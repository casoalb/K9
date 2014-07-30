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
**      sloth   (sloth@nopninjas.com)
**
**      *** DO NOT DISTRIBUTE ***
**/   
 
#include "services.h"
#include "encrypt.h"

/*************************************************************************/

/* Send a NICK command for the given pseudo-client.  If `user' is NULL,
 * send NICK commands for all the pseudo-clients. */

#ifdef IRC_UNREAL
# define EXTRA_MODES (UMODE_S | UMODE_q | UMODE_d)
#else
# define EXTRA_MODES 0
#endif
#define NICK(nick,name,modes) \
    send_nick((nick), ServiceUser, ServiceHost, ServerName, (name), (modes) | EXTRA_MODES);

void introduce_user(const char *user)
{
    /* Watch out for infinite loops... */
#define LTSIZE 20
    static int lasttimes[LTSIZE];
    if (lasttimes[0] >= time(NULL)-3)
	fatal("introduce_user() loop detected");
    memmove(lasttimes, lasttimes+1, sizeof(lasttimes)-sizeof(int));
    lasttimes[LTSIZE-1] = time(NULL);
#undef LTSIZE

    if (!user || stricmp(user, s_NickServ) == 0)
	NICK(s_NickServ, desc_NickServ, UMODE_o);
    if (!user || stricmp(user, s_ChanServ) == 0) {
        new_user(s_ChanServ);
	NICK(s_ChanServ, desc_ChanServ, UMODE_o);
    }
}

#undef NICK

/*************************************************************************/

/* Set GID if necessary.  Return 0 if successful (or if RUNGROUP not
 * defined), else print an error message to logfile and return -1.
 */

static int set_group(void)
{
#if defined(RUNGROUP) && defined(HAVE_SETGRENT)
    struct group *gr;

    setgrent();
    while ((gr = getgrent()) != NULL) {
	if (strcmp(gr->gr_name, RUNGROUP) == 0)
	    break;
    }
    endgrent();
    if (gr) {
	setgid(gr->gr_gid);
	return 0;
    } else {
	log("Unknown group `%s'\n", RUNGROUP);
	return -1;
    }
#else
    return 0;
#endif
}

/*************************************************************************/

/* Parse command-line options.  Return 0 if all went well, -1 for an error
 * with an option, or 1 for -help.
 */

static int parse_options(int ac, char **av)
{
    int i, n;
    char *s, *t;

    debug = 0;
    for (i = 1; i < ac; i++) {
	s = av[i];
	if (*s == '-') {
	    s++;
	    if (strcmp(s, "remote") == 0) {
		if (++i >= ac) {
		    fprintf(stderr, "-remote requires hostname[:port]\n");
		    return -1;
		}
		s = av[i];
		t = strchr(s, ':');
		if (t) {
		    *t++ = 0;
		    if (atoi(t) > 0)
			RemotePort = atoi(t);
		    else {
			fprintf(stderr, "-remote: port number must be a positive integer.  Using default.");
			return -1;
		    }
		    t[-1] = ':';
		}
		RemoteServer = s;
	    } else if (strcmp(s, "local") == 0) {
		if (++i >= ac) {
		    fprintf(stderr, "-local requires hostname or [hostname]:[port]\n");
		    return -1;
		}
		s = av[i];
		t = strchr(s, ':');
		if (t) {
		    *t = 0;
		    n = atoi(t+1);
		    if (n >= 0)
			LocalPort = n;
		    else
			fprintf(stderr, "-local: port number must be a positive integer or 0.  Using default.\n");
		    *t = ':';
		}
		LocalHost = s;
	    } else if (strcmp(s, "name") == 0) {
		if (++i >= ac) {
		    fprintf(stderr, "-name requires a parameter\n");
		    return -1;
		}
		ServerName = av[i];
	    } else if (strcmp(s, "desc") == 0) {
		if (++i >= ac) {
		    fprintf(stderr, "-desc requires a parameter\n");
		    return -1;
		}
		ServerDesc = av[i];
	    } else if (strcmp(s, "numeric") == 0) {
#ifdef IRC_UNREAL
		if (++i >= ac) {
		    fprintf(stderr, "-numeric requires a parameter\n");
		    return -1;
		}
		n = atoi(av[i]);
		if (n < 0 || n > 254)
		    fprintf(stderr, "-numeric parameter must be between 0 and 254 inclusive.  Using default.\n");
		else
		    ServerNumeric = n;
#else
		fprintf(stderr, "-numeric available only with Unreal IRC daemon\n");
		return -1;
#endif
	    } else if (strcmp(s, "user") == 0) {
		if (++i >= ac) {
		    fprintf(stderr, "-user requires a parameter\n");
		    return -1;
		}
		ServiceUser = av[i];
	    } else if (strcmp(s, "host") == 0) {
		if (++i >= ac) {
		    fprintf(stderr, "-host requires a parameter\n");
		    return -1;
		}
		ServiceHost = av[i];
	    } else if (strcmp(s, "dir") == 0) {
		if (++i >= ac) {
		    fprintf(stderr, "-dir requires a parameter\n");
		    return -1;
		}
		services_dir = av[i];
	    } else if (strcmp(s, "log") == 0) {
		if (++i >= ac) {
		    fprintf(stderr, "-log requires a parameter\n");
		    return -1;
		}
		log_filename = av[i];
	    } else if (strcmp(s, "update") == 0) {
		if (++i >= ac) {
		    fprintf(stderr, "-update requires a parameter\n");
		    return -1;
		}
		s = av[i];
		if (atoi(s) <= 0) {
		    fprintf(stderr, "-update: number of seconds must be positive");
		    return -1;
		} else
		    UpdateTimeout = atol(s);
	    } else if (strcmp(s, "expire") == 0) {
		if (++i >= ac) {
		    fprintf(stderr, "-expire requires a parameter\n");
		    return -1;
		}
		s = av[i];
		if (atoi(s) <= 0) {
		    fprintf(stderr, "-expire: number of seconds must be positive");
		    return -1;
		} else
		    ExpireTimeout = atol(s);
	    } else if (strcmp(s, "debug") == 0) {
		debug++;
	    } else if (strcmp(s, "readonly") == 0) {
		readonly = 1;
		skeleton = 0;
	    } else if (strcmp(s, "skeleton") == 0) {
		readonly = 0;
		skeleton = 1;
	    } else if (strcmp(s, "nofork") == 0) {
		nofork = 1;
	    } else if (strcmp(s, "forceload") == 0) {
		forceload = 1;
	    } else if (strcmp(s, "noexpire") == 0) {
		noexpire = 1;
	    } else if (strcmp(s, "noakill") == 0) {
		noakill = 1;
	    } else if (strcmp(s, "h") == 0 || strcmp(s, "help") == 0
		       || strcmp(s, "-help") == 0) {
		fputs(
"The following options are recognized:"
"	-remote server[:port]	Connect to the specified server"
"	-local host[:port]	Connect from the specified address (e.g."
"				    for multihomed servers)"
"	-name servername	Our server name (e.g. services.some.net)"
"	-desc string		Description of us (e.g. SomeNet Services)\n"
#ifdef IRC_UNREAL
"	-numeric numeric	Services server numeric (1-254 or 0 for none)\n"
#endif
"	-user username		Username for Services' nicks (e.g. services)"
"	-host hostname		Hostname for Services' nicks (e.g. some.net)"
"	-dir directory		Directory containing Services' data files"
"				    (e.g. /usr/local/lib/services)"
"	-log filename		Services log filename (e.g. services.log)"
"	-update secs		How often to update databases (in seconds)"
"	-expire secs		How often to check for nick/channel"
"				    expiration (in seconds)"
"	-debug			Enable debugging mode--more info sent to log"
"				    (give option more times for more info)"
"	-readonly		Enable read-only mode--no changes to"
"				    databases allowed, .db files and log"
"				    not written"
"	-skeleton		Enable skeleton mode--like read-only mode,"
"				    but only OperServ is available"
"	-nofork			Do not fork after startup; log messages will"
"				    be written to terminal (as well as to"
"				    the log file if not in read-only mode)"
"	-forceload		Try to load as much of the databases as"
"				    possible, even if errors are encountered"
"	-noexpire		Prevents all expirations (nicknames, channels,"
"				    akills, session limit exceptions, etc.)"
"	-noakill		Disables autokill checking"
, stdout);
		exit(0);
	    } else {
		fprintf(stderr, "Unknown option -%s.  Use \"-help\" for help.\n", s);
		return -1;
	    }
	} else {
	    fprintf(stderr, "Non-option arguments not allowed\n");
	    return -1;
	}
    }
    return 0;
}

/*************************************************************************/

/* Remove our PID file.  Done at exit. */

static void remove_pidfile(void)
{
    remove(PIDFilename);
}

/*************************************************************************/

/* Create our PID file and write the PID to it. */

static void write_pidfile(void)
{
    FILE *pidfile;

    pidfile = fopen(PIDFilename, "w");
    if (pidfile) {
	fprintf(pidfile, "%d\n", (int)getpid());
	fclose(pidfile);
	atexit(remove_pidfile);
    } else {
	log_perror("Warning: cannot write to PID file %s", PIDFilename);
    }
}

/*************************************************************************/

/* Overall initialization routine.  Returns 0 on success, -1 on failure. */

int init(int ac, char **av)
{

/* temporary
ChannelInfo *ci;
NickInfo *ni;
*/

    int i;
    int openlog_failed = 0, openlog_errno = 0;
    int started_from_term = isatty(0) && isatty(1) && isatty(2);


    /* Initialize pseudo-random number generator. */
    srand(time(NULL) ^ getppid() ^ getpid()<<16);

    /* Set file creation mask and group ID. */
#if defined(DEFUMASK) && HAVE_UMASK
    umask(DEFUMASK);
#endif
    if (set_group() < 0)
	return -1;

    /* Parse command-line options; exit if an error occurs. */
    if (parse_options(ac, av) < 0)
	return -1;

    /* Chdir to Services data directory. */
    if (chdir(services_dir) < 0) {
	fprintf(stderr, "chdir(%s): %s\n", services_dir, strerror(errno));
	return -1;
    }

    /* Open logfile, and complain if we didn't. */
    if (open_log() < 0) {
	openlog_errno = errno;
	if (started_from_term) {
	    fprintf(stderr, "Warning: unable to open log file %s: %s\n",
			log_filename, strerror(errno));
	} else {
	    openlog_failed = 1;
	}
    }

    /* Read configuration file; exit if there are problems. */
    if (!read_config())
	return -1;

    /* Re-parse command-line options (to override configuration file). */
    parse_options(ac, av);

    /* Detach ourselves if requested. */
    if (!nofork) {
	if ((i = fork()) < 0) {
	    perror("fork()");
	    return -1;
	} else if (i != 0) {
	    exit(0);
	}
	if (started_from_term) {
	    close(0);
	    close(1);
	    close(2);
	}
	if (setpgid(0, 0) < 0) {
	    perror("setpgid()");
	    return -1;
	}
    }

#ifdef MEMCHECKS
    /* Account for runtime memory.  Do this after forking to avoid a bogus
     * "XXX bytes leaked on exit" message when the parent exits. */
    init_memory();
#endif

    /* Write our PID to the PID file. */
    write_pidfile();

    /* Announce ourselves to the logfile. */
    if (debug || readonly || skeleton || noexpire) {
	log("Services %s (compiled for %s) starting up (options:%s%s%s%s)",
	    version_number, version_protocol,
	    debug ? " debug" : "",
	    readonly ? " readonly" : "",
	    skeleton ? " skeleton" : "",
	    noexpire ? " noexpire" : "");
    } else {
	log("Services %s (compiled for %s) starting up",
	    version_number, version_protocol);
    }
    start_time = time(NULL);

    /* If in read-only mode, close the logfile again. */
    if (readonly)
	close_log();

    /* Set signal handlers.  Catch certain signals to let us do things or
     * panic as necessary, and ignore all others.
     */
#ifdef NSIG
    for (i = 1; i <= NSIG; i++) {
#else
    for (i = 1; i <= 32; i++) {
#endif
	if (i != SIGPROF)
	    signal(i, SIG_IGN);
    }

    signal(SIGINT, weirdsig_handler);
    signal(SIGTERM, weirdsig_handler);
    signal(SIGQUIT, weirdsig_handler);
#ifndef DUMPCORE
    signal(SIGSEGV, weirdsig_handler);
#endif
    signal(SIGBUS, weirdsig_handler);
    signal(SIGQUIT, weirdsig_handler);
    signal(SIGHUP, weirdsig_handler);
    signal(SIGILL, weirdsig_handler);
    signal(SIGTRAP, weirdsig_handler);
    signal(SIGFPE, weirdsig_handler);
#ifdef SIGIOT
    signal(SIGIOT, weirdsig_handler);
#endif

    /* This is our "out-of-memory" panic switch */
    signal(SIGUSR1, weirdsig_handler);

    /* Initialize multi-language support */
    lang_init();
    if (debug)
	log("debug: Loaded languages");

    /* Initialiize subservices */
    ns_init();
    cs_init();

#ifdef USE_MYSQL
    if(!db_connect(1))
      fatal("could not connect to mysql database");
#endif

    /* Load up databases */
    if (!skeleton) {

        db_load_ns();
	//load_ns_dbase();

	if (debug)
	    log("debug: Loaded %s database (1/7)", s_NickServ);

        db_load_cs();
	//load_cs_dbase();

	if (debug)
	    log("debug: Loaded %s database (2/7)", s_ChanServ);

/* start: temporary code */

/*
    for (ni = firstnick(); ni; ni = nextnick()) {
      genpass(ni->pass);
      email_pass(ni->email ? ni->email : "invalid", ni->pass, ni->nick);
      log("debug: genpass for [%s]", ni->nick);
#ifdef USE_ENCRYPTION
      encrypt_in_place(ni->pass, PASSMAX - 1);
#endif
      db_nick_set(ni, "pass", ni->pass);
    }

    for(ci = cs_firstchan(); ci; ci = cs_nextchan()) {
      genpass(ci->founderpass);
      email_pass(ci->email ? ci->email : "invalid", ci->founderpass, ci->name);
      log("debug: genpass for [%s]", ci->name);
#ifdef USE_ENCRYPTION
      encrypt_in_place(ci->founderpass, PASSMAX - 1);
#endif
      db_chan_set(ci, "founderpass", ci->founderpass);
    }

    exit(0);
*/

/*
    for (ni = firstnick(); ni; ni = nextnick()) {
       if(db_add_nick(ni) == -1)
         log("dberror: while adding nicks. continuing");
    }

    for(ci = cs_firstchan(); ci; ci = cs_nextchan()) {
      if(db_add_channel(ci) == -1)
        log("dberror: while adding channels. continuing");
    }

    exit(1);
*/

/* end: temporary code */

    }
    log("Databases loaded");

    /* Connect to the remote server */
    servsock = conn(RemoteServer, RemotePort, LocalHost, LocalPort);
    if (servsock < 0)
	fatal_perror("Can't connect to server");
    send_server();
    sgets2(inbuf, sizeof(inbuf), servsock);
    if (strnicmp(inbuf, "ERROR", 5) == 0) {
	/* Close server socket first to stop wallops, since the other
	 * server doesn't want to listen to us anyway */
	disconn(servsock);
	servsock = -1;
	fatal("Remote server returned: %s", inbuf);
    }

    /* Announce a logfile error if there was one */
    if (openlog_failed) {
	wallops(NULL, "Warning: couldn't open logfile: %s",
		strerror(openlog_errno));
    }

    /* Bring in our pseudo-clients */
    introduce_user(NULL);

    /* Success! */
    return 0;
}

/*************************************************************************/
