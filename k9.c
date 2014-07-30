/* Chatnet K9 Channel Services
**
** Based on ircdservices ver. by Andy Church
** Chatnet modifications (c) 2001-2002
**
** E-mail: routing@lists.chatnet.org
** Authors: 
**
**	Vampire	(vampire@alias.chatnet.org)
**	Thread	(thread@alias.chatnet.org)
** 	MRX	(tom@rooted.net)
**      sloth   (sloth@nopninjas.com)
**
** 	*** DO NOT DISTRIBUTE ***
*/
	  
#include "services.h"
#include "pseudo.h"

#define FALSE	0
#define TRUE	1

#define HASH(chan)  (hashtable[(unsigned char)((chan)[1])]<<5 \
		     | (chan[1] ? hashtable[(unsigned char)((chan)[2])] : 0))
#define HASHSIZE    1024
#define LINEBUFFSIZE    512

#if defined(IRC_DALNET) || defined(IRC_UNDERNET)
# define OPER_BOUNCY_MODES_MESSAGE OPER_BOUNCY_MODES_U_LINE
#else
# define OPER_BOUNCY_MODES_MESSAGE OPER_BOUNCY_MODES
#endif

static ChannelInfo *chanlists[HASHSIZE];

static const char hashtable[256] = {
     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,

     0, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,
    16,17,18,19,20,21,22,23,24,25,26,27,28,29, 0, 0,
     0, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,
    16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,30,

    31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,
    31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,
    31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,
    31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,

    31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,
    31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,
    31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,
    31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,
};

/*************************************************************************/

/* Channel option list. */

typedef struct {
    char *name;
    int32 flag;
    int namestr;  /* If -1, will be ignored by cs_flags_to_string() */
    int onstr, offstr, syntaxstr;
} ChanOpt;

#define CHANOPT(x) \
    { #x, CI_##x, CHAN_INFO_OPT_##x, \
      CHAN_SET_##x##_ON, CHAN_SET_##x##_OFF, CHAN_SET_##x##_SYNTAX }

ChanOpt chanopts[] = {
    CHANOPT(KEEPTOPIC),
    CHANOPT(TOPICLOCK),
    CHANOPT(PRIVATE),
    CHANOPT(SECUREOPS),
    CHANOPT(LEAVEOPS),
    CHANOPT(RESTRICTED),
    CHANOPT(SECURE),
    CHANOPT(OPNOTICE),
    CHANOPT(ENFORCE),
    { "NOEXPIRE", CI_NOEXPIRE, -1, CHAN_SET_NOEXPIRE_ON,
	  CHAN_SET_NOEXPIRE_OFF, CHAN_SET_NOEXPIRE_SYNTAX },
    { NULL }
};
#undef CHANOPT

/*************************************************************************/

/* Access level control data. */

/* Default levels.  All levels MUST be listed here irrespective of IRC
 * server type. */
static int def_levels[][2] = {

    { CA_AUTODEOP,            -1 },
    { CA_NOJOIN,              -2 },

    { CA_ACCESS_LIST,          0 },
    { CA_COMMANDS,             0 },

    { CA_AUTOHALFOP,           4 },
    { CA_HALFOP,               4 },
	
    { CA_MEMO,                10 },
    { CA_AUTOPROTECT,         10 },
    { CA_PROTECT,             10 },

    { CA_KICK,                50 },
    
    { CA_BAN ,                75 },
    { CA_UNBAN,               75 },
    
    { CA_INVITE,             100 },
    { CA_OPDEOP,             100 },
    { CA_AUTOVOICE,          -1 },
    { CA_VOICE,              100 },
    
    { CA_TOPIC,              200 },
    { CA_COMMENT,            200 },
    { CA_INVITE,             200 },

    { CA_ACCESS_CHANGE,      400 },
    { CA_SET,                400 },
    { CA_AUTOOP,             400 },
    { CA_ADDUSER,            400 },
    { CA_REMUSER,            400 },
    { CA_MODUSER,            400 },
    { CA_MODE,               400 },

    { CA_CLEAR,              450 },
    { CA_JOIN  ,             450 },
    { CA_PART,               450 },
    { CA_ONJOIN,             450 },
    { CA_GUARDM,             450 },
    { CA_GUARDT,             450 },

    { CA_SAY,                500 },
    { CA_ACT,                500 },
    { CA_SND,                500 },
	    
    { CA_GENPASS,            600 },

    { CA_LASTCMDS ,          610 },
    { CA_UNSCHAN,            610 },
    { CA_FORBID,             610 },
    { CA_GETPASS,            610 },
    { CA_REMCHAN,            610 },
    { CA_STATUS,             610 },

    { CA_SCHAN,              630 },

    { CA_BROADCAST,          650 },
   
    { CA_RESTART,            800 },
    { CA_DIEDIE,             800 },
    { CA_UPDATE,             800 },    
    
    { -1 }
};

/*************************************************************************/

/* Local functions. */

static ChannelInfo *makechan(const char *chan);
static int delchan(ChannelInfo *ci);
static int expire_autoops(void);
static int expire_bans(void);
static int has_access(User *user, ChannelInfo *ci);
static int is_founder(User *user, ChannelInfo *ci);
static int is_identified(User *user, ChannelInfo *ci);
static void uncount_chan(ChannelInfo *ci);

/* Not So Local functions. */
void alpha_insert_chan(ChannelInfo *ci);
void count_chan(ChannelInfo *ci);
void reset_levels(ChannelInfo *ci);

/*
int get_access(User *user, ChannelInfo *ci);
*/
static int get_access_offline(const char *user, ChannelInfo *ci);
static void suspend(ChannelInfo *ci, const char *reason,
		    const char *who, const time_t expires);
static void unsuspend(ChannelInfo *ci, int set_time);
static void chan_bad_password(User *u, ChannelInfo *ci);

static ChanOpt *chanopt_from_name(const char *optname);

static void k9_help(User *u);
static void k9_register(User *u);
static void k9_auth(User *u);
static void k9_email(User *u);
static void k9_founder(User *u);
static void k9_successor(User *u);
static void k9_remchan(User *u);
static void k9_addchan(User *u);
char create_host(User *u);
/*
static void do_set_founder(User *u, ChannelInfo *ci, char *param);
*/
static void k9_setpass(User *u);
/*
static void do_set_desc(User *u, ChannelInfo *ci, char *param);
static void do_set_email(User *u, ChannelInfo *ci, char *param);
*/
static void do_set_entrymsg(User *u, ChannelInfo *ci, char *param);
/* static void do_addto_entrymsg(User *u, ChannelInfo *ci, char *param); */
static void do_set_topic(User *u, ChannelInfo *ci, char *param);
static void do_set_boolean(User *u, ChannelInfo *ci, ChanOpt *co, char *param);
static void k9_access(User *u);
static int owner_add(const char *chan, const char *nick);
static int emperor_add(const char *chan, const char *nick);
static void k9_info(User *u);
static void k9_list(User *u);
static void k9_invite(User *u);
static void k9_op(User *u);
static void k9_deop(User *u);
static void k9_voice(User *u);
static void k9_devoice(User *u);
#ifdef HAVE_CHANPROT
static void do_protect(User *u);
static void do_deprotect(User *u);
#endif
static void k9_unban(User *u);
/*
static void do_clear(User *u);
*/
static void k9_genpass(User *u);
static void k9_getpass(User *u);
static void k9_forbid(User *u);
static void k9_schan(User *u);
static void k9_unschan(User *u);
static void k9_status(User *u);
/* NEW */

/* static void k9_say(User *u); */
static void k9_act(User *u);
static void k9_snd(User *u);
static void k9_kick(User *u);
static void k9_restart(User *u);
static void k9_diedie(User *u);
static void k9_comment(User *u);
static void k9_lastcmds(User *u);
static void k9_topic(User *u);
static void k9_commands(User *u);
static void k9_ban(User *u);
static void k9_banlist(User *u);
static void k9_version(User *u);
static void k9_adduser(User *u);
static void k9_remuser(User *u);
/* static void k9_moduser(User *u); */
static void k9_broadcast(User *u);
/* static void k9_mode(User *u); */
static void k9_save(User *u);
static void k9_update(User *u);
static void k9_join(User *u);
static void k9_part(User *u);
static void k9_onjoin(User *u);
static void k9_guardm(User *u);
static void k9_guardt(User *u);
static void k9_autoop(User *u);
static void do_set_mlock(User *u, ChannelInfo *ci, char *param);
void record_comment(ChannelInfo *ci, NickInfo *ni, char *msg);
void remove_comment(ChannelInfo *ci, NickInfo *ni);
void record_autoop(ChannelInfo *ci, NickInfo *ni, char *msg);
void remove_autoop(ChannelInfo *ci, NickInfo *ni);
static int akick_list(User *u, int index, ChannelInfo *ci, int *sent_header, int is_view);
/* static int akick_list_callback(User *u, int num, va_list args); */
static int akick_del_callback(User *u, int num, va_list args);
static int akick_del(char *chan, User *u, AutoKick *akick);
static void timeout_leave(Timeout *to);
int add_history(NickInfo *ni, char *chan, char *data);
static char *get_hostmask_of(char *mask);
int check_w32_device(char *rest);

void cs_join(char *chan);
void cs_part(char *chan);

extern int db_delete_chan(char *channame);

/*************************************************************************/

/* Command list. */

static Command cmds[] = {
    {"HELP",		k9_help,		NULL,	0,	-1,	-1,-1},
    {"COMMANDS",	k9_commands,		NULL,	0,	-1,	-1,-1},
    {"INFO",		k9_info,		NULL,	0,	-1,	-1,-1},
    {"ACCESS",		k9_access,		NULL,	0,	-1,	-1,-1},
    {"BANLIST",		k9_banlist,		NULL,	0,	-1,	-1,-1},
    {"VERSION",		k9_version,		NULL,	0,	-1,	-1,-1},
    {"KICK",		k9_kick,		NULL,	50,	-1,	-1,-1},
    {"BAN",		k9_ban,			NULL,	75,	-1,	-1,-1},  
    {"UNBAN",		k9_unban,		NULL,	75,	-1,	-1,-1},
    {"COMMENT",		k9_comment,		NULL,	75,	-1,	-1,-1},
    {"INVITE",		k9_invite,		NULL,	100,	-1,	-1,-1},
    {"OP",		k9_op,			NULL,	100,	-1,	-1,-1},
    {"DEOP",		k9_deop,		NULL,	100,	-1,	-1,-1},
    {"VOICE",		k9_voice,		NULL,	100,	-1,	-1,-1},
    {"DEVOICE",		k9_devoice,		NULL,	100,	-1,	-1,-1},
    {"TOPIC",		k9_topic,		NULL,	200,	-1,	-1,-1},
    {"AUTOOP",		k9_autoop,		NULL,	400,	-1,	-1,-1},
/*
    {"MODE",		k9_mode,		NULL,	400,	-1,	-1,-1},
*/
    {"ADDUSER",		k9_adduser,		NULL,	400,	-1,	-1,-1},
    {"MODUSER",		k9_adduser,		NULL,	400,	-1,	-1,-1},        
    {"REMUSER",		k9_remuser,		NULL,	400,	-1,	-1,-1},
    {"GUARDM", 		k9_guardm,		NULL,	450,	-1,	-1,-1},
    {"GUARDT",		k9_guardt,		NULL,	450,	-1,	-1,-1},    
    {"ONJOIN",		k9_onjoin,		NULL,	450,	-1,	-1,-1},
    {"JOIN",		k9_join,		NULL,	450,	-1,	-1,-1},    
    {"PART",		k9_part,		NULL,	450,	-1,	-1,-1},
 /* {"IDENTIFY",	k9_auth,		NULL,	450,	-1,	-1,-1}, */
    {"ACT",		k9_act,			NULL,	500,	-1,	-1,-1},
    {"AUTH",		k9_auth,		NULL,	500,	-1,	-1,-1},
/*    {"SAY",		k9_say,			NULL,	500,	-1,	-1,-1},
*/
    {"SND",		k9_snd,			NULL,	500,	-1,	-1,-1},
    {"SETPASS",		k9_setpass,		NULL,	500,	-1,	-1,-1},
    {"SUCCESSOR",	k9_successor,		NULL,	500,	-1,	-1,-1},

    {"GENPASS",		k9_genpass,		NULL,	600,	-1,	-1,-1},
    {"GETPASS",		k9_getpass,		NULL,	610,	-1,	-1,-1},
    {"LASTCMDS",	k9_lastcmds,		NULL,	610,	-1,	-1,-1}, 
    {"LIST",		k9_list,		NULL,	610,	-1,	-1,-1},
    {"EMAIL",		k9_email,		NULL,	610,	-1,	-1,-1},
    {"FOUNDER",		k9_founder,		NULL,	610,	-1,	-1,-1},
    {"STATUS",		k9_status,		NULL,	610,	-1,	-1,-1},
    {"REMCHAN",		k9_remchan,		NULL,	610,	-1,	-1,-1},    
    {"ADDCHAN",		k9_addchan,		NULL,	630,	-1,	-1,-1},
    {"REGISTER",	k9_register,		NULL,	630,	-1,	-1,-1},
    {"SCHAN",		k9_schan,		NULL,	630,	-1,	-1,-1},
    {"UNSCHAN",		k9_unschan,		NULL,	630,	-1,	-1,-1},
    {"BROADCAST",	k9_broadcast,		NULL,	650,	-1,	-1,-1},
    {"FORBID",		k9_forbid,		NULL,	650,	-1,	-1,-1},
    {"DIEDIE",		k9_diedie,		NULL,	800,	-1,	-1,-1},
    {"RESTART",		k9_restart,		NULL,	800,	-1,	-1,-1},
    {"UPDATE",		k9_update,		NULL,	800,	-1,	-1,-1},
    {"SAVE",		k9_save,		NULL,	800,	-1,	-1,-1},
/*    

    { "CLEAR",		do_clear,		NULL,  CHAN_HELP_CLEAR,                -1,-1,-1,-1 },
*/    
    
    { NULL }
};

/*************************************************************************/
/************************ Main K9 Routines *************************/
/*************************************************************************/

/* K9 initialization. */

void cs_init(void)
{
	expire_bans();
	expire_autoops();
}

/*************************************************************************/

/* Main K9 Routine. */

void chanserv(const char *source, char *chan, char *buf)
{
	char *cmd,*s;
	User *u = NULL;
	char *histbuf;
	int tmp_i;
	ChannelInfo *ci;

	if (!source || (!(u = finduser(source))) )
	{
		log("%s: user record for %s not found", s_ChanServ, source);
		notice(s_ChanServ, source, getstring((NickInfo *)NULL, USER_RECORD_NOT_FOUND));
		return;
	}
    
	if (!buf)
		return;

	histbuf = sstrdup(buf);	

	if (u->ni && histbuf)
		tmp_i = add_history(u->ni, NULL, histbuf);
	        
	cmd = strtok(buf, " ");
    
	if (!cmd) 
		return;
	
	if (stricmp(cmd, "\1PING") == 0)
	{

		if (!(s = strtok(NULL, "")))
			s = "\1";

		return; 
	}


	if (skeleton)
	{
		notice_lang(s_ChanServ, u, SERVICE_OFFLINE, s_ChanServ);
		return;
	}
	if (!(ci = cs_findchan( chan )) )
		ci = NULL;

	if (stricmp(cmd,s_ChanServ)==0)
		cmd++;

	run_cmd(s_ChanServ, u, cmds, cmd, ci);
}

/*************************************************************************/

/* Return the ChannelInfo structure for the given channel, or NULL if the
 * channel isn't registered. */

ChannelInfo *cs_findchan(const char *chan)
{
    ChannelInfo *ci;

    for (ci = chanlists[HASH(chan)]; ci; ci = ci->next) {
	if (irc_stricmp(ci->name, chan) == 0)
	    return ci;
    }
    return NULL;
}

/*************************************************************************/

/* Return values for add/delete/list functions.  Success > 0, failure < 0. */
#define RET_ADDED       1
#define RET_CHANGED     2
#define RET_UNCHANGED   3
#define RET_DELETED     4
#define RET_LISTED      5
#define RET_HIGHER      6
#define RET_LOWER       7
#define RET_PERMISSION  -1
#define RET_NOSUCHNICK  -2
#define RET_NICKFORBID  -3
#define RET_LISTFULL    -4
#define RET_NOENTRY     -5

static int access_add(ChannelInfo *ci, const char *nick, int level, int uacc)
{
    int i;
    ChanAccess *access;
    NickInfo *ni;

    if (level > ACCLEV_EMPEROR)
        return RET_PERMISSION;

    ni = findnick(nick);
    if (!ni)
        return RET_NOSUCHNICK;
    else if (ni->status & NS_VERBOTEN)
        return RET_NICKFORBID;
    for (access = ci->access, i = 0; i < ci->accesscount; access++, i++) {
        if (access->ni == ni) {
            /* Don't allow lowering from a level >= uacc */
            if (access->level > ACCLEV_EMPEROR)
                return RET_PERMISSION;
            if (access->level == level)
                return RET_UNCHANGED;
            access->level = level;
            return RET_CHANGED;
        }
    }
    for (i = 0; i < ci->accesscount; i++) {
        if (!ci->access[i].in_use)
            break;
    }
    if (i == ci->accesscount) {
        if (i < CSAccessMax) {
            ci->accesscount++;
            ci->access =
                srealloc(ci->access, sizeof(ChanAccess) * ci->accesscount);
        } else {
            return RET_LISTFULL;
        }
    }

    printf("access_add for %s\n", ni->nick);

    if(ni == NULL)
    {
	printf("!!INTERNAL ERROR!! access_add - ni == NULL! - Exiting\n");
	exit(1);
    }

    access = &ci->access[i];
    access->ni = ni;
    access->in_use = 1;
    access->level = level;

    db_adduser(ci, ni, level);

    return RET_ADDED;
}

/*************************************************************************/

static int access_del(ChannelInfo *ci, const char *nick, int uacc)
{
    int i;
    ChanAccess *access;
    NickInfo *ni;

    ni = findnick(nick);
    if (!ni)
        return RET_NOSUCHNICK;
    else if (ni->status & NS_VERBOTEN)
        return RET_NICKFORBID;

    for (i = 0; i < ci->commentcount; i++)
    {
        if (ci->comment[i].in_use && ci->comment[i].ni == ni) {
            ci->comment[i].in_use = 0;
            ci->comment[i].ni = NULL;
            if (ci->comment[i].msg)
                memset(ci->comment[i].msg, '\0', sizeof(ci->comment[i].msg));
        }
    }

    for (access = ci->access, i = 0; i < ci->accesscount; access++, i++) {
        if (access->ni == ni) {
            /* Don't allow lowering from a level >= uacc */
            access->ni = NULL;
            access->in_use = 0;
            db_remuser(ci->name, (char *)nick);
            return RET_DELETED;
        }
    }
    for (i = 0; i < ci->accesscount; i++) {
        if (!ci->access[i].in_use)
            break;
    }

    access->ni = NULL;
    access->in_use = 0;

    db_remuser(ci->name, (char *)nick);

    return RET_DELETED;
}

/*************************************************************************/

static int access_list(User *u, int index, ChannelInfo *ci, int *sent_header)
{
    ChanAccess *access = &ci->access[index];
    ChannelComment *comment = NULL; 
    ChannelAutoop *autoop = NULL;
    NickInfo *ni = access->ni;
    char *uc;	/* Comment */
    char aflag[2]; /* Autoop Flag */
    char *s;
    int i;

    if (!access->in_use)
    {
        return RET_NOENTRY;
    }
    if (!*sent_header)
    {
        notice_lang(s_ChanServ, u, CHAN_ACCESS_LIST_HEADER, ci->name);
        *sent_header = 1;
    }
    if (!(getlink(ni)->flags & NI_HIDE_MASK))
    {
        s = ni->last_usermask;
    }
    else
    {
        s = NULL;
    }

    for (i=0; i < ci->commentcount; i++)
    {
        if (ci->comment[i].in_use && ci->comment[i].ni == getlink(ni) )
        {
            comment = &ci->comment[i];
        }
    }  

    if (comment == NULL)
	uc = " "; 
    else
    	uc = comment->msg;

     for (i=0; i < ci->autoopcount; i++)
     {
          if (ci->autoop[i].in_use && ci->autoop[i].ni == getlink(ni))
          {
                    autoop = &ci->autoop[i];
          }
     }  
  
     memset(aflag, 0, sizeof(aflag));
 
     if ((autoop != NULL)&&(autoop->flag))
     {
     
  	     if (autoop->flag == 't' || autoop->flag == 'T')
             {  
		strncpy(aflag, "T", 1);
  	     }
             else if (autoop->flag == 'v' || autoop->flag == 'V')   
             {
                strncpy(aflag, "V", 1);
             }
	     else
             {
		strncpy(aflag, "F", 1);
             }
     }
     else
     {
        strncpy(aflag, "F", 1); 
     }
      
    if ((access->level >= ACCLEV_HELPER) && (check_cservice(u) < ACCLEV_IMMORTAL))
    {
        if (access->level >= ACCLEV_HELPER && access->level < ACCLEV_IMMORTAL)
        {
            notice_lang(s_ChanServ, u, CHAN_ACCESS_LIST2_FORMAT, index+1, access->ni->nick, "HELPER", aflag, uc);
        }
        else
        {
            notice_lang(s_ChanServ, u, CHAN_ACCESS_LIST2_FORMAT, index+1, access->ni->nick, "CSERVICE", aflag, uc);
        }
    }
    else 
    {
        notice_lang(s_ChanServ, u, CHAN_ACCESS_LIST_FORMAT, index+1, access->ni->nick, access->level, aflag, uc);
    }

	notice(s_ChanServ, u->nick, " ");


        return RET_LISTED;

}

/*************************************************************************/
/*
static int access_list_callback(User *u, int num, va_list args)
{
    ChannelInfo *ci = va_arg(args, ChannelInfo *);
    int *sent_header = va_arg(args, int *);
    if (num < 1 || num > ci->accesscount)
        return 0;
    return access_list(u, num-1, ci, sent_header) > 0;
}
*/

/*************************************************************************/

#ifndef MAX_HISTORY
#define MAX_HISTORY 8
#endif

int add_history(NickInfo *ni, char *chan, char *data)
{
    ChanServHistory *history;
    int i = 0;
    int p = -1;
    char *s;

    if (!ni || !data)
        return (ni) ? -1 : ni->historycount;

    /* We buffer up to MAX_HISTORY commands the user has sent to Chan Services
       If MAX_HISTORY already exist, wipe out the oldest */

    if (ni->historycount == MAX_HISTORY)
    {
        for (i = 0; i < ni->historycount; i++)
        {
            memmove(&ni->history[i], &ni->history[i+1], sizeof(ChanServHistory));
        }
        p = MAX_HISTORY-1;
    } else {
        ni->historycount++;
        ni->history = srealloc(ni->history, sizeof(ChanServHistory) * ni->historycount);
        p = ni->historycount-1;
    }

    history = &ni->history[p];
    strscpy(history->data, data, sizeof(history->data)-1);
    s = history->data + (sizeof(history->data));
    *s = 0;

    if (chan)
    {
        strncpy(history->chan, chan, sizeof(history->chan)-1);
        s = history->chan + (sizeof(history->chan));
        *s = 0;
    } else {
        s = history->chan;
        *s = 0;
    }

    return ni->historycount;
}


/*************************************************************************/

/* Check whether a user is permitted to be on a channel.  If so, return 0;
 * else, kickban the user with an appropriate message (could be either
 * KICK or restricted access) and return 1.  Note that this is called
 * _before_ the user is added to internal channel lists (so do_kick() is
 * not called).
 */

int check_kick(User *user, const char *chan)
{
	ChannelInfo *ci = cs_findchan(chan);
	AutoKick *akick;
	int i;
	NickInfo *ni;
	char *av[3], *mask, *s;
	const char *reason;
	Timeout *t;
	int stay;
	time_t now = time(NULL);

	if (!ci || !chan || !user)
		return 0;
	
	if (debug)
		log("debug: check_kick starting for %s", user->nick);
	
	if (!is_on_chan(user->nick, chan))
			return 0;




#ifdef IRC_UNREAL
	/* Don't let plain opers into +A (admin only) channels */
	if ((ci->mlock_on & CMODE_A) && !(user->mode & (UMODE_A|UMODE_N|UMODE_T)))
	{
		mask = create_mask(user, 1);
		reason = getstring(user->ni, CHAN_NOT_ALLOWED_TO_JOIN);
		goto kick;
	}

	/* Don't let hiding users into no-hiding channels */
	if ((ci->mlock_on & CMODE_H) && (user->mode & UMODE_I))
	{
		mask = create_mask(user, 1);
		reason = getstring(user->ni, CHAN_NOT_ALLOWED_TO_JOIN);
		goto kick;
	}
#endif /* IRC_UNREAL */

	if (debug)
		log("debug: check_kick CI_VERBOTEN");

	if ((!is_oper_u(user)) && ((ci->flags & CI_VERBOTEN) || ci->suspendinfo))
	{
		mask = sstrdup("*!*@*");
		reason = getstring(user->ni, CHAN_MAY_NOT_BE_USED);
		goto kick;
	}

	if (debug)
		log("debug: check_kick CMODE_OPERONLY");

	if (!is_oper_u(user) && ( ci->mlock_on & CMODE_OPERONLY) )
	{
		mask = create_mask(user, 1);
		reason = getstring(user->ni, CHAN_NOT_ALLOWED_TO_JOIN);
		goto kick;
	}

	if (debug)
		log("debug: check_kick nick_recognized()");

	if ( nick_recognized(user) )
		ni = user->ni;
	else
		ni = NULL;

	if (debug)
		log("debug: check_kick akickcount");

	for (akick = ci->akick, i = 0; i < ci->akickcount; akick++, i++)
	{
		if (akick->in_use && (akick->expires != 0 && akick->expires < now) ) {
			akick->in_use = 0;
                        db_akick_del(ci->name, akick->is_nick ?
                                     akick->u.ni->nick : akick->u.mask);
                }

		if ( !akick->in_use )
			continue;
        


		if ( (akick->is_nick && akick->u.ni)
			? ( akick->u.ni == ni
				|| getlink(akick->u.ni) == ni
				|| match_usermask(akick->u.ni->last_usermask,user)
			  ) 
			: ( !akick->is_nick && match_usermask(akick->u.mask, user) )
			)
		{
			if (debug >= 2)
			{
				log("debug: %s matched akick %s", user->nick,
					akick->is_nick ? akick->u.ni->nick : akick->u.mask);
			}
			mask = (akick->is_nick) 
				? create_mask(user, 1)
				: sstrdup(akick->u.mask);
			reason = (akick->reason)
				? akick->reason
				: CSAutobanReason;
			goto kick;
		}
	}

	if (debug)
		log("debug: check_kick bancount");
/*
	for (i = 0; i < ci->c->bancount; i++)
	{
		char *m;
		m = create_mask(user, 1);
        	
		if ( match_wild_nocase(ci->c->bans[i], m) )
		{
			if (debug >= 2)
			{
				log("debug: %s(%s) matched chan-ban %s", 
				user->nick, m, ci->c->bans[i] );
			}
			mask = sstrdup(m);
			free(m);
			goto kick;
		}
	}
*/

	if (((now - start_time) >= CSRestrictDelay)
		&& check_access(user, ci, CA_NOJOIN)  )
	{
		mask = get_hostmask_of( create_mask(user, 1) );
		reason = getstring(user->ni, CHAN_NOT_ALLOWED_TO_JOIN);
		goto kick;
	}

	return 0;

	/* If we reach here, one of the above traps determined to kick
	 * so lets get on with it ...*/
kick:
    if (debug)
    {
        log("debug: channel: AutoKicking %s!%s@%s",
                user->nick, user->username, user->host);
    }

    /* Remember that the user has not been added to our channel user list
     * yet, so we check whether the channel does not exist */

    stay = !findchan(chan);
    av[0] = (char *)chan;
    if (stay)
    {
        cs_join((char *)chan);
        t = add_timeout(CSInhabit, timeout_leave, 0);
        t->data = sstrdup(chan);
    }
    /* Make sure the mask has an ! in it */
    if (!(s = strchr(mask, '!')) || s > strchr(mask, '@'))
    {
        int len = strlen(mask);
        mask = srealloc(mask, len+3);
        memmove(mask+2, mask, len+1);
        mask[0] = '*';
        mask[1] = '!';
    }
    /* Apparently invites can get around bans, so check for ban first */
    if (!chan_has_ban(chan, mask))
    {
        av[1] = "+b";
        av[2] = mask;
        send_cmode(MODE_SENDER(s_ChanServ), chan, "+b", mask);
        do_cmode(s_ChanServ, 3, av);
    }
    free(mask);
    send_cmd(MODE_SENDER(s_ChanServ), "KICK %s %s :%s", chan, user->nick, reason);
    return 1;
}

/*************************************************************************/

/* Tiny helper routine to get K9 out of a channel after it went in. */

static void timeout_leave(Timeout *to)
{
    char *chan = to->data;
    cs_part(chan);
    free(to->data);
    }
	    

/*************************************************************************/
	    
/* Check whether a user is permitted to be on a channel.  If so, return 0;
* else, kickban the user with an appropriate message (could be either
* KICK or restricted access) and return 1.  Note that this is called
* _before_ the user is added to internal channel lists (so do_kick() is
* not called).
*/
		 

int expire_chan_bans(ChannelInfo *ci)
{
    AutoKick     *akick;
    Channel      *chan;
    struct c_userlist *cu;
    struct c_userlist *cu_next;
    time_t       now = time(NULL);
    int          i;
    int          c = 0;
    char         *av[3];

    chan = ci->c;

    if (readonly)
        return 0;

    if (!ci || !chan)
        return 0;

    av[0] = ci->name;
    av[1] = "-b";

    for (akick = ci->akick, i = 0; i < ci->akickcount; akick++, i++)
    {
        if ( akick->in_use && akick->expires ? akick->expires > now : 1 )
            continue;

        cu = chan->users;
        while (cu)
        {
            cu_next = cu->next;
            av[2] = akick->is_nick 
              ? (akick->u.ni->last_usermask)
                ? akick->u.ni->last_usermask
                : ""
              : akick->u.mask;

            if ( chan_has_ban(ci->name, av[2]) )
	    {
                send_cmode(MODE_SENDER(s_ChanServ), av[0], av[1], av[2]);
                do_cmode(s_ChanServ, 3, av);
            }
            cu = cu_next;
        }
        c += akick_del(ci->name, NULL, akick);
    }
    if ( c > 0 )
        log("%s: Expiring %d Channel Bans for %s", s_ChanServ, c, ci->name);

    return c;
}

/*************************************************************************/

int expire_bans(void)
{
    ChannelInfo  *ci;
    int i = 0;

    ci = cs_firstchan();
    while (ci)
    {
        i += expire_chan_bans(ci);
        ci = cs_nextchan();
    }
    return i;
}

/*************************************************************************/

int expire_chan_autoops(ChannelInfo *ci)
{
	ChannelAutoop *autoop;
	NickInfo *ni = NULL;
	NickInfo *target = NULL;
	int16 i;
	int16 oldcount = ci->autoopcount;
	int16 newautoopcount = 0;
	int16 c;

	/* Determine if the Autoop list has stale accounts or nicks which are no longer
	 * valid.  Do this by comparing if the NS account listed matches that of a 'found'
	 * user..  If not, deactivate it.
	 */
	for (i=0; i<ci->autoopcount; i++)
	{
		if (! (ci->autoop[i].in_use &&
		    (ni = ci->autoop[i].ni) &&
	    	    (target = findnick(ni->nick)) &&
		    ni && target &&
	    	    ni == target
		))
		{
			log("Autoop Record for %s on %s found to be stale, removing",
				ni ? ni->nick : "UNKNOWN",
				ci ? ci->name : "NO-CHAN" 
			 );
			ci->autoop[i].in_use = 0;
		}

		/* If the Autoop record is not in use we reset its contents
		 * to empty.  This may not be nescessary due to later work
	 	 * but we do it to be sure..
		 */
	 
		if (! ci->autoop[i].in_use )
		{
			ci->autoop[i].ni = NULL;
			ci->autoop[i].flag = '\0';
		} else {
			newautoopcount++;
		}
	}

	/* At this point ,we are going to dynamically recreate the entire 
	 * Autoop list for this channel.  This is done to prevent channels
	 * from having hundreds of members with Autoop set, and them removing
	 * all but a few, we would still allocate memory for the 'old' list..
	 */

	autoop = scalloc(sizeof(ChannelAutoop), newautoopcount);
	memset(autoop, 0, sizeof(autoop) );
		
	for (i=0,c=0; i < ci->autoopcount; i++)
	{
		if (ci->autoop[i].in_use)
		{
			autoop[c].in_use = 1;
			autoop[c].ni = ci->autoop[i].ni;
			autoop[c].flag = ci->autoop[i].flag;
			c++;
			
		} else {
			autoop[c].in_use = 0;
			autoop[c].ni = NULL;
			autoop[c].flag = '\0';
		}
	}

	free(ci->autoop);
	ci->autoop = autoop;
	ci->autoopcount = newautoopcount;

	if (oldcount != newautoopcount)
		log("Autoop list for %s changed from %d to %d",
			ci->name, oldcount, newautoopcount
		);
	return (oldcount - newautoopcount);
}

/*************************************************************************/

int expire_autoops(void)
{
	ChannelInfo  *ci;
	int i = 0;

	ci = cs_firstchan();
	while (ci)
	{
		i += expire_chan_autoops(ci);
		ci = cs_nextchan();
	}
	return i;
}

/*************************************************************************/

static int akick_list(User *u, int index, ChannelInfo *ci, int *sent_header, int is_view)
{
    AutoKick *akick = &ci->akick[index];
    char buf[BUFSIZE];

    expire_chan_bans(ci);
    expire_chan_autoops(ci);
    
    if (!akick->in_use)
        return 0;

    if (!*sent_header)
    {
        notice_lang(s_ChanServ, u, CHAN_BANLIST, ci->name);
        *sent_header = 1;
    }
    if (akick->is_nick)
    {
      if (akick->u.ni) {
        snprintf(buf, sizeof(buf), "Nick: %s (%s)",
            akick->u.ni->nick,
            (akick->u.ni->flags & NI_HIDE_MASK)
              ? "Host Hidden"
              : akick->u.ni->last_usermask);
      } else
        log("ERROR: NULL NICK?");

    } else {
        snprintf(buf, sizeof(buf), " %s", akick->u.mask);
    }

    if (akick->expires)
    {
        char expirebuf[BUFSIZE];
        expires_in_lang(expirebuf, sizeof(expirebuf), u->ni, akick->expires);
	notice(s_ChanServ, u->nick, "ID: %d BANNED MASK: %s BANNED BY: %s", index+1, buf, akick->who[0] ? akick->who : "<unknown");	
	notice(s_ChanServ, u->nick, "REASON:%s", (akick->reason) ? akick->reason : CSAutobanReason);
	notice(s_ChanServ, u->nick, "EXPIRES IN: %s", expirebuf);
	notice(s_ChanServ, u->nick, " ");
    } 
    else 
    {
	notice(s_ChanServ, u->nick, "ID: %d BANNED MASK: %s BANNED BY: %s", index+1, buf, akick->who[0] ? akick->who : "<unknown");	
	notice(s_ChanServ, u->nick, "REASON:%s", (akick->reason) ? akick->reason : CSAutobanReason);
	notice(s_ChanServ, u->nick, "EXPIRES IN: PERM BAN");
	notice(s_ChanServ, u->nick, " ");
    }


    return 1;
}

/*************************************************************************/

static int akick_del_callback(User *u, int num, va_list args)
{
    ChannelInfo *ci = va_arg(args, ChannelInfo *);
    int *last = va_arg(args, int *);
    char *av[3];

    if (num < 1 || num > ci->akickcount)
        return 0;
    *last = num;

    if (!ci->akick->is_nick && (chan_has_ban(ci->name, ci->akick->u.mask)))
    {
        av[0] = ci->name;
        av[1] = "-b";
        av[2] = ci->akick->u.mask;

        send_cmode(MODE_SENDER(s_ChanServ), av[0], av[1], av[2]);
        do_cmode(s_ChanServ, 3, av);
    }
    else if (ci->akick->is_nick) {

        av[0] = ci->name;
        av[1] = "-b";
        av[2] = get_hostmask_of(u->ni->last_usermask);

        if (av[2] && chan_has_ban(ci->name, av[2])) { 
          send_cmode(MODE_SENDER(s_ChanServ), av[0], av[1], av[2]);
          do_cmode(s_ChanServ, 3, av);
          free(av[2]);
        }

    }

    return akick_del(ci->name, u, &ci->akick[num-1]);
}

/*************************************************************************/

#ifdef DISABLED
static int akick_list_callback(User *u, int num, va_list args)
{
    ChannelInfo *ci = va_arg(args, ChannelInfo *);
    int *sent_header = va_arg(args, int *);
    int is_view = va_arg(args, int);
    if (num < 1 || num > ci->akickcount)
        return 0;
    return akick_list(u, num-1, ci, sent_header, is_view);
}
#endif

/*************************************************************************/

static int akick_del(char *chan, User *u, AutoKick *akick)
{
    if (!akick->in_use)
        return 0;
    if (akick->is_nick)
    {
        if (akick->u.ni)
        {
            db_akick_del(chan, akick->u.ni->nick);
            akick->u.ni = NULL;
        }
    }
    else
    {
        if (akick->u.mask)
        {
            db_akick_del(chan, akick->u.mask);
            free(akick->u.mask);
            akick->u.mask = NULL;
        }
    }
    if (akick->reason)
    {
        free(akick->reason);
        akick->reason = NULL;
    }

    akick->in_use = akick->is_nick = akick->time = akick->expires = 0;
    return 1;
}

/*************************************************************************/

/* Iterate over all ChannelInfo structures.  Return NULL when called after
 * reaching the last channel.
 */

static int iterator_pos = HASHSIZE;   /* return NULL initially */
static ChannelInfo *iterator_ptr = NULL;

ChannelInfo *cs_firstchan(void)
{
    iterator_pos = -1;
    iterator_ptr = NULL;
    return cs_nextchan();
}

/*************************************************************************/

ChannelInfo *cs_nextchan(void)
{
    if (iterator_ptr)
	iterator_ptr = iterator_ptr->next;
    while (!iterator_ptr && iterator_pos < HASHSIZE) {
	iterator_pos++;
	if (iterator_pos < HASHSIZE)
	    iterator_ptr = chanlists[iterator_pos];
    }
    return iterator_ptr;
}

/*************************************************************************/

/* Return information on memory use.  Assumes pointers are valid. */

void get_chanserv_stats(long *nrec, long *memuse)
{
    long count = 0, mem = 0;
    int i;
    ChannelInfo *ci;

    for (ci = cs_firstchan(); ci; ci = cs_nextchan()) {
	count++;
	mem += sizeof(*ci);
	if (ci->desc)
	    mem += strlen(ci->desc)+1;
	if (ci->url)
	    mem += strlen(ci->url)+1;
	if (ci->email)
	    mem += strlen(ci->email)+1;
	mem += ci->accesscount * sizeof(ChanAccess);
        mem += ci->akickcount * sizeof(AutoKick);
        for (i = 0; i < ci->akickcount; i++) {
            if (!ci->akick[i].is_nick && ci->akick[i].u.mask)
                mem += strlen(ci->akick[i].u.mask)+1;
            if (ci->akick[i].reason)
                mem += strlen(ci->akick[i].reason)+1;
        }
        if (ci->autoopcount)
            mem += ci->autoopcount * sizeof(ChannelAutoop);
	if (ci->commentcount)
		mem += ci->commentcount * sizeof(ChannelComment);
	if (ci->mlock_key)
	    mem += strlen(ci->mlock_key)+1;
	if (ci->last_topic)
	    mem += strlen(ci->last_topic)+1;
        for (i = 0; i < ci->entrycount; i++)
        {
            mem += strlen(ci->entrymsg[i])+1;
        }

	if (ci->levels)
	    mem += sizeof(*ci->levels) * CA_SIZE;
    }
    *nrec = count;
    *memuse = mem;
}

/*************************************************************************/
/************************ Global utility routines ************************/
/*************************************************************************/

#include "cs-loadsave.c"

/*************************************************************************/

/* Check the current modes on a channel; if they conflict with a mode lock,
 * fix them. */

void check_modes(const char *chan)
{
    Channel *c = findchan(chan);
    ChannelInfo *ci;
    char newmodes[40];	/* 31 possible modes + extra leeway */
    char *newkey = NULL;
    int32 newlimit = 0;
    char *end = newmodes;
    int modes;
    int set_limit = 0, set_key = 0;

    if (!c || c->bouncy_modes)
	return;

    if (!NoBouncyModes) {
	/* Check for mode bouncing */
	if (c->server_modecount >= 3 && c->chanserv_modecount >= 3) {
#if defined(IRC_DALNET) || defined(IRC_UNDERNET)
	    wallops(NULL, "Warning: unable to set modes on channel %s.  "
		    "Are your servers' U:lines configured correctly?", chan);
#else
	    wallops(NULL, "Warning: unable to set modes on channel %s.  "
		    "Are your servers configured correctly?", chan);
#endif
	    log("%s: Bouncy modes on channel %s (%d)(%d)", s_ChanServ, c->name,
	    	c->server_modecount, c->chanserv_modecount);
	    c->bouncy_modes = 1;
	    return;
	}
	if (c->chanserv_modetime != time(NULL)) {
	    c->chanserv_modecount = 0;
	    c->chanserv_modetime = time(NULL);
	}
	c->chanserv_modecount++;
    }

    ci = c->ci;
    if (!ci) {
	/* Services _always_ knows who should be +r. If a channel tries to be
	 * +r and is not registered, send mode -r. This will compensate for
	 * servers that are split when mode -r is initially sent and then try
	 * to set +r when they rejoin. -TheShadow
	 */
	if (c->mode & CMODE_REG) {
	    c->mode &= ~CMODE_REG;
	    send_cmd(MODE_SENDER(s_ChanServ), "MODE %s -%s", c->name,
		     mode_flags_to_string(CMODE_REG, MODE_CHANNEL));
	}
	return;
    }

    modes = ~c->mode & (ci->mlock_on | CMODE_REG);
    end += snprintf(end, sizeof(newmodes)-(end-newmodes)-2,
		    "+%s", mode_flags_to_string(modes, MODE_CHANNEL));
    c->mode |= modes;
    if (ci->mlock_limit && ci->mlock_limit != c->limit) {
	*end++ = 'l';
	newlimit = ci->mlock_limit;
	c->limit = newlimit;
	set_limit = 1;
    }
    if (ci->mlock_key) {
	if (c->key && strcmp(c->key, ci->mlock_key) != 0) {
	    /* Send this directly, since send_cmode() will edit it out */
	    send_cmd(MODE_SENDER(s_ChanServ), "MODE %s -k %s",
		     c->name, c->key);
	    free(c->key);
	    c->key = NULL;
	}
	if (!c->key) {
	    *end++ = 'k';
	    newkey = ci->mlock_key;
	    c->key = sstrdup(newkey);
	    set_key = 1;
	}
    }
    if (end[-1] == '+')
	end--;

    modes = c->mode & ci->mlock_off;
    end += snprintf(end, sizeof(newmodes)-(end-newmodes)-1,
		    "-%s", mode_flags_to_string(modes, MODE_CHANNEL));
    c->mode &= ~modes;
    if (c->limit && (ci->mlock_off & CMODE_l)) {
	*end++ = 'l';
	c->limit = 0;
    }
    if (c->key && (ci->mlock_off & CMODE_k)) {
	*end++ = 'k';
	newkey = sstrdup(c->key);
	free(c->key);
	c->key = NULL;
	set_key = 1;
    }
    if (end[-1] == '-')
	end--;

    if (end == newmodes)
	return;
    *end = 0;
    if (set_limit) {
	char newlimit_str[32];
	snprintf(newlimit_str, sizeof(newlimit_str), "%d", newlimit);
	send_cmode(MODE_SENDER(s_ChanServ), c->name, newmodes, newlimit_str,
		   newkey ? newkey : "");
    } else {
	send_cmode(MODE_SENDER(s_ChanServ), c->name, newmodes,
		   newkey ? newkey : "");
    }

    if (newkey && !c->key)
	free(newkey);
}

/*************************************************************************/

/* Check whether a user should be opped or voiced on a channel, and if so,
 * do it.  Return the user's new modes on the channel (CUMODE_* flags).
 * Updates the channel's last used time if the user is opped.  `modes' is
 * the user's current mode set.  `source' is the source of the message
 * which caused the mode change, NULL for a join.
 * On Unreal servers, sets +q mode for channel founder or identified users.
 */

int check_chan_user_modes(const char *source, User *user, const char *chan, int32 modes)
{
	ChannelInfo *ci = cs_findchan(chan);
	NickInfo *ni = user->ni;    
	ChannelAutoop *autoop = NULL;
	int i = 0;
	int is_servermode = (!source || strchr(source, '.') != NULL);

	/* Don't change modes on unregistered, forbidden, or modeless channels */
	if (!ci || (ci->flags & CI_VERBOTEN) || *chan == '+')
		return modes;

    /* Don't reverse mode changes made by the user him/herself, or by
     * K9 Services (because we prevent people from doing improper mode changes
     * via Services already, so anything that gets here must be okay). */

	if (source && (irc_stricmp(source, user->nick) == 0
	  || irc_stricmp(source, s_ChanServ) == 0))
		return modes;

#ifdef IRC_UNREAL
	/* Don't change modes for a +I user */
	if (user->mode & UMODE_I)
		return modes;
#endif

	/* Check early for server auto-ops */
/*
    if ((modes & CUMODE_o)
     && !(ci->flags & CI_LEAVEOPS)
     && is_servermode
     && time(NULL)-start_time >= CSRestrictDelay     
     && !check_access(user, ci, CA_AUTOOP)     

     && (ni && check_access(user, ci, CA_AUTOOP) && !nick_identified(user) && !(ci->access->ni->flags & CI_AUTOOP))    
    ) {
        char modebuf[3];
	modebuf[0] = '-';
	modebuf[1] = mode_flag_to_char(CUMODE_o, MODE_CHANUSER);
	modebuf[2] = 0;        
	notice_lang(s_ChanServ, user, CHAN_IS_REGISTERED, s_ChanServ);
	send_cmode(MODE_SENDER(s_ChanServ), chan, modebuf, user->nick);
	modes &= ~CUMODE_o;
    }
*/

	/* Mode additions.  Only check for join or server mode change, unless
	 * ENFORCE is set */
	if (is_servermode || (ci->flags & CI_ENFORCE))
	{
		int set = 0;
#ifdef HAVE_CHANPROT
		if (is_founder(user, ci))
		{
			ci->last_used = time(NULL);
                        db_update_lastused(ci);
			if (!(modes & CUMODE_q))
			{
				send_cmode(MODE_SENDER(s_ChanServ), chan, "+q", user->nick);
				modes |= CUMODE_q;
				set++;
			}
		}
		else if (check_access(user, ci, CA_AUTOPROTECT))
		{
			ci->last_used = time(NULL);
                        db_update_lastused(ci);
			if (!(modes & CUMODE_a))
			{
				send_cmode(MODE_SENDER(s_ChanServ), chan, "+a", user->nick);
				modes |= CUMODE_a;
				set++;
			}    
		}	
#endif
		if (check_access(user, ci, CA_AUTOOP))
		{
			for (i=0; i < ci->autoopcount; i++)
			{
				if (ci->autoop[i].in_use && ci->autoop[i].ni == getlink(ni))
				{
					autoop = &ci->autoop[i];
					break;
				}
			}
			if (autoop && autoop->flag)
			{
				if (autoop->flag == 't' || autoop->flag == 'T')
				{
					if (nick_identified(user))
					{
						ci->last_used = time(NULL);
                                                db_update_lastused(ci);
						if (!(modes & CUMODE_o))
						{
							char modebuf[3];
							modebuf[0] = '+';
							modebuf[1] = mode_flag_to_char(CUMODE_o, MODE_CHANUSER);
							modebuf[2] = 0;  
							send_cmode(MODE_SENDER(s_ChanServ), chan, modebuf, user->nick);
							modes |= CUMODE_o;
							set++;
						}
					}
				}
				else if (autoop->flag == 'v' || autoop->flag == 'V') 
				{
					if (nick_identified(user))
					{ 
						char *av[3];
						av[0] = sstrdup(chan);
						av[1] = "+v";
						av[2] = user->nick;
						ci->last_used = time(NULL);
                                                db_update_lastused(ci);
						if (!(modes & CUMODE_v))
						{
							char modebuf[3];
							modebuf[0] = '+';
							modebuf[1] = mode_flag_to_char(CUMODE_v, MODE_CHANUSER);
							modebuf[2] = 0;  
							send_cmode(MODE_SENDER(s_ChanServ), chan, modebuf, user->nick);
							modes |= CUMODE_v;
							set++;
						}
						free( (char *) av[0] );
					}
				}
			}
		}

		if (set)
			return modes;  /* don't bother checking for mode subtractions */
	}
	/* Don't subtract modes from opers or Cservice Heads */

//	if ( is_oper_u(user) || is_cservice_member(user) )
//		return modes;

	return modes;
}

/*************************************************************************/

/* Record the current channel topic in the ChannelInfo structure. */

void record_topic(Channel *c)
{
    ChannelInfo *ci = c->ci;

    if (readonly || !ci)
	return;
    if (ci->last_topic)
	free(ci->last_topic);
    if (c->topic)
	ci->last_topic = sstrdup(c->topic);
    else
	ci->last_topic = NULL;
    strscpy(ci->last_topic_setter, c->topic_setter, NICKMAX);
    ci->last_topic_time = c->topic_time;

    db_topic(ci);

}

/*************************************************************************/

void remove_comment(ChannelInfo *ci, NickInfo *ni)
{
    int i;

    for (i = 0; i < ci->commentcount; i++)
    {
        if (ci->comment[i].in_use && ci->comment[i].ni == ni) {
            ci->comment[i].in_use = 0;
            ci->comment[i].ni = NULL;	    
	    if (ci->comment[i].msg)
                memset(ci->comment[i].msg, '\0', sizeof(ci->comment[i].msg));		
        }
    }
}

/*************************************************************************/

void remove_autoop(ChannelInfo *ci, NickInfo *ni)
{
    int i;

    for (i = 0; i < ci->autoopcount; i++)
    {
        if (ci->autoop[i].in_use && ci->autoop[i].ni == getlink(ni)) {
            ci->autoop[i].in_use = 0;
            ci->autoop[i].ni = NULL;
            ci->autoop[i].flag = '\0';
        }
    }

    db_remove_autoop(ci, ni);
}


/*************************************************************************/

void record_autoop(ChannelInfo *ci, NickInfo *ni, char *msg)
{
	ChannelAutoop *autoop;
	int i;

	if (!msg)
		return;

	remove_autoop(ci,ni);

	for (i = 0; i < ci->autoopcount; i++)
	{
		if ( !ci->autoop[i].in_use 
			|| (ci->autoop[i].ni == getlink(ni) )
		)
		break;
	}
/*
	for (i = 0; i < ci->autoopcount; i++)
	{
		if (!ci->autoop[i].in_use)
			break;
	}
*/
	if (i == ci->autoopcount)
	{
		ci->autoopcount++;
		ci->autoop =
			srealloc(ci->autoop, sizeof(ChannelAutoop) * ci->autoopcount);
	}

	autoop = &ci->autoop[i];

	autoop->in_use = 1;
	autoop->ni = getlink(ni);
	autoop->flag = msg[0];

        db_autoop(ci, ni, msg[0]);
}

/*************************************************************************/

void record_comment(ChannelInfo *ci, NickInfo *ni, char *msg)
{
	ChannelComment *comment;
	int i;
	char *p;

	if (!msg)
		return;

	remove_comment(ci,ni);

	for (i = 0; i < ci->commentcount; i++)
	{
		if ( !ci->comment[i].in_use
			|| (ci->comment[i].ni == getlink(ni) )
		)
			break;
	}
/*
	for (i = 0; i < ci->commentcount; i++)
	{
		if (!ci->comment[i].in_use)
			break;
	}
*/
	if (i == ci->commentcount)
	{
		ci->commentcount++;
		ci->comment =
			srealloc(ci->comment, sizeof(ChannelComment) * ci->commentcount);
	}

	comment = &ci->comment[i];

	comment->in_use = 1;
	comment->ni = getlink(ni);
	strncpy(comment->msg, msg, sizeof(comment->msg));
	p = comment->msg;
	p[COMMENTMAX] = '\0';

        db_comment(ci, ni, msg);
}

/*************************************************************************/

/* Restore the topic in a channel when it's created, if we should. */

void restore_topic(Channel *c)
{
    ChannelInfo *ci = c->ci;

    if (!ci || !(ci->flags & CI_KEEPTOPIC))
	return;
    set_topic(c, ci->last_topic,
	      *ci->last_topic_setter ? ci->last_topic_setter : s_ChanServ,
	      ci->last_topic_time);
}

/*************************************************************************/

/* See if the topic is locked on the given channel, and return 1 (and fix
 * the topic) if so, 0 if not. */

int check_topiclock(const char *chan)
{
    Channel *c = findchan(chan);
    ChannelInfo *ci;

    if (!c || !(ci = c->ci) || !(ci->flags & CI_TOPICLOCK))
	return 0;
    set_topic(c, ci->last_topic,
	      *ci->last_topic_setter ? ci->last_topic_setter : s_ChanServ,
	      ci->last_topic_time);
    return 1;
}

/*************************************************************************/

/* Remove all channels and clear all suspensions which have expired. */

void expire_chans()
{
    ChannelInfo *ci, *next;
    time_t now = time(NULL);
    Channel *c;

    if (!CSExpire)
	return;

    for (ci = cs_firstchan(); ci; ci = next) {
	next = cs_nextchan();
	if (now >= ci->last_used + CSExpire
	 && !(ci->flags & (CI_VERBOTEN | CI_NOEXPIRE))
	 && !ci->suspendinfo
	) {
	    log("%s: Expiring channel %s", s_ChanServ, ci->name);
	    if (CMODE_REG && (c = findchan(ci->name))) {
		c->mode &= ~CMODE_REG;
		/* Send this out immediately, no send_cmode() delay */
		send_cmd(s_ChanServ, "MODE %s -%s", ci->name,
			 mode_flags_to_string(CMODE_REG, MODE_CHANNEL));
	    }
	    delchan(ci);
	} else if (ci->suspendinfo && ci->suspendinfo->expires
		   && now >= ci->suspendinfo->expires) {
	    log("%s: Expiring suspension for %s", s_ChanServ, ci->name);
	    unsuspend(ci, 1);
	}
    }
}

/*************************************************************************/

/* Remove a (deleted or expired) nickname from all channel lists. */

void cs_remove_nick(const NickInfo *ni)
{
    int i;
    ChannelInfo *ci, *next;
    ChanAccess *ca;
    AutoKick *akick;
    ChannelComment *cc;

    for (ci = cs_firstchan(); ci; ci = next) {
	next = cs_nextchan();
	if (ci->founder == ni) {
	    int was_suspended = (ci->suspendinfo != NULL);
	    char name_save[CHANMAX];
	    if (was_suspended)
		strscpy(name_save, ci->name, CHANMAX);
	    uncount_chan(ci);  /* Make sure it disappears from founderchans */
	    if (ci->successor) {
		NickInfo *ni2 = ci->successor;
		if (check_channel_limit(ni2) < 0) {
		    log("%s: Transferring foundership of %s from deleted "
			"nick %s to successor %s",
			s_ChanServ, ci->name, ni->nick, ni2->nick);
		    ci->founder = ni2;
                    db_chan_set(ci, "foundernick", ci->founder->nick);
		    ci->successor = NULL;
                    db_chan_set(ci, "successornick", NULL);
		    count_chan(ci);
		} else {
		    log("%s: Successor (%s) of %s owns too many channels, "
			"deleting channel",
			s_ChanServ, ni2->nick, ci->name);
		    goto delete;
		}
	    } else {
		log("%s: Deleting channel %s owned by deleted nick %s",
		    s_ChanServ, ci->name, ni->nick);
	      delete:
		delchan(ci);
		if (was_suspended) {
		    /* Channel was suspended, so make it forbidden */
		    log("%s: Channel %s was suspended, forbidding it",
			s_ChanServ, name_save);
		    ci = makechan(name_save);
		    ci->flags |= CI_VERBOTEN;
                    db_chan_seti(ci, "flags", ci->flags);
		}
		continue;
	    }
	}
	if (ci->successor == ni)
	    ci->successor = NULL;
	for (ca = ci->access, i = ci->accesscount; i > 0; ca++, i--) {
	    if (ca->in_use && ca->ni == ni) {
		ca->in_use = 0;
		ca->ni = NULL;
	    }
	}
        for (cc = ci->comment, i = ci->commentcount; i > 0; cc++,i--)
        {
            if (cc->in_use && cc->ni == ni)
            {
                cc->in_use = 0;
                cc->ni = NULL;
            }
        }
        for (akick = ci->akick, i = ci->akickcount; i > 0; akick++, i--)
        {
            if (akick->is_nick && akick->u.ni == ni) {
                akick->in_use = akick->is_nick = 0;
                akick->u.ni = NULL;
                if (akick->reason) {
                    free(akick->reason);
                    akick->reason = NULL;
                }
            }
       }
																														    	
	
    }
}

/*************************************************************************/

#define RET_ADDED       1
#define RET_CHANGED     2

static int owner_add(const char *chan, const char *nick)
{
    int i;
    ChanAccess *access;
    NickInfo *ni;
    ChannelInfo *ci = cs_findchan(chan);
    int ownerlevel = 500;
    ni = findnick(nick);

    for (access = ci->access, i = 0; i < ci->accesscount; access++, i++) {
        if (access->ni == ni) {
            /* Don't allow lowering from a level >= uacc */
            access->level = ownerlevel;
            return RET_CHANGED;
            access->level = ownerlevel;
            return RET_CHANGED;
        }
    }
    for (i = 0; i < ci->accesscount; i++) {
        if (!ci->access[i].in_use)
            break;
    }
    if (i == ci->accesscount) {
        if (i < CSAccessMax) {
            ci->accesscount++;
            ci->access =
                srealloc(ci->access, sizeof(ChanAccess) * ci->accesscount);
        }
    }
    access = &ci->access[i];
    access->ni = ni;
    access->in_use = 1;
    access->level = ownerlevel;
    return RET_ADDED;
}

/*************************************************************************/

static int emperor_add(const char *chan, const char *nick)
{
    int i;
    ChanAccess *access;
    NickInfo *ni;
    ChannelInfo *ci = cs_findchan(chan);
    int cslevel = 800;
    ni = findnick(nick);

    for (access = ci->access, i = 0; i < ci->accesscount; access++, i++) {
        if (access->ni == ni) {
            /* Don't allow lowering from a level >= uacc */
            access->level = cslevel;
            return RET_CHANGED;
            access->level = cslevel;
            return RET_CHANGED;
        }
    }
    for (i = 0; i < ci->accesscount; i++) {
        if (!ci->access[i].in_use)
            break;
    }
    if (i == ci->accesscount) {
        if (i < CSAccessMax) {
            ci->accesscount++;
            ci->access =
                srealloc(ci->access, sizeof(ChanAccess) * ci->accesscount);
        } 
    }
    access = &ci->access[i];
    access->ni = ni;
    access->in_use = 1;
    access->level = cslevel;
    return RET_ADDED;
}

/*************************************************************************/

/* Return access level if the user's access level on the given channel falls into the
 * given category, 0 otherwise.  |SaMaN| */

int check_cservice(User *user)
{

    ChannelInfo *ci = cs_findchan(CSChan);

    int level = get_access(user,ci);

    if (level >= 600)
    {
       return level;
    }
    return(0);
}

/*************************************************************************/

/* Return 1 if the user's access level on the given channel falls into the
 * given category, 0 otherwise.  Note that this may seem slightly confusing
 * in some cases: for example, check_access(..., CA_NOJOIN) returns true if 
 * the user does _not_ have access to the channel (i.e. matches the NOJOIN
 * criterion). */
    

int check_access(User *user, ChannelInfo *ci, int what)
{

    int level = get_access(user, ci);
    int limit = ci->levels[what];

    if (level == ACCLEV_FOUNDER)
	return (what==CA_AUTODEOP || what==CA_NOJOIN) ? 0 : 1;
    /* Hacks to make flags work */
    if (what == CA_AUTODEOP && (ci->flags & CI_SECUREOPS) && level == 0)
	return 1;
    if (limit == ACCLEV_INVALID)
	return 0;
    if (what == CA_AUTODEOP || what == CA_NOJOIN)
	return level <= ci->levels[what];
    else
	return level >= ci->levels[what];
}

/*************************************************************************/

/* Check the nick's number of registered channels against its limit, and
 * return -1 if below the limit, 0 if at it exactly, and 1 if over it.
 */

int check_channel_limit(NickInfo *ni)
{
    register uint16 max, count;

    ni = getlink(ni);
    max = ni->channelmax;
    if (!max)
	max = MAX_CHANNELCOUNT;
    count = ni->channelcount;
    return count<max ? -1 : count==max ? 0 : 1;
}

/*************************************************************************/

/* Return a string listing the options (those given in chanopts[]) set on
 * the given channel.  Uses the given NickInfo for language information.
 * The returned string is stored in a static buffer which will be
 * overwritten on the next call.
 */

char *chanopts_to_string(ChannelInfo *ci, NickInfo *ni)
{
    static char buf[BUFSIZE];
    char *end = buf;
    const char *commastr = getstring(ni, COMMA_SPACE);
    const char *s;
    int need_comma = 0;
    int i;

    for (i = 0; chanopts[i].name && end-buf < sizeof(buf)-1; i++) {
	if (ni && chanopts[i].namestr < 0)
	    continue;
	if (ci->flags & chanopts[i].flag && chanopts[i].namestr >= 0) {
	    s = getstring(ni, chanopts[i].namestr);
	    if (need_comma)
		end += snprintf(end, sizeof(buf)-(end-buf), "%s", commastr);
	    end += snprintf(end, sizeof(buf)-(end-buf), "%s", s);
	    need_comma = 1;
	}
    }
    return buf;
}

/*************************************************************************/
/*********************** ChanServ private routines ***********************/
/*************************************************************************/

/* Insert a channel alphabetically into the database. */

void alpha_insert_chan(ChannelInfo *ci)
{
    ChannelInfo *ptr, *prev;
    char *chan = ci->name;
    int hash = HASH(chan);

    for (prev = NULL, ptr = chanlists[hash];
	 ptr != NULL && irc_stricmp(ptr->name, chan) < 0;
	 prev = ptr, ptr = ptr->next)
	;
    ci->prev = prev;
    ci->next = ptr;
    if (!prev)
	chanlists[hash] = ci;
    else
	prev->next = ci;
    if (ptr)
	ptr->prev = ci;
}

/*************************************************************************/

/* Add a channel to the database.  Returns a pointer to the new ChannelInfo
 * structure if the channel was successfully registered, NULL otherwise.
 * Assumes channel does not already exist. */

static ChannelInfo *makechan(const char *chan)
{
    ChannelInfo *ci;

    ci = scalloc(sizeof(ChannelInfo), 1);
    strscpy(ci->name, chan, CHANMAX);
    ci->time_registered = time(NULL);
    reset_levels(ci);
    alpha_insert_chan(ci);
    return ci;
}

/*************************************************************************/

/* Remove a channel from the K9 database.  Return 1 on success, 0
 * otherwise. */

static int delchan(ChannelInfo *ci)
{
    User *u;
    int i;

    /* Remove the channel from the SQL database */
    db_delete_chan(ci->name);

    /* Remove channel from founder's owned-channel count */
    uncount_chan(ci);

    /* Clear channel from users' identified-channel lists */
    for (u = firstuser(); u; u = nextuser()) {
	struct u_chaninfolist *uc, *next;
	for (uc = u->founder_chans; uc; uc = next) {
	    next = uc->next;
	    if (uc->chan == ci) {
		if (uc->next)
		    uc->next->prev = uc->prev;
		if (uc->prev)
		    uc->prev->next = uc->next;
		else
		    u->founder_chans = uc->next;
		free(uc);
	    }
	}
    }

    /* Now actually free channel data */
    if (ci->c)
	ci->c->ci = NULL;
    if (ci->next)
	ci->next->prev = ci->prev;
    if (ci->prev)
	ci->prev->next = ci->next;
    else
	chanlists[HASH(ci->name)] = ci->next;
    if (ci->desc)
	free(ci->desc);
    if (ci->mlock_key)
	free(ci->mlock_key);
    if (ci->last_topic)
	free(ci->last_topic);
    if (ci->suspendinfo)
	unsuspend(ci, 0);
    if (ci->access)
	free(ci->access);
    /* Remove comments */	
    for (i = 0; i < ci->commentcount; i++)
    {
        ci->comment[i].in_use = 0;
        memset(ci->comment[i].msg,'\0', sizeof(ci->comment[i].msg));
    }
    /* Remove onjoin */
    do_set_entrymsg(u, ci, NULL);
    
    for (i = 0; i < ci->akickcount; i++)
    {
        if (!ci->akick[i].is_nick && ci->akick[i].u.mask)
            free(ci->akick[i].u.mask);
        if (ci->akick[i].reason)
            free(ci->akick[i].reason);
    }
    if (ci->akick)
        free(ci->akick);
    if (ci->levels)
	free(ci->levels);

    free(ci);

    return 1;
}

/*************************************************************************/

/* Mark the given channel as owned by its founder.  This updates the
 * founder's list of owned channels (ni->founderchans) and the count of
 * owned channels for the founder and all linked nicks.
 */

void count_chan(ChannelInfo *ci)
{
    NickInfo *ni = ci->founder;

    if (!ni)
	return;
    ni->foundercount++;
    ni->founderchans = srealloc(ni->founderchans,
				sizeof(*ni->founderchans) * ni->foundercount);
    ni->founderchans[ni->foundercount-1] = ci;
    while (ni) {
	/* Be paranoid--this could overflow in extreme cases, though we
	 * check for that elsewhere as well. */
	if (ni->channelcount+1 > ni->channelcount)
	    ni->channelcount++;
	ni = ni->link;
    }
}

/*************************************************************************/

/* Mark the given channel as no longer owned by its founder. */

static void uncount_chan(ChannelInfo *ci)
{
    NickInfo *ni = ci->founder;
    int i;

    if (!ni)
	return;
    for (i = 0; i < ni->foundercount; i++) {
	if (ni->founderchans[i] == ci) {
	    ni->foundercount--;
	    if (i < ni->foundercount)
		memmove(&ni->founderchans[i], &ni->founderchans[i+1],
			sizeof(*ni->founderchans) * (ni->foundercount-i));
	    ni->founderchans = srealloc(ni->founderchans,
			sizeof(*ni->founderchans) * ni->foundercount);
	    break;
	}
    }
    while (ni) {
	if (ni->channelcount > 0)
	    ni->channelcount--;
	ni = ni->link;
    }
}

/*************************************************************************/

/* Reset channel access level values to their default state. */


void reset_levels(ChannelInfo *ci)
{
    int i;

    if (ci->levels)
	free(ci->levels);
    ci->levels = scalloc(CA_SIZE, sizeof(*ci->levels));
    for (i = 0; def_levels[i][0] >= 0; i++)
	ci->levels[def_levels[i][0]] = def_levels[i][1];
}


/*************************************************************************/

/* Does the given user have access to the channel? 
 * User does not have to be online - |SaMaN| */


static int has_access(User *user, ChannelInfo *ci)
{
    NickInfo *ni = user->ni;
    ChanAccess *access;
    int i;
    
    if (!ci || !ni || (ci->flags & CI_VERBOTEN) || ci->suspendinfo)
            return 0;
	    
    for (access = ci->access, i = 0; i < ci->accesscount; access++, i++) {
            if (access->in_use && getlink(access->ni) == ni)
                return 1;
    }
    return 0;					    
}
									 
/*************************************************************************/

/* Does the given user have founder access to the channel? */


static int is_founder(User *user, ChannelInfo *ci)
{
    if ((ci->flags & CI_VERBOTEN) || ci->suspendinfo)
	return 0;
    if (user->ni == getlink(ci->founder)) {
	if ((nick_identified(user) ||
		 (nick_recognized(user) && !(ci->flags & CI_SECURE))))
	    return 1;
    }
    if (is_identified(user, ci))
	return 1;
    return 0;
}

/*************************************************************************/

/* Has the given user password-identified as founder for the channel? */

static int is_identified(User *user, ChannelInfo *ci)
{
    struct u_chaninfolist *c;

    for (c = user->founder_chans; c; c = c->next) {
	if (c->chan == ci)
	    return 1;
    }
    return 0;
}

/*************************************************************************/

/* Return the access level the given user has on the channel.  If the
 * channel doesn't exist, the user isn't on the access list, or the channel
 * is CS_SECURE and the user hasn't IDENTIFY'd with NickServ, return 0. 
 * User does not have to be online - Coded by |SaMaN| */

static int get_access_offline(const char *user, ChannelInfo *ci)
{

    ChanAccess *access;
    NickInfo *ni;
    int i;
    ni = findnick(user);
    
    if (!ci || !ni || (ci->flags & CI_VERBOTEN) || ci->suspendinfo)
    return 0;

    for (access = ci->access, i = 0; i < ci->accesscount; access++, i++) {
        if (access->in_use && getlink(access->ni) == ni)
            return access->level;
        }
    return 0;
}						    			

/*************************************************************************/

/* Return the access level the given user has on the channel.  If the
 * channel doesn't exist, the user isn't on the access list, or the channel
 * is CS_SECURE and the user hasn't IDENTIFY'd with NickServ, return 0. */
  

int get_access(User *user, ChannelInfo *ci)
{
	NickInfo *ni = user->ni;
	ChanAccess *access;
	int i;

	if (!ci || !user->ni || (ci->flags & CI_VERBOTEN) || ci->suspendinfo)
		return 0;

	if ( (stricmp(user->nick, ServicesRoot) == 0) && nick_recognized(user) )
		return ACCLEV_GOD;

	if (nick_identified(user) || (nick_recognized(user) && !(ci->flags & CI_SECURE)))
	{
		for (access = ci->access, i = 0; i < ci->accesscount; access++, i++)
		{
			if (access->in_use && getlink(access->ni) == ni)
				return access->level;
		}
	}
	return 0;	
}

/*************************************************************************/

/* Create a new SuspendInfo structure and associate it with the given
 * channel. */

static void suspend(ChannelInfo *ci, const char *reason,
		    const char *who, const time_t expires)
{
    SuspendInfo *si;

    si = scalloc(sizeof(*si), 1);
    strscpy(si->who, who, NICKMAX);
    si->reason = sstrdup(reason);
    si->suspended = time(NULL);
    si->expires = expires;
    ci->suspendinfo = si;

    db_suspend(ci);

}

/*************************************************************************/

/* Delete the suspension data for the given channel.  We also alter the
 * last_seen value to ensure that it does not expire within the next
 * CSSuspendGrace seconds, giving its users a chance to reclaim it
 * (but only if set_time is non-zero).
 */

static void unsuspend(ChannelInfo *ci, int set_time)
{
    char *av[3];
    time_t now = time(NULL);

    if (!ci->suspendinfo) {
	log("%s: unsuspend() called on non-suspended channel %s",
	    s_ChanServ, ci->name);
	return;
    }
    if (ci->suspendinfo->reason)
	free(ci->suspendinfo->reason);
    free(ci->suspendinfo);
    ci->suspendinfo = NULL;
    if (set_time && CSExpire && CSSuspendGrace
     && (now - ci->last_used >= CSExpire - CSSuspendGrace)
    ) {
	ci->last_used = now - CSExpire + CSSuspendGrace;
        db_update_lastused(ci);
	log("%s: unsuspend: Altering last_used time for %s to %ld.",
	    s_ChanServ, ci->name, ci->last_used);
    }

    av[0] = ci->name;
    av[1] = "-b";
    av[2] = "*!*@*";

/*
    send_cmode(MODE_SENDER(s_ChanServ), av[0], av[1] , av[2]);
    do_cmode(s_ChanServ, 3, av);
*/

    db_unsuspend(ci);

}

/*************************************************************************/

/* Register a bad password attempt for a channel. */

static void chan_bad_password(User *u, ChannelInfo *ci)
{
    bad_password(s_ChanServ, u, ci->name);
    ci->bad_passwords++;
    if (BadPassWarning && ci->bad_passwords == BadPassWarning) {
	wallops(s_ChanServ, "\2Warning:\2 Repeated bad password attempts"
	                    " for channel %s", ci->name);
    }
    if (BadPassSuspend && ci->bad_passwords == BadPassSuspend) {
	time_t expire = 0;
	if (CSSuspendExpire)
	    expire = time(NULL) + CSSuspendExpire;
	suspend(ci, "Too many bad passwords (automatic suspend)",
		s_ChanServ, expire);
	log("%s: Automatic suspend for %s (too many bad passwords)",
	    s_ChanServ, ci->name);
	/* Clear bad password count for when channel is unsuspended */
	ci->bad_passwords = 0;
    }
}

/*************************************************************************/

/* Return the ChanOpt structure for the given option name.  If not found,
 * return NULL.
 */

static ChanOpt *chanopt_from_name(const char *optname)
{
    int i;
    for (i = 0; chanopts[i].name; i++) {
	if (stricmp(chanopts[i].name, optname) == 0)
	    return &chanopts[i];
    }
    return NULL;
}

/*************************************************************************/
/*********************** ChanServ command routines ***********************/
/*************************************************************************/

static void k9_help(User *u)
{
	char *chan = strtok(NULL, " ");
	FILE *HelpFile;
	char HelpFilePath[LINEBUFFSIZE];
	char buffer[LINEBUFFSIZE + 1];
	char bchar[] = ".;|%/\?*!$^&{}()[]";
	int b;
	int c;
	char *cmd = NULL;

	if(chan)
	{
		if (*chan != '#')
		{
			b = strspn(chan, bchar);
			if(b != 0)
       		{
				notice(s_ChanServ,u->nick,"Attempted Security compromise detected!");
				kill_user(s_ChanServ, u->nick, "Attempted security compromise detected");
				return; 
			}
			else 
			{
				snprintf(HelpFilePath, LINEBUFFSIZE, "%s/help/%s.txt", SERVICES_DIR, chan);
				HelpFile = fopen(HelpFilePath, "r");
			}
		}
		else if (*chan == '#')
		{
			cmd = strtok(NULL, " ");

			if(!cmd)
			{
				snprintf(HelpFilePath, LINEBUFFSIZE, "%s/help/help.txt", SERVICES_DIR);
				HelpFile = fopen(HelpFilePath, "r");
			} 
			else 
			{  
				b = strspn(cmd, bchar);

				if(b != 0)
				{
					notice(s_ChanServ,u->nick,"Attempted Security compromise detected!");
					kill_user(s_ChanServ, u->nick, "Attempted security compromise detected");
					return;
				}
				else
				{
					snprintf(HelpFilePath, LINEBUFFSIZE, "%s/help/%s.txt", SERVICES_DIR, cmd);
					HelpFile = fopen(HelpFilePath, "r");
				}
			}
		} 
		else 
		{
			snprintf(HelpFilePath, LINEBUFFSIZE, "%s/help/help.txt", SERVICES_DIR);
			HelpFile = fopen(HelpFilePath, "r");
		}
	} 
	else
	{
		snprintf(HelpFilePath, LINEBUFFSIZE, "%s/help/help.txt", SERVICES_DIR);
		HelpFile = fopen(HelpFilePath, "r");
	}	  

	if (HelpFile)
	{
		while ((c = (fgets(buffer, LINEBUFFSIZE, HelpFile) != NULL)))
		{
			buffer[strlen(buffer) - 1] = '\0';
			notice(s_ChanServ, u->nick, buffer);
		}
			fclose(HelpFile);
		} 
	else 
	{
		notice(s_ChanServ, u->nick, "Sorry, I have no information on that.");
	}
}


static void k9_addchan(User *u)
{
	char *chan = strtok(NULL, " ");
	char *nick = strtok(NULL, " ");
	char *pass = strtok(NULL, " ");
	char *desc = strtok(NULL, "");
	NickInfo *ni; 
	User *target_user = NULL;
	Channel *c;
	ChannelInfo *ci;
	struct u_chaninfolist *uc;
#ifdef USE_ENCRYPTION
	char founderpass[PASSMAX+1];
#endif

	if (readonly)
	{
		notice_lang(s_ChanServ, u, CHAN_REGISTER_DISABLED);
		return;
	}

	if (nick)
		target_user = finduser(nick);

	if ( !target_user || !chan || !nick || !pass || !desc )
	{
		syntax_error(s_ChanServ, u, "ADDCHAN", CHAN_ADDCHAN_SYNTAX);
		return;
	}
	if ( *chan == '&' )
	{
		notice_lang(s_ChanServ, u, CHAN_REGISTER_NOT_LOCAL);
		return;
	}
	if ( !valid_channel(chan, 1) )
	{
		notice_lang(s_ChanServ, u, ACCESS_DENIED);
		return;
	}
	if ( !(ni = findnick(nick)) )
	{
		notice_lang(s_ChanServ, u, CHAN_MUST_REGISTER_NICK, s_NickServ);
		return;
	}
	if ( !nick_recognized(u) )
	{
		notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK, s_NickServ, s_NickServ);
		return;
	}
	if ( (ci = cs_findchan(chan)) != NULL )
	{
		if ( ci->flags & CI_VERBOTEN )
		{
			log("%s: Attempt to register FORBIDden channel %s by %s!%s@%s",
				s_ChanServ, ci->name, u->nick, u->username, u->host);
			notice_lang(s_ChanServ, u, CHAN_ALREADY_REGISTERED, chan);
		} else {
			notice_lang(s_ChanServ, u, CHAN_ALREADY_REGISTERED, chan);
		}
		return;
	}
	if ( (check_channel_limit(ni) >= 0) && !is_cservice_member(target_user) )
	{
		int max = ni->channelmax ? ni->channelmax : MAX_CHANNELCOUNT;
		notice_lang(s_ChanServ, u,
			ni->channelcount > max 
				? CHAN_EXCEEDED_CHANNEL_LIMIT
				: CHAN_REACHED_CHANNEL_LIMIT, 
			max);
		return;
	}
	if ( !(c = findchan(chan)) )
	{
		log("%s: Channel %s not found for REGISTER", s_ChanServ, chan);
		notice_lang(s_ChanServ, u, CHAN_REGISTRATION_FAILED);
		return;
	}
	if ( !(ci = makechan(chan)) )
	{
		log("%s: makechan() failed for REGISTER %s", s_ChanServ, chan);
		notice_lang(s_ChanServ, u, CHAN_REGISTRATION_FAILED);
		return;
	}
#ifdef USE_ENCRYPTION
	if (strscpy(founderpass, pass, PASSMAX+1),
		encrypt_in_place(founderpass, PASSMAX) < 0)
	{
		log("%s: Couldn't encrypt password for %s (REGISTER)",
			s_ChanServ, chan);
		notice_lang(s_ChanServ, u, CHAN_REGISTRATION_FAILED);
		delchan(ci);
		return;
	}
#endif

	c->ci = ci;
	ci->c = c;
	ci->flags = CI_KEEPTOPIC | CI_SECURE | CI_INCHANNEL;
	ci->mlock_on = CMODE_n | CMODE_t;
	ci->last_used = ci->time_registered;
	ci->founder = ni;
#ifdef USE_ENCRYPTION
	if (strlen(pass) > PASSMAX)
		notice_lang(s_ChanServ, u, PASSWORD_TRUNCATED, PASSMAX);
	memset(pass, 0, strlen(pass));
	memcpy(ci->founderpass, founderpass, PASSMAX);
	ci->flags |= CI_ENCRYPTEDPW;
#else
	if (strlen(pass) > PASSMAX-1) /* -1 for null byte */
		notice_lang(s_ChanServ, u, PASSWORD_TRUNCATED, PASSMAX-1);
	strscpy(ci->founderpass, pass, PASSMAX);
#endif
	ci->desc = sstrdup(desc);
	if (c->topic)
	{
		ci->last_topic = sstrdup(c->topic);
		strscpy(ci->last_topic_setter, c->topic_setter, NICKMAX);
		ci->last_topic_time = c->topic_time;
	}
	count_chan(ci);

	log("%s: Channel %s registered by %s!%s@%s", s_ChanServ, chan,
		u->nick, u->username, u->host);

	uc = smalloc(sizeof(*uc));
	uc->next = u->founder_chans;
	uc->prev = NULL;
	if (u->founder_chans)
		u->founder_chans->prev = uc;
	u->founder_chans = uc;
	uc->chan = ci;
	/* Implement new mode lock */

        cs_join(chan);
	send_cmd(s_ChanServ, "MODE %s +%s %s", chan, "o",s_ChanServ);
	check_modes(ci->name);
	owner_add(ci->name, ni->nick);

        /* note: this should be fixed up with notice_lang()? */
        if(db_add_channel(ci) == -1)
          send_cmd(s_ChanServ, "NOTICE %s :database error while adding channel "
                   "%s. The channel will still be created but will not load "
                   "after a restart. The channel must be deleted and added "
                   "again. Inform the maintainer if you get this notice.",
                   u->nick, chan);

	notice_lang(s_ChanServ, u, CHAN_REGISTERED, chan, ni->nick);
#ifndef USE_ENCRYPTION
	notice_lang(s_ChanServ, u, CHAN_PASSWORD_IS, ci->founderpass);
#endif

}

/*************************************************************************/

static void k9_register(User *u)
{
	char *chan = strtok(NULL, " ");
	char *pass = strtok(NULL, " ");
	char *desc = strtok(NULL, "");
	NickInfo *ni = u->ni;
	Channel *c;
	ChannelInfo *ci;
	struct u_chaninfolist *uc;
#ifdef USE_ENCRYPTION
	char founderpass[PASSMAX+1];
#endif

	if (readonly)
	{
		notice_lang(s_ChanServ, u, CHAN_REGISTER_DISABLED);
		return;
	}

	if (!desc)
	{
		syntax_error(s_ChanServ, u, "REGISTER", CHAN_REGISTER_SYNTAX);
		return;
	}
	if (*chan == '&')
	{
		notice_lang(s_ChanServ, u, CHAN_REGISTER_NOT_LOCAL);
		return;
	}
	if (!ni)
	{
		notice_lang(s_ChanServ, u, CHAN_MUST_REGISTER_NICK, s_NickServ);
		return;
	}
	if (!nick_recognized(u))
	{
		notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK, s_NickServ, s_NickServ);
		return;
	}
	if ((ci = cs_findchan(chan)) != NULL)
	{
		if (ci->flags & CI_VERBOTEN)
		{
			log("%s: Attempt to register FORBIDden channel %s by %s!%s@%s",
				s_ChanServ, ci->name, u->nick, u->username, u->host);
			notice_lang(s_ChanServ, u, CHAN_MAY_NOT_BE_REGISTERED, chan);
		}
		if (ci->suspendinfo)
		{
			log("%s: Attempt to register SUSPENDed channel %s by %s!%s@%s",
				s_ChanServ, ci->name, u->nick, u->username, u->host);
			notice_lang(s_ChanServ, u, CHAN_ALREADY_REGISTERED, chan);
		} else {
			notice_lang(s_ChanServ, u, CHAN_ALREADY_REGISTERED, chan);
		}
		return;
	}
	if (!is_chanop(u->nick, chan))
	{
		notice_lang(s_ChanServ, u, CHAN_MUST_BE_CHANOP);
		return;
	}
	if ( check_channel_limit(ni) >= 0 )
	{
		int max = ni->channelmax ? ni->channelmax : MAX_CHANNELCOUNT;
		notice_lang(s_ChanServ, u,
			ni->channelcount > max
				? CHAN_EXCEEDED_CHANNEL_LIMIT
				: CHAN_REACHED_CHANNEL_LIMIT,
			max);
		return;
	}
	if (!(c = findchan(chan)))
	{
		log("%s: Channel %s not found for REGISTER", s_ChanServ, chan);
		notice_lang(s_ChanServ, u, CHAN_REGISTRATION_FAILED);
		return;
	}
	if (!(ci = makechan(chan)))
	{
		log("%s: makechan() failed for REGISTER %s", s_ChanServ, chan);
		notice_lang(s_ChanServ, u, CHAN_REGISTRATION_FAILED);
		return;
	}
	
	if ( !(check_cservice(u)) && (stricmp(ServicesRoot,u->nick) == 0))
	{
		log("%s: findchan failed after makechan() for REGISTER %s", s_ChanServ, chan);
		notice_lang(s_ChanServ, u, CHAN_REGISTRATION_FAILED);
		return;
	}
#ifdef USE_ENCRYPTION
	if (strscpy(founderpass, pass, PASSMAX+1),
               encrypt_in_place(founderpass, PASSMAX) < 0)
	{
		log("%s: Couldn't encrypt password for %s (REGISTER)", s_ChanServ, chan);
		notice_lang(s_ChanServ, u, CHAN_REGISTRATION_FAILED);
		delchan(ci);
	}
#endif

	if ( ( (stricmp(u->nick, ServicesRoot) == 0) && nick_recognized(u) )
	     || ( check_cservice(u) >= ACCLEV_IMMORTAL )
	   )
	{
		if(strcasecmp(chan,CSChan) == 0)
		{
			c->ci = ci;
			ci->c = c;
			ci->flags = CI_KEEPTOPIC | CI_SECURE | CI_INCHANNEL;
			ci->mlock_on = CMODE_n | CMODE_t;
			ci->last_used = ci->time_registered;
			ci->founder = u->real_ni;
#ifdef USE_ENCRYPTION
			if (strlen(pass) > PASSMAX)
				notice_lang(s_ChanServ, u, PASSWORD_TRUNCATED, PASSMAX);
			memset(pass, 0, strlen(pass));
			memcpy(ci->founderpass, founderpass, PASSMAX);
			ci->flags |= CI_ENCRYPTEDPW;
#else
			if (strlen(pass) > PASSMAX-1) /* -1 for null byte */
				notice_lang(s_ChanServ, u, PASSWORD_TRUNCATED, PASSMAX-1);
			strscpy(ci->founderpass, pass, PASSMAX);
#endif
			ci->desc = sstrdup(desc);
			if (c->topic)
			{
				ci->last_topic = sstrdup(c->topic);
				strscpy(ci->last_topic_setter, c->topic_setter, NICKMAX);
				ci->last_topic_time = c->topic_time;
			}
			count_chan(ci);
			log("%s: Cservice Channel %s registered by %s!%s@%s", s_ChanServ, chan,
				u->nick, u->username, u->host);
			uc = smalloc(sizeof(*uc));
			uc->next = u->founder_chans;
			uc->prev = NULL;
			if (u->founder_chans)
				u->founder_chans->prev = uc;
			u->founder_chans = uc;
			uc->chan = ci;
			/* Implement new mode lock */

                        cs_join(chan);
			send_cmd(s_ChanServ, "MODE %s +%s %s", chan, "o",s_ChanServ);
			check_modes(ci->name);
			emperor_add(ci->name, u->nick);
                        db_add_channel(ci);
			notice_lang(s_ChanServ, u, CHAN_REGISTERED, chan, u->nick);
#ifndef USE_ENCRYPTION
			notice_lang(s_ChanServ, u, CHAN_PASSWORD_IS, ci->founderpass);
#endif
			return;
		}
		if (strcasecmp(chan,AOChan) == 0)
		{
			c->ci = ci;
			ci->c = c;
			ci->flags = CI_KEEPTOPIC | CI_SECURE;
			ci->mlock_on = CMODE_n | CMODE_t;
			ci->last_used = ci->time_registered;
			ci->founder = u->real_ni;
#ifdef USE_ENCRYPTION
			if (strlen(pass) > PASSMAX)
				notice_lang(s_ChanServ, u, PASSWORD_TRUNCATED, PASSMAX);
			memset(pass, 0, strlen(pass));
			memcpy(ci->founderpass, founderpass, PASSMAX);
			ci->flags |= CI_ENCRYPTEDPW;
#else
			if (strlen(pass) > PASSMAX-1) /* -1 for null byte */
				notice_lang(s_ChanServ, u, PASSWORD_TRUNCATED, PASSMAX-1);
			strscpy(ci->founderpass, pass, PASSMAX);
#endif	
			ci->desc = sstrdup(desc);
			if (c->topic)
			{
				ci->last_topic = sstrdup(c->topic);
				strscpy(ci->last_topic_setter, c->topic_setter, NICKMAX);
				ci->last_topic_time = c->topic_time;
			}
			count_chan(ci);
                        db_add_channel(ci);
			log("%s: Cservice Channel %s registered by %s!%s@%s", s_ChanServ, chan,
				u->nick, u->username, u->host);
			uc = smalloc(sizeof(*uc));
			uc->next = u->founder_chans;
			uc->prev = NULL;
			if (u->founder_chans)
			u->founder_chans->prev = uc;
			u->founder_chans = uc;
			uc->chan = ci;
			/* Implement new mode lock */

                        cs_join(chan);
			send_cmd(s_ChanServ, "MODE %s +%s %s", chan, "o",s_ChanServ);
			check_modes(ci->name);
			emperor_add(ci->name, u->nick);
			notice_lang(s_ChanServ, u, CHAN_REGISTERED, chan, u->nick);
#ifndef USE_ENCRYPTION
			notice_lang(s_ChanServ, u, CHAN_PASSWORD_IS, ci->founderpass);
#endif
			return;
		}
	
		c->ci = ci;
		ci->c = c;
		ci->flags = CI_KEEPTOPIC | CI_SECURE;
		ci->mlock_on = CMODE_n | CMODE_t;
		ci->last_used = ci->time_registered;
		ci->founder = u->real_ni;
#ifdef USE_ENCRYPTION
		if (strlen(pass) > PASSMAX)
		    notice_lang(s_ChanServ, u, PASSWORD_TRUNCATED, PASSMAX);
		memset(pass, 0, strlen(pass));
		memcpy(ci->founderpass, founderpass, PASSMAX);
		ci->flags |= CI_ENCRYPTEDPW;
#else
		if (strlen(pass) > PASSMAX-1) /* -1 for null byte */
		    notice_lang(s_ChanServ, u, PASSWORD_TRUNCATED, PASSMAX-1);
		strscpy(ci->founderpass, pass, PASSMAX);
#endif
		ci->desc = sstrdup(desc);
		if (c->topic)
		{
			ci->last_topic = sstrdup(c->topic);
			strscpy(ci->last_topic_setter, c->topic_setter, NICKMAX);
			ci->last_topic_time = c->topic_time;
		}
		count_chan(ci);
                db_add_channel(ci);
		log("%s: Channel %s registered by %s!%s@%s", s_ChanServ, chan,
			u->nick, u->username, u->host);
		uc = smalloc(sizeof(*uc));
		uc->next = u->founder_chans;
		uc->prev = NULL;
		if (u->founder_chans)
			u->founder_chans->prev = uc;
		u->founder_chans = uc;
		uc->chan = ci;
		/* Implement new mode lock */
 
                cs_join(chan);
		send_cmd(s_ChanServ, "MODE %s +%s %s", chan, "o",s_ChanServ);
		check_modes(ci->name);
		owner_add(ci->name, u->nick);
		notice_lang(s_ChanServ, u, CHAN_REGISTERED, chan, u->nick);
#ifndef USE_ENCRYPTION
		notice_lang(s_ChanServ, u, CHAN_PASSWORD_IS, ci->founderpass);
#endif
	}
        notice_lang(s_ChanServ, u, CHAN_REGISTER_DISABLED);
}

/*************************************************************************/

static void k9_auth(User *u)
{
	char *chan = strtok(NULL, " ");
	char *pass = strtok(NULL, " ");
	ChannelInfo *ci;
	struct u_chaninfolist *uc;
	int res;
    
	if (!chan || !pass)
	{
		syntax_error(s_ChanServ, u, "AUTH", CHAN_AUTH_SYNTAX);
		return;
	}
	if ( !(ci = cs_findchan(chan)) )
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}
	if (ci->suspendinfo)
	{
		notice_lang(s_ChanServ, u, CHAN_X_SUSPENDED, chan);
		return;
	}

	if ( !( is_cservice_member || ((get_access(u,ci) >= ACCLEV_FOUNDER) && nick_identified(u))) )
	{
		notice_lang(s_ChanServ, u, CHAN_IDENTIFY_FAILED);
		return;
	}
   
	res = check_password(pass, ci->founderpass);
	if (res == 1)
	{
		ci->bad_passwords = 0;
		ci->last_used = time(NULL);
                db_update_lastused(ci);
		if ( !is_identified(u, ci) )
		{
			uc = smalloc(sizeof(*uc));
			uc->next = u->founder_chans;
			uc->prev = NULL;
			if (u->founder_chans)
				u->founder_chans->prev = uc;
			u->founder_chans = uc;
			uc->chan = ci;
			log("%s: %s!%s@%s identified for %s", s_ChanServ,
				u->nick, u->username, u->host, ci->name);
		}
		notice_lang(s_ChanServ, u, CHAN_IDENTIFY_SUCCEEDED, chan);
		return;
	}
	else if (res < 0)
	{
		log("%s: check_password failed for %s", s_ChanServ, ci->name);
		notice_lang(s_ChanServ, u, CHAN_IDENTIFY_FAILED);
		return;
	}
	else
	{
		log("%s: Failed IDENTIFY for %s by %s!%s@%s",
			s_ChanServ, ci->name, u->nick, u->username, u->host);
		chan_bad_password(u, ci);
		notice_lang(s_ChanServ, u, CHAN_IDENTIFY_FAILED);
		return;
	}
}

/*************************************************************************/

/* Main SET routine.  Calls other routines as follows:
 *	do_set_command(User *command_sender, ChannelInfo *ci, char *param);
 * The parameter passed is the first space-delimited parameter after the
 * option name, except in the case of DESC, TOPIC, and ENTRYMSG, in which
 * it is the entire remainder of the line.  Additional parameters beyond
 * the first passed in the function call can be retrieved using
 * strtok(NULL, toks).
 *
 * do_set_boolean, the default handler, is an exception to this in that it
 * also takes the ChanOpt structure for the selected option as a parameter.
 */

static void k9_guardm(User *u)
{
	char *chan = strtok(NULL, " ");
	char *param = strtok(NULL, " ");
	char *s;
	ChannelInfo *ci;
	char buf[BUFSIZE], *end;
	int modelen;

	if (readonly)
	{
		notice_lang(s_ChanServ, u, CHAN_SET_DISABLED);
		return;
	}

	if (!chan)
	{
		syntax_error(s_ChanServ, u, "GUARDM", CHAN_GUARDM_SYNTAX);
		return;
	}
	if ( !(ci = cs_findchan(chan)) )
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}
	
	/* If nothing specified, show what we have.. */
	if (!param)
	{
		end = buf;	
		*end = 0;
		if (ci->mlock_on || ci->mlock_key || ci->mlock_limit)
			end += snprintf(end, sizeof(buf)-(end-buf), "+%s%s%s",
		mode_flags_to_string(ci->mlock_on, MODE_CHANNEL),
			(ci->mlock_key  ) 
				? "k" 
				: "",
			(ci->mlock_limit) 
				? "l" :
				 ""
			);

		if (ci->mlock_off)
			end += snprintf(end, sizeof(buf)-(end-buf), "-%s",
				mode_flags_to_string(ci->mlock_off, MODE_CHANNEL));
		if (*buf)
		{
			notice_lang(s_ChanServ, u, CHAN_INFO_MODE_LOCK, buf);		    
		}
		else
		{
			notice(s_ChanServ,u->nick,"No mode guards set master");
		}
		return;
	}

        /* Get a list of valid modes */
        s = mode_flags_to_string(MODE_ALL, MODE_CHANNEL);
	modelen =  strcspn(param, s) -  strspn("+", param) - strspn("-", param);
	printf("modelen is %d\n", modelen);
	
		if (modelen > 0)
		{
			syntax_error(s_ChanServ, u, "GUARDM", CHAN_GUARDM_SYNTAX);
        		return;
		} 

	if (check_cservice(u) >= ACCLEV_IMMORTAL)
	{
		do_set_mlock(u, ci, param);
		return;
	}
	if (!u || (get_access(u,ci) == 0))
	{
		notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
		return;
	}
	if (get_access(u,ci) < 450)
	{
		notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
		return;
	}
	do_set_mlock(u, ci, param);
}

/*************************************************************************/

static void k9_autoop(User *u)
{
	char *chan = strtok(NULL, " ");
	char *param = strtok(NULL, " ");
	ChannelInfo *ci;
	NickInfo *ni = NULL;

	ni = findnick(u->nick);

	if (readonly)
	{
		notice_lang(s_ChanServ, u, CHAN_SET_DISABLED);
		return;
	}

	if (!ni || !chan || !param)
	{
		syntax_error(s_ChanServ, u, "AUTOOP", CHAN_AUTOOP_SYNTAX);
		return;
	}
	if (!(ci = cs_findchan(chan)))
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}

	if (!(stricmp(param, "t")))
	{
		param = "t";    
		record_autoop(ci, ni, param);
		notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
		return;
	}
	if (!(stricmp(param,"v")))
	{
		param = "v";
		record_autoop(ci, ni, param);
		notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
		return;
	}

		remove_autoop(ci, ni);
		notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
		return;
}

/*************************************************************************/

static void k9_guardt(User *u)
{
	char *chan = strtok(NULL, " ");
	char *param = strtok(NULL, " ");
	ChannelInfo *ci;
	ChanOpt *ca;  

	if (readonly)
	{
		notice_lang(s_ChanServ, u, CHAN_SET_DISABLED);
		return;
	}

	ca = chanopt_from_name("TOPICLOCK");
	if(!ca) return;

	if (!chan || !param)
	{
		syntax_error(s_ChanServ, u, "GUARDT", CHAN_GUARDT_SYNTAX);
		return;
	}
	if ( !(ci = cs_findchan(chan)) )
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}

	if (!u || (check_cservice(u) < ACCLEV_IMMORTAL && (get_access(u,ci) == 0)) )
	{
		notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
		return;
	}

	if (!(stricmp(param, "t")))
	{
		param = "ON";
		do_set_boolean(u, ci, ca, param);
		notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
		return;
	}
	if (!(stricmp(param,"f")))
	{
		param = "OFF";
		do_set_boolean(u,ci,ca,param);
		notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
		return;
	}
}

/*************************************************************************/

/*
static void do_set_founder(User *u, ChannelInfo *ci, char *param)
{
	NickInfo *ni = NULL;

	if (!param)
	{
		syntax_error(s_ChanServ, u, "FOUNDER", CHAN_HELP_SET_FOUNDER);
		return;
	}

	if ( !(ni = findnick(param)) )
	{
		notice_lang(s_ChanServ, u, NICK_X_NOT_REGISTERED, param);
		return;
	}
	if (ni->status & NS_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, NICK_X_FORBIDDEN, param);
		return;
	}
	if ( (ni->channelcount >= ni->channelmax && !is_services_admin(u)) || 
	     ni->channelcount >= MAX_CHANNELCOUNT
	   )
	{
		notice_lang(s_ChanServ, u, CHAN_SET_FOUNDER_TOO_MANY_CHANS, param);
		return;
	}

	uncount_chan(ci);
	ci->founder = ni;
	count_chan(ci);
	if (ci->successor == ci->founder) {
		ci->successor = NULL;
                db_chan_set(ci, "successornick", NULL);
        }
        db_chan_set(ci, "foundernick", ci->founder->nick);
	log("%s: Changing founder of %s to %s by %s!%s@%s", s_ChanServ,
		ci->name, param, u->nick, u->username, u->host);
	notice_lang(s_ChanServ, u, CHAN_FOUNDER_CHANGED, ci->name, param);
}

*/

static void k9_setpass(User *u)
{
	char *chan = strtok(NULL, " ");
	char *param = strtok(NULL, " ");
        int len, len2;
	ChannelInfo *ci;

	if (!param)
	{
		syntax_error(s_ChanServ, u, "SETPASS", CHAN_SETPASS_SYNTAX);
		return;
	}
	if ( !(ci = cs_findchan(chan)) )
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}
	if (ci->suspendinfo)
	{
		notice_lang(s_ChanServ, u, CHAN_X_SUSPENDED, chan);
		return;
	}
	if ( !(is_founder(u,ci)) && !(is_cservice_member(u)) )
	{
		notice_lang(s_ChanServ, u, CHAN_IDENTIFY_REQUIRED, s_ChanServ, chan);
		return;
	}
	if (!(is_identified(u,ci)))
	{
		notice_lang(s_ChanServ, u, CHAN_IDENTIFY_REQUIRED, s_ChanServ, chan);	
		return;
	}
#ifdef USE_ENCRYPTION
        len = len2 = strlen(param);
	if (len2 > PASSMAX)
	{
		len2 = PASSMAX;
		param[len2] = 0;
		notice_lang(s_ChanServ, u, PASSWORD_TRUNCATED, PASSMAX);
	}
	if (encrypt(param, len2, ci->founderpass, PASSMAX) < 0)
	{
		memset(param, 0, len);
		log("%s: Failed to encrypt password for %s (set)", s_ChanServ, ci->name);
		notice_lang(s_ChanServ, u, CHAN_SET_PASSWORD_FAILED);
		return;
	}
	memset(param, 0, len);
	notice_lang(s_ChanServ, u, CHAN_PASSWORD_CHANGED, ci->name);
#else
	if (strlen(param) > PASSMAX-1) 
		notice_lang(s_ChanServ, u, PASSWORD_TRUNCATED, PASSMAX-1);
	strscpy(ci->founderpass, param, PASSMAX);
	notice_lang(s_ChanServ, u, CHAN_PASSWORD_CHANGED_TO, ci->name, ci->founderpass);
#endif

        db_setpass(ci);

	if (get_access(u, ci) >= ACCLEV_IMMORTAL)
	{
		log("%s: %s!%s@%s set password as Cservice Member for %s",
			s_ChanServ, u->nick, u->username, u->host, ci->name);
		if (WallSetpass)
			wallops(s_ChanServ, "\2%s\2 set password as Cservice Member for "
				"channel \2%s\2", u->nick, ci->name);
	}
}

/*
static void do_set_desc(User *u, ChannelInfo *ci, char *param)
{
	if (ci->desc)
		free(ci->desc);
	ci->desc = sstrdup(param);
        db_chan_set(ci, "chandesc", ci->desc);
	notice_lang(s_ChanServ, u, CHAN_DESC_CHANGED, ci->name, param);
}

*/

static void k9_founder(User *u)
{
	char *chan = strtok(NULL, " ");
	char *param = strtok(NULL, "");
	ChannelInfo *ci;
	NickInfo *ni = NULL;
	int i = 500;

	if ((!param)||(!chan))
	{	
		syntax_error(s_ChanServ, u, "FOUNDER", CHAN_FOUNDER_SYNTAX); 
		return;
	}

	if ( !(ni = findnick(param)) )
	{
		notice_lang(s_ChanServ, u, NICK_X_NOT_REGISTERED, param);
		return;
	}
	if ( !(ci = cs_findchan(chan)) )
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}
	if ( !u )
	{
		notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
		return;
	}
	if (ni->status & NS_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, NICK_X_FORBIDDEN, param);
		return;
	}
	if ((ni->channelcount >= ni->channelmax && !is_cservice_member(u)) ||
	    ni->channelcount >= MAX_CHANNELCOUNT
	   )
	{
		notice_lang(s_ChanServ, u, CHAN_SET_FOUNDER_TOO_MANY_CHANS, param);
		return;
	}

	uncount_chan(ci);
	ci->founder = ni;
	access_add(ci, param, i, get_access(u,ci));
	count_chan(ci);
	if (ci->successor == ci->founder) {
		ci->successor = NULL;
                db_chan_set(ci, "successornick", NULL);
        }

        db_founder(ci);

	log("%s: Changing founder of %s to %s by %s!%s@%s", s_ChanServ,
		ci->name, param, u->nick, u->username, u->host);
	notice_lang(s_ChanServ, u, CHAN_FOUNDER_CHANGED, ci->name, param);
}

static void k9_successor(User *u)
{
	char *chan = strtok(NULL, " ");
	char *param = strtok(NULL, "");
	ChannelInfo *ci;
	NickInfo *ni;
//	int slevel = 0;
//	int cslevel = 0;

	if (!chan)
	{
		syntax_error(s_ChanServ, u, "GUARDM", CHAN_GUARDM_SYNTAX);
		return;
	}
	if ( !(ci = cs_findchan(chan)) )
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}

//	slevel = get_access(u,ci);
//	cslevel = check_cservice(u);
//	if ( (cslevel < ACCLEV_IMMORTAL) && (slevel < ACCLEV_FOUNDER ) )

	if (!(is_cservice_member(u) || is_founder(u,ci)) )
	{
		notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
		return;
	}	
	if (param)
	{
		ni = findnick(param);
		if (!ni)
		{
			notice_lang(s_ChanServ, u, NICK_X_NOT_REGISTERED, param);
			return;
		}
		if (ni->status & NS_VERBOTEN)
		{
			notice_lang(s_ChanServ, u, NICK_X_FORBIDDEN, param);
			return;
		}
		if (ni == ci->founder)
		{
			notice_lang(s_ChanServ, u, CHAN_SUCCESSOR_IS_FOUNDER);
			return;
		}
	} else {
		ni = NULL;
	}

	/* We only log this if it was requested by CService
	 * and the user was not the owner of the channel
	*/
	if ( is_cservice_member(u) && !is_founder(u,ci) )
		log("%s: Changing successor of %s to %s by %s!%s@%s", s_ChanServ,
			ci->name, (param) ? param : "NONE", u->nick, u->username, u->host);

	ci->successor = ni;

        db_successor(ci);

	if (ni)
		notice_lang(s_ChanServ, u, CHAN_SUCCESSOR_CHANGED, ci->name, param);
	else
		notice_lang(s_ChanServ, u, CHAN_SUCCESSOR_UNSET, ci->name);
}


static void k9_email(User *u)
{
	char *chan = strtok(NULL, " ");
	char *param = strtok(NULL, "");
	ChannelInfo *ci;

	if (readonly)
	{
		notice_lang(s_ChanServ, u, CHAN_SET_DISABLED);
		return;
	}

	if (!chan)
	{
		syntax_error(s_ChanServ, u, "GUARDM", CHAN_GUARDM_SYNTAX);
		return;
	}
	if ( !(ci = cs_findchan(chan)) )
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}

	if (ci->email)
		free(ci->email);
	if (param)
	{
		if ( !valid_email(param) )
		{
			ci->email = NULL;
                        db_email(ci);
			notice_lang(s_ChanServ, u, BAD_EMAIL);
		} else {
			ci->email = sstrdup(param);
                        db_email(ci);
			notice_lang(s_ChanServ, u, CHAN_EMAIL_CHANGED, ci->name, param);
		}
		return;
	} else {
		ci->email = NULL;
                db_email(ci);
		notice_lang(s_ChanServ, u, CHAN_EMAIL_UNSET, ci->name);
		return;
	}
}

/*************************************************************************/

static void do_set_entrymsg(User *u, ChannelInfo *ci, char *param)
{
	int i;
	char **greet;

	if (!param)
	{
		for (i=0; i < ci->entrycount; i++)
		{
			if (ci->entrymsg[i])
				free(ci->entrymsg[i]);
		}
		ci->entrycount = 0;
                db_onjoin(ci, param);
		notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
		return;
	}

	if (ci->entrycount < MAXONJOIN)
	{
		char *p;
			
		ci->entrycount++;
		greet = srealloc(ci->entrymsg, sizeof(char *) * ci->entrycount);
		i = ci->entrycount - 1;
		greet[i] = sstrdup(param);
		p = greet[i];
		p[ONJOINMAX] = 0;
		ci->entrymsg = greet;
                db_onjoin(ci, param);
		notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
		return;
	} else {
		 notice_lang(s_ChanServ, u, CHAN_ONJOIN_FULL, MAXONJOIN);
		 return;
	}
}

/*************************************************************************/

static void do_set_topic(User *u, ChannelInfo *ci, char *param)
{
	Channel *c = ci->c;
	time_t now = time(NULL);
	NickInfo *ni = u->ni;

	if (!c)
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, ci->name);
		return;
	}
	set_topic(c, param, ni->nick, now);
	notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
	record_topic(c);
}

/*************************************************************************/

static void do_set_mlock(User *u, ChannelInfo *ci, char *param)
{
	char *s, modebuf[32], *end, c;
	int add = -1;	
	int32 newlock_on = 0, newlock_off = 0, newlock_limit = 0;
	char *newlock_key = NULL;

	while (*param)
	{
		if (*param != '+' && *param != '-' && add < 0)
		{
			param++;
			continue;
		}
		switch ((c = *param++))
		{
		case '+':
			add = 1;
			break;
		case '-':
			add = 0;
			break;
		case 'k':
			if (add)
			{
				if (!(s = strtok(NULL, " ")))
				{
					notice_lang(s_ChanServ, u, CHAN_SET_MLOCK_KEY_REQUIRED);
					return;
				}
				if (newlock_key)
					free(newlock_key);
				newlock_key = sstrdup(s);
				newlock_off &= ~CMODE_k;
			} else {
				if (newlock_key)
				{
					free(newlock_key);
					newlock_key = NULL;
				}
				newlock_off |= CMODE_k;
			}
			break;
		case 'l':
			if (add)
			{
				if (!(s = strtok(NULL, " ")))
				{
					notice_lang(s_ChanServ, u, CHAN_SET_MLOCK_LIMIT_REQUIRED);
					return;
				}
				if (atol(s) <= 0)
				{
					notice_lang(s_ChanServ, u, CHAN_SET_MLOCK_LIMIT_POSITIVE);
					return;
				}
				newlock_limit = atol(s);
				newlock_off &= ~CMODE_l;
			} else {
				newlock_limit = 0;
				newlock_off |= CMODE_l;
			}
			break;
#ifdef IRC_UNREAL
		case 'f':
			if (add)
			{
				notice_lang(s_ChanServ, u, CHAN_SET_MLOCK_MODE_F_BAD);
				break;
			}
	    
#endif
		default:
		{
			int32 flag = mode_char_to_flag(c, MODE_CHANNEL);
#ifdef IRC_UNREAL
			if ((flag & (CMODE_A | CMODE_H))
			  && !(is_cservice_member(u)
			  || (u->mode & (UMODE_A|UMODE_N|UMODE_T)))
			)
			{
				continue;
			}
#endif
			if ((flag & CMODE_OPERONLY) && !is_oper_u(u))
				continue;
			if (flag)
			{
				if (flag & CMODE_REG)
					notice_lang(s_ChanServ, u, CHAN_SET_MLOCK_MODE_REG_BAD, c);
				else if (add)
					newlock_on |= flag, newlock_off &= ~flag;
				else
					newlock_off |= flag, newlock_on &= ~flag;
			} else {
				notice_lang(s_ChanServ, u, CHAN_SET_MLOCK_UNKNOWN_CHAR, c);
			}
			break;
		} /* end default */
		} /* end select */
	} 

	ci->mlock_on = newlock_on;
	ci->mlock_off = newlock_off;
	ci->mlock_limit = newlock_limit;
	if (ci->mlock_key)
		free(ci->mlock_key);
	ci->mlock_key = newlock_key;

        db_mlock(ci);

	end = modebuf;
	*end = 0;
	if (ci->mlock_on || ci->mlock_key || ci->mlock_limit)
		end += snprintf(end, sizeof(modebuf)-(end-modebuf), "+%s%s%s",
			mode_flags_to_string(ci->mlock_on, MODE_CHANNEL),
			(ci->mlock_key  ) ? "k" : "",
			(ci->mlock_limit) ? "l" : "");
	if (ci->mlock_off)
		end += snprintf(end, sizeof(modebuf)-(end-modebuf), "-%s",
			mode_flags_to_string(ci->mlock_off, MODE_CHANNEL));
	if (*modebuf)
	{
		notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
	} else {
		notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
	}

	check_modes(ci->name);
}

/*************************************************************************/

static void do_set_boolean(User *u, ChannelInfo *ci, ChanOpt *co, char *param)
{
	if (stricmp(param, "ON") == 0)
	{
		ci->flags |= co->flag;
                db_chan_seti(ci, "flags", ci->flags);
		if (co->flag == CI_RESTRICTED && ci->levels[CA_NOJOIN] < 0)
			ci->levels[CA_NOJOIN] = 0;
	} else if (stricmp(param, "OFF") == 0) {
		ci->flags &= ~co->flag;
                db_chan_seti(ci, "flags", ci->flags);
		if (co->flag == CI_RESTRICTED && ci->levels[CA_NOJOIN] >= 0)
			ci->levels[CA_NOJOIN] = -1;
	} else {
		char buf[BUFSIZE];
		snprintf(buf, sizeof(buf), "SET %s", co->name);
		syntax_error(s_ChanServ, u, buf, co->syntaxstr);
	}
}

/*************************************************************************/

/* SADMINS, and users who have identified for a channel, can now cause its
 * entry message and successor to be displayed by supplying the ALL
 * parameter.
 * Syntax: INFO channel [ALL]
 * -TheShadow (29 Mar 1999)
 */

/* Check the status of show_all and make a note of having done so.  See
 * comments at nickserv.c/do_info() for details. */

#define CHECK_SHOW_ALL (used_all++, show_all)

static void k9_info(User *u)
{
	char *chan = strtok(NULL, " ");
	ChannelInfo *ci;
	NickInfo *ni;
	char buf[BUFSIZE], *end, *s;
	struct tm *tm;
	int i;
	int is_servadmin = is_cservice_member(u);
	int can_show_all = 0, show_all = 0, used_all = 0;

	if (!chan)
	{
		syntax_error(s_ChanServ, u, "INFO", CHAN_INFO_SYNTAX);
		return;
	}
	if (!(ci = cs_findchan(chan)))
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}
	if (!ci->founder)
	{
		/* Paranoia... this shouldn't be able to happen */
		delchan(ci);
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}

	/* Only show all the channel's settings to sadmins and founders. */
	can_show_all = (is_identified(u, ci) || is_servadmin);
	
	if (can_show_all)
		show_all = 1;  

	notice_lang(s_ChanServ, u, CHAN_INFO_HEADER, chan);
	ni = ci->founder;
	if (ni->last_usermask && (is_servadmin || !(ni->flags & NI_HIDE_MASK)))
	{
		notice_lang(s_ChanServ, u, CHAN_INFO_FOUNDER, ni->nick, ni->last_usermask);
	} else {
		notice_lang(s_ChanServ, u, CHAN_INFO_NO_FOUNDER, ni->nick);
	}

	if ( (ni = ci->successor) )
	{
		if (ni->last_usermask && (is_servadmin || !(ni->flags & NI_HIDE_MASK)))
		{
			notice_lang(s_ChanServ, u, CHAN_INFO_SUCCESSOR, ni->nick, ni->last_usermask);
		} else {
			notice_lang(s_ChanServ, u, CHAN_INFO_NO_SUCCESSOR, ni->nick);
		}
	}

	notice_lang(s_ChanServ, u, CHAN_INFO_DESCRIPTION, ci->desc);
	tm = localtime(&ci->time_registered);
	strftime_lang(buf, sizeof(buf), u, STRFTIME_DATE_TIME_FORMAT, tm);
	notice_lang(s_ChanServ, u, CHAN_INFO_TIME_REGGED, buf);
	tm = localtime(&ci->last_used);
	strftime_lang(buf, sizeof(buf), u, STRFTIME_DATE_TIME_FORMAT, tm);
	notice_lang(s_ChanServ, u, CHAN_INFO_LAST_USED, buf);

	/* Do not show last_topic if channel is mlock'ed +s or +p, or if the
	 * channel's current modes include +s or +p. -TheShadow */
	if (ci->last_topic && !(ci->mlock_on & (CMODE_s | CMODE_p)))
	{
		if (!ci->c || !(ci->c->mode & (CMODE_s | CMODE_p)))
		{
			notice_lang(s_ChanServ, u, CHAN_INFO_LAST_TOPIC, ci->last_topic);
			notice_lang(s_ChanServ, u, CHAN_INFO_TOPIC_SET_BY, ci->last_topic_setter);
		}
	}

	if (ci->entrycount && CHECK_SHOW_ALL)
		for (i = 0; i < ci->entrycount; i++)
			notice_lang(s_ChanServ, u, CHAN_INFO_ENTRYMSG, ci->entrymsg[i]);
	if (ci->email && CHECK_SHOW_ALL)
		notice_lang(s_ChanServ, u, CHAN_INFO_EMAIL, ci->email);
	s = chanopts_to_string(ci, u->ni);
	notice_lang(s_ChanServ, u, CHAN_INFO_OPTIONS,
		*s ? s : getstring(u->ni, CHAN_INFO_OPT_NONE));
	end = buf;
	*end = 0;
	if (ci->mlock_on || ci->mlock_key || ci->mlock_limit)
		end += snprintf(end, sizeof(buf)-(end-buf), "+%s%s%s",
			mode_flags_to_string(ci->mlock_on, MODE_CHANNEL),
				(ci->mlock_key  ) ? "k" : "",
				(ci->mlock_limit) ? "l" : "");
	if (ci->mlock_off)
		end += snprintf(end, sizeof(buf)-(end-buf), "-%s",
			mode_flags_to_string(ci->mlock_off, MODE_CHANNEL));
	if (*buf)
		notice_lang(s_ChanServ, u, CHAN_INFO_MODE_LOCK, buf);

	if ((ci->flags & CI_NOEXPIRE) && CHECK_SHOW_ALL)
		notice_lang(s_ChanServ, u, CHAN_INFO_NO_EXPIRE);

	if (ci->suspendinfo)
	{
		notice_lang(s_ChanServ, u, CHAN_X_SUSPENDED, chan);
		if (CHECK_SHOW_ALL)
		{
			SuspendInfo *si = ci->suspendinfo;
			char timebuf[BUFSIZE], expirebuf[BUFSIZE];

			tm = localtime(&si->suspended);
			strftime_lang(timebuf, sizeof(timebuf), u, STRFTIME_DATE_TIME_FORMAT, tm);
			expires_in_lang(expirebuf, sizeof(expirebuf), u->ni, si->expires);
			notice_lang(s_ChanServ, u, CHAN_INFO_SUSPEND_DETAILS, si->who, timebuf, expirebuf);
			notice_lang(s_ChanServ, u, CHAN_INFO_SUSPEND_REASON, si->reason);
		}
	}

	if (can_show_all && !show_all && used_all)
		notice_lang(s_ChanServ, u, CHAN_INFO_SHOW_ALL, s_ChanServ, ci->name);

}

/*************************************************************************/

/* SADMINS can search for channels based on their CI_VERBOTEN and
 * CI_NOEXPIRE flags and suspension status. This works in the same way as
 * NickServ's LIST command.
 * Syntax for sadmins: LIST pattern [FORBIDDEN] [NOEXPIRE] [SUSPENDED]
 * Also fixed CI_PRIVATE channels being shown to non-sadmins.
 * -TheShadow
 */

static void k9_list(User *u)
{ 
        char *chan = strtok(NULL, " ");
	char *pattern = strtok(NULL, " ");
	char *keyword;
	ChannelInfo *ci;
	int nchans;
	char buf[BUFSIZE];
	int32 matchflags = 0; /* CI_ flags a chan must match one of to qualify */
	int match_susp = 0;	/* nonzero to match suspended channels */

        if (!chan)
        {
        	syntax_error(s_ChanServ, u, "LIST", CHAN_LIST_SYNTAX);
		return;
        }
	if (!nick_recognized(u))
	{
		notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK, s_NickServ, s_NickServ);
		return;
	}
	if (!pattern)
	{
		syntax_error(s_ChanServ, u, "LIST", CHAN_LIST_SYNTAX);
		return;
	}
	nchans = 0;

	while ((keyword = strtok(NULL, " ")))
	{
		if (stricmp(keyword, "FORBIDDEN") == 0)
			matchflags |= CI_VERBOTEN;
		if (stricmp(keyword, "NOEXPIRE") == 0)
			matchflags |= CI_NOEXPIRE;
		if (stricmp(keyword, "SUSPENDED") == 0)
			match_susp = 1;
	}

	notice_lang(s_ChanServ, u, CHAN_LIST_HEADER, pattern);
	for (ci = cs_firstchan(); ci; ci = cs_nextchan())
	{
		if (matchflags || match_susp)
		{
			if (!((ci->flags & matchflags) || (ci->suspendinfo && match_susp)))
				continue;
		}

		snprintf(buf, sizeof(buf), "%-20s  %s", ci->name,
			ci->desc ? ci->desc : "");
		if (irc_stricmp(pattern, ci->name) == 0 || match_wild_nocase(pattern, buf))
		{
			if (++nchans <= CSListMax)
			{
				char noexpire_char = ' ', suspended_char = ' ';

				/* This can only be true for SADMINS - normal users
				 * will never get this far with a VERBOTEN channel.
				 * -TheShadow */
				if (ci->flags & CI_VERBOTEN)
				{
					snprintf(buf, sizeof(buf), "%-20s  [Forbidden]", ci->name);
				}

				notice(s_ChanServ, u->nick, "  %c%c%s",
					suspended_char, noexpire_char, buf);
			}
		}
	}
	notice_lang(s_ChanServ, u, CHAN_LIST_END, nchans>CSListMax ? CSListMax : nchans, nchans);
}

/*************************************************************************/


/* Internal routine to handle all op/voice-type requests. */

/*
static struct {
    const char *cmd;
    int add;
    int32 mode;
    int sender_acc;	
    int target_acc;	
    int target_nextacc;	
    int CHAN_OP_SUCCEEDED, failure_msg;
} opvoice_data[] = {
    { "OP",        1, CUMODE_o, CA_OPDEOP, CA_AUTODEOP, -1,
	  CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "DEOP",      0, CUMODE_o, CA_OPDEOP, CA_AUTOOP, -1,
	  CHAN_DEOP_SUCCEEDED, CHAN_DEOP_FAILED },
    { "VOICE",     1, CUMODE_v, CA_VOICE, -1, -1,
	  CHAN_VOICE_SUCCEEDED, CHAN_VOICE_FAILED },
    { "DEVOICE",   0, CUMODE_v, CA_VOICE, CA_AUTOVOICE, CA_AUTOHALFOP,
	  CHAN_DEVOICE_SUCCEEDED, CHAN_DEVOICE_FAILED },
    { "HALFOP",    1, CUMODE_h, CA_HALFOP, CA_AUTODEOP, -1,
	  CHAN_HALFOP_SUCCEEDED, CHAN_HALFOP_FAILED },
    { "DEHALFOP",  0, CUMODE_h, CA_HALFOP, CA_AUTOHALFOP, CA_AUTOOP,
	  CHAN_DEHALFOP_SUCCEEDED, CHAN_DEHALFOP_FAILED },
#ifdef HAVE_CHANPROT
    { "PROTECT",   1, CUMODE_a, CA_PROTECT, -1, -1,
	  CHAN_PROTECT_SUCCEEDED, CHAN_PROTECT_FAILED },
    { "DEPROTECT", 0, CUMODE_a, CA_PROTECT, -1, -1,
	  CHAN_DEPROTECT_SUCCEEDED, CHAN_DEPROTECT_FAILED },
#endif
    { "JOIN",   1, -1, CA_JOIN, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "PART", 0, -1, CA_PART, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "SAY",   1, -1, CA_SAY, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "ACT",   1, -1, CA_ACT, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "SND", 0, -1, CA_SND, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "KICK",   1, -1, CA_KICK, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "BAN",   1, -1, CA_BAN, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "ADDUSER", 0, -1, CA_ADDUSER, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "REMUSER",   1, -1, CA_REMUSER, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "MODUSER", 0, -1, CA_MODUSER, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "TOPIC",   1, -1, CA_TOPIC, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "MODE", 0, -1, CA_MODE, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "DIEDIE",   1, -1, CA_DIEDIE, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "RESTART",   1, -1, CA_RESTART, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "UPDATE",   1, -1, CA_UPDATE, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },	      	      	  
    { "BROADCAST",   1, -1, CA_BROADCAST, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },	
    { "LASTCMDS",   1, -1, CA_LASTCMDS, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },	      	        	  
    { "ONJOIN",   1, -1, CA_ONJOIN, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "INVITE",   1, -1, CA_INVITE, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "REMCHAN",   1, -1, CA_REMCHAN, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "ADDCHAN",   1, -1, CA_ADDCHAN, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "GUARDM",   1, -1, CA_GUARDM, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "GUARDT",   1, -1, CA_GUARDT, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "COMMANDS", 1, -1, CA_COMMANDS, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "COMMENT", 1, -1, CA_COMMENT, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "SUSPEND", 1, -1, CA_SUSPEND, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "UNSUSPEND", 1, -1, CA_UNSUSPEND, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "FORBID", 1, -1, CA_FORBID, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "UNBAN", 1, -1, CA_UNBAN, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "GETPASS", 1, -1, CA_GETPASS, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
    { "GENPASS", 1, -1, CA_GENPASS, -1, -1,
          CHAN_OP_SUCCEEDED, CHAN_OP_FAILED },
	      	  
};
*/

static void k9_op(User *u)
{
	char *chan = strtok(NULL, " ");
	char *userlist = strtok(NULL, "");
	const char *cmd = "OP";
	Channel *c = NULL;
	ChannelInfo *ci;
	User *target_user;
	int slevel = 0;
	int cslevel = 0;
	int tlevel = 0;
	char *target;
	char modebuf[3];
	struct u_chanlist *cl;

	if (!userlist)
	{
		userlist = malloc(NICKMAX);
		userlist = u->nick;
	}
	if (!chan)
	{
		char buf[BUFSIZE];
		snprintf(buf, sizeof(buf), getstring(u->ni, CHAN_OPVOICE_SYNTAX), cmd);
		notice_lang(s_ChanServ, u, SYNTAX_ERROR, buf);
		notice_lang(s_ChanServ, u, MORE_INFO, s_ChanServ, cmd);
		return;
	}
	//if (!(check_cservice(u)) && !(c = findchan(chan)))
	if (!(c = findchan(chan)))
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
		return;
	}
	if (!nick_recognized(u))
	{
		notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK, s_NickServ, s_NickServ);
		return;
	}
	//if (c->bouncy_modes)
	//{
	//	notice_lang(s_ChanServ, u, CHAN_BOUNCY_MODES, cmd);
	//	return;
	//}
	if (!(ci = c->ci))
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}

	slevel = get_access(u,ci);
	cslevel = check_cservice(u);

	for ( (!(target = strtok(userlist, " "))) ? target = userlist : NULL; target;  target = strtok(NULL, " ") )
	{
		if (! (target_user = finduser(target))  )
		{
			notice_lang(s_ChanServ, u, CHAN_NOUSER_FOUND, target);
			continue;
		}
		for (cl = target_user->chans; cl; cl = cl->next)
		{
			if (irc_stricmp(chan, cl->chan->name) == 0)
				break;
		}
		if (!cl)
		{
			notice_lang(s_ChanServ, u, NICK_X_NOT_ON_CHAN_X, target, chan);
			continue;
		}

		tlevel = get_access(target_user,ci);
		modebuf[0] = '+';
		modebuf[1] = mode_flag_to_char(CUMODE_o, MODE_CHANUSER);
		modebuf[2] = 0;

		send_cmode(MODE_SENDER(s_ChanServ), chan, modebuf, target);
		target_user->mode |= CUMODE_o;
	}

	ci->last_used = time(NULL);
        db_update_lastused(ci);
	notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED, target, chan);
}

/*************************************************************************/

static void k9_deop(User *u)
{
	char *chan = strtok(NULL, " ");
	char *userlist = strtok(NULL, "");
	const char *cmd = "DEOP";
	Channel *c = NULL;
	ChannelInfo *ci;
	User *target_user;
	int slevel = 0;
	int cslevel = 0;
	int tlevel = 0;
	char *target;
	char modebuf[3];
	struct u_chanlist *cl;

	if (!userlist)
	{
		userlist = malloc(NICKMAX);
		userlist = u->nick;
	}
	if (!chan)
	{
		char buf[BUFSIZE];
		snprintf(buf, sizeof(buf), getstring(u->ni, CHAN_OPVOICE_SYNTAX), cmd);
		notice_lang(s_ChanServ, u, SYNTAX_ERROR, buf);
		notice_lang(s_ChanServ, u, MORE_INFO, s_ChanServ, cmd);
		return;
	}
	if (!(c = findchan(chan)))
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
		return;
	}
	if (!nick_recognized(u))
	{
		notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK, s_NickServ, s_NickServ);
		return;
	}
	//if (c->bouncy_modes)
	//{
	//	notice_lang(s_ChanServ, u, CHAN_BOUNCY_MODES, cmd);
	//	return;
	//}
	if (!(ci = c->ci))
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}

	cslevel = check_cservice(u);
	slevel = get_access(u,ci);

	for ( (!(target = strtok(userlist, " "))) ? target = userlist : NULL; target;  target = strtok(NULL, " ") )
	{
		if (! (target_user = finduser(target))  )
		{
			notice_lang(s_ChanServ, u, CHAN_NOUSER_FOUND, target);
			continue;
		}
		for (cl = target_user->chans; cl; cl = cl->next)
		{
			if (irc_stricmp(chan, cl->chan->name) == 0)
				break;
		}
		if (!cl)
		{
			notice_lang(s_ChanServ, u, NICK_X_NOT_ON_CHAN_X, target, chan);
			continue;
		}

		tlevel = check_cservice(target_user);
		if (tlevel < ACCLEV_IMMORTAL)
			tlevel = get_access(target_user,ci);

		if (((cslevel > 0) ? (cslevel <= tlevel) : (slevel <= tlevel)) && (stricmp(target_user->nick, u->nick) != 0))
		{
			notice_lang(s_ChanServ, u, CHAN_USER_LIKE_THAT, target);
			continue;
		}

		modebuf[0] = '-';
		modebuf[1] = mode_flag_to_char(CUMODE_o, MODE_CHANUSER);
		modebuf[2] = 0;

		send_cmode(MODE_SENDER(s_ChanServ), chan, modebuf, target);
		target_user->mode &= ~CUMODE_o;
	}

	notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED, target, chan);
}

/*************************************************************************/

static void k9_voice(User *u)
{
	char *chan = strtok(NULL, " ");
	char *userlist = strtok(NULL, "");
	const char *cmd = "DEOP";
	Channel *c = NULL;
	ChannelInfo *ci;
	int slevel = 0;
	int cslevel = 0;
	int tlevel = 0;
	char *target;
	char modebuf[3];
	struct u_chanlist *cl;

	if (!userlist)
	{
		userlist = malloc(NICKMAX);
		userlist = u->nick;
	}
	if (!chan)
	{
		char buf[BUFSIZE];
		snprintf(buf, sizeof(buf), getstring(u->ni, CHAN_OPVOICE_SYNTAX), cmd);
		notice_lang(s_ChanServ, u, SYNTAX_ERROR, buf);
		notice_lang(s_ChanServ, u, MORE_INFO, s_ChanServ, cmd);
		return;
	}
	if ( !(c = findchan(chan)) )
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
		return;
	}
	if (!nick_recognized(u))
	{
		notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK, s_NickServ, s_NickServ);
		return;
	}
	//if (c->bouncy_modes)
	//{
	//	notice_lang(s_ChanServ, u, CHAN_BOUNCY_MODES, cmd);
	//	return;
	//}
	if (!(ci = c->ci))
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}

	slevel = get_access(u,ci);
	cslevel = check_cservice(u);

	for ( target = strtok(userlist, " "); target;  target = strtok(NULL, " ") )
	{
		User *target_user;
		int add = 0;

		if (! (target_user = finduser(target))  )
		{
			notice_lang(s_ChanServ, u, CHAN_NOUSER_FOUND, target);
			continue;
		}
		for (cl = target_user->chans; cl; cl = cl->next)
		{
			if (irc_stricmp(chan, cl->chan->name) == 0)
				break;
		}
		if (!cl)
		{
			notice_lang(s_ChanServ, u, NICK_X_NOT_ON_CHAN_X, target, chan);
			continue;
		}

		tlevel = get_access(target_user,ci);

		add =  (target_user->mode & CUMODE_v);

		modebuf[0] = '+';
		modebuf[1] = mode_flag_to_char(CUMODE_v, MODE_CHANUSER);
		modebuf[2] = 0;

		target_user->mode |= CUMODE_v;
		send_cmode(MODE_SENDER(s_ChanServ), chan, modebuf, target);
	}

	notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED, target, chan);
}

static void k9_devoice(User *u)
{
	char *chan = strtok(NULL, " ");
	char *userlist = strtok(NULL, "");
	const char *cmd = "DEOP";
	Channel *c = NULL;
	ChannelInfo *ci;
	int slevel = 0;
	int cslevel = 0;
	int tlevel = 0;
	char *target;
	char modebuf[3];
	struct u_chanlist *cl;

	if (!userlist)
	{
		userlist = malloc(NICKMAX);
		userlist = u->nick;
	}
	if (!chan)
	{
		char buf[BUFSIZE];
		snprintf(buf, sizeof(buf), getstring(u->ni, CHAN_OPVOICE_SYNTAX), cmd);
		notice_lang(s_ChanServ, u, SYNTAX_ERROR, buf);
		notice_lang(s_ChanServ, u, MORE_INFO, s_ChanServ, cmd);
		return;
	}
	if ( !(c = findchan(chan)) )
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
		return;
	}
	if (!nick_recognized(u))
	{
		notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK, s_NickServ, s_NickServ);
		return;
	}
	//if (c->bouncy_modes)
	//{
	//	notice_lang(s_ChanServ, u, CHAN_BOUNCY_MODES, cmd);
	//	return;
	//}
	if (!(ci = c->ci))
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}

	slevel = get_access(u,ci);
	cslevel = check_cservice(u);

	for ( target = strtok(userlist, " "); target;  target = strtok(NULL, " ") )
	{
		User *target_user;
		int add = 0;

		if (! (target_user = finduser(target))  )
		{
			notice_lang(s_ChanServ, u, CHAN_NOUSER_FOUND, target);
			continue;
		}
		for (cl = target_user->chans; cl; cl = cl->next)
		{
			if (irc_stricmp(chan, cl->chan->name) == 0)
				break;
		}
		if (!cl)
		{
			notice_lang(s_ChanServ, u, NICK_X_NOT_ON_CHAN_X, target, chan);
			continue;
		}

		tlevel = get_access(target_user,ci);

		add =  (target_user->mode & CUMODE_v);

		modebuf[0] = '-';
		modebuf[1] = mode_flag_to_char(CUMODE_v, MODE_CHANUSER);
		modebuf[2] = 0;

		target_user->mode |= CUMODE_v;
		send_cmode(MODE_SENDER(s_ChanServ), chan, modebuf, target);
	}

	notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED, target, chan);
}

/*
#ifdef HAVE_HALFOP
static void do_halfop(User *u)
{
    do_opvoice(u, "HALFOP");
}

static void do_dehalfop(User *u)
{
    do_opvoice(u, "DEHALFOP");
}
#endif
*/

/* Will take either a nick, or existing mask and parse it
 * into a complete *!*@* hostmask format.  The returned
 * contents are malloc'd and should be free()d when done
 * with.
 */

static char *get_hostmask_of(char *mask)
{
	User *tu;
	char *hostmask;
	char *p;
        
	if (!mask)
		return NULL;

	hostmask = smalloc(MASKLEN);    
    
	if ( (index(mask,'*') == NULL) && (index(mask, '!') == NULL) && (index(mask, '@') == NULL) )
	{
		char *nick;
		char *user;
		char *host;
		char *m;
        
		if ( (tu = finduser(mask)) )
			m = create_mask(tu, 1);
		else
			m = strdup(mask);
        
		split_usermask(m, &nick, &user, &host );
		if (*user == '~')
			*user = '*';
		free(m);

		snprintf(hostmask, MASKLEN, "%s!%s@%s", nick, user, host);            
		free(nick);
		free(user);
		free(host);

	} else {
		char *nick,*user,*host;

		split_usermask(mask, &nick, &user, &host );
		if (*user == '~')
			*user = '*';
		snprintf(hostmask, MASKLEN, "%s!%s@%s", nick, user, host); 
		free(nick);
		free(user);
		free(host);
	}
	p = hostmask;
//	p[MASKLEN] = 0;
	p[MASKLEN] = '\0';
	return p;
//    return hostmask;
}

/*************************************************************************/

static void k9_unban(User *u)
{
	char        *chan    = strtok(NULL," ");
	char        *mask    = strtok(NULL, " ");

	char        *hostmask;

	ChannelInfo *ci;
	Channel     *c;
	NickInfo    *ni;
	AutoKick    *akick;

	if (!chan || !mask)
	{
		syntax_error(s_ChanServ, u, "UNBAN", CHAN_UNBAN_SYNTAX);
		return;
	}
	if ( !(c = (Channel *)findchan(chan)) )
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);	
		return;
	}
	//if (c->bouncy_modes)
	//{
	//	notice_lang(s_ChanServ, u, CHAN_BOUNCY_MODES, "UNBAN");
	//	return;
	//}
	if (!(ci = c->ci))
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (!nick_recognized(u))
	{
		notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK,s_NickServ, s_NickServ);
		return;
	}
	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}

	if (isdigit(*mask) && strspn(mask, "1234567890,-") == strlen(mask))
	{
		int count, deleted, last = -1;

		deleted = process_numlist(mask, &count, akick_del_callback, u, ci, &last);
		if (!deleted)
		{
			if (count == 1)
				notice_lang(s_ChanServ, u, CHAN_BAN_NOSUCH, atoi(mask), ci->name);
			else
				notice_lang(s_ChanServ, u, CHAN_BAN_NOMATCH, ci->name);
		} else {
			notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
		}
	}
	else
	{
		char     *av[3];
		int      removed = 0;
		int      i;
		int      j;

		if (!(hostmask = get_hostmask_of(mask)))                       /* This SHOULD always*/ 
			hostmask = mask;                                           /* lets be safe..*/

		if (!(ni = findnick(mask)))
			ni = NULL;

		for (akick = ci->akick, i = 0; i < ci->akickcount; akick++, i++)
		{
			if (!akick->in_use)
				continue;

			if ( (akick->is_nick)
				? ni && ( (akick->u.ni == ni)
				  || match_wild_nocase(hostmask, akick->u.mask) )
				: match_wild_nocase(hostmask, akick->u.mask)
			)
			{
				if (akick_del(ci->name, u, akick))
					removed++;
					
				/* We do not use chan_has_ban here as it matches exact hosts
				 * only.
				 */
				for (j = 0; j < c->bancount; j++)
					if ( match_wild_nocase(hostmask, c->bans[j]) )
						chan_rem_ban(ci->name, c->bans[j]);
			}
		}

		if (!removed)
		{
			notice_lang(s_ChanServ, u, CHAN_BAN_NOMATCH, ci->name);
		} else {
			notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
		}

		av[0] = ci->name;
		av[1] = "-b";

		for (i = 0; i < c->bancount; i++)
		{
			if (stricmp(c->bans[i], hostmask) == 0 )
			{
				av[2] = c->bans[i];
				send_cmode(MODE_SENDER(s_ChanServ), av[0], av[1], av[2]);
				do_cmode(s_ChanServ, 3, av);
			}
		}
	}
}

/*************************************************************************/
/*
static void do_clear(User *u)
{
    char *chan = strtok(NULL, " ");
    char *what = strtok(NULL, " ");
    Channel *c;
    ChannelInfo *ci;

    if (!what) {
	syntax_error(s_ChanServ, u, "CLEAR", CHAN_CLEAR_SYNTAX);
    } else if (!(c = findchan(chan))) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
    //} else if (c->bouncy_modes) {
	//notice_lang(s_ChanServ, u, CHAN_BOUNCY_MODES, "CLEAR");
    } else if (!(ci = c->ci)) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (ci->flags & CI_VERBOTEN) {
	notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (!u || !check_access(u, ci, CA_CLEAR)) {
	notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
    } else if (stricmp(what, "BANS") == 0) {
	clear_channel(c, CLEAR_BANS, NULL);
	notice_lang(s_ChanServ, u, CHAN_CLEARED_BANS, chan);
#ifdef HAVE_BANEXCEPT
    } else if (stricmp(what, "EXCEPTIONS") == 0) {
	clear_channel(c, CLEAR_EXCEPTS, NULL);
	notice_lang(s_ChanServ, u, CHAN_CLEARED_EXCEPTIONS, chan);
#endif
    } else if (stricmp(what, "MODES") == 0) {
	clear_channel(c, CLEAR_MODES, NULL);
	notice_lang(s_ChanServ, u, CHAN_CLEARED_MODES, chan);
    } else if (stricmp(what, "OPS") == 0) {
	clear_channel(c, CLEAR_UMODES, (void *)CUMODE_o);
	notice_lang(s_ChanServ, u, CHAN_CLEARED_OPS, chan);
#ifdef HAVE_HALFOP
    } else if (stricmp(what, "HALFOPS") == 0) {
	clear_channel(c, CLEAR_UMODES, (void *)CUMODE_h);
	notice_lang(s_ChanServ, u, CHAN_CLEARED_HALFOPS, chan);
#endif
    } else if (stricmp(what, "VOICES") == 0) {
	clear_channel(c, CLEAR_UMODES, (void *)CUMODE_v);
	notice_lang(s_ChanServ, u, CHAN_CLEARED_VOICES, chan);
    } else if (stricmp(what, "USERS") == 0) {
	char buf[BUFSIZE];
	snprintf(buf, sizeof(buf), "CLEAR USERS command from %s", u->nick);
	clear_channel(c, CLEAR_USERS, buf);
	notice_lang(s_ChanServ, u, CHAN_CLEARED_USERS, chan);
    } else {
	syntax_error(s_ChanServ, u, "CLEAR", CHAN_CLEAR_SYNTAX);
    }
}
*/
/*************************************************************************/

/* Assumes that permission checking has already been done. */

static void k9_getpass(User *u)
{
#ifdef USE_ENCRYPTION
    notice_lang(s_ChanServ, u, CHAN_GETPASS_UNAVAILABLE);
#else
    char *chan = strtok(NULL, " ");
    ChannelInfo *ci;
    
    if (!chan) {
	syntax_error(s_ChanServ, u, "GETPASS", CHAN_GETPASS_SYNTAX);
    } else if (!(check_cservice(u)) || !(ci = cs_findchan(chan))) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (!nick_recognized(u)) {
        notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK,
        s_NickServ, s_NickServ);
    } else if (ci->flags & CI_VERBOTEN) {
	notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (!u || (check_cservice(u) == 0)) {
        notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
    } else if (check_cservice(u) < ACCLEV_IMMORTAL) {
        notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
    } else if (!is_cservice_head(u) && stricmp(chan,CSChan)==0) {
        notice_lang(s_ChanServ, u, CHAN_CSCHAN_GETPASS);
        return;
    } else if (!is_cservice_head(u) && stricmp(chan,AOChan)==0) {
        notice_lang(s_ChanServ, u, CHAN_AOCHAN_GETPASS);
        return;
    } else {
	log("%s: %s!%s@%s used GETPASS on %s",
		s_ChanServ, u->nick, u->username, u->host, ci->name);
	if (WallGetpass) {
	    wallops(s_ChanServ, "\2%s\2 used GETPASS on channel \2%s\2",
		u->nick, chan);
	}
	notice_lang(s_ChanServ, u, CHAN_GETPASS_PASSWORD_IS,
		chan, ci->founderpass);
    }
#endif
}

static void k9_genpass(User *u)
{
  char *chan = strtok(NULL, " ");
  ChannelInfo *ci;

  if (debug)
    log("genpass: start for %s", chan);

  if (!chan || !(ci = cs_findchan(chan))) {
    syntax_error(s_ChanServ, u, "GENPASS", CHAN_GENPASS_SYNTAX);
    return;
  }
  if (!check_cservice(u)) {
    notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, CSChan);
    return;
  }
  if (!nick_recognized(u)) {
    notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK, s_NickServ, s_NickServ);
    return;
  }
  if (!ci->email) {
    /* add this to the lang files later */
    notice(s_ChanServ, u->nick, "channel was not registered with a valid email address");
    return;
  }
  if (!u || (check_cservice(u) == 0)) {
    notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
    return;
  }  
  if (check_cservice(u) < ACCLEV_HELPER) {
    notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
    return;
  }
  if(!stricmp(chan,CSChan)) {
    notice_lang(s_ChanServ, u, CHAN_CSCHAN_GENPASS);
    return;
  }
  if(!stricmp(chan,AOChan)) {
    notice_lang(s_ChanServ, u, CHAN_AOCHAN_GETPASS);
    return;
  }

  log("%s: %s!%s@%s used GENPASS on %s", s_ChanServ, u->nick, u->username, 
      u->host, ci->name);

  genpass(ci->founderpass);
  email_pass(ci->email, ci->founderpass, ci->name);

#ifdef USE_ENCRYPTION
  encrypt_in_place(ci->founderpass, PASSMAX - 1);
#endif

  db_chan_set(ci, "founderpass", ci->founderpass);
  notice_lang(s_ChanServ, u, CHAN_GENPASS_OK, ci->email);

}

/*************************************************************************/

static void k9_forbid(User *u)
{
	char *chan = strtok(NULL, " ");
	Channel *c;
	ChannelInfo *ci;

	if (!chan || !(ci = cs_findchan(chan)))
	{
		syntax_error(s_ChanServ, u, "FORBID", CHAN_FORBID_SYNTAX);
		return;
	}
	if (!nick_recognized(u))
	{
		notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK, s_NickServ, s_NickServ);
		return;
	}
	if ( stricmp(chan,CSChan) == 0 )
	{
		notice_lang(s_ChanServ, u, CHAN_CSCHAN_FORBID);
		return;
	}
	if ( stricmp(chan,AOChan) == 0 )
	{
		notice_lang(s_ChanServ, u, CHAN_AOCHAN_FORBID);
		return;
	}
    
	if (readonly)
	{
		notice_lang(s_ChanServ, u, READ_ONLY_MODE);
		return;
	}
		
	if ((ci = cs_findchan(chan)) != NULL)
		delchan(ci);

	if ( (ci = makechan(chan)) )
	{
		log("%s: %s set FORBID for channel %s", s_ChanServ, u->nick, ci->name);
		ci->flags |= CI_VERBOTEN;
                db_chan_seti(ci, "flags", ci->flags);
		notice_lang(s_ChanServ, u, CHAN_FORBID_SUCCEEDED, chan);
		c = findchan(chan);
		if (c)
			clear_channel(c, CLEAR_USERS, "Use of this channel has been forbidden");
	} else {
		log("%s: Valid FORBID for %s by %s failed", s_ChanServ, ci->name, u->nick);
		notice_lang(s_ChanServ, u, CHAN_FORBID_FAILED, chan);
	}
}

/*************************************************************************/

static void k9_schan(User *u)
{
	ChannelInfo *ci;
	char *expiry, *chan, *reason;
	time_t expires;
	Channel *c;
    
	chan = strtok(NULL, " ");
	if (chan && *chan == '+')
	{
		expiry = chan;
		chan = strtok(NULL, " ");
	} else {
		expiry = NULL;
	}
	reason = strtok(NULL, "");

	if (!reason)
	{
		syntax_error(s_ChanServ, u, "SCHAN", CHAN_SUSPEND_SYNTAX);
		return;
	}
	if ( !(ci = cs_findchan(chan)) )
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (!nick_recognized(u))
	{
		notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK, s_NickServ, s_NickServ);
		return;
	}
	if (!u )
	{
		notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
		return;
	}
	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}
	if (ci->suspendinfo)
	{
		notice_lang(s_ChanServ, u, CHAN_SUSPEND_ALREADY_SUSPENDED, chan);
		return;
	}
	if (!is_cservice_head(u) && stricmp(chan,CSChan)==0)
	{
		notice_lang(s_ChanServ, u, CHAN_CSCHAN_SUSPEND);
		return;
	}
	if (!is_cservice_head(u) && stricmp(chan,AOChan)==0)
	{
		notice_lang(s_ChanServ, u, CHAN_AOCHAN_SUSPEND);
		return;
	}

	if (expiry)
		expires = dotime(expiry);
	else
		expires = CSSuspendExpire;

	if (expires < 0)
	{
		notice_lang(s_ChanServ, u, BAD_EXPIRY_TIME);
		return;
	} else if (expires > 0) {
		expires += time(NULL);	/* Set an absolute time */
	}
	log("%s: %s suspended %s", s_ChanServ, u->nick, ci->name);
	suspend(ci, reason, u->nick, expires);
	notice_lang(s_ChanServ, u, CHAN_SUSPEND_SUCCEEDED, chan);
	c = findchan(chan);
	if (c)
		clear_channel(c, CLEAR_USERS, "Use of this channel has been forbidden");
	if (readonly)
		notice_lang(s_ChanServ, u, READ_ONLY_MODE);
}

/*************************************************************************/

static void k9_unschan(User *u)
{
	char *chan = strtok(NULL, " ");
	ChannelInfo *ci;

	if (!chan)
	{
		syntax_error(s_ChanServ, u, "UNSCHAN", CHAN_UNSUSPEND_SYNTAX);
		return;
	}
	if ( !(ci = cs_findchan(chan)) )
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (!nick_recognized(u))
	{
		notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK, s_NickServ, s_NickServ);
		return;
	}
	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}
	if (!u )
	{
		notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
		return;
	}
	if (!ci->suspendinfo)
	{
		notice_lang(s_ChanServ, u, CHAN_SUSPEND_NOT_SUSPENDED, chan);
		return;
	}

	if (readonly)
		notice_lang(s_ChanServ, u, READ_ONLY_MODE);
	log("%s: %s unsuspended %s", s_ChanServ, u->nick, ci->name);
	unsuspend(ci, 1);
	send_cmode(MODE_SENDER(s_ChanServ), ci->name, "-b", "*!*@*");	
	notice_lang(s_ChanServ, u, CHAN_UNSUSPEND_SUCCEEDED, chan);
}

/*************************************************************************/

/* Join registered channels */

void join_channel(void)
{
	ChannelInfo *ci;
    
	for (ci = cs_firstchan(); ci; ci = cs_nextchan())
	{
                cs_join(ci->name);
		send_cmd(s_ChanServ, "MODE %s +%s %s", ci->name, "o",s_ChanServ);
		ci->flags |= CI_INCHANNEL;
                db_chan_seti(ci, "flags", ci->flags);
	}


	return;
}
		    
		    
		    
/*************************************************************************/

static void k9_restart(User *u)
{       
        char *chan = strtok(NULL," ");
        char *msg = strtok(NULL,"");

        if (!chan || !msg) {
	    syntax_error(s_ChanServ, u, "RESTART", CHAN_RESTART_SYNTAX);
        } else if (!(check_cservice(u))) {
            notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, CSChan);
        } else if (!nick_recognized(u)) {
            notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK,
            s_NickServ, s_NickServ);
        } else if (!u || (check_cservice(u) == 0)) {
            notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
        } else if (check_cservice(u) < 800) {
            notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
        } else {
            wallops(s_ChanServ, "\2RESTART\2 command received from  (%s (%s))", u->nick, msg);
#ifdef HAVE_ALLWILD_NOTICE
            notice(s_ChanServ, "$*", "%s (Restarting..)", msg);
#else
#ifdef NETWORK_DOMAIN
            notice(s_ChanServ, "$*." NETWORK_DOMAIN, "%s (Restarting..)", msg);
#else
            notice(s_ChanServ, "$*.com", "%s (Restarting..)", msg);
            notice(s_ChanServ, "$*.net", "%s (Restarting..)", msg);
            notice(s_ChanServ, "$*.org", "%s (Restarting..)", msg);
            notice(s_ChanServ, "$*.edu", "%s (Restarting..)", msg);
            notice(s_ChanServ, "$*", "%s (Restarting..)", msg);
#endif
#endif	    
            log("%s: RESTART command received from (%s!%s@%s (%s))", s_ChanServ,
	                        u->nick, u->username, u->host, msg);
	    notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);			 
            raise(SIGHUP);
   }					 
}
							 
/*************************************************************************/
							 
static void k9_diedie(User *u)
{
        char *chan = strtok(NULL," ");
        char *msg = strtok(NULL,"");

        if (!chan || !msg) {
            syntax_error(s_ChanServ, u, "DIEDIE", CHAN_DIEDIE_SYNTAX);
        } else if (!(check_cservice(u))) {
            notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, CSChan);
        } else if (!nick_recognized(u)) {
            notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK,
            s_NickServ, s_NickServ);
        } else if (!u || (check_cservice(u) == 0)) {
            notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
        } else if (check_cservice(u) < 800) {
            notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
        } else {
            wallops(s_ChanServ, "\2DIEDIE\2 command received from  (%s (%s))",
            u->nick, msg);
#ifdef HAVE_ALLWILD_NOTICE
            notice(s_ChanServ, "$*", "%s (Shutdown..)", msg);
#else
#ifdef NETWORK_DOMAIN
            notice(s_ChanServ, "$*." NETWORK_DOMAIN, "%s (Shutdown..)", msg);
#else
	    notice(s_ChanServ, "$*.com", "%s (Shutdown..)", msg);
	    notice(s_ChanServ, "$*.net", "%s (Shutdown..)", msg);
	    notice(s_ChanServ, "$*.org", "%s (Shutdown..)", msg);
	    notice(s_ChanServ, "$*.edu", "%s (Shutdown..)", msg);
	    notice(s_ChanServ, "$*", "%s (Shutdown..)", msg);
#endif
#endif	    
            log("%s: DIEDIE command received from (%s!%s@%s (%s))", s_ChanServ,
	                        u->nick, u->username, u->host, msg);
	    notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);			
            save_data = 1;
            delayed_quit = 1;
     }						
}
															      
/*************************************************************************/

#ifdef DISABLED
static void k9_say(User *u)
{
	char *chan = strtok(NULL, " ");
	char *rest = strtok(NULL, "");

        Channel *c;
        ChannelInfo *ci;

        if (!chan || !rest) {
	    syntax_error(s_ChanServ, u, "SAY", CHAN_SAY_SYNTAX);
        } else if (!(c = findchan(chan))) {
            notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
        } else if (!(ci = c->ci)) {
            notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
        } else if (ci->flags & CI_VERBOTEN) {
            notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
        } else if (!nick_recognized(u)) {
            notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK,
                    s_NickServ, s_NickServ);
        } else if (check_cservice(u) >= ACCLEV_IMMORTAL) {
	    privmsg(s_ChanServ, chan,"%s",rest ? rest : "");
	    notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
        } else if (!u || (get_access(u,ci) == 0)) {
            notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
        } else if (!u || (get_access(u,ci) < 500)) {
            notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
	} else {
        privmsg(s_ChanServ, chan,"%s",rest ? rest : "");
	notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
    }
}
#endif

/*************************************************************************/

static void k9_act(User *u)
{
        char *chan = strtok(NULL, " ");
        char *rest = strtok(NULL, "");

        Channel *c;
        ChannelInfo *ci;
//	ChannelInfo *ca;

        if (!chan || !rest) {
	    syntax_error(s_ChanServ, u, "ACT", CHAN_ACT_SYNTAX);
        } else if (!(c = findchan(chan))) {
            notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
        } else if (!(ci = c->ci)) {
            notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
        } else if (ci->flags & CI_VERBOTEN) {
            notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
        } else if (!nick_recognized(u)) {
            notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK,
            s_NickServ, s_NickServ);
        } else if (check_cservice(u) >= ACCLEV_IMMORTAL) {
            privmsg(s_ChanServ, chan,"\1ACTION %s\1", rest ? rest : "");
	    notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
        } else if (!u || (get_access(u,ci) == 0)) {
            notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
        } else if (!u || (get_access(u,ci) < 500)) {
	    notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
        } else {
	
        privmsg(s_ChanServ, chan,"\1ACTION %s\1", rest ? rest : "");
	notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
     }
}

/*************************************************************************/
				
static void k9_snd(User *u)
{
	char *chan = strtok(NULL, " ");
	char *rest = strtok(NULL, "");

        Channel *c;
        ChannelInfo *ci;

        if (!chan || !rest)
	{
		syntax_error(s_ChanServ, u, "SND", CHAN_SND_SYNTAX);
		return;
        } 
	if (check_w32_device(rest) != 0)
	{
		wallops(s_ChanServ, "Channel Service Abuse: %s attempted to exploit W32 device filename vulnerability through channel service in %s", u->nick, chan);
		kill_user(s_ChanServ, u->nick, "Channel Service Abuse: Attempted to exploit W32 device filename vulnerability through channel service");
		return;
	}
	
	else if ( !(c = findchan(chan)))
	{
        	notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
		return;
        } 
	else if (!(ci = c->ci)) 
	{
        	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
        } 
	else if (ci->flags & CI_VERBOTEN) 
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
        } 
	else if (!nick_recognized(u))
	{
       		notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK, s_NickServ, s_NickServ); 
		return;
        } 
	else if (check_cservice(u) >= ACCLEV_IMMORTAL) 
	{
	    privmsg(s_ChanServ, chan,"\1SOUND %s\1", rest ? rest : "");
	    notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
        } 
	
	else if (!u || (get_access(u,ci) == 0)) 
	{
            notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
        } 
	else if (!u || (get_access(u,ci) < 500)) 
	{
            notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
        } 
	else 
	{
        	privmsg(s_ChanServ, chan,"\1SOUND %s\1", rest ? rest : "");
		notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
    	}
}

/*************************************************************************/
			
static void k9_kick(User *u)
{
        char *chan = strtok(NULL, " ");
        char *target = strtok(NULL, " ");
        char *rest = strtok(NULL, "");
        User *target_user;
        NickInfo *ni = u->ni;
	
        Channel *c;
        ChannelInfo *ci;

        if (!chan || !target) {
	    syntax_error(s_ChanServ, u, "KICK", CHAN_KICK_SYNTAX);
	    return;
        } else if ( !(c = findchan(chan))) {
            notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
        } else if (!(ci = c->ci)) {
            notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
        } else if (ci->flags & CI_VERBOTEN) {
            notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
        } else if (!nick_recognized(u)) {
            notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK,
                    s_NickServ, s_NickServ);
        } else if (!(target_user = finduser(target))) {
            notice_lang(s_ChanServ, u, CHAN_NOUSER_FOUND, target);
        } else if (check_cservice(u) >= ACCLEV_IMMORTAL) {
	    if (!stricmp(u->nick,target)) {
             if (rest) {
               send_cmd(MODE_SENDER(s_ChanServ), "KICK %s %s :(Requested By: %s) %s", chan, target, ni->nick, rest);                  
	       notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
               return;
             } else {
               send_cmd(MODE_SENDER(s_ChanServ), "KICK %s %s :(Requested By: %s)", chan, target ,ni->nick);
               notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
               return;
             }}

            if (check_cservice(u) < ACCLEV_IMMORTAL && check_cservice(u) <= get_access(target_user,ci)) {
               notice_lang(s_ChanServ, u, CHAN_USER_LIKE_THAT, target);
               return;
            } else {
   	     if (rest) {
	          send_cmd(MODE_SENDER(s_ChanServ), "KICK %s %s :(Requested By: %s) %s", chan, target, ni->nick, rest);
		  notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
		  return;
	      } else {
	          send_cmd(MODE_SENDER(s_ChanServ), "KICK %s %s :(Requested By: %s)", chan, target, u->nick);    
		  notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
		  return;
              }}
        } else if (!u || (get_access(u,ci) == 0)) {
              notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
        } else if (!u || (get_access(u,ci) < 50)) {
	    notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
        } else if (!stricmp(u->nick,target)) {
                if (rest) {
                send_cmd(MODE_SENDER(s_ChanServ), "KICK %s %s :(Requested By: %s) %s", chan, target, ni->nick, rest);
                return;
                } else {
                send_cmd(MODE_SENDER(s_ChanServ), "KICK %s %s :(Requested By: %s)", chan, target, ni->nick);
                notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
                return;
                }
        } else if (get_access(u,ci) <= get_access(target_user,ci)) {
        notice_lang(s_ChanServ, u, CHAN_USER_LIKE_THAT, target);
        return;
        } else if (rest) {
        send_cmd(MODE_SENDER(s_ChanServ), "KICK %s %s :(Requested By: %s) %s", chan, target, ni->nick, rest);
	notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
	return;
	} else { 
        send_cmd(MODE_SENDER(s_ChanServ), "KICK %s %s :(Requested By: %s)", chan, target, ni->nick);
	notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
	return;
    }
}

/*************************************************************************/

void k9_topic(User *u)
{
	char *chan = strtok(NULL, " ");
	char *topic  = strtok(NULL, "");
	Channel *c;
	ChannelInfo *ci;
	
	if(!chan)
	{ 
		return;
	}
	if ( !(c = findchan(chan)) )
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
		return;
	}
	if (!(ci = c->ci))
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}
	if (!nick_recognized(u))
	{
		notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK, s_NickServ, s_NickServ);
		return;
	}
	if ( !(is_cservice_member(u) || (get_access(u,ci) >= 200)) )
	{
		notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
		return;
	}

	do_set_topic(u, ci, topic);
}

/*************************************************************************/							 

static void k9_save(User *u)
{
	// save_ns_dbase();
        // save_cs_dbase();
	return;
}
		
static void k9_update(User *u)
{
}

/*************************************************************************/

int isnum(char *num)
{
    int i = 0;

    while (num[i] != '\0')
    {
        if (!isdigit(num[i]))
        {
            return FALSE;
        }
        i++;
    }
    return TRUE;
}

#ifdef DISABLED
static void k9_mode(User *u)
{
    char *chan = strtok(NULL, " ");     /* channel info */
    char *list = strtok(NULL, "");      /* arg list */
    ChannelInfo *ci;                    /* ChannelInfo struct */
    Channel *c;                         /* Channel struct */
    char sign;                          /* tmp var to track +/- */
    char *s;
    char *modes = NULL;                 /* string of modes */
    char *mode_args = NULL;             /* string of args for modes */
    char *arg_buf = NULL;               /* copy of mode_args */
    char *arg = NULL;                   /* a mode arg */
    int i = 0;
    int j = 0;
    int modelen = 0;                    /* length of mode string */
    int signlen = 0;
    int arg_cnt = 0;                    /* number of mode args */
    int req_arg = 0;                    /* number of modes that require args */
    char mode_arr[16];                  /* parsed modes */
    char sign_arr[16];                  /* signs for parsed modes */
    char *arg_arr[16];                  /* args for parsed modes */
    char tmp[3];                        /* tmp buf to store sign and mode arg */
    char *av[3] = { NULL, NULL, NULL };                    

    if (!chan || !list || ((list[0] != '+') && (list[0] != '-')))
    {
        syntax_error(s_ChanServ, u, "MODE", CHAN_MODE_SYNTAX);
        return;
    }
    if ((list[0] != '+') && (list[0] != '-'))
    {
        syntax_error(s_ChanServ, u, "MODE", CHAN_MODE_SYNTAX);
        return;
    }
    if (!(c = findchan(chan)))
    {
        notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
        return;
    }
    if (!(ci = c->ci))
    {
        notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
        return;
    }
    if (ci->flags & CI_VERBOTEN)
    {
        notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
        return;
    } 

    if (!nick_recognized(u))
    {
        notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK, s_NickServ, s_NickServ);
        return;
    }
 
    /* Initialize sign var */
    sign = list[0];
 
    /* Get a list of valid modes */
    s = mode_flags_to_string(MODE_ALL, MODE_CHANNEL);
 
    /* Calculate the number of valid modes and number of +/-'s */
    i = 0;
    modes = strtok(list, " ");
    while(modes[i])
    {
        if (strspn(&modes[i], s))
        {
            modelen++;
        }
        if (strspn(&modes[i], "+-"))
        {
            signlen++;
        }
        i++;
    }
 
    /* Verify that all modes are valid. */
    if (!modelen || !signlen || (strlen(modes) != (modelen + signlen)))
    {
        syntax_error(s_ChanServ, u, "MODE", CHAN_MODE_SYNTAX);
        return;
    }
 
    mode_args = strtok(NULL, "");  

    /* Count mode arguments. */
    if (mode_args != NULL)
    {
        arg_buf = sstrdup(mode_args);
        arg = strtok(arg_buf, " ");
    }
    while (arg != NULL)
    {
        arg_cnt++;
        arg = strtok(NULL, " ");
    }                             

    /* Count modes which require an argument. */
    /* Build arrays so we can send modes later */
    i = 0;
    j = 0;
    req_arg = 0;
    if (mode_args)
    {
        arg_buf = sstrdup(mode_args);
    }
    while ((modes[i] != '\0') && (i < 16))
    {
        switch (modes[i])
        {
            case '+':
            case '-':
                sign = modes[i];
                i++;
                break;
            case 'k':
            case 'l':
                if (sign == '+')
                {
                    req_arg++;
                    /* Make sure there's a mode arg left */
                    if (req_arg > arg_cnt)
                    {
                        syntax_error(s_ChanServ, u, "MODE", CHAN_MODE_SYNTAX);
                        return;
                    }
                    if (!arg)
                    {
                        arg = strtok(arg_buf, " ");
                    }
                    else
                    {
                        arg = strtok(NULL, " ");
                    }
                    if (modes[i] == 'l' && !isnum(arg))
                    {
                        syntax_error(s_ChanServ, u, "MODE", CHAN_MODE_SYNTAX);
                        return;
                    }
                    arg_arr[j] = arg;
                }
                else
                {
                    arg_arr[j] = NULL;
                }
                sign_arr[j] = sign;
                mode_arr[j] = modes[i];
                i++;
                j++;
                break;
            default:
                sign_arr[j] = sign;
                mode_arr[j] = modes[i];
                arg_arr[j] = NULL;
                i++;
                j++;
                break;
        }
    }
 
    /* Verify we have the required number of arguments. */
    if (arg_cnt != req_arg)
    {
        syntax_error(s_ChanServ, u, "MODE", CHAN_MODE_SYNTAX);
        return;
    }
 
    j = 0;
    av[0] = chan;
    tmp[2] = '\0';
 
    while (mode_arr[j] != '\0')
    {
        av[2] = NULL;
        switch (mode_arr[j])
        {
            case 'k':
            case 'l':
                if (sign_arr[j] == '+')
                {
                    av[2] = arg_arr[j];
                }
            default:
                /* Build mode arg and store in tmp */
                tmp[0] = sign_arr[j];
                tmp[1] = mode_arr[j];
                av[1] = tmp;
                break;
        }
 
        send_cmode(MODE_SENDER(s_ChanServ), av[0], av[1], av[2]);
        do_cmode(s_ChanServ, 3, av);
 
        j++;
    }
 
    return;  
}
#endif

/*************************************************************************/

/* Global notice sending via GlobalNoticer. */

static void k9_broadcast(User *u)
{
        char *chan = strtok(NULL, " ");
        char *msg = strtok(NULL, "");

        if (!chan || !msg) {
	    syntax_error(s_ChanServ, u, "BROADCAST", CHAN_BROADCAST_SYNTAX);
	} else if (!(check_cservice(u))) {
	    return;
	} else if (!nick_recognized(u)) {
            notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK,
                    s_NickServ, s_NickServ);
        } else if (!u || (check_cservice(u) == 0)) {
	    notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
        } else if (!u || (check_cservice(u) < 650)) {
            notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
        } else {
#ifdef HAVE_ALLWILD_NOTICE
        notice(s_ChanServ, "$*", "%s", msg);
#else
#ifdef NETWORK_DOMAIN
        notice(s_ChanServ, "$*." NETWORK_DOMAIN, "%s", msg);
#else
        /* blah, turk code */
        notice(s_ChanServ, "$*.tr", "%s", msg);
        notice(s_ChanServ, "$*.com", "%s", msg);
        notice(s_ChanServ, "$*.net", "%s", msg);
        notice(s_ChanServ, "$*.org", "%s", msg);
        notice(s_ChanServ, "$*.edu", "%s", msg);
	notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
#endif
#endif
  }
}

/*************************************************************************/

void k9_join(User *u)
{
    ChannelInfo *ci = NULL;
    char *chan = strtok(NULL, " ");     /* channel info */
	
    if (!chan)
    {
        syntax_error(s_ChanServ, u, "JOIN", CHAN_JOIN_SYNTAX);
    }
    else if (!(ci = cs_findchan(chan)))
    {
        notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    }
    else if (ci->flags & CI_VERBOTEN)
    {
        notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    }
    else if (!nick_recognized(u))
    {
        notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK, s_NickServ, s_NickServ);
    }
    else if (check_cservice(u) >= ACCLEV_IMMORTAL)
    {		    
        if (ci->flags & CI_INCHANNEL)
        {
	    notice_lang(s_ChanServ, u, CHAN_INCHAN);
	}
        else
        {
            cs_join(chan);
            send_cmd(s_ChanServ, "MODE %s +%s :%s", chan, "o",s_ChanServ);
            ci->flags |= CI_INCHANNEL;
            db_chan_seti(ci, "flags", ci->flags);
	    notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
        }
    }
    else if (!u || (get_access(u,ci) == 0))
    {
        notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
    }
    else if (!u || (get_access(u,ci) < 450))
    {
        notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
    }
    else
    {
        if (ci->flags & CI_INCHANNEL)
        {
            notice_lang(s_ChanServ, u, CHAN_INCHAN);
        }
        else
        {
            cs_join(chan);
            send_cmd(s_ChanServ, "MODE %s +%s :%s", chan, "o",s_ChanServ);
            ci->flags |= CI_INCHANNEL;
            db_chan_seti(ci, "flags", ci->flags);
            notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
        }
    }
}

/*************************************************************************/

static void k9_remchan(User *u)
{
	char *chan = strtok(NULL, "");
	ChannelInfo *ci;
	Channel *c;

	if (readonly)
	{
		notice_lang(s_ChanServ, u, CHAN_DROP_DISABLED);
		return;
	}

	if ( !chan || !valid_channel(chan,1) )
	{
		syntax_error(s_ChanServ, u, "REMCHAN", CHAN_DROP_SYNTAX);
		return;
	}
	if ( !(ci = cs_findchan(chan)) )
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (!u )
	{	
		notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
		return;
	}
	if ( stricmp(chan,CSChan)==0 )
	{
		notice_lang(s_ChanServ, u, CHAN_CSCHAN_REMCHAN);
		return;
	}
	if (!is_cservice_head(u) && stricmp(chan,AOChan)==0)
	{
		notice_lang(s_ChanServ, u, CHAN_AOCHAN_REMCHAN);
		return;
	}

	log("%s: Channel %s dropped by %s!%s@%s", s_ChanServ, ci->name,
		u->nick, u->username, u->host);
	delchan(ci);
			
	if (CMODE_REG && (c = findchan(chan)))
	{
		c->mode &= ~CMODE_REG;
		send_cmd(s_ChanServ, "MODE %s -%s", chan,
			mode_flags_to_string(CMODE_REG, MODE_CHANNEL));
	}
        cs_part(chan);
	notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
}

/*************************************************************************/

static void k9_commands(User *u)
{
    char *chan = strtok(NULL, " ");
    ChannelInfo *ci;
    Command *c;
    char *s[3] = {"", "", ""};
    int i = 0;
    int ulevel = 0;
    int curr_lvl = 0;
    int old_lvl = 0;

    if(!chan)
    {
        syntax_error(s_ChanServ, u, "COMMANDS", CHAN_COMMANDS_SYNTAX);    
        return;
    }

    if (!(ci = cs_findchan(chan)))
    {
        notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
        return;
    }
     						
    if (!(ulevel = get_access(u, ci)))
    {
	ulevel = check_cservice(u);
    }

    notice(s_ChanServ, u->nick, "COMMANDS");
    notice(s_ChanServ, u->nick, "-");
    notice_lang(s_ChanServ, u, CHAN_COMMANDS_HDR, curr_lvl);

    for (c = cmds; c->name; c++)
    {
        /* if its disabled or they don't have access, skip it */
        if (c->level == -1 || (ulevel < c->level))
        {
            continue;
        }
        curr_lvl = c->level;

        if (curr_lvl == old_lvl)
        {
            s[i++] = (char *) c->name;
        }
        if (i == 3)
        {
            notice_lang(s_ChanServ, u, CHAN_COMMANDS_LST, s[0], s[1], s[2]);
            i = 0;
            s[0] = "";
            s[1] = "";
            s[2] = "";
        }
        if (curr_lvl != old_lvl)
        {
            if (s[0] != "")
                notice_lang(s_ChanServ, u, CHAN_COMMANDS_LST, s[0], s[1], s[2]);

            notice(s_ChanServ, u->nick, "-");
            notice_lang(s_ChanServ, u, CHAN_COMMANDS_HDR, curr_lvl);

            s[0] = "";
            s[1] = "";
            s[2] = "";
            i = 0;
            s[i++] = (char *) c->name;
        }
        old_lvl = curr_lvl;
    }
    if (s[0] != "")
    {
        notice_lang(s_ChanServ, u, CHAN_COMMANDS_LST, s[0], s[1], s[2]);
    }

    return;
}

/*************************************************************************/

static void k9_onjoin(User *u)
{
	char *chan = strtok(NULL, " ");
	char *param = strtok(NULL, " ");
	char *msg = strtok(NULL, "");

/*	NickInfo *ni = u->ni; */
	Channel *c;
	ChannelInfo *ci;

	if (!u || !chan || !param)
	{

		syntax_error(s_ChanServ, u, "ONJOIN", CHAN_ONJOIN_SYNTAX);
		return;
	}
	if ( !(c = findchan(chan)) )
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
		return;
	}
	if ( !(ci = c->ci) )
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}
	if (!nick_recognized(u))
	{
		notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK, s_NickServ, s_NickServ);
		return;
	}
	if ( !( get_access(u,ci) >= ACCLEV_BANS || is_cservice_member(u)) )
	{
		notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
		return;
	}

	if (!(stricmp(param,"clear")))
	{
		do_set_entrymsg(u, ci, NULL);
		return;
	}

	if (!(stricmp(param,"add")))
	{
		char *p;
		char *buf;

		if (!msg)
		{
			syntax_error(s_ChanServ, u, "ONJOIN", CHAN_ONJOIN_SYNTAX);
			return;
		}
		buf = sstrdup(msg);
		p = buf;
		p[ONJOINMAX] = 0;
		do_set_entrymsg(u, ci, buf);
		return;
	}
	
	else
	{
		syntax_error(s_ChanServ, u, "ONJOIN", CHAN_ONJOIN_SYNTAX);
		return;
	}
}

/*************************************************************************/

static void k9_comment(User *u)
{

    char *chan = strtok(NULL, " ");
    char *param = strtok(NULL, "");

    NickInfo *ni = u->ni;
    Channel *c;
    ChannelInfo *ci;

    if (!chan || !u)
    {
        return;
    }
    if ( !(c = findchan(chan)) )
    {
        notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
        return;
    }
    if ( !(ci = c->ci) )
    {
        notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);	
        return;
    }
    if (ci->flags & CI_VERBOTEN)
    {
        notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
        return;
    }
    if (!nick_recognized(u))
    {
        notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK,
        s_NickServ, s_NickServ);
        return;
    }
    if ( get_access(u, ci) == 0 )
    {
        notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
        return;
    }
    if ( get_access(u,ci) < 75 )
    {
        notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
        return;
    }
    if (!param)
    {
        remove_comment(ci, ni);
        notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
        return;
    }
    if (strlen(param) > COMMENTMAX)
    {
	notice(s_ChanServ, u->nick, "Channel comments must be no longer than %d characters!", COMMENTMAX);
	return;
    }
    else
    {
        record_comment(ci, ni, param);	    
        notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
	return;
    }
}


/*************************************************************************/

static void k9_lastcmds(User *u)
{
        char *chan = strtok(NULL, " ");
        char *user = strtok(NULL, "");
        User *tu;
        NickInfo *ni;
	Channel *c;
	ChannelInfo *ci;
        int i = 0;
			    
        if (!chan || !user ) {
            syntax_error(s_ChanServ, u, "LASTCMDS", CHAN_LASTCMDS_SYNTAX);
        } else if (  !(c = findchan(chan))) {
            notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
        } else if (!(ci = c->ci)) {
            notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
        } else if (ci->flags & CI_VERBOTEN) {
            notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
        } else if (!nick_recognized(u)) {
            notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK,
            s_NickServ, s_NickServ);
        } else if (!u || (check_cservice(u) == 0)) {
	    notice_lang(s_ChanServ, u, CHAN_OP_FAILED);		    
        } else if (!u || (check_cservice(u) < ACCLEV_IMMORTAL)) {
	    notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
        } else if (!user || !(tu = finduser(user)) || !(ni = tu->ni) || !stricmp(user,"k9")) {
	    notice_lang(s_ChanServ, u, CHAN_NOUSER_FOUND, user);
	    return;    
        } else if (!stricmp(u->nick,user)) {
                  notice(s_ChanServ, u->nick, "History for: %s (%s) (count: %d)", tu->nick, ni->nick, ni->historycount);

              for (i = 0; i < ni->historycount; i++) {
                char timebuf[62] = "";
                ChanServHistory *history;
                history = &ni->history[i];
                notice(s_ChanServ, u->nick, "%d [%s]: %s",(i+1), timebuf, history->data );
                }
            notice(s_ChanServ, u->nick, "History list complete");

        } else if (check_cservice(u) <= check_cservice(tu)) {
	    notice_lang(s_ChanServ, u, CHAN_USER_LIKE_THAT, tu->nick);
            return;
	} else if (ni->historycount == 0) { 
            notice(s_ChanServ, u->nick, "No History Information on record");
            return;
        } else { 
            notice(s_ChanServ, u->nick, "History for: %s (%s) (count: %d)", tu->nick, ni->nick, ni->historycount);
            if (chan)

    for (i = 0; i < ni->historycount; i++)
    {
        char timebuf[62] = "";
        ChanServHistory *history;
        history = &ni->history[i];
        notice(s_ChanServ, u->nick, "%d [%s]: %s", (i+1), timebuf, history->data);
    }
    notice(s_ChanServ, u->nick, "History list complete");
  }
}

/*************************************************************************/

static void k9_status(User *u)
{
	char *chan = strtok(NULL, " ");
	char *nick = strtok(NULL, " ");
	Channel *c;
	ChannelInfo *ci;
	User *target_user;

        if (!chan || !nick) {
	syntax_error(s_ChanServ, u, "STATUS", CHAN_STATUS_SYNTAX);
        } else if ( !(c = findchan(chan))) {
            notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
        } else if (!(ci = c->ci)) {
            notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
        } else if (ci->flags & CI_VERBOTEN) {
            notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
        } else if (!nick_recognized(u)) {
            notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK,
            s_NickServ, s_NickServ);
        } else if (!u || (check_cservice(u) == 0)) {
            notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
        } else if (!u || (check_cservice(u) < ACCLEV_IMMORTAL)) {
            notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
        } else if (!stricmp(nick,"k9") || !(target_user = finduser(nick))) {
	    notice_lang(s_ChanServ, u, CHAN_NOUSER_FOUND, nick);
            return;
        } else {
              notice(s_ChanServ, u->nick, "STATUS %s %s %d", chan, nick, 
                    get_access(target_user, ci));
              notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
              return;
        }

}

/*************************************************************************/

static void k9_invite(User *u)
{
	char *chan = strtok(NULL, " ");
	char *user = strtok(NULL, "");
	NickInfo *target = NULL;

	Channel *c;
	ChannelInfo *ci;
	
		/*if (user)
			target = (NickInfo *) cs_finduser(user);
		else
		*/
		target = (NickInfo *) u;

		if (!target)
		{
			if(user)
				notice(s_ChanServ, u->nick, "I couldn't find %s on chatnet master!", user);
			else
				notice(s_ChanServ, u->nick, "Uhm, I don't see you on chatnet. wtf?");
			return;
		}

		if (!chan) 
		{
			syntax_error(s_ChanServ, u, "INVITE", CHAN_INVITE_SYNTAX);	
			return;
		} 
		else if ( !(c = (Channel *)findchan(chan))) 
		{
			notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
		} 
		else if (!(ci = c->ci)) 
		{
			notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		}
		else if (ci->flags & CI_VERBOTEN) 
		{
			notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		} 
                else if (ci->suspendinfo)
                { 
                        notice_lang(s_ChanServ, u, CHAN_X_SUSPENDED, chan);
                        return;
                }
		else if (!nick_recognized(u)) 
		{
			notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK, s_NickServ, s_NickServ);
		} 
		else if (check_cservice(u) >= ACCLEV_IMMORTAL) 
		{
			if(is_on_chan(target->nick, chan)) 
			{
				notice_lang(s_ChanServ, u, CHAN_NOINVITE, target->nick, chan);
				return;
			}   

		send_cmd(s_ChanServ, "INVITE %s %s", target->nick, chan);
		notice(s_ChanServ, u->nick, "%s wishes to invite you to join %s", u->nick, chan);
		notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
		return;	
		} 

		else if (!u || (get_access(u,ci) == 0)) 
		{
			notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
		} 
		else if (!u || (get_access(u,ci) < 100)) 
		{
			notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
		} 
		else 
		{
		
			if(is_on_chan(target->nick,chan)) 
			{
				notice_lang(s_ChanServ, u, CHAN_NOINVITE, target->nick, chan);
				return;
			}

		send_cmd(s_ChanServ, "INVITE %s %s", target->nick, chan);
		notice(s_ChanServ, target->nick, "%s wishes to invite you to join %s", u->nick, chan);
		notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
		return;
		}
}

/*************************************************************************/
									
void k9_part(User *u)
{
        char *chan = strtok(NULL, " ");
        Channel *c;
        ChannelInfo *ci;
	
        if (!chan) {
	   syntax_error(s_ChanServ, u, "PART", CHAN_PART_SYNTAX);
        } else if ( !(c = findchan(chan))) {
            notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
        } else if (!(ci = c->ci)) {
            notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
        } else if (ci->flags & CI_VERBOTEN) {
            notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
        } else if (!nick_recognized(u)) {
            notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK,
                    s_NickServ, s_NickServ);		    
        } else if (check_cservice(u) >= ACCLEV_IMMORTAL) {		    
	    if (!(ci->flags & CI_INCHANNEL))
		return;

            cs_part(chan);
	    ci->flags &= ~CI_INCHANNEL;
            db_chan_seti(ci, "flags", ci->flags);
	    notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
        } else if (!u || (get_access(u,ci) == 0)) {
            notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
        } else if (!u || (get_access(u,ci) < 450)) {
            notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
        } else {
            if (!(ci->flags & CI_INCHANNEL))
	        return;
	    else
            send_cmd(s_ChanServ, "PART %s",chan);
	    ci->flags &= ~CI_INCHANNEL;
            db_chan_seti(ci, "flags", ci->flags);
	    notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
        }
}

/*************************************************************************/

static void k9_access(User *u)
{
	char *chan = strtok(NULL, " ");
	char *cmd  = strtok(NULL, " ");
	char *args = strtok(NULL, "");
	User *target_user = NULL;
	NickInfo *target_nick = NULL;
	ChannelInfo *ci;
//	ChannelInfo *ca = cs_findchan(CSChan);
	int sent_header = 0;
	int startpoint = 0;
	int endpoint = 0;
	int i;
	int counter = 0;

	if ( !chan || !(ci = cs_findchan(chan)) )
		return;

	if (ci->accesscount == 0)
	{
		notice_lang(s_ChanServ, u, CHAN_ACCESS_LIST_EMPTY, chan);
		return;
	}
	else
	{
		endpoint = ( ci->accesscount > ACCLISTNUM ) ? ACCLISTNUM : ci->accesscount;
	}

	if (!cmd && !args)
		cmd = "*";

	if (!cmd)
		cmd = "*";

	/*
	 * If theres no args, and the first argument starts
	 * with -, marking a counter, reassign as appropriate.
	 */
	if ( !args && (cmd[0] == '-') )
	{
		char *pp;

		pp = cmd;
		cmd = "*";
		args = pp;
	}

	/*
	 * Set our start point up..
	 */
	if ( args && (args[0] == '-') )
	{
		char *start;
		char *end;
		char *str = strdup(args);
		int i;

		start = str;
		start++;
		if ( (end = index(start, ' ')) )
			*end = 0;
		if ( start && (i = atoi(start)) )
			startpoint = (i - 1);

		free(str);
	}

	/*
	 * Verify that startpoint is valid, and set our end point
	 */
	if ( startpoint < 0 )
		startpoint = 0;
	if (startpoint > ci->accesscount )
	{
		notice_lang(s_ChanServ, u, CHAN_ACCESS_NO_MATCH, chan);
		return;
	}
	if ( args && (args[0] == '/') && is_cservice_member(u) )
	{
		char *start;
		char *end;
		char *str = strdup(args);
		int i;

		start = str;
		start++;
		if ( (end = index(start, ' ')) )
			*end = 0;
		if ( start && (i = atoi(start)) )
			endpoint = (i - 1);
		if ( endpoint < 0 )
			endpoint = 0;
		if (endpoint > ci->accesscount)
			endpoint = ci->accesscount;

		free(str);
	} else {
		endpoint = (startpoint + ACCLISTNUM) > ci->accesscount 
			? ci->accesscount
			: (startpoint + ACCLISTNUM);
	}

	/*
	 * Parse for =<> characters
	 */
	if ( ((cmd[0] == '=') || (cmd[0] == '<') || (cmd[0] == '>') ) && (cmd[1]) )
	{
		int level;
		char *levelstr = cmd;
		levelstr++;
		level = atoi(levelstr);

		for (i = startpoint; (i < ci->accesscount && counter < ACCLISTNUM); i++)
		{
			ChanAccess *access = &ci->access[i];
			char c;
			
			switch ( c = cmd[0] )
			{
			  case '=':
			  	if ( access->level == level)
				{
					access_list(u, i, ci, &sent_header);
					counter++;
				}
			  	break; 
			  case '<':
			  	if ( access->level < level)
				{
					access_list(u, i, ci, &sent_header);
					counter++;
				}
			  	break;
			  case '>':
			  	if ( access->level > level)
				{
					access_list(u, i, ci, &sent_header);
					counter++;
				}
			  	break;
			  default:
                                break;
			}

		}
	}

	else if ( *cmd == '*' )
	{
		for (i = startpoint; (i < ci->accesscount && counter < ACCLISTNUM); i++)
		{
			access_list(u, i, ci, &sent_header);
			counter++;
		}
	}
	else if ( (target_user = finduser(cmd)) )
	{
		if ( (target_nick = target_user->real_ni) )
		{
			for (i = 0; i < ci->accesscount; i++)
			{
				if ( ci->access[i].ni && 
					(
					  ci->access[i].ni == getlink(target_nick) || 
					  (
					    match_wild_nocase(cmd, ci->access[i].ni->nick ) ||
					    match_wild_nocase(cmd, getlink(ci->access[i].ni)->nick )
					  )
					)
				)
				{
					access_list(u, i, ci, &sent_header);
					break;
				}
			}
		} else {
			/* No NS account exists for user online */
		}
	}
	else if ( (target_nick = findnick(cmd)) )
	{
		for (i = 0; i < ci->accesscount; i++)
		{
			if ( ci->access[i].ni && 
				(
				  ci->access[i].ni == getlink(target_nick) || 
		  		  (
				    match_wild_nocase(cmd, ci->access[i].ni->nick ) ||
				    match_wild_nocase(cmd, getlink(ci->access[i].ni)->nick )
		    		  )
				)
			)
			{
				access_list(u, i, ci, &sent_header);
				break;
			}
		}
	}

	if (!sent_header)
	{
		notice_lang(s_ChanServ, u, CHAN_ACCESS_NO_MATCH, chan);
		return;
	}
	else if (ci->accesscount <= startpoint+ACCLISTNUM)
	{
		notice(s_ChanServ, u->nick, "End of access list.");
		return;
	}
	else if ((startpoint == 0) && (ci->accesscount > ACCLISTNUM))
	{
		notice_lang(s_ChanServ, u, CHAN_ACCESS_LIST_UNFINISHED, ACCLISTNUM+1);
		return;
	}
	else if ((startpoint != 0) && (ci->accesscount > counter)) 
	{
		notice_lang(s_ChanServ, u, CHAN_ACCESS_LIST_UNFINISHED, startpoint + ACCLISTNUM + 1);
		return;
	}
	else
	{
		notice(s_ChanServ, u->nick, "End of access list.");
		return;
	}
}

/*************************************************************************/

static void k9_remuser(User *u)
{
    char *chan = strtok(NULL, " ");
    char *nick = strtok(NULL, " ");
    ChannelInfo *ci;
    NickInfo *ni = u->ni;
    	
    if (!chan || !nick)
    {
        syntax_error(s_ChanServ, u, "REMUSER", CHAN_REMUSER_SYNTAX);    
        return;
    }
    if (!(ci = cs_findchan(chan)))
    {
        notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
        return;
    }
    if (ci->flags & CI_VERBOTEN)
    {
        notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
        return;
    }
    if (!nick_recognized(u))
    {
        notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK, s_NickServ, s_NickServ);
        return;
    }
    if (!(((is_cservice_member(u) &&
        check_cservice(u) > get_access_offline(nick,ci))) ||
        (get_access(u,ci) > get_access_offline(nick,ci))))
    {
        notice_lang(s_ChanServ, u, CHAN_USER_LIKE_THAT, nick);
        return;
    }

    if (!stricmp(nick,"k9"))
    {
        notice_lang(s_ChanServ, u, CHAN_NOUSER_FOUND, nick);
        return;
    }
    
    switch (access_del(ci, nick, get_access(u,ci)))
    {
        case RET_DELETED:
            remove_comment(ci,ni);
            notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);
            break;
        case RET_LISTFULL:
            notice_lang(s_ChanServ, u, CHAN_ACCESS_REACHED_LIMIT, CSAccessMax);
            break;
        case RET_NOSUCHNICK:
            notice_lang(s_ChanServ, u, CHAN_NOUSER_FOUND, nick);
            break;
        case RET_NICKFORBID:
            notice_lang(s_ChanServ, u, NICK_X_FORBIDDEN, nick);
            break;
        case RET_PERMISSION:
            notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
            break;
    }
}

/*************************************************************************/

static void k9_adduser(User *u)
{
	char *chan = strtok(NULL, " ");
	char *nick = strtok(NULL, " ");
	char *s    = strtok(NULL, " ");
    
	NickInfo *ni = u->ni;   
	NickInfo *na = NULL;

	Channel *c;
	ChannelInfo *ci = NULL;
	User *target_user;
	short level = 0;

	if (nick)
		na = findnick(nick);

	if (!chan || !ni || !nick || !s)
	{
		syntax_error(s_ChanServ, u, "ADDUSER", CHAN_ADDUSER_SYNTAX);
		return;
	}

	if ( !(c = findchan(chan)) )
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
		return;
	}
	if (!(ci = c->ci))
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}
	if (!ni || !nick_recognized(u))
	{
		notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK,s_NickServ, s_NickServ);
		return;
	}
	if (readonly)
	{
		notice_lang(s_ChanServ, u, CHAN_ACCESS_DISABLED);
		return;
	}
	if (!na)
	{
		notice_lang(s_ChanServ, u, CHAN_NOUSER_FOUND, nick);
		return;
	}


	if ( is_cservice_member(u) )
	{
		level = atoi(s);
		if (level == 0)
		{
			notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_NONZERO);
			return;
		}
		if ( (level >= ACCLEV_IMMORTAL) && (stricmp(ci->name,CSChan) != 0))
		{
			notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_RANGE,
				ACCLEV_INVALID+1, ACCLEV_EMPEROR-301);
			return;
		}
		if ( level > check_cservice(u) )
		{
			notice_lang(s_ChanServ, u, CHAN_USER_ONLY_LOWER);
			return;
		}
		switch (access_add(ci, nick, level, get_access(u,ci)))
		{
			case RET_ADDED:
				notice_lang(s_ChanServ, u, CHAN_USER_ADDED2, nick, chan, level);
				break;	    
			case RET_CHANGED:
				notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_CHANGED, nick, chan, level);
				break;
			case RET_UNCHANGED:
				notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_UNCHANGED, nick, chan, level);
				break;
			case RET_LISTFULL:
				notice_lang(s_ChanServ, u, CHAN_ACCESS_REACHED_LIMIT, CSAccessMax);
				break;
			case RET_NOSUCHNICK:
				notice_lang(s_ChanServ, u, CHAN_NOUSER_FOUND, nick);
				break;
			case RET_NICKFORBID:
				notice_lang(s_ChanServ, u, NICK_X_FORBIDDEN, nick);
				break;
			case RET_PERMISSION:
				notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
				break;
		}
		return;
	}

	/*
	 *	General adduser support
	 */
	 
	if (!(target_user = finduser(nick)))
	{
		notice_lang(s_ChanServ, u, CHAN_NOUSER_FOUND, nick);
		return;
	}
	if (!nick_recognized(target_user))
	{
		notice_lang(s_ChanServ, u, CHAN_USER_MUST_IDENTIFY);
		return;
	}
	if (!stricmp(nick,"k9"))
	{
		notice_lang(s_ChanServ, u, CHAN_NOUSER_FOUND, nick);
		return;
	}

	if (has_access(target_user,ci))
	{
		notice_lang(s_ChanServ, u, CHAN_USER_ALREADY_ACC);
		return;
	}
	
	level = atoi(s);
	if (level == 0)
	{
		notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_NONZERO);
		return;
	}
	if ( (level >= ACCLEV_IMMORTAL) && (stricmp(ci->name,CSChan) != 0))
	{
		notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_RANGE,
			ACCLEV_INVALID+1, ACCLEV_EMPEROR-301);
		return;
	}
	if (level <= ACCLEV_INVALID || level >= ACCLEV_EMPEROR)
	{
		notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_RANGE,
			ACCLEV_INVALID+1, ACCLEV_EMPEROR-1);
		return;
	}
	if (level >= get_access(u,ci))
	{
		notice_lang(s_ChanServ, u, CHAN_USER_ONLY_LOWER);
		return;
	}

	switch (access_add(ci, nick, level, get_access(u,ci)))
	{
		case RET_ADDED:
			notice_lang(s_ChanServ, target_user, CHAN_USER_ADDED, ni->nick, nick, chan, level);
			notice_lang(s_ChanServ, u, CHAN_USER_ADDED2, nick, chan, level);									    
			break;
		case RET_LISTFULL:
			notice_lang(s_ChanServ, u, CHAN_ACCESS_REACHED_LIMIT, CSAccessMax);
			break;
		case RET_NOSUCHNICK:
			notice_lang(s_ChanServ, u, CHAN_NOUSER_FOUND, nick);
			break;
		case RET_NICKFORBID:
			notice_lang(s_ChanServ, u, NICK_X_FORBIDDEN, nick);
			break;
		case RET_PERMISSION:
			notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
			break;
	}
}

/*************************************************************************/

#ifdef DISABLED
static void k9_moduser(User *u)
{
	char *chan = strtok(NULL, " ");
	char *nick = strtok(NULL, " ");
	char *s    = strtok(NULL, " ");
	Channel *c;
	ChannelInfo *ci = NULL;
	NickInfo *ni = NULL;
	short slevel = 0;
	short tlevel = 0;
    
	if (!chan || !nick || !s)
	{
		syntax_error(s_ChanServ, u, "MODUSER", CHAN_MODUSER_SYNTAX);
		return;
	}
	if ( !(ni = findnick(nick)) )
	{
		notice_lang(s_ChanServ, u, NICK_X_NOT_IN_USE, nick);
		return;
	}
	if ( !(c = findchan(chan)) )
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
		return;
	}
	if (!(ci = c->ci))
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}
	if (!nick_recognized(u))
	{
		notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK, s_NickServ, s_NickServ);
		return;
	}

	tlevel = atoi(s); /* This is the level we want the target set to */

	/*
	 * Determine requestors access
	 */

	slevel = check_cservice(u);
	if (slevel < ACCLEV_IMMORTAL )
		slevel = get_access(u,ci);

	if (slevel == 0)
	{
		notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
		return;
	} 

	if (tlevel == 0)
	{
		notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_NONZERO);
		return;
	}
	if ( !( is_cservice_god(u) || (get_access_offline(nick,ci) < slevel)) )
	{
		notice_lang(s_ChanServ, u, CHAN_USER_LIKE_THAT, nick);
		return;
	}
	
	/* Ensure access level is valid for the channel */
	if ( (tlevel >= ACCLEV_IMMORTAL) && (stricmp(ci->name,CSChan) != 0))
	{
		notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_RANGE, ACCLEV_INVALID+1, slevel - 1 );
		return;
        }
        if (tlevel <= ACCLEV_INVALID || tlevel > ACCLEV_EMPEROR)
        {
		notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_RANGE, ACCLEV_INVALID+1, 
			(stricmp(ci->name,CSChan) == 0)
			? slevel -1
			: (slevel >= ACCLEV_IMMORTAL)
			  ? ACCLEV_IMMORTAL -1
			  : slevel -1);
		/*
		 *The : should return users level -1 or 599
		 */
		return;
	}
	if (tlevel >= slevel)
	{
		notice_lang(s_ChanServ, u, CHAN_RIGHTS_FAILED);
		return;
	}

	/*
	 * Should almost all of the above not be put BACK into access_add?
	 * Why are we checking for the below when we've already checked it ..
	 */
	 	
	switch ( access_add(ci, nick, tlevel, slevel ) )
	{
	  case RET_CHANGED:
		notice_lang(s_ChanServ, u, CHAN_OP_SUCCEEDED);		
		break;
	  case RET_LISTFULL:
		notice_lang(s_ChanServ, u, CHAN_ACCESS_REACHED_LIMIT, CSAccessMax);
		break;
	  case RET_NOSUCHNICK:
		notice_lang(s_ChanServ, u, CHAN_NOUSER_FOUND, nick);
		break;
	  case RET_NICKFORBID:
		notice_lang(s_ChanServ, u, NICK_X_FORBIDDEN, nick);
		break;
	  case RET_PERMISSION:
		notice_lang(s_ChanServ, u, CHAN_OP_FAILED);
		break;
	}
}
#endif
				
/*************************************************************************/

/* Cservice. */

int is_cservice_god(User *u)
{
	int ulevel;
    
	ulevel = check_cservice(u);
	if (ulevel == 0)
		return 0;
	if (ulevel >= ACCLEV_GOD)
	{
		if (nick_identified(u)) 
			return 1;
		else     
			return 0;
	}    
	if (skeleton)
		return 1;
	return 0;
}

int is_cservice_head(User *u)
{
	int ulevel;
    
	ulevel = check_cservice(u);
	if (ulevel == 0)
		return 0;
	if (ulevel >= ACCLEV_EMPEROR)
	{
		if (nick_identified(u)) 
			return 1;
		else     
			return 0;
	}    
	if (skeleton)
		return 1;
	return 0;
}

int is_cservice_demigod(User *u)
{
	int ulevel;
    
	ulevel = check_cservice(u);
	if (ulevel == 0)
		return 0;
	if (ulevel >= ACCLEV_DEMIGOD)
	{
		if (nick_identified(u)) 
			return 1;
		else     
			return 0;
	}    
	if (skeleton)
		return 1;
	return 0;
}

int is_cservice_titan(User *u)
{
	int ulevel;
    
	ulevel = check_cservice(u);
	if (ulevel == 0)
		return 0;
	if (ulevel >= ACCLEV_TITAN)
	{
		if (nick_identified(u)) 
			return 1;
		else     
			return 0;
	}    
	if (skeleton)
		return 1;
	return 0;
}

int is_cservice_member(User *u)
{
	int ulevel;
    
	ulevel = check_cservice(u);
	if (ulevel == 0)
		return 0;
	if (ulevel >= ACCLEV_IMMORTAL)
	{
		if (nick_identified(u)) 
			return 1;
		else     
			return 0;
	}    
	if (skeleton)
		return 1;
	return 0;
}

int is_cservice_helper(User *u)
{
	int ulevel;
    
	ulevel = check_cservice(u);
	if (ulevel == 0)
		return 0;
	if (ulevel >= ACCLEV_HELPER)
	{
		if (nick_identified(u)) 
			return 1;
		else     
			return 0;
	}    
	if (skeleton)
		return 1;
	return 0;
}

/*************************************************************************/
/*************************************************************************/

/*
 * new_akick() Is used to get a new akick record for a channel
 * It will return either an unused record, or reallocate a new
 * one.  It will return NULL if the Maximum akicks are already
 * in place
 */

AutoKick *new_akick(Channel *c)
{
    int i;
    ChannelInfo *ci = c->ci;
    AutoKick *akick;

    if (!c || !ci)
        return (AutoKick *) NULL;

    for (i = 0; i < ci->akickcount; i++)
        if ( ! ci->akick[i].in_use )
                        break;

    if (i == ci->akickcount)
    {
        if (ci->akickcount >= CSAutokickMax)   /* Maximim # of AKicks already exists, cancel */
            return NULL;
        ci->akickcount++;
        ci->akick = srealloc(ci->akick, sizeof(AutoKick) * ci->akickcount);
    }
    akick = &ci->akick[i];
    return akick;
}


/*************************************************************************/

static void k9_version(User *u)
{

        typedef struct {
                char *line;
               } Credits;

               Credits line[] = {
                                { "Chatnet K9 Channel Services" 		}, {" "},
                                { "ChatNet modifications (c) 2001-2002"		}, {" "},
				{ "E-mail: routing@lists.chatnet.org"		},
				{ "Authors:"					}, {" "},
				{ "MRX     (mrx@rooted.net)"			}, 
				{ "sloth   (sloth@nopninjas.com)"		},
				{ "Vampire (vampire@iglou.com)"			}, 
				{ "Thread  (thread@techbench.net)"		},
				{ NULL       },
                                };

                Credits *k9_credits;

		for (k9_credits=line; k9_credits->line; k9_credits++)
		{
			notice(s_ChanServ, u->nick, "%s", k9_credits->line);
		}

	return;
}

static void k9_banlist(User *u)
{
    char *chan = strtok(NULL, " ");
    char *mask    = strtok(NULL, " ");

    Channel     *c;
    // AutoKick    *akick;
    ChannelInfo *ci;

    int i;
    int sent_header = 0;
    int startpoint = 0;
    int counter = 0;

    if (!chan) 
    {
	syntax_error(s_ChanServ, u, "BANLIST", CHAN_BANLIST_SYNTAX);
	return;
    } 
    else if (!(c = findchan(chan))) 
    {
        notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
    } 
    else if (!(ci = c->ci)) 
    {
        notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } 
    else if (ci->flags & CI_VERBOTEN) 
    {
        notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } 
    else if (ci->akickcount == 0) 
    {
        notice_lang(s_ChanServ, u, CHAN_NOBANS);
        return;
    } 
    
    else 
    {
    	if (mask && (mask[0] == '-') )
    	{
                char *start;
                char *end;
                char *str = strdup(mask);
                int i;

                start = str;
                start++;

                if ( (end = index(start, ' ')) )
                        *end = 0;
                if ( start && (i = atoi(start)) )
                        startpoint = (i - 1);

                free(str);
	}

        if (startpoint < 0)
                startpoint = 0;

	if (startpoint > ci->akickcount)
       	{
       	        notice_lang(s_ChanServ, u, CHAN_BAN_NOMATCH, chan);
       		return;
	}


	for (i = startpoint; (i < ci->akickcount && counter < ACCLISTNUM); i++)
	{
		 akick_list(u, i, ci, &sent_header, 1);
		 counter++;
	} 

    
	if (!sent_header)
	{
        	notice_lang(s_ChanServ, u, CHAN_BAN_NOMATCH, chan);
		return;
	}
        else if (ci->akickcount <= startpoint+ACCLISTNUM)
        {
                notice(s_ChanServ, u->nick, "End of ban list.");
                return;
        }
        else if ((startpoint == 0) && (ci->akickcount > ACCLISTNUM))
        {
                notice_lang(s_ChanServ, u, CHAN_BAN_LIST_UNFINISHED, ci->akickcount - ACCLISTNUM, chan, chan, ACCLISTNUM+1);
                return;
        }
        else if ((startpoint != 0) && (ci->akickcount > counter))
        {
                notice_lang(s_ChanServ, u, CHAN_BAN_LIST_UNFINISHED, ci->akickcount - (startpoint + ACCLISTNUM), chan, chan, startpoint + ACCLISTNUM + 1);
                return;
        }
        else
        {
                notice(s_ChanServ, u->nick, "End of ban list.");
                return;
        }

    }
}

/*************************************************************************/

static void k9_ban(User *u)
{
	char        *chan;
/*	char        *cmd; */
	char        *mask;
	char        *reason;

	Channel      *c;
	ChannelInfo *ci;
	ChannelInfo *ca;
	AutoKick    *akick;
	struct      c_userlist *cu;
	struct      c_userlist *next;

	time_t      now = time(NULL);

	NickInfo  *ni = NULL;
/*	User      *tu = NULL; */
	int       bantime = 0;
	char      *av[3];
	int       i; 
	char	  *hostmask;

	chan = strtok(NULL, " ");
	mask  = strtok(NULL, " ");


	if (!chan || !mask )
	{
		syntax_error(s_ChanServ, u, "KICK", CHAN_AKICK_SYNTAX);
		return;
	}

	if (mask[0] == '@')
	{
		syntax_error(s_ChanServ, u, "KICK", CHAN_AKICK_SYNTAX);
		return;
        }

	if ( !(ca = cs_findchan(CSChan)) || !(c = findchan(chan)))
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
		return;
	}
	if (!(ci = c->ci)) {
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}
	if (ci->flags & CI_VERBOTEN) {
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}
	if (!nick_recognized(u)) {
		notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK,s_NickServ, s_NickServ);
		return;
	}

	reason = strtok(NULL, "");

    /*
    	If the target host matches that of ChannelServices, deny the request
    */
    
	if ( strcasecmp(mask, s_ChanServ) == 0 || match_wild_nocase(mask, ServiceMask) )
	{
		notice_lang(s_ChanServ, u, ACCESS_DENIED);
		return;
	}

    
	if (!(ci = cs_findchan(chan)) )
	{
		notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
		return;
	}

	if (ci->flags & CI_VERBOTEN)
	{
		notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
		return;
	}

	if (readonly)
	{
		notice_lang(s_ChanServ, u, CHAN_AKICK_DISABLED);
		return;
	}

	c = findchan(ci->name);
 
	if (reason)
	{
		char   *s1,*s2,*buf;
		
		buf = sstrdup(reason);            
		s1 = strtok(buf, " ");
		if ( s1 )
		{
			long   i;

			i = dotime(s1);
			s2 = strtok(NULL, "");
			
			if (i != -1)
			{
				if(i > 99999999)
				{
					notice(s_ChanServ, u->nick, "Ban time too long, setting to 4 years");
					bantime = 123033600;
				}
				else
					bantime = i;

				if (s2)
					reason = sstrdup(s2);
				else
					reason = NULL;
			}
		}
		if (buf)
			free(buf);
	}

	hostmask = get_hostmask_of(mask);

	if (!(ni = findnick(mask)))
		ni = NULL;

	if ( ni && (ni->status & NS_VERBOTEN) )
	{
	    notice_lang(s_ChanServ, u, NICK_X_FORBIDDEN, mask);
	    return;
	}


	for (akick = ci->akick, i = 0; i < ci->akickcount; akick++, i++)
	{
		/*
			Save on iterations.  If this akill has expired, lets just disable it now.
		*/
		if (akick->in_use && akick->expires && (akick->expires < now))
			akick->in_use = 0;
		
	    if (!akick->in_use)
			continue;

		if ( akick->is_nick 
			? ni && (akick->u.ni == ni) 
			: stricmp(akick->u.mask, hostmask) == 0  )
		{
			notice_lang(s_ChanServ, u, CHAN_AKICK_ALREADY_EXISTS,
				akick->is_nick ? akick->u.ni->nick : akick->u.mask, ci->name);

			free(hostmask);
			return;
		}
	}
        
	for (i = 0; i < ci->akickcount; i++)
		if ( ! ci->akick[i].in_use )
			break;

	if (i == ci->akickcount)
	{
		if (ci->akickcount >= CSAutokickMax)
		{
			notice_lang(s_ChanServ, u, CHAN_AKICK_REACHED_LIMIT, CSAutokickMax);
			return;
		}
		ci->akickcount++;
		ci->akick = srealloc(ci->akick, sizeof(AutoKick) * ci->akickcount);
	}

	akick = &ci->akick[i];

	akick->in_use = 1;
	if (ni) 
	{
		akick->is_nick = 1;
		akick->u.ni = ni;
	}
	else
	{
		akick->is_nick = 0;
		akick->u.mask = sstrdup(hostmask);
	}

	akick->time = now;
	akick->expires = (bantime != 0) ? (now+bantime) : 0;

	strscpy(akick->who, u->nick, NICKMAX);
	akick->reason = sstrdup( (reason) ? reason : CSAutobanReason);
	notice_lang(s_ChanServ, u, CHAN_AKICK_ADDED, mask, ci->name);

        db_akick_add(ci, akick);

    av[0] = ci->name;

    if (chan_has_ban(ci->name, hostmask) == 0)
    {
        av[1] = "+b";
        av[2] = hostmask;
        /*
        send_cmode(MODE_SENDER(s_ChanServ), av[0], av[1], av[2]);
        */
        
        send_cmd(s_ChanServ, "MODE %s %s %s", av[0], av[1], av[2] );
        
        do_cmode(s_ChanServ, 3, av);
    }

    av[2] = akick->reason;

    cu = c->users;
    while (cu) 
    {
        next = cu->next;
        if (check_kick(cu->user, ci->name) )
        {
            av[1] = cu->user->nick;
            do_kick(s_ChanServ, 3, av);
        }
        cu = next;
    }

    free(hostmask);               /* Allocated within sub-function */
}

void cs_join(char *chan) {
  User *u = finduser(s_ChanServ);

  if (u)
    chan_adduser(u, chan, 0);

  send_cmd(s_ChanServ, "JOIN %s", chan);

}

void cs_part(char *chan) {
  User *u = finduser(s_ChanServ);
  Channel *c = findchan(chan);

  if (u)
    chan_deluser(u, c);

  send_cmd(s_ChanServ, "PART %s", chan);

}
