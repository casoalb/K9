/* Channel-handling routines.
**
** Chatnet K9 Channel Services
** Based on ircdservices ver. by Andy Church
** Chatnet modifications (c) 2001-2002
**
** E-mail: routing@lists.chatnet.org
** Authors:
**
**      Vampire (vampire@alias.chatnet.org)
**      Thread  (thread@alias.chatnet.org)
**      MRX     (tom@rooted.net)
**      sloth   (sloth@nopninjas.com)
**
**      *** DO NOT DISTRIBUTE ***
**/   

#include "services.h"

/*************************************************************************/

#define HASH(chan)  ((chan)[1] ? ((chan)[1]&31)<<5 | ((chan)[2]&31) : 0)
#define HASHSIZE    1024
static Channel *chanlist[HASHSIZE];
/*************************************************************************/
/*************************************************************************/

/* Return the Channel structure corresponding to the named channel, or NULL
 * if the channel was not found.  chan is assumed to be non-NULL and valid
 * (i.e. pointing to a channel name of 1 or more characters). */

Channel *findchan(const char *chan)
{
    Channel *c;

    if (debug >= 3)
	log("debug: findchan(%p)", chan);
    c = chanlist[HASH(chan)];
    while (c) {
	if (irc_stricmp(c->name, chan) == 0)
	    return c;
	c = c->next;
    }
    if (debug >= 3)
	log("debug: findchan(%s) -> %p", chan, c);
    return NULL;
}

/*************************************************************************/

/* Iterate over all channels in the channel list.  Return NULL at end of
 * list.
 */

static Channel *current;
static int next_index;

Channel *firstchan(void)
{
    next_index = 0;
    while (next_index < HASHSIZE && current == NULL)
	current = chanlist[next_index++];
    if (debug >= 3)
	log("debug: firstchan() returning %s",
			current ? current->name : "NULL (end of list)");
    return current;
}

Channel *nextchan(void)
{
    if (current)
	current = current->next;
    if (!current && next_index < HASHSIZE) {
	while (next_index < HASHSIZE && current == NULL)
	    current = chanlist[next_index++];
    }
    if (debug >= 3)
	log("debug: nextchan() returning %s",
			current ? current->name : "NULL (end of list)");
    return current;
}

/*************************************************************************/

/* Return statistics.  Pointers are assumed to be valid. */

void get_channel_stats(long *nrec, long *memuse)
{
    long count = 0, mem = 0;
    Channel *chan;
    struct c_userlist *cu;
    int i;

    for (chan = firstchan(); chan; chan = nextchan()) {
	count++;
	mem += sizeof(*chan);
	if (chan->topic)
	    mem += strlen(chan->topic)+1;
	if (chan->key)
	    mem += strlen(chan->key)+1;
	mem += sizeof(char *) * chan->bansize;
	for (i = 0; i < chan->bancount; i++) {
	    if (chan->bans[i])
		mem += strlen(chan->bans[i])+1;
	}
	for (cu = chan->users; cu; cu = cu->next)
	    mem += sizeof(*cu);
    }
    *nrec = count;
    *memuse = mem;
}

/*************************************************************************/

#ifdef DEBUG_COMMANDS

/* Send the current list of channels to the named user. */

void send_channel_list(User *user)
{
    Channel *c;
    char lim[16], buf[512], *end;
    struct c_userlist *u;
    const char *source = user->nick;

    for (c = firstchan(); c; c = nextchan()) {
	snprintf(lim, sizeof(lim), " %d", c->limit);
	notice(s_OperServ, source, "%s %lu +%s%s%s%s%s %s",
	       c->name, c->creation_time,
	       mode_flags_to_string(c->mode & ~CMODE_k, MODE_CHANNEL),
	       c->key   ? "k"      : "",
	       c->limit ? lim      : "",
	       c->key   ? " "      : "",
	       c->key   ? c->key   : "",
	       c->topic ? c->topic : "");
	end = buf;
	end += snprintf(end, sizeof(buf)-(end-buf), "%s", c->name);
	for (u = c->users; u; u = u->next) {
	    end += snprintf(end, sizeof(buf)-(end-buf), " +%s/%s",
			    mode_flags_to_string(u->mode,MODE_CHANUSER),
			    u->user->nick);
	}
	notice(s_OperServ, source, buf);
    }
}


/* Send list of users on a single channel, taken from strtok(). */

void send_channel_users(User *user)
{
    char *chan = strtok(NULL, " ");
    Channel *c = chan ? findchan(chan) : NULL;
    struct c_userlist *u;
    const char *source = user->nick;

    if (!c) {
	notice(s_OperServ, source, "Channel %s not found!",
		chan ? chan : "(null)");
	return;
    }
    notice(s_OperServ, source, "Channel %s users:", chan);
    for (u = c->users; u; u = u->next)
	notice(s_OperServ, source, "%x/%s", u->mode, u->user->nick);
}

#endif	/* DEBUG_COMMANDS */

/*************************************************************************/
/*************************************************************************/

/* Add/remove a user to/from a channel, creating or deleting the channel as
 * necessary.  If creating the channel, restore mode lock and topic as
 * necessary.  Also check for auto-opping and auto-voicing.  If a mode is
 * given, it is assumed to have been set by the remote server.
 * Returns the Channel structure for the given channel.
 */

Channel *chan_adduser(User *user, const char *chan, int32 modes)
{
    Channel *c = findchan(chan);
    Channel **list;
    int newchan = !c;
    struct c_userlist *u;

    if (newchan) {
	if (debug)
	    log("debug: Creating channel %s", chan);
	/* Allocate pre-cleared memory */
	c = scalloc(sizeof(Channel), 1);
	strscpy(c->name, chan, sizeof(c->name));
	list = &chanlist[HASH(c->name)];
	c->next = *list;
	if (*list)
	    (*list)->prev = c;
	*list = c;
	c->creation_time = time(NULL);
	/* Store ChannelInfo pointer in channel record */
	c->ci = cs_findchan(chan);
	if (c->ci) {
	    /* Store return pointer in ChannelInfo record */
	    c->ci->c = c;
	}
	/* Restore locked modes and saved topic */
	check_modes(chan);
	restore_topic(c);
    }
    u = smalloc(sizeof(struct c_userlist));
    u->next = c->users;
    u->prev = NULL;
    if (c->users)
	c->users->prev = u;
    c->users = u;
    u->user = user;
    u->mode = check_chan_user_modes(NULL, user, chan, modes);

    return c;
}


void chan_deluser(User *user, Channel *c)
{
    struct c_userlist *u;
    int i;

    if (debug >= 2)
	log("debug: chan_deluser() called...");

    for (u = c->users; u && u->user != user; u = u->next)
	;
    if (!u || !c) {
	log("channel: BUG(?) chan_deluser() called for %s in %s but they "
	    "were not found on the channel's userlist.",
	    user->nick, (c) ? c->name : "NONE!");
	return;
    }

    if (u->next)
	u->next->prev = u->prev;
    if (u->prev)
	u->prev->next = u->next;
    else
	c->users = u->next;
    free(u);

    if (!c->users) {
	if (debug)
	    log("debug: Deleting channel %s", c->name);
	if (c->ci)
	    c->ci->c = NULL;
	if (c->topic)
	    free(c->topic);
	if (c->key)
	    free(c->key);
	for (i = 0; i < c->bancount; ++i) {
	    if (c->bans[i])
		free(c->bans[i]);
	    else
		log("channel: BUG freeing %s: bans[%d] is NULL!", c->name, i);
	}
	if (c->bansize)
	    free(c->bans);
#ifdef HAVE_BANEXCEPT
	for (i = 0; i < c->exceptcount; ++i) {
	    if (c->excepts[i])
		free(c->excepts[i]);
	    else
		log("channel: BUG freeing %s: excepts[%d] is NULL!", c->name, i);
	}
	if (c->exceptsize)
	    free(c->excepts);
#endif
	if (c->next)
	    c->next->prev = c->prev;
	if (c->prev)
	    c->prev->next = c->next;
	else
	    chanlist[HASH(c->name)] = c->next;
	free(c);
    }
    if (debug >= 2)
	log("debug: chan_deluser() complete.");
}

/*************************************************************************/

/* Search for the given ban (case-insensitive) on the channel; return 1 if
 * it exists, 0 if not.
 */

int chan_has_ban(const char *chan, const char *ban)
{
    Channel *c;
    int i;

    if (!ban || !chan)
        return 0;
        
    c = findchan(chan);
    if (!c)
	return 0;
    for (i = 0; i < c->bancount; i++)
	if (irc_stricmp(c->bans[i], ban) == 0)
	    return 1;
    return 0;
}

/*************************************************************************/
/* Add a ban to the given channel; return 1 on success, 0 if already there,
 * or -1 error/otherwise (should not happen) 
 */
int chan_add_ban(const char *chan, const char *ban)
{
	Channel *c;
	char *av[3];

	c = findchan(chan);
	if (!c)
		return 0;

	if (chan_has_ban(c->name, ban) == 0)
	{
		av[0] = c->name;
		av[1] = "+b";
		av[2] = sstrdup(ban);
		send_cmode(MODE_SENDER(s_ChanServ), av[0], av[1], av[2]);
		do_cmode(s_ChanServ, 3, av);
		free(av[2]);
		return 1;
	} else {
		return 0;
	}
	return -1;
}

/*************************************************************************/
/* Removes a ban to the given channel; return 1 on success, 0 if already there,
 * or -1 error/otherwise (should not happen) 
 */
int chan_rem_ban(const char *chan, const char *ban)
{
	Channel *c;
	char *av[3];

	c = findchan(chan);
	if (!c)
		return 0;

	if (chan_has_ban(c->name, ban) == 1)
	{
		av[0] = c->name;
		av[1] = "-b";
		av[2] = sstrdup(ban);
		send_cmode(MODE_SENDER(s_ChanServ), av[0], av[1], av[2]);
		do_cmode(s_ChanServ, 3, av);
		free(av[2]);
		return 1;
	} else {
		return 0;
	}
	return -1;
}


/*************************************************************************/

/* Handle a channel MODE command.
 * When called internally to modify channel modes, callers may assume that
 * the contents of the argument strings will not be modified.
 */

static void do_cumode(const char *source, Channel *chan, int32 flag, int add,
		      const char *nick);

void do_cmode(const char *source, int ac, char **av)
{
    Channel *chan;
    char *s;
    int add = 1;		/* 1 if adding modes, 0 if deleting */
    char *modestr = av[1];

    if (ac < 2) {
      if (debug) 
        log("debug: error in do_cmode(), ac = %d", ac);
      return;
    }

    chan = findchan(av[0]);
    if (!chan)
    {
	log("channel: MODE %s for nonexistent channel %s", merge_args(ac-1, av+1), av[0]);
	return;
    }

    if (!NoBouncyModes) {
	/* Count identical server mode changes per second (mode bounce check) */
	/* Doesn't trigger on +/-[bov] */
	if (strchr(source, '.') && strcmp(source, ServerName) != 0
#ifdef IRC_UNREAL  /* FIXME: should check HAVE_HALFOP etc. */
	 && !modestr[strcspn(modestr, "beovhaq")]
#else
	 && !modestr[strcspn(modestr, "bov")]
#endif
	) {
	    static char lastmodes[40];	/* 31 modes + leeway */
	    if (time(NULL) != chan->server_modetime
	     || strcmp(modestr, lastmodes) != 0
	    ) {
		chan->server_modecount = 0;
		chan->server_modetime = time(NULL);
		strscpy(lastmodes, modestr, sizeof(lastmodes));
	    }
	    chan->server_modecount++;
	}
    }

    s = modestr;
    ac -= 2;
    av += 2;

    while (*s) {
	char modechar = *s++;

	switch (modechar) {

	  case '+':
	    add = 1; break;

	  case '-':
	    add = 0; break;

	  case 'k':
	    if (--ac < 0) {
		log("channel: MODE %s %s: missing parameter for %ck",
					chan->name, modestr, add ? '+' : '-');
		break;
	    }
	    if (chan->key) {
		free(chan->key);
		chan->key = NULL;
	    }
	    if (add)
		chan->key = sstrdup(*av++);
	    break;

	  case 'l':
	    if (add) {
		if (--ac < 0) {
		    log("channel: MODE %s %s: missing parameter for +l",
							chan->name, modestr);
		    break;
		}
		chan->limit = atoi(*av++);
	    } else {
		chan->limit = 0;
	    }
	    break;

	  case 'b': 	  	  
	    if (--ac < 0) {
		log("channel: MODE %s %s: missing parameter for %cb",
					chan->name, modestr, add ? '+' : '-');			
		break;
	    }
	    if (add) {
	        char *st;
	        
	        st = sstrdup(*av++);
	        
	    	if (chan->bancount >= chan->bansize) 
	    	{
		    chan->bansize += 8;
		    chan->bans = srealloc(chan->bans, sizeof(char *) * chan->bansize);
		}

		chan->bans[chan->bancount++] = st;

	    } else {
		char **s = chan->bans;
		int i = 0;
		while (i < chan->bancount && strcmp(*s, *av) != 0) {
		    i++;
		    s++;
		}
		if (i < chan->bancount) {
		    chan->bancount--;
		    if (i < chan->bancount)
			memmove(s, s+1, sizeof(char *) * (chan->bancount-i));
		} else {
		    log("channel: MODE %s -b %s: ban not found",
			chan->name, *av);
		}
		av++;
	    }
	    break;

#ifdef HAVE_BANEXCEPT
	  case 'e':
	    if (--ac < 0) {
		log("channel: MODE %s %s: missing parameter for %ce",
					chan->name, modestr, add ? '+' : '-');
		break;
	    }
	    if (add) {
		if (chan->exceptcount >= chan->exceptsize) {
		    chan->exceptsize += 8;
		    chan->excepts = srealloc(chan->excepts,
					sizeof(char *) * chan->exceptsize);
		}
		chan->excepts[chan->exceptcount++] = sstrdup(*av++);
	    } else {
		char **s = chan->excepts;
		int i = 0;
		while (i < chan->exceptcount && strcmp(*s, *av) != 0) {
		    i++;
		    s++;
		}
		if (i < chan->exceptcount) {
		    chan->exceptcount--;
		    if (i < chan->exceptcount)
			memmove(s, s+1, sizeof(char *)*(chan->exceptcount-i));
		} else {
		    log("channel: MODE %s -e %s: exception not found",
			chan->name, *av);
		}
		av++;
	    }
	    break;
#endif

	  default: {
	    int32 flag;

	    /* Check for it as a channel user mode */
	    flag = mode_char_to_flag(modechar, MODE_CHANUSER);
	    if (flag) {
		if (--ac < 0) {
		    log("channel: MODE %s %s: missing parameter for %c%c",
			chan->name, modestr, add ? '+' : '-', modechar);
		    break;
		}

		do_cumode(source, chan, flag, add, *av++);

		break;
	    }

	    /* Nope, must be a regular channel mode */
	    flag = mode_char_to_flag(modechar, MODE_CHANNEL);
	    /* No need to check for failure -- return value 0 in that case */
	    if (add)
		chan->mode |= flag;
	    else
		chan->mode &= ~flag;
	    break;
	  } /* default case */
	} /* switch */

    } /* while (*s) */

    /* Check modes against ChanServ mode lock */
    check_modes(chan->name);
}

/* Modify a user's CUMODE. */
static void do_cumode(const char *source, Channel *chan, int32 flag, int add,
		      const char *nick)
{
	struct c_userlist *u;
	User *user;

	user = finduser(nick);
	if (!user)
	{
		if ( irc_stricmp(nick, s_ChanServ) == 0 )
			return;
	
		log("channel: MODE %s %c%c for nonexistent user %s", chan->name, add ? '+' : '-',
			mode_flag_to_char(flag, MODE_CHANUSER), nick);
		return;
	}
	for (u = chan->users; u; u = u->next)
	{
		if (u->user == user)
			break;
	}
	if (!u)
	{
		log("channel: MODE %s %c%c for user %s not on channel",
			chan->name, 
			add ? '+' : '-',
			mode_flag_to_char(flag, MODE_CHANUSER), 
			nick
		);
		return;
	}

	if (add)
		u->mode |= flag;
	else
		u->mode &= ~flag;
	u->mode = check_chan_user_modes(source, u->user, chan->name, u->mode);
}

/*************************************************************************/

/* Handle a TOPIC command. */

void do_topic(const char *source, int ac, char **av)
{
    Channel *c = findchan(av[0]);

    if (!c) {
	log("channel: TOPIC %s for nonexistent channel %s",
						merge_args(ac-1, av+1), av[0]);
	return;
    }
    c->topic_time = atol(av[2]);  /* check_topiclock() may need this */
    if (check_topiclock(av[0]))
	return;
    strscpy(c->topic_setter, av[1], sizeof(c->topic_setter));
    if (c->topic) {
	free(c->topic);
	c->topic = NULL;
    }
    if (ac > 3 && *av[3])
	c->topic = sstrdup(av[3]);
    record_topic(c);
}

/*************************************************************************/
