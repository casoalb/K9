/* Routines to handle `listnicks' and `listchans' invocations.
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
#include "language.h"	/* for STRFTIME_DATE_TIME_FORMAT */

/*************************************************************************/
/*************************************************************************/

/* Display total number of registered nicks and info about each; or, if
 * a specific nick is given, display information about that nick (like
 * /msg NickServ INFO <nick>).  If count_only != 0, then only display the
 * number of registered nicks (the nick parameter is ignored).
 */

static void do_listnicks(int count_only, const char *nick)
{
    int count = 0;
    NickInfo *ni;
    char *end;

    if (count_only) {

	for (ni = firstnick(); ni; ni = nextnick())
	    count++;
	printf("%d nicknames registered.\n", count);

    } else if (nick) {

	struct tm *tm;
	char buf[512];
	static const char commastr[] = ", ";
	int need_comma = 0;

	if (!(ni = findnick(nick))) {
	    printf("%s not registered.\n", nick);
	    return;
	} else if (ni->status & NS_VERBOTEN) {
	    printf("%s is FORBIDden.\n", nick);
	    return;
	}
	printf("%s is %s\n", nick, ni->last_realname);
	printf("Last seen address: %s\n", ni->last_usermask);
	tm = localtime(&ni->time_registered);
	strftime(buf, sizeof(buf), getstring((NickInfo *)NULL,STRFTIME_DATE_TIME_FORMAT), tm);
	printf("  Time registered: %s\n", buf);
	tm = localtime(&ni->last_seen);
	strftime(buf, sizeof(buf), getstring((NickInfo *)NULL,STRFTIME_DATE_TIME_FORMAT), tm);
	printf("   Last seen time: %s\n", buf);
	if (ni->url)
	    printf("              URL: %s\n", ni->url);
	if (ni->email)
	    printf("   E-mail address: %s\n", ni->email);
	*buf = 0;
	end = buf;
	if (ni->flags & NI_KILLPROTECT) {
	    end += snprintf(end, sizeof(buf)-(end-buf), "Kill protection");
	    need_comma = 1;
	}
	if (ni->flags & NI_SECURE) {
	    end += snprintf(buf, sizeof(buf)-(end-buf), "%sSecurity",
			need_comma ? commastr : "");
	    need_comma = 1;
	}
	if (ni->flags & NI_PRIVATE) {
	    end += snprintf(buf, sizeof(buf)-(end-buf), "%sPrivate",
			need_comma ? commastr : "");
	    need_comma = 1;
	}
	if (ni->status & NS_NOEXPIRE) {
	    end += snprintf(buf, sizeof(buf)-(end-buf), "%sNo Expire",
			need_comma ? commastr : "");
	    need_comma = 1;
	}
	printf("          Options: %s\n", *buf ? buf : "None");

    } else {

	for (ni = firstnick(); ni; ni = nextnick()) {
	    printf("    %s %-20s  %s\n",
		   ni->status & NS_NOEXPIRE ? "!" : " ",
		   ni->nick, ni->status & NS_VERBOTEN ?
				"Disallowed (FORBID)" : ni->last_usermask);
	    count++;
	}
	printf("%d nicknames registered.\n", count);

    }
}

/*************************************************************************/

/* Display total number of registered channels and info about each; or, if
 * a specific channel is given, display information about that channel
 * (like /msg ChanServ INFO <channel>).  If count_only != 0, then only
 * display the number of registered channels (the channel parameter is
 * ignored).
 */

static void do_listchans(int count_only, const char *chan)
{
    int count = 0;
    ChannelInfo *ci;

    if (count_only) {

	for (ci = cs_firstchan(); ci; ci = cs_nextchan())
	    count++;
	printf("%d channels registered.\n", count);

    } else if (chan) {

	struct tm *tm;
	char *s, buf[BUFSIZE];

	if (!(ci = cs_findchan(chan))) {
	    printf("Channel %s not registered.\n", chan);
	    return;
	}
	if (ci->flags & CI_VERBOTEN) {
	    printf("Channel %s is FORBIDden.\n", ci->name);
	} else {
	    printf("Information about channel %s:\n", ci->name);
	    s = ci->founder->last_usermask;
	    printf("        Founder: %s%s%s%s\n",
			ci->founder->nick,
			s ? " (" : "", s ? s : "", s ? ")" : "");
	    printf("    Description: %s\n", ci->desc);
	    tm = localtime(&ci->time_registered);
	    strftime(buf, sizeof(buf), getstring(NULL,STRFTIME_DATE_TIME_FORMAT), tm);
	    printf("     Registered: %s\n", buf);
	    tm = localtime(&ci->last_used);
	    strftime(buf, sizeof(buf), getstring(NULL,STRFTIME_DATE_TIME_FORMAT), tm);
	    printf("      Last used: %s\n", buf);
	    if (ci->last_topic) {
		printf("     Last topic: %s\n", ci->last_topic);
		printf("   Topic set by: %s\n", ci->last_topic_setter);
	    }
	    if (ci->url)
		printf("            URL: %s\n", ci->url);
	    if (ci->email)
		printf(" E-mail address: %s\n", ci->email);
	    printf("        Options: %s\n",
		   ci->flags ? chanopts_to_string(ci, NULL) : "None");
	    printf("      Mode lock: ");
	    if (ci->mlock_on || ci->mlock_key || ci->mlock_limit)
		printf("+%s%s%s",
		       mode_flags_to_string(ci->mlock_on, MODE_CHANNEL),
		       (ci->mlock_key  ) ? "k" : "",
		       (ci->mlock_limit) ? "l" : ""
		);
	    if (ci->mlock_off)
		printf("-%s", mode_flags_to_string(ci->mlock_off, MODE_CHANNEL));
	    if (ci->mlock_key)
		printf(" %s", ci->mlock_key);
	    if (ci->mlock_limit)
		printf(" %d", ci->mlock_limit);
	    printf("\n");
	    if (ci->flags & CI_NOEXPIRE)
		printf("This channel will not expire.\n");
	}

    } else {

	for (ci = cs_firstchan(); ci; ci = cs_nextchan()) {
	    printf("  %s %-20s  %s\n", ci->flags & CI_NOEXPIRE ? "!" : " ",
		   ci->name,
		   ci->flags & CI_VERBOTEN ? "Disallowed (FORBID)" : ci->desc);
	    count++;
	}
	printf("%d channels registered.\n", count);

    }
}

/*************************************************************************/
/*************************************************************************/

void listnicks(int ac, char **av)
{
    int count = 0;	/* Count only rather than display? */
    int usage = 0;	/* Display command usage?  (>0 also indicates error) */
    int i;

    i = 1;
    while (i < ac) {
	if (av[i][0] == '-') {
	    switch (av[i][1]) {
	      case 'h':
		usage = -1; break;
	      case 'c':
		if (i > 1)
		    usage = 1;
		count = 1; break;
	      case 'd':
		if (av[i][2]) {
		    services_dir = av[i]+2;
		} else {
		    if (i >= ac-1) {
			usage = 1;
			break;
		    }
		    ac--;
		    memmove(av+i, av+i+1, sizeof(char *) * ac-i);
		    services_dir = av[i];
		}
		break;
	      default :
		usage = 1; break;
	    } /* switch */
	    ac--;
	    if (i < ac)
		memmove(av+i, av+i+1, sizeof(char *) * ac-i);
	} else {
	    if (count)
		usage = 1;
	    i++;
	}
    }
    if (usage) {
	fprintf(stderr, "\
\n\
Usage: listnicks [-c] [-d data-dir] [nick [nick...]]\n\
     -c: display only count of registered nicks\n\
            (cannot be combined with nicks)\n\
   nick: nickname(s) to display information for\n\
\n\
If no nicks are given, the entire nickname database is printed out in\n\
compact format followed by the number of registered nicks (with -c, the\n\
list is suppressed and only the count is printed).  If one or more nicks\n\
are given, detailed information about those nicks is displayed.\n\
\n");
	exit(usage>0 ? 1 : 0);
    }

    if (chdir(services_dir) < 0) {
	fprintf(stderr, "chdir(%s): %s\n", services_dir, strerror(errno));
	exit(1);
    }
    if (!read_config())
	exit(1);
    //load_ns_dbase();

    lang_init();

    if (ac > 1) {
	for (i = 1; i < ac; i++)
	    do_listnicks(0, av[i]);
    } else {
	do_listnicks(count, NULL);
    }
    exit(0);
}

/*************************************************************************/

void listchans(int ac, char **av)
{
    int count = 0;	/* Count only rather than display? */
    int usage = 0;	/* Display command usage?  (>0 also indicates error) */
    int i;

    i = 1;
    while (i < ac) {
	if (av[i][0] == '-') {
	    switch (av[i][1]) {
	      case 'h':
		usage = -1; break;
	      case 'c':
		if (i > 1)
		    usage = 1;
		count = 1; break;
	      case 'd':
		if (av[i][2]) {
		    services_dir = av[i]+2;
		} else {
		    if (i >= ac-1) {
			usage = 1;
			break;
		    }
		    ac--;
		    memmove(av+i, av+i+1, sizeof(char *) * ac-i);
		    services_dir = av[i];
		}
		break;
	      default :
		usage = 1; break;
	    } /* switch */
	    ac--;
	    if (i < ac)
		memmove(av+i, av+i+1, sizeof(char *) * ac-i);
	} else {
	    if (count)
		usage = 1;
	    i++;
	}
    }
    if (usage) {
	fprintf(stderr, "\
\n\
Usage: listchans [-c] [-d data-dir] [channel [channel...]]\n\
     -c: display only count of registered channels\n\
            (cannot be combined with channels)\n\
channel: channel(s) to display information for\n\
\n\
If no channels are given, the entire channel database is printed out in\n\
compact format followed by the number of registered channels (with -c, the\n\
list is suppressed and only the count is printed).  If one or more channels\n\
are given, detailed information about those channels is displayed.\n\
\n");
	exit(usage>0 ? 1 : 0);
    }

    if (chdir(services_dir) < 0) {
	fprintf(stderr, "chdir(%s): %s\n", services_dir, strerror(errno));
	exit(1);
    }
    if (!read_config())
	exit(1);
    //load_ns_dbase();
    //load_cs_dbase();

    lang_init();

    if (ac > 1) {
	for (i = 1; i < ac; i++)
	    do_listchans(0, av[i]);
    } else {
	do_listchans(count, NULL);
    }
    exit(0);
}

/*************************************************************************/
