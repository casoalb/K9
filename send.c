/* Routines for sending stuff to the network.
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

time_t last_send;	/* Time last data was sent to server */

/*************************************************************************/

/* Send a command to the server.  The two forms here are like
 * printf()/vprintf() and friends. */

void send_cmd(const char *source, const char *fmt, ...)
{
    va_list args;

    va_start(args, fmt);
    vsend_cmd(source, fmt, args);
    va_end(args);
}

void vsend_cmd(const char *source, const char *fmt, va_list args)
{
    char buf[BUFSIZE];

    vsnprintf(buf, sizeof(buf), fmt, args);
    if (source) {
	sockprintf(servsock, ":%s %s\r\n", source, buf);
	if (debug)
	    log("debug: Sent: :%s %s", source, buf);
    } else {
	sockprintf(servsock, "%s\r\n", buf);
	if (debug)
	    log("debug: Sent: %s", buf);
    }
    last_send = time(NULL);
}

/*************************************************************************/
/*************************************************************************/

/* Send a NICK command for a new user. */

void send_nick(const char *nick, const char *user, const char *host,
	       const char *server, const char *name, int32 modes)
{
#if defined(IRC_UNREAL)
    /* NICK <nick> <hops> <TS> <user> <host> <server> <svsid> <mode>
     *      <fakehost> :<ircname> */
    /* Note that if SETHOST has not been used, <fakehost> is <host> for VHP
     * servers but "*" for others.  We send <host> because that works in
     * both cases. */
    send_cmd(NULL, "NICK %s 1 %ld %s %s %s 0 +%s %s :%s", nick, time(NULL),
	     user, host, server, mode_flags_to_string(modes, MODE_USER),
	     host, name);
#elif defined(IRC_BAHAMUT)
    /* NICK <nick> <hops> <TS> <umode> <user> <host> <server> <svsid>
     *      :<ircname> */
    send_cmd(NULL, "NICK %s 1 %ld +%s %s %s %s 0 :%s", nick, time(NULL),
	     mode_flags_to_string(modes, MODE_USER),
	     user, host, server, name);
#elif defined(IRC_DAL4_4_15)
    send_cmd(NULL, "NICK %s 1 %ld %s %s %s 0 :%s", nick, time(NULL),
	     user, host, server, name);
#elif defined(IRC_DALNET)
    send_cmd(NULL, "NICK %s 1 %ld %s %s %s :%s", nick, time(NULL),
	     user, host, server, name);
#elif defined(IRC_UNDERNET)
    send_cmd(ServerName, "NICK %s 1 %ld %s %s %s :%s", nick, time(NULL),
	     user, host, server, name);
#elif defined(IRC_TS8)
    send_cmd(NULL, "NICK %s :1", nick);
    send_cmd(nick, "USER %ld %s %s %s :%s", time(NULL),
	     user, host, server, name);
#else
    send_cmd(NULL, "NICK %s :1", nick);
    send_cmd(nick, "USER %s %s %s :%s", user, host, server, name);
#endif

#if !defined(IRC_UNREAL) && !defined(IRC_BAHAMUT)
    if (modes)
	send_cmd(nick, "MODE %s +%s", nick,
		 mode_flags_to_string(modes, MODE_USER));
#endif
}

/*************************************************************************/

/* Send a NOTICE from the given source to the given nick. */

void notice(const char *source, const char *dest, const char *fmt, ...)
{
    va_list args;
    char buf[BUFSIZE];

    va_start(args, fmt);
    snprintf(buf, sizeof(buf), "NOTICE %s :%s", dest, fmt);
    vsend_cmd(source, buf, args);
}


/* Send a NULL-terminated array of text as NOTICEs. */

void notice_list(const char *source, const char *dest, const char **text)
{
    while (*text) {
	/* Have to kludge around an ircII bug here: if a notice includes
	 * no text, it is ignored, so we replace blank lines by lines
	 * with a single space.
	 */
	if (**text)
	    notice(source, dest, *text);
	else
	    notice(source, dest, " ");
	text++;
    }
}


/* Send a message in the user's selected language to the user using NOTICE. */

void notice_lang(const char *source, User *dest, int message, ...)
{
    va_list args;
    char buf[4096];	/* because messages can be really big */
    char *s, *t;
    const char *fmt;

    if (!dest)
	return;
  
    fmt = getstring(dest->ni, message);

    va_start(args, message); 

    if (!fmt)
	return;
    vsnprintf(buf, sizeof(buf), fmt, args);
    s = buf;
    while (*s) {
	t = s;
	s += strcspn(s, "\n");
	if (*s)
	    *s++ = 0;
	send_cmd(source, "NOTICE %s :%s", dest->nick, *t ? t : " ");

    }
}


/* Like notice_lang(), but replace %S by the source.  This is an ugly hack
 * to simplify letting help messages display the name of the pseudoclient
 * that's sending them.
 */
void notice_help(const char *source, User *dest, int message, ...)
{
    va_list args;
    char buf[4096], buf2[4096], outbuf[BUFSIZE];
    char *s, *t;
    const char *fmt;

    if (!dest)
	return;
    va_start(args, message);
    fmt = getstring(dest->ni, message);
    if (!fmt)
	return;
    /* Some sprintf()'s eat %S or turn it into just S, so change all %S's
     * into \1\1... we assume this doesn't occur anywhere else in the
     * string. */
    strscpy(buf2, fmt, sizeof(buf2));
    strnrepl(buf2, sizeof(buf2), "%S", "\1\1");
    vsnprintf(buf, sizeof(buf), buf2, args);
    s = buf;
    while (*s) {
	t = s;
	s += strcspn(s, "\n");
	if (*s)
	    *s++ = 0;
	strscpy(outbuf, t, sizeof(outbuf));
	strnrepl(outbuf, sizeof(outbuf), "\1\1", source);
	send_cmd(source, "NOTICE %s :%s", dest->nick, *outbuf ? outbuf : " ");
    }
}

/*************************************************************************/

/* Send a PRIVMSG from the given source to the given nick. */

void privmsg(const char *source, const char *dest, const char *fmt, ...)
{
    va_list args;
    char buf[BUFSIZE];

    va_start(args, fmt);
    snprintf(buf, sizeof(buf), "PRIVMSG %s :%s", dest, fmt);
    vsend_cmd(source, buf, args);
}

/*************************************************************************/

/* Send a SERVER command, and anything else needed at the beginning of the
 * connection.
 */

void send_server()
{
#if defined(IRC_UNREAL)
    /* We now use VL, so we can send along the numeric (if any; 0 is legal)
     * This will not have any effect on services except for making them
     * more bandwidth friendly. */
    send_cmd(NULL, "PROTOCTL SJOIN SJOIN2 SJ3 NICKv2 VHP VL");
    send_cmd(NULL, "PASS :%s", RemotePassword);
    /* Syntax:
     *     SERVER servername hopcount :U<protocol>-flags-numeric serverdesc
     * We use protocol 0, as we are protocol independent, and flags are *,
     * to prevent matching with version denying lines. */
    send_cmd(NULL, "SERVER %s 1 :U0-*-%d %s", ServerName, ServerNumeric, 
	     ServerDesc);
#elif defined(IRC_BAHAMUT)
    send_cmd(NULL, "PASS %s :TS", RemotePassword);
    send_cmd(NULL, "SERVER %s 1 :%s", ServerName, ServerDesc);
/*    send_cmd(NULL, "SVINFO 3 3 0 :%ld", time(NULL));
*/
    send_cmd(NULL, "CAPAB TS3 SSJOIN");
#elif defined(IRC_UNDERNET_NEW)
    send_cmd(NULL, "PASS :%s", RemotePassword);
    send_cmd(NULL, "SERVER %s 1 %lu %lu P09 :%s",
		ServerName, start_time, start_time, ServerDesc);
#else
    send_cmd(NULL, "PASS :%s", RemotePassword);
    send_cmd(NULL, "SERVER %s 1 :%s", ServerName, ServerDesc);
#endif
}

/*************************************************************************/

/* Send a SERVER command for a remote (juped) server. */

void send_server_remote(const char *server, const char *reason)
{
#ifdef IRC_UNDERNET_NEW
    send_cmd(NULL, "SERVER %s 1 %lu %lu P09 :%s",
	     server, time(NULL), time(NULL), reason);
#else
    send_cmd(NULL, "SERVER %s 2 :%s", server, reason);
#endif
}

/*************************************************************************/

/* Send a WALLOPS (a GLOBOPS on ircd.dal). */

void wallops(const char *source, const char *fmt, ...)
{
    va_list args;
    char buf[BUFSIZE];

    va_start(args, fmt);
    snprintf(buf, sizeof(buf), "GLOBOPS :%s", fmt);
    vsend_cmd(source ? source : ServerName, buf, args);
}

/*************************************************************************/
