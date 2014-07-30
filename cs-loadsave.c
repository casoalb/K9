/* Routines to load/save ChanServ data files.
**
** Chatnet K9 Channel Services
** Based on ircdservices ver. by Andy Church
** Parts copyright (c) 1999-2000 Andrew Kempe and others.
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

/*************************************************************************/
/*************************************************************************/

/* Load v1-v4 files. */

#define SAFE(x) do {					\
    if ((x) < 0) {					\
	if (!forceload)					\
	    fatal("Read error on %s", ChanDBName);	\
	failed = 1;					\
	break;						\
    }							\
} while (0)

static void load_old_cs_dbase(dbFILE *f, int ver)
{
    int i, j, c;
    ChannelInfo *ci, **last, *prev;
    int failed = 0;

    struct {
	short level;
#ifdef COMPATIBILITY_V2
	short is_nick;
#else
	short in_use;
#endif
	char *name;
    } old_chanaccess;

    struct {
	short is_nick;
	short pad;
	char *name;
	char *reason;
    } old_autokick;

    struct {
	ChannelInfo *next, *prev;
	char name[CHANMAX];
	char founder[NICKMAX];
	char founderpass[PASSMAX];
	char *desc;
	time_t time_registered;
	time_t last_used;
	long accesscount;
	ChanAccess *access;
	long akickcount;
	AutoKick *akick;
	short mlock_on, mlock_off;
	long mlock_limit;
	char *mlock_key;
	char *last_topic;
	char last_topic_setter[NICKMAX];
	time_t last_topic_time;
	long flags;
	short *levels;
	char *url;
	char *email;
	struct channel_ *c;
    } old_channelinfo;


    for (i = 33; i < 256 && !failed; i++) {

	last = &chanlists[i];
	prev = NULL;
	while ((c = getc_db(f)) != 0) {
	    if (c != 1)
		fatal("Invalid format in %s", ChanDBName);
	    SAFE(read_variable(old_channelinfo, f));
	    if (debug >= 3)
		log("debug: load_old_cs_dbase: read channel %s",
			old_channelinfo.name);
	    ci = scalloc(sizeof(ChannelInfo), 1);
	    strscpy(ci->name, old_channelinfo.name, CHANMAX);
	    ci->founder = findnick(old_channelinfo.founder);
	    count_chan(ci);
	    strscpy(ci->founderpass, old_channelinfo.founderpass, PASSMAX);
	    ci->time_registered = old_channelinfo.time_registered;
	    ci->last_used = old_channelinfo.last_used;
	    ci->accesscount = old_channelinfo.accesscount;
	    ci->akickcount = old_channelinfo.akickcount;
	    ci->mlock_on = old_channelinfo.mlock_on;
	    ci->mlock_off = old_channelinfo.mlock_off;
	    ci->mlock_limit = old_channelinfo.mlock_limit;
	    strscpy(ci->last_topic_setter,
			old_channelinfo.last_topic_setter, NICKMAX);
	    ci->last_topic_time = old_channelinfo.last_topic_time;
#ifdef USE_ENCRYPTION
	    if (!(ci->flags & (CI_ENCRYPTEDPW | CI_VERBOTEN))) {
		if (debug)
		    log("debug: %s: encrypting password for %s on load",
				s_ChanServ, ci->name);
		if (encrypt_in_place(ci->founderpass, PASSMAX) < 0)
		    fatal("%s: load database: Can't encrypt %s password!",
				s_ChanServ, ci->name);
		ci->flags |= CI_ENCRYPTEDPW;
	    }
#else
	    if (ci->flags & CI_ENCRYPTEDPW) {
		/* Bail: it makes no sense to continue with encrypted
		 * passwords, since we won't be able to verify them */
		fatal("%s: load database: password for %s encrypted "
		          "but encryption disabled, aborting",
		          s_ChanServ, ci->name);
	    }
#endif
	    SAFE(read_string(&ci->desc, f));
	    if (!ci->desc)
		ci->desc = sstrdup("");
	    if (old_channelinfo.url)
		SAFE(read_string(&ci->url, f));
	    if (old_channelinfo.email)
		SAFE(read_string(&ci->email, f));
	    if (old_channelinfo.mlock_key)
		SAFE(read_string(&ci->mlock_key, f));
	    if (old_channelinfo.last_topic)
		SAFE(read_string(&ci->last_topic, f));

	    if (ci->accesscount) {
		ChanAccess *access;
		char *s;

		access = smalloc(sizeof(ChanAccess) * ci->accesscount);
		ci->access = access;
		for (j = 0; j < ci->accesscount; j++, access++) {
		    SAFE(read_variable(old_chanaccess, f));
#ifdef COMPATIBILITY_V2
		    if (old_chanaccess.is_nick < 0)
			access->in_use = 0;
		    else
			access->in_use = old_chanaccess.is_nick;
#else
		    access->in_use = old_chanaccess.in_use;
#endif
		    access->level = old_chanaccess.level;
		}
		access = ci->access;
		for (j = 0; j < ci->accesscount; j++, access++) {
		    SAFE(read_string(&s, f));
		    if (s && access->in_use)
			access->ni = findnick(s);
		    else
			access->ni = NULL;
		    if (s)
			free(s);
		    if (access->ni == NULL)
			access->in_use = 0;
		}
	    } else {
		ci->access = NULL;
	    } /* if (ci->accesscount) */

	    if (ci->akickcount) {
		AutoKick *akick;
		char *s;

		akick = smalloc(sizeof(AutoKick) * ci->akickcount);
		ci->akick = akick;
		for (j = 0; j < ci->akickcount; j++, akick++) {
		    SAFE(read_variable(old_autokick, f));
		    if (old_autokick.is_nick < 0) {
			akick->in_use = 0;
			akick->is_nick = 0;
		    } else {
			akick->in_use = 1;
			akick->is_nick = old_autokick.is_nick;
		    }
		    akick->reason = old_autokick.reason;
		}
		akick = ci->akick;
		for (j = 0; j < ci->akickcount; j++, akick++) {
		    SAFE(read_string(&s, f));
		    if (akick->is_nick) {
			if (!(akick->u.ni = findnick(s)))
			    akick->in_use = akick->is_nick = 0;
			free(s);
		    } else {
			if (!(akick->u.mask = s))
			    akick->in_use = 0;
		    }
		    if (akick->reason)
			SAFE(read_string(&akick->reason, f));
		    if (!akick->in_use) {
			if (akick->is_nick) {
			    akick->u.ni = NULL;
			} else {
			    free(akick->u.mask);
			    akick->u.mask = NULL;
			}
			if (akick->reason) {
			    free(akick->reason);
			    akick->reason = NULL;
			}
		    }
		}
	    } else {
		ci->akick = NULL;
	    } /* if (ci->akickcount) */

	    if (old_channelinfo.levels) {
		int16 n_entries;
		ci->levels = NULL;
		reset_levels(ci);
		SAFE(read_int16(&n_entries, f));
#ifdef COMPATIBILITY_V2
		/* Ignore earlier, incompatible levels list */
		if (n_entries == 6) {
		    fseek(f, sizeof(short) * n_entries, SEEK_CUR);
		} else
#endif
		for (j = 0; j < n_entries; j++) {
		    short lev;
		    SAFE(read_variable(lev, f));
		    if (j < CA_SIZE)
			ci->levels[j] = lev;
		}
	    } else {
	    
		reset_levels(ci);
	    }

	    *last = ci;
	    last = &ci->next;
	    ci->prev = prev;
	    prev = ci;

	} /* while (getc_db(f) != 0) */

	*last = NULL;

    } /* for (i) */
}

#undef SAFE

/*************************************************************************/

#define SAFE(x) do {					\
    if ((x) < 0) {					\
	if (!forceload)					\
	    fatal("Read error on %s", ChanDBName);	\
	return NULL;					\
    }							\
} while (0)

static ChannelInfo *load_channel(dbFILE *f, int ver)
{
    ChannelInfo *ci;
    int16 tmp16;
    int32 tmp32;
    int n_levels;
    char *s;
    int i;

    ci = scalloc(sizeof(ChannelInfo), 1);
    SAFE(read_buffer(ci->name, f));
    alpha_insert_chan(ci);
    SAFE(read_string(&s, f));
    if (s) {
	ci->founder = findnick(s);
	free(s);
    } else {
	ci->founder = NULL;
    }
    if (ver >= 7) {
	SAFE(read_string(&s, f));
	if (s) {
	    ci->successor = findnick(s);
	    free(s);
	} else {
	    ci->successor = NULL;
	}
	/* Founder could be successor, which is bad, in vers 7,8 */
	if (ci->founder == ci->successor)
	    ci->successor = NULL;
    } else {
	ci->successor = NULL;
    }
    count_chan(ci);
    SAFE(read_buffer(ci->founderpass, f));
    SAFE(read_string(&ci->desc, f));
    if (!ci->desc)
	ci->desc = sstrdup("");
    SAFE(read_string(&ci->url, f));
    SAFE(read_string(&ci->email, f));
    SAFE(read_int32(&tmp32, f));
    ci->time_registered = tmp32;
    SAFE(read_int32(&tmp32, f));
    ci->last_used = tmp32;
    SAFE(read_string(&ci->last_topic, f));
    SAFE(read_buffer(ci->last_topic_setter, f));
    SAFE(read_int32(&tmp32, f));
    ci->last_topic_time = tmp32;
    SAFE(read_int32(&ci->flags, f));
    if (ver >= 9)
	SAFE(read_ptr((void **)&ci->suspendinfo, f));
    if (ci->suspendinfo) {
	SuspendInfo *si = smalloc(sizeof(*si));
	SAFE(read_buffer(si->who, f));
	SAFE(read_string(&si->reason, f));
	SAFE(read_int32(&tmp32, f));
	si->suspended = tmp32;
	SAFE(read_int32(&tmp32, f));
	si->expires = tmp32;
	ci->suspendinfo = si;
    }
#ifdef USE_ENCRYPTION
    if (!(ci->flags & (CI_ENCRYPTEDPW | CI_VERBOTEN))) {
	if (debug)
	    log("debug: %s: encrypting password for %s on load",
		s_ChanServ, ci->name);
	if (encrypt_in_place(ci->founderpass, PASSMAX) < 0)
	    fatal("%s: load database: Can't encrypt %s password!",
		  s_ChanServ, ci->name);
	ci->flags |= CI_ENCRYPTEDPW;
    }
#else
    if (ci->flags & CI_ENCRYPTEDPW) {
	/* Bail: it makes no sense to continue with encrypted
	 * passwords, since we won't be able to verify them */
	fatal("%s: load database: password for %s encrypted "
	      "but encryption disabled, aborting",
	      s_ChanServ, ci->name);
    }
#endif
    SAFE(read_int16(&tmp16, f));
    n_levels = tmp16;  
    reset_levels(ci);

    for (i = 0; i < n_levels; i++) {
	if (i < CA_SIZE)
	    SAFE(read_int16(&ci->levels[i], f));
	else
	    SAFE(read_int16(&tmp16, f));
    }

    SAFE(read_int16(&ci->accesscount, f));
    if (ci->accesscount) {
	ci->access = scalloc(sizeof(ChanAccess), ci->accesscount);
	for (i = 0; i < ci->accesscount; i++) {
	    SAFE(read_int16(&ci->access[i].in_use, f));
	    if (ci->access[i].in_use) {
		SAFE(read_int16(&ci->access[i].level, f));
		SAFE(read_string(&s, f));
		if (s) {
		    ci->access[i].ni = findnick(s);
		    free(s);
		}
		if (ci->access[i].ni == NULL)
		    ci->access[i].in_use = 0;
	    }
	}
    } else {
	ci->access = NULL;
    }

    SAFE(read_int16(&ci->akickcount, f));
    if (ci->akickcount) {
	ci->akick = scalloc(sizeof(AutoKick), ci->akickcount);
	for (i = 0; i < ci->akickcount; i++) {
	    SAFE(read_int16(&ci->akick[i].in_use, f));
	    if (ci->akick[i].in_use) {
		SAFE(read_int16(&ci->akick[i].is_nick, f));
		SAFE(read_string(&s, f));
		if (ci->akick[i].is_nick) {
		    ci->akick[i].u.ni = findnick(s);
		    if (!ci->akick[i].u.ni)
			ci->akick[i].in_use = 0;
		    free(s);
		} else {
		    ci->akick[i].u.mask = s;
		}
		SAFE(read_string(&s, f));
		if (ci->akick[i].in_use)
		    ci->akick[i].reason = s;
		else if (s)
		    free(s);
		if (ver >= 8)
		    SAFE(read_buffer(ci->akick[i].who, f));
		else
		    ci->akick[i].who[0] = '\0';
	    }
	}
    } else {
	ci->akick = NULL;
    }

    if (ver < 10) {
	SAFE(read_int16(&tmp16, f));
	ci->mlock_on = tmp16;
	SAFE(read_int16(&tmp16, f));
	ci->mlock_off = tmp16;
    } else {
	SAFE(read_int32(&ci->mlock_on, f));
	SAFE(read_int32(&ci->mlock_off, f));
    }
    SAFE(read_int32(&ci->mlock_limit, f));
    SAFE(read_string(&ci->mlock_key, f));
    ci->mlock_on &= ~CMODE_REG;  /* check_modes() takes care of this */

    SAFE(read_int16(&ci->entrycount, f));
    if (ci->entrycount)
    {
        char **greet;
        greet = smalloc(sizeof(char *) * ci->entrycount);
        ci->entrymsg = greet;
        for (i = 0; i < ci->entrycount; i++, greet++)
            SAFE(read_string(greet, f));
    }
							    

    SAFE(read_int16(&ci->autoopcount, f));
    if (ci->autoopcount)
    {
        ci->autoop = scalloc(sizeof(ChannelAutoop), ci->autoopcount);
        for (i = 0; i < ci->autoopcount; i++)
        {
            SAFE(read_int16(&ci->autoop[i].in_use, f));
            if (ci->autoop[i].in_use)
            {
                SAFE(read_string(&s, f));
                if (s)
                {
                    ci->autoop[i].ni = findnick(s);
                    free(s);
                }
	        SAFE(read_variable(ci->autoop[i].flag, f));

	        if (ci->autoop[i].ni == NULL)
	            ci->access[i].in_use = 0;
            }
        }
    } else {
        ci->autoop = NULL;
    }


    SAFE(read_int16(&ci->commentcount, f));
    if (ci->commentcount)
    {
        ci->comment = scalloc(sizeof(ChannelComment), ci->commentcount);
        for (i = 0; i < ci->commentcount; i++)
        {
            SAFE(read_int16(&ci->comment[i].in_use, f));
            if (ci->comment[i].in_use)
            {
                SAFE(read_string(&s, f));
                if (s)
                {
                    ci->comment[i].ni = findnick(s);
                    free(s);
                }
                SAFE(read_buffer(ci->comment[i].msg, f));

                if (ci->comment[i].ni == NULL)
                    ci->access[i].in_use = 0;
            }
        }
    } else {
        ci->comment = NULL;
    }


    ci->c = NULL;

    return ci;
}

#undef SAFE

/*************************************************************************/

void load_cs_dbase(void)
{
    dbFILE *f;
    int ver, i, c;
    ChannelInfo *ci;
    int failed = 0;

    if (!(f = open_db(s_ChanServ, ChanDBName, "r")))
	return;

    switch (ver = get_file_version(f)) {
      case 13:
      case 12:
      case 11:
      case 10:
      case 9:
      case 8:
      case 7:
      case 6:
      case 5:
	for (i = 0; i < 256 && !failed; i++) {
	    while ((c = getc_db(f)) != 0) {
		if (c != 1)
		    fatal("Invalid format in %s", ChanDBName);
		ci = load_channel(f, ver);
		if (!ci) {
		    failed = 1;
		    break;
		}
		/* Delete non-forbidden channels with no founder.  These
		 * can crop up if the nick and channel databases get out
		 * of sync and the founder's nick has disappeared.  Note
		 * that we ignore the successor here, but since this
		 * shouldn't happen normally, no big deal.
		 */
		if (!(ci->flags & CI_VERBOTEN) && !ci->founder) {
		    log("%s: database load: Deleting founderless channel %s",
			s_ChanServ, ci->name);
		    delchan(ci);
		    continue;
		}
	    }
	}
	break;

      case 4:
      case 3:
      case 2:
      case 1:
	load_old_cs_dbase(f, ver);
	for (i = 0; i < 256; i++) {
	    ChannelInfo *next;
	    for (ci = chanlists[i]; ci; ci = next) {
		next = ci->next;
		if (!(ci->flags & CI_VERBOTEN) && !ci->founder) {
		    log("%s: database load: Deleting founderless channel %s",
			s_ChanServ, ci->name);
		    delchan(ci);
		}
	    }
	}
	break;

      case -1:
	fatal("Unable to read version number from %s", ChanDBName);

      default:
	fatal("Unsupported version number (%d) on %s", ver, ChanDBName);

    } /* switch (version) */

    close_db(f);

}

#undef SAFE

/*************************************************************************/
/*************************************************************************/

#define SAFE(x) do { if ((x) < 0) goto fail; } while (0)

void save_cs_dbase(void)
{
    dbFILE *f;
    int i, j;
    int16 tmp16;
    ChannelInfo *ci;
    static time_t lastwarn = 0;

    if (!(f = open_db(s_ChanServ, ChanDBName, "w")))
	return;

    for (ci = cs_firstchan(); ci; ci = cs_nextchan()) {
        SAFE(write_int8(1, f));
        if (debug >= 3)
        {
            log("Saving channel %s\n", ci->name);
        }
	SAFE(write_buffer(ci->name, f));
	if (ci->founder)
	    SAFE(write_string(ci->founder->nick, f));
	else
	    SAFE(write_string(NULL, f));
	if (ci->successor)
	    SAFE(write_string(ci->successor->nick, f));
	else
	    SAFE(write_string(NULL, f));
	SAFE(write_buffer(ci->founderpass, f));
	SAFE(write_string(ci->desc, f));
	SAFE(write_string(ci->url, f));
	SAFE(write_string(ci->email, f));
	SAFE(write_int32(ci->time_registered, f));
	SAFE(write_int32(ci->last_used, f));
	SAFE(write_string(ci->last_topic, f));
	SAFE(write_buffer(ci->last_topic_setter, f));
	SAFE(write_int32(ci->last_topic_time, f));
	SAFE(write_int32(ci->flags, f));
	SAFE(write_ptr(ci->suspendinfo, f));
	if (ci->suspendinfo) {
	    SAFE(write_buffer(ci->suspendinfo->who, f));
	    SAFE(write_string(ci->suspendinfo->reason, f));
	    SAFE(write_int32(ci->suspendinfo->suspended, f));
	    SAFE(write_int32(ci->suspendinfo->expires, f));
	}

	tmp16 = CA_SIZE;
	SAFE(write_int16(tmp16, f));
	for (i = 0; i < CA_SIZE; i++)
	    SAFE(write_int16(ci->levels[i], f));

	SAFE(write_int16(ci->accesscount, f));
	for (i = 0; i < ci->accesscount; i++) 
	{
	    if(ci->access[i].ni == NULL)
		continue;

	    SAFE(write_int16(ci->access[i].in_use, f));
	    if (ci->access[i].in_use) {
		SAFE(write_int16(ci->access[i].level, f));
		SAFE(write_string(ci->access[i].ni->nick, f));
	    }
	}

	SAFE(write_int16(ci->akickcount, f));
	for (i = 0; i < ci->akickcount; i++) 
	{
	    SAFE(write_int16(ci->akick[i].in_use, f));
	    if (ci->akick[i].in_use) {
		SAFE(write_int16(ci->akick[i].is_nick, f));
		if (ci->akick[i].is_nick)
		    SAFE(write_string(ci->akick[i].u.ni->nick, f));
		else
		    SAFE(write_string(ci->akick[i].u.mask, f));
		SAFE(write_string(ci->akick[i].reason, f));
		SAFE(write_buffer(ci->akick[i].who, f));
	    }
	}

	SAFE(write_int32(ci->mlock_on, f));
	SAFE(write_int32(ci->mlock_off, f));
	SAFE(write_int32(ci->mlock_limit, f));
	SAFE(write_string(ci->mlock_key, f));

        SAFE(write_int16(ci->entrycount, f));
        for (i = 0; i < ci->entrycount; i++)
        {
            SAFE(write_string(ci->entrymsg[i], f));
        }

        for (i = ci->autoopcount - 1; i >= 0; i--)
        {
            if (ci->autoop[i].ni == NULL)
            {
                if (ci->autoopcount != i + 1)
                {
                    for (j = i; j < ci->autoopcount; j++)
                    {
                        ci->autoop[j].ni = ci->autoop[j + 1].ni;
                    }
                }
                ci->autoopcount = ci->autoopcount - 1;
            }
        }
        SAFE(write_int16(ci->autoopcount, f));
        for (i = 0; i < ci->autoopcount; i++)
        {
            SAFE(write_int16(ci->autoop[i].in_use, f));
            if (ci->autoop[i].in_use)
            {
                SAFE(write_string(ci->autoop[i].ni->nick, f));
               	SAFE(write_variable(ci->autoop[i].flag, f));
            }
        }

					    
        SAFE(write_int16(ci->commentcount, f));
        for (i = 0; i < ci->commentcount; i++) 
	{
            if (ci->comment[i].in_use == 1)
            {
                SAFE(write_int16(ci->comment[i].in_use, f));
                SAFE(write_string(ci->comment[i].ni->nick, f)); 
               	SAFE(write_buffer(ci->comment[i].msg, f));
            }
        }


    } /* for (ci) */

    {
	/* This is an UGLY HACK but it simplifies loading.  It will go away
	 * in the next file version */
	static char buf[256];
	SAFE(write_buffer(buf, f));
    }

    close_db(f);
    return;

  fail:
    restore_db(f);
    log_perror("Write error on %s", ChanDBName);
    if (time(NULL) - lastwarn > WarningTimeout) {
	wallops(NULL, "Write error on %s: %s", ChanDBName,
		strerror(errno));
	lastwarn = time(NULL);
    }
}

#undef SAFE

