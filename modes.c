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
**
**      *** DO NOT DISTRIBUTE ***
**/   
	  
#include "services.h"

/*************************************************************************/

/* List of user/channel modes and associated mode letters. */

struct flag {
    char mode;
    int32 flag;
    char prefix;  /* Prefix for channel user mode (e.g. +o -> '@') */
};

static const struct flag umodes[] = {
    { 'o', UMODE_o },
    { 'i', UMODE_i },
    { 'w', UMODE_w },
    { 'g', UMODE_g },
#ifdef IRC_DALNET
    { 'h', UMODE_h },
#endif
#ifdef IRC_DAL4_4_15
    { 'r', UMODE_r },
    { 'a', UMODE_a },
    { 'A', UMODE_A },
#endif
#ifdef IRC_UNREAL
    { 'N', UMODE_N },
    { 'T', UMODE_T },
    { 'x', UMODE_x },
    { 'S', UMODE_S },
    { 'q', UMODE_q },
    { 'I', UMODE_I },
    { 'd', UMODE_d },
#endif
    { 0, 0 }
};

static const struct flag cmodes[] = {
    { 'i', CMODE_i },
    { 'm', CMODE_m },
    { 'n', CMODE_n },
    { 'p', CMODE_p },
    { 's', CMODE_s },
    { 't', CMODE_t },
    { 'k', CMODE_k },
    { 'l', CMODE_l },
#ifdef IRC_DAL4_4_15
    { 'R', CMODE_R },
    { 'r', CMODE_r },
#endif
#if defined(IRC_BAHAMUT) || defined(IRC_UNREAL)
    { 'c', CMODE_c },
    { 'O', CMODE_O },
#endif
#ifdef IRC_UNREAL
    { 'A', CMODE_A },
    { 'z', CMODE_z },
    { 'Q', CMODE_Q },
    { 'K', CMODE_K },
    { 'V', CMODE_V },
    { 'H', CMODE_H },
    { 'C', CMODE_C },
    { 'N', CMODE_N },
    { 'S', CMODE_S },
    { 'G', CMODE_G },
    { 'u', CMODE_u },
    { 'f', CMODE_f },
#endif
#ifdef IRC_BAHAMUT
    { 'M', CMODE_M },
#endif

    { 0, 0 }
};

static const struct flag cumodes[] = {
    { 'o', CUMODE_o, '@' },
    { 'v', CUMODE_v, '+' },
#ifdef IRC_UNREAL
    { 'h', CUMODE_h, '%' },
    { 'a', CUMODE_a, '~' },
    { 'q', CUMODE_q, '*' },
#endif
    { 0, 0, 0 }
};

static const struct flag *modetable[] = { umodes, cmodes, cumodes };

/*************************************************************************/
/*************************************************************************/

/* Return the flag corresponding to the given mode character, or 0 if no
 * such mode exists.
 */

int32 mode_char_to_flag(char c, int which)
{
    int i;
    const struct flag *modelist = modetable[which];

    for (i = 0; modelist[i].mode != 0 && modelist[i].mode != c; i++)
	;
    return modelist[i].flag;
}

/*************************************************************************/

/* Return the mode character corresponding to the given flag, or 0 if no
 * such mode exists.
 */

char mode_flag_to_char(int32 f, int which)
{
    int i;
    const struct flag *modelist = modetable[which];

    for (i = 0; modelist[i].flag != 0 && modelist[i].flag != f; i++)
	;
    return modelist[i].mode;
}

/*************************************************************************/

/* Return the flag set corresponding to the given string of mode
 * characters, or (CMODE_INVALID | modechar) if an invalid mode character
 * is found.
 */

int32 mode_string_to_flags(char *s, int which)
{
    int32 flags = 0;
    const struct flag *modelist = modetable[which];

    while (*s) {
	int i;
	for (i = 0; modelist[i].mode != 0 && modelist[i].mode != *s; i++)
	    ;
	if (!modelist[i].mode)
	    return MODE_INVALID | *s;
	flags |= modelist[i].flag;
    }
    return flags;
}

/*************************************************************************/

/* Return the string of mode characters corresponding to the given flag
 * set.  If the flag set has invalid flags in it, they are ignored.
 * The returned string is stored in a static buffer which will be
 * overwritten on the next call.
 */

char *mode_flags_to_string(int32 flags, int which)
{
    static char buf[32];
    char *s = buf;
    int i;
    const struct flag *modelist = modetable[which];

    for (i = 0; modelist[i].mode != 0; i++) {
	if (flags & modelist[i].flag)
	    *s++ = modelist[i].mode;
    }
    *s = 0;
    return buf;
}

/*************************************************************************/

/* Return the flag corresponding to the given channel user mode prefix, or
 * 0 if no such mode exists.
 */

int32 cumode_prefix_to_flag(char c)
{
    int i;

    for (i = 0; cumodes[i].prefix != 0 && cumodes[i].prefix != c; i++)
	;
    return cumodes[i].flag;
}

/*************************************************************************/
