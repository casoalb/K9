/* Routines to load/save NickServ data files.
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
	  
/*************************************************************************/
/*************************************************************************/

#define SAFE(x) do {					\
    if ((x) < 0) {					\
	if (!forceload)					\
	    fatal("Read error on %s", NickDBName);	\
	failed = 1;					\
	break;						\
    }							\
} while (0)

static void load_old_ns_dbase(dbFILE *f, int ver)
{
    struct nickinfo_ {
	NickInfo *next, *prev;
	char nick[NICKMAX];
	char pass[PASSMAX];
	char *last_usermask;
	char *last_realname;
	time_t time_registered;
	time_t last_seen;
	long accesscount;
	char **access;
	long flags;
	time_t id_stamp;
	unsigned short memomax;
	unsigned short channelcount;
	char *url;
	char *email;
    } old_nickinfo;

    int i, j, c;
    NickInfo *ni, **last, *prev;
    int failed = 0;

    for (i = 33; i < 256 && !failed; i++) {
	last = &nicklists[i];
	prev = NULL;
	while ((c = getc_db(f)) != 0) {
	    if (c != 1)
		fatal("Invalid format in %s", NickDBName);
	    SAFE(read_variable(old_nickinfo, f));
	    if (debug >= 3)
		log("debug: load_old_ns_dbase read nick %s", old_nickinfo.nick);
	    ni = scalloc(sizeof(NickInfo), 1);
	    *last = ni;
	    last = &ni->next;
	    ni->prev = prev;
	    prev = ni;
	    strscpy(ni->nick, old_nickinfo.nick, NICKMAX);
	    strscpy(ni->pass, old_nickinfo.pass, PASSMAX);
	    ni->time_registered = old_nickinfo.time_registered;
	    ni->last_seen = old_nickinfo.last_seen;
	    ni->accesscount = old_nickinfo.accesscount;
	    ni->flags = old_nickinfo.flags;
	    ni->channelcount = 0;
	    ni->channelmax = CSMaxReg;
	    ni->language = DEF_LANGUAGE;
	    /* ENCRYPTEDPW and VERBOTEN moved from ni->flags to ni->status */
	    if (ni->flags & 4)
		ni->status |= NS_VERBOTEN;
	    if (ni->flags & 8)
		ni->status |= NS_ENCRYPTEDPW;
	    ni->flags &= ~0xE000000C;
#ifdef USE_ENCRYPTION
	    if (!(ni->status & (NS_ENCRYPTEDPW | NS_VERBOTEN))) {
		if (debug)
		    log("debug: %s: encrypting password for `%s' on load",
				s_NickServ, ni->nick);
		if (encrypt_in_place(ni->pass, PASSMAX) < 0)
		    fatal("%s: Can't encrypt `%s' nickname password!",
				s_NickServ, ni->nick);
		ni->status |= NS_ENCRYPTEDPW;
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
	    if (old_nickinfo.url)
		SAFE(read_string(&ni->url, f));
	    if (old_nickinfo.email)
		SAFE(read_string(&ni->email, f));
	    SAFE(read_string(&ni->last_usermask, f));
	    if (!ni->last_usermask)
		ni->last_usermask = sstrdup("@");
	    SAFE(read_string(&ni->last_realname, f));
	    if (!ni->last_realname)
		ni->last_realname = sstrdup("");
	    if (ni->accesscount) {
		char **access, *s;
		if (ni->accesscount > NSAccessMax)
		    ni->accesscount = NSAccessMax;
		access = smalloc(sizeof(char *) * ni->accesscount);
		ni->access = access;
		for (j = 0; j < ni->accesscount; j++, access++)
		    SAFE(read_string(access, f));
		while (j < old_nickinfo.accesscount) {
		    SAFE(read_string(&s, f));
		    if (s)
			free(s);
		    j++;
		}
	    }
	    ni->id_stamp = 0;
	    if (ver < 3) {
		ni->flags |= NI_MEMO_SIGNON | NI_MEMO_RECEIVE;
	    } else if (ver == 3) {
		if (!(ni->flags & (NI_MEMO_SIGNON | NI_MEMO_RECEIVE)))
		    ni->flags |= NI_MEMO_SIGNON | NI_MEMO_RECEIVE;
	    }
	} /* while (getc_db(f) != 0) */
	*last = NULL;
    } /* for (i) */
}

#undef SAFE

/*************************************************************************/

#define SAFE(x) do {					\
    if ((x) < 0) {					\
	if (!forceload)					\
	    fatal("Read error on %s", NickDBName);	\
	return NULL;					\
    }							\
} while (0)

NickInfo *load_nick(dbFILE *f, int ver)
{
    NickInfo *ni;
    int32 tmp32;
    int i;

    ni = scalloc(sizeof(NickInfo), 1);
    SAFE(read_buffer(ni->nick, f));
    SAFE(read_buffer(ni->pass, f));
    SAFE(read_string(&ni->url, f));
    SAFE(read_string(&ni->email, f));
    SAFE(read_string(&ni->last_usermask, f));
    if (!ni->last_usermask)
	ni->last_usermask = sstrdup("@");
    SAFE(read_string(&ni->last_realname, f));
    if (!ni->last_realname)
	ni->last_realname = sstrdup("");
    SAFE(read_string(&ni->last_quit, f));
    SAFE(read_int32(&tmp32, f));
    ni->time_registered = tmp32;
    SAFE(read_int32(&tmp32, f));
    ni->last_seen = tmp32;
    SAFE(read_int16(&ni->status, f));
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
    /* Store the _name_ of the link target in ni->link for now;
     * we'll resolve it after we've loaded all the nicks */
    SAFE(read_string((char **)&ni->link, f));
    /* We actually recalculate link and channel counts later, but leave
     * them in for now to avoid changing the data file format */
    SAFE(read_int16(&ni->linkcount, f));
    if (ni->link) {
	SAFE(read_int16(&ni->channelcount, f));
	/* No other information saved for linked nicks, since
	 * they get it all from their link target */
	ni->channelmax = CSMaxReg;
	ni->language = DEF_LANGUAGE;
    } else {
	SAFE(read_int32(&ni->flags, f));
	if (!NSAllowKillImmed)
	    ni->flags &= ~NI_KILL_IMMED;
	if (ver >= 9) {
	    read_ptr((void **)&ni->suspendinfo, f);
	} else if (ver == 8 && (ni->flags & 0x10000000)) {
	    /* In version 8, 0x10000000 was NI_SUSPENDED */
	    ni->suspendinfo = (SuspendInfo *)1;
	}
	if (ni->suspendinfo) {
	    SuspendInfo *si = smalloc(sizeof(*si));
	    SAFE(read_buffer(si->who, f));
	    SAFE(read_string(&si->reason, f));
	    SAFE(read_int32(&tmp32, f));
	    si->suspended = tmp32;
	    SAFE(read_int32(&tmp32, f));
	    si->expires = tmp32;
	    ni->suspendinfo = si;
	}
	SAFE(read_int16(&ni->accesscount, f));
	if (ni->accesscount) {
	    char **access;
	    access = smalloc(sizeof(char *) * ni->accesscount);
	    ni->access = access;
	    for (i = 0; i < ni->accesscount; i++, access++)
		SAFE(read_string(access, f));
	}
	SAFE(read_int16(&ni->channelcount, f));
	SAFE(read_int16(&ni->channelmax, f));
	if (ver <= 8) {
	    /* Fields not initialized or updated properly */
	    /* These will be updated by load_cs_dbase() */
	    ni->channelcount = 0;
	    if (ver == 5)
		ni->channelmax = CSMaxReg;
	}
	SAFE(read_int16(&ni->language, f));
	if (!langtexts[ni->language])
	    ni->language = DEF_LANGUAGE;
    }
    /* Link and channel counts are recalculated later */
    ni->linkcount = 0;
    ni->channelcount = 0;
    ni->historycount = 0;
    return ni;
}

#undef SAFE

/*************************************************************************/

void load_ns_dbase(void)
{
    dbFILE *f;
    int ver, i, c;
    NickInfo *ni;
    int failed = 0;

    if (!(f = open_db(s_NickServ, NickDBName, "r")))
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
		    fatal("Invalid format in %s", NickDBName);
		ni = load_nick(f, ver);
		if (ni) {
		    alpha_insert_nick(ni);
		} else {
		    failed = 1;
		    break;
		}
	    }
	}

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

	break;

      case 4:
      case 3:
      case 2:
      case 1:
	load_old_ns_dbase(f, ver);
	break;

      case -1:
	fatal("Unable to read version number from %s", NickDBName);

      default:
	fatal("Unsupported version number (%d) on %s", ver, NickDBName);

    } /* switch (version) */

    close_db(f);
}

#undef SAFE

/*************************************************************************/
/*************************************************************************/

#define SAFE(x) do { if ((x) < 0) goto fail; } while (0)

void save_ns_dbase(void)
{
    dbFILE *f;
    int i;
    NickInfo *ni;
    char **access;
    static time_t lastwarn = 0;

    if (!(f = open_db(s_NickServ, NickDBName, "w")))
	return;
    for (ni = firstnick(); ni; ni = nextnick()) {
	SAFE(write_int8(1, f));
	SAFE(write_buffer(ni->nick, f));
	SAFE(write_buffer(ni->pass, f));
	SAFE(write_string(ni->url, f));
	SAFE(write_string(ni->email, f));
	SAFE(write_string(ni->last_usermask, f));
	SAFE(write_string(ni->last_realname, f));
	SAFE(write_string(ni->last_quit, f));
	SAFE(write_int32(ni->time_registered, f));
	SAFE(write_int32(ni->last_seen, f));
	SAFE(write_int16(ni->status, f));
	if (ni->link) {
	    SAFE(write_string(ni->link->nick, f));
	    SAFE(write_int16(ni->linkcount, f));
	    SAFE(write_int16(ni->channelcount, f));
	} else {
	    SAFE(write_string(NULL, f));
	    SAFE(write_int16(ni->linkcount, f));
	    SAFE(write_int32(ni->flags, f));
	    SAFE(write_ptr(ni->suspendinfo, f));
	    if (ni->suspendinfo) {
		SAFE(write_buffer(ni->suspendinfo->who, f));
		SAFE(write_string(ni->suspendinfo->reason, f));
		SAFE(write_int32(ni->suspendinfo->suspended, f));
		SAFE(write_int32(ni->suspendinfo->expires, f));
	    }
	    SAFE(write_int16(ni->accesscount, f));
	    for (i=0, access=ni->access; i<ni->accesscount; i++, access++)
		SAFE(write_string(*access, f));
	    SAFE(write_int16(ni->channelcount, f));
	    SAFE(write_int16(ni->channelmax, f));
	    SAFE(write_int16(ni->language, f));
	}
    } /* for (ni) */
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
    log_perror("Write error on %s", NickDBName);
    if (time(NULL) - lastwarn > WarningTimeout) {
	wallops(NULL, "Write error on %s: %s", NickDBName,
		strerror(errno));
	lastwarn = time(NULL);
    }
}

#undef SAFE

