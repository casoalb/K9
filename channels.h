/* Online channel data structure.
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
*/        

#ifndef CHANNELS_H
#define CHANNELS_H

/*************************************************************************/

struct channel_ {
    Channel *next, *prev;
    char name[CHANMAX];
    ChannelInfo *ci;			/* Corresponding ChannelInfo */
    time_t creation_time;		/* When channel was created */

    char *topic;
    char topic_setter[NICKMAX];		/* Who set the topic */
    time_t topic_time;			/* When topic was set */

    int32 mode;				/* CMODE_* (binary) channel modes */
    int32 limit;			/* 0 if none */
    char *key;				/* NULL if none */

    int32 bancount, bansize;
    char **bans;
#ifdef HAVE_BANEXCEPT
    int32 exceptcount, exceptsize;
    char **excepts;
#endif

    struct c_userlist {
	struct c_userlist *next, *prev;
	User *user;
	int32 mode;			/* CUMODE_* modes (chanop, voice) */
    } *users;

    time_t server_modetime;		/* Time of last server MODE */
    time_t chanserv_modetime;		/* Time of last check_modes() */
    int16 server_modecount;		/* Number of server MODEs this second*/
    int16 chanserv_modecount;		/* Number of check_mode()'s this sec */
    int16 bouncy_modes;			/* Did we fail to set modes here? */
};

/*************************************************************************/

#endif
