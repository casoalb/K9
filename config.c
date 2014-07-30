/* Configuration file handling.
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

/* Configurable variables: */

char *RemoteServer;
int   RemotePort;
char *RemotePassword;
char *LocalHost;
int   LocalPort;

char *DBhost;
int  DBport;
char *DBuser;
char *DBpass;
char *DBname;

char *ServerName;
char *ServerDesc;
char *CMDMark;
char *ServiceUser;
char *ServiceHost;
char *ServiceMask;
int   ServerNumeric;
static char *temp_userhost;

char *s_NickServ;
char *s_ChanServ;
char *s_MemoServ;

char *desc_NickServ;
char *desc_ChanServ;
char *desc_MemoServ;

char *PIDFilename;
char *MOTDFilename;
char *HelpDir;
char *NickDBName;
char *ChanDBName;

int   NoBackupOkay;
int   NoBouncyModes;
int   NoSplitRecovery;
int   StrictPasswords;
int   BadPassLimit;
int   BadPassTimeout;
int   BadPassWarning;
int   BadPassSuspend;
int   UpdateTimeout;
int   ExpireTimeout;
int   ReadTimeout;
int   WarningTimeout;
int   TimeoutCheck;
int   PingFrequency;
int   MergeChannelModes;

int   NSForceNickChange;
char *NSGuestNickPrefix;
int   NSDefFlags;
int   NSRegDelay;
int   NSRequireEmail;
int   NSExpire;
int   NSExpireWarning;
int   NSAccessMax;
char *NSEnforcerUser;
char *NSEnforcerHost;
int   NSReleaseTimeout;
int   NSAllowKillImmed;
int   NSMaxLinkDepth;
int   NSListOpersOnly;
int   NSListMax;
int   NSSecureAdmins;
int   NSSuspendExpire;
int   NSSuspendGrace;

int   CSMaxReg;
int   CSExpire;
int   CSAccessMax;
int   CSAutokickMax;
char *CSAutokickReason;
char *CSAutobanReason;
char *CSDefaultbanTime;
int   CSInhabit;
int   CSRestrictDelay;
int   CSListOpersOnly;
int   CSListMax;
int   CSSuspendExpire;
int   CSSuspendGrace;

int   MSMaxMemos;
int   MSSendDelay;
int   MSNotifyAll;

int   WallGetpass;
int   WallSetpass;
int   WallOper;

char *ServicesRoot;
int   LogMaxUsers;

/******* Local use only: *******/

static int   NSDefNone;
static int   NSDefKill;
static int   NSDefKillQuick;
static int   NSDefSecure;
static int   NSDefPrivate;
static int   NSDefHideEmail;
static int   NSDefHideUsermask;
static int   NSDefHideQuit;
static int   NSDefMemoSignon;
static int   NSDefMemoReceive;
static int   NSDisableLinkCommand;
static char *temp_nsuserhost;

/*************************************************************************/

/* Deprecated directive (dep_) and value checking (chk_) functions: */

/*************************************************************************/

#define MAXPARAMS	8

/* Configuration directives. */

typedef struct {
    char *name;
    struct {
	int type;	/* PARAM_* below */
	int flags;	/* Same */
	void *ptr;	/* Pointer to where to store the value */
    } params[MAXPARAMS];
} Directive;

#define PARAM_NONE	0
#define PARAM_INT	1
#define PARAM_POSINT	2	/* Positive integer only */
#define PARAM_PORT	3	/* 1..65535 only */
#define PARAM_STRING	4
#define PARAM_TIME	5
#define PARAM_TIMEMSEC	6	/* Variable is in milliseconds, parameter
				 *    in seconds (decimal allowed) */
#define PARAM_SET	-1	/* Not a real parameter; just set the
				 *    given integer variable to 1 */
#define PARAM_DEPRECATED -2	/* Set for deprecated directives; `ptr'
				 *    is a function pointer to call */

/* Flags: */
#define PARAM_OPTIONAL	0x01
#define PARAM_FULLONLY	0x02	/* Directive only allowed if !STREAMLINED */

Directive directives[] = {
    { "BadPassLimit",     { { PARAM_POSINT, 0, &BadPassLimit } } },
    { "BadPassSuspend",   { { PARAM_POSINT, 0, &BadPassSuspend } } },
    { "BadPassTimeout",   { { PARAM_TIME, 0, &BadPassTimeout } } },
    { "BadPassWarning",   { { PARAM_POSINT, 0, &BadPassWarning } } },
    { "ChanServDB",       { { PARAM_STRING, 0, &ChanDBName } } },
    { "ChanServName",     { { PARAM_STRING, 0, &s_ChanServ },
                            { PARAM_STRING, 0, &desc_ChanServ } } },
    { "CSAccessMax",      { { PARAM_POSINT, 0, &CSAccessMax } } },
    { "CSAutokickMax",    { { PARAM_POSINT, 0, &CSAutokickMax } } },
    { "CSAutokickReason", { { PARAM_STRING, 0, &CSAutokickReason } } },
    { "CSAutobanReason",  { { PARAM_STRING, 0, &CSAutobanReason } } },    
    { "CSDefaultbanTime",    { { PARAM_STRING, 0, &CSDefaultbanTime } } },    
    { "CSExpire",         { { PARAM_TIME, 0, &CSExpire } } },
    { "CSInhabit",        { { PARAM_TIME, 0, &CSInhabit } } },
    { "CSListMax",        { { PARAM_POSINT, 0, &CSListMax } } },
    { "CSListOpersOnly",  { { PARAM_SET, 0, &CSListOpersOnly } } },
    { "CSMaxReg",         { { PARAM_POSINT, 0, &CSMaxReg } } },
    { "CSRestrictDelay",  { { PARAM_TIME, 0, &CSRestrictDelay } } },
    { "CSSuspendExpire",  { { PARAM_TIME, 0 , &CSSuspendExpire },
                            { PARAM_TIME, 0 , &CSSuspendGrace } } },
    { "HelpDir",          { { PARAM_STRING, 0, &HelpDir } } },
    { "LocalAddress",     { { PARAM_STRING, 0, &LocalHost },
                            { PARAM_PORT, PARAM_OPTIONAL, &LocalPort } } },
    { "MemoServName",     { { PARAM_STRING, 0, &s_MemoServ },
                            { PARAM_STRING, 0, &desc_MemoServ } } },
    { "MergeChannelModes",{ { PARAM_TIMEMSEC, 0, &MergeChannelModes } } },
    { "MOTDFile",         { { PARAM_STRING, 0, &MOTDFilename } } },
    { "MSMaxMemos",       { { PARAM_POSINT, 0, &MSMaxMemos } } },
    { "MSNotifyAll",      { { PARAM_SET, 0, &MSNotifyAll } } },
    { "MSSendDelay",      { { PARAM_TIME, 0, &MSSendDelay } } },
	        
    { "NickservDB",       { { PARAM_STRING, 0, &NickDBName } } },
    { "NickServName",     { { PARAM_STRING, 0, &s_NickServ },
                            { PARAM_STRING, 0, &desc_NickServ } } },
    { "NoBackupOkay",     { { PARAM_SET, 0, &NoBackupOkay } } },
    { "NoBouncyModes",    { { PARAM_SET, 0, &NoBouncyModes } } },
    { "NoSplitRecovery",  { { PARAM_SET, 0, &NoSplitRecovery } } },
    { "NSAccessMax",      { { PARAM_POSINT, 0, &NSAccessMax } } },
    { "NSAllowKillImmed", { { PARAM_SET, 0, &NSAllowKillImmed } } },
    { "NSDefHideEmail",   { { PARAM_SET, 0, &NSDefHideEmail } } },
    { "NSDefHideQuit",    { { PARAM_SET, 0, &NSDefHideQuit } } },
    { "NSDefHideUsermask",{ { PARAM_SET, 0, &NSDefHideUsermask } } },
    { "NSDefKill",        { { PARAM_SET, 0, &NSDefKill } } },
    { "NSDefKillQuick",   { { PARAM_SET, 0, &NSDefKillQuick } } },
    { "NSDefMemoReceive", { { PARAM_SET, 0, &NSDefMemoReceive } } },
    { "NSDefMemoSignon",  { { PARAM_SET, 0, &NSDefMemoSignon } } },
    { "NSDefNone",        { { PARAM_SET, 0, &NSDefNone } } },
    { "NSDefPrivate",     { { PARAM_SET, 0, &NSDefPrivate } } },
    { "NSDefSecure",      { { PARAM_SET, 0, &NSDefSecure } } },
    { "NSDisableLinkCommand",{{PARAM_SET, 0, &NSDisableLinkCommand } } },
    { "NSEnforcerUser",   { { PARAM_STRING, 0, &temp_nsuserhost } } },
    { "NSExpire",         { { PARAM_TIME, 0, &NSExpire } } },
    { "NSExpireWarning",  { { PARAM_TIME, 0, &NSExpireWarning } } },
    { "NSForceNickChange",{ { PARAM_SET, 0, &NSForceNickChange } } },
    { "NSGuestNickPrefix",{ { PARAM_STRING, 0, &NSGuestNickPrefix } } },
    { "NSListMax",        { { PARAM_POSINT, 0, &NSListMax } } },
    { "NSListOpersOnly",  { { PARAM_SET, 0, &NSListOpersOnly } } },
    { "NSMaxLinkDepth",   { { PARAM_INT, 0, &NSMaxLinkDepth } } },
    { "NSRegDelay",       { { PARAM_TIME, 0, &NSRegDelay } } },
    { "NSRequireEmail",   { { PARAM_SET, 0, &NSRequireEmail } } },
    { "NSReleaseTimeout", { { PARAM_TIME, 0, &NSReleaseTimeout } } },
    { "NSSecureAdmins",   { { PARAM_SET, 0, &NSSecureAdmins } } },
    { "NSSuspendExpire",  { { PARAM_TIME, 0 , &NSSuspendExpire },
                            { PARAM_TIME, 0 , &NSSuspendGrace } } },
    { "PIDFile",          { { PARAM_STRING, 0, &PIDFilename } } },
    { "PingFrequency",    { { PARAM_TIME, 0, &PingFrequency } } },
    { "ReadTimeout",      { { PARAM_TIME, 0, &ReadTimeout } } },
    { "RemoteServer",     { { PARAM_STRING, 0, &RemoteServer },
                            { PARAM_PORT, 0, &RemotePort },
                            { PARAM_STRING, 0, &RemotePassword } } },
    { "ServerDesc",       { { PARAM_STRING, 0, &ServerDesc } } },
    { "CMDMark",          { { PARAM_STRING, 0, &CMDMark } } },    
    { "ServerName",       { { PARAM_STRING, 0, &ServerName } } },
    { "ServerNumeric",	  { { PARAM_POSINT, 0, &ServerNumeric } } },

    { "ServicesRoot",     { { PARAM_STRING, 0, &ServicesRoot } } },
    { "ServiceUser",      { { PARAM_STRING, 0, &temp_userhost } } },

    { "StrictPasswords",  { { PARAM_SET, 0, &StrictPasswords } } },
    
    { "UpdateTimeout",    { { PARAM_TIME, 0, &UpdateTimeout } } },
    { "ExpireTimeout",    { { PARAM_TIME, 0, &ExpireTimeout } } },    
    { "WarningTimeout",   { { PARAM_TIME, 0, &WarningTimeout } } },    

    { "WallSetpass",      { { PARAM_SET, 0, &WallSetpass } } },
    { "WallGetpass",      { { PARAM_SET, 0, &WallGetpass } } },
    { "WallOper",         { { PARAM_SET, 0, &WallOper } } },    
    
    { "LogMaxUsers",      { { PARAM_SET, 0, &LogMaxUsers } } },    
    { "TimeoutCheck",     { { PARAM_TIMEMSEC, 0, &TimeoutCheck } } },
    { "ServicesDB",       { { PARAM_STRING, 0, &DBhost },
                            { PARAM_INT, 0, &DBport },
                            { PARAM_STRING, 0, &DBuser },
                            { PARAM_STRING, 0, &DBpass },
                            { PARAM_STRING, 0, &DBname } } },
};

/*************************************************************************/

/* Print an error message to the log (and the console, if open). */

void error(int linenum, char *message, ...)
{
    char buf[4096];
    va_list args;

    va_start(args, message);
    vsnprintf(buf, sizeof(buf), message, args);
#ifndef NOT_MAIN
    if (linenum)
	log("%s:%d: %s", SERVICES_CONF, linenum, buf);
    else
	log("%s: %s", SERVICES_CONF, buf);
    if (!nofork && isatty(2)) {
#endif
	if (linenum)
	    fprintf(stderr, "%s:%d: %s\n", SERVICES_CONF, linenum, buf);
	else
	    fprintf(stderr, "%s: %s\n", SERVICES_CONF, buf);
#ifndef NOT_MAIN
    }
#endif
}

/*************************************************************************/

/* Parse a configuration line.  Return 1 on success; otherwise, print an
 * appropriate error message and return 0.  Destroys the buffer by side
 * effect.
 */

int parse(char *buf, int linenum)
{
    char *s, *t, *dir;
    int i, n, optind, val;
    int retval = 1;
    int ac = 0;
    char *av[MAXPARAMS];

    dir = strtok(buf, " \t\r\n");
    s = strtok(NULL, "");
    if (s) {
	while (isspace(*s))
	    s++;
	while (*s) {
	    if (ac >= MAXPARAMS) {
		error(linenum, "Warning: too many parameters (%d max)",
			MAXPARAMS);
		break;
	    }
	    t = s;
	    if (*s == '"') {
		t++;
		s++;
		while (*s && *s != '"') {
		    if (*s == '\\' && s[1] != 0)
			s++;
		    s++;
		}
		if (!*s)
		    error(linenum, "Warning: unterminated double-quoted string");
		else
		    *s++ = 0;
	    } else {
		s += strcspn(s, " \t\r\n");
		if (*s)
		    *s++ = 0;
	    }
	    av[ac++] = t;
	    while (isspace(*s))
		s++;
	}
    }

    if (!dir)
	return 1;

    for (n = 0; n < lenof(directives); n++) {
	Directive *d = &directives[n];
	if (stricmp(dir, d->name) != 0)
	    continue;
	optind = 0;
	for (i = 0; i < MAXPARAMS && d->params[i].type != PARAM_NONE; i++) {
	    if (d->params[i].type == PARAM_SET) {
		*(int *)d->params[i].ptr = 1;
		continue;
	    }
#ifdef STREAMLINED
	    if (d->params[i].flags & PARAM_FULLONLY) {
		error(linenum, "Directive `%s' not available in STREAMLINED mode",
		      d->name);
		break;
	    }
#endif
	    if (d->params[i].type == PARAM_DEPRECATED) {
		void (*func)(void); /* For clarity */
		error(linenum, "Deprecated directive `%s' used", d->name);
		func = (void (*)(void))(d->params[i].ptr);
		if (func)
		    func();
		continue;
	    }
	    if (optind >= ac) {
		if (!(d->params[i].flags & PARAM_OPTIONAL)) {
		    error(linenum, "Not enough parameters for `%s'", d->name);
		    retval = 0;
		}
		break;
	    }
	    switch (d->params[i].type) {
	      case PARAM_INT:
		val = strtol(av[optind++], &s, 0);
		if (*s) {
		    error(linenum, "%s: Expected an integer for parameter %d",
			d->name, optind);
		    retval = 0;
		    break;
		}
		*(int *)d->params[i].ptr = val;
		break;
	      case PARAM_POSINT:
		val = strtol(av[optind++], &s, 0);
		if (*s || val <= 0) {
		    error(linenum,
			"%s: Expected a positive integer for parameter %d",
			d->name, optind);
		    retval = 0;
		    break;
		}
		*(int *)d->params[i].ptr = val;
		break;
	      case PARAM_PORT:
		val = strtol(av[optind++], &s, 0);
		if (*s) {
		    error(linenum,
			"%s: Expected a port number for parameter %d",
			d->name, optind);
		    retval = 0;
		    break;
		}
		if (val < 1 || val > 65535) {
		    error(linenum,
			"Port numbers must be in the range 1..65535");
		    retval = 0;
		    break;
		}
		*(int *)d->params[i].ptr = val;
		break;
	      case PARAM_STRING:
		*(char **)d->params[i].ptr = strdup(av[optind++]);
		if (!d->params[i].ptr) {
		    error(linenum, "%s: Out of memory", d->name);
		    return 0;
		}
		break;
	      case PARAM_TIME:
		val = dotime(av[optind++]);
		if (val < 0) {
		    error(linenum,
			"%s: Expected a time value for parameter %d",
			d->name, optind);
		    retval = 0;
		    break;
		}
		*(int *)d->params[i].ptr = val;
		break;
	      case PARAM_TIMEMSEC:
		val = strtol(av[optind++], &s, 10);
		if (val < 0) {
		    error(linenum,
			"%s: Expected a positive value for parameter %d",
			d->name, optind);
		    retval = 0;
		    break;
		} else if (val > 1000000) {
		    error(linenum, "%s: Value too large (maximum 1000000)",
			  d->name);
		}
		val *= 1000;
		if (*s++ == '.') {
		    int decimal = 0;
		    int count = 0;
		    while (count < 3 && isdigit(*s)) {
			decimal = decimal*10 + (*s++ - '0');
			count++;
		    }
		    while (count++ < 3)
			decimal *= 10;
		    val += decimal;
		}
		*(uint32 *)d->params[i].ptr = val;
		break;
	      default:
		error(linenum, "%s: Unknown type %d for param %d",
				d->name, d->params[i].type, i+1);
		return 0;  /* don't bother continuing--something's bizarre */
	    }
	}
	break;	/* because we found a match */
    }

    if (n == lenof(directives)) {
	error(linenum, "Unknown directive `%s'", dir);
	return 1;	/* don't cause abort */
    }

    return retval;
}

/*************************************************************************/

#define CHECK(v) do {			\
    if (!v) {				\
	error(0, #v " missing");	\
	retval = 0;			\
    }					\
} while (0)

#define CHEK2(v,n) do {			\
    if (!v) {				\
	error(0, #n " missing");	\
	retval = 0;			\
    }					\
} while (0)

/* Read the entire configuration file.  If an error occurs while reading
 * the file or a required directive is not found, print and log an
 * appropriate error message and return 0; otherwise, return 1.
 */

int read_config()
{
    FILE *config;
    int linenum = 1, retval = 1;
    char buf[1024], *s;

    config = fopen(SERVICES_CONF, "r");
    if (!config) {
#ifndef NOT_MAIN
	log_perror("Can't open " SERVICES_CONF);
	if (!nofork && isatty(2))
#endif
	    perror("Can't open " SERVICES_CONF);
	return 0;
    }
    while (fgets(buf, sizeof(buf), config)) {
	s = strchr(buf, '#');
	if (s)
	    *s = 0;
	if (!parse(buf, linenum))
	    retval = 0;
	linenum++;
    }
    fclose(config);

    CHECK(RemoteServer);
    CHECK(ServerName);
    CHECK(ServerDesc);
    CHECK(CMDMark);
    CHEK2(temp_userhost, ServiceUser);
    CHEK2(s_NickServ, NickServName);
    CHEK2(s_ChanServ, ChanServName);
    CHEK2(s_MemoServ, MemoServName);    
    CHEK2(PIDFilename, PIDFile);
    CHEK2(MOTDFilename, MOTDFile);
    CHECK(HelpDir);
    CHEK2(NickDBName, NickServDB);
    CHEK2(ChanDBName, ChanServDB);
    CHECK(UpdateTimeout);
    CHECK(ExpireTimeout);
    CHECK(ReadTimeout);
    CHECK(WarningTimeout);
    CHECK(TimeoutCheck);
    CHECK(NSAccessMax);
    CHEK2(temp_nsuserhost, NSEnforcerUser);
    CHECK(NSReleaseTimeout);
    CHECK(NSMaxLinkDepth);
    CHECK(NSListMax);
    CHECK(CSAccessMax);
    CHECK(CSAutokickMax);
    CHECK(CSAutokickReason);
    CHECK(CSAutobanReason);
    CHECK(CSDefaultbanTime);    
    CHECK(CSInhabit);
    CHECK(CSListMax);
    CHECK(ServicesRoot);

#ifdef IRC_UNREAL
    if (ServerNumeric < 0 || ServerNumeric > 254) {
    	error(0, "ServerNumeric must be in the range 1..254");
	retval = 0;
    }
#endif

    /* Note: setting expire timeouts at less than 1 day may result in
     * bogus help messages (see NICK_HELP and CHAN_HELP). */
    if (NSExpire > 0 && NSExpire < 86400) {
	error(0, "NSExpire may not be set less than 1 day");
	retval = 0;
    }
    if (CSExpire > 0 && CSExpire < 86400) {
	error(0, "CSExpire may not be set less than 1 day");
	retval = 0;
    }

    if (NSDisableLinkCommand)
	NSMaxLinkDepth = 0;
    if (NSMaxLinkDepth > LINK_HARDMAX) {
	printf("WARNING: NSMaxLinkDepth (%d) > LINK_HARDMAX (%d), resetting to %d\n",
	       NSMaxLinkDepth, LINK_HARDMAX, LINK_HARDMAX);
	NSMaxLinkDepth = LINK_HARDMAX;
    }

    if (temp_userhost) {
	if (!(s = strchr(temp_userhost, '@'))) {
	    error(0, "Missing `@' for ServiceUser");
	} else {
	    *s++ = 0;
	    ServiceUser = temp_userhost;
	    ServiceHost = s;
	}
    }

    if (temp_nsuserhost) {
	if (!(s = strchr(temp_nsuserhost, '@'))) {
	    NSEnforcerUser = temp_nsuserhost;
	    NSEnforcerHost = ServiceHost;
	} else {
	    *s++ = 0;
	    NSEnforcerUser = temp_userhost;
	    NSEnforcerHost = s;
	}
    }

    if (!NSDefNone &&
		!NSDefKill &&
		!NSDefKillQuick &&
		!NSDefSecure &&
		!NSDefPrivate &&
		!NSDefHideEmail &&
		!NSDefHideUsermask &&
		!NSDefHideQuit &&
                !NSDefMemoSignon &&
		!NSDefMemoReceive
    ) {
	NSDefSecure = 1;
        NSDefMemoSignon = 1;
	NSDefMemoReceive = 1;
    }

    NSDefFlags = 0;
    if (NSDefKill)
	NSDefFlags |= NI_KILLPROTECT;
    if (NSDefKillQuick)
	NSDefFlags |= NI_KILL_QUICK;
    if (NSDefSecure)
	NSDefFlags |= NI_SECURE;
    if (NSDefPrivate)
	NSDefFlags |= NI_PRIVATE;
    if (NSDefHideEmail)
	NSDefFlags |= NI_HIDE_EMAIL;
    if (NSDefHideUsermask)
	NSDefFlags |= NI_HIDE_MASK;
    if (NSDefHideQuit)
	NSDefFlags |= NI_HIDE_QUIT;
    if (NSDefMemoSignon)
        NSDefFlags |= NI_MEMO_SIGNON;
    if (NSDefMemoReceive)
        NSDefFlags |= NI_MEMO_RECEIVE;

    ServiceMask = (char *) smalloc(strlen(s_ChanServ)+strlen(ServiceUser)+strlen(ServiceHost)+3);
    memset(ServiceMask, '\0', sizeof(ServiceMask) );
    sprintf(ServiceMask, "%s!%s@%s", s_ChanServ, ServiceUser, ServiceHost );
	    	
    return retval;
}

/*************************************************************************/
