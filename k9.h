/* ChanServ-related structures.
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
**/        
	  
#ifndef K9_H
#define K9_H


/* Access levels for users. */
typedef struct {
    int16 in_use;	/* 1 if this entry is in use, else 0 */
    int16 level;
    NickInfo *ni;	/* Guaranteed to be non-NULL if in use, NULL if not */
} ChanAccess;

/* Maximim number of lines possible in an ONJOIN */

#define MAXONJOIN  5

/* Maximim number of chars possible in an COMMENT */

#define COMMENTMAX 256 


/* Maximum number of chars possible per-line in an ONJOIN */
#define ONJOINMAX 256


/* Maximim number of chars possible in an AUTOOP */

/* #define AUTOOPMAX 2 */

/* Maximum number of ACCESS and BANLIST enteries to show at a time */

#define ACCLISTNUM 10

/* Note that these two levels also serve as exclusive boundaries for valid
 * access levels.  ACCLEV_FOUNDER may be assumed to be strictly greater
 * than any valid access level, and ACCLEV_INVALID may be assumed to be
 * strictly less than any valid access level.
 */
#define ACCLEV_FOUNDER	500	/* Numeric level indicating founder access */
#define ACCLEV_INVALID	  0	/* Used in levels[] for disabled settings */

/*
 * Access levels for Channel Services staff
 */

#define ACCLEV_HELPER     600
#define ACCLEV_IMMORTAL   610
#define ACCLEV_TITAN	  630
#define ACCLEV_DEMIGOD    650
#define ACCLEV_EMPEROR    800

#define ACCLEV_GOD        801

/*
 * Access levels for general users
 */
#define ACCLEV_BANS 75 

#ifdef HAVE_HALFOP
# define ACCLEV_HOP	4
#endif


/* AutoKick data. */

typedef struct {
    int16 in_use;
    int16 is_nick;	 
			
    union {
	char *mask;	
	NickInfo *ni;	
    } u;
    char *reason;
    char who[NICKMAX];
    time_t time;        /* when it was added */
    time_t expires;     /* or 0 = never */
} AutoKick;

typedef struct {
    int16 in_use;
    NickInfo *ni;
    char msg[COMMENTMAX];
} ChannelComment;
	    
typedef struct {
    int16 in_use;
    NickInfo *ni;
    char flag;
} ChannelAutoop;
	    


struct chaninfo_ {
    ChannelInfo *next, *prev;
    char name[CHANMAX];
    NickInfo *founder;
    NickInfo *successor;		/* Who gets the channel if the founder
					 * nick is dropped or expires */
    char founderpass[PASSMAX * 2];
    char *desc;
    char *url;
    char *email;

    time_t time_registered;
    time_t last_used;
    char *last_topic;		/* Last topic on the channel */
    char last_topic_setter[NICKMAX];	/* Who set the last topic */
    time_t last_topic_time;	/* When the last topic was set */

    int32 flags;		/* See below */
    SuspendInfo *suspendinfo;	/* Non-NULL iff suspended */

    int16 *levels;		/* Access levels for commands */

    int16 accesscount;
    ChanAccess *access;		/* List of authorized users */
    int16 akickcount;
    AutoKick *akick;            /* List of users to kickban */

    int32 mlock_on, mlock_off;	/* See channel modes below */
    int32 mlock_limit;		/* 0 if no limit */
    char *mlock_key;		/* NULL if no key */

    int16 entrycount;           /* Number of greet lines */
    char **entrymsg;            /* Notice sent on entering channel */
    
    int16 autoopcount;    
    ChannelAutoop *autoop;      /* Autoop T/F */
	
    int16 commentcount;
    ChannelComment *comment;    /* List of Users Channel Comments */
	
    struct channel_ *c;		/* Pointer to channel record (if   *
				 *    channel is currently in use) */

    int bad_passwords;		/* # of bad passwords since last good one */
};

/* Retain topic even after last person leaves channel */
#define CI_KEEPTOPIC	0x00000001
/* Don't allow non-authorized users to be opped */
#define CI_SECUREOPS	0x00000002
/* Hide channel from ChanServ LIST command */
#define CI_PRIVATE	0x00000004
/* Topic can only be changed by SET TOPIC */
#define CI_TOPICLOCK	0x00000008
/* Those not allowed ops are kickbanned */
#define CI_RESTRICTED	0x00000010
/* Don't auto-deop anyone */
#define CI_LEAVEOPS	0x00000020
/* Don't allow any privileges unless a user is IDENTIFY'd with NickServ */
#define CI_SECURE	0x00000040
/* Don't allow the channel to be registered or used */
#define CI_VERBOTEN	0x00000080
/* Channel password is encrypted */
#define CI_ENCRYPTEDPW	0x00000100
/* Channel does not expire */
#define CI_NOEXPIRE	0x00000200
/* Channel memo limit may not be changed */
#define CI_MEMO_HARDMAX 0x00000400
/* Send notice to channel on use of OP/DEOP */
#define CI_OPNOTICE	0x00000800
/* Enforce +o, +v modes (don't allow deopping) */
#define CI_ENFORCE	0x00001000
/* K9 is in channel or not */
#define CI_INCHANNEL    0x00002000
/* auto-op a user who is IDENTIFY'd with NickServ */
#define CI_AUTOOP    0x00003000

/* Indices for cmd_access[]: (DO NOT REORDER THESE unless you hack
 * load_cs_dbase to deal with them) */
#define CA_INVITE	0
#define CA_KICK  	1
#define CA_SET		2	/* but not FOUNDER or PASSWORD */
#define CA_UNBAN	3
#define CA_AUTOOP	4
#define CA_AUTODEOP	5	/* Maximum, not minimum */
#define CA_AUTOVOICE	6
#define CA_OPDEOP	7	/* ChanServ commands OP and DEOP */
#define CA_ACCESS_LIST	8
#define CA_CLEAR	9
#define CA_NOJOIN	10	/* Maximum */
#define CA_ACCESS_CHANGE 11
#define CA_MEMO         12
#define CA_VOICE	13	/* VOICE/DEVOICE commands */
#define CA_AUTOHALFOP	14
#define CA_HALFOP	15	/* HALFOP/DEHALFOP commands */
#define CA_AUTOPROTECT	16
#define CA_PROTECT	17

#define CA_BROADCAST    18
#define CA_SAY          19
#define CA_ACT          20
#define CA_SND          21
#define CA_BAN          22
#define CA_TOPIC        23
#define CA_RESTART      24
#define CA_DIEDIE       25
#define CA_ADDUSER      26
#define CA_REMUSER      27
#define CA_MODUSER      28
#define CA_LASTCMDS     29
#define CA_MODE         30
#define CA_UPDATE       31
#define CA_JOIN         32
#define CA_PART         33
#define CA_ONJOIN       34
#define CA_COMMENT      35
#define CA_REMCHAN      36
#define CA_GUARDM       37
#define CA_SCHAN        38
#define CA_UNSCHAN      39
#define CA_FORBID       40
#define CA_GETPASS      41
#define CA_STATUS       42
#define CA_COMMANDS     43
#define CA_GUARDT       44
#define CA_ADDCHAN      45
#define CA_GENPASS	46

#define CA_SIZE         47

#ifdef USE_MYSQL
/* global MYSQL database handle */
MYSQL mysqldb;
#endif

#endif	/* K9_H */
