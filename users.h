/* Online user data structure.
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
*/ 
	  
#ifndef USERS_H
#define USERS_H

/*************************************************************************/

struct user_ {
    User *next, *prev;
    char nick[NICKMAX];
    NickInfo *ni;			/* Effective NickInfo (not a link) */
    NickInfo *real_ni;			/* Real NickInfo (ni.nick==user.nick)*/
    Server *server;			/* Server user is on */
    char *username;
    char *host;				/* User's hostname */
    char *realname;
#ifdef IRC_UNREAL
    char *fakehost;			/* Hostname seen by other users */
#endif
    time_t signon;			/* Timestamp sent with nick when we
    					 *    first saw it.  Never changes! */
    time_t my_signon;			/* When did _we_ see the user with
    					 *    their current nickname? */
    uint32 services_stamp;		/* ID value for user; used in split
					 *    recovery */
    int32 mode;				/* UMODE_* user modes */
    struct u_chanlist {
	struct u_chanlist *next, *prev;
	Channel *chan;
    } *chans;				/* Channels user has joined */
    struct u_chaninfolist {
	struct u_chaninfolist *next, *prev;
	ChannelInfo *chan;
    } *founder_chans;			/* Channels user has identified for */
    short invalid_pw_count;		/* # of invalid password attempts */
    time_t invalid_pw_time;		/* Time of last invalid password */
    time_t lastmemosend;		/* Last time MS SEND command used */
    time_t lastnickreg;			/* Last time NS REGISTER cmd used */
};

/*************************************************************************/

#endif /* USERS_H */
