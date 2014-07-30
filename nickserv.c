/* NickServ functions.
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
#include "pseudo.h"

/*************************************************************************/

#define HASH(nick)  (hashtable[(unsigned char)((nick)[0])]<<5 \
                     | hashtable[(unsigned char)((nick)[1])])
		     

#define HASHSIZE    1024
static NickInfo *nicklists[HASHSIZE];

static const char hashtable[256] = {
     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,

     0, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,
    16,17,18,19,20,21,22,23,24,25,26,27,28,29, 0, 0,
     0, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,
    16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,30,

    31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,
    31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,
    31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,
    31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,

    31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,
    31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,
    31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,
    31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,
};

/*************************************************************************/

#define TO_COLLIDE   0			/* Collide the user with this nick */
#define TO_RELEASE   1			/* Release a collided nick */
#define TO_SEND_433  2			/* Send a 433 numeric */

/*************************************************************************/

static int is_on_access(User *u, NickInfo *ni);
void alpha_insert_nick(NickInfo *ni);
static NickInfo *makenick(const char *nick);
static int delnick(NickInfo *ni);
static void remove_links(NickInfo *ni);
static void delink(NickInfo *ni);
static void link_fix_users(void);
static void suspend(NickInfo *ni, const char *reason,
		    const char *who, const time_t expires);
static void unsuspend(NickInfo *ni, int set_time);
static void nick_bad_password(User *u, NickInfo *ni);

static void collide(NickInfo *ni, int from_timeout);
static void release(NickInfo *ni, int from_timeout);
static void add_ns_timeout(NickInfo *ni, int type, time_t delay);
static void rem_ns_timeout(NickInfo *ni, int type, int del_to);

static void do_help(User *u);
static void do_register(User *u);
static void do_addnick(User *u);
static void do_identify(User *u);
static void do_drop(User *u);
static void do_set(User *u);
static void do_unset(User *u);
static void do_set_password(User *u, NickInfo *ni, char *param);
static void do_set_language(User *u, NickInfo *ni, char *param);
static void do_set_url(User *u, NickInfo *ni, char *param);
static void do_set_email(User *u, NickInfo *ni, char *param);
static void do_set_kill(User *u, NickInfo *ni, char *param);
static void do_set_secure(User *u, NickInfo *ni, char *param);
static void do_set_private(User *u, NickInfo *ni, char *param);
static void do_set_hide(User *u, NickInfo *ni, char *param, char *setting);
static void do_set_noexpire(User *u, NickInfo *ni, char *param);
static void do_access(User *u);
static void do_link(User *u);
static void do_unlink(User *u);
static void do_listlinks(User *u);
static void do_info(User *u);
static void do_genpass(User *u);
static void do_listchans(User *u);
static void do_list(User *u);
/* static void do_recover(User *u); */
/* static void do_release(User *u); */
static void do_ghost(User *u);
static void do_status(User *u);
static void do_getpass(User *u);
static void do_forbid(User *u);
static void do_suspend(User *u);
static void do_unsuspend(User *u);
#ifdef DEBUG_COMMANDS
static void do_listnick(User *u);
#endif

ChannelInfo *ca;

/*************************************************************************/

static Command cmds[] = {
    { "HELP",		do_help,	NULL,	0,	-1,			-1,	-1},
    { "REGISTER",	do_register,	NULL,	0,	NICK_HELP_REGISTER,	-1,	-1},
    { "ADDNICK",	do_addnick,	NULL,	0,	NICK_HELP_REGISTER,	-1,	-1},
    { "IDENTIFY",	do_identify,	NULL,	0,	NICK_HELP_IDENTIFY,	-1,	-1},
    { "SIDENTIFY",	do_identify,	NULL,	0,	-1,			-1,	-1},
    { "DROP",		do_drop,	NULL,	0,	NICK_HELP_DROP, 	-1,	-1},
	
    { "ACCESS",		do_access,	NULL,	0,	NICK_HELP_ACCESS,	-1,	-1},
    { "LINK",		do_link,	NULL,	0,	NICK_HELP_LINK,		-1,	-1},
    { "UNLINK",		do_unlink,	NULL,	0,	NICK_HELP_UNLINK,	-1,	-1},
    { "SET",		do_set,		NULL,	0,	NICK_HELP_SET,		-1,	-1},
    { "SET PASSWORD",	NULL,		NULL,	0,	NICK_HELP_SET_PASSWORD, -1,	-1},
    { "SET URL",	NULL,		NULL,	0,	NICK_HELP_SET_URL,      -1,	-1},
    { "SET EMAIL",	NULL,		NULL,	0,	NICK_HELP_SET_EMAIL,    -1,	-1},
    { "SET KILL",	NULL,		NULL,	0,	NICK_HELP_SET_KILL,     -1,	-1},
    { "SET SECURE",	NULL,		NULL,	0,	NICK_HELP_SET_SECURE,   -1,	-1},
    { "SET PRIVATE",	NULL,		NULL,	0,	NICK_HELP_SET_PRIVATE,  -1,	-1},
    { "SET HIDE",	NULL,		NULL,	0,	NICK_HELP_SET_HIDE,     -1,	-1},
    { "SET NOEXPIRE",	NULL,		NULL,	0,	-1			-1,	-1},
    { "UNSET",		do_unset,	NULL,	0,	NICK_HELP_UNSET,	-1,	-1},
    { "RECOVER",	do_ghost,	NULL,	0,	NICK_HELP_GHOST,      	-1,	-1},
    { "RELEASE",	do_ghost,	NULL,	0,	NICK_HELP_GHOST,     	-1,	-1},
    { "GHOST",		do_ghost,	NULL,	0,	NICK_HELP_GHOST,        -1,	-1},
    { "INFO",		do_info,	NULL,	0,	NICK_HELP_INFO,		-1,	-1},
    { "LIST",		do_list,	NULL,	0,	NICK_HELP_LIST		-1,	-1},
    { "STATUS",		do_status,	NULL,	0,	NICK_HELP_STATUS,       -1,	-1},
    { "LISTCHANS",	do_listchans,	NULL,	0,	NICK_HELP_LISTCHANS,	-1,	-1},
    { "GENPASS",	do_genpass,	is_cservice_helper, 0,NICK_SERVADMIN_HELP_GENPASS,-1,-1},
    { "LISTLINKS",	do_listlinks,	is_cservice_member, 0,NICK_SERVADMIN_HELP_LISTLINKS,-1,-1},
    { "GETPASS",	do_getpass,	is_cservice_member, 0,NICK_SERVADMIN_HELP_GETPASS,-1,-1},
    { "FORBID",		do_forbid,	is_cservice_member, 0,NICK_SERVADMIN_HELP_FORBID,-1,-1},
    { "SUSPEND",	do_suspend,	is_cservice_member, 0,NICK_SERVADMIN_HELP_SUSPEND,-1,-1},
    { "UNSUSPEND",	do_unsuspend,	is_cservice_member, 0,NICK_SERVADMIN_HELP_UNSUSPEND,-1,-1},
#ifdef DEBUG_COMMANDS
    { "LISTNICK",	do_listnick,	is_cservice_head,   0, -1, -1, -1},
#endif
    { NULL }
};

/*************************************************************************/
/************************ Main NickServ routines *************************/
/*************************************************************************/

/* NickServ initialization. */

void ns_init(void)
{
/*
    Command *cmd;

    if (NSRequireEmail) {
	cmd = lookup_cmd(cmds, "REGISTER");
	if (cmd)
	    cmd->helpmsg_all = NICK_HELP_REGISTER_REQ_EMAIL;
	cmd = lookup_cmd(cmds, "UNSET");
	if (cmd)
	    cmd->helpmsg_all = NICK_HELP_UNSET_REQ_EMAIL;
    }
*/
}

/*************************************************************************/

/* Main NickServ routine. */

void nickserv(const char *source, char *buf)
{
	char *cmd, *s;
	User *u = NULL;
	char *histbuf = NULL;
	int tmp_i;

	if (source)
		u = finduser(source);
	if (!u)
	{
		log("%s: user record for %s not found", s_NickServ, source);
		notice(s_NickServ, source,
		getstring((NickInfo *)NULL, USER_RECORD_NOT_FOUND));
		return;
	}
    
	if (buf)
		histbuf = sstrdup(buf);

	cmd = strtok(buf, " ");

	if (!cmd)
	{
		return;
	}
	if (stricmp(cmd, "\1PING") == 0)
	{
		if (!(s = strtok(NULL, "")))
		s = "\1";
		notice(s_NickServ, source, "\1PING %s", s);
		return;
	}
	if (skeleton)
	{
		notice_lang(s_NickServ, u, SERVICE_OFFLINE, s_NickServ);
		return;
	}
	
	if (u->ni && histbuf && stricmp(cmd, "identify"))
		tmp_i = add_history(u->ni, NULL, histbuf);
		    
	run_cmd(s_NickServ, u, cmds, cmd, NULL);
}

/*************************************************************************/

/* Return the NickInfo structure for the given nick, or NULL if the nick
 * isn't registered. */

NickInfo *findnick(const char *nick)
{
	NickInfo *ni;

	for (ni = nicklists[HASH(nick)]; ni; ni = ni->next)
	{
		if (irc_stricmp(ni->nick, nick) == 0)
			return ni;
	}
	return NULL;
}

/*************************************************************************/

/* Return the "master" nick for the given nick; i.e., trace the linked list
 * through the `link' field until we find a nickname with a NULL `link'
 * field.  Assumes `ni' is not NULL, and will always return a valid pointer.
 *
 * Note that we impose an arbitrary limit (LINK_HARDMAX) on the depth of
 * nested links.  This is to prevent infinite loops in case someone manages
 * to create a circular link.  If we pass this limit, we arbitrarily cut
 * off the link at the initial nick.
 */

NickInfo *getlink(NickInfo *ni)
{
	NickInfo *orig = ni;
	int i = 0;

        if (!ni)
          return(NULL);

	while (ni->link && ++i < LINK_HARDMAX)
		ni = ni->link;
	if (i >= LINK_HARDMAX)
	{
		log("%s: WARNING: Infinite loop(?) found at nick %s for nick %s, "
			"cutting link", s_NickServ, ni->nick, orig->nick);
		orig->link = NULL;
		ni = orig;
	}
	return ni;
}

/*************************************************************************/

/* Iterate over all NickInfo structures.  Return NULL when called after
 * reaching the last nickname.
 */

static int iterator_pos = HASHSIZE;   /* return NULL initially */
static NickInfo *iterator_ptr = NULL;

NickInfo *firstnick(void)
{
	iterator_pos = -1;
	iterator_ptr = NULL;
	return nextnick();
}

NickInfo *nextnick(void)
{
	if (iterator_ptr)
		iterator_ptr = iterator_ptr->next;
	while (!iterator_ptr && iterator_pos < HASHSIZE)
	{
		iterator_pos++;
		if (iterator_pos < HASHSIZE)
			iterator_ptr = nicklists[iterator_pos];
	}
	return iterator_ptr;
}

/*************************************************************************/

/* Return information on memory use.  Assumes pointers are valid. */

void get_nickserv_stats(long *nrec, long *memuse)
{
    long count = 0, mem = 0;
    int i;
    NickInfo *ni;
    char **accptr;

    for (ni = firstnick(); ni; ni = nextnick()) {
	count++;
	mem += sizeof(*ni);
	if (ni->url)
	    mem += strlen(ni->url)+1;
	if (ni->email)
	    mem += strlen(ni->email)+1;
	if (ni->last_usermask)
	    mem += strlen(ni->last_usermask)+1;
	if (ni->last_realname)
	    mem += strlen(ni->last_realname)+1;
	if (ni->last_quit)
	    mem += strlen(ni->last_quit)+1;
	mem += sizeof(char *) * ni->accesscount;
	for (accptr=ni->access, i=0; i < ni->accesscount; accptr++, i++) {
	    if (*accptr)
		mem += strlen(*accptr)+1;
	}
    }
    *nrec = count;
    *memuse = mem;
}

/*************************************************************************/
/************************ Global utility routines ************************/
/*************************************************************************/

#include "ns-loadsave.c"

/*************************************************************************/

/* Check whether a user is on the access list of the nick they're using,
 * and set the NS_ON_ACCESS flag if so.  Return 1 if on the access list, 0
 * if not.
 */

int check_on_access(User *u)
{
	int on_access;

	if (!u->ni)
		return 0;
	on_access = is_on_access(u, u->ni);
	if (on_access)
		u->real_ni->status |= NS_ON_ACCESS;
	return on_access;
}

/*************************************************************************/

/* Check whether a user is on the access list of the nick they're using, or
 * if they're the same user who last identified for the nick.  If not, send
 * warnings as appropriate.  If so (and not NI_SECURE), update last seen
 * info.  Return 1 if the user is valid and recognized, 0 otherwise (note
 * that this means an NI_SECURE nick will return 0 from here unless the
 * user's timestamp matches the last identify timestamp).  If the user's
 * nick is not registered, 0 is returned.
 */

int validate_user(User *u)
{
	NickInfo *ni;
	int on_access;

	if (!(ni = u->real_ni))
		return 0;

    /* IDENTIFIED may be set if another (valid) user was using the nick and
     * changed to a different, linked one.  Clear it here or people can
     * steal privileges. */

	ni->status &= ~NS_TEMPORARY;

	if ((ni->status & NS_VERBOTEN) || (u->ni->suspendinfo))
	{
		notice_lang(s_NickServ, u, NICK_MAY_NOT_BE_USED);
#ifdef HAVE_NICKCHANGE
		if (NSForceNickChange)
			notice_lang(s_NickServ, u, FORCENICKCHANGE_IN_1_MINUTE);
		else
#endif
			notice_lang(s_NickServ, u, DISCONNECT_IN_1_MINUTE);
#ifndef DONT_SEND_433
		add_ns_timeout(ni, TO_SEND_433, 40);
#endif
		add_ns_timeout(ni, TO_COLLIDE, 60);
		return 0;
	}

	if (!NoSplitRecovery)
	{
	/*
	 * This can be exploited to gain improper privilege if an attacker
	 * has the same Services stamp, username and hostname as the
	 * victim.
	 *
	 * Under ircd.dal 4.4.15+ and other servers supporting a Services
	 * stamp, Services guarantees that the first condition cannot occur
	 * unless the stamp counter rolls over (2^31-1 client connections).
	 * This is practically infeasible.  As an example, on a network of
	 * 30 servers, an attack introducing 10 new clients every second on
	 * every server would need to be sustained for 83 days (2.8 months)
	 * to cause the stamp to roll over.
	 *
	 * Under other servers, an attack is theoretically possible, but
	 * would require access to the computer the victim is using for IRC
	 * or the DNS servers for the victim's domain and IP address range
	 * in order to have the same hostname, and would require that the
	 * attacker connect so that he has the same server timestamp as the
	 * victim (this could be accomplished by finding a server with a
	 * clock slower than that of the victim's server and timing the
	 * connection attempt properly).
	 *
	 * When using Unreal, the username and hostname are not checked,
	 * since the real hostname is not saved, only the fake one.
	 * However, since Unreal supports Services stamps, this is still
	 * believed safe (see above).
	 *
	 * If someone gets a hacked server into your network, all bets are
	 * off.
	 */
		if (ni->id_stamp != 0 && u->services_stamp == ni->id_stamp)
		{
#ifndef IRC_UNREAL
			char buf[BUFSIZE];
			snprintf(buf, sizeof(buf), "%s@%s", u->username, u->host);
			if (strcmp(buf, ni->last_usermask) == 0)
			{
#endif
				ni->status |= NS_IDENTIFIED;
				return 1;
#ifndef IRC_UNREAL
			}
#endif
		}
	}

	on_access = check_on_access(u);

	if (!(u->ni->flags & NI_SECURE) && on_access)
	{
		ni->status |= NS_RECOGNIZED;
		ni->last_seen = time(NULL);
                db_nick_seti(ni, "lastseen", ni->last_seen);
		if (ni->last_usermask)
			free(ni->last_usermask);
#ifdef IRC_UNREAL
		ni->last_usermask = smalloc(strlen(u->username)+strlen(u->fakehost)+2);
		sprintf(ni->last_usermask, "%s@%s", u->username, u->fakehost);
                db_nick_set(ni, "lastusermask", ni->last_usermask);
#else
		ni->last_usermask = smalloc(strlen(u->username)+strlen(u->host)+2);
		sprintf(ni->last_usermask, "%s@%s", u->username, u->host);
                db_nick_set(ni, "lastusermask", ni->last_usermask);
#endif
		if (ni->last_realname)
			free(ni->last_realname);
		ni->last_realname = sstrdup(u->realname);
                db_nick_set(ni, "lastrealname", ni->last_realname);
		return 1;
	}

	if (on_access || !(u->ni->flags & NI_KILL_IMMED))
	{
		if (u->ni->flags & NI_SECURE)
			notice_lang(s_NickServ, u, NICK_IS_SECURE, s_NickServ);
		else
			notice_lang(s_NickServ, u, NICK_IS_REGISTERED, s_NickServ);
	}

	if ((u->ni->flags & NI_KILLPROTECT) && !on_access)
	{
		if (u->ni->flags & NI_KILL_IMMED)
		{
			collide(ni, 0);
			return 0;
		} else if (u->ni->flags & NI_KILL_QUICK) {
#ifdef HAVE_NICKCHANGE
			if (NSForceNickChange)
				notice_lang(s_NickServ, u, FORCENICKCHANGE_IN_20_SECONDS);
			else
#endif
				notice_lang(s_NickServ, u, DISCONNECT_IN_20_SECONDS);
			add_ns_timeout(ni, TO_COLLIDE, 20);
#ifndef DONT_SEND_433
		    add_ns_timeout(ni, TO_SEND_433, 10);
#endif
		} else {
#ifdef HAVE_NICKCHANGE
			if (NSForceNickChange)
				notice_lang(s_NickServ, u, FORCENICKCHANGE_IN_1_MINUTE);
			else
#endif
				notice_lang(s_NickServ, u, DISCONNECT_IN_1_MINUTE);
			add_ns_timeout(ni, TO_COLLIDE, 60);
#ifndef DONT_SEND_433
			add_ns_timeout(ni, TO_SEND_433, 40);
#endif
		}
	}

	if (NSExpire && NSExpireWarning && !(ni->status & NS_NOEXPIRE))
	{
		int time_left = NSExpire - (time(NULL) - ni->last_seen);
		if (time_left <= NSExpireWarning)
		{
			int msg;
			if (time_left >= 86400)
			{
				time_left /= 86400;
				msg = (time_left==1 ? STR_DAY : STR_DAYS);
			} else if (time_left >= 3600) {
				time_left /= 3600;
				msg = (time_left==1 ? STR_HOUR : STR_HOURS);
			} else {
				time_left /= 60;
				if (time_left < 1)
					time_left = 1;
				msg = (time_left==1 ? STR_MINUTE : STR_MINUTES);
			}
			notice_lang(s_NickServ, u, NICK_EXPIRES_SOON, time_left,
				getstring(ni,msg), s_NickServ, s_NickServ);
		}
	}

	return 0;
}

/*************************************************************************/

/* Cancel validation flags for a nick (i.e. when the user with that nick
 * signs off or changes nicks).  Also cancels any impending collide.
 * On NICKCHANGE-supporting servers, the enforcer nick is introduced
 * here as well.
 */

void cancel_user(User *u)
{
	NickInfo *ni = u->real_ni;

	if (ni)
	{
#ifdef HAVE_NICKCHANGE
		if (ni->status & NS_GUESTED)
		{
			char realname[NICKMAX+16];
			snprintf(realname, sizeof(realname), "%s Enforcement", s_NickServ);
			send_nick(u->nick, NSEnforcerUser, NSEnforcerHost, ServerName,
				realname, 0);
			add_ns_timeout(ni, TO_RELEASE, NSReleaseTimeout);
			ni->status &= ~NS_TEMPORARY;
			ni->status |= NS_KILL_HELD;
		} else {
#endif
			ni->status &= ~NS_TEMPORARY;
#ifdef HAVE_NICKCHANGE
		}
#endif
		rem_ns_timeout(ni, TO_COLLIDE, 1);
	}
}

/*************************************************************************/

/* Return whether a user has identified for their nickname. */

int nick_identified(User *u)
{
	return u->real_ni && (u->real_ni->status & NS_IDENTIFIED);
}

/*************************************************************************/

/* Return whether a user is recognized for their nickname. */

int nick_recognized(User *u)
{
	return u->real_ni && (u->real_ni->status & (NS_IDENTIFIED | NS_RECOGNIZED));
}

/*************************************************************************/

/* Remove all nicks and clear all suspensions which have expired.  Also
 * update last-seen time for all nicks.
 */

void expire_nicks()
{
	User *u;
	NickInfo *ni, *next;
	time_t now = time(NULL);

	for (u = firstuser(); u; u = nextuser())
	{
		if (u->real_ni && (u->real_ni->status & (NS_IDENTIFIED|NS_RECOGNIZED)))
		{
			if (debug >= 2)
				log("debug: %s: updating last seen time for %s", s_NickServ, u->nick);
			u->real_ni->last_seen = time(NULL);
                        db_nick_seti(u->real_ni, "lastseen", u->real_ni->last_seen);
		}
	}
	if (!NSExpire)
		return;
	for (ni = firstnick(); ni; ni = next)
	{
		next = nextnick();
		if (now >= (ni->last_seen + NSExpire)
			&& !(ni->status & (NS_VERBOTEN | NS_NOEXPIRE))
			&& !ni->suspendinfo
		) {
			log("%s: Expiring nickname %s (%d)(%d)(%d)", s_NickServ, ni->nick,
				(int)now, (int)ni->last_seen, NSExpire
			);
			u = finduser(ni->nick);
			if (u)
			{
				notice_lang(s_NickServ, u, NICK_EXPIRED);
				u->ni = u->real_ni = NULL;
			}
                        db_cs_expire_nick(ni->nick);
			delnick(ni);
		} else if (ni->suspendinfo && ni->suspendinfo->expires
			&& now >= ni->suspendinfo->expires)
		{
			log("%s: Expiring suspension for %s", s_NickServ, ni->nick);
			unsuspend(ni, 1);
		}
	}
}

/*************************************************************************/
/*********************** NickServ private routines ***********************/
/*************************************************************************/

/* Is the given user's address on the given nick's access list?  Return 1
 * if so, 0 if not. */

static int is_on_access(User *u, NickInfo *ni)
{
	int i;
	char *buf;

	if (ni->accesscount == 0)
		return 0;
	i = strlen(u->username);
	buf = smalloc(i + strlen(u->host) + 2);
	sprintf(buf, "%s@%s", u->username, u->host);
	strlower(buf+i+1);
	for (i = 0; i < ni->accesscount; i++)
	{
		if (match_wild_nocase(ni->access[i], buf))
		{
			free(buf);
			return 1;
		}
	}
	free(buf);
	return 0;
}

/*************************************************************************/

/* Insert a nick alphabetically into the database. */

void alpha_insert_nick(NickInfo *ni)
{
    NickInfo *ptr, *prev;
    char *nick = ni->nick;

    for (prev = NULL, ptr = nicklists[HASH(nick)];
			ptr && irc_stricmp(ptr->nick, nick) < 0;
			prev = ptr, ptr = ptr->next)
	;
    ni->prev = prev;
    ni->next = ptr;
    if (!prev)
	nicklists[HASH(nick)] = ni;
    else
	prev->next = ni;
    if (ptr)
	ptr->prev = ni;
}

/*************************************************************************/

/* Add a nick to the database.  Returns a pointer to the new NickInfo
 * structure if the nick was successfully registered, NULL otherwise.
 * Assumes nick does not already exist.
 */

static NickInfo *makenick(const char *nick)
{
    NickInfo *ni;

    ni = scalloc(sizeof(NickInfo), 1);
    memset(ni, '\0', sizeof(NickInfo));
    strscpy(ni->nick, nick, NICKMAX);
    alpha_insert_nick(ni);
    return ni;
}

/*************************************************************************/

/* Remove a nick from the NickServ database. Return 1 on success, 0
 * otherwise.  Also deletes any suspend info and removes the nick from any
 * ChanServ/OperServ lists it is on.
 */

static int delnick(NickInfo *ni)
{
    int i;

    db_nick_delete(ni);

    rem_ns_timeout(ni, -1, 1);
    cs_remove_nick(ni);
    if (ni->linkcount)
	remove_links(ni);
    if (ni->link)
	ni->link->linkcount--;
    if (ni->suspendinfo)
	unsuspend(ni, 0);
    if (ni->last_usermask)
	free(ni->last_usermask);
    if (ni->last_realname)
	free(ni->last_realname);
    if (ni->last_quit)
	free(ni->last_quit);
    if (ni->access) {
	for (i = 0; i < ni->accesscount; i++) {
	    if (ni->access[i])
		free(ni->access[i]);
	}
	free(ni->access);
    }
    if (ni->next)
	ni->next->prev = ni->prev;
    if (ni->prev)
	ni->prev->next = ni->next;
    else
	nicklists[HASH(ni->nick)] = ni->next;
    free(ni);
    return 1;
}

/*************************************************************************/

/* Remove any links to the given nick (i.e. prior to deleting the nick).
 * Note this is currently linear in the number of nicks in the database--
 * that's the tradeoff for the nice clean method of keeping a single parent
 * link in the data structure.
 * WARNING: this must be done AFTER channels are deleted or channel counts
 *          will be wrong!!
 */

static void remove_links(NickInfo *ni)
{
    NickInfo *ptr;
    int delinked = 0;

    for (ptr = firstnick(); ptr; ptr = nextnick()) {
	if (ptr->link == ni) {
	    if (ni->link) {
		ptr->link = ni->link;
		ni->link->linkcount++;
	    } else {
		delink(ptr);
		delinked = 1;
	    }
	}
    }
    if (delinked)
	link_fix_users();
}

/*************************************************************************/

/* Break a link from the given nick to its parent. */

static void delink(NickInfo *ni)
{
    NickInfo *link;

    link = ni->link;
    ni->link = NULL;
    link->linkcount--;
    do {
	link->channelcount -= ni->channelcount;
	if (link->link)
	    link = link->link;
    } while (link->link);
    ni->flags = link->flags;
    ni->channelmax = link->channelmax;
    ni->language = link->language;
    if (link->suspendinfo) {
	SuspendInfo *si;
	si = smalloc(sizeof(*si));
	memcpy(si, link->suspendinfo, sizeof(*si));
	if (si->reason)
	    si->reason = strdup(si->reason);
    }
    if (link->accesscount > 0) {
	char **access;
	int i;

	ni->accesscount = link->accesscount;
	access = smalloc(sizeof(char *) * ni->accesscount);
	ni->access = access;
	for (i = 0; i < ni->accesscount; i++, access++)
	    *access = sstrdup(link->access[i]);
    }
}

/*************************************************************************/

/* Adjust effective nick pointers after a link change */
/* FIXME: can we speed this up? */

static void link_fix_users(void)
{
    User *u;

    for (u = firstuser(); u; u = nextuser()) {
	if (u->real_ni)
	    u->ni = getlink(u->real_ni);
    }
}

/*************************************************************************/

/* Create a new SuspendInfo structure and associate it with the given nick. */

static void suspend(NickInfo *ni, const char *reason,
		    const char *who, const time_t expires)
{
    SuspendInfo *si;

    si = scalloc(sizeof(*si), 1);
    strscpy(si->who, who, NICKMAX);
    si->reason = sstrdup(reason);
    si->suspended = time(NULL);
    si->expires = expires;
    ni->suspendinfo = si;

    db_nick_suspend(ni);

}

/*************************************************************************/

/* Delete the suspension data for the given nick.  We also alter the
 * last_seen value to ensure that it does not expire within the next
 * NSSuspendGrace seconds, giving the owner a chance to reclaim it
 * (but only if set_time is nonzero).
 */

static void unsuspend(NickInfo *ni, int set_time)
{
    time_t now = time(NULL);

    if (!ni->suspendinfo) {
	log("%s: unsuspend; called on non-suspended nick %s",
	    s_NickServ, ni->nick);
	return;
    }
    if (ni->suspendinfo->reason)
	free(ni->suspendinfo->reason);
    free(ni->suspendinfo);
    ni->suspendinfo = NULL;
    db_nick_unsuspend(ni);
    if (set_time && NSExpire && NSSuspendGrace
     && (now - ni->last_seen >= NSExpire - NSSuspendGrace)
    ) {
	ni->last_seen = now - NSExpire + NSSuspendGrace;
        db_nick_seti(ni, "lastseen", ni->last_seen);
	log("%s: unsuspend: Altering last_seen time for %s to %ld.",
	    s_NickServ, ni->nick, ni->last_seen);
    }
}

/*************************************************************************/

/* Register a bad password attempt for a nickname. */

static void nick_bad_password(User *u, NickInfo *ni)
{
    bad_password(s_NickServ, u, ni->nick);
    ni->bad_passwords++;
    if (BadPassWarning && ni->bad_passwords == BadPassWarning) {
	wallops(s_NickServ, "\2Warning:\2 Repeated bad password attempts"
	                    " for nick %s", ni->nick);
    }
    if (BadPassSuspend && ni->bad_passwords == BadPassSuspend) {
	time_t expire = 0;
	if (NSSuspendExpire)
	    expire = time(NULL) + NSSuspendExpire;
	suspend(ni, "Too many bad passwords (automatic suspend)",
		s_NickServ, expire);
	log("%s: Automatic suspend for %s (too many bad passwords)",
	    s_NickServ, ni->nick);
	/* Clear bad password count for when nick is unsuspended */
	ni->bad_passwords = 0;
    }
}

/*************************************************************************/
/*************************************************************************/

/* Collide a nick.
 *
 * When connected to a network using DALnet servers version 4.4.15 or
 * later, Services is able to force a nick change instead of killing the
 * user.  The new nick takes the form "Guest######".  If a nick change is
 * forced, we do not introduce the enforcer nick until the user's nick
 * actually changes.  This is watched for and done in cancel_user().
 *
 * The number that is used to build the "Guest" nick should be:
 *	- Atomic
 *	- Unique within a 24 hour period - basically this means that if
 *	  someone has a "Guest" nick for more than 24 hours, there is a
 *	  slight chance that a new "Guest" could be collided. I really
 *	  don't see this as a problem.
 *	- Reasonably unpredictable
 *
 * -TheShadow
 *
 * I don't see the need for the "reasonably unpredictable" bit, as you can
 * prevent users from stealing guest nicks with ircd.conf settings.
 * Switched to a simple uint32 suffix (4 billion nicks should be enough for
 * 24 hours). --AC 2001/1/7
 */

static void collide(NickInfo *ni, int from_timeout)
{
    User *u;
    char realname[NICKMAX+16]; /*Long enough for s_NickServ + " Enforcement"*/

    u = finduser(ni->nick);

    if (!from_timeout)
	rem_ns_timeout(ni, TO_COLLIDE, 1);

#ifdef HAVE_NICKCHANGE
    if (NSForceNickChange) {
	char guestnick[NICKMAX];
	static uint32 counter = 0;

	snprintf(guestnick, sizeof(guestnick), "%s%d",
			NSGuestNickPrefix, counter);
	counter++;
        notice_lang(s_NickServ, u, FORCENICKCHANGE_NOW, guestnick);
	send_cmd(s_NickServ, "SVSNICK %s %s :%ld",
			u->nick, guestnick, time(NULL));
	ni->status |= NS_GUESTED;
    } else {
#endif
	notice_lang(s_NickServ, u, DISCONNECT_NOW);
    	kill_user(s_NickServ, ni->nick, "Nick kill enforced");

	snprintf(realname, sizeof(realname), "%s Enforcement", s_NickServ);
	send_nick(ni->nick, NSEnforcerUser, NSEnforcerHost, ServerName,
		  realname, 0);

	ni->status |= NS_KILL_HELD;
	add_ns_timeout(ni, TO_RELEASE, NSReleaseTimeout);
#ifdef HAVE_NICKCHANGE
    }
#endif
}

/*************************************************************************/

/* Release hold on a nick. */

static void release(NickInfo *ni, int from_timeout)
{
    if (!from_timeout)
	rem_ns_timeout(ni, TO_RELEASE, 1);
    send_cmd(ni->nick, "QUIT");
    ni->status &= ~NS_KILL_HELD;
}

/*************************************************************************/
/*************************************************************************/

static struct my_timeout {
    struct my_timeout *next, *prev;
    NickInfo *ni;
    Timeout *to;
    int type;
} *my_timeouts;

/*************************************************************************/

/* Collide a nick on timeout. */

static void timeout_collide(Timeout *t)
{
    NickInfo *ni = t->data;
    User *u;

    rem_ns_timeout(ni, TO_COLLIDE, 0);
    /* If they identified or don't exist anymore, don't kill them. */
    if ((ni->status & NS_IDENTIFIED)
		|| !(u = finduser(ni->nick))
		|| u->my_signon > t->settime)
	return;
    /* The RELEASE timeout will always add to the beginning of the
     * list, so we won't see it.  Which is fine because it can't be
     * triggered yet anyway. */
    collide(ni, 1);
}

/*************************************************************************/

/* Release a nick on timeout. */

static void timeout_release(Timeout *t)
{
    NickInfo *ni = t->data;

    rem_ns_timeout(ni, TO_RELEASE, 0);
    release(ni, 1);
}

/*************************************************************************/

/* Send a 433 (nick in use) numeric to the given user. */

static void timeout_send_433(Timeout *t)
{
    NickInfo *ni = t->data;
    User *u;

    rem_ns_timeout(ni, TO_SEND_433, 0);
    /* If they identified or don't exist anymore, don't send the 433. */
    if ((ni->status & NS_IDENTIFIED)
		|| !(u = finduser(ni->nick))
		|| u->my_signon > t->settime)
	return;
    if (ni->status & NS_VERBOTEN)
	send_cmd(ServerName, "433 %s %s :Nickname may not be used",
		 ni->nick, ni->nick);
    else
	send_cmd(ServerName, "433 %s %s :Nickname is registered to someone"
		 " else", ni->nick, ni->nick);
}

/*************************************************************************/

/* Add a collide/release/433 timeout. */

void add_ns_timeout(NickInfo *ni, int type, time_t delay)
{
    Timeout *to;
    struct my_timeout *t;
    void (*timeout_routine)(Timeout *);

    if (type == TO_COLLIDE)
	timeout_routine = timeout_collide;
    else if (type == TO_RELEASE)
	timeout_routine = timeout_release;
    else if (type == TO_SEND_433)
	timeout_routine = timeout_send_433;
    else {
	log("%s: unknown timeout type %d!  ni=%p (%s), delay=%ld",
	    s_NickServ, type, ni, ni->nick, delay);
	return;
    }
    to = add_timeout(delay, timeout_routine, 0);
    to->data = ni;
    t = smalloc(sizeof(*t));
    t->next = my_timeouts;
    t->prev = NULL;
    if (my_timeouts)
	my_timeouts->prev = t;
    my_timeouts = t;
    t->ni = ni;
    t->to = to;
    t->type = type;
}

/*************************************************************************/

/* Remove a collide/release timeout from our private list.  If del_to is
 * nonzero, also delete the associated timeout.  If type == -1, delete
 * timeouts of all types.
 */

static void rem_ns_timeout(NickInfo *ni, int type, int del_to)
{
    struct my_timeout *t, *t2;

    t = my_timeouts;
    while (t) {
	if (t->ni == ni && (type < 0 || t->type == type)) {
	    t2 = t->next;
	    if (t->next)
		t->next->prev = t->prev;
	    if (t->prev)
		t->prev->next = t->next;
	    else
		my_timeouts = t->next;
	    if (del_to)
		del_timeout(t->to);
	    free(t);
	    t = t2;
	} else {
	    t = t->next;
	}
    }
}

/*************************************************************************/
/*********************** NickServ command routines ***********************/
/*************************************************************************/

/* Return a help message. */

static void do_help(User *u)
{
	char *cmd = strtok(NULL, "");

notice(s_NickServ, u->nick, "Help disabled temporarily pending rewrite...");
return;
	if (!cmd)
	{
		if (NSExpire >= 86400)
			notice_help(s_NickServ, u, NICK_HELP, NSExpire/86400);
		else
			notice_help(s_NickServ, u, NICK_HELP_EXPIRE_ZERO);

		if ( is_cservice_head(u) )
			notice_help(s_NickServ, u, NICK_SERVADMIN_HELP);

		notice_help(s_NickServ, u, NICK_HELP);

	} else if (stricmp(cmd, "SET LANGUAGE") == 0) {
		int i;
		notice_help(s_NickServ, u, NICK_HELP_SET_LANGUAGE);
		for (i = 0; i < NUM_LANGS && langlist[i] >= 0; i++)
		{
			notice(s_NickServ, u->nick, "    %2d) %s", i+1, langnames[langlist[i]]);
		}
	} else {
		help_cmd(s_NickServ, u, cmds, cmd);
	}
}

/*************************************************************************/

/* Register a nick. */
static void do_addnick(User *u)
{
	NickInfo *ni;
	char *nick = strtok(NULL, " ");
	char *pass = strtok(NULL, " ");
	char *email = strtok(NULL, " ");
        char passbuf[PASSMAX];
        int len;
	User *target;
    
	if (readonly)
	{
		notice_lang(s_NickServ, u, NICK_REGISTRATION_DISABLED);
		return;
	}

	if (!nick || !pass)
	{
		notice(s_ChanServ,u->nick,"Syntax: \2ADDNICK\2 nickname password \2[\2email\2]\2");
		notice(s_ChanServ,u->nick,"Type \2/msg NickServ HELP ADDNICK\2 for more information.");
		return;
	}
	if (!u || !(ca = cs_findchan(CSChan)))
	{
		notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
		return;
	}
	if (get_access(u,ca) < ACCLEV_HELPER)
	{
		notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
		return;
	}

	target = finduser(nick);

	if (!target)
	{
		notice_lang(s_ChanServ, u, CHAN_NOUSER_FOUND, nick);
		return;
	}
	
	if (!nick || !pass || (NSRequireEmail && !email)
		|| (stricmp(pass, target->nick) == 0
		&& (strtok(NULL, "")
		|| (email && (!strchr(email,'@')
		|| !strchr(email,'.')))))
	)
	{
        /* No password/email, or they (apparently) tried to include the nick
         * in the command. */
		syntax_error(s_NickServ, u, "REGISTER",
			NSRequireEmail ? NICK_REGISTER_REQ_EMAIL_SYNTAX
			: NICK_REGISTER_SYNTAX);
		return;
	}
	else if (target->real_ni)
	{    /* i.e. there's already such a nick regged */
		if (target->real_ni->status & NS_VERBOTEN) {
		log("%s: %s@%s tried to register forbidden nick %s", s_NickServ, u->username, u->host, target->nick);
		notice_lang(s_NickServ, u, NICK_CANNOT_BE_REGISTERED, target->nick);
		return;
	}
	else
	{
		if (target->ni->suspendinfo)
			log("%s: %s@%s tried to register suspended nick %s",s_NickServ, u->username, u->host, target->nick);
		notice_lang(s_NickServ, u, NICK_ALREADY_REGISTERED, target->nick);
		return;
	}

    } else if (stricmp(pass, target->nick) == 0
               || (StrictPasswords && strlen(pass) < 5)
    )
    {
		notice_lang(s_NickServ, u, MORE_OBSCURE_PASSWORD);
		return;
    }
    else if (email && !valid_email(email))
    {
        notice_lang(s_NickServ, u, BAD_EMAIL);
        return;
    } 

	/* Fail safes complete */

#ifdef USE_ENCRYPTION
	len = strlen(pass);
	if (len > PASSMAX)
	{
		len = PASSMAX;
		pass[len] = 0;
		notice_lang(s_NickServ, u, PASSWORD_TRUNCATED, PASSMAX);
	}
	if (encrypt(pass, len, passbuf, PASSMAX) < 0)
	{
		memset(pass, 0, strlen(pass));
		log("%s: Failed to encrypt password for %s (register)",
			s_NickServ, target->nick);
		notice_lang(s_NickServ, u, NICK_REGISTRATION_FAILED);
		return;
	}
	memset(pass, 0, strlen(pass));
#endif
	ni = makenick(target->nick);
	if (!ni)
	{
		log("%s: makenick (%s) failed by (%s)", s_NickServ, target->nick, u->nick);
		notice_lang(s_NickServ, u, NICK_REGISTRATION_FAILED);
		return;
	}
#ifdef USE_ENCRYPTION
	memcpy(ni->pass, passbuf, PASSMAX);
	ni->status = NS_ENCRYPTEDPW | NS_IDENTIFIED | NS_RECOGNIZED;
#else
	if (strlen(pass) > PASSMAX-1) /* -1 for null byte */
		notice_lang(s_NickServ, u, PASSWORD_TRUNCATED, PASSMAX-1);
	strscpy(ni->pass, pass, PASSMAX);
	ni->status = NS_IDENTIFIED | NS_RECOGNIZED;
#endif
	ni->flags = NSDefFlags;
	ni->channelcount = 0;
	ni->channelmax = CSMaxReg;
#ifdef IRC_UNREAL
	ni->last_usermask = smalloc(strlen(target->username)+strlen(target->fakehost)+2);
	sprintf(ni->last_usermask, "%s@%s", target->username, target->fakehost);
#else
	ni->last_usermask = smalloc(strlen(target->username)+strlen(target->host)+2);
	sprintf(ni->last_usermask, "%s@%s", target->username, target->host);
#endif
	ni->last_realname = sstrdup(target->realname);
	ni->time_registered = ni->last_seen = time(NULL);
	ni->accesscount = 1;
	ni->access = smalloc(sizeof(char *));
	ni->access[0] = create_mask(target, 0);
	ni->language = DEF_LANGUAGE;
	ni->link = NULL;
	if (email)
		ni->email = sstrdup(email);
	target->ni = target->real_ni = ni;
	if (email)
	{
		log("%s: `%s' registered by %s@%s (%s) by (%s)", s_NickServ,
			target->nick, target->username, target->host, email, u->nick);
	}
	else
	{
		log("%s: `%s' registered by %s@%s by (%s)", s_NickServ,
			target->nick, target->username, target->host, u->nick);
	}

        db_add_nick(ni);

	notice_lang(s_NickServ, u, NICK_REGISTERED2, target->nick, target->ni->access[0]);

#ifndef USE_ENCRYPTION
	notice_lang(s_NickServ, u, NICK_PASSWORD2_IS, ni->pass);
#endif
	target->lastnickreg = time(NULL);
	if (UMODE_REG)
		send_cmd(s_NickServ, "SVSMODE %s :+%s", target->nick,
	mode_flags_to_string(UMODE_REG, MODE_USER));
}


static void do_register(User *u)
{
    NickInfo *ni;
    char *pass = strtok(NULL, " ");
    char *email = strtok(NULL, " ");

    if (readonly) {
	notice_lang(s_NickServ, u, NICK_REGISTRATION_DISABLED);
	return;
    }
    /*if (stricmp(u->nick, ServicesRoot) != 0) {
    **    notice_lang(s_NickServ, u, NICK_REGISTRATION_DISABLED);
    **} else {
    */

#ifdef HAVE_NICKCHANGE
    /* Prevent "Guest" nicks from being registered. -TheShadow */
    if (NSForceNickChange) {
	int prefixlen = strlen(NSGuestNickPrefix);
	int nicklen = strlen(u->nick);

	/* A guest nick is defined as a nick...
	 * 	- starting with NSGuestNickPrefix
	 * 	- with a series of between, and including, 1 and 10 digits
	 */
	if (nicklen <= prefixlen+10 && nicklen >= prefixlen+1
	 && stristr(u->nick, NSGuestNickPrefix) == u->nick
	 && strspn(u->nick+prefixlen, "1234567890") == nicklen-prefixlen
	) {
	    notice_lang(s_NickServ, u, NICK_CANNOT_BE_REGISTERED, u->nick);
	    return;
	}
    }
#endif

    if (time(NULL) < u->lastnickreg + NSRegDelay) {
	notice_lang(s_NickServ, u, NICK_REG_PLEASE_WAIT, NSRegDelay);

    } else if (!pass || (NSRequireEmail && !email)
	       || (stricmp(pass, u->nick) == 0
		   && (strtok(NULL, "")
		       || (email && (!strchr(email,'@')
				     || !strchr(email,'.')))))
    ) {
	/* No password/email, or they (apparently) tried to include the nick
	 * in the command. */
	syntax_error(s_NickServ, u, "REGISTER",
		     NSRequireEmail ? NICK_REGISTER_REQ_EMAIL_SYNTAX
		                    : NICK_REGISTER_SYNTAX);

    } else if (u->real_ni) {	/* i.e. there's already such a nick regged */
	if (u->real_ni->status & NS_VERBOTEN) {
	    log("%s: %s@%s tried to register forbidden nick %s", s_NickServ,
			u->username, u->host, u->nick);
	    notice_lang(s_NickServ, u, NICK_CANNOT_BE_REGISTERED, u->nick);
	} else {
	    if (u->ni->suspendinfo)
		log("%s: %s@%s tried to register suspended nick %s",
		    s_NickServ, u->username, u->host, u->nick);
	    notice_lang(s_NickServ, u, NICK_ALREADY_REGISTERED, u->nick);
	}

    } else if (stricmp(pass, u->nick) == 0
	       || (StrictPasswords && strlen(pass) < 5)
    ) {
	notice_lang(s_NickServ, u, MORE_OBSCURE_PASSWORD);

    } else if (email && !valid_email(email)) {
	notice_lang(s_NickServ, u, BAD_EMAIL);

    } else {
#ifdef USE_ENCRYPTION
	int len = strlen(pass);
	char passbuf[PASSMAX];
	if (len > PASSMAX) {
	    len = PASSMAX;
	    pass[len] = 0;
	    notice_lang(s_NickServ, u, PASSWORD_TRUNCATED, PASSMAX);
	}
	if (encrypt(pass, len, passbuf, PASSMAX) < 0) {
	    memset(pass, 0, strlen(pass));
	    log("%s: Failed to encrypt password for %s (register)",
		s_NickServ, u->nick);
	    notice_lang(s_NickServ, u, NICK_REGISTRATION_FAILED);
	    return;
	}
	memset(pass, 0, strlen(pass));
#endif
	ni = makenick(u->nick);
	if (!ni) {
	    log("%s: makenick(%s) failed", s_NickServ, u->nick);
	    notice_lang(s_NickServ, u, NICK_REGISTRATION_FAILED);
	    return;
	}
#ifdef USE_ENCRYPTION
	memcpy(ni->pass, passbuf, PASSMAX);
	ni->status = NS_ENCRYPTEDPW | NS_IDENTIFIED | NS_RECOGNIZED;
#else
	if (strlen(pass) > PASSMAX-1) /* -1 for null byte */
	    notice_lang(s_NickServ, u, PASSWORD_TRUNCATED, PASSMAX-1);
	strscpy(ni->pass, pass, PASSMAX);
	ni->status = NS_IDENTIFIED | NS_RECOGNIZED;
#endif
	ni->flags = NSDefFlags;
	ni->channelcount = 0;
	ni->channelmax = CSMaxReg;
#ifdef IRC_UNREAL
	ni->last_usermask = smalloc(strlen(u->username)+strlen(u->fakehost)+2);
	sprintf(ni->last_usermask, "%s@%s", u->username, u->fakehost);
#else
	ni->last_usermask = smalloc(strlen(u->username)+strlen(u->host)+2);
	sprintf(ni->last_usermask, "%s@%s", u->username, u->host);
#endif
	ni->last_realname = sstrdup(u->realname);
	ni->time_registered = ni->last_seen = time(NULL);
	ni->accesscount = 1;
	ni->access = smalloc(sizeof(char *));
	ni->access[0] = create_mask(u, 0);
	ni->language = DEF_LANGUAGE;
	ni->link = NULL;
	if (email)
	    ni->email = sstrdup(email);
	u->ni = u->real_ni = ni;
	if (email) {
	    log("%s: `%s' registered by %s@%s (%s)", s_NickServ,
		u->nick, u->username, u->host, email);
	} else {
	    log("%s: `%s' registered by %s@%s", s_NickServ,
		u->nick, u->username, u->host);
	}

        db_add_nick(ni);

	notice_lang(s_NickServ, u, NICK_REGISTERED, u->nick, ni->access[0]);
#ifndef USE_ENCRYPTION
	notice_lang(s_NickServ, u, NICK_PASSWORD_IS, ni->pass);
#endif
	u->lastnickreg = time(NULL);
	if (UMODE_REG)
	    send_cmd(s_NickServ, "SVSMODE %s :+%s", u->nick,
		     mode_flags_to_string(UMODE_REG, MODE_USER));
	
      }
   /* }
   */
}

/*************************************************************************/

static void do_identify(User *u)
{
    char *pass = strtok(NULL, " ");
    NickInfo *ni;
    int res;

    if (!pass) {
	syntax_error(s_NickServ, u, "IDENTIFY", NICK_IDENTIFY_SYNTAX);

    } else if (!(ni = u->real_ni)) {
	notice(s_NickServ, u->nick, "Your nick isn't registered.");

    } else if (getlink(ni)->suspendinfo) {
	notice_lang(s_NickServ, u, NICK_X_SUSPENDED, u->nick);

    } else if (!(res = check_password(pass, ni->pass))) {
	log("%s: Failed IDENTIFY for %s!%s@%s",
		s_NickServ, u->nick, u->username, u->host);
	nick_bad_password(u, ni);

    } else if (res == -1) {
	notice_lang(s_NickServ, u, NICK_IDENTIFY_FAILED);

    } else {
	ni->bad_passwords = 0;
	ni->status |= NS_IDENTIFIED;
	ni->id_stamp = u->services_stamp;
	ni->last_seen = time(NULL);
        db_nick_seti(ni, "lastseen", ni->last_seen);
	if (!(ni->status & NS_RECOGNIZED)) {
	    if (ni->last_usermask)
		free(ni->last_usermask);
#ifdef IRC_UNREAL
	    ni->last_usermask = smalloc(strlen(u->username)+strlen(u->fakehost)+2);
	    sprintf(ni->last_usermask, "%s@%s", u->username, u->fakehost);
            db_nick_set(ni, "lastusermask", ni->last_usermask);
#else
	    ni->last_usermask = smalloc(strlen(u->username)+strlen(u->host)+2);
	    sprintf(ni->last_usermask, "%s@%s", u->username, u->host);
            db_nick_set(ni, "lastusermask", ni->last_usermask);
#endif
	    if (ni->last_realname)
		free(ni->last_realname);
	    ni->last_realname = sstrdup(u->realname);
            db_nick_set(ni, "lastrealname", ni->last_realname);
	}
#ifdef IRC_DAL4_4_15
	if ((ca = cs_findchan(CSChan)) && get_access(u,ca) >= 800)
	    send_cmd(s_NickServ, "SVSMODE %s :+ra", u->nick);
	else
#endif
	if (UMODE_REG)
	    send_cmd(s_NickServ, "SVSMODE %s :+%s", u->nick, mode_flags_to_string(UMODE_REG, MODE_USER));

	log("%s: %s!%s@%s identified for nick %s", s_NickServ, u->nick, u->username, u->host, u->nick);
	notice_lang(s_NickServ, u, NICK_IDENTIFY_SUCCEEDED);
	if (!(ni->status & NS_RECOGNIZED)) {
	    ni->status |= NS_RECOGNIZED;
	}
    }
}

/*************************************************************************/

static void do_drop(User *u)
{
    char *nick = strtok(NULL, " ");
    NickInfo *ni;
    User *u2;

    if (readonly && ((ca = cs_findchan(CSChan)) && get_access(u,ca) < ACCLEV_HELPER)) {
	notice_lang(s_NickServ, u, NICK_DROP_DISABLED);
	return;
    }

    if (((ca = cs_findchan(CSChan)) && (get_access(u,ca) < 800)) && nick) {
	syntax_error(s_NickServ, u, "DROP", NICK_DROP_SYNTAX);

    } else if (!(ni = (nick ? findnick(nick) : u->real_ni))) {
	if (nick)
	    notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);
	else
	    notice_lang(s_NickServ, u, NICK_NOT_REGISTERED);

    } else if (NSSecureAdmins && nick && !is_cservice_member(u)) {
	notice_lang(s_NickServ, u, PERMISSION_DENIED);

    } else if (!nick && !nick_identified(u)) {
	notice_lang(s_NickServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);

    } else {
	/* Record whether this nick had any links to it */
	int hadlinks = (ni->linkcount > 0);

	if (readonly)
	    notice_lang(s_NickServ, u, READ_ONLY_MODE);
	if (UMODE_REG)
	    send_cmd(s_NickServ, "SVSMODE %s :-%s", ni->nick,
		     mode_flags_to_string(UMODE_REG, MODE_USER));
	delnick(ni);
	log("%s: %s!%s@%s dropped nickname %s", s_NickServ,
		u->nick, u->username, u->host, nick ? nick : u->nick);
	if (nick)
	    notice_lang(s_NickServ, u, NICK_X_DROPPED, nick);
	else
	    notice_lang(s_NickServ, u, NICK_DROPPED);
	if (nick && (u2 = finduser(nick)))
	    u2->ni = u2->real_ni = NULL;
	else if (!nick)
	    u->ni = u->real_ni = NULL;
	/* Update effective-nick pointers if this nick was a link parent */
	/* FIXME: using a doubly-linked nicklink tree could speed this up */
	if (hadlinks) {
	    for (u2 = firstuser(); u2; u2 = nextuser()) {
		if (u2->ni == ni)
		    u2->ni = getlink(u2->real_ni);
	    }
	}
    }
}

/*************************************************************************/

static void do_set(User *u)
{
    char *cmd   = strtok(NULL, " ");
    char *param = strtok(NULL, " ");
    char *extra = strtok(NULL, " ");
    NickInfo *ni;
    int is_servadmin = is_cservice_member(u);
    int set_nick = 0;

    if (readonly) {
	notice_lang(s_NickServ, u, NICK_SET_DISABLED);
	return;
    }

    if (is_servadmin && extra && (ni = findnick(cmd))) {
	cmd = param;
	param = extra;
	extra = strtok(NULL, " ");
	set_nick = 1;
    } else {
	ni = u->ni;
    }
    if (!param || (stricmp(cmd,"HIDE")==0 && !extra)) {
	if (is_servadmin)
	    syntax_error(s_NickServ, u, "SET", NICK_SET_SERVADMIN_SYNTAX);
	else
	    syntax_error(s_NickServ, u, "SET", NICK_SET_SYNTAX);
    } else if (!ni) {
	notice_lang(s_NickServ, u, NICK_NOT_REGISTERED);
    } else if (ni->status & NS_VERBOTEN) {
	notice_lang(s_NickServ, u, NICK_X_FORBIDDEN, ni->nick);
    } else if (!is_servadmin && !nick_identified(u)) {
	notice_lang(s_NickServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
    } else if (stricmp(cmd, "PASSWORD") == 0) {
	do_set_password(u, set_nick ? ni : u->real_ni, param);
    } else if (stricmp(cmd, "LANGUAGE") == 0) {
	do_set_language(u, ni, param);
    } else if (stricmp(cmd, "URL") == 0) {
	do_set_url(u, set_nick ? ni : u->real_ni, param);
    } else if (stricmp(cmd, "EMAIL") == 0) {
	do_set_email(u, set_nick ? ni : u->real_ni, param);
    } else if (stricmp(cmd, "KILL") == 0) {
	do_set_kill(u, ni, param);
    } else if (stricmp(cmd, "SECURE") == 0) {
	do_set_secure(u, ni, param);
    } else if (stricmp(cmd, "PRIVATE") == 0) {
	do_set_private(u, ni, param);
    } else if (stricmp(cmd, "HIDE") == 0) {
	do_set_hide(u, ni, param, extra);
    } else if (stricmp(cmd, "NOEXPIRE") == 0) {
	do_set_noexpire(u, ni, param);
    } else {
	if (is_servadmin)
	    notice_lang(s_NickServ, u, NICK_SET_UNKNOWN_OPTION_OR_BAD_NICK,
			strupper(cmd));
	else
	    notice_lang(s_NickServ, u, NICK_SET_UNKNOWN_OPTION, strupper(cmd));
    }
}

/*************************************************************************/

static void do_unset(User *u)
{
    char *cmd   = strtok(NULL, " ");
    char *extra = strtok(NULL, " ");
    NickInfo *ni;
    int is_servadmin = is_cservice_member(u);
    int set_nick = 0;

    if (readonly) {
	notice_lang(s_NickServ, u, NICK_SET_DISABLED);
	return;
    }

    if (is_servadmin && extra && (ni = findnick(cmd))) {
	cmd = extra;
	extra = strtok(NULL, " ");
	set_nick = 1;
    } else {
	ni = u->ni;
    }
    if (!cmd || extra) {
	syntax_error(s_NickServ, u, "UNSET",
	    NSRequireEmail ? NICK_UNSET_SYNTAX_REQ_EMAIL : NICK_UNSET_SYNTAX);
    } else if (!ni) {
	notice_lang(s_NickServ, u, NICK_NOT_REGISTERED);
    } else if (ni->status & NS_VERBOTEN) {
	notice_lang(s_NickServ, u, NICK_X_FORBIDDEN, ni->nick);
    } else if (!is_servadmin && !nick_identified(u)) {
	notice_lang(s_NickServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
    } else if (stricmp(cmd, "URL") == 0) {
	do_set_url(u, set_nick ? ni : u->real_ni, NULL);
    } else if (stricmp(cmd, "EMAIL") == 0) {
	if (NSRequireEmail) {
	    if (set_nick)
		notice_lang(s_NickServ, u, NICK_UNSET_EMAIL_OTHER_BAD);
	    else
		notice_lang(s_NickServ, u, NICK_UNSET_EMAIL_BAD);
	} else {
	    do_set_email(u, set_nick ? ni : u->real_ni, NULL);
	}
    } else {
	syntax_error(s_NickServ, u, "UNSET",
	    NSRequireEmail ? NICK_UNSET_SYNTAX_REQ_EMAIL : NICK_UNSET_SYNTAX);
    }
}

/*************************************************************************/

static void do_set_password(User *u, NickInfo *ni, char *param)
{
    int len = strlen(param);

    if (NSSecureAdmins && u->real_ni != ni && !is_cservice_member(u)) {
	notice_lang(s_NickServ, u, PERMISSION_DENIED);
	return;
    } else if (stricmp(param, ni->nick) == 0 || (StrictPasswords && len < 5)) {
	notice_lang(s_NickServ, u, MORE_OBSCURE_PASSWORD);
	return;
    }

#ifdef USE_ENCRYPTION
    if (len > PASSMAX) {
	len = PASSMAX;
	param[len] = 0;
	notice_lang(s_NickServ, u, PASSWORD_TRUNCATED, PASSMAX);
    }
    if (encrypt(param, len, ni->pass, PASSMAX) < 0) {
	memset(param, 0, strlen(param));
	log("%s: Failed to encrypt password for %s (set)",
		s_NickServ, ni->nick);
	notice_lang(s_NickServ, u, NICK_SET_PASSWORD_FAILED);
	return;
    }
    memset(param, 0, strlen(param));
    notice_lang(s_NickServ, u, NICK_SET_PASSWORD_CHANGED);
#else
    if (strlen(param) > PASSMAX-1) /* -1 for null byte */
	notice_lang(s_NickServ, u, PASSWORD_TRUNCATED, PASSMAX-1);
    strscpy(ni->pass, param, PASSMAX);
    notice_lang(s_NickServ, u, NICK_SET_PASSWORD_CHANGED_TO, ni->pass);
#endif
    if (u->real_ni != ni) {
	log("%s: %s!%s@%s used SET PASSWORD as Services admin on %s",
		s_NickServ, u->nick, u->username, u->host, ni->nick);
	if (WallSetpass) {
	    wallops(s_NickServ, "\2%s\2 used SET PASSWORD as Services admin "
			"on \2%s\2", u->nick, ni->nick);
	}
    }

    db_nick_set(ni, "pass", ni->pass);

}

/*************************************************************************/

static void do_set_language(User *u, NickInfo *ni, char *param)
{
    int langnum;

    if (param[strspn(param, "0123456789")] != 0) {  /* i.e. not a number */
	syntax_error(s_NickServ, u, "SET LANGUAGE", NICK_SET_LANGUAGE_SYNTAX);
	return;
    }
    langnum = atoi(param)-1;
    if (langnum < 0 || langnum >= NUM_LANGS || langlist[langnum] < 0) {
	notice_lang(s_NickServ, u, NICK_SET_LANGUAGE_UNKNOWN,
		langnum+1, s_NickServ);
	return;
    }
    ni->language = langlist[langnum];

    db_nick_seti(ni, "language", ni->language);

    notice_lang(s_NickServ, u, NICK_SET_LANGUAGE_CHANGED);
}

/*************************************************************************/

static void do_set_url(User *u, NickInfo *ni, char *param)
{
    if (param && !valid_url(param)) {
	notice_lang(s_NickServ, u, BAD_URL);
	return;
    }

    if (ni->url)
	free(ni->url);
    if (param) {
	ni->url = sstrdup(param);
        db_nick_set(ni, "url", ni->url);
	notice_lang(s_NickServ, u, NICK_SET_URL_CHANGED, ni->nick, param);
    } else {
	ni->url = NULL;
        db_nick_set(ni, "url", NULL);
	notice_lang(s_NickServ, u, NICK_UNSET_URL, ni->nick);
    }
}

/*************************************************************************/

static void do_set_email(User *u, NickInfo *ni, char *param)
{
    if (param && !valid_email(param)) {
	notice_lang(s_NickServ, u, BAD_EMAIL);
	return;
    }

    if (ni->email)
	free(ni->email);
    if (param) {
	ni->email = sstrdup(param);
        db_nick_set(ni, "email", ni->email);
	log("%s: %s E-mail address changed to %s by %s!%s@%s",
	    s_NickServ, ni->nick, param, u->nick, u->username, u->host);
	notice_lang(s_NickServ, u, NICK_SET_EMAIL_CHANGED, ni->nick,param);
    } else {
	ni->email = NULL;
        db_nick_set(ni, "email", NULL);
	log("%s: %s E-mail address cleared by %s!%s@%s",
	    s_NickServ, ni->nick, u->nick, u->username, u->host);
	notice_lang(s_NickServ, u, NICK_UNSET_EMAIL, ni->nick);
    }
}

/*************************************************************************/

static void do_set_kill(User *u, NickInfo *ni, char *param)
{
    if (stricmp(param, "ON") == 0) {
	ni->flags |= NI_KILLPROTECT;
	ni->flags &= ~(NI_KILL_QUICK | NI_KILL_IMMED);
        db_nick_seti(ni, "flags", ni->flags);
	notice_lang(s_NickServ, u, NICK_SET_KILL_ON);
    } else if (stricmp(param, "QUICK") == 0) {
	ni->flags |= NI_KILLPROTECT | NI_KILL_QUICK;
	ni->flags &= ~NI_KILL_IMMED;
        db_nick_seti(ni, "flags", ni->flags);
	notice_lang(s_NickServ, u, NICK_SET_KILL_QUICK);
    } else if (stricmp(param, "IMMED") == 0) {
	if (NSAllowKillImmed) {
	    ni->flags |= NI_KILLPROTECT | NI_KILL_IMMED;
	    ni->flags &= ~NI_KILL_QUICK;
            db_nick_seti(ni, "flags", ni->flags);
	    notice_lang(s_NickServ, u, NICK_SET_KILL_IMMED);
	} else {
	    notice_lang(s_NickServ, u, NICK_SET_KILL_IMMED_DISABLED);
	}
    } else if (stricmp(param, "OFF") == 0) {
	ni->flags &= ~(NI_KILLPROTECT | NI_KILL_QUICK | NI_KILL_IMMED);
        db_nick_seti(ni, "flags", ni->flags);
	notice_lang(s_NickServ, u, NICK_SET_KILL_OFF);
    } else {
	syntax_error(s_NickServ, u, "SET KILL",
		NSAllowKillImmed ? NICK_SET_KILL_IMMED_SYNTAX
		                 : NICK_SET_KILL_SYNTAX);
    }
}

/*************************************************************************/

static void do_set_secure(User *u, NickInfo *ni, char *param)
{
    if (stricmp(param, "ON") == 0) {
	ni->flags |= NI_SECURE;
        db_nick_seti(ni, "flags", ni->flags);
	notice_lang(s_NickServ, u, NICK_SET_SECURE_ON);
    } else if (stricmp(param, "OFF") == 0) {
	ni->flags &= ~NI_SECURE;
        db_nick_seti(ni, "flags", ni->flags);
	notice_lang(s_NickServ, u, NICK_SET_SECURE_OFF);
    } else {
	syntax_error(s_NickServ, u, "SET SECURE", NICK_SET_SECURE_SYNTAX);
    }
}

/*************************************************************************/

static void do_set_private(User *u, NickInfo *ni, char *param)
{
    if (stricmp(param, "ON") == 0) {
	ni->flags |= NI_PRIVATE;
        db_nick_seti(ni, "flags", ni->flags);
	notice_lang(s_NickServ, u, NICK_SET_PRIVATE_ON);
    } else if (stricmp(param, "OFF") == 0) {
	ni->flags &= ~NI_PRIVATE;
        db_nick_seti(ni, "flags", ni->flags);
	notice_lang(s_NickServ, u, NICK_SET_PRIVATE_OFF);
    } else {
	syntax_error(s_NickServ, u, "SET PRIVATE", NICK_SET_PRIVATE_SYNTAX);
    }
}

/*************************************************************************/

static void do_set_hide(User *u, NickInfo *ni, char *param, char *setting)
{
    int flag, onmsg, offmsg;

    if (stricmp(param, "EMAIL") == 0) {
	flag = NI_HIDE_EMAIL;
	onmsg = NICK_SET_HIDE_EMAIL_ON;
	offmsg = NICK_SET_HIDE_EMAIL_OFF;
    } else if (stricmp(param, "USERMASK") == 0) {
	flag = NI_HIDE_MASK;
	onmsg = NICK_SET_HIDE_MASK_ON;
	offmsg = NICK_SET_HIDE_MASK_OFF;
    } else if (stricmp(param, "QUIT") == 0) {
	flag = NI_HIDE_QUIT;
	onmsg = NICK_SET_HIDE_QUIT_ON;
	offmsg = NICK_SET_HIDE_QUIT_OFF;
    } else {
	syntax_error(s_NickServ, u, "SET HIDE", NICK_SET_HIDE_SYNTAX);
	return;
    }
    if (stricmp(setting, "ON") == 0) {
	ni->flags |= flag;
        db_nick_seti(ni, "flags", ni->flags);
	notice_lang(s_NickServ, u, onmsg, s_NickServ);
    } else if (stricmp(setting, "OFF") == 0) {
	ni->flags &= ~flag;
        db_nick_seti(ni, "flags", ni->flags);
	notice_lang(s_NickServ, u, offmsg, s_NickServ);
    } else {
	syntax_error(s_NickServ, u, "SET HIDE", NICK_SET_HIDE_SYNTAX);
    }
}

/*************************************************************************/

static void do_set_noexpire(User *u, NickInfo *ni, char *param)
{
    if ((ca = cs_findchan(CSChan)) && get_access(u,ca) < 800) {
	notice_lang(s_NickServ, u, PERMISSION_DENIED);
	return;
    }
    if (!param) {
	syntax_error(s_NickServ, u, "SET NOEXPIRE", NICK_SET_NOEXPIRE_SYNTAX);
	return;
    }
    if (stricmp(param, "ON") == 0) {
	ni->status |= NS_NOEXPIRE;
        db_nick_seti(ni, "status", ni->status);
	notice_lang(s_NickServ, u, NICK_SET_NOEXPIRE_ON, ni->nick);
    } else if (stricmp(param, "OFF") == 0) {
	ni->status &= ~NS_NOEXPIRE;
        db_nick_seti(ni, "status", ni->status);
	notice_lang(s_NickServ, u, NICK_SET_NOEXPIRE_OFF, ni->nick);
    } else {
	syntax_error(s_NickServ, u, "SET NOEXPIRE", NICK_SET_NOEXPIRE_SYNTAX);
    }
}

/*************************************************************************/

static void do_access(User *u)
{
    char *cmd = strtok(NULL, " ");
    char *mask = strtok(NULL, " ");
    NickInfo *ni;
    int i;
    char **access;

    if (cmd && stricmp(cmd, "LIST") == 0 && mask && ((ca = cs_findchan(CSChan)) && get_access(u,ca) >= ACCLEV_HELPER)) {
	ni = findnick(mask);
	if (!ni) {
	    notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, mask);
	    return;
	}
	ni = getlink(ni);
	notice_lang(s_NickServ, u, NICK_ACCESS_LIST_X, mask);
	for (access = ni->access, i = 0; i < ni->accesscount; access++, i++)
	    notice(s_NickServ, u->nick, "    %s", *access);

    } else if (!cmd || ((stricmp(cmd,"LIST")==0) ? mask!=NULL : mask==NULL)) {
	syntax_error(s_NickServ, u, "ACCESS", NICK_ACCESS_SYNTAX);

    } else if (mask && !strchr(mask, '@')) {
	notice_lang(s_NickServ, u, BAD_USERHOST_MASK);
	notice_lang(s_NickServ, u, MORE_INFO, s_NickServ, "ACCESS");

    } else if (!(ni = u->ni)) {
	notice_lang(s_NickServ, u, NICK_NOT_REGISTERED);

    } else if (!nick_identified(u)) {
	notice_lang(s_NickServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);

    } else if (stricmp(cmd, "ADD") == 0) {
	if (ni->accesscount >= NSAccessMax) {
	    notice_lang(s_NickServ, u, NICK_ACCESS_REACHED_LIMIT, NSAccessMax);
	    return;
	}
	for (access = ni->access, i = 0; i < ni->accesscount; access++, i++) {
	    if (stricmp(*access, mask) == 0) {
		notice_lang(s_NickServ, u,
			NICK_ACCESS_ALREADY_PRESENT, *access);
		return;
	    }
	}
	ni->accesscount++;
	ni->access = srealloc(ni->access, sizeof(char *) * ni->accesscount);
	ni->access[ni->accesscount-1] = sstrdup(mask);
	notice_lang(s_NickServ, u, NICK_ACCESS_ADDED, mask);

    } else if (stricmp(cmd, "DEL") == 0) {
	/* First try for an exact match; then, a case-insensitive one. */
	for (access = ni->access, i = 0; i < ni->accesscount; access++, i++) {
	    if (strcmp(*access, mask) == 0)
		break;
	}
	if (i == ni->accesscount) {
	    for (access = ni->access, i = 0; i < ni->accesscount;
							access++, i++) {
		if (stricmp(*access, mask) == 0)
		    break;
	    }
	}
	if (i == ni->accesscount) {
	    notice_lang(s_NickServ, u, NICK_ACCESS_NOT_FOUND, mask);
	    return;
	}
	notice_lang(s_NickServ, u, NICK_ACCESS_DELETED, *access);
	free(*access);
	ni->accesscount--;
	if (i < ni->accesscount)	/* if it wasn't the last entry... */
	    memmove(access, access+1, (ni->accesscount-i) * sizeof(char *));
	if (ni->accesscount)		/* if there are any entries left... */
	    ni->access = srealloc(ni->access, ni->accesscount * sizeof(char *));
	else {
	    free(ni->access);
	    ni->access = NULL;
	}

    } else if (stricmp(cmd, "LIST") == 0) {
	notice_lang(s_NickServ, u, NICK_ACCESS_LIST);
	for (access = ni->access, i = 0; i < ni->accesscount; access++, i++)
	    notice(s_NickServ, u->nick, "    %s", *access);

    } else {
	syntax_error(s_NickServ, u, "ACCESS", NICK_ACCESS_SYNTAX);

    }
}

/*************************************************************************/

static void do_link(User *u)
{
    char *nick = strtok(NULL, " ");
    char *pass = strtok(NULL, " ");
    NickInfo *ni = u->real_ni, *target;
    int res;

    if (!NSMaxLinkDepth) {
	notice_lang(s_NickServ, u, NICK_LINK_DISABLED);
	return;
    }

    if (!pass) {
	syntax_error(s_NickServ, u, "LINK", NICK_LINK_SYNTAX);

    } else if (!ni) {
	notice_lang(s_NickServ, u, NICK_NOT_REGISTERED);

    } else if (!nick_identified(u)) {
	notice_lang(s_NickServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);

    } else if (!(target = findnick(nick))) {
	notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);

    } else if (target == ni) {
	notice_lang(s_NickServ, u, NICK_NO_LINK_SAME, nick);

    } else if (target->status & NS_VERBOTEN) {
	notice_lang(s_NickServ, u, NICK_X_FORBIDDEN, nick);

    } else if (!(res = check_password(pass, target->pass))) {
	log("%s: LINK: bad password for %s by %s!%s@%s",
		s_NickServ, nick, u->nick, u->username, u->host);
	nick_bad_password(u, target);

    } else if (res == -1) {
	notice_lang(s_NickServ, u, NICK_LINK_FAILED);

    } else {
	NickInfo *tmp, *top;
	int depth;

	target->bad_passwords = 0;

	/* Get the top-level nick.  This also has the side effect of
	 * ensuring we're not about to run into an infinite loop
	 * (getlink() will check that for us). */
	top = getlink(target);

	/* Make sure they're not trying to make a circular or deep link */
	depth = 0;
	for (tmp = target; tmp; tmp = tmp->link) {
	    if (tmp == ni) {
		notice_lang(s_NickServ, u, NICK_LINK_CIRCULAR, nick);
		return;
	    }
	    depth++;
	}
	if (depth > NSMaxLinkDepth) {
	    notice_lang(s_NickServ, u, NICK_LINK_TOO_DEEP, NSMaxLinkDepth);
	    return;
	}

	/* Check for exceeding the channel registration limit. */
	top->channelcount += ni->channelcount;
	res = check_channel_limit(top);
	top->channelcount -= ni->channelcount;
	if (res >= 0) {
	    notice_lang(s_NickServ, u, NICK_LINK_TOO_MANY_CHANNELS, nick,
			top->channelmax ? top->channelmax : MAX_CHANNELCOUNT);
	    return;
	}

	/* If this nick already has a link, break it */
	if (ni->link)
	    delink(ni);

	ni->link = target;
	target->linkcount++;
	do {
	    target->channelcount += ni->channelcount;
	    if (target->link)
		target = target->link;
	} while (target->link);
	if (ni->access) {
	    int i;
	    for (i = 0; i < ni->accesscount; i++) {
		if (ni->access[i])
		    free(ni->access[i]);
	    }
	    free(ni->access);
	    ni->access = NULL;
	    ni->accesscount = 0;
	}
	link_fix_users();
	log("%s: %s!%s@%s linked nick %s to %s", s_NickServ, u->nick,
			u->username, u->host, u->nick, nick);
	notice_lang(s_NickServ, u, NICK_LINKED, nick);
	/* They gave the password, so they might as well have IDENTIFY'd...
	 * but don't set NS_IDENTIFIED if someone else is using the nick! */
	if (!finduser(top->nick))
	    top->status |= NS_IDENTIFIED;
    }
}

/*************************************************************************/

static void do_unlink(User *u)
{
    NickInfo *ni;
    char *linkname;
    char *nick = strtok(NULL, " ");
    char *pass = strtok(NULL, " ");
    int res = 0;

    if (nick) {
	int is_servadmin = is_cservice_member(u);
	ni = findnick(nick);
	if (!ni) {
	    notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);
	} else if (!ni->link) {
	    notice_lang(s_NickServ, u, NICK_X_NOT_LINKED, nick);
	} else if (!is_servadmin && !pass) {
	    syntax_error(s_NickServ, u, "UNLINK", NICK_UNLINK_SYNTAX);
	} else if (!is_servadmin &&
				!(res = check_password(pass, ni->pass))) {
	    log("%s: UNLINK: bad password for %s by %s!%s@%s",
		s_NickServ, nick, u->nick, u->username, u->host);
	    nick_bad_password(u, ni);
	} else if (res == -1) {
	    notice_lang(s_NickServ, u, NICK_UNLINK_FAILED);
	} else {
	    ni->bad_passwords = 0;
	    linkname = ni->link->nick;
	    delink(ni);
	    link_fix_users();
	    notice_lang(s_NickServ, u, NICK_X_UNLINKED, ni->nick, linkname);
	    log("%s: %s!%s@%s unlinked nick %s from %s", s_NickServ, u->nick,
			u->username, u->host, ni->nick, linkname);
	}
    } else {
	ni = u->real_ni;
	if (!ni)
	    notice_lang(s_NickServ, u, NICK_NOT_REGISTERED);
	else if (!nick_identified(u))
	    notice_lang(s_NickServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
	else if (!ni->link)
	    notice_lang(s_NickServ, u, NICK_NOT_LINKED);
	else {
	    linkname = ni->link->nick;
	    u->ni = ni;  /* Effective nick now the same as real nick */
	    delink(ni);
	    link_fix_users();
	    notice_lang(s_NickServ, u, NICK_UNLINKED, linkname);
	    log("%s: %s!%s@%s unlinked nick %s from %s", s_NickServ, u->nick,
			u->username, u->host, u->nick, linkname);
	}
    }
}

/*************************************************************************/

static void do_listlinks(User *u)
{
    char *nick = strtok(NULL, " ");
    char *param = strtok(NULL, " ");
    NickInfo *ni, *ni2;
    int count = 0;

    if (!nick || (param && stricmp(param, "ALL") != 0)) {
	syntax_error(s_NickServ, u, "LISTLINKS", NICK_LISTLINKS_SYNTAX);

    } else if (!(ni = findnick(nick))) {
	notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);

    } else if (ni->status & NS_VERBOTEN) {
	notice_lang(s_NickServ, u, NICK_X_FORBIDDEN, ni->nick);

    } else {
	if (param)
	    ni = getlink(ni);

	notice_lang(s_NickServ, u, NICK_LISTLINKS_HEADER, ni->nick);

	for (ni2 = firstnick(); ni2; ni2 = nextnick()) {
	    if (ni2 == ni)
		continue;
	    if (param ? getlink(ni2) == ni : ni2->link == ni) {
		if (ni2->link == ni)
		    notice_lang(s_NickServ, u, NICK_X_IS_LINKED, ni2->nick);
		else
		    notice_lang(s_NickServ, u, NICK_X_IS_LINKED_VIA_X,
				ni2->nick, ni2->link->nick);
		count++;
	    }
	}
	notice_lang(s_NickServ, u, NICK_LISTLINKS_FOOTER, count);
    }
}

/*************************************************************************/

/* Show hidden info to nick owners and sadmins when the "ALL" parameter is
 * supplied. If a nick is online, the "Last seen address" changes to "Is
 * online from".
 * Syntax: INFO <nick> {ALL}
 * -TheShadow (13 Mar 1999)
 */

/* Check the status of show_all and make a note of having done so.  This is
 * used at the end, to see whether we should print a "use ALL for more info"
 * message.  Note that this should be the last test in a boolean expression,
 * to ensure that used_all isn't set inappropriately. */
#define CHECK_SHOW_ALL (used_all++, show_all)

static void do_info(User *u)
{
    char *nick = strtok(NULL, " ");
    char *param = strtok(NULL, " ");
    NickInfo *ni, *link;

    if (!nick) {
    	syntax_error(s_NickServ, u, "INFO", NICK_INFO_SYNTAX);

    } else if (!(ni = findnick(nick))) {
	notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);

    } else if (ni->status & NS_VERBOTEN) {
	notice_lang(s_NickServ, u, NICK_X_FORBIDDEN, nick);

    } else {
	struct tm *tm;
	char buf[BUFSIZE], *end;
	const char *commastr = getstring(u->ni, COMMA_SPACE);
	int need_comma = 0;
	int nick_online = 0;
	int can_show_all = 0, show_all = 0, used_all = 0;

	/* Is the real owner of the nick we're looking up online? -TheShadow */
	if (finduser(nick) && (ni->status & (NS_IDENTIFIED | NS_RECOGNIZED)))
	    nick_online = 1;

        /* Only show hidden fields to owner and sadmins and only when the ALL
	 * parameter is used. -TheShadow */
	can_show_all = ((nick_online && (irc_stricmp(u->nick, nick) == 0)) ||
			((ca = cs_findchan(CSChan)) && get_access(u,ca) >= ACCLEV_HELPER));
		    
        if (can_show_all && (param && stricmp(param, "ALL") == 0))
            show_all = 1;

	link = getlink(ni);

	notice_lang(s_NickServ, u, NICK_INFO_REALNAME,
		    nick, ni->last_realname);

	if (nick_online) {
	    if (!(link->flags & NI_HIDE_MASK) || CHECK_SHOW_ALL)
		notice_lang(s_NickServ, u, NICK_INFO_ADDRESS_ONLINE,
			    ni->last_usermask);
	    else
		notice_lang(s_NickServ, u, NICK_INFO_ADDRESS_ONLINE_NOHOST,
			    ni->nick);

	} else {
	    if (!(link->flags & NI_HIDE_MASK) || CHECK_SHOW_ALL)
		notice_lang(s_NickServ, u, NICK_INFO_ADDRESS,
			    ni->last_usermask);

            tm = localtime(&ni->last_seen);
            strftime_lang(buf, sizeof(buf), u, STRFTIME_DATE_TIME_FORMAT, tm);
            notice_lang(s_NickServ, u, NICK_INFO_LAST_SEEN, buf);
	}

	tm = localtime(&ni->time_registered);
	strftime_lang(buf, sizeof(buf), u, STRFTIME_DATE_TIME_FORMAT, tm);
	notice_lang(s_NickServ, u, NICK_INFO_TIME_REGGED, buf);
	if (ni->last_quit && (!(link->flags & NI_HIDE_QUIT) || CHECK_SHOW_ALL))
	    notice_lang(s_NickServ, u, NICK_INFO_LAST_QUIT, ni->last_quit);
	if (ni->url)
	    notice_lang(s_NickServ, u, NICK_INFO_URL, ni->url);
	if (ni->email && (!(link->flags & NI_HIDE_EMAIL) || CHECK_SHOW_ALL))
	    notice_lang(s_NickServ, u, NICK_INFO_EMAIL, ni->email);
	*buf = 0;
	end = buf;
	if (link->flags & NI_KILLPROTECT) {
	    end += snprintf(end, sizeof(buf)-(end-buf), "%s",
			    getstring(u->ni, NICK_INFO_OPT_KILL));
	    need_comma = 1;
	}
	if (link->flags & NI_SECURE) {
	    end += snprintf(end, sizeof(buf)-(end-buf), "%s%s",
			    need_comma ? commastr : "",
			    getstring(u->ni, NICK_INFO_OPT_SECURE));
	    need_comma = 1;
	}
	if (link->flags & NI_PRIVATE) {
	    end += snprintf(end, sizeof(buf)-(end-buf), "%s%s",
			    need_comma ? commastr : "",
			    getstring(u->ni, NICK_INFO_OPT_PRIVATE));
	    need_comma = 1;
	}
	notice_lang(s_NickServ, u, NICK_INFO_OPTIONS,
		    *buf ? buf : getstring(u->ni, NICK_INFO_OPT_NONE));

	if (ni->link && CHECK_SHOW_ALL)
	    notice_lang(s_NickServ, u, NICK_INFO_LINKED_TO, ni->link->nick);

	if ((ni->status & NS_NOEXPIRE) && CHECK_SHOW_ALL)
	    notice_lang(s_NickServ, u, NICK_INFO_NO_EXPIRE);

	if (link->suspendinfo) {
	    notice_lang(s_NickServ, u, NICK_X_SUSPENDED, nick);
	    if (CHECK_SHOW_ALL) {
		SuspendInfo *si = link->suspendinfo;
		char timebuf[BUFSIZE], expirebuf[BUFSIZE];

		tm = localtime(&si->suspended);
		strftime_lang(timebuf, sizeof(timebuf), u,
			      STRFTIME_DATE_TIME_FORMAT, tm);
		expires_in_lang(expirebuf, sizeof(expirebuf), u->ni,
				si->expires);
		notice_lang(s_NickServ, u, NICK_INFO_SUSPEND_DETAILS,
			    si->who, timebuf, expirebuf);
		notice_lang(s_NickServ, u, NICK_INFO_SUSPEND_REASON,
			    si->reason);
	    }
	}

	if (can_show_all && !show_all && used_all)
	    notice_lang(s_NickServ, u, NICK_INFO_SHOW_ALL, s_NickServ,
			ni->nick);
    }
}

/*************************************************************************/

static void do_genpass(User *u) {
  char *nick = strtok(NULL, " ");
  NickInfo *ni = NULL;

  if (!is_cservice_helper(u)) {
    notice_lang(s_NickServ, u, PERMISSION_DENIED);
    return;
  }
  if (!nick_identified(u)) {
    notice_lang(s_NickServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
    return;
  }
  if (!nick) {
    notice_lang(s_NickServ, u, NICK_GENPASS_SYNTAX);
    return;
  }
  if (!(ni = findnick(nick))) {
    notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);
    return;
  }
  if (ni->status & NS_VERBOTEN) {
    notice_lang(s_NickServ, u, NICK_X_FORBIDDEN, ni->nick);
    return;
  } 

  genpass(ni->pass);
  email_pass(ni->email, ni->pass, ni->nick);

#ifdef USE_ENCRYPTION
  encrypt_in_place(ni->pass, PASSMAX - 1);
#endif

  db_nick_set(ni, "pass", ni->pass); 
  notice_lang(s_NickServ, u, NICK_GENPASS_OK, ni->email);

}

static void do_listchans(User *u)
{
    NickInfo *ni;

    if (is_cservice_member(u)) {
	char *nick = strtok(NULL, " ");
	if (nick) {
	    ni = findnick(nick);
	    if (!ni) {
		notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);
		return;
	    }
	} else {
	    ni = u->real_ni;
	}
    } else {
	ni = u->real_ni;
	if (!ni) {
	    notice_lang(s_NickServ, u, NICK_NOT_REGISTERED);
	    return;
	}
    }
    if (ni->status & NS_VERBOTEN) {
	notice_lang(s_NickServ, u, NICK_X_FORBIDDEN, ni->nick);
    } else if (!nick_identified(u)) {
	notice_lang(s_NickServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
    } else if (!ni->foundercount) {
	notice_lang(s_NickServ, u, NICK_LISTCHANS_NONE, ni->nick);
    } else {
	int i;
	notice_lang(s_NickServ, u, NICK_LISTCHANS_HEADER, ni->nick);
	for (i = 0; i < ni->foundercount; i++) 
	    notice_lang(s_NickServ, u, NICK_LISTCHANS_ENTRY,
			ni->founderchans[i]->name);
	notice_lang(s_NickServ, u, NICK_LISTCHANS_END, ni->foundercount);
    }
}

/*************************************************************************/

static void do_list(User *u)
{
    char *pattern = strtok(NULL, " ");
    char *keyword;
    NickInfo *ni, *link;
    int nnicks;
    char buf[BUFSIZE];
    int is_servadmin = is_cservice_member(u);
    int16 match_NS = 0; /* NS_ flags a nick must match one of to qualify */
    int32 match_NI = 0; /* NI_ flags a nick must match one of to qualify */
    int match_susp = 0; /* 1 if we match on suspended nicks */

    if (NSListOpersOnly && !is_oper_u(u)) {
	notice_lang(s_NickServ, u, PERMISSION_DENIED);
	return;
    }

    if (!pattern) {
	syntax_error(s_NickServ, u, "LIST",
		is_servadmin ? NICK_LIST_SERVADMIN_SYNTAX : NICK_LIST_SYNTAX);
    } else {
	nnicks = 0;

	while (is_servadmin && (keyword = strtok(NULL, " "))) {
	    if (stricmp(keyword, "FORBIDDEN") == 0)
		match_NS |= NS_VERBOTEN;
	    if (stricmp(keyword, "NOEXPIRE") == 0)
		match_NS |= NS_NOEXPIRE;
	    if (stricmp(keyword, "SUSPENDED") == 0)
		match_susp = 1;
	}

	notice_lang(s_NickServ, u, NICK_LIST_HEADER, pattern);
	for (ni = firstnick(); ni; ni = nextnick()) {
	    link = getlink(ni);
	    if (!is_servadmin && ((ni->flags & NI_PRIVATE)
				  || (ni->status & NS_VERBOTEN)))
		continue;
	    if (match_NI || match_NS || match_susp)
		/* ok, we have flags, now see if they match */
		if (!((ni->status & match_NS) || (link->flags & match_NI)
		      || (link->suspendinfo && match_susp)))
		    continue;
	    if (!is_servadmin && (ni->flags & NI_HIDE_MASK)) {
		snprintf(buf, sizeof(buf), "%-20s  [Hidden]",ni->nick);
	    } else if (ni->status & NS_VERBOTEN) {
		snprintf(buf, sizeof(buf), "%-20s  [Forbidden]",
			 ni->nick);
	    } else {
		snprintf(buf, sizeof(buf), "%-20s  %s",
			 ni->nick, ni->last_usermask);
	    }
	    if (irc_stricmp(pattern, ni->nick) == 0
	     || match_wild_nocase(pattern, buf)
	    ) {
		if (++nnicks <= NSListMax) {
		    char noexpire_char = ' ';
		    char suspended_char = ' ';
		    if (is_servadmin) {
			if (ni->status & NS_NOEXPIRE)
			    noexpire_char = '!';
			if (link->suspendinfo)
			    suspended_char = '*';
		    }
		    notice(s_NickServ, u->nick, "   %c%c %s",
			   suspended_char, noexpire_char, buf);
		}
	    }
	}
	notice_lang(s_NickServ, u, NICK_LIST_RESULTS,
			nnicks>NSListMax ? NSListMax : nnicks, nnicks);
    }
}

/*************************************************************************/

#ifdef DISABLED
static void do_recover(User *u)
{
    char *nick = strtok(NULL, " ");
    char *pass = strtok(NULL, " ");
    NickInfo *ni;
    User *u2;

    if (!nick) {
	syntax_error(s_NickServ, u, "RECOVER", NICK_RECOVER_SYNTAX);
    } else if (!(u2 = finduser(nick))) {
	notice_lang(s_NickServ, u, NICK_X_NOT_IN_USE, nick);
    } else if (!(ni = u2->real_ni)) {
	notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);
    } else if (ni->status & NS_GUESTED) {
	notice_lang(s_NickServ, u, NICK_X_NOT_IN_USE, nick);
    } else if (irc_stricmp(nick, u->nick) == 0) {
	notice_lang(s_NickServ, u, NICK_NO_RECOVER_SELF);
    } else if (pass) {
	int res = check_password(pass, ni->pass);
	if (res == 1) {
	    ni->bad_passwords = 0;
	    collide(ni, 0);
	    notice_lang(s_NickServ, u, NICK_RECOVERED, s_NickServ, nick);
	} else {
	    if (res == 0) {
		log("%s: RECOVER: invalid password for %s by %s!%s@%s",
		    s_NickServ, nick, u->nick, u->username, u->host);
		nick_bad_password(u, ni);
	    } else { /* res == -1 */
		log("%s: RECOVER: check_password failed for %s",
		    s_NickServ, nick);
		notice_lang(s_NickServ, u, ACCESS_DENIED);
	    }
	}
    } else {
	if (!(ni->flags & NI_SECURE) && is_on_access(u, ni)) {
	    collide(ni, 0);
	    notice_lang(s_NickServ, u, NICK_RECOVERED, s_NickServ, nick);
	} else {
	    notice_lang(s_NickServ, u, ACCESS_DENIED);
	}
    }
}
#endif

/*************************************************************************/

#ifdef DISABLED
static void do_release(User *u)
{
    char *nick = strtok(NULL, " ");
    char *pass = strtok(NULL, " ");
    NickInfo *ni;

    if (!nick) {
	syntax_error(s_NickServ, u, "RELEASE", NICK_RELEASE_SYNTAX);
    } else if (!(ni = findnick(nick))) {
	notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);
    } else if (!(ni->status & NS_KILL_HELD)) {
	notice_lang(s_NickServ, u, NICK_RELEASE_NOT_HELD, nick);
    } else if (pass) {
	int res = check_password(pass, ni->pass);
	if (res == 1) {
	    ni->bad_passwords = 0;
	    release(ni, 0);
	    notice_lang(s_NickServ, u, NICK_RELEASED);
	} else {
	    if (res == 0) {
		log("%s: RELEASE: invalid password for %s by %s!%s@%s",
		    s_NickServ, nick, u->nick, u->username, u->host);
		nick_bad_password(u, ni);
	    } else { /* res == -1 */
		log("%s: RELEASE: check_password failed for %s",
		    s_NickServ, nick);
		notice_lang(s_NickServ, u, ACCESS_DENIED);
	    }
	}
    } else {
	if (!(ni->flags & NI_SECURE) && is_on_access(u, ni)) {
	    release(ni, 0);
	    notice_lang(s_NickServ, u, NICK_RELEASED);
	} else {
	    notice_lang(s_NickServ, u, ACCESS_DENIED);
	}
    }
}
#endif

/*************************************************************************/

static void do_ghost(User *u)
{
    char *nick = strtok(NULL, " ");
    char *pass = strtok(NULL, " ");
    NickInfo *ni;
    User *u2;

    if (!nick) {
	syntax_error(s_NickServ, u, "GHOST", NICK_GHOST_SYNTAX);
    } else if (!(u2 = finduser(nick))) {
	notice_lang(s_NickServ, u, NICK_X_NOT_IN_USE, nick);
    } else if (!(ni = u2->real_ni)) {
	notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);
    } else if (ni->status & NS_GUESTED) {
	notice_lang(s_NickServ, u, NICK_X_NOT_IN_USE, nick);
    } else if (irc_stricmp(nick, u->nick) == 0) {
	notice_lang(s_NickServ, u, NICK_NO_GHOST_SELF);
    } else if (pass) {
	int res = check_password(pass, ni->pass);
	if (res == 1) {
	    char buf[NICKMAX+32];
	    ni->bad_passwords = 0;
	    snprintf(buf, sizeof(buf), "GHOST command used by %s", u->nick);
	    kill_user(s_NickServ, nick, buf);
	    notice_lang(s_NickServ, u, NICK_GHOST_KILLED, nick);
	} else {
	    if (res == 0) {
		log("%s: GHOST: invalid password for %s by %s!%s@%s",
		    s_NickServ, nick, u->nick, u->username, u->host);
		nick_bad_password(u, ni);
	    } else { /* res == -1 */
		log("%s: GHOST: check_password failed for %s",
		    s_NickServ, nick);
		notice_lang(s_NickServ, u, ACCESS_DENIED);
	    }
	}
    } else {
	if (!(ni->flags & NI_SECURE) && is_on_access(u, ni)) {
	    char buf[NICKMAX+32];
	    snprintf(buf, sizeof(buf), "GHOST command used by %s", u->nick);
	    kill_user(s_NickServ, nick, buf);
	    notice_lang(s_NickServ, u, NICK_GHOST_KILLED, nick);
	} else {
	    notice_lang(s_NickServ, u, ACCESS_DENIED);
	}
    }
}

/*************************************************************************/

static void do_status(User *u)
{
    char *nick;
    User *u2;
    int i = 0;

    while ((nick = strtok(NULL, " ")) && (i++ < 16)) {
	if (!(u2 = finduser(nick)))
	    notice(s_NickServ, u->nick, "STATUS %s 0", nick);
	else if (nick_identified(u2))
	    notice(s_NickServ, u->nick, "STATUS %s 3", nick);
	else if (nick_recognized(u2))
	    notice(s_NickServ, u->nick, "STATUS %s 2", nick);
	else
	    notice(s_NickServ, u->nick, "STATUS %s 1", nick);
    }
}

/*************************************************************************/

static void do_getpass(User *u)
{
#ifndef USE_ENCRYPTION
    char *nick = strtok(NULL, " ");
    NickInfo *ni;
#endif

    /* Assumes that permission checking has already been done. */
#ifdef USE_ENCRYPTION
    notice_lang(s_NickServ, u, NICK_GETPASS_UNAVAILABLE);
#else
    if (!nick) {
	syntax_error(s_NickServ, u, "GETPASS", NICK_GETPASS_SYNTAX);
    } else if (!(ca = cs_findchan(CSChan))) {
        return;	
    } else if (!u || (get_access(u,ca) == 0)) {
        notice(s_ChanServ,u->nick,"Do i know you?");
        return;
    } else if (get_access(u,ca) < ACCLEV_HELPER) {
        notice(s_ChanServ,u->nick,"Sorry you dont have rights to do that");
        return;
    } else if (!(ni = findnick(nick))) {
	notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);
    } else {
	log("%s: %s!%s@%s used GETPASS on %s",
		s_NickServ, u->nick, u->username, u->host, nick);
	if (WallGetpass)
	wallops(s_NickServ, "\2%s\2 used GETPASS on \2%s\2", u->nick, nick);
	notice_lang(s_NickServ, u, NICK_GETPASS_PASSWORD_IS, nick, ni->pass);
    }
#endif
}

/*************************************************************************/

static void do_forbid(User *u)
{
    NickInfo *ni;
    char *nick = strtok(NULL, " ");
    User *u2;

    /* Assumes that permission checking has already been done. */
    if (!nick) {
	syntax_error(s_NickServ, u, "FORBID", NICK_FORBID_SYNTAX);
	return;
    }
    
    u2 = finduser(nick);
    
    if ((ni = findnick(nick)) != NULL) {
        if (!u || (get_access(u,ca) == 0)) {
            notice(s_ChanServ,u->nick,"Do i know you?");
            return;
        } else if (get_access(u,ca) < ACCLEV_HELPER) {
            notice(s_ChanServ,u->nick,"Sorry you dont have rights to do that");
            return;
	}
	delnick(ni);
	if (u2)
	    u2->ni = u2->real_ni = NULL;
    }

    if (readonly)
	notice_lang(s_NickServ, u, READ_ONLY_MODE);
    ni = makenick(nick);
    if (ni) {
	ni->status |= NS_VERBOTEN;
	ni->language = DEF_LANGUAGE;
	log("%s: %s set FORBID for nick %s", s_NickServ, u->nick, nick);
	notice_lang(s_NickServ, u, NICK_FORBID_SUCCEEDED, nick);
	/* If someone is using the nick, make them stop */
	if (u2) {
	    u2->ni = u2->real_ni = ni;
	    validate_user(u2);
	}
    } else {
	log("%s: Valid FORBID for %s by %s failed", s_NickServ,
		nick, u->nick);
	notice_lang(s_NickServ, u, NICK_FORBID_FAILED, nick);
    }
}

/*************************************************************************/

static void do_suspend(User *u)
{
    NickInfo *ni, *link;
    char *expiry, *nick, *reason;
    time_t expires;

    nick = strtok(NULL, " ");
    if (nick && *nick == '+') {
	expiry = nick;
	nick = strtok(NULL, " ");
    } else {
	expiry = NULL;
    }
    reason = strtok(NULL, "");

    if (!reason)
    {
        syntax_error(s_NickServ, u, "SUSPEND", NICK_SUSPEND_SYNTAX);
    }
    else if (!u || (get_access(u,ca) == 0))
    {
        notice(s_ChanServ,u->nick,"Do i know you?");
        return;
    }
    else if (get_access(u,ca) < ACCLEV_HELPER)
    {
        notice(s_ChanServ,u->nick,"Sorry you dont have rights to do that");
        return;
    }
    else if (!(ni = findnick(nick)))
    {
	notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);
    }
    else if (ni->status & NS_VERBOTEN)
    {
	notice_lang(s_NickServ, u, NICK_X_FORBIDDEN, nick);
    }
    else if ((link = getlink(ni))->suspendinfo)
    {
	notice_lang(s_NickServ, u, NICK_SUSPEND_ALREADY_SUSPENDED, nick);
    }
    else
    {
	if (expiry)
        {
	    expires = dotime(expiry);
	}
	else
        {
	    expires = NSSuspendExpire;
	}

	if (expires < 0)
        {
	    notice_lang(s_NickServ, u, BAD_EXPIRY_TIME);
	    return;
	}
        else if (expires > 0)
        {
	    expires += time(NULL);	/* Set an absolute time */
	}

	log("%s: %s SUSPENDED %s (root of %s)", s_NickServ, u->nick, link->nick, ni->nick);
	suspend(link, reason, u->nick, expires);
	notice_lang(s_NickServ, u, NICK_SUSPEND_SUCCEEDED, nick);

	if (readonly)
        {
	    notice_lang(s_NickServ, u, READ_ONLY_MODE);
        }
    }
}

/*************************************************************************/

static void do_unsuspend(User *u)
{
    NickInfo *ni, *link;
    char *nick = strtok(NULL, " ");

    if (!nick) {
	syntax_error(s_NickServ, u, "UNSUSPEND", NICK_UNSUSPEND_SYNTAX);
    } else if (!u || (get_access(u,ca) == 0)) {
        notice(s_ChanServ,u->nick,"Do i know you?");
        return;
    } else if (get_access(u,ca) < ACCLEV_HELPER) {
        notice(s_ChanServ,u->nick,"Sorry you dont have rights to do that");
        return;
    } else if (!(ni = findnick(nick))) {
	notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);
    } else if (ni->status & NS_VERBOTEN) {
	notice_lang(s_NickServ, u, NICK_X_FORBIDDEN, nick);
    } else if (!(link = getlink(ni))->suspendinfo) {
	notice_lang(s_NickServ, u, NICK_SUSPEND_NOT_SUSPENDED, nick);
    } else {
	log("%s: %s UNSUSPENDED %s (root of %s)", s_NickServ, u->nick,
	    link->nick, ni->nick);
	unsuspend(link, 1);
	notice_lang(s_NickServ, u, NICK_UNSUSPEND_SUCCEEDED, nick);
	if (readonly)
	    notice_lang(s_NickServ, u, READ_ONLY_MODE);
    }
}

/*************************************************************************/

#ifdef DEBUG_COMMANDS

/* Return all the fields in the NickInfo structure. */

static void do_listnick(User *u)
{
    NickInfo *ni;
    char *nick = strtok(NULL, " ");
    char buf1[BUFSIZE], buf2[BUFSIZE], buf3[BUFSIZE], buf4[BUFSIZE];
    char *s;
    int i;

    if (!nick)
	return;
    ni = findnick(nick);
    if (!ni) {
	notice(s_NickServ, u->nick, "%s", nick);
	return;
    }
    strscpy(buf1, ni->url ? ni->url : "-", sizeof(buf1));
    strscpy(buf2, ni->email ? ni->email : "-", sizeof(buf2));
    if (ni->suspendinfo) {
	SuspendInfo *si = ni->suspendinfo;
	snprintf(buf3, sizeof(buf3), "%s.%ld.%ld.%s",
		 si->who, si->suspended, si->expires,
		 si->reason ? si->reason : "-");
	strnrepl(buf3, sizeof(buf3), " ", "_");
    } else {
	strcpy(buf3, "-");
    }
    s = buf4;
    *buf4 = 0;
    for (i = 0; i < ni->accesscount; i++)
	s += snprintf(s, sizeof(buf4)-(s-buf4), "%s%s",
		      *buf4 ? "," : "", ni->access[i]);
    strnrepl(buf1, sizeof(buf1), " ", "_");
    strnrepl(buf2, sizeof(buf2), " ", "_");
    strnrepl(buf4, sizeof(buf4), " ", "_");
    notice(s_NickServ, u->nick,
	   "%s %s %s %s %d %d %04X %s %d %08X %s %d %d %d %d %s :%s;%s",
	   ni->nick, buf1, buf2, ni->last_usermask, (int)ni->time_registered,
	   (int)ni->last_seen, ni->status & 0xFFFF,
	   (ni->link ? ni->link->nick : "-"), ni->linkcount, ni->flags,
	   buf3, ni->channelcount, ni->channelmax, ni->language,
	   ni->accesscount, buf4, 
	   ni->last_realname, (ni->last_quit ? ni->last_quit : "-"));
}

#endif /* DEBUG_COMMANDS */

/*************************************************************************/
