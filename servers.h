/* Online server data.
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
	  
#ifndef SERVERS_H
#define SERVERS_H

/*************************************************************************/

struct server_ {
    Server *next, *prev;        /* Use to navigate the entire server list */
    Server *hub;
    Server *child, *sibling;

    char *name;                 /* Server's name */
    time_t t_join;		/* Time server joined us. 0 == not here. */

#ifdef STATISTICS
    ServerStats *stats;
#endif
};

/*************************************************************************/

#endif	/* SERVERS_H */
