/* Multi-language support.
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
**
**      *** DO NOT DISTRIBUTE ***
**/   
 
	  
#include "services.h"
#include "language.h"

/*************************************************************************/

/* The list of lists of messages. */
char **langtexts[NUM_LANGS];

/* The list of names of languages. */
char *langnames[NUM_LANGS];

/* Indexes of available languages: */
int langlist[NUM_LANGS];

/* Order in which languages should be displayed: (alphabetical) */
static int langorder[] = {
    LANG_EN_US,		/* English (US) */
    LANG_NL,		/* Dutch */
/*    LANG_FR,*/	/* French */
    LANG_DE,		/* German */
    LANG_IT,		/* Italian */
/*    LANG_JA_JIS,*/	/* Japanese (JIS encoding) */
    LANG_JA_EUC,	/* Japanese (EUC encoding) */
    LANG_JA_SJIS,	/* Japanese (SJIS encoding) */
    LANG_PT,		/* Portugese */
    LANG_ES,		/* Spanish */
    LANG_TR,		/* Turkish */
};

/* Filenames for language files: */
static const char *filenames[] = {
    [LANG_EN_US]	"en_us",
    [LANG_NL]		"nl",
    [LANG_FR]		"fr",
    [LANG_DE]		"de",
    [LANG_IT]		"it",
/*    [LANG_JA_JIS]	"ja_jis",*/
    [LANG_JA_EUC]	"ja_euc",
    [LANG_JA_SJIS]	"ja_sjis",
    [LANG_PT]		"pt",
    [LANG_ES]		"es",
    [LANG_TR]		"tr",
};

/*************************************************************************/

/* Load a language file. */

static int read_int32(int32 *ptr, FILE *f)
{
    int a = fgetc(f);
    int b = fgetc(f);
    int c = fgetc(f);
    int d = fgetc(f);
    if (a == EOF || b == EOF || c == EOF || d == EOF)
	return -1;
    *ptr = a<<24 | b<<16 | c<<8 | d;
    return 0;
}

static void load_lang(int index, const char *filename)
{
    char buf[256];
    FILE *f;
    int num, i;

    if (debug) {
	log("debug: Loading language %d from file `languages/%s'",
		index, filename);
    }
    snprintf(buf, sizeof(buf), "languages/%s", filename);
    if (!(f = fopen(buf, "r"))) {
	log_perror("Failed to load language %d (%s)", index, filename);
	return;
    } else if (read_int32(&num, f) < 0) {
	log("Failed to read number of strings for language %d (%s)",
		index, filename);
	return;
    } else if (num != NUM_STRINGS) {
	log("Warning: Bad number of strings (%d, wanted %d) "
	    "for language %d (%s)", num, NUM_STRINGS, index, filename);
    }
    langtexts[index] = scalloc(sizeof(char *), NUM_STRINGS);
    if (num > NUM_STRINGS)
	num = NUM_STRINGS;
    for (i = 0; i < num; i++) {
	int32 pos, len;
	fseek(f, i*8+4, SEEK_SET);
	if (read_int32(&pos, f) < 0 || read_int32(&len, f) < 0) {
	    log("Failed to read entry %d in language %d (%s) TOC",
			i, index, filename);
	    goto fail;
	}
	if (len == 0) {
	    langtexts[index][i] = NULL;
	} else if (len >= 65536) {
	    log("Entry %d in language %d (%s) is too long (over 64k)--"
		"corrupt TOC?", i, index, filename);
	    goto fail;
	} else if (len < 0) {
	    log("Entry %d in language %d (%s) has negative length--"
		"corrupt TOC?", i, index, filename);
	    goto fail;
	} else {
	    langtexts[index][i] = smalloc(len+1);
	    fseek(f, pos, SEEK_SET);
	    if (fread(langtexts[index][i], 1, len, f) != len) {
		log("Failed to read string %d in language %d (%s)",
			i, index, filename);
		free(langtexts[index][i]);
		goto fail;
	    }
	    langtexts[index][i][len] = 0;
	}
    }
    fclose(f);
    return;

  fail:
    while (--i >= 0) {
	if (langtexts[index][i])
	    free(langtexts[index][i]);
    }
    free(langtexts[index]);
    langtexts[index] = NULL;
    return;
}

/*************************************************************************/

/* Initialize list of lists. */

void lang_init()
{
    int i, j, n = 0;

    for (i = 0; i < lenof(langorder); i++)
	load_lang(langorder[i], filenames[langorder[i]]);

    if (!langtexts[DEF_LANGUAGE])
	fatal("Unable to load default language");

    for (i = 0; i < lenof(langorder); i++) {
	if (langtexts[langorder[i]] != NULL) {
	    langnames[langorder[i]] = langtexts[langorder[i]][LANG_NAME];
	    for (j = 0; j < NUM_STRINGS; j++) {
		if (!langtexts[langorder[i]][j])
		    langtexts[langorder[i]][j] = langtexts[DEF_LANGUAGE][j];
		if (!langtexts[langorder[i]][j])
		    langtexts[langorder[i]][j] = langtexts[LANG_EN_US][j];
	    }
	    langlist[n++] = langorder[i];
	}
    }
    while (n < NUM_LANGS)
	langlist[n++] = -1;

    for (i = 0; i < NUM_LANGS; i++) {
	if (!langtexts[i])
	    langtexts[i] = langtexts[DEF_LANGUAGE];
    }
}

/*************************************************************************/
/*************************************************************************/

/* Format a string in a strftime()-like way, but heed the user's language
 * setting for month and day names.  The string stored in the buffer will
 * always be null-terminated, even if the actual string was longer than the
 * buffer size.
 * Assumption: No month or day name has a length (including trailing null)
 * greater than BUFSIZE or contains the '%' character.
 */

int strftime_lang(char *buf, int size, User *u, int format, struct tm *tm)
{
    int language = u && u->ni ? u->ni->language : DEF_LANGUAGE;
    char tmpbuf[BUFSIZE], buf2[BUFSIZE];
    char *s;
    int i, ret;

    strscpy(tmpbuf, langtexts[language][format], sizeof(tmpbuf));
    if ((s = langtexts[language][STRFTIME_DAYS_SHORT]) != NULL) {
	for (i = 0; i < tm->tm_wday; i++)
	    s += strcspn(s, "\n")+1;
	i = strcspn(s, "\n");
	strncpy(buf2, s, i);
	buf2[i] = 0;
	strnrepl(tmpbuf, sizeof(tmpbuf), "%a", buf2);
    }
    if ((s = langtexts[language][STRFTIME_DAYS_LONG]) != NULL) {
	for (i = 0; i < tm->tm_wday; i++)
	    s += strcspn(s, "\n")+1;
	i = strcspn(s, "\n");
	strncpy(buf2, s, i);
	buf2[i] = 0;
	strnrepl(tmpbuf, sizeof(tmpbuf), "%A", buf2);
    }
    if ((s = langtexts[language][STRFTIME_MONTHS_SHORT]) != NULL) {
	for (i = 0; i < tm->tm_mon; i++)
	    s += strcspn(s, "\n")+1;
	i = strcspn(s, "\n");
	strncpy(buf2, s, i);
	buf2[i] = 0;
	strnrepl(tmpbuf, sizeof(tmpbuf), "%b", buf2);
    }
    if ((s = langtexts[language][STRFTIME_MONTHS_LONG]) != NULL) {
	for (i = 0; i < tm->tm_mon; i++)
	    s += strcspn(s, "\n")+1;
	i = strcspn(s, "\n");
	strncpy(buf2, s, i);
	buf2[i] = 0;
	strnrepl(tmpbuf, sizeof(tmpbuf), "%B", buf2);
    }
    ret = strftime(buf, size, tmpbuf, tm);
    if (ret == size)
	buf[size-1] = 0;
    return ret;
}

/*************************************************************************/

/* Generates a description for the given expiration time in the form of
 * days, hours, minutes, seconds and/or a combination thereof.  May also
 * return "does not expire" or "expires soon" messages if the expiration
 * time given is zero or earlier than the current time, respectively.
 */

void expires_in_lang(char *buf, int size, NickInfo *ni, time_t expires)
{
    int32 seconds = expires - time(NULL) + 59; /* Round up to next minute */

    if (expires == 0) {
	strscpy(buf, getstring(ni,EXPIRES_NONE), size);
    } else if (seconds <= 59) {
	/* Original "expires" was <= now */
	strscpy(buf, getstring(ni,EXPIRES_SOON), size);
    } else if (seconds < 3600) {
	seconds /= 60;
	if (seconds == 1)
	    snprintf(buf, size, getstring(ni,EXPIRES_1M), seconds);
	else
	    snprintf(buf, size, getstring(ni,EXPIRES_M), seconds);
    } else if (seconds < 86400) {
	seconds /= 60;
	if (seconds/60 == 1) {
	    if (seconds%60 == 1)
		snprintf(buf, size, getstring(ni,EXPIRES_1H1M),
			 seconds/60, seconds%60);
	    else
		snprintf(buf, size, getstring(ni,EXPIRES_1HM),
			 seconds/60, seconds%60);
	} else {
	    if (seconds%60 == 1)
		snprintf(buf, size, getstring(ni,EXPIRES_H1M),
			 seconds/60, seconds%60);
	    else
		snprintf(buf, size, getstring(ni,EXPIRES_HM),
			 seconds/60, seconds%60);
	}
    } else {
	seconds /= 86400;
	if (seconds == 1)
	    snprintf(buf, size, getstring(ni,EXPIRES_1D), seconds);
	else
	    snprintf(buf, size, getstring(ni,EXPIRES_D), seconds);
    }
}

/*************************************************************************/
/*************************************************************************/

/* Send a syntax-error message to the user. */

void syntax_error(const char *service, User *u, const char *command, int msgnum)
{
    const char *str = getstring(u->ni, msgnum);
    notice_lang(service, u, SYNTAX_ERROR, str);
    notice_lang(service, u, MORE_INFO, service, command);
}

/*************************************************************************/
