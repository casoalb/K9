/* Definitions of IRC message functions and list of messages.
**
** Based on ircdservices ver. by Andy Church
** Parts copyright (c) 1999-2000 Andrew Kempe and others.
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
#include "messages.h"
#include "language.h"

/* List of messages is at the bottom of the file. */

/*************************************************************************/
/*************************************************************************/

static void m_nickcoll(char *source, int ac, char **av)
{
    if (ac < 1)
	return;
    if (!skeleton && !readonly)
	introduce_user(av[0]);
}

/*************************************************************************/

static void m_ping(char *source, int ac, char **av)
{
    if (ac < 1)
	return;
    send_cmd(ServerName, "PONG %s %s", ac>1 ? av[1] : ServerName, av[0]);
}

/*************************************************************************/

static void m_info(char *source, int ac, char **av)
{
    int i;
    struct tm *tm;
    char timebuf[64];

    tm = localtime(&start_time);
    strftime(timebuf, sizeof(timebuf), "%a %b %d %H:%M:%S %Y %Z", tm);

    for (i = 0; info_text[i]; i++)
	send_cmd(ServerName, "371 %s :%s", source, info_text[i]);
    send_cmd(ServerName, "371 %s :Version %s (%s)", source,
	     version_number, version_build);
    send_cmd(ServerName, "371 %s :On-line since %s", source, timebuf);
    send_cmd(ServerName, "374 %s :End of /INFO list.", source);
}

/*************************************************************************/

static void m_join(char *source, int ac, char **av)
{
    if (ac != 1)
    {
	return;
    }
    if (strncmp(source, "OS", strlen(source)) == 0)
    {
        return;
    }
    do_join(source, ac, av);
}

/*************************************************************************/

static void m_kick(char *source, int ac, char **av)
{
    if (ac != 3)
	return;

    /* Check if the target to be kicked is ChanServ.
       If it is, we need to rejoin the channel.  We
       could then use any needed revenge.. */

/*    if (strcasecmp(av[1],s_ChanServ) == 0) */
    if (stricmp(av[1], s_ChanServ) == 0)
    {
        /* This Kick was against us! */
	log("debug: m_kick, WE were the target!");
	send_cmd(s_ChanServ, "JOIN %s", av[0]);
	send_cmd(s_ChanServ, "MODE %s +o %s", av[0], s_ChanServ);
    } else {
        do_kick(source, ac, av);
    }
}

/*************************************************************************/

static void m_kill(char *source, int ac, char **av)
{
    if (ac != 2)
	return;
    /* Recover if someone kills us. */
    if (stricmp(av[0], s_NickServ) == 0 ||
        stricmp(av[0], s_ChanServ) == 0
    ) {
	if (!readonly && !skeleton)
	    introduce_user(av[0]);
    } else {
	do_kill(source, ac, av);
    }
}

/*************************************************************************/

static void m_mode(char *source, int ac, char **av)
{
    if (*av[0] == '#' || *av[0] == '&')
    {
        if (ac < 2)
            return;
        do_cmode(source, ac, av);
    } else {
        if (ac != 2)
            return;
        do_umode(source, ac, av);
    }
}

/*************************************************************************/

static void m_motd(char *source, int ac, char **av)
{
    FILE *f;
    char buf[BUFSIZE];

    f = fopen(MOTDFilename, "r");
    send_cmd(ServerName, "375 %s :- %s Message of the Day",
	     source, ServerName);
    if (f) {
	while (fgets(buf, sizeof(buf), f)) {
	    buf[strlen(buf)-1] = 0;
	    send_cmd(ServerName, "372 %s :- %s", source, buf);
	}
	fclose(f);
    } else {
	send_cmd(ServerName, "372 %s :- MOTD file not found!  Please "
		 "contact your IRC administrator.", source);
    }
}

/*************************************************************************/

static void m_nick(char *source, int ac, char **av)
{
    int orig_ac = ac;
#ifdef IRC_DAL4_4_15
    char *tmp;
#endif
#if defined(IRC_DALNET) || defined(IRC_UNDERNET)
    char *newmodes = NULL;
#endif

#ifdef IRC_UNDERNET
    /* ircu sends the server as the source for a NICK message for a new
     * user. */
    if (strchr(source, '.'))
	*source = 0;
#endif

    if (*source) {
	/* Old user changing nicks. */
#ifdef IRC_CLASSIC
	if (ac != 1) {
#else
	if (ac != 2) {
#endif
	    if (debug)
		log("debug: NICK message: wrong number of parameters (%d) "
		    "for source `%s'", orig_ac, source);
	} else {
	    do_nick(source, ac, av);
	}
	return;
    }

    /* New user.  For IRC_CLASSIC and IRC_TS8, we get the information we
     * want from the USER command, so we don't do anything else here. */

#if defined(IRC_DALNET) || defined(IRC_UNDERNET)
# ifdef IRC_DAL4_4_15
#  ifdef IRC_UNREAL
    if (ac != 10) {
#  elif defined(IRC_BAHAMUT)
    if (ac != 9) {
#  else /* DAL4_4_15 && !UNREAL && !BAHAMUT */
    if (ac != 8) {
#  endif
# else /* !DAL4_4_15 */
    if (ac != 7) {
# endif
	if (debug)
	    log("debug: NICK message: wrong number of parameters (%d) for "
		"new user", orig_ac);
	return;
    }
# ifdef IRC_UNREAL
    /* With Unreal, new users get modes in the NICK message.  Save
     * the modes and strip the parameter out.  Note that we move the
     * real name parameter before the fake host, which stays as is, to
     * make things simpler for do_nick(). */
    newmodes = av[7];
    av[7] = av[9];
    ac--;
# endif
# ifdef IRC_BAHAMUT
    /* Bahamut also gives us user modes--but in a different place.
     * Good grief, can't we get at least some order here? */
    newmodes = av[3];
    memmove(&av[3], &av[4], sizeof(char *) * 5);
    ac--;
# endif
# ifdef IRC_DAL4_4_15
    /* Swap parameters so the Services timestamp is last. */
    tmp = av[6];
    av[6] = av[7];
    av[7] = tmp;
# endif
    if (do_nick(source, ac, av) && newmodes) {
	av[1] = newmodes;
	do_umode(av[0], 2, av);
    }
#endif /* UNDERNET || DALNET */
}

/*************************************************************************/

static void m_part(char *source, int ac, char **av)
{
    if (ac < 1 || ac > 2)
	return;
    do_part(source, ac, av);
}

/*************************************************************************/

static void m_privmsg(char *source, int ac, char **av)
{
	struct timeval start;
//    struct timeval stop; /* When processing started and finished */
	char *s;
        
	if (ac != 2)
		return;

	
	/* Check if we should ignore.  Operators always get through. */
	if (allow_ignore && !is_oper(source))
	{
		IgnoreData *ign = get_ignore(source);
		if (ign && (ign->time > time(NULL)) )
		{
			log("Ignored message from %s: \"%s\"", source, inbuf);
			return;
		}
	}

	/* If a server is specified (nick@server format), make sure it matches
	 * us, and strip it off. */
	s = strchr(av[0], '@');
	if (s)
	{
		*s++ = 0;
		if (stricmp(s, ServerName) != 0)
			return;
	}

	gettimeofday(&start, NULL);

	if (stricmp(av[0], s_NickServ) == 0)
	{
		nickserv(source, av[1]);
		return;
	}

	/* If this is In-Message */

	if (stricmp(av[0], s_ChanServ) == 0)
	{
		char cmd[64];
		char chan[CHANMAX];
		char buf[512];
		char *p;

		strscpy(buf, (char *) av[1], sizeof(buf) );     /* make a copy of the buffer + null */

		p = strpbrk(buf, " ");
		if (!p)
			p = cmd;

		*p = 0;
		while (isspace(*++p));
			;
		strscpy(cmd, buf, sizeof(cmd));         /* No need to store it, really */
		memmove(buf,p,strlen(p)+1);             /* move the buffer 3 chars to the left */
		
		if ( cmd )
		{
			p = strpbrk(buf, " ");
			if ( (p) && (strncasecmp(buf,"#",1) == 0) )        /* Ensure it looks like a channel */
			{
				*p = 0;
				while (isspace(*++p))
						;
				strscpy(chan, buf, sizeof(chan));    /* Store it away */
				memmove(buf, p, strlen(p) +1);       /* Move the buffer over */
			}
			else if ( (buf) && strncasecmp(buf, "#",1) == 0 )
			{
				strscpy(chan, buf, sizeof(chan));
			}
		}

			
		chanserv(source, chan , av[1]);              /* We use the origional buffer, with the   */
	                                             /* New channel name (or orig if not found) */
		return;
	}
    
    	/* If this is In-Channel */
	if ( (strncasecmp(av[0], "#", 1) == 0) && (strncasecmp(av[1], "K9 ", 3) == 0) )
	{
		char buf[512];
		char cmd[64];
		char chan[CHANMAX];
		typedef struct {
			char *name;
		} DisableChannel;
		DisableChannel disabled_inchanlist[] = {
			{ "IDENTIFY" },
			{ "AUTH"     },
			{ "REGISTER" },
//			{ "ADDCHAN" },
			{ NULL }
		};
		char *p,*s;
		DisableChannel *d_cmd;

		p = buf;
		*p = 0;
		strscpy(buf, (char *) av[1], strlen(av[1])+1);       /* make a copy of the buffer + null */
        
        /* Strip off the 'k9 ' from the message
           It need not be stored in ANY variable, simply use cmd here
           until 6 lines down */
           
		p = strpbrk(buf, " ");                  /* Eat the leading 'k9 ' from the string */
		if (!p)                                 /* Stripping excess spaces after it      */
			return;
		*p = 0;
		while (isspace(*++p));
			;
//		strscpy(csid, buf, sizeof(csid));     /* No need to store it, really */
		memmove(buf,p,strlen(p)+1);             /* move the buffer 3 chars to the left */
                                                /* (3 if 'k9 ', this may change - uses the space */

		if (!buf)                               /* Thats all they typed? a waste of our time! */
			return;

		p = strpbrk(buf, " ");                  /* Get the command for this item.  The first argument */
		if (p)                                  /* up to the space */
		{
			*p = 0;
			while (isspace(*++p))
				;
		}
		else
			p = buf + strlen(buf);

		strscpy(cmd, buf, sizeof(cmd));         /* Store it away */
		memmove(buf, p,strlen(p)+1);            /* Move the buffer over */

		if (cmd && buf && (strncasecmp(buf,"#",1) == 0))
		{
			p = strpbrk(buf, " ");                   /* Store the channel name */
			if (p)
			{
				*p = 0;
				while (isspace(*++p))
					;
				strscpy(chan, buf, sizeof(chan));    /* Store it away */
				memmove(buf, p, strlen(p) +1);       /* Move the buffer over */
			}
			else
			{
				strscpy(chan, buf, sizeof(chan));    /* Only a channel specified no args */
				buf[0] = 0;
			}
		}
		else
			strscpy(chan, av[0], CHANMAX);
        
		for (d_cmd=disabled_inchanlist; d_cmd->name; d_cmd++)       /* Prevent some commands from working in-channel */
		{
			if (strcasecmp(cmd,d_cmd->name) == 0)
				return;
		}

        /* Now that we are here, we should have the following:
            cmd = command entered
            chan = channel target
            buf = argument list (if any)
            ..only cmd is guaranteed to exist!
        
            Lets create our new string ... 
        */

		p = av[1];
		*p = 0;

		s = buf;
		if (*s != 0)
			snprintf(p, strlen(cmd)+strlen(chan)+strlen(buf)+3, "%s %s %s", cmd, chan, buf);
		else
			snprintf(p, strlen(cmd)+strlen(chan)+strlen(buf)+3, "%s %s", cmd, chan);

		p = av[1];    
		p[512] = 0;                        /* regardless of the string, the last char IS null */
		chanserv(source, chan, av[1]);
		return;
	}

    /* Add to ignore list if the command took a significant amount of time. */

// Disabled to to conflicts with the debugger !

//    if (allow_ignore) {
//	int32 diff;
//	gettimeofday(&stop, NULL);
//	diff = (stop.tv_sec-start.tv_sec)*1000000+(stop.tv_usec-start.tv_usec);
//	if (diff >= 1000000 && *source && !strchr(source, '.'))
//	    add_ignore(source, diff/1000000);
//    }
    
}

/*************************************************************************/

#if defined(IRC_DAL4_4_15) && !defined(IRC_BAHAMUT)
static void m_protoctl(char *source, int ac, char **av)
{
#ifdef IRC_UNREAL
    int got_nickv2 = 0;
    int i;

    for (i = 0; i < ac; i++) {
	if (stricmp(av[i], "NICKv2") == 0)
	    got_nickv2 = 1;
    }
    if (!got_nickv2) {
	send_cmd(NULL, "ERROR :Need NICKv2 protocol");
	quitmsg = "Remote server doesn't support NICKv2";
	quitting = 1;
    }
#endif
}
#endif

/*************************************************************************/

static void m_quit(char *source, int ac, char **av)
{
    if (ac != 1)
	return;
    do_quit(source, ac, av);
}

/*************************************************************************/

static void m_server(char *source, int ac, char **av)
{
    do_server(source, ac, av);
}

/*************************************************************************/

static void m_squit(char *source, int ac, char **av)
{
    do_squit(source, ac, av);
}

/*************************************************************************/

static void m_stats(char *source, int ac, char **av)
{
    if (ac < 1)
	return;
    switch (*av[0]) {
      case 'u': {
	int uptime = time(NULL) - start_time;
	send_cmd(NULL, "242 %s :Services up %d day%s, %02d:%02d:%02d",
		 source, uptime/86400, (uptime/86400 == 1) ? "" : "s",
		 (uptime/3600) % 24, (uptime/60) % 60, uptime % 60);
	send_cmd(NULL, "250 %s :Current users: %d (%d ops); maximum %d",
		 source, usercnt, opcnt, maxusercnt);
	send_cmd(NULL, "219 %s u :End of /STATS report.", source);
	break;
      } /* case 'u' */

      case 'l':
	send_cmd(NULL, "211 %s Server SendBuf SentBytes SentMsgs RecvBuf "
		 "RecvBytes RecvMsgs ConnTime", source);
	//send_cmd(NULL, "211 %s %s %d %d %d %d %d %d %ld", source, RemoteServer,
	send_cmd(NULL, "211 %s %s %d %d %d %d %d %d %ld", source, "Services.ChatNet.Org",
		 read_buffer_len(), total_read, -1,
		 write_buffer_len(), total_written, -1,
		 start_time);
	send_cmd(NULL, "219 %s l :End of /STATS report.", source);
	break;

      case 'c':
      case 'h':
      case 'i':
      case 'k':
      case 'm':
      case 'o':
      case 'y':
	send_cmd(NULL, "219 %s %c :/STATS %c not applicable or not supported.",
		 source, *av[0], *av[0]);
	break;
    }
}

/*************************************************************************/

static void m_time(char *source, int ac, char **av)
{
    time_t t;
    struct tm *tm;
    char buf[64];

    time(&t);
    tm = localtime(&t);
    strftime(buf, sizeof(buf), "%a %b %d %H:%M:%S %Y %Z", tm);
    send_cmd(NULL, "391 :%s", buf);
}

/*************************************************************************/

static void m_topic(char *source, int ac, char **av)
{
    if (ac != 4)
	return;
    do_topic(source, ac, av);
}

/*************************************************************************/

static void m_user(char *source, int ac, char **av)
{
#if defined(IRC_CLASSIC) || defined(IRC_TS8)
    char *new_av[7];

# ifdef IRC_TS8
    if (ac != 5)
# else
    if (ac != 4)
# endif
	return;
    new_av[0] = source;	/* Nickname */
    new_av[1] = sstrdup("0");  /* # of hops (was in NICK command... we lose) */
# ifdef IRC_TS8
    new_av[2] = av[0];	/* Timestamp */
    av++;
# else
    new_av[2] = sstrdup("0");
# endif
    new_av[3] = av[0];	/* Username */
    new_av[4] = av[1];	/* Hostname */
    new_av[5] = av[2];	/* Server */
    new_av[6] = av[3];	/* Real name */
    do_nick("", 7, new_av);
    free(new_av[1]);
# ifndef IRC_TS8
    free(new_av[2]);
# endif
#else	/* !IRC_CLASSIC && !IRC_TS8 */
    /* Do nothing - we get everything we need from the NICK command. */
#endif
}

/*************************************************************************/

void m_version(char *source, int ac, char **av)
{
    if (source)
	send_cmd(ServerName, "351 %s ircservices-%s %s :%s",
		 source, version_number, ServerName, version_build);
}

/*************************************************************************/

void m_whois(char *source, int ac, char **av)
{
    const char *clientdesc;
 
    if (source && ac >= 1) {
	if (stricmp(av[0], s_NickServ) == 0)
	    clientdesc = desc_NickServ;
	else if (stricmp(av[0], s_ChanServ) == 0)
	    clientdesc = desc_ChanServ;
	else {
	    send_cmd(ServerName, "401 %s %s :No such service.", source, av[0]);
	    return;
	}
	send_cmd(ServerName, "311 %s %s %s %s :%s", source, av[0],
		ServiceUser, ServiceHost, clientdesc);
	send_cmd(ServerName, "312 %s %s %s :%s", source, av[0],
		ServerName, ServerDesc);
	send_cmd(ServerName, "318 End of /WHOIS response.");
    }
}

/*************************************************************************/
/*********************** Server-specific functions ***********************/
/*************************************************************************/

#if defined(IRC_BAHAMUT) || defined(IRC_UNREAL)

static void m_sjoin(char *source, int ac, char **av)
{
#if defined(IRC_BAHAMUT)
    if (ac == 3 || ac < 2) {
	if (debug)
	    log("debug: SJOIN: expected 2 or >=4 params, got %d", ac);
	return;
    }
#elif defined(IRC_UNREAL)
    if (ac < 3) {
	if (debug)
	    log("debug: SJOIN: expected >=3 params, got %d", ac);
	return;
    }
#endif
    do_sjoin(source, ac, av);
}

#endif /* IRC_BAHAMUT || IRC_UNREAL */

/*************************************************************************/

#ifdef IRC_UNREAL

static void m_setident(char *source, int ac, char **av)
{
    User *u;

    if (ac != 1)
	return;
    u = finduser(source);
    if (!u) {
	log("m_setident: user record for %s not found", source);
	return;
    }
    free(u->username);
    u->username = sstrdup(av[0]);
}


static void m_sethost(char *source, int ac, char **av)
{
    User *u;

    if (ac != 1)
	return;
    u = finduser(source);
    if (!u) {
	log("m_sethost: user record for %s not found", source);
	return;
    }
    free(u->fakehost);
    u->fakehost = sstrdup(av[0]);
}


static void m_setname(char *source, int ac, char **av)
{
    User *u;

    if (ac != 1)
	return;
    u = finduser(source);
    if (!u) {
	log("m_setname: user record for %s not found", source);
	return;
    }
    free(u->realname);
    u->realname = sstrdup(av[0]);
}

#endif	/* IRC_UNREAL */

/*************************************************************************/

/* Ping checking code */

static void m_318(char *from, int parc, char **parv)
{
    char *c;

    c = parv[1];
    if( strncmp( c , "TIMETEST_" , 9 ) == 0 ) {
        c+=9;
        got_ping_reply(c);
    }

}

/*************************************************************************/

Message messages[] = {

    { "318",       m_318 }, /* Ping checking code */
    { "401",       NULL },
    { "412",       NULL },
    { "INVITE",    NULL },
    { "436",       m_nickcoll },
    { "AWAY",      NULL },
    { "INFO",	   m_info },
    { "JOIN",      m_join },
    { "KICK",      m_kick },
    { "KILL",      m_kill },
    { "MODE",      m_mode },
    { "MOTD",      m_motd },
    { "NICK",      m_nick },
    { "NOTICE",    NULL },
    { "PART",      m_part },
    { "PASS",      NULL },
    { "PING",      m_ping },
    { "PONG",      NULL },
    { "PRIVMSG",   m_privmsg },
    { "QUIT",      m_quit },
    { "SERVER",    m_server },
    { "SQUIT",     m_squit },
    { "STATS",     m_stats },
    { "TIME",      m_time },
    { "TOPIC",     m_topic },
    { "USER",      m_user },
    { "VERSION",   m_version },
    { "WALLOPS",   NULL },
    { "WHOIS",     m_whois },

#ifdef IRC_UNDERNET
    { "GLINE",     NULL },
#endif

#ifdef IRC_DALNET
    { "AKILL",     NULL },
    { "GLOBOPS",   NULL },
    { "GNOTICE",   NULL },
    { "GOPER",     NULL },
    { "SQLINE",	   NULL },
    { "RAKILL",    NULL },
#endif

#if defined(IRC_DAL4_4_15) && !defined(IRC_BAHAMUT)
    { "PROTOCTL",  m_protoctl },
#endif

#ifdef IRC_BAHAMUT
    { "CAPAB",	   NULL },
    { "SVINFO",    NULL },
    { "SGLINE",    NULL },
    { "SVSMODE",   NULL },
#endif

#if defined(IRC_BAHAMUT) || defined(IRC_UNREAL)
    { "SJOIN",	   m_sjoin },
#endif

#ifdef IRC_UNREAL
    { "NETINFO",   NULL },
    { "SETIDENT",  m_setident },
    { "SETHOST",   m_sethost },
    { "SETNAME",   m_setname },
#endif

    { NULL }

};

/*************************************************************************/

Message *find_message(const char *name)
{
    Message *m;

    for (m = messages; m->name; m++) {
	if (stricmp(name, m->name) == 0)
	    return m;
    }
    return NULL;
}

/*************************************************************************/
