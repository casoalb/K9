/* Main processing code for Services.
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
#include "messages.h"

/*************************************************************************/
/*************************************************************************/

/* Use ignore code? */
int allow_ignore = 1;

/* People to ignore. */
static IgnoreData *ignore[1024];
#define HASH(nick) (((nick)[0]&31)<<5 | ((nick)[1]&31))

/*************************************************************************/

/* first_ignore, next_ignore: Iterate over the ignore list. */

static int iterator_char = 256;   /* return NULL initially */
static IgnoreData *iterator_ptr = NULL;

IgnoreData *first_ignore(void)
{
    iterator_char = -1;
    iterator_ptr = NULL;
    return next_ignore();
}

IgnoreData *next_ignore(void)
{
    if (iterator_ptr)
	iterator_ptr = iterator_ptr->next;
    while (!iterator_ptr && iterator_char < 256) {
	iterator_char++;
	if (iterator_char < 256)
	    iterator_ptr = ignore[iterator_char];
    }
    return iterator_ptr;
}

/*************************************************************************/

/* add_ignore: Add someone to the ignorance list for the next `delta'
 *             seconds.
 */

void add_ignore(const char *nick, time_t delta)
{
    IgnoreData *ign;
    char who[NICKMAX];
    time_t now = time(NULL);
    IgnoreData **whichlist = &ignore[HASH(nick)];

    strscpy(who, nick, NICKMAX);
    for (ign = *whichlist; ign; ign = ign->next) {
	if (stricmp(ign->who, who) == 0)
	    break;
    }
    if (ign) {
	if (ign->time > now)
	    ign->time += delta;
	else
	    ign->time = now + delta;
    } else {
	ign = smalloc(sizeof(*ign));
	strscpy(ign->who, who, sizeof(ign->who));
	ign->time = now + delta;
	ign->next = *whichlist;
	*whichlist = ign;
    }
}

/*************************************************************************/

/* get_ignore: Retrieve an ignorance record for a nick.  If the nick isn't
 *             being ignored, return NULL and flush the record from the
 *             in-core list if it exists (i.e. ignore timed out).
 */

IgnoreData *get_ignore(const char *nick)
{
    IgnoreData *ign, *prev;
    time_t now = time(NULL);
    IgnoreData **whichlist = &ignore[HASH(nick)];

    for (ign = *whichlist, prev = NULL; ign; prev = ign, ign = ign->next) {
	if (irc_stricmp(ign->who, nick) == 0)
	    break;
    }
    if (ign && ign->time <= now) {
	if (prev)
	    prev->next = ign->next;
	else
	    *whichlist = ign->next;
	free(ign);
	ign = NULL;
    }
    return ign;
}

/*************************************************************************/
/*************************************************************************/

/* split_buf:  Split a buffer into arguments and store a pointer to the
 *             argument vector in argv_ptr; return the argument count.
 *             The argument vector will point to a static buffer;
 *             subsequent calls will overwrite this buffer.
 *             If colon_special is non-zero, then treat a parameter with a
 *             leading ':' as the last parameter of the line, per the IRC
 *             RFC.  Destroys the buffer by side effect.
 */

int split_buf(char *buf, char ***argv_ptr, int colon_special)
{
    static int argvsize = 8;
    static char **argv = NULL;
    int argc;
    char *s;

    if (!argv)
	argv = smalloc(sizeof(char *) * argvsize);
    argc = 0;
    while (*buf) {
	if (argc == argvsize) {
	    argvsize += 8;
	    argv = srealloc(argv, sizeof(char *) * argvsize);
	}
	if (*buf == ':' && colon_special) {
	    argv[argc++] = buf+1;
	    buf = "";
	} else {
	    s = strpbrk(buf, " ");
	    if (s) {
		*s++ = 0;
		while (isspace(*s))
		    s++;
	    } else {
		s = buf + strlen(buf);
	    }
	    argv[argc++] = buf;
	    buf = s;
	}
    }
    *argv_ptr = argv;
    return argc;
}

/*************************************************************************/

/* process:  Main processing routine.  Takes the string in inbuf (global
 *           variable) and does something appropriate with it. */

void process()
{
    char source[64];
    char cmd[64];
    char buf[512];		/* Longest legal IRC command line */
    char *s;
    int ac;			/* Parameters for the command */
    char **av;
    Message *m;


    /* If debugging, log the buffer. */
    if (debug)
	log("debug: Received: %s", inbuf);

    /* First make a copy of the buffer so we have the original in case we
     * crash - in that case, we want to know what we crashed on. */
    memset(buf, '\0', sizeof(buf) );
    strscpy(buf, inbuf, sizeof(buf));
    buf[512] = 0;
    
    /* Split the buffer into pieces. */
    if (*buf == ':') {
	s = strpbrk(buf, " ");
	if (!s)
	    return;
	*s = 0;
	while (isspace(*++s))
	    ;
	strscpy(source, buf+1, sizeof(source));
	memmove(buf, s, strlen(s)+1);
    } else {
	*source = 0;
    }
    if (!*buf)
	return;

    s = strpbrk(buf, " ");
    if (s) {
	*s = 0;
	while (isspace(*++s))
	    ;
    } else
	s = buf + strlen(buf);
    strscpy(cmd, buf, sizeof(cmd));
    ac = split_buf(s, &av, 1);

    /* Do something with the message. */
    m = find_message(cmd);
    if (m) {
	if (m->func)
	    m->func(source, ac, av);
    } else {
	log("unknown message from server (%s)", inbuf);
    }
}

/*************************************************************************/
