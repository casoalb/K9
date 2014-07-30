/* Database file descriptor structure and file handling routine prototypes.
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
	  
#ifndef DATAFILES_H
#define DATAFILES_H

/*************************************************************************/

typedef struct dbFILE_ dbFILE;
struct dbFILE_ {
    int mode;			/* 'r' for reading, 'w' for writing */
    FILE *fp;			/* The normal file descriptor */
    FILE *backupfp;		/* Open file pointer to a backup copy of
				 *    the database file (if non-NULL) */
    char filename[PATH_MAX];	/* Name of the database file */
    char backupname[PATH_MAX];	/* Name of the backup file */
};

/*************************************************************************/

/* Prototypes and macros: */

E void check_file_version(dbFILE *f);
E int get_file_version(dbFILE *f);
E int write_file_version(dbFILE *f);
E dbFILE *open_db(const char *service, const char *filename, const char *mode);
E int restore_db(dbFILE *f);	/* Restore to state before open_db() */
E void close_db(dbFILE *f);
#define read_db(f,buf,len)	(fread((buf),1,(len),(f)->fp))
#define write_db(f,buf,len)	(fwrite((buf),1,(len),(f)->fp))
#define getc_db(f)		(fgetc((f)->fp))

E int read_int8(unsigned char *ret, dbFILE *f);
E int write_int8(unsigned char val, dbFILE *f);
E int read_int16(uint16 *ret, dbFILE *f);
E int write_int16(uint16 val, dbFILE *f);
E int read_int32(uint32 *ret, dbFILE *f);
E int write_int32(uint32 val, dbFILE *f);
E int read_ptr(void **ret, dbFILE *f);
E int write_ptr(const void *ptr, dbFILE *f);
E int read_string(char **ret, dbFILE *f);
E int write_string(const char *s, dbFILE *f);
E int copy_string(char **dest, const char *source);

#define read_buffer(buf,f)	(read_db((f),(buf),sizeof(buf)) == sizeof(buf))
#define write_buffer(buf,f)	(write_db((f),(buf),sizeof(buf)) == sizeof(buf))
#define copy_buffer(buf,src)     (strncpy(buf,src,sizeof(buf)))
#define read_buflen(buf,len,f)	(read_db((f),(buf),(len)) == (len))
#define write_buflen(buf,len,f)	(write_db((f),(buf),(len)) == (len))
#define copy_buflen(buf,src,len) (strncpy(buf,src,len))
#define read_variable(var,f)	(read_db((f),&(var),sizeof(var)) == sizeof(var))
#define write_variable(var,f)	(write_db((f),&(var),sizeof(var)) == sizeof(var))

/*************************************************************************/

#endif	/* DATAFILES_H */
