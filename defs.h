/* Set default values for any constants that should be in include files but
** aren't, or that have wacky values.  Also define things based on IRC
** server type.
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
	  
/*************************************************************************/

/* Generally useful macros/constants. */

/*************************************************************************/

#ifndef NAME_MAX
# define NAME_MAX 255
#endif
#ifndef PATH_MAX
# define PATH_MAX 1023
#endif

/* Length of an array: */
#define lenof(a)	(sizeof(a) / sizeof(*(a)))

/* Telling compilers about printf()-like functions: */
#ifdef __GNUC__
# define FORMAT(type,fmt,start) __attribute__((format(type,fmt,start)))
#else
# define FORMAT(type,fmt,start)
#endif

/*************************************************************************/
/*************************************************************************/

/* Macros/defines based on IRC server type. */

/*************************************************************************/

/* Servers that break RFC 1459 case rules (i.e. that differentiate [ \ ]
 * from { | }). */

#if defined(IRC_DALNET)
# define VIOLATES_RFC1459_CASE
#endif

/*************************************************************************/

/* Who sends channel MODE (and KICK) commands? */

#if defined(IRC_DALNET) || (defined(IRC_UNDERNET) && !defined(IRC_UNDERNET_NEW))
# define MODE_SENDER(service) service
#else
# define MODE_SENDER(service) ServerName
#endif

/*************************************************************************/

/* Do we have some way of changing user nicks remotely? */

#ifdef IRC_DAL4_4_15
# define HAVE_NICKCHANGE
#endif

/*************************************************************************/

/* Do we have ban exceptions? */

#if defined(IRC_BAHAMUT) || defined(IRC_UNREAL)
# define HAVE_BANEXCEPT
#endif

/*************************************************************************/

/* Do we have halfop (+h) mode? */

#ifdef IRC_UNREAL
# define HAVE_HALFOP
#endif

/*************************************************************************/

/* Do we have channel protect (+a) mode?
 * NOTE: We assume that if +a is available, channel owner (+q) mode is also
 *       available.  If this is not the case, a new #define will be needed
 *       and check_chan_user_modes() will need to be modified.
 */

#ifdef IRC_UNREAL
# define HAVE_CHANPROT
#endif

/*************************************************************************/

/* Can we send NOTICE $* :message (wildcard in top domain)? */

#ifdef IRC_UNREAL
# define HAVE_ALLWILD_NOTICE
#endif

/*************************************************************************/
