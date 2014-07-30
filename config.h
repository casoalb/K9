/* K9 IRC Services configuration.
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

	  
#ifndef CONFIG_H
#define CONFIG_H

/* Note that most of the options which used to be here have been moved to
 * k9.conf. */

/*************************************************************************/

/* Should we try and deal with old (v2.x) databases?  Define this if you're
 * upgrading from v2.2.26 or earlier. */
/* #define COMPATIBILITY_V2 */


/******* General configuration *******/

/* Name of Cservice Channel */
#define CSChan   "#Doghouse"

/* Name of Admins/Opers Channel */
#define AOChan   "#Nuthouse"

/* Name of configuration file (in K9 IRC Services directory) */
#define SERVICES_CONF	"k9.conf"

/* Name of log file (in Services directory) */
#define LOG_FILENAME	"k9.log"

/* Maximum amount of data from/to the network to buffer (bytes). */
#define NET_BUFSIZE	65536

/* Maximum number of channels to buffer modes for (for MergeChannelModes) */
#define MERGE_CHANMODES_MAX	3


/******* NickServ configuration *******/

/* Default language for newly registered nicks (and nicks imported from
 * old databases); see services.h for available languages (search for
 * "LANG_").  Unless you're running a regional network, you should probably
 * leave this at LANG_EN_US. */
#define DEF_LANGUAGE	LANG_EN_US

/* Absolute limit on depth of nick links; if we search for more than this
 * many iterations in nickserv.c/getlink(), assume we have run into a
 * circular link and break it.  This also serves as an upper bound on the
 * value of the NSMaxLinkDepth configuration option.
 * CAUTION: Reducing this value in an operational system may invalidate
 *          some nick links and/or channel counts--be careful! */
#define LINK_HARDMAX	42


/******* OperServ configuration *******/

/* What is the maximum number of Services admins we will allow? */
#define MAX_SERVADMINS	32

/* What is the maximum number of Services operators we will allow? */
#define MAX_SERVOPERS	64

/* How big a hostname list do we keep for clone detection?  On large nets
 * (over 500 simultaneous users or so), you may want to increase this if
 * you want a good chance of catching clones. */
#define CLONE_DETECT_SIZE 16

/* Define this to enable OperServ's debugging commands (Services root
 * only).  These commands are undocumented; "use the source, Luke!" */
/* #define DEBUG_COMMANDS */


/******************* END OF USER-CONFIGURABLE SECTION ********************/


/* If STREAMLINED is defined, undefine STATISTICS. You can't have both. */

#ifdef STREAMLINED
# undef STATISTICS
#endif


/* Size of input buffer (note: this is different from BUFSIZ)
 * This must be big enough to hold at least one full IRC message, or messy
 * things will happen. */
#define BUFSIZE		1024


/* Extra warning:  If you change these, your data files will be unusable! */

/* Maximum length of a channel name, including the trailing null.  Any
 * channels with a length longer than CHANMAX-1 (including the leading #)
 * will not be usable with ChanServ. */
#define CHANMAX		64

/* Maximum length of a nickname, including the trailing null.  This MUST be
 * at least one greater than the maximum allowable nickname length on your
 * network, or people will run into problems using Services!  The default
 * (32) works with all servers I know of. */
#define NICKMAX		32

/* Maximum length of a password */
#define PASSMAX		32

#define MASKLEN    256

/**************************************************************************/

#endif	/* CONFIG_H */
