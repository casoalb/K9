/* NickServ-related structures.
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
	  
#ifndef NICKSERV_H
#define NICKSERV_H


typedef struct {
    char   chan[CHANMAX];
    struct tm *tm;
    char   data[101];
} ChanServHistory;
	    

/* Nickname info structure.  Each nick structure is stored in one of 256
 * lists; the list is determined by the first character of the nick.  Nicks
 * are stored in alphabetical order within lists. */

struct nickinfo_ {
    NickInfo *next, *prev;
    char nick[NICKMAX];
    char pass[PASSMAX * 2];
    char *url;
    char *email;
    int  historycount;
    ChanServHistory *history;

    char *last_usermask;
    char *last_realname;
    char *last_quit;
    time_t time_registered;
    time_t last_seen;
    int16 status;	/* See NS_* below */

    NickInfo *link;	/* If non-NULL, nick to which this one is linked */
    int16 linkcount;	/* Number of links to this nick */

    /* All information from this point down is governed by links.  Note,
     * however, that channelcount is always saved, even for linked nicks
     * (thus removing the need to recount channels when unlinking a nick). */

    int32 flags;	/* See NI_* below */
    SuspendInfo *suspendinfo;	/* Suspension info (non-NULL => suspended) */
    uint16 channelcount;/* Number of channels currently registered */
    uint16 channelmax;	/* Maximum number of channels allowed */
    uint16 language;	/* Language selected by nickname owner (LANG_*) */

    int16 accesscount;	/* # of entries */
    char **access;	/* Array of strings */

    /* Online-only information: */

    time_t id_stamp;	/* Services stamp of user who last ID'd for nick */

    uint16 foundercount;	/* Number of channels nick is a founder of */
    ChannelInfo **founderchans;	/* Array of ... */

    int bad_passwords;	/* # of bad passwords for nick since last good one */
};


/* Nickname status flags: */
#define NS_ENCRYPTEDPW	0x0001      /* Nickname password is encrypted */
#define NS_VERBOTEN	0x0002      /* Nick may not be registered or used */
#define NS_NOEXPIRE	0x0004      /* Nick never expires */

#define NS_IDENTIFIED	0x8000      /* User has IDENTIFY'd */
#define NS_RECOGNIZED	0x4000      /* ON_ACCESS true && SECURE flag not set */
#define NS_ON_ACCESS	0x2000      /* User comes from a known address */
#define NS_KILL_HELD	0x1000      /* Nick is being held after a kill */
#define NS_SERVROOT	0x0800      /* User has Services root privileges */
#define NS_GUESTED	0x0100	    /* SVSNICK has been sent but nick has not
				     * yet changed. An enforcer will be
				     * introduced when it does change. */
#define NS_TEMPORARY	0xFF00      /* All temporary status flags */


/* Nickname setting flags: */
#define NI_KILLPROTECT	0x00000001  /* Kill others who take this nick */
#define NI_SECURE	0x00000002  /* Don't recognize unless IDENTIFY'd */
#define NI_MEMO_HARDMAX	0x00000008  /* Don't allow user to change memo limit */
#define NI_MEMO_SIGNON	0x00000010  /* Notify of memos at signon and un-away */
#define NI_MEMO_RECEIVE	0x00000020  /* Notify of new memos when sent */
#define NI_PRIVATE	0x00000040  /* Don't show in LIST to non-servadmins */
#define NI_HIDE_EMAIL	0x00000080  /* Don't show E-mail in INFO */
#define NI_HIDE_MASK	0x00000100  /* Don't show last seen address in INFO */
#define NI_HIDE_QUIT	0x00000200  /* Don't show last quit message in INFO */
#define NI_KILL_QUICK	0x00000400  /* Kill in 20 seconds instead of 60 */
#define NI_KILL_IMMED	0x00000800  /* Kill immediately instead of in 60 sec */


/* Maximum number of channels we can record: */
#define MAX_CHANNELCOUNT 65535


#endif	/* NICKSERV_H */
