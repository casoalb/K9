/* SQL Routines to load/save Chan/NickServ data db.
**
** Chatnet K9 Channel Services
** Based on ircdservices ver. by Andy Church
** Parts copyright (c) 1999-2000 Andrew Kempe and others.
** Chatnet modifications (c) 2001-2003
**
** E-mail: routing@lists.chatnet.org
** Authors:
**
**      Vampire (vampire@alias.chatnet.org)
**      sloth   (sloth@nopninjas.com)
**
**      *** DO NOT DISTRIBUTE ***
**/

/*************************************************************************/
/*************************************************************************/

/*************************************************************************
 * MYSQL database code section 
 *
 * + 09.18.2002 - sloth@nopninjas.com
 *     all core MYSQL commands to load and save to the DB
 *     specific commands other than ADDCHAN are not working
 * 
 * db_escape_string(char *dest, char *string, unsigned int len)
 *   dest should be double the length + 1 of string.
 *
 * db_connect(int init_db)
 *   connect to the database and initialize the db structure if init_db
 *
 * coming soon: more comments
 *
 * mysql_real_query still needs a wrapper to try to reconnect
 *   if disconnected from the DB
 *
 *************************************************************************/

#ifdef USE_MYSQL

#include "services.h"
#include "pseudo.h"

#define DB_LEVEL_FIELDS    1
#define DB_ACCESS_FIELDS   2
#define DB_AKICK_FIELDS    4
#define DB_ENTRYMSG_FIELDS 1
#define DB_AUTOOP_FIELDS   2
#define DB_COMMENT_FIELDS  2
#define DB_CHAN_FIELDS     27

/* START SQL PROTOTYPES */
void db_remove_autoop(ChannelInfo *ci, NickInfo *ni);
void db_autoop(ChannelInfo *ci, NickInfo *ni, char param);
void db_comment(ChannelInfo *ci, NickInfo *ni, char *comment);
void db_akick_del(char *chan, char *mask);
void db_load_cs(void);
static ChannelInfo *db_load_channel(char **crow);
void db_load_comments(ChannelInfo *ci);
void db_load_autoop(ChannelInfo *ci);
void db_load_entrymsg(ChannelInfo *ci);
void db_load_akicks(ChannelInfo *ci);
void db_load_access(ChannelInfo *ci);
void db_load_levels(ChannelInfo *ci, uint16 n_levels);
int db_add_channel(ChannelInfo *ci);
int db_queryadd_chan(ChannelInfo *ci);
int db_queryadd_comment(ChannelInfo *ci, int n, int a);
int db_queryadd_autoop(ChannelInfo *ci, int n, int a);
int db_queryadd_entrymsg(ChannelInfo *ci, int n);
int db_queryadd_akick(ChannelInfo *ci, int n, int a);
int db_queryadd_access(ChannelInfo *ci, int n, int a);
int db_test_chan(char *channame, uint32 n);
void db_cs_expire_nick(char *usernick);
void db_remuser(char *channame, char *usernick);
int db_remove_nick_in(char *e_usernick, char *dbtable);
int db_remove_nick_from(char *e_usernick, char *channame, char *dbtable);
/* END SQL PROTOTYPES */

extern void alpha_insert_chan(ChannelInfo *ci);
extern void count_chan(ChannelInfo *ci);
extern void reset_levels(ChannelInfo *ci);
extern void alpha_insert_chan(ChannelInfo *ci);
extern void alpha_insert_nick(NickInfo *ni);

char *db_escape_string(char *dest, char *string, unsigned int len) {

  if (!string || !len) {
    dest[0] = 0;
    return(NULL);
  }

  len = len / 2 - 1;
  
  if(strlen(string) < len)
    len = strlen(string);

  mysql_real_escape_string((MYSQL *)&mysqldb, dest, string, len);
  return(dest);

}

int db_connect(int init_db) {

  if(init_db)
    if (mysql_init((MYSQL *)&mysqldb) == NULL) {
      log("dberror: could not init MYSQL data");
      exit(1);
    }

  if (debug)
    log("debug: connecting to database [%s@%s:%d/%s]",
        DBuser, DBhost, DBport, DBname);

  if (mysql_real_connect((MYSQL *)&mysqldb, DBhost, DBuser, DBpass, DBname,
      DBport, NULL, 0) == NULL) {
    log("dberror: could not connect to database: %s",
        mysql_error((MYSQL *)&mysqldb));
    return(0);
  }

  return(1);

}

int db_delete_chan(char *channame) {
  char e_channame[CHANMAX*2+1],
       tmpquery[2048],
       dbtable[][32] = {
         "chan_access",
         "chan_akick",
         "chan_autoop",
         "chan_entrymsg",
         "chan_comments",
         "chan_levels",
         "channel"
       };
  uint16 i, r = 0;

  if (db_escape_string(e_channame, channame, sizeof(e_channame)) == NULL)
    return(-1);

  for( i = 0; i < 7; i++) {

    snprintf(tmpquery, sizeof(tmpquery) - 1, "DELETE FROM %s WHERE "
             "channame=\'%s\'", dbtable[i], e_channame);

    if(mysql_real_query((MYSQL *)&mysqldb, tmpquery, strlen(tmpquery)) != 0) {
      log("dberror: deleting [%s] from [%s]: %s", channame, dbtable[i],
          mysql_error((MYSQL *)&mysqldb));
      r = DB_ERROR;
    }

  }

  return(r);

}

void db_simple_update(char *dbtable, char *field, char *value,
                      char *cfield, char *cvalue) {
  char e_value[512],
       e_cvalue[512];

  if (db_escape_string(e_value, value, sizeof(e_value)) == NULL)
    return;

  if (db_escape_string(e_cvalue, cvalue, sizeof(e_cvalue)) == NULL)
    return;

  db_queryf("UPDATE %s SET %s='%s' WHERE %s='%s'", dbtable, field, value, 
            cfield, cvalue);

}

void db_chan_seti(ChannelInfo *ci, char *field, int value) {
  char e_channame[CHANMAX*2+1];

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return;

  db_queryf("UPDATE channel SET %s='%d' WHERE channame='%s'", field, value, 
            e_channame);

}

void db_chan_set(ChannelInfo *ci, char *field, char *value) {
  char e_channame[CHANMAX*2+1],
       e_value[2048];

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return;

  if (value) {
    if (db_escape_string(e_value, value, sizeof(e_value)) == NULL)
      return;
  } else
    strcpy(e_value, "");

  db_queryf("UPDATE channel SET %s='%s' WHERE channame='%s'", field, e_value,
            e_channame);

}

/* db_update_number
 *   send the SQL command to update the number.
 *   used in db_update_numbers()
 */

void db_update_number(MYSQL_ROW row, uint32 number, char *dbtable,
                      char *e_channame) {

  db_queryf("UPDATE %s SET number=%d WHERE channame='%s' && number=%s",
                dbtable, number, e_channame, row[1]);

}

/* always escape user input string arguments to this! */
int db_update_numbers(char *e_channame, char *dbtable) {
  MYSQL_ROW row;
  MYSQL_RES *mr;
  uint32 i;

  if ((mr = db_request("SELECT channame,number FROM %s WHERE channame='%s' "
                "ORDER BY number", dbtable, e_channame)) == NULL)
    return(DB_ERROR);

  if(mysql_num_rows(mr) == 0) {
    mysql_free_result(mr);
    return(0);
  }

  for( i = 0; (row = mysql_fetch_row(mr)); i++) 
    db_update_number(row, i, dbtable, e_channame);

  mysql_free_result(mr);
  return(i);

}


/*
 * db_remove_nick_from
 *   remove a user from specified table and returns the number of remaining
 *   entries or negative on error. used for cleaning up expired users in the
 *   channel database.
 */

int db_remove_nick_from(char *e_usernick, char *channame, char *dbtable) {
  char table[][32] = {
         "chan_comment",
         "chan_akick",
         "chan_levels",
         "chan_autoop",
         "chan_access",
         "chan_entrymsg",
         "\0"
       },
       e_channame[CHANMAX*2+1],
       tmpquery[2048];
  int r, i;

  if (db_escape_string(e_channame, channame, sizeof(e_channame)) == NULL)
    return(-1);

  snprintf(tmpquery, sizeof(tmpquery) - 1, "DELETE FROM %s WHERE "
           "channame=\'%s\' && nick=\'%s\'", dbtable, e_channame, e_usernick);

  if (mysql_real_query((MYSQL *)&mysqldb, tmpquery, strlen(tmpquery)) != 0) {
    log("dberror: deleting [%s@%s] in [%s]: %s", e_usernick, channame, dbtable,
        mysql_error((MYSQL *)&mysqldb));
    return(DB_ERROR);
  }

  if(mysql_affected_rows((MYSQL *)&mysqldb) < 1) {
    if (debug)
      log("dberror: entry not found while deleting [%s@%s] in [%s]",
          e_usernick, channame, dbtable);
    return(-1);
  }

  if ((r = db_update_numbers(e_channame, dbtable)) < 0)
    return(-1);

  for( i = 0; table[i] && i<6; i++) {
    if (!strcmp(table[i], dbtable)) {
      db_update_count(i, channame, r);
      break;
    }
  }

  return(r);

}

int db_remove_nick_in(char *e_usernick, char *dbtable) {
  MYSQL_ROW row;
  MYSQL_RES *mr;
  char tmpquery[2048],
       *last = "\0";
  uint16 i;

  snprintf(tmpquery, sizeof(tmpquery) - 1, "SELECT channame FROM %s "
           "WHERE nick=\'%s\'", dbtable, e_usernick);

  if (mysql_real_query((MYSQL *)&mysqldb, tmpquery, strlen(tmpquery)) != 0) {
    log("dberror: selecting [nick=%s] in [%s]: %s", e_usernick, dbtable,
        mysql_error((MYSQL *)&mysqldb));
    return(DB_ERROR);
  }

  if((mr = mysql_store_result((MYSQL *)&mysqldb)) == NULL) {
    log("dberror: getting results from [%s] for [%s]: %s", dbtable, e_usernick,
        mysql_error((MYSQL *)&mysqldb));
    return(DB_ERROR);
  }

  if(mysql_num_rows(mr) == 0)
    return(0);

  for( i = 0; (row = mysql_fetch_row(mr)); i++) {
    if(strcmp(last, row[0])) {
      db_remove_nick_from(e_usernick, row[0], dbtable);
      last = row[0];
    }
  }

  return(i);

}

void db_remuser(char *channame, char *usernick) {
  char e_usernick[NICKMAX*2+1],
       dbtable[][32] = {
         "chan_access",
         "chan_autoop",
         "chan_comments"
       };
  uint16 i;

  if (debug > 2)
    log("debug db_remuser(%s, %s)", channame, usernick);

  if (db_escape_string(e_usernick, usernick, sizeof(e_usernick)) == NULL)
    return;

  for( i = 0; i < 3; i++)
    db_remove_nick_from(e_usernick, channame, dbtable[i]);

}

void db_cs_expire_nick(char *usernick) {
  char e_usernick[NICKMAX*2+1],
       dbtable[][32] = {
         "chan_access",
         "chan_autoop",
         "chan_comments"
       };
  uint16 i;

  if (db_escape_string(e_usernick, usernick, sizeof(e_usernick)) == NULL)
    return;

  for( i = 0; i < 3; i++)
    db_remove_nick_in(e_usernick, dbtable[i]);

}

int db_test_chan(char *channame, uint32 n) {
  MYSQL_RES *mr;
  char tmpquery[2048], e_channame[CHANMAX*2+1];
  int32 i, a, r;
  char tabname[][32] = {
    "channel",
    "chan_akick",
    "chan_levels",
    "chan_autoop",
    "chan_access",
    "chan_entrymsg",
    "chan_comments",
    "channel"
  };

  if (db_escape_string(e_channame, channame, sizeof(e_channame)) == NULL)
    return(0);

  a = (n < 8) ? n : 0;

  for( i = a; i < (a ? (a + 1) : 7); i++) {

    memset(tmpquery, 0, sizeof(tmpquery));
    snprintf(tmpquery, sizeof(tmpquery) - 1, "SELECT channame FROM %s"
             " WHERE channame=\'%s\'", tabname[i], e_channame);

    if(mysql_real_query((MYSQL *)&mysqldb, tmpquery, strlen(tmpquery)) != 0) {
      log("dberror: querying [%s] for [%s]: %s", tabname[i], channame,
          mysql_error((MYSQL *)&mysqldb));
      return(DB_ERROR);
    }

    if((mr = mysql_store_result((MYSQL *)&mysqldb)) == NULL) {

      log("dberror: getting results from [%s] for: [%s]: %s", tabname[i],
          channame, mysql_error((MYSQL *)&mysqldb));
      return(DB_ERROR);

    } else if((r = mysql_num_rows(mr)) > 0) {

      if (debug)
        log("dberror: channel [%s] already exists in [%s]", 
            channame, tabname[i]);

      mysql_free_result(mr);
      return(DB_EXIST);

    }

    mysql_free_result(mr);

  }

  return(DB_NOEXIST);

}

int db_queryadd_access(ChannelInfo *ci, int n, int a) {
  char e_channame[CHANMAX*2+1],
       e_nick[NICKMAX*2+1],
       tmpquery[2048];

  if(db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return(0);

  if(db_escape_string(e_nick, ci->access[n].ni->nick, sizeof(e_nick)) == NULL)
    return(0);

  memset(tmpquery, 0, sizeof(tmpquery));
  snprintf(tmpquery, sizeof(tmpquery) - 1, "INSERT INTO chan_access "
           "VALUES (\'%s\',%d,%d,\'%s\')", e_channame, a, ci->access[n].level,
           e_nick);

  if(mysql_real_query((MYSQL *)&mysqldb, tmpquery, strlen(tmpquery)) != 0) {
    log("dberror: loading access for [%s]! %s", ci->name,
        mysql_error((MYSQL *)&mysqldb));
    return(DB_ERROR);
  }

  return(1);

}

int db_queryadd_akick(ChannelInfo *ci, int n, int a) {
  char e_channame[CHANMAX*2+1],
       e_nickmask[512],
       e_reason[512],
       e_who[NICKMAX*2+1],
       tmpquery[2048];

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return(0);

  if (db_escape_string(e_nickmask, ci->akick[n].is_nick ?
                       ci->akick[n].u.ni->nick : ci->akick[n].u.mask,
                       sizeof(e_nickmask)) == NULL)
    return(0);

  if (db_escape_string(e_reason, ci->akick[n].reason, sizeof(e_reason)) == NULL)
    return(0);

  if (db_escape_string(e_who, ci->akick[n].who, sizeof(e_who)) == NULL)
    return(0);

  memset(tmpquery, 0, sizeof(tmpquery));
  snprintf(tmpquery, sizeof(tmpquery) - 1, "INSERT INTO chan_akick VALUES"
           " (\'%s\',%d,%d,\'%s\',\'%s\',\'%s\')", e_channame, a,
           ci->akick[n].is_nick, e_nickmask, e_reason, e_who);

  if (mysql_real_query((MYSQL *)&mysqldb, tmpquery, strlen(tmpquery)) != 0) {
    log("dberror: loading akicks for [%s]: %s", ci->name,
        mysql_error((MYSQL *)&mysqldb));
    return(DB_ERROR);
  }

  return(1);

}

int db_queryadd_entrymsg(ChannelInfo *ci, int n) {
  char e_channame[CHANMAX*2+1],
       e_entrymsg[2048],
       tmpquery[2048];

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return(0);

  if (db_escape_string(e_entrymsg, ci->entrymsg[n], sizeof(e_entrymsg)) == NULL)
    return(0);

  memset(tmpquery, 0, sizeof(tmpquery));
  snprintf(tmpquery, sizeof(tmpquery) - 1, "INSERT INTO chan_entrymsg "
           "VALUES (\'%s\',%d,\'%s\')", e_channame, n, e_entrymsg);

  if (mysql_real_query((MYSQL *)&mysqldb, tmpquery, strlen(tmpquery)) != 0) {
    log("dberror: loading onjoins for [%s]: %s", ci->name,
        mysql_error((MYSQL *)&mysqldb));
    return(DB_ERROR);
  }

  return(1);

}

int db_queryadd_autoop(ChannelInfo *ci, int n, int a) {
  char e_channame[CHANMAX*2+1],
       e_nick[NICKMAX*2+1],
       tmpquery[2048];

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return(0);

  if (db_escape_string(e_nick, ci->autoop[n].ni->nick, sizeof(e_nick)) == NULL)
    return(0);

  memset(tmpquery, 0, sizeof(tmpquery));
  snprintf(tmpquery, sizeof(tmpquery) - 1, "INSERT INTO chan_autoop "
           "VALUES (\'%s\',%d,\'%s\',\'%c\')", e_channame, a,
           e_nick, ci->autoop[n].flag);

  if (mysql_real_query((MYSQL *)&mysqldb, tmpquery, strlen(tmpquery)) != 0) {
    log("dberror: loading autoops for [%s]: %s", ci->name,
        mysql_error((MYSQL *)&mysqldb));
    return(DB_ERROR);
  }

  return(1);

}

int db_queryadd_comment(ChannelInfo *ci, int n, int a) {
  char e_channame[CHANMAX*2+1],
       e_nick[NICKMAX*2+1],
       e_msg[COMMENTMAX*2+1],
       tmpquery[2048];

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return(0);

  if (db_escape_string(e_nick, ci->comment[n].ni->nick, sizeof(e_nick)) == NULL)
    return(0);

  if (db_escape_string(e_msg, ci->comment[n].msg, sizeof(e_msg)) == NULL)
    return(0);

  memset(tmpquery, 0, sizeof(tmpquery));
  snprintf(tmpquery, sizeof(tmpquery) - 1, "INSERT INTO chan_comments "
           "VALUES (\'%s\',%d,\'%s\',\'%s\')", e_channame, a,
           e_nick, e_msg);

  if (mysql_real_query((MYSQL *)&mysqldb, tmpquery, strlen(tmpquery)) != 0) {
    log("dberror: loading user greets for [%s]: %s", ci->name,
        mysql_error((MYSQL *)&mysqldb));
    return(DB_ERROR);
  }

  return(1);

}

int db_queryadd_chan(ChannelInfo *ci) {
  /* escape string buffers [buf * 2 + 1]*/
  char e_channame[CHANMAX*2+1],
       e_foundernick[NICKMAX*2+1],
       e_successornick[NICKMAX*2+1],
       e_founderpass[PASSMAX*2+1],
       e_chandesc[512],
       e_chanurl[512],
       e_email[512],
       e_last_topic[800],
       e_last_topic_setter[NICKMAX*2+1],
       e_swho[NICKMAX*2+1],
       e_sreason[512],
       e_mlock_key[512],
       tmpquery[4096];

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return(0);

  if (db_escape_string(e_foundernick, ci->founder->nick,
                       sizeof(e_foundernick)) == NULL)
    return(0);

  if (ci->successor)
    db_escape_string(e_successornick, ci->successor->nick,
                     sizeof(e_successornick));

  db_escape_string(e_founderpass, ci->founderpass, sizeof(e_founderpass));
  db_escape_string(e_chandesc, ci->desc, sizeof(e_chandesc));
  db_escape_string(e_chanurl, ci->url, sizeof(e_chanurl));
  db_escape_string(e_email, ci->email, sizeof(e_email));
  db_escape_string(e_last_topic, ci->last_topic, sizeof(e_last_topic));
  db_escape_string(e_last_topic_setter, ci->last_topic_setter,
                   sizeof(e_last_topic_setter));
  db_escape_string(e_mlock_key, ci->mlock_key, sizeof(e_mlock_key));

  if(ci->suspendinfo) {
    db_escape_string(e_swho, ci->suspendinfo->who, sizeof(e_swho));
    db_escape_string(e_sreason, ci->suspendinfo->reason, sizeof(e_sreason));
  }

  memset(tmpquery, 0, sizeof(tmpquery));
  snprintf(tmpquery, sizeof(tmpquery) - 1, "INSERT INTO channel VALUES ("
           "\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',%d,%d,"
           "\'%s\',\'%s\',%d,%d,\'%s\',\'%s\',%d,%d,%d,"
           "%d,%d,%d,%d,%d,\'%s\',%d,%d,%d)",
           e_channame,
           e_foundernick,
           e_successornick,
           e_founderpass,
           e_chandesc,
           e_chanurl,
           e_email,
           ci->time_registered,
           ci->last_used,
           e_last_topic,
           e_last_topic_setter,
           ci->last_topic_time,
           ci->flags,
           ci->suspendinfo ? e_swho : "",
           ci->suspendinfo ? e_sreason : "",
           ci->suspendinfo ? ci->suspendinfo->suspended : 0,
           ci->suspendinfo ? ci->suspendinfo->expires : 0,
           CA_SIZE,
           ci->accesscount,
           ci->akickcount,
           ci->mlock_on,
           ci->mlock_off,
           ci->mlock_limit,
           e_mlock_key,
           ci->entrycount,
           ci->autoopcount,
           ci->commentcount
  );

  if(mysql_real_query((MYSQL *)&mysqldb, tmpquery, strlen(tmpquery)) != 0) {
    log("dberror: loading channel for [%s]: %s", ci->name,
        mysql_error((MYSQL *)&mysqldb));
    return(DB_ERROR);
  }

  return(1);
}

int db_add_channel(ChannelInfo *ci) {
  char escapebuf[2050];
  int i, r, a;

  if (debug)
    log("db_add_channel() adding channel [%s]", ci->name);

  if((r = db_test_chan(ci->name, DB_TEST_ALL)) != DB_NOEXIST)
    return(r);

  /* load command levels into the db */
  for( i = 0; i < CA_SIZE; i++) 
    db_queryf("INSERT INTO chan_levels VALUES ('%s','%d','%d')", 
              db_escape_string(escapebuf, ci->name, sizeof(escapebuf)), 
                               i, ci->levels[i]);


  /* load access list into the db */
  if(ci->accesscount) {

    for( i = 0, a = 0; i < ci->accesscount; i++)
      if(ci->access[i].in_use) {
        db_queryadd_access(ci, i, a);
        a++;
      }

    if(a < ci->accesscount)
      ci->accesscount = a;

  }

  /* load banlist into the db */
  if(ci->akickcount) {

    for( i = 0, a = 0; i < ci->akickcount; i++)
      if(ci->akick[i].in_use) {
        db_queryadd_akick(ci, i, a);
        a++;
      }

    if(a < ci->akickcount)
      ci->akickcount = a;

  }


  /* load onjoin messages into the db */
  if(ci->entrycount)
    for( i = 0; i < ci->entrycount; i++)
      db_queryadd_entrymsg(ci, i);


  /* load autoop list into the db */
  if(ci->autoopcount) {

    for( i = 0, a = 0; i < ci->autoopcount; i++)
      if(ci->autoop[i].in_use) {
        db_queryadd_autoop(ci, i, a);
        a++;
      }

    if(a < ci->autoopcount)
      ci->autoopcount = a;

  }


  /* load user greet messages into the db */
  if(ci->commentcount) {

    for( i = 0, a = 0; i < ci->commentcount; i++)
      if(ci->comment[i].in_use) {
        db_queryadd_comment(ci, i, a);
        a++;
      }

    if(a < ci->commentcount)
      ci->commentcount = a;

  }


  /* finish adding the rest */
  db_queryadd_chan(ci);

  return(DB_SUCCESS);
}

void db_load_levels(ChannelInfo *ci, uint16 n_levels) {
  MYSQL_ROW row;
  MYSQL_RES *res;
  char tmpquery[256],
       e_channame[CHANMAX*2+1];
  uint16 fields, i, r;

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    fatal("error: could not escape string [%s]", ci->name);

  snprintf(tmpquery, sizeof(tmpquery) - 1, "SELECT level FROM chan_levels "
           "WHERE channame='%s' ORDER BY number", e_channame);

  if(mysql_real_query((MYSQL *)&mysqldb, tmpquery, strlen(tmpquery)) != 0) {
    fatal("dberror: querying [chan_levels] for [%s]: %s",
        ci->name, mysql_error((MYSQL *)&mysqldb));
  }

  if((res = mysql_store_result((MYSQL *)&mysqldb)) == NULL) {
    fatal("dberror: getting results from [chan_levels] for [%s]: %s",
        ci->name, mysql_error((MYSQL *)&mysqldb));
  }

  if((r = mysql_num_rows(res)) != n_levels) {
    fatal("dberror: [chan_levels] table has an invalid number or rows for [%s]!"
        "%d rows != %d n_levels", ci->name, r, n_levels);
    mysql_free_result(res);
  }

  if((fields = mysql_num_fields(res)) < DB_LEVEL_FIELDS) {
    fatal("dberror: less than [%d] fields in table [chan_levels] "
        "for [%s]", DB_LEVEL_FIELDS, ci->name);
    mysql_free_result(res);
  }

  for( i = 0; (row = mysql_fetch_row(res)); i++)
    ci->levels[i] = atoi(row[0]);

  mysql_free_result(res);
  return;

}

void db_load_access(ChannelInfo *ci) {
  MYSQL_ROW row;
  MYSQL_RES *res;
  char tmpquery[256],
       e_channame[CHANMAX*2+1];
  uint16 fields, i;

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    fatal("error: could not escape string [%s]", ci->name);

  snprintf(tmpquery, sizeof(tmpquery) - 1, "SELECT level,nick FROM chan_access "
           "WHERE channame='%s' ORDER BY number", e_channame);

  if(mysql_real_query((MYSQL *)&mysqldb, tmpquery, strlen(tmpquery)) != 0) {
    fatal("dberror: querying [chan_access] for [%s]: %s",
        ci->name, mysql_error((MYSQL *)&mysqldb));
  }

  if((res = mysql_store_result((MYSQL *)&mysqldb)) == NULL) {
    fatal("dberror: getting results from [chan_access] for [%s]: %s",
        ci->name, mysql_error((MYSQL *)&mysqldb));
  }

  ci->accesscount = mysql_num_rows(res);

/*
  if(mysql_num_rows(res) != ci->accesscount) {
    mysql_free_result(res);
    fatal("dberror: [chan_access] table has invalid number or rows for [%s]!",
        ci->name);
  }
*/


  if((fields = mysql_num_fields(res)) < DB_ACCESS_FIELDS) {
    mysql_free_result(res);
    fatal("dberror: less than [%d] fields in table [chan_access] "
        "for [%s]", DB_ACCESS_FIELDS, ci->name);
  }

  ci->access = scalloc(sizeof(ChanAccess), ci->accesscount);


  for( i = 0; (row = mysql_fetch_row(res)); i++) {

    ci->access[i].level = atoi(row[0]);

    if(!(ci->access[i].ni = findnick(row[1]))) {
      if (debug > 2)
        log("debug: db_load_access() couldn't find nick [%s]", row[1]);
      ci->access[i].in_use = 0;
    } else
      ci->access[i].in_use = 1;

  }
 mysql_free_result(res);
  return;

}

void db_load_akicks(ChannelInfo *ci) {
  MYSQL_ROW row;
  MYSQL_RES *res;
  char tmpquery[256],
       e_channame[CHANMAX*2+1];
  uint16 fields, i;

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    fatal("error: could not escape string [%s]", ci->name);

  snprintf(tmpquery, sizeof(tmpquery) - 1, "SELECT is_nick,mask,reason,who "
           "FROM chan_akick WHERE channame='%s' ORDER BY number", e_channame);

  if(mysql_real_query((MYSQL *)&mysqldb, tmpquery, strlen(tmpquery)) != 0) {
    fatal("dberror: querying [chan_akick] for [%s]: %s",
        ci->name, mysql_error((MYSQL *)&mysqldb));
  }

  if((res = mysql_store_result((MYSQL *)&mysqldb)) == NULL) {
    fatal("dberror: getting results from [chan_akick] for [%s]: %s",
        ci->name, mysql_error((MYSQL *)&mysqldb));
  }

  ci->akickcount = mysql_num_rows(res);

/*
  if(mysql_num_rows(res) != ci->akickcount) {
    mysql_free_result(res);
    fatal("dberror: [chan_akick] table has an invalid number or rows for [%s]!",
        ci->name);
  }
*/

  if((fields = mysql_num_fields(res)) < DB_AKICK_FIELDS) {
    mysql_free_result(res);
    fatal("dberror: less than [%d] fields in table [chan_akick] "
        "for [%s]", DB_AKICK_FIELDS, ci->name);
  }

  ci->akick = scalloc(sizeof(AutoKick), ci->akickcount);

  for( i = 0; (row = mysql_fetch_row(res)); i++) {

    ci->akick[i].is_nick = atoi(row[0]);

    if (ci->akick[i].is_nick)
       ci->akick[i].u.ni = findnick(row[1]);
    else {
      ci->akick[i].u.mask = smalloc(strlen(row[1]) + 1);
      strcpy(ci->akick[i].u.mask, row[1]);
    }

    ci->akick[i].reason = smalloc(strlen(row[2]) + 1);
    strcpy(ci->akick[i].reason, row[2]);
    copy_buffer(ci->akick[i].who, row[3]);
    ci->akick[i].in_use = 1;
  }

  mysql_free_result(res);
  return;

}

void db_load_entrymsg(ChannelInfo *ci) {
  MYSQL_ROW row;
  MYSQL_RES *res;
  char tmpquery[256],
       e_channame[CHANMAX*2+1],
       **greet;
  uint16 fields, i;

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    fatal("error: could not escape string [%s]", ci->name);

  snprintf(tmpquery, sizeof(tmpquery) - 1, "SELECT entrymsg FROM chan_entrymsg "           "WHERE channame='%s' ORDER BY number", e_channame);

  if(mysql_real_query((MYSQL *)&mysqldb, tmpquery, strlen(tmpquery)) != 0) {
    fatal("dberror: querying [chan_entrymsg] for [%s]: %s",
        ci->name, mysql_error((MYSQL *)&mysqldb));
  }

  if((res = mysql_store_result((MYSQL *)&mysqldb)) == NULL) {
    fatal("dberror: getting results from [chan_entrymsg] for [%s]: %s",
        ci->name, mysql_error((MYSQL *)&mysqldb));
  }

  ci->entrycount = mysql_num_rows(res);

/*
  if(mysql_num_rows(res) != ci->entrycount) {
    mysql_free_result(res);
    fatal("dberror: [chan_entrymsg] table has an invalid number or rows "
        "for [%s]!", ci->name);
  }
*/

  if((fields = mysql_num_fields(res)) < DB_ENTRYMSG_FIELDS) {
    mysql_free_result(res);
    fatal("dberror: less than [%d] fields in table [chan_entrymsg] "
        "for [%s]", DB_ENTRYMSG_FIELDS, ci->name);
  }

  greet = smalloc(sizeof(char *) * ci->entrycount);
  ci->entrymsg = greet;

  for( i = 0; (row = mysql_fetch_row(res)); i++, greet++)
    copy_string(greet, row[0]);

  mysql_free_result(res);
  return;

}

void db_load_autoop(ChannelInfo *ci) {
  MYSQL_ROW row;
  MYSQL_RES *res;
  char tmpquery[256],
       e_channame[CHANMAX*2+1];
  uint16 fields, i;

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    fatal("error: could not escape string [%s]", ci->name);

  snprintf(tmpquery, sizeof(tmpquery) - 1, "SELECT nick,flag FROM chan_autoop "
           "WHERE channame='%s' ORDER BY number", e_channame);

  if(mysql_real_query((MYSQL *)&mysqldb, tmpquery, strlen(tmpquery)) != 0) {
    fatal("error querying [chan_autoop] for [%s]: %s",
        ci->name, mysql_error((MYSQL *)&mysqldb));
  }

  if((res = mysql_store_result((MYSQL *)&mysqldb)) == NULL) {
    fatal("dberror: getting results from [chan_autoop] for [%s]: %s",
        ci->name, mysql_error((MYSQL *)&mysqldb));
  }

  ci->autoopcount = mysql_num_rows(res);

/*
  if(mysql_num_rows(res) != ci->autoopcount) {
    mysql_free_result(res);
    fatal("dberror: [chan_autoop] table has an invalid number or rows "
        "for [%s]!", ci->name);
  }
*/

  if((fields = mysql_num_fields(res)) < DB_AUTOOP_FIELDS) {
    mysql_free_result(res);
    log("dberror: less than [%d] fields in table [chan_autoop] "
        "for [%s]", DB_AUTOOP_FIELDS, ci->name);
  }

  ci->autoop = scalloc(sizeof(ChannelAutoop), ci->autoopcount);

  for( i = 0; (row = mysql_fetch_row(res)); i++) {
    ci->autoop[i].ni = findnick(row[0]);
    ci->autoop[i].flag = row[1][0];
    ci->autoop[i].in_use = 1;
  }

  mysql_free_result(res);
  return;

}

void db_load_comments(ChannelInfo *ci) {
  MYSQL_ROW row;
  MYSQL_RES *res;
  char tmpquery[256],
       e_channame[CHANMAX*2+1];
  uint16 fields, i;

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return;

  snprintf(tmpquery, sizeof(tmpquery) - 1, "SELECT nick,message FROM "
           "chan_comments WHERE channame='%s' ORDER BY number", e_channame);

  if(mysql_real_query((MYSQL *)&mysqldb, tmpquery, strlen(tmpquery)) != 0) {
    fatal("dberror: querying [chan_comments] for [%s]: %s",
        ci->name, mysql_error((MYSQL *)&mysqldb));
  }

  if((res = mysql_store_result((MYSQL *)&mysqldb)) == NULL) {
    fatal("dberror: getting results from [chan_comments] for [%s]: %s",
        ci->name, mysql_error((MYSQL *)&mysqldb));
  }

  ci->commentcount = mysql_num_rows(res);

/*
  if(mysql_num_rows(res) != ci->commentcount) {
    mysql_free_result(res);
    fatal("dberror: [chan_comments] table has an invalid number or rows "
        "for [%s]!", ci->name);
  }
*/

  if((fields = mysql_num_fields(res)) < DB_COMMENT_FIELDS) {
    mysql_free_result(res);
    fatal("dberror: less than [%d] fields in table [chan_comments] "
        "for [%s]", DB_AUTOOP_FIELDS, ci->name);
  }

  ci->comment = scalloc(sizeof(ChannelComment), ci->commentcount);

  for( i = 0; (row = mysql_fetch_row(res)); i++) {
    ci->comment[i].ni = findnick(row[0]);
    copy_buffer(ci->comment[i].msg, row[1]);
    ci->comment[i].in_use = 1;
  }

  mysql_free_result(res);
  return;

}

static ChannelInfo *db_load_channel(char **crow) {
  ChannelInfo *ci;
  uint16 i = 0,
         n_levels;

  ci = scalloc(sizeof(ChannelInfo), 1);

  if (findchan(crow[0]))
    return(NULL);

  if (debug)
    log("debug: loading channel [%s]", crow[0]);

  copy_buffer(ci->name, crow[i++]);
  alpha_insert_chan(ci);

  if (crow[i])
    ci->founder = findnick(crow[i]);
  else
    ci->founder = NULL;

  i++;

  if (crow[i])
    ci->successor = findnick(crow[i]);
  else
    ci->successor = NULL;

  i++;

  count_chan(ci);
  copy_buffer(ci->founderpass, crow[i++]);
  copy_string(&ci->desc, crow[i++]);

  if (!ci->desc)
    ci->desc = sstrdup("");

  copy_string(&ci->url, crow[i++]);
  copy_string(&ci->email, crow[i++]);
  ci->time_registered = atol(crow[i++]);
  ci->last_used = atol(crow[i++]);
  copy_string(&ci->last_topic, crow[i++]);
  copy_buffer(ci->last_topic_setter, crow[i++]);
  ci->last_topic_time = atol(crow[i++]);
  ci->flags = atol(crow[i++]);

  if (strlen(crow[i]) > 0) {
    SuspendInfo *si = smalloc(sizeof(*si));
    copy_buffer(si->who, crow[i++]);
    copy_string(&si->reason, crow[i++]);
    si->suspended = atol(crow[i++]);
    si->expires = atol(crow[i++]);
    ci->suspendinfo = si;
  } else {
    ci->suspendinfo = NULL;
    i += 4;
  }

/* straight out of load_channel() */
#ifdef USE_ENCRYPTION
  if (!(ci->flags & (CI_ENCRYPTEDPW | CI_VERBOTEN))) {
     if (debug)
        log("debug: %s: encrypting password for %s on load",
            s_ChanServ, ci->name);
    if (encrypt_in_place(ci->founderpass, PASSMAX) < 0)
       fatal("%s: load database: Can't encrypt %s password!",
             s_ChanServ, ci->name);
    ci->flags |= CI_ENCRYPTEDPW;
    db_chan_set(ci, "founderpass", ci->founderpass);
    db_chan_seti(ci, "flags", ci->flags);
  }
#else
  if (ci->flags & CI_ENCRYPTEDPW) {
      /* Bail: it makes no sense to continue with encrypted
       * passwords, since we won't be able to verify them */
      fatal("%s: load database: password for %s encrypted "
            "but encryption disabled, aborting", s_ChanServ, ci->name);
  }
#endif

  n_levels = atoi(crow[i++]);
  
  
  reset_levels(ci);
  // db_load_levels(ci, n_levels);

  ci->accesscount = atoi(crow[i++]);
  if (ci->accesscount)
    db_load_access(ci);
  else
    ci->access = NULL;

  ci->akickcount = atoi(crow[i++]);
  if (ci->akickcount)
    db_load_akicks(ci);
  else
    ci->akick = NULL;

  ci->mlock_on = atol(crow[i++]);
  ci->mlock_off = atol(crow[i++]);
  ci->mlock_limit = atol(crow[i++]);
  copy_string(&ci->mlock_key, crow[i++]);
  ci->mlock_on &= ~CMODE_REG;  /* check_modes() takes care of this */

  ci->entrycount = atoi(crow[i++]);
  if (ci->entrycount)
    db_load_entrymsg(ci);
  else
    ci->entrymsg = NULL;

  ci->autoopcount = atoi(crow[i++]);
  if (ci->autoopcount)
    db_load_autoop(ci);
  else
    ci->autoop = NULL;

  ci->commentcount = atoi(crow[i++]);
  if (ci->commentcount)
    db_load_comments(ci);
  else
    ci->comment = NULL;

  ci->c = NULL;
  return ci;

}

void db_load_cs(void) {
  MYSQL_ROW crow;
  MYSQL_RES *cres;
  uint16 cfields;

  if((cres = db_request("SELECT * FROM channel WHERE 1>0")) == NULL)
    fatal("dberror: fatal db error during query");

  if(mysql_num_rows(cres) == 0) {
    /* create a blank channel list and continue some day */
    fatal("dberror: the channels database is empty!");
  }

  if((cfields = mysql_num_fields(cres)) < DB_CHAN_FIELDS) {
    fatal("dberror: the database has less than [%d] fields in table [channel]",
        DB_CHAN_FIELDS);
  }

  while((crow = mysql_fetch_row(cres)))
    db_load_channel(crow);
  

  mysql_free_result(cres);
  return;

}

void db_akick_del(char *chan, char *mask) {
  char e_mask[512],
       e_channame[CHANMAX*2+1];
  int16 r;

  if (db_escape_string(e_channame, chan, sizeof(e_channame)) == NULL)
    return;

  if (db_escape_string(e_mask, mask, sizeof(e_mask)) == NULL)
    return;

  if(db_queryf("DELETE FROM chan_akick WHERE channame='%s' && mask='%s'",
               e_channame, e_mask) != 0)
    return;

  if ((r = db_update_numbers(e_channame, "chan_akick")) < 0)
    return;

  db_update_count(DB_AKICK, chan, r);

/*
    if (r != ci->akickcount) {
      sprintf(tmp, "%d", r);
      db_simple_update("channel", "akickcount", tmp, "channame", e_channame);
      ci->akickcount = r;
    }
*/

}

void db_akick_add(ChannelInfo *ci, AutoKick *akick) {
  char e_channame[CHANMAX*2+1],
       e_who[NICKMAX*2+1],
       e_mask[512],
       e_reason[1024];
  int res;

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return;

  if (db_escape_string(e_who, akick->who, sizeof(e_who)) == NULL)
    return;

  if (db_escape_string(e_mask, akick->is_nick ? akick->u.ni->nick : 
                       akick->u.mask, sizeof(e_mask)) == NULL)
    return;

  if (db_escape_string(e_reason, akick->reason, sizeof(e_reason)) == NULL)
    return;

  db_queryf("INSERT INTO chan_akick VALUES ('%s','99999','%d','%s','%s','%s')",
            e_channame, akick->is_nick, e_mask, e_reason, e_who);

  if ((res = db_update_numbers(e_channame, "chan_akick")) < 0)
    return;

  db_update_count(DB_AKICK, ci->name, res);

}

void db_comment(ChannelInfo *ci, NickInfo *ni, char *comment) {
  char e_channame[CHANMAX*2+1],
       e_nickname[NICKMAX*2+1],
       e_comment[1024];
  int res;

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return;

  if (db_escape_string(e_nickname, ni->nick, sizeof(e_nickname)) == NULL)
    return;

  if (db_escape_string(e_comment, comment, sizeof(e_comment)) == NULL)
    return;

  if (db_queryf("DELETE FROM chan_comments WHERE channame='%s' && nick='%s' ",
                e_channame, e_nickname) != 0) 
    return;

  /* if this has an error lets still try to update the numbers */
  db_queryf("INSERT INTO chan_comments VALUES ('%s','99999','%s','%s')",
            e_channame, e_nickname, e_comment);

  if ((res = db_update_numbers(e_channame, "chan_comments")) < 0)
    return;

  db_update_count(DB_COMMENTS, ci->name, res);

}

void db_onjoin(ChannelInfo *ci, char *msg) {
  char e_channame[CHANMAX*2+1],
       e_msg[2048];
  int res;

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return;

  if (msg) {
    if (db_escape_string(e_msg, msg, sizeof(e_msg)) == NULL)
      return;

    db_queryf("INSERT INTO chan_entrymsg VALUES ('%s','99999','%s')",
              e_channame, e_msg);

    if ((res = db_update_numbers(e_channame, "chan_entrymsg")) < 0)
      return;

    db_update_count(DB_ENTRYMSG, ci->name, res);

  } else {
    db_queryf("DELETE FROM chan_entrymsg WHERE channame='%s'");
 
    db_update_count(DB_ENTRYMSG, ci->name, 0);
  }

}

void db_remove_autoop(ChannelInfo *ci, NickInfo *ni) {
  char e_channame[CHANMAX*2+1],
       e_nickname[NICKMAX*2+1];
  int res;

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return;

  if (db_escape_string(e_nickname, ni->nick, sizeof(e_nickname)) == NULL)
    return;

  db_queryf("DELETE FROM chan_autoop WHERE channame='%s' && nick='%s' ",
                e_channame, e_nickname);

  if ((res = db_update_numbers(e_channame, "chan_autoop")) < 0)
    return;

  db_update_count(DB_AUTOOP, ci->name, res);
}

void db_autoop(ChannelInfo *ci, NickInfo *ni, char param) {
  char e_channame[CHANMAX*2+1],
       e_nickname[NICKMAX*2+1];
  int res;

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return;

  if (db_escape_string(e_nickname, ni->nick, sizeof(e_nickname)) == NULL)
    return;

  if (db_queryf("DELETE FROM chan_autoop WHERE channame='%s' && nick='%s' ",
                e_channame, e_nickname) != 0)
    return;

  /* if this has an error lets still try to update the numbers */
  db_queryf("INSERT INTO chan_autoop VALUES ('%s','9999','%s','%c')",
            e_channame, e_nickname, param);

  if ((res = db_update_numbers(e_channame, "chan_autoop")) < 0) 
    return;

  db_update_count(DB_AUTOOP, ci->name, res);
}

void db_adduser(ChannelInfo *ci, NickInfo *ni, int level) {
  char e_channame[CHANMAX*2+1],
       e_nickname[NICKMAX*2+1];
  int res;

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return;

  if (db_escape_string(e_nickname, ni->nick, sizeof(e_nickname)) == NULL)
    return;

  db_queryf("DELETE FROM chan_access WHERE channame='%s' && nick='%s'",
            e_channame, e_nickname);

  db_queryf("INSERT INTO chan_access VALUES ('%s','9999','%d','%s')",
            e_channame, level, e_nickname);

  if ((res = db_update_numbers(e_channame, "chan_access")) < 0)
    return;

  db_chan_seti(ci, "accesscount", res);

}

void db_setpass(ChannelInfo *ci) {
  char e_channame[CHANMAX*2+1],
       e_passwd[PASSMAX*2+1];

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return;

  if (db_escape_string(e_passwd, ci->founderpass, sizeof(e_passwd)) == NULL)
    return;

  db_queryf("UPDATE channel SET founderpass='%s' WHERE channame='%s'",
            e_passwd, e_channame);

}

void db_founder(ChannelInfo *ci) {
  char e_channame[CHANMAX*2+1],
       e_founder[NICKMAX*2+1];

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return;

  if (db_escape_string(e_founder, ci->founder->nick, sizeof(e_founder)) == NULL)
    return;

  db_queryf("UPDATE channel SET foundernick='%s' WHERE channame='%s'",
            e_founder, e_channame);

}

void db_successor(ChannelInfo *ci) {
  char e_channame[CHANMAX*2+1],
       e_successor[NICKMAX*2+1];

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return;

  if (ci->successor) {
    if (db_escape_string(e_successor, ci->successor->nick, sizeof(e_successor)) 
        == NULL)
    return;
  } else
    strcpy(e_successor, "");

  db_queryf("UPDATE channel SET successornick='%s' WHERE channame='%s'",
            e_successor, e_channame);

}

void db_suspend(ChannelInfo *ci) {
  char e_channame[CHANMAX*2+1],
       e_who[NICKMAX*2+1],
       e_reason[1024];

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return;

  if (db_escape_string(e_who, ci->suspendinfo->who, sizeof(e_who)) == NULL)
    return;

  if (db_escape_string(e_reason, ci->suspendinfo->reason, sizeof(e_reason)) 
      == NULL)
    return;

  db_queryf("UPDATE channel SET swho='%s', sreason='%s', stime='%d', "
            "sexpire='%d' WHERE channame='%s'",
            e_who, e_reason, ci->suspendinfo->expires, 
            ci->suspendinfo->suspended, e_channame);
 
}

void db_unsuspend(ChannelInfo *ci) {
  char e_channame[CHANMAX*2+1];

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return;

  db_queryf("UPDATE channel SET swho='', sreason='', stime='', "
            "sexpire='' WHERE channame='%s'", e_channame);

}

void db_update_lastused(ChannelInfo *ci) {
  char e_channame[CHANMAX*2+1];

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return;

  db_queryf("UPDATE channel SET last_used='%d' WHERE channame='%s'", 
            ci->last_used, e_channame);

}

void db_topic(ChannelInfo *ci) {
  char e_channame[NICKMAX*2+1],
       e_who[NICKMAX*2+1],
       e_topic[2048];

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return;

  if (db_escape_string(e_who, ci->last_topic_setter, sizeof(e_who)) == NULL)
    return;

  if (db_escape_string(e_topic, ci->last_topic, sizeof(e_topic)) == NULL)
    return;

  db_queryf("UPDATE channel SET last_topic='%s', last_topic_setter='%s', "
            "last_topic_time='%d' WHERE channame='%s'", e_topic, e_who,
            ci->last_topic_time, e_channame);

}

void db_email(ChannelInfo *ci) {
  char e_channame[CHANMAX*2+1],
       e_email[1024];

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return;

  if (ci->email) {
    if (db_escape_string(e_email, ci->email, sizeof(e_email)) == NULL)
      return;
  } else
    strcpy(e_email, "");

  db_queryf("UPDATE channel SET email='%s' WHERE channame='%s'",
            e_email, e_channame);

}

void db_mlock(ChannelInfo *ci) {
  char e_channame[CHANMAX*2+1],
       e_key[1024];

  if (db_escape_string(e_channame, ci->name, sizeof(e_channame)) == NULL)
    return;

  if (ci->mlock_key) {
    if (db_escape_string(e_key, ci->mlock_key, sizeof(e_key)) == NULL)
      return;
  } else
    strcpy(e_key, "");

  db_queryf("UPDATE channel SET mlock_on='%d', mlock_off='%d', "
            "mlock_limit='%d', mlock_key='%s' WHERE channame='%s'",
            ci->mlock_on, ci->mlock_off, ci->mlock_limit, e_key, e_channame);

}

int db_update_count(int column, char *channame, uint32 count) {
  char dbtable[][32] = {
    "commentcount",
    "akickcount",
    "n_levels",
    "autoopcount",
    "accesscount",
    "entrycount",
    "accesscount"    /* hacked */
  },
    e_channame[CHANMAX*2+1];

  if (db_escape_string(e_channame, channame, sizeof(e_channame)) == NULL)
    return(-1);

  return(db_queryf("UPDATE %s SET %s='%d' WHERE channame='%s'", 
                   (column > 5) ? "nick" : "channel",
                   dbtable[column], count, e_channame));

}

MYSQL_RES *db_request(const char *query_fmt, ...) {
  MYSQL_RES *mres;
  int res;
  char query[4096];
  va_list ap;

  va_start(ap, query_fmt);
  vsnprintf(query, sizeof(query) - 1, query_fmt, ap);
  va_end(ap);

  if((res = db_query(query)) != 0)
    return(NULL);

  if((mres = mysql_store_result((MYSQL *)&mysqldb)) == NULL) {
    if(debug)
      log("dberror: could not store db results during query [%s]: %s\n", query, 
          mysql_error((MYSQL *)&mysqldb));
    return(NULL); 
  }

  return(mres);

}

int db_queryf(const char *query_fmt, ...) {
  char query[2048]; 
  va_list ap;

  va_start(ap, query_fmt);
  vsnprintf(query, sizeof(query) - 1, query_fmt, ap);
  va_end(ap);

  return(db_query(query));
}

int db_query(char *query) {
  int res;

  if (debug > 2)
    log("debug: dbquery \"%s\"", query);

  if((res = mysql_real_query((MYSQL *)&mysqldb, query, strlen(query))) != 0) {

    switch(res) {

      case CR_COMMANDS_OUT_OF_SYNC:
        log("dberror: Commands were executed in an improper order: %s\n", query);
        break;

      case CR_SERVER_GONE_ERROR:
        log("dberror: The MySQL server has gone away\n");
        db_connect(0);
        break;

      case CR_SERVER_LOST:
        log("dberror: The connection to the server was lost during the query\n");
        db_connect(0);
        break;

      case CR_UNKNOWN_ERROR:
        log("dberror: An unknown error occurred: %s\n", query);
        break;

      default:
        log("dberror: there was an unknown error [%d] during the query: %s\n",
            res, query);
        break;

    }

  }

  return(res);

}

/*************************************************************************/

#define DB_NICK_FIELDS 22
#define DB_NICK_ACCESS 1

void db_nick_seti(NickInfo *ni, char *field, int value) {
  char e_nickname[NICKMAX*2+1];

  if (db_escape_string(e_nickname, ni->nick, sizeof(e_nickname)) == NULL)
    return;

  db_queryf("UPDATE nick SET %s='%d' WHERE channame='%s'", field, value,
            e_nickname);

}

void db_nick_set(NickInfo *ni, char *field, char *value) {
  char e_nickname[NICKMAX*2+1],
       e_value[2048];

  if (db_escape_string(e_nickname, ni->nick, sizeof(e_nickname)) == NULL)
    return;

  if (value) {
    if (db_escape_string(e_value, value, sizeof(e_value)) == NULL)
      return;
  } else
    strcpy(e_value, "");

  db_queryf("UPDATE nick SET %s='%s' WHERE channame='%s'", field, e_value, 
            e_nickname);

}

void db_nick_suspend(NickInfo *ni) {
  char e_nickname[NICKMAX*2+1],
       e_swho[NICKMAX*2+1],
       e_sreason[1024];

  if (db_escape_string(e_nickname, ni->nick, sizeof(e_nickname)) == NULL)
    return;

  if (db_escape_string(e_swho, ni->suspendinfo->who, sizeof(e_swho)) == NULL)
    return;

  if (db_escape_string(e_sreason, ni->suspendinfo->reason, sizeof(e_sreason)) == NULL)
    return;

  db_queryf("UPDATE nick SET swho='%s', sreason='%s', stime='%d', sexpires='%d'"
            "WHERE channame='%s'", e_swho, e_sreason, ni->suspendinfo->suspended,
            ni->suspendinfo->expires, e_nickname);

}

void db_nick_unsuspend(NickInfo *ni) {
  char e_nickname[NICKMAX*2+1];

  if (db_escape_string(e_nickname, ni->nick, sizeof(e_nickname)) == NULL)
    return;

  db_queryf("UPDATE nick SET swho='', sreason='', stime=0, sexpires=0 "
            "WHERE channame='%s'", e_nickname);

}

void db_nick_delete(NickInfo *ni) {
  char e_nickname[NICKMAX*2+1];

  if (db_escape_string(e_nickname, ni->nick, sizeof(e_nickname)) == NULL)
    return;

  db_queryf("DELETE FROM nick WHERE channame='%s'", e_nickname);
  db_queryf("DELETE FROM nick_access WHERE channame='%s'", e_nickname);

}

void db_load_nickaccess(NickInfo *ni) {
  MYSQL_ROW row;
  MYSQL_RES *res;
  char e_nickname[NICKMAX*2+1],
       **access;
  uint16 fields, i;

  if (db_escape_string(e_nickname, ni->nick, sizeof(e_nickname)) == NULL)
    fatal("error: could not escape string [%s]", ni->nick);

  if ((res = db_request("SELECT access FROM nick_access WHERE channame='%s' "
                        "ORDER BY number", e_nickname)) == NULL)
    fatal("dberror: querying [nick_access]  for [%s]", ni->nick);

  if(mysql_num_rows(res) != ni->accesscount) {
    mysql_free_result(res);
    fatal("dberror: [nick_access] table has an invalid number or rows "
        "for [%s]!", ni->nick);
  }

  if((fields = mysql_num_fields(res)) < DB_NICK_ACCESS) {
    mysql_free_result(res);
    fatal("dberror: less than [%d] fields in table [nick_access] "
        "for [%s]", DB_NICK_ACCESS, ni->nick);
  }

  access = smalloc(sizeof(char *) * ni->accesscount);
  ni->access = access;

  for( i = 0; (row = mysql_fetch_row(res)); i++, access++)
    copy_string(access, row[0]);

  mysql_free_result(res); 
  return;

}

static NickInfo *db_load_nick(char **crow) {
  NickInfo *ni;
  uint16 i = 0;

  ni = scalloc(sizeof(NickInfo), 1);

  if (findnick(crow[0]))
    return(NULL);

  if (debug)
    log("debug: loading nick [%s]", crow[0]);

  copy_buffer(ni->nick, crow[i++]);
  alpha_insert_nick(ni);
  copy_buffer(ni->pass, crow[i++]);
  copy_string(&ni->url, crow[i++]);
  copy_string(&ni->email, crow[i++]);

  copy_string(&ni->last_usermask, crow[i++]);
  if (!ni->last_usermask)
    ni->last_usermask = sstrdup("@");

  copy_string(&ni->last_realname, crow[i++]);
  if (!ni->last_realname)
    ni->last_realname = sstrdup("");

  copy_string(&ni->last_quit, crow[i++]);
  ni->time_registered = atol(crow[i++]);
  ni->last_seen = atol(crow[i++]);
  ni->status = atol(crow[i++]);
  ni->status &= ~NS_TEMPORARY;

#ifdef USE_ENCRYPTION
  if (!(ni->status & (NS_ENCRYPTEDPW | NS_VERBOTEN))) {
    if (debug)
      log("debug: %s: encrypting password for `%s' on load",
          s_NickServ, ni->nick);
      if (encrypt_in_place(ni->pass, PASSMAX) < 0)
        fatal("%s: Can't encrypt `%s' nickname password!",
              s_NickServ, ni->nick);
      ni->status |= NS_ENCRYPTEDPW;
      db_nick_set(ni, "pass", ni->pass);
      db_nick_seti(ni, "status", ni->status);
  }
#else
  if (ni->status & NS_ENCRYPTEDPW) {
    /* Bail: it makes no sense to continue with encrypted
     * passwords, since we won't be able to verify them */
    fatal("%s: load database: password for %s encrypted "
          "but encryption disabled, aborting",
          s_NickServ, ni->nick);
  }
#endif

  copy_string((char **)&ni->link, crow[i++]);
  ni->linkcount = atol(crow[i++]);
  i++;
  ni->flags = atol(crow[i++]);
  ni->flags &= ~NI_KILL_IMMED;

  if (strlen(crow[i]) > 0) {
    SuspendInfo *si = smalloc(sizeof(*si));
    copy_buffer(si->who, crow[i++]);
    copy_string(&si->reason, crow[i++]);
    si->suspended = atol(crow[i++]);
    si->expires = atol(crow[i++]);
    ni->suspendinfo = si;
  } else {
    ni->suspendinfo = NULL;
    i += 4;
  }

  ni->accesscount = atol(crow[i++]);
  if (ni->accesscount)
    db_load_nickaccess(ni);
  else
    ni->access = NULL;

  ni->channelcount = atol(crow[i++]);
  ni->channelmax = atol(crow[i++]);
  ni->language = atol(crow[i++]);

  if (!langtexts[ni->language])
    ni->language = DEF_LANGUAGE;

  /* Link and channel counts are recalculated later */
  ni->linkcount = 0;
  ni->channelcount = 0;
  ni->historycount = 0;
  return(ni);

}

void db_load_ns(void) {
  MYSQL_ROW crow;
  MYSQL_RES *cres;
  uint16 cfields;
  NickInfo *ni;

  if((cres = db_request("SELECT * FROM nick WHERE 1>0")) == NULL)
    fatal("dberror: fatal db error during query");

  if(mysql_num_rows(cres) == 0) {
    /* create a blank nick list and continue some day */
    fatal("dberror: the nick database is empty!");
  }

  if((cfields = mysql_num_fields(cres)) < DB_NICK_FIELDS) {
    fatal("dberror: the database has less than [%d] fields in table [nick]",
        DB_NICK_FIELDS);
  }

  while((crow = mysql_fetch_row(cres)))
    db_load_nick(crow);

  mysql_free_result(cres);

  /* Now resolve links */
  for (ni = firstnick(); ni; ni = nextnick()) {
    if (ni->link) {
      char *s = (char *)ni->link;
      ni->link = findnick(s);
      free(s);
      if (ni->link)
        ni->link->linkcount++;
    }
  }

  return;

}

void db_add_access(NickInfo *ni, char *access) {
  char e_nickname[NICKMAX*2+1],
       e_access[1024];
  int res;

  if (db_escape_string(e_nickname, ni->nick, sizeof(e_nickname)) == NULL)
    return;

  if (db_escape_string(e_access, access, sizeof(e_access)) == NULL)
    return;

  db_queryf("INSERT INTO nick_access VALUES ('%s','9999','%s')",
            e_nickname, e_access);

  if ((res = db_update_numbers(e_nickname, "nick_access")) < 0)
    return;

  db_update_count(DB_NICKACCESS, ni->nick, res);

}

int db_add_nick(NickInfo *ni) {
  char e_nick[NICKMAX*2+1],
       e_pass[PASSMAX*2+1],
       e_email[512],
       e_url[512],
       e_lastusermask[512],
       e_lastrealname[128],
       e_lastquit[1024],
       e_linknick[NICKMAX*2+1],
       e_swho[NICKMAX*2+1],
       e_sreason[1024];
  int i, res;

  if (debug)
    log("db_add_nick() adding nick [%s]", ni->nick);

  for( i = 0; i < ni->accesscount; i++) 
    db_add_access(ni, ni->access[i]);

  if (db_escape_string(e_nick, ni->nick, sizeof(e_nick)) == NULL)
    return(0);

  if (db_escape_string(e_pass, ni->pass, sizeof(e_pass)) == NULL)
    return(0);

  db_escape_string(e_email, ni->email, sizeof(e_email));
  db_escape_string(e_url, ni->url, sizeof(e_url));
  db_escape_string(e_lastusermask, ni->last_usermask, sizeof(e_lastusermask));
  db_escape_string(e_lastrealname, ni->last_realname, sizeof(e_lastrealname));
  db_escape_string(e_lastquit, ni->last_quit, sizeof(e_lastquit));

  if (ni->link) 
    db_escape_string(e_linknick, ni->link->nick, sizeof(e_linknick));

  if (ni->suspendinfo) {
    db_escape_string(e_swho, ni->suspendinfo->who, sizeof(e_swho));
    db_escape_string(e_sreason, ni->suspendinfo->reason, sizeof(e_sreason));
  }

  res = db_queryf("INSERT INTO nick VALUES ('%s','%s','%s','%s','%s','%s'"
            ",'%s','%d','%d','%d','%s','%d','%d','%d','%s','%s','%d'"
            ",'%d','%d','%d','%d','%d')",
            e_nick,
            e_pass,
            e_url,
            e_email,
            e_lastusermask,
            e_lastrealname,
            e_lastquit,
            ni->time_registered,
            ni->last_seen,
            ni->status,
            ni->link ? e_linknick : "",
            ni->link ? ni->linkcount : 0,
            ni->link ? ni->channelcount : 0,
            ni->flags,
            ni->suspendinfo ? e_swho : "",
            ni->suspendinfo ? e_sreason : "",
            ni->suspendinfo ? ni->suspendinfo->suspended : 0,
            ni->suspendinfo ? ni->suspendinfo->expires : 0,
            ni->accesscount,
            ni->channelcount,
            ni->channelmax,
            ni->language
  );

  if (res) {
    log("dberror: adding nick [%s]", ni->nick);
    return(DB_ERROR);
  }

  return(1);

}

#endif

