/* Routines to maintain a list of online users.
**
** Based on ircdservices ver. by Andy Church
** Chatnet modifications (c) 2001-2002
**
** E-mail: routing@lists.chatnet.org
** Authors:
**
**      Vampire (vampire@alias.chatnet.org)
**      Thread  (thread@alias.chatnet.org)
**      MRX     (tom@rooted.net)
**
**      *** DO NOT DISTRIBUTE ***
**/        
	  
#include "services.h"

#define HASH(nick)  (((nick)[0]&31)<<5 | ((nick)[1]&31))

#define HASHSIZE    1024
#define LINEBUFFSIZE 512
#define MSG_TYPE_STD 0
#define MSG_TYPE_ACT 1
#define MSG_TYPE_SND 2

static User *userlist[HASHSIZE];
void send_comment(User *from, char *channel);

int32 usercnt = 0, opcnt = 0, maxusercnt = 0;
time_t maxusertime;

/*************************************************************************/
/************************* User list management **************************/
/*************************************************************************/

/* Allocate a new User structure, fill in basic values, link it to the
 * overall list, and return it.  Always successful.
 */

User *new_user(const char *nick)
{
    User *user, **list;

    user = scalloc(sizeof(User), 1);
    if (!nick)
	nick = "";
    strscpy(user->nick, nick, NICKMAX);
    list = &userlist[HASH(user->nick)];
    user->next = *list;
    if (*list)
	(*list)->prev = user;
    *list = user;
    user->real_ni = findnick(nick);
    if (user->real_ni)
	user->ni = getlink(user->real_ni);
    else
	user->ni = NULL;
    usercnt++;
    if (usercnt > maxusercnt) {
	maxusercnt = usercnt;
	maxusertime = time(NULL);
	if (LogMaxUsers)
	    log("user: New maximum user count: %d", maxusercnt);
    }
    return user;
}

/*************************************************************************/

/* Change the nickname of a user, and move pointers as necessary. */

static void change_user_nick(User *user, const char *nick)
{
    User **list;

    if (user->prev)
	user->prev->next = user->next;
    else
	userlist[HASH(user->nick)] = user->next;
    if (user->next)
	user->next->prev = user->prev;
    user->nick[1] = 0;	/* paranoia for zero-length nicks */
    strscpy(user->nick, nick, NICKMAX);
    list = &userlist[HASH(user->nick)];
    user->next = *list;
    user->prev = NULL;
    if (*list)
	(*list)->prev = user;
    *list = user;
    user->real_ni = findnick(nick);
    if (user->real_ni)
	user->ni = getlink(user->real_ni);
    else
	user->ni = NULL;
}

/*************************************************************************/

/* Remove and free a User structure. */

static void delete_user(User *user)
{
    struct u_chanlist *c, *c2;
    struct u_chaninfolist *ci, *ci2;

    if (debug >= 2)
	log("debug: delete_user() called");

    usercnt--;
    if (is_oper_u(user))
	opcnt--;
#ifdef STATISTICS
    stats_do_quit(user);
#endif

    cancel_user(user);
    if (debug >= 2)
	log("debug: delete_user(): free user data");
    free(user->username);
    free(user->host);
    free(user->realname);
#ifdef IRC_UNREAL
    if (user->fakehost)
	free(user->fakehost);
#endif
    if (debug >= 2)
	log("debug: delete_user(): remove from channels");
    c = user->chans;
    while (c && c->chan) {
	c2 = c->next;
	chan_deluser(user, c->chan);
	free(c);
	c = c2;
    }
    if (debug >= 2)
	log("debug: delete_user(): free founder data");
    ci = user->founder_chans;
    while (ci) {
	ci2 = ci->next;
	free(ci);
	ci = ci2;
    }
    if (debug >= 2)
	log("debug: delete_user(): delete from list");
    if (user->prev)
    {
        if (user->next)
        {
            user->prev->next = user->next;
            user->next->prev = user->prev;
        }
        else
        {
            user->prev->next = NULL;
        }
    }
    else if (user->next)
    {
        userlist[HASH(user->nick)] = user->next;
        user->next->prev = NULL;
    }
    else
    {
        userlist[HASH(user->nick)] = NULL;
    }

    if (debug >= 2)
	log("debug: delete_user(): free user structure");
    free(user);
    if (debug >= 2)
	log("debug: delete_user() done");
}

/*************************************************************************/

/* Find a user by nick.  Return NULL if user could not be found. */

User *finduser(const char *nick)
{
    User *user;

    if (debug >= 3)
	log("debug: finduser(%p)", nick);
    user = userlist[HASH(nick)];
    while (user && irc_stricmp(user->nick, nick) != 0)
	user = user->next;
    if (debug >= 3)
	log("debug: finduser(%s) -> %p", nick, user);
    return user;
}

/*************************************************************************/

/* Iterate over all users in the user list.  Return NULL at end of list. */

static User *current;
static int next_index;

User *firstuser(void)
{
    next_index = 0;
    while (next_index < HASHSIZE && current == NULL)
	current = userlist[next_index++];
    if (debug >= 3)
	log("debug: firstuser() returning %s",
			current ? current->nick : "NULL (end of list)");
    return current;
}

User *nextuser(void)
{
    if (current)
	current = current->next;
    if (!current && next_index < HASHSIZE) {
	while (next_index < HASHSIZE && current == NULL)
	    current = userlist[next_index++];
    }
    if (debug >= 3)
	log("debug: nextuser() returning %s",
			current ? current->nick : "NULL (end of list)");
    return current;
}

/*************************************************************************/
/*************************************************************************/

/* Return statistics.  Pointers are assumed to be valid. */

void get_user_stats(long *nusers, long *memuse)
{
    long count = 0, mem = 0;
    User *user;
    struct u_chanlist *uc;
    struct u_chaninfolist *uci;

    for (user = firstuser(); user; user = nextuser()) {
	count++;
	mem += sizeof(*user);
	if (user->username)
	    mem += strlen(user->username)+1;
	if (user->host)
	    mem += strlen(user->host)+1;
	if (user->realname)
	    mem += strlen(user->realname)+1;
	for (uc = user->chans; uc; uc = uc->next)
	    mem += sizeof(*uc);
	for (uci = user->founder_chans; uci; uci = uci->next)
	    mem += sizeof(*uci);
    }
    *nusers = count;
    *memuse = mem;
}

/*************************************************************************/

#ifdef DEBUG_COMMANDS

/* Send the current list of users to the given user. */

void send_user_list(User *user)
{
    User *u;
    const char *source = user->nick;

    for (u = firstuser(); u; u = nextuser())
    {
	char buf[5];
	if (u->real_ni)
        {
	    snprintf(buf, sizeof(buf), "%04X", u->real_ni->status & 0xFFFF);
        }
	else
        {
	    strcpy(buf, "-");
        }
    }
}


/* Send information about a single user to the given user.  Nick is taken
 * from strtok(). */

void send_user_info(User *user)
{
    char *nick = strtok(NULL, " ");
    User *u = nick ? finduser(nick) : NULL;
    char buf[BUFSIZE], *s;
    struct u_chanlist *c;
    struct u_chaninfolist *ci;
    const char *source = user->nick;

    if (!u) {
	return;
    }
    if (u->real_ni)
	snprintf(buf, sizeof(buf), "%04X", u->real_ni->status & 0xFFFF);
    else
	strcpy(buf, "-");
    buf[0] = 0;
    s = buf;
    for (c = u->chans; c; c = c->next)
	s += snprintf(s, sizeof(buf)-(s-buf), " %s", c->chan->name);
    buf[0] = 0;
    s = buf;
    for (ci = u->founder_chans; ci; ci = ci->next)
	s += snprintf(s, sizeof(buf)-(s-buf), " %s", ci->chan->name);
}

#endif	/* DEBUG_COMMANDS */

/*************************************************************************/
/************************* Internal routines *****************************/
/*************************************************************************/

/* Remove a user and update nickname info as needed on QUIT/KILL. */

static void quit_user(User *user, const char *quitmsg)
{
    NickInfo *ni;

    if ((ni = user->real_ni) != NULL) {
	/* Services root privilege paranoia */
	ni->status &= ~NS_SERVROOT;
	if (!(ni->status & NS_VERBOTEN) &&
			(ni->status & (NS_IDENTIFIED | NS_RECOGNIZED))) {
	    ni->last_seen = time(NULL);
	    if (ni->last_quit)
		free(ni->last_quit);
	    ni->last_quit = *quitmsg ? sstrdup(quitmsg) : NULL;
	}
    }
#ifndef STREAMLINED
#endif
    delete_user(user);
}

/*************************************************************************/
/************************* Message handlers ******************************/
/*************************************************************************/

/* Handle a server NICK command.  Note that we do some parameter swapping
 * in messages.c/m_nick() to simplify life here.
 *	av[0] = nick
 *	If a new user:
 *		av[1] = hop count
 *		av[2] = signon time
 *		av[3] = username
 *		av[4] = hostname
 *		av[5] = user's server
 *		av[6] = user's real name
 *	    For DAL4_4_15 only:
 *		av[7] = Services stamp (set with mode +d; 0 == no stamp)
 *	    For UNREAL only:
 *		av[8] = "fake" hostname (to be shown to users)
 *	Else:
 *		av[1] = time of change
 * Return 1 if message was accepted, 0 if rejected (AKILL/session limit).
 */

int do_nick(const char *source, int ac, char **av)
{
    User *user;
    NickInfo *new_ni;	/* New master nick */
    int ni_changed = 1;	/* Did master nick change? */

    if (!*source) {
	/* This is a new user; create a User structure for it. */
#ifdef IRC_DAL4_4_15
	/* Unreal (and other ircds in this class?) upper-bound values at
	 * 2^31-1, so we limit ourselves to 31 bits even though our field
	 * (and the field in ircd/include/struct.h) is unsigned... */
	static int32 servstamp = 0;
	int i;
#endif

	if (debug)
	    log("debug: new user: %s", av[0]);

	/* We used to ignore the ~ which a lot of ircd's use to indicate no
	 * identd response.  That caused channel bans to break, so now we
	 * just take what the server gives us.  People are still encouraged
	 * to read the RFCs and stop doing anything to usernames depending
	 * on the result of an identd lookup.
	 */

	/* First check for AKILLs and session limits. */
#ifndef STREAMLINED
#endif /* !STREAMLINED */

	/* User was accepted; allocate User structure and fill it in. */
	user = new_user(av[0]);
	user->signon = atol(av[2]);
	user->username = sstrdup(av[3]);
	user->host = sstrdup(av[4]);
	user->server = findserver(av[5]);
	user->realname = sstrdup(av[6]);
	user->my_signon = time(NULL);
#ifdef IRC_UNREAL
	user->fakehost = strdup(av[8]);
#endif
#ifdef IRC_DAL4_4_15
	i = atoi(av[7]);
	if (i) {
	    user->services_stamp = i;
	} else {
	    if (servstamp == 0) {
		servstamp = rand() & 0x7FFFFFFF;
		if (servstamp == 0)
		    servstamp++;
	    }
	    user->services_stamp = servstamp++;
	    if (servstamp <= 0)
		servstamp = 1;
	    send_cmd(ServerName, "SVSMODE %s +d %u", user->nick,
		     user->services_stamp);
	}
#else /* !IRC_DAL4_4_15 */
	/* Under other servers, we just use signon (i.e. what the remote
	 * server gave us). */
	user->services_stamp = user->signon;
#endif /* IRC_DAL4_4_15 */

#ifndef STREAMLINED
#endif

#ifdef STATISTICS
	if (user->server)
	    user->server->stats->usercnt++;
#endif

    } else {
	/* An old user changing nicks. */

	user = finduser(source);
	if (!user) {
	    log("user: NICK from nonexistent nick %s: %s", source,
							merge_args(ac, av));
	    return 0;
	}
	if (debug)
	    log("debug: %s changes nick to %s", source, av[0]);

	/* Be extra careful with Services root privileges; validate_user()
	 * will clear all NS_TEMPORARY flags the next time someone uses
	 * the nick, but just in case... */
	if (user->real_ni)
	    user->real_ni->status &= ~NS_SERVROOT;

	/* Changing nickname case isn't a real change.  Only update
	 * my_signon if the nicks aren't the same, case-insensitively. */
	if (irc_stricmp(av[0], user->nick) != 0)
	    user->my_signon = time(NULL);

	new_ni = findnick(av[0]);
	if (new_ni)
	    new_ni = getlink(new_ni);
	if (new_ni != user->ni) {
	    cancel_user(user);
	} else if (new_ni) {
	    if (!user->real_ni) {
		log("user: do_nick BUG: user->ni set but real_ni not set!");
	    } else if (user->real_ni->status & (NS_IDENTIFIED|NS_RECOGNIZED)) {
		ni_changed = 0;
	    } else {
		cancel_user(user);
	    }
	}
	change_user_nick(user, av[0]);
    }

    if (ni_changed) {
	if (validate_user(user))
	    check_on_access(user);
    } else {
	/* Make sure NS_ON_ACCESS flag gets set for current nick */
	check_on_access(user);
    }
    if (UMODE_REG) {
	if (nick_identified(user)) {
	    send_cmd(s_NickServ, "SVSMODE %s :+%s", av[0],
		     mode_flags_to_string(UMODE_REG, MODE_USER));
	    user->mode |= UMODE_REG;
	} else if (user->mode & UMODE_REG) {
# ifndef IRC_BAHAMUT  /* Bahamut removes the "+r" usermode automatically */
	    send_cmd(s_NickServ, "SVSMODE %s :-%s", av[0],
		     mode_flags_to_string(UMODE_REG, MODE_USER));
# endif
	    user->mode &= ~UMODE_REG;
	}
    }

    return 1;
}

/*************************************************************************/

/* Handle a JOIN command.
 *	av[0] = channels to join
 */

void do_join(const char *source, int ac, char **av)
{
	User *user;
	char *s, *t;
	struct u_chanlist *uc, *nextuc;
	Channel *c;
	ChannelInfo *ci;
	int i;

	user = finduser(source);
	if (!user)
	{
		log("user: JOIN from nonexistent user %s: %s", source, merge_args(ac, av));
		return;
	} else {
		log("user: JOIN user %s: %s", source, merge_args(ac, av));
	}

	t = av[0];
	while (*(s=t))
	{
		t = s + strcspn(s, ",");
		if (*t)
			*t++ = 0;
		if (debug)
			log("debug: %s joins %s", source, s);

		if (*s == '0')
		{
			uc = user->chans;
			while (uc)
			{
				nextuc = uc->next;
				chan_deluser(user, uc->chan);
				free(uc);
				uc = nextuc;
			}
			user->chans = NULL;
			continue;
		}

		/* Make sure check_kick comes before chan_adduser, so banned users
		 * don't get to see things like channel keys. */

		if (check_kick(user, s))
			continue;	    	 
		c = chan_adduser(user, s, 0);
		if ( (ci = cs_findchan(s)) && (ci->flags & CI_INCHANNEL) && (ci->entrycount > 0) )
		{
			for (i = 0; i <= ci->entrycount; i++)
				if (ci->entrymsg[i])
					notice(s_ChanServ, user->nick, "%s", ci->entrymsg[i]);
		}
		uc = smalloc(sizeof(*c));
		uc->next = user->chans;
		uc->prev = NULL;
		if (user->chans)
			user->chans->prev = uc;
		user->chans = uc;
		uc->chan = c;
	}
}

/*************************************************************************/

#if defined(IRC_BAHAMUT) || defined(IRC_UNREAL)

/* Handle an SJOIN command.
 * Bahamut no-SSJOIN format:
 *	av[0] = TS3 timestamp
 *	av[1] = TS3 timestamp - channel creation time
 *	av[2] = channel
 *	av[3] = channel modes
 *	av[4] = limit / key (depends on modes in av[3])
 *	av[5] = limit / key (depends on modes in av[3])
 *	av[ac-1] = nickname(s), with modes, joining channel
 * Bahamut SSJOIN format (server source) / Unreal SJOIN2 format:
 *	av[0] = TS3 timestamp - channel creation time
 *	av[1] = channel
 *	av[2] = modes (limit/key in av[3]/av[4] as needed)
 *	av[ac-1] = users
 *      (Note that Unreal may omit the modes if there aren't any.)
 * Bahamut SSJOIN format (client source):
 *	av[0] = TS3 timestamp - channel creation time
 *	av[1] = channel
 */

void do_sjoin(const char *source, int ac, char **av)
{
    User *user;
    char *t, *nick;
    char *channel;
    struct u_chanlist *uc;
    Channel *c = NULL;
    ChannelInfo *ci = NULL;
    int joins = 0;	/* Number of users that actually joined (after akick)*/
    int i;

    if (isdigit(av[1][0])) {
	/* Plain SJOIN format, zap join timestamp */
	memmove(&av[0], &av[1], sizeof(char *) * (ac-1));
	ac--;
    }

    channel = av[1];
    if (ac >= 3) {
	/* SJOIN from server: nick list in last param */
	t = av[ac-1];
    } else {
	/* SJOIN for a single client: source is nick */
	/* We assume the nick has no spaces, so we can discard const */
	t = (char *)source;
    }
    while (*(nick=t)) {
	int32 modes = 0, thismode;

        t = nick + strcspn(nick, " ");
	if (*t)
	    *t++ = 0;
#ifdef IRC_UNREAL
	if (*nick == '&' || *nick == '"') {
	    /* Ban (&) or exception (") */
	    char *av[3];
	    av[0] = channel;
	    av[1] = (*nick=='&') ? "+b" : "+e";
	    av[2] = nick+1;
	    do_cmode(source, 3, av);
	    continue;
	}
#endif
	do {
	    thismode = cumode_prefix_to_flag(*nick);
	    modes |= thismode;
	} while (thismode && nick++); /* increment nick only if thismode!=0 */
	user = finduser(nick);
	if (!user) {
	    log("channel: SJOIN to channel %s for non-existent nick %s (%s)",
		channel, nick, merge_args(ac-1, av));
	    continue;
	}

	if (debug)
	    log("debug: %s SJOINs %s", nick, channel);
	if ( check_kick(user, channel) )
		continue;

	if (debug)
		log("debug: SJOIN check_kick complete");

	c = chan_adduser(user, channel, modes);
	joins++;
        if ((ci || (ci = cs_findchan(channel))) && ci->entrycount)
        {
            for (i = 0; i < ci->entrycount; i++)
            notice(s_ChanServ, user->nick, "%s", ci->entrymsg[i]);
        }
	if ( (ci = cs_findchan(channel)) && (ci->flags & CI_INCHANNEL) )
	{
		if ( nick_identified(user) )
			send_comment(user,channel);
	}
	
	uc = smalloc(sizeof(*uc));
	uc->next = user->chans;
	uc->prev = NULL;
	if (user->chans)
	    user->chans->prev = uc;
	user->chans = uc;
	uc->chan = c;
    }

    /* Did anyone actually join the channel? */
    if (c)
    {
	/* Store channel timestamp in channel structure. */
	c->creation_time = strtol(av[0], NULL, 10);
	/* Set channel modes if there are any.  Note how argument list is
	 * conveniently set up for do_cmode(). */
	if (ac > 3)
	    do_cmode(source, ac-2, av+1);
    }
	if (debug)
		log("debug: do_sjoin done");
}

#endif /* IRC_BAHAMUT */

/*************************************************************************/

/* Handle a PART command.
 *	av[0] = channels to leave
 *	av[1] = reason (optional)
 */

void do_part(const char *source, int ac, char **av)
{
    User *user;
    char *s, *t;
    struct u_chanlist *c;

    user = finduser(source);
    if (!user) {
	log("user: PART from nonexistent user %s: %s", source,
							merge_args(ac, av));
	return;
    }
    t = av[0];
    while (*(s=t)) {
	t = s + strcspn(s, ",");
	if (*t)
	    *t++ = 0;
	if (debug)
	    log("debug: %s leaves %s", source, s);
	for (c = user->chans; c && stricmp(s, c->chan->name) != 0; c = c->next)
	    ;
	if (c) {
	    chan_deluser(user, c->chan);
	    if (c->next)
		c->next->prev = c->prev;
	    if (c->prev)
		c->prev->next = c->next;
	    else
		user->chans = c->next;
	    free(c);
	}
    }
}

/*************************************************************************/

/* Handle a KICK command.
 *	av[0] = channel
 *	av[1] = nick(s) being kicked
 *	av[2] = reason
 * When called internally to remove a single user (no "," in av[1]) from a
 * channel, callers may assume that the contents of the argument strings
 * will not be modified.
 */

void do_kick(const char *source, int ac, char **av)
{
    User *user;
    char *s, *t;
    struct u_chanlist *c;

    t = av[1];
    while (*(s=t)) {
	t = s + strcspn(s, ",");
	if (*t)
	    *t++ = 0;
	user = finduser(s);
	if (!user) {
	    log("user: KICK for nonexistent user %s on %s: %s", s, av[0],
						merge_args(ac-2, av+2));
	    continue;
	}
	if (debug)
	    log("debug: kicking %s from %s", s, av[0]);
	for (c = user->chans; c && stricmp(av[0], c->chan->name) != 0;
								c = c->next)
	    ;
	if (c) {
	    chan_deluser(user, c->chan);
	    if (c->next)
		c->next->prev = c->prev;
	    if (c->prev)
		c->prev->next = c->next;
	    else
		user->chans = c->next;
	    free(c);
	}
    }
}

/*************************************************************************/

/* Handle a MODE command for a user.
 *	av[0] = nick to change mode for
 *	av[1] = modes
 */

void do_umode(const char *source, int ac, char **av)
{
    User *user;
    char *s;
    int add = 1;		/* 1 if adding modes, 0 if deleting */

    if (stricmp(source, av[0]) != 0 && strchr(source, '.') == NULL) {
	log("user: MODE %s %s from different nick %s!", av[0], av[1], source);
	wallops(NULL, "%s attempted to change mode %s for %s",
		source, av[1], av[0]);
	return;
    }
    user = finduser(av[0]);
    if (!user) {
	log("user: MODE %s for nonexistent nick %s: %s", av[1], av[0],
	    merge_args(ac, av));
	return;
    }
#ifdef IRC_DAL4_4_15
    if (strchr(av[1], 'd') && ac > 2) {
	log("user: MODE tried to change services stamp: %s",
	    merge_args(ac, av));
	send_cmd(s_NickServ, "SVSMODE %s +d %u", av[0], user->services_stamp);
    }
#endif
    if (debug)
	log("debug: Changing mode for %s to %s", av[0], av[1]);
    s = av[1];
    while (*s) {
	char modechar = *s++;
	switch (modechar) {
	  case '+': add = 1; break;
	  case '-': add = 0; break;

#ifdef IRC_DAL4_4_15
	  case 'r':
	    if (nick_identified(user)) {
		if (!add)
		    send_cmd(s_NickServ, "SVSMODE %s :+r", av[0]);
	    } else {
		if (add)
		    send_cmd(s_NickServ, "SVSMODE %s :-r", av[0]);
	    }
	    break;

	  case 'a':
	    if (is_cservice_head(user)) {
		if (!add)
		    send_cmd(s_NickServ, "SVSMODE %s :+a", av[0]);
	    } else {
		if (add)
		    send_cmd(s_NickServ, "SVSMODE %s :-a", av[0]);
	    }
	    break;
#endif

	  case 'o':
	    if (add) {
		user->mode |= UMODE_o;
		opcnt++;
		
#ifdef STATISTICS
		if (user->server)
		    user->server->stats->opercnt++;
#endif
	    } else {
		user->mode &= ~UMODE_o;
		opcnt--;
#ifdef STATISTICS
		if (user->server)
		    user->server->stats->opercnt--;
#endif
	    }
	    break;

	  default: {
	    int32 flag = mode_char_to_flag(modechar, MODE_USER);
	    if (add)
		user->mode |= flag;
	    else
		user->mode &= ~flag;
	  }
	} /* switch (modechar) */
    }
}

/*************************************************************************/

/* Handle a QUIT command.
 *	av[0] = reason
 */

void do_quit(const char *source, int ac, char **av)
{
    User *user;

    user = finduser(source);
    if (!user) {
	/* Reportedly Undernet IRC servers will sometimes send duplicate
	 * QUIT messages for quitting users, so suppress the log warning. */
#ifndef IRC_UNDERNET
	if (stricmp(merge_args(ac,av),s_ChanServ) != 0)
	  log("user: QUIT from nonexistent user %s: %s", source,
							merge_args(ac, av));
#endif
	return;
    }
    if (debug)
	log("debug: %s quits", source);
    quit_user(user, av[0]);
}

/*************************************************************************/

/* Handle a KILL command.
 *	av[0] = nick being killed
 *	av[1] = reason
 * When called internally, callers may assume that the contents of the
 * argument strings will not be modified.
 */

void do_kill(const char *source, int ac, char **av)
{
    User *user;

    user = finduser(av[0]);
    if (!user)
	return;
    if (debug)
	log("debug: %s killed", av[0]);
    quit_user(user, av[1]);
}

/*************************************************************************/
/*************************************************************************/

/* Is the given nick an oper? */

int is_oper(const char *nick)
{
    User *user = finduser(nick);
    return user && (user->mode & UMODE_o);
}

/*************************************************************************/

/* Is the given nick on the given channel? */

int is_on_chan(const char *nick, const char *chan)
{
    User *u = finduser(nick);
    struct u_chanlist *c;

    if (!u)
	return 0;
    for (c = u->chans; c; c = c->next) {
	if (stricmp(c->chan->name, chan) == 0)
	    return 1;
    }
    return 0;
}

/*************************************************************************/

/* Is the given nick a channel operator on the given channel? */

int is_chanop(const char *nick, const char *chan)
{
    Channel *c = findchan(chan);
    struct c_userlist *u;

    if (!c)
	return 0;
    for (u = c->users; u; u = u->next) {
	if (irc_stricmp(u->user->nick, nick) != 0)
	    continue;
	return (u->mode & CUMODE_o) != 0;
    }
    return 0;
}

/*************************************************************************/

/* Is the given nick voiced (channel mode +v) on the given channel? */

int is_voiced(const char *nick, const char *chan)
{
	Channel *c = findchan(chan);
	struct c_userlist *u;

	if (c)
	  for (u = c->users; u; u = u->next)
	{
		if (irc_stricmp(u->user->nick, nick) != 0)
			continue;
		return (u->mode & CUMODE_v) != 0;
	}
	return 0;
}

/*************************************************************************/
/*************************************************************************/

/* Does the user's usermask match the given mask (either nick!user@host or
 * just user@host)?  Also checks fakehost where supported.
 */

int match_usermask(const char *mask, User *user)
{
    char *mask2 = sstrdup(mask);
    char *nick, *username, *host;
    int match_user, match_host, result;

    if (strchr(mask2, '!')) {
	nick = strtok(mask2, "!");
	username = strtok(NULL, "@");
    } else {
	nick = NULL;
	username = strtok(mask2, "@");
    }
    host = strtok(NULL, "");
    if (!host) {
	free(mask2);
	return 0;
    }
    match_user = match_wild(username, user->username);
    match_host = match_wild_nocase(host, user->host);
#ifdef IRC_UNREAL
    if (user->fakehost)
	match_host |= match_wild_nocase(host, user->fakehost);
#endif
    if (nick) {
	result = match_wild_nocase(nick, user->nick) &&
		 match_user && match_host;
    } else {
	result = match_user && match_host;
    }
    free(mask2);
    return result;
}

/*************************************************************************/

/* Split a usermask up into its constitutent parts.  Returned strings are
 * malloc()'d, and should be free()'d when done with.  Returns "*" for
 * missing parts.
 */

void split_usermask(const char *mask, char **nick, char **user, char **host)
{
	char *mask2 = sstrdup(mask);

	*nick = strtok(mask2, "!");
	*user = strtok(NULL, "@");
	*host = strtok(NULL, "");
	/* Handle special case: mask == user@host */
	if (*nick && !*user && strchr(*nick, '@'))
	{
		*nick = NULL;
		*user = strtok(mask2, "@");
		*host = strtok(NULL, "");
	}
	if (!*nick)
		*nick = "*";
	if (!*user)
		*user = "*";
	if (!*host)
		*host = "*";
	*nick = sstrdup(*nick);
	*user = sstrdup(*user);
	*host = sstrdup(*host);
	free(mask2);
}

/*************************************************************************/

/* Given a user, return a mask that will most likely match any address the
 * user will have from that location.  For IP addresses, wildcards the
 * appropriate subnet mask (e.g. 35.1.1.1 -> 35.*; 128.2.1.1 -> 128.2.*);
 * for named addresses, wildcards the leftmost part of the name unless the
 * name only contains two parts.  The returned character string is malloc'd
 * and should be free'd when done with.
 *
 * Where supported, uses the fake host instead of the real one if
 * use_fakehost is nonzero.
 */

char *create_mask(User *u, int use_fakehost)
{
    char *mask, *s, *end, *host;
	char *uname;

    host = u->host;
#ifdef IRC_UNREAL
    if (use_fakehost && u->fakehost)
	host = u->fakehost;
#endif
    /* Get us a buffer the size of the username plus hostname.  The result
     * will never be longer than this (and will often be shorter), thus we
     * can use strcpy() and sprintf() safely.
     */
    end = mask = smalloc(strlen(u->username) + strlen(host) + 2);
	uname = strdup(u->username);
	if (*uname == '~')
		*uname = '*';
    end += sprintf(end, "%s@", uname);
    free(uname);
    
    if (strspn(host, "0123456789.") == strlen(host)
		&& (s = strchr(host, '.'))
		&& (s = strchr(s+1, '.'))
		&& (s = strchr(s+1, '.'))
		&& (   !strchr(s+1, '.'))) {	/* IP addr */
	s = sstrdup(host);
	*strrchr(s, '.') = 0;
	if (atoi(host) < 192)
	    *strrchr(s, '.') = 0;
	if (atoi(host) < 128)
	    *strrchr(s, '.') = 0;
	sprintf(end, "%s.*", s);
	free(s);
    } else {
	if ((s = strchr(host+1, '.')) && strchr(s+1, '.')) {
	    s = sstrdup(s-1);
	    *s = '*';
	} else {
	    s = sstrdup(host);
	}
	strcpy(end, s);
	free(s);
    }
    return mask;
}

/*************************************************************************/

void send_comment(User *from, char *channel)
{
    Channel *c = findchan(channel);
    ChannelInfo *ci = c->ci;
    ChannelInfo *ca = cs_findchan(CSChan);
    NickInfo *ni = from->ni;
    ChannelComment *comment = NULL;
    char *message;
    char *tmp;
    char buf[512];
    int type = MSG_TYPE_STD;

    int i;

    if (!ci || !ca || !ni)
    {
        return;
    }

    for (i=0; i < ci->commentcount; i++)
    {
        if (ci->comment[i].in_use && ci->comment[i].ni == getlink(ni) )
        {
            comment = &ci->comment[i];
            break;
        }
    }
    if (comment && comment->msg)
    {
        message = strdup(comment->msg);
        tmp = strtok(message, " ");

        if (tmp == NULL)
        {
            return;
        }
        if (!stricmp(tmp, "$ACT"))
        {
            type = MSG_TYPE_ACT;
            tmp = strtok(NULL, " ");
            if (tmp == NULL)
            {
                return;
            }
        }
        else if (!stricmp(tmp, "$SND"))
        {
            type = MSG_TYPE_SND;
            tmp = strtok(NULL, " ");
            if (tmp == NULL)
            {
                return;
            }
        }

        memset(buf, '\0', sizeof(buf));

        for (; tmp; tmp = strtok(NULL, " "))
        {
            if (!stricmp(tmp, "$NICK"))
            {
                strcat(buf, ni->nick);
                strcat(buf, " ");
            }
            else
            {
                strcat(buf, tmp);
                strcat(buf, " ");
            }
        }

        switch(type)
        {
            case MSG_TYPE_ACT:
                send_cmd(s_ChanServ, "PRIVMSG %s :\1ACTION %s\1", ci->name, buf);
                break;
            case MSG_TYPE_SND:
                send_cmd(s_ChanServ, "PRIVMSG %s :\1SOUND %s\1", ci->name, buf);
                break;
            case MSG_TYPE_STD:
            default:
                privmsg(s_ChanServ, ci->name, "%s", buf);
                break;
        }
    }
    return;
}
