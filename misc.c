/* Miscellaneous routines.
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

#include <ctype.h>	  
#include "services.h"

/*************************************************************************/

/* irc_toupper/tolower:  Like toupper/tolower, but for nicknames and
 *                       channel names; the RFC requires that '[' and '{',
 *                       '\' and '|', ']' and '}' be pairwise equivalent.
 *                       Declared inline for irc_stricmp()'s benefit.
 */

static const unsigned char irc_uppertable[256] = {
    0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,
    0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F,
    0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,
    0x18,0x19,0x1A,0x1B,0x1C,0x1D,0x1E,0x1F,
    0x20,0x21,0x22,0x23,0x24,0x25,0x26,0x27,
    0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,
    0x30,0x31,0x32,0x33,0x34,0x35,0x36,0x37,
    0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,

    0x40,0x41,0x42,0x43,0x44,0x45,0x46,0x47,
    0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,
    0x50,0x51,0x52,0x53,0x54,0x55,0x56,0x57,
    0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,
    0x60,0x41,0x42,0x43,0x44,0x45,0x46,0x47,
    0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,
    0x50,0x51,0x52,0x53,0x54,0x55,0x56,0x57,
#ifdef VIOLATES_RFC1459_CASE
    0x58,0x59,0x5A,0x7B,0x7C,0x7D,0x7E,0x7F,
#else
    0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x7E,0x7F,
#endif

    0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,
    0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,
    0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,
    0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F,
    0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,
    0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,
    0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,
    0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF,

    0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,
    0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,
    0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,
    0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF,
    0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,
    0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,
    0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,
    0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF,
};

static const unsigned char irc_lowertable[256] = {
    0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,
    0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F,
    0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,
    0x18,0x19,0x1A,0x1B,0x1C,0x1D,0x1E,0x1F,
    0x20,0x21,0x22,0x23,0x24,0x25,0x26,0x27,
    0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,
    0x30,0x31,0x32,0x33,0x34,0x35,0x36,0x37,
    0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,

    0x40,0x61,0x62,0x63,0x64,0x65,0x66,0x67,
    0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,
    0x70,0x71,0x72,0x73,0x74,0x75,0x76,0x77,
#ifdef VIOLATES_RFC1459_CASE
    0x78,0x79,0x7A,0x5B,0x5C,0x5D,0x5E,0x5F,
#else
    0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x5E,0x5F,
#endif
    0x60,0x61,0x62,0x63,0x64,0x65,0x66,0x67,
    0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,
    0x70,0x71,0x72,0x73,0x74,0x75,0x76,0x77,
    0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x7F,

    0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,
    0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,
    0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,
    0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F,
    0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,
    0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,
    0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,
    0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF,

    0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,
    0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,
    0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,
    0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF,
    0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,
    0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,
    0xF0,0xF1,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,
    0xF8,0xF9,0xFA,0xFB,0xFC,0xFD,0xFE,0xFF,
};

inline unsigned char irc_toupper(char c)
{
    return irc_uppertable[(unsigned char)c];
}

inline unsigned char irc_tolower(char c)
{
    return irc_lowertable[(unsigned char)c];
}

/*************************************************************************/

/* irc_stricmp:  Like stricmp, but for nicknames and channel names. */

int irc_stricmp(const char *s1, const char *s2)
{
    register char c1, c2;

    while ((c1 = (char)irc_tolower(*s1)) == (c2 = (char)irc_tolower(*s2))) {
	if (c1 == 0)
	    return 0;
	s1++;
	s2++;
    }
    return c1<c2 ? -1 : 1;
}

/*************************************************************************/

/* strscpy:  Copy at most len-1 characters from a string to a buffer, and
 *           add a null terminator after the last character copied.
 */

char *strscpy(char *d, const char *s, size_t len)
{
    char *d_orig = d;

    if (!len)
	return d;
    while (--len && (*d++ = *s++))
	;
    *d = 0;
    return d_orig;
}

/*************************************************************************/

/* stristr:  Search case-insensitively for string s2 within string s1,
 *           returning the first occurrence of s2 or NULL if s2 was not
 *           found.
 */

char *stristr(char *s1, char *s2)
{
    register char *s = s1, *d = s2;

    while (*s1) {
	if (tolower(*s1) == tolower(*d)) {
	    s1++;
	    d++;
	    if (*d == 0)
		return s;
	} else {
	    s = ++s1;
	    d = s2;
	}
    }
    return NULL;
}

/*************************************************************************/

/* strupper, strlower:  Convert a string to upper or lower case.
 */

char *strupper(char *s)
{
    char *t = s;
    while (*t) {
	*t = toupper(*t);
	t++;
    }
    return s;
}

char *strlower(char *s)
{
    char *t = s;
    while (*t) {
	*t = tolower(*t);
	t++;
    }
    return s;
}

/*************************************************************************/

/* strnrepl:  Replace occurrences of `old' with `new' in string `s'.  Stop
 *            replacing if a replacement would cause the string to exceed
 *            `size' bytes (including the null terminator).  Return the
 *            string.
 */

char *strnrepl(char *s, int32 size, const char *old, const char *new)
{
    char *ptr = s;
    int32 left = strlen(s);
    int32 avail = size - (left+1);
    int32 oldlen = strlen(old);
    int32 newlen = strlen(new);
    int32 diff = newlen - oldlen;

    while (left >= oldlen) {
	if (strncmp(ptr, old, oldlen) != 0) {
	    left--;
	    ptr++;
	    continue;
	}
	if (diff > avail)
	    break;
	if (diff != 0)
	    memmove(ptr+oldlen+diff, ptr+oldlen, left+1);
	strncpy(ptr, new, newlen);
	ptr += newlen;
	left -= oldlen;
    }
    return s;
}

/*************************************************************************/
/*************************************************************************/

/* merge_args:  Take an argument count and argument vector and merge them
 *              into a single string in which each argument is separated by
 *              a space.
 */

char *merge_args(int argc, char **argv)
{
    int i;
    static char s[4096];
    char *t;

    t = s;
    for (i = 0; i < argc; i++)
	t += snprintf(t, sizeof(s)-(t-s), "%s%s", *argv++, (i<argc-1) ? " " : "");
    return s;
}

/*************************************************************************/
/*************************************************************************/

/* match_wild:  Attempt to match a string to a pattern which might contain
 *              '*' or '?' wildcards.  Return 1 if the string matches the
 *              pattern, 0 if not.
 */

static int do_match_wild(const char *pattern, const char *str, int docase)
{
    char c;
    const char *s;

    /* This WILL eventually terminate: either by *pattern == 0, or by a
     * trailing '*' (or "*???..."). */

    if (!pattern || !str)
      return 0;

    for (;;) {
	switch (c = *pattern++) {
	  case 0:
	    if (!*str)
		return 1;
	    return 0;
	  case '?':
	    if (!*str)
		return 0;
	    str++;
	    break;
	  case '*':
	    while (*pattern == '?') {
		if (!*str)
		    return 0;
		str++;		/* skip a character for each '?' */
		pattern++;
	    }
	    if (!*pattern)
		return 1;	/* trailing '*' matches everything else */
	    s = str;
	    while (*s) {
		if ((docase ? (*s==*pattern) : (tolower(*s)==tolower(*pattern)))
					&& do_match_wild(pattern+1, s+1, docase))
		    return 1;
		s++;
	    }
	    break;
	  default:
	    if (docase ? (*str != c) : (tolower(*str) != tolower(c)))
		return 0;
	    str++;
	    break;
	} /* switch */
    }
    /* not reached */
}


int match_wild(const char *pattern, const char *str)
{
    return do_match_wild(pattern, str, 1);
}

int match_wild_nocase(const char *pattern, const char *str)
{
    if (!pattern || !str)
      return 0;

    return do_match_wild(pattern, str, 0);
}

/*************************************************************************/
/*************************************************************************/

/* Check whether the given string is a valid domain name, according to RFC
 * rules:
 *   - Contains only letters, digits, hyphens, and periods (dots).
 *   - Begins with a letter or digit.
 *   - Has a letter or digit after every dot (except for a trailing dot).
 *   - Is no more than DOMAIN_MAXLEN characters long.
 *   - Has no more than DOMPART_MAXLEN characters between periods.
 *   - Has at least one character and does not end with a dot. (not RFC)
 */

#define DOMAIN_MAXLEN	255
#define DOMPART_MAXLEN	63

int valid_domain(const char *str)
{
    const char *s;
    int i;
    static const char valid_domain_chars[] =
	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-.";

    if (!*str)
	return 0;
    if (str[strspn(str,valid_domain_chars)] != 0)
	return 0;
    s = str;
    while (s-str < DOMAIN_MAXLEN && *s) {
	if (*s == '-' || *s == '.')
	    return 0;
	i = strcspn(s, ".");
	if (i > DOMPART_MAXLEN)
	    return 0;
	s += i;
	if (*s)
	    s++;
    }
    if (s-str > DOMAIN_MAXLEN || *s)
	return 0;
    if (s[-1] == '.')
	return 0;
    return 1;
}

/*************************************************************************/

/* Check whether the given string is a valid E-mail address.  A valid
 * E-mail address:
 *   - Contains none of the following characters:
 *       + control characters (\000-\037)
 *       + space (\040)
 *       + vertical bar ('|') (because some mailers try to pipe with it)
 *       + RFC-822 specials, except [ ] @ .
 *   - Contains exactly one '@', which may not be the first character.
 *   - Contains a valid domain name after the '@'.
 * FIXME: allow [1.2.3.4] style domains but forbid [] otherwise
 */

int valid_email(const char *str)
{
    const unsigned char *s;
    const char *atmark;

    for (s = (const unsigned char *)str; *s; s++) {
	if (*s <= '\040')  // 040 == 0x20 == ' '
	    return 0;
	if (strchr("|,:;\\\"()<>", *s))
	    return 0;
    }
    atmark = strchr(str, '@');
    if (!atmark || atmark == str)
	return 0;
    atmark++;
    /* Valid domain names cannot contain '@' so we just check valid_domain();
     * also prohibit domains without dots */
    return strchr(atmark, '.') && valid_domain(atmark);
}

/*************************************************************************/

/* Check whether the given string is a valid URL.  A valid URL:
 *   - Contains neither control characters (\000-\037) nor spaces (\040).
 *   - Contains a series of letters followed by "://" followed by a valid
 *     domain name, possibly followed by a : and a numeric port number in
 *     the range 1-65535, followed either by a slash and possibly more text
 *     by nothing.
 */

int valid_url(const char *str)
{
    const unsigned char *s, *colon, *host;
    static const char letters[] =
	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    char domainbuf[DOMAIN_MAXLEN+1];

    for (s = (const unsigned char *)str; *s; s++) {
	if (*s <= '\040')  // 040 == 0x20 == ' '
	    return 0;
    }
    s = (const unsigned char *)strstr(str, "://");
    if (!s)
	return 0;
    if (strspn(str, letters) != s - (const unsigned char *)str)
	return 0;
    host = s+3;
    colon = (const unsigned char *)strchr(host, ':');
    /* s will eventually point to the expected end of the host string */
    s = host + strcspn(host, "/");
    if (colon && colon < s) {
	int port = strtol(colon+1, (char **)&colon, 10);
	if (port < 1 || port > 65535 || colon != s)
	    return 0;
	s = colon;
    }
    /* The string from host through s-1 must be a valid domain name.
     * Check length (must be >=1, <=DOMAIN_MAXLEN), then copy into
     * temporary buffer and check.  Also discard domain names without
     * dots in them. */
    if (s-host < 1 || s-host > DOMAIN_MAXLEN)
	return 0;
    memcpy(domainbuf, host, s-host);
    domainbuf[s-host] = 0;
    return strchr(domainbuf, '.') && valid_domain(domainbuf);
}

/*************************************************************************/
/*************************************************************************/

#ifndef NOT_MAIN

/* Process a string containing a number/range list in the form
 * "n1[-n2][,n3[-n4]]...", calling a caller-specified routine for each
 * number in the list.  If the callback returns -1, stop immediately.
 * Returns the sum of all nonnegative return values from the callback.
 * If `count' is non-NULL, it will be set to the total number of times the
 * callback was called.
 *
 * The number list will never contain duplicates and will always be sorted
 * ascendingly. This means the callback routines don't have to worry about
 * being called twice for the same index. -TheShadow
 * Also, the only values accepted are 0-65536 (inclusive), to avoid someone
 * giving us 0-2^31 and causing freezes or out-of-memory.  Numbers outside
 * this range will be ignored.
 *
 * The callback should be of type range_callback_t, which is defined as:
 *	int (*range_callback_t)(User *u, int num, va_list args)
 */


int process_numlist(const char *numstr, int *count_ret,
		range_callback_t callback, User *u, ...)
{
    int n1, n2, min, max, i;
    int retval = 0;
    int numcount = 0;
    va_list args;
    static char numflag[65537];

    memset(numflag, 0, sizeof(numflag));
    min = 65536;
    max = 0;
    va_start(args, u);

    /* This algorithm ignores invalid characters, ignores a dash
     * when it precedes a comma, and ignores everything from the
     * end of a valid number or range to the next comma or null.
     */
    while (*numstr) {
        n1 = n2 = strtol(numstr, (char **)&numstr, 10);
        numstr += strcspn(numstr, "0123456789,-");
        if (*numstr == '-') {
            numstr++;
            numstr += strcspn(numstr, "0123456789,");
            if (isdigit(*numstr)) {
                n2 = strtol(numstr, (char **)&numstr, 10);
                numstr += strcspn(numstr, "0123456789,-");
            }
        }
	if (n1 < 0)
	    n1 = 0;
	if (n2 > 65536)
	    n2 = 65536;
	if (n1 < min)
	    min = n1;
	if (n2 > max)
	    max = n2;
        while (n1 <= n2) {
	    numflag[n1] = 1;
	    n1++;
	}
        numstr += strcspn(numstr, ",");
        if (*numstr)
            numstr++;
    }

    /* Now call the callback routine for each index. */
    numcount = 0;
    for (i = min; i <= max; i++) {
	int res;
	if (!numflag[i])
	    continue;
	numcount++;
	res = callback(u, i, args);
	if (debug)
	    log("debug: process_numlist: tried to do %d; result = %d", i, res);
	if (res < 0)
	    break;
	retval += res;
    }

    va_end(args);
    if (count_ret)
        *count_ret = numcount;
    return retval;
}

#endif	/* !NOT_MAIN */

/*************************************************************************/
/*************************************************************************/

/* time_msec:  Return the current time to millisecond resolution. */

uint32 time_msec(void)
{
#ifdef HAVE_GETTIMEOFDAY
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_sec*1000 + tv.tv_usec/1000;
#else
    return time(NULL) * 1000;
#endif
}

/*************************************************************************/

/* dotime:  Return the number of seconds corresponding to the given time
 *          string.  If the given string does not represent a valid time,
 *          return -1.
 *
 *          A time string is either a plain integer (representing a number
 *          of seconds), an integer followed by one of these characters:
 *          "s" (seconds), "m" (minutes), "h" (hours), or "d" (days), or a
 *          sequence of such integer-character pairs (without separators,
 *          e.g. "1h30m").
 */

int dotime(const char *s)
{
    int amount;

    amount = strtol(s, (char **)&s, 10);
    if (*s) {
	char c = *s++;
	int rest = dotime(s);
	if (rest < 0)
	    return -1;
	switch (c) {
	    case 's': return rest + amount;
	    case 'm': return rest + amount*60;
	    case 'h': return rest + amount*3600;
	    case 'd': return rest + amount*86400;
	    default : return -1;
	}
    } else {
	return amount;
    }
}

/* Check whether the given string is a valid Channel NAME.
 *   - Contains neither control characters (\000-\037) nor spaces (\040). 
  *   - Contains a series of letters followed by "://" followed by a valid
   *     domain name, possibly followed by a : and a numeric port number in
    *     the range 1-65535, followed either by a slash and possibly more text
     *     by nothing.
      */
      

#define CHANNELLEN 32

int valid_channel(const char *channame, int type)
{
	char *chan = strdup(channame);
	unsigned char *cn;
	int i;
	int endnull = 0;
                
	cn = chan;
	if ( !chan || !(type && cn[0] == '#') || (cn[0] == '&') )
	{
		return 0;
	}

	if (strlen(chan) > CHANMAX)
		return 0;

	for (i = 0 ; i < strlen(cn); i++)
		if ( ((int) cn[i] < 33) || ((int) cn[i] > 255))    /* Filter out color codes, and sequences */
			return 0;
                                                    
	for (i = 0; i <= CHANNELLEN; i++)
	{
		if (chan[i] == '\0')
		{
        		endnull = 1;
       			break;
        	}
        }
        if (endnull)
		return 1;
                                                                
	return 0;
}
                                                                                                                                            
/*************************************************************************/

int check_w32_device(unsigned char *param)
{
	int p;
	int m = 0;
	char *tdev;	

	typedef struct {
		char *device;
               } Devices;

        Devices dos_devices[] = {
				{ "CON"      },
				{ "AUX"      },
				{ "NUL"      },
				{ "PRN"      },
				{ "LPT"      }, { "LPT1" }, { "LPT2" }, { "LPT3" }, { "LPT4" }, { "LPT5" }, { "LPT6" }, { "LPT7" }, { "LPT8" }, { "LPT9" },
				{ "COM1"     }, { "COM2" }, { "COM3" }, { "COM4" }, { "COM5" }, { "COM6" }, { "COM7" }, { "COM8" }, { "COM9" },
				{ "CLOCK$"   },
				{ "CONFIG$"  },
				{ "XMSXXXX0" },
				{ "$MMXXXX0" },
				{ "MSCD000"  },
				{ "DBLBUFF$" },
				{ "EMMXXXX0" },
				{ "IFS$HLP$" },
				{ "SETVERXX" },
				{ "SCSIMGR$" },
				{ "DBLSBIN$" },
				{ NULL }
                                };       
		Devices *d_devs; 

	
               	for(p=0;param[p]!=0;p++)
		{
			param[p]=toupper ((unsigned char) param[p]);

                }

		/* Check to see if the sound file contains any directory delims or file extensions */
		if ( (strstr(param, "/") != NULL) || (strstr(param, "\\") != NULL) || (strstr(param, ".") != NULL) )
		{
			/* If it does, break it up by the delims we tested for and cycle through the fields */
			while((tdev = strsep((char **) &param, "./\\")) != NULL)
			{
				/* Cycle through all of the windows special device names */
				for (d_devs=dos_devices; d_devs->device; d_devs++)
                		{
					/* And test to see if the current device matches the file the user wanted to play    */
					/* Also check to see if matches is less than two as two special devices are required */
					/* in a file name to exploit the bug. Innocent files could also possibly be called   */
					/* con.wav, lpt.wav etc.							     */

					if ((strcmp(d_devs->device, tdev) == 0) && (m < 2)) 
					{
						/* If it does increment m (matches) by one */
						m++;
					}
				}
			}
		}

		/* If it doesnt contain any of the delims required to exploit the vuln then no point in bothering witht he above */
		else
		{
			return 0;
		}

		/* If we matched 2 or more W32 device file references then its almost certainly a DoS attempt. */
		if (m >= 2) 
		{		
				return -1;
		}	

	return 0;
}
