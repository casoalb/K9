/* Chatnet K9 Channel Services
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
#include "language.h"
#include "timeout.h"

/*************************************************************************/

/* Note a bad password attempt for the given user from the given service.
 * If they've used up their limit, toss them off.  "service" is used only
 * for the sender of the bad-password message.  "what" describes what the
 * password was for, and is used in the kill message if the user is killed.
 */

void bad_password(const char *service, User *u, const char *what)
{
    time_t now = time(NULL);

    notice_lang(service, u, PASSWORD_INCORRECT);

    if (!BadPassLimit)
	return;

    if (BadPassTimeout > 0 && u->invalid_pw_time > 0
			&& now >= u->invalid_pw_time + BadPassTimeout)
	u->invalid_pw_count = 0;
    u->invalid_pw_count++;
    u->invalid_pw_time = now;
    if (u->invalid_pw_count >= BadPassLimit) {
	char buf[BUFSIZE];
	snprintf(buf, sizeof(buf), "Too many invalid passwords (%s)", what);
	kill_user(NULL, u->nick, buf);
    }
}

/*************************************************************************/

/* Clear modes/users from a channel.  The "what" parameter is one or more
 * of the CLEAR_* constants defined in services.h.  "param" is:
 *     - for CLEAR_USERS, a kick message (const char *)
 *     - for CLEAR_UMODES, a bitmask of modes to clear (int32)
 *     - for CLEAR_BANS and CLEAR_EXCEPTS, a User * to match masks agains,
 *          or NULL to mean "all bans/exceptions"
 */

static void clear_modes(Channel *chan);
static void clear_bans(Channel *chan, User *u);
static void clear_excepts(Channel *chan, User *u);
static void clear_umodes(Channel *chan, int32 modes);
static void clear_users(Channel *chan, const char *reason);

void clear_channel(Channel *chan, int what, const void *param)
{
    if (what & CLEAR_USERS) {
	clear_users(chan, (const char *)param);
	/* Once we kick all the users, nothing else will matter */
	return;
    }

    if (what & CLEAR_MODES)
	clear_modes(chan);
    if (what & CLEAR_BANS)
	clear_bans(chan, (User *)param);
    if (what & CLEAR_EXCEPTS)
	clear_excepts(chan, (User *)param);
    if (what & CLEAR_UMODES)
	clear_umodes(chan, (int32)param);
    send_cmode(NULL);	/* Flush modes out */
}

static void clear_modes(Channel *chan)
{
    char *av[3];
    char buf[40];

    snprintf(buf, sizeof(buf), "-%s",
	     mode_flags_to_string(MODE_ALL & ~CMODE_REG, MODE_CHANNEL));
    av[0] = chan->name;
    av[1] = buf;
    if (chan->key)
	av[2] = chan->key;
    else
	av[2] = "";
    send_cmode(MODE_SENDER(s_ChanServ), av[0], av[1], av[2]);
    do_cmode(s_ChanServ, 3, av);
    check_modes(chan->name);
}

static void clear_bans(Channel *chan, User *u)
{
    char *av[3];
    int i, count;
    char **bans;

    if (!chan->bancount)
	return;

    /* Save original ban info */
    count = chan->bancount;
    bans = smalloc(sizeof(char *) * count);
    memcpy(bans, chan->bans, sizeof(char *) * count);

    av[0] = chan->name;
    av[1] = "-b";
    for (i = 0; i < count; i++) {
	if (!u || match_usermask(bans[i], u)) {
	    av[2] = bans[i];
	    send_cmode(MODE_SENDER(s_ChanServ), av[0], av[1], av[2]);
	    do_cmode(s_ChanServ, 3, av);
	}
    }
    free(bans);
}

static void clear_excepts(Channel *chan, User *u)
{
#ifdef HAVE_BANEXCEPT
    char *av[3];
    int i, count;
    char **excepts;

    if (!chan->exceptcount)
	return;
    count = chan->exceptcount;
    excepts = smalloc(sizeof(char *) * count);
    memcpy(excepts, chan->excepts, sizeof(char *) * count);
    av[0] = chan->name;
    av[1] = "-e";
    for (i = 0; i < count; i++) {
	if (!u || match_usermask(excepts[i], u)) {
	    av[2] = excepts[i];
	    send_cmode(MODE_SENDER(s_ChanServ), av[0], av[1], av[2]);
	    do_cmode(s_ChanServ, 3, av);
	}
    }
    free(excepts);
#endif
}

static void clear_umodes(Channel *chan, int32 modes)
{
    struct c_userlist *cu;

    for (cu = chan->users; cu; cu = cu->next) {
	if (cu->mode & modes) {
	    char buf[40];
	    snprintf(buf, sizeof(buf), "-%s",
		     mode_flags_to_string(cu->mode & modes, MODE_CHANUSER));
	    send_cmode(MODE_SENDER(s_ChanServ), chan->name, buf,
		       cu->user->nick);
	    cu->mode &= ~modes;
	}
    }
}

static void clear_users(Channel *chan, const char *reason)
{
    struct c_userlist *cu, *next;
    char *av[3];

    /* Prevent anyone from coming back in.  The ban will disappear
     * once everyone's gone. */
#if defined(IRC_BAHAMUT) || defined(IRC_UNREAL)
    send_cmd(ServerName, "SJOIN %ld %s + :",
	     chan->creation_time-1, chan->name);
#elif defined(HAS_BANEXCEPT)
    clear_excepts(chan, NULL);
#endif
    send_cmode(MODE_SENDER(s_ChanServ), chan->name, "+b", "*!*@*");
    send_cmode(NULL);	/* Flush modes out */

    av[0] = chan->name;
    av[2] = (char *)reason;
    for (cu = chan->users; cu; cu = next) {
	next = cu->next;
	av[1] = cu->user->nick;
	send_cmd(MODE_SENDER(s_ChanServ), "KICK %s %s :%s",
		 av[0], av[1], av[2]);
	do_kick(s_ChanServ, 3, av);
    }
}

/*************************************************************************/

/* Remove a user from the IRC network.  `source' is the nick which should
 * generate the kill, or NULL for a server-generated kill.
 */

void kill_user(const char *source, const char *user, const char *reason)
{
    char *av[2];
    char buf[BUFSIZE];

    if (!user || !*user)
	return;
    if (!source || !*source)
	source = ServerName;
    if (!reason)
	reason = "";
    snprintf(buf, sizeof(buf), "%s (%s)", source, reason);
    av[0] = (char *)user;
    av[1] = buf;
    send_cmd(source, "KILL %s :%s", user, av[1]);
    do_kill(source, 2, av);
}

/*************************************************************************/

/* Set the topic on a channel.  `setter' must not be NULL. */

void set_topic(Channel *c, const char *topic, const char *setter, time_t t)
{
    if (c->topic)
	free(c->topic);
    if (topic && *topic)
	c->topic = sstrdup(topic);
    else
	c->topic = NULL;
    strscpy(c->topic_setter, setter, NICKMAX);
    /* Make sure topic_time is not zero */
    if (!c->topic_time)
	c->topic_time = time(NULL);
#ifdef IRC_UNREAL
    if (t <= c->topic_time)
	t = c->topic_time + 1;  /* Force topic change */
#elif defined(IRC_TS8) || (defined(IRC_DALNET) && !defined(IRC_BAHAMUT))
    if (t >= c->topic_time)
	t = c->topic_time - 1;  /* Force topic change */
#endif
    c->topic_time = t;
#ifdef IRC_CLASSIC
    send_cmd(MODE_SENDER(s_ChanServ), "TOPIC %s %s :%s", c->name,
	     c->topic_setter, c->topic ? c->topic : "");
#elif defined(IRC_UNREAL)
    /* FIXME: using s_ChanServ sometimes gives "not on channel"?  U-line
     * setting problem? */
    send_cmd(ServerName, "TOPIC %s %s %lu :%s", c->name,
	     c->topic_setter, c->topic_time, c->topic ? c->topic : "");
#else
    send_cmd(MODE_SENDER(s_ChanServ), "TOPIC %s %s %lu :%s", c->name,
	     c->topic_setter, c->topic_time, c->topic ? c->topic : "");
#endif
}

/*************************************************************************/
/*************************************************************************/

/* send_cmode(): Send modes for a channel.  Using this routine allows the
 * modes for a channel to be collected up over several calls and sent out
 * in a single command, decreasing network traffic (and scroll).
 * This function should be called as either:
 *	send_cmode(sender, channel, modes, param1, param2...)
 * to send a channel mode, or
 *	send_cmode(NULL)
 * to flush all buffered modes.
 */

#define MAXMODES	6
#define MAXPARAMSLEN	(510-NICKMAX-CHANMAX-34-(7+MAXMODES))

static struct modedata {
    time_t used;
    int last_add;
    char channel[CHANMAX];
    char sender[NICKMAX];
    int32 binmodes_on;
    int32 binmodes_off;
    char opmodes[MAXMODES*2+1];
    char params[BUFSIZE];
    int nparams;
    int paramslen;
    Timeout *timeout;	/* For timely flushing */
} modedata[MERGE_CHANMODES_MAX];

static void flush_cmode(struct modedata *md);
static void flush_cmode_callback(Timeout *t);


void send_cmode(const char *sender, ...)
{
    va_list args;
    const char *channel, *modes;
    struct modedata *md;
    int which = -1, add;
    int32 flag;
    int i;
    char c, *s;


    if (!sender) {
	for (i = 0; i < MERGE_CHANMODES_MAX; i++) {
	    if (modedata[i].used)
		flush_cmode(&modedata[i]);
	}
	return;
    }

    va_start(args, sender);
    channel = va_arg(args, const char *);
    modes = va_arg(args, const char *);
    for (i = 0; i < MERGE_CHANMODES_MAX; i++) {
	if (modedata[i].used != 0
	 && irc_stricmp(modedata[i].channel, channel) == 0
	) {
	    if (irc_stricmp(modedata[i].sender, sender) != 0)
		flush_cmode(&modedata[i]);
	    which = i;
	    break;
	}
    }
    if (which < 0) {
	for (i = 0; i < MERGE_CHANMODES_MAX; i++) {
	    if (modedata[i].used == 0) {
		which = i;
		modedata[which].last_add = -1;
		break;
	    }
	}
    }
    if (which < 0) {
	int oldest = 0;
	time_t oldest_time = modedata[0].used;
	for (i = 1; i < MERGE_CHANMODES_MAX; i++) {
	    if (modedata[i].used < oldest_time) {
		oldest_time = modedata[i].used;
		oldest = i;
	    }
	}
	flush_cmode(&modedata[oldest]);
	which = oldest;
	modedata[which].last_add = -1;
    }
    md = &modedata[which];
    strscpy(md->sender, sender, NICKMAX);
    strscpy(md->channel, channel, CHANMAX);

    add = -1;
    while ((c = *modes++) != 0) {
	if (c == '+') {
	    add = 1;
	    continue;
	} else if (c == '-') {
	    add = 0;
	    continue;
	} else if (add < 0) {
	    continue;
	}
	switch (c) {
	  case 'k':
	  case 'l':
	  case 'o':
	  case 'v':
#ifdef HAVE_HALFOP
	  case 'h':
#endif
#ifdef IRC_UNREAL
	  case 'a':
	  case 'q':
#endif
	  case 'b':
#ifdef HAVE_BANEXCEPT
	  case 'e':
#endif
	    if (md->nparams >= MAXMODES || md->paramslen >= MAXPARAMSLEN) {
		flush_cmode(&modedata[which]);
		md->used = time(NULL);
	    }
	    s = md->opmodes + strlen(md->opmodes);
	    if (add != md->last_add) {
		*s++ = add ? '+' : '-';
		md->last_add = add;
	    }
	    *s++ = c;
	    if (!add && c == 'l')
		break;
	    s = va_arg(args, char *);
	    md->paramslen +=
		snprintf(md->params+md->paramslen,MAXPARAMSLEN+1-md->paramslen,
			 "%s%s", md->paramslen ? " " : "", s);
	    md->nparams++;
	    break;

	  default:
	    flag = mode_char_to_flag(c, MODE_CHANNEL);
	    if (add) {
		md->binmodes_on  |=  flag;
		md->binmodes_off &= ~flag;
	    } else {
		md->binmodes_off |=  flag;
		md->binmodes_on  &= ~flag;
	    }
	}
    }
    va_end(args);
    md->used = time(NULL);

    if (MergeChannelModes) {
	if (!md->timeout) {
	    md->timeout = add_timeout_ms(MergeChannelModes,
					 flush_cmode_callback, 0);
	    md->timeout->data = md;
	}
    } else {
	flush_cmode(md);
    }
}


static void flush_cmode(struct modedata *md)
{
    char buf[BUFSIZE];
    int len = 0;
    char lastc = 0;

    if (md->timeout)
	del_timeout(md->timeout);

    if (!md->binmodes_on && !md->binmodes_off && !*md->opmodes)
	goto done;	/* No actual modes here */

    /* Note that - must come before + because some servers (Unreal, others?)
     * ignore +s if followed by -p. */
    if (md->binmodes_off) {
	len += snprintf(buf+len, sizeof(buf)-len, "-%s",
			mode_flags_to_string(md->binmodes_off, MODE_CHANNEL));
	lastc = '-';
    }
    if (md->binmodes_on) {
	len += snprintf(buf+len, sizeof(buf)-len, "+%s",
			mode_flags_to_string(md->binmodes_on, MODE_CHANNEL));
	lastc = '+';
    }
    if (*md->opmodes) {
	if (*md->opmodes == lastc) {
	    /* First +/- matches last binary mode change */
	    memmove(md->opmodes, md->opmodes+1, strlen(md->opmodes+1)+1);
	}
	len += snprintf(buf+len, sizeof(buf)-len, "%s", md->opmodes);
    }
    if (md->paramslen)
	snprintf(buf+len, sizeof(buf)-len, " %s", md->params);
    send_cmd(md->sender, "MODE %s %s", md->channel, buf);

  done:
    memset(md, 0, sizeof(*md));
    md->last_add = -1;
}

static void flush_cmode_callback(Timeout *t)
{
    flush_cmode((struct modedata *)t->data);
}

/*************************************************************************/

void email_pass(char *email, char *pass, char *name) {
  char *efile = "emails/password-emails.txt";
  FILE *efp;

  if (!email || !pass || !name)
    return;

  if ((efp = fopen(efile, "a+")) == NULL ) {
    log("ERROR: could not open file [%s] to write emails to", efile);
    return;
  }

  fprintf(efp, "%s %s %s\n", email, pass, name);  
  fclose(efp); 

}
