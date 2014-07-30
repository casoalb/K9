/* Mode flag definitions.
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
**
**      *** DO NOT DISTRIBUTE ***
**/ 
	  
#ifndef MODES_H
#define MODES_H

/*************************************************************************/

#define MODE_INVALID	0x80000000	/* Used as error flag */
#define MODE_ALL	(~MODE_INVALID)	/* All possible modes */

/*************************************************************************/

/* User modes: */

/* Note that it is not necessary to define every mode supported by the
 * server here!  We only need to worry about the ones which make a
 * difference to Services operations.
 */

#define UMODE_o		0x00000001
#define UMODE_i		0x00000002
#define UMODE_w		0x00000004
#define UMODE_g		0x00000008
#ifdef IRC_DALNET
# define UMODE_h	0x00000010	/* Helpop */
#endif
#ifdef IRC_DAL4_4_15
# define UMODE_r	0x00000020	/* Registered nick */
# define UMODE_a	0x00000040	/* Services admin */
# define UMODE_A	0x00000080	/* Server admin */
#endif
#ifdef IRC_UNREAL
# define UMODE_N	0x00000100	/* Network admin */
# define UMODE_T	0x00000200	/* Technical admin */
# define UMODE_x	0x00000400	/* Hide hostmask */
# define UMODE_S	0x00000800	/* Services client */
# define UMODE_q	0x00001000	/* Cannot be kicked from chans */
# define UMODE_I	0x00002000	/* Completely invisible (joins etc) */
# define UMODE_d	0x00004000	/* Deaf */
#endif

/* User mode(s) set to indicate a registered nick: */
#ifdef IRC_DAL4_4_15
# define UMODE_REG	UMODE_r
#else
# define UMODE_REG	0
#endif

/*************************************************************************/

/* Channel modes: */

/* We generally want to define all modes supported by the server here, so
 * CLEARMODES and the like work correctly.
 */

#define CMODE_i		0x00000001
#define CMODE_m		0x00000002
#define CMODE_n		0x00000004
#define CMODE_p		0x00000008
#define CMODE_s		0x00000010
#define CMODE_t		0x00000020
#define CMODE_k		0x00000040	/* These two used only by ChanServ */
#define CMODE_l		0x00000080
#ifdef IRC_DAL4_4_15
# define CMODE_R	0x00000100	/* Only identified users can join */
# define CMODE_r	0x00000200	/* Set for all registered channels */
#endif
#if defined(IRC_BAHAMUT) || defined(IRC_UNREAL)
# define CMODE_c	0x00000400	/* No ANSI colors in channel */
# define CMODE_O	0x00000800	/* Only opers can join channel */
#endif
#ifdef IRC_UNREAL
# define CMODE_A	0x00001000	/* Only admins can join channel */
# define CMODE_z	0x00002000	/* Only secure (+z) users allowed */
# define CMODE_Q	0x00004000	/* No kicks */
# define CMODE_K	0x00008000	/* No knocks */
# define CMODE_V	0x00010000	/* No invites */
# define CMODE_H	0x00020000	/* No hiding (+I) users */
# define CMODE_C	0x00040000	/* No CTCPs */
# define CMODE_N	0x00080000	/* No nick changing */
# define CMODE_S	0x00100000	/* Strip colors */
# define CMODE_G	0x00200000	/* Strip "bad words" */
# define CMODE_u	0x00400000	/* Auditorium mode */
# define CMODE_f	0x00800000	/* Flood limit */
#endif
#ifdef IRC_BAHAMUT
# define CMODE_M        0x01000000
#endif

/* Channel mode(s) set to indicate a registered channel: */
#ifdef IRC_DAL4_4_15
# define CMODE_REG	CMODE_r
#else
# define CMODE_REG	0
#endif

/* Channel mode(s) indicating channels which only opers (or above) can
 * enter: */
#ifdef IRC_BAHAMUT
# define CMODE_OPERONLY	CMODE_O
#elif defined(IRC_UNREAL)
# define CMODE_OPERONLY	(CMODE_O | CMODE_A)
#else
# define CMODE_OPERONLY	0
#endif

/*************************************************************************/

/* Modes for users on channels: */

#define CUMODE_o	0x00000001
#define CUMODE_v	0x00000002
#ifdef IRC_UNREAL
# define CUMODE_h	0x00000004	/* Half-op */
# define CUMODE_a	0x00000008	/* Protected (no kicks?) */
# define CUMODE_q	0x00000010	/* Channel owner */
#endif

/*************************************************************************/
/*************************************************************************/

/* Values for "which" parameter to mode_* functions: */

#define MODE_USER	0	/* UMODE_* (user modes) */
#define MODE_CHANNEL	1	/* CMODE_* (binary channel modes) */
#define MODE_CHANUSER	2	/* CUMODE_* (channel modes for users) */

/*************************************************************************/

#endif	/* MODES_H */
