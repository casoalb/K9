/* Main header for Services.
**
** K9 IRC Services (c) 2001-2002
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
	  
#ifndef SERVICES_H
#define SERVICES_H

/*************************************************************************/

#include "sysconf.h"
#include "config.h"

/* Some Linux boxes (or maybe glibc includes) require this for the
 * prototype of strsignal(). */
#define _GNU_SOURCE

/* Some AIX boxes define int16 and int32 on their own.  Blarph. */
#if INTTYPE_WORKAROUND
# define int16 builtin_int16
# define int32 builtin_int32
#endif

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>
#include <time.h>
#include <ctype.h>
#include <errno.h>
#include <grp.h>
#include <limits.h>
#include <netdb.h>
#include <netinet/in.h>
#include <setjmp.h>
#include <sys/socket.h>
#include <sys/stat.h>	/* for umask() on some systems */
#include <sys/types.h>
#include <sys/time.h>

#ifdef USE_MYSQL
#include <mysql/mysql.h>
#include <mysql/errmsg.h>
#endif

#if HAVE_STRINGS_H
# include <strings.h>
#endif

#if HAVE_SYS_SELECT_H
# include <sys/select.h>
#endif

#ifdef _AIX
/* Some AIX boxes seem to have bogus includes that don't have these
 * prototypes. */
extern int strcasecmp(const char *, const char *);
extern int strncasecmp(const char *, const char *, size_t);
# if 0	/* These break on some AIX boxes (4.3.1 reported). */
extern int gettimeofday(struct timeval *, struct timezone *);
extern int socket(int, int, int);
extern int bind(int, struct sockaddr *, int);
extern int connect(int, struct sockaddr *, int);
extern int shutdown(int, int);
# endif
# undef FD_ZERO
# define FD_ZERO(p) memset((p), 0, sizeof(*(p)))
#endif /* _AIX */

/* Alias stricmp/strnicmp to strcasecmp/strncasecmp if we have the latter
 * but not the former. */
#if !HAVE_STRICMP && HAVE_STRCASECMP
# define stricmp strcasecmp
# define strnicmp strncasecmp
#endif

/* We have our own encrypt(). */
#define encrypt encrypt_


#if INTTYPE_WORKAROUND
# undef int16
# undef int32
#endif


/* Miscellaneous definitions. */
#include "defs.h"

/*************************************************************************/

/* Configuration sanity-checking: */

#if MAX_SERVOPERS > 32767
# undef MAX_SERVOPERS
# define MAX_SERVOPERS 32767
#endif
#if MAX_SERVADMINS > 32767
# undef MAX_SERVADMINS
# define MAX_SERVADMINS 32767
#endif

/*************************************************************************/
/*************************************************************************/

/* Version number for data files; if structures below change, increment
 * this.  (Otherwise -very- bad things will happen!) */

#define FILE_VERSION	12

/*************************************************************************/

/* Types corresponding to various structures.  These have to come first
 * because some structures reference each other circularly. */

typedef struct user_ User;
typedef struct channel_ Channel;
typedef struct server_ Server;
typedef struct serverstats_ ServerStats;

typedef struct nickinfo_ NickInfo;
typedef struct chaninfo_ ChannelInfo;
typedef struct memoinfo_ MemoInfo;

/*************************************************************************/

/* Languages.  Never insert anything in (or delete anything from) the
 * middle of this list, or everybody will start getting the wrong language!
 * If you want to change the order the languages are displayed in for
 * NickServ HELP SET LANGUAGE, do it in language.c.
 */
#define LANG_EN_US	0	/* United States English */
#define LANG_UNUSED1	1	/* Unused; was Japanese (JIS encoding) */
#define LANG_JA_EUC	2	/* Japanese (EUC encoding) */
#define LANG_JA_SJIS	3	/* Japanese (SJIS encoding) */
#define LANG_ES		4	/* Spanish */
#define LANG_PT		5	/* Portugese */
#define LANG_FR		6	/* French */
#define LANG_TR		7	/* Turkish */
#define LANG_IT		8	/* Italian */
#define LANG_DE		9	/* German */
#define LANG_NL		10	/* Dutch */

#define NUM_LANGS	11	/* Number of languages */

/* Sanity-check on default language value */
#if DEF_LANGUAGE < 0 || DEF_LANGUAGE >= NUM_LANGS
# error Invalid value for DEF_LANGUAGE: must be >= 0 and < NUM_LANGS
#endif

/*************************************************************************/

/* Suspension info structure. */

typedef struct suspendinfo_ SuspendInfo;
struct suspendinfo_ {
    char who[NICKMAX];	/* who added this suspension */
    char *reason;
    time_t suspended;
    time_t expires;	/* 0 for no expiry */
};

/*************************************************************************/

/* Constants for "what" parameter to clear_channel(). */

#define CLEAR_MODES	0x0001	/* Binary modes */
#define CLEAR_BANS	0x0002
#define CLEAR_EXCEPTS	0x0004
#define CLEAR_UMODES	0x0008	/* User modes (+v, +o) */

#define CLEAR_USERS	0x8000	/* Kick all users and empty the channel */

/*************************************************************************/

/* Ignorance list data. */

typedef struct ignore_data {
    struct ignore_data *next;
    char who[NICKMAX];
    time_t time;	/* When do we stop ignoring them? */
} IgnoreData;

/*************************************************************************/

/* MYSQL DB function return value defines */
#define DB_ERROR   -1
#define DB_EXIST   -2
#define DB_NOEXIST  0
#define DB_SUCCESS  1

/* db_test_chan() flags */
#define DB_TEST_CHAN     7
#define DB_TEST_COMMENTS 6
#define DB_TEST_ENTRYMSG 5
#define DB_TEST_ACCESS   4
#define DB_TEST_AUTOOP   3
#define DB_TEST_LEVELS   2
#define DB_TEST_AKICK    1
#define DB_TEST_ALL      0

/* db_update_count() flags */
#define DB_NICKACCESS 6
#define DB_ENTRYMSG   5
#define DB_ACCESS     4
#define DB_AUTOOP     3
#define DB_LEVELS     2
#define DB_AKICK      1
#define DB_COMMENTS   0


/*************************************************************************/

/* &chanopts being one of the first things in the .data section makes
 * it a great valid address to check pointers against. It will not
 * detect invalid pointers that are higher than &chanopts */

#define IsValidPtr(a) ((int)a > (int)&chanopts)

/*************************************************************************/

/* All other "main" include files. */

#include "memory.h"
#include "modes.h"
#include "users.h"
#include "channels.h"
#include "servers.h"
#include "nickserv.h"
#include "k9.h"

#include "extern.h"

/*************************************************************************/

#endif	/* SERVICES_H */
