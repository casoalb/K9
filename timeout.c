/* Routines for time-delayed actions.
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
#include "timeout.h"

static Timeout *timeouts = NULL;
static int checking_timeouts = 0;

/*************************************************************************/

#ifdef DEBUG_COMMANDS

/* Send the timeout list to the given user. */

void send_timeout_list(User *u)
{
    Timeout *to, *last;
    uint32 now = time_msec();

    notice(s_OperServ, u->nick, "Now: %u.%03u", now/1000, now%1000);
    for (to = timeouts, last = NULL; to; last = to, to = to->next) {
	notice(s_OperServ, u->nick, "%p: %u.%03u: %p (%p)",
	       to, to->timeout/1000, to->timeout%1000, to->code, to->data);
	if (to->prev != last)
	    notice(s_OperServ, u->nick,
		   "    to->prev incorrect!  expected=%p seen=%p",
		   last, to->prev);
    }
}

#endif	/* DEBUG_COMMANDS */

/*************************************************************************/

/* Check the timeout list for any pending actions. */

void check_timeouts(void)
{
    Timeout *to, *to2;
    uint32 now = time_msec();

    if (checking_timeouts)
	fatal("check_timeouts() called recursively!");
    checking_timeouts = 1;
    if (debug >= 2) {
	log("debug: Checking timeouts at time_msec = %u.%03u",
	    now/1000, now%1000);
    }

    to = timeouts;
    while (to) {
	if (!to->timeout)
	    goto delete;
	if ((int32)(to->timeout - now) > 0) {
	    to = to->next;
	    continue;
	}
	if (debug >= 3) {
	    log("debug: Running timeout %p (code=%p repeat=%d)",
			to, to->code, to->repeat);
	}
	to->code(to);
	if (to->repeat) {
	    to = to->next;
	    continue;
	}
      delete:
	to2 = to->next;
	if (to->next)
	    to->next->prev = to->prev;
	if (to->prev)
	    to->prev->next = to->next;
	else
	    timeouts = to->next;
	free(to);
	to = to2;
    }

    if (debug >= 2)
	log("debug: Finished timeout list");
    checking_timeouts = 0;
}

/*************************************************************************/

/* Add a timeout to the list to be triggered in `delay' seconds.  If
 * `repeat' is nonzero, do not delete the timeout after it is triggered.
 * This must maintain the property that timeouts added from within a
 * timeout routine do not get checked during that run of the timeout list.
 */

Timeout *add_timeout(int delay, void (*code)(Timeout *), int repeat)
{
    if (delay > 4294967)  /* 2^32 / 1000 */
	delay = 4294967;
    return add_timeout_ms(delay*1000, code, repeat);
}

/*************************************************************************/

Timeout *add_timeout_ms(uint32 delay, void (*code)(Timeout *), int repeat)
{
    Timeout *t = smalloc(sizeof(Timeout));
    t->settime = time(NULL);
    t->timeout = time_msec() + delay;
    t->code = code;
    t->repeat = repeat;
    t->next = timeouts;
    t->prev = NULL;
    if (timeouts)
	timeouts->prev = t;
    timeouts = t;
    return t;
}

/*************************************************************************/

/* Remove a timeout from the list (if it's there). */

void del_timeout(Timeout *t)
{
    Timeout *ptr;

    for (ptr = timeouts; ptr; ptr = ptr->next) {
	if (ptr == t)
	    break;
    }
    if (!ptr) {
	log("timeout: BUG: attempted to remove timeout %p (not on list)", t);
	return;
    }
    if (checking_timeouts) {
	t->timeout = 0;  /* delete it when we hit it in the list */
	return;
    }
    if (t->prev)
	t->prev->next = t->next;
    else
	timeouts = t->next;
    if (t->next)
	t->next->prev = t->prev;
    free(t);
}

/*************************************************************************/
