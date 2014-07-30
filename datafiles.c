/* Database file handling routines.
**	  
** Chatnet K9 Channel Services
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

#include "services.h"
#include "datafiles.h"
#include <fcntl.h>

/*************************************************************************/
/*************************************************************************/

/* Return the version number of the file.  Return -1 if there is no version
 * number or the number doesn't make sense (i.e. less than 1 or greater
 * than FILE_VERSION).
 */

int get_file_version(dbFILE *f)
{
    FILE *fp = f->fp;
    int version = fgetc(fp)<<24 | fgetc(fp)<<16 | fgetc(fp)<<8 | fgetc(fp);
    if (ferror(fp)) {
#ifndef NOT_MAIN
	log_perror("Error reading version number on %s", f->filename);
#endif
	return -1;
    } else if (feof(fp)) {
#ifndef NOT_MAIN
	log("Error reading version number on %s: End of file detected",
		f->filename);
#endif
	return -1;
    } else if (version > FILE_VERSION || version < 1) {
#ifndef NOT_MAIN
	log("Invalid version number (%d) on %s", version, f->filename);
#endif
	return -1;
    }
    return version;
}

/*************************************************************************/

/* Write the current version number to the file.  Return 0 on success,
 * -1 on failure.
 */

int write_file_version(dbFILE *f)
{
    FILE *fp = f->fp;
    if (
	fputc(FILE_VERSION>>24 & 0xFF, fp) < 0 ||
	fputc(FILE_VERSION>>16 & 0xFF, fp) < 0 ||
	fputc(FILE_VERSION>> 8 & 0xFF, fp) < 0 ||
	fputc(FILE_VERSION     & 0xFF, fp) < 0
    ) {
#ifndef NOT_MAIN
	log_perror("Error writing version number on %s", f->filename);
#endif
	return -1;
    }
    return 0;
}

/*************************************************************************/
/*************************************************************************/

static dbFILE *open_db_read(const char *service, const char *filename)
{
    dbFILE *f;
    FILE *fp;

    f = malloc(sizeof(*f));
    if (!f) {
#ifndef NOT_MAIN
	log_perror("Can't read %s database %s", service, filename);
#endif
	return NULL;
    }
    strscpy(f->filename, filename, sizeof(f->filename));
    f->mode = 'r';
    fp = fopen(f->filename, "rb");
    if (!fp) {
	int errno_save = errno;
#ifndef NOT_MAIN
	if (errno != ENOENT)
	    log_perror("Can't read %s database %s", service, f->filename);
#endif
	free(f);
	errno = errno_save;
	return NULL;
    }
    f->fp = fp;
    f->backupfp = NULL;
    return f;
}

/*************************************************************************/

static dbFILE *open_db_write(const char *service, const char *filename)
{
    dbFILE *f;
    int fd;

    f = malloc(sizeof(*f));
    if (!f) {
#ifndef NOT_MAIN
	log_perror("Can't read %s database %s", service, filename);
#endif
	return NULL;
    }
    strscpy(f->filename, filename, sizeof(f->filename));
    filename = f->filename;
    f->mode = 'w';

    *f->backupname = 0;
    snprintf(f->backupname, sizeof(f->backupname), "%s.save", filename);
    if (!*f->backupname || strcmp(f->backupname, filename) == 0) {
	int errno_save = errno;
#ifndef NOT_MAIN
	log("Opening %s database %s for write: Filename too long",
		service, filename);
#endif
	free(f);
	errno = errno_save;
	return NULL;
    }
    unlink(f->backupname);
    f->backupfp = fopen(filename, "rb");
    if (rename(filename, f->backupname) < 0 && errno != ENOENT) {
	int errno_save = errno;
#ifndef NOT_MAIN
	static int walloped = 0;
	if (!walloped) {
	    walloped++;
	    wallops(NULL, "Can't back up %s database %s", service, filename);
	}
	errno = errno_save;
	log_perror("Can't back up %s database %s", service, filename);
	if (!NoBackupOkay) {
#endif
	    if (f->backupfp)
		fclose(f->backupfp);
	    free(f);
	    errno = errno_save;
	    return NULL;
#ifndef NOT_MAIN
	}
#endif
	*f->backupname = 0;
    }
    unlink(filename);
    /* Use open() to avoid people sneaking a new file in under us */
    fd = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
    f->fp = fdopen(fd, "wb");	/* will fail and return NULL if fd < 0 */
    if (!f->fp || write_file_version(f) < 0) {
	int errno_save = errno;
#ifndef NOT_MAIN
	static int walloped = 0;
	if (!walloped) {
	    walloped++;
	    wallops(NULL, "Can't write to %s database %s", service, filename);
	}
	errno = errno_save;
	log_perror("Can't write to %s database %s", service, filename);
#endif
	if (f->fp) {
	    fclose(f->fp);
	    unlink(filename);
	}
	if (*f->backupname && rename(f->backupname, filename) < 0)
#ifndef NOT_MAIN
	    fatal_perror("Cannot restore backup copy of %s", filename);
#else
	    ;
#endif
	errno = errno_save;
	return NULL;
    }
    return f;
}

/*************************************************************************/

/* Open a database file for reading (*mode == 'r') or writing (*mode == 'w').
 * Return the stream pointer, or NULL on error.  When opening for write, it
 * is an error for rename() to return an error (when backing up the original
 * file) other than ENOENT, if NO_BACKUP_OKAY is not defined; it is an error
 * if the version number cannot be written to the file; and it is a fatal
 * error if opening the file for write fails and the backup was successfully
 * made but cannot be restored.
 */

dbFILE *open_db(const char *service, const char *filename, const char *mode)
{
    if (*mode == 'r') {
	return open_db_read(service, filename);
    } else if (*mode == 'w') {
	return open_db_write(service, filename);
    } else {
	errno = EINVAL;
	return NULL;
    }
}

/*************************************************************************/

/* Restore the database file to its condition before open_db().  This is
 * identical to close_db() for files open for reading; however, for files
 * open for writing, we first attempt to restore any backup file before
 * closing files.  Return 0 on success, errno value on failure.  Does not
 * modify errno itself.
 */

int restore_db(dbFILE *f)
{
    int errno_orig = errno;
    int errno_save = 0;
    int retval = 0;

    if (f->mode == 'w') {
	int ok = 0;	/* Did we manage to restore the old file? */
	errno = 0;
	if (*f->backupname && strcmp(f->backupname, f->filename) != 0) {
	    if (rename(f->backupname, f->filename) == 0)
		ok = 1;
	}
	if (!ok && f->backupfp) {
	    char buf[1024];
	    int i;
	    ok = 1;
	    if (fseek(f->fp, 0, SEEK_SET) < 0)
		ok = 0;
	    while (ok && (i = fread(buf, 1, sizeof(buf), f->backupfp)) > 0) {
		if (fwrite(buf, 1, i, f->fp) != i)
		    ok = 0;
	    }
	    if (ok) {
		fflush(f->fp);
		ftruncate(fileno(f->fp), ftell(f->fp));
	    }
	}
	if (!ok && errno > 0) {
	    errno_save = errno;
	    retval = -1;
#ifndef NOT_MAIN
	    log_perror("Unable to restore backup of %s", f->filename);
#endif
	}
	if (f->backupfp)
	    fclose(f->backupfp);
	if (*f->backupname)
	    unlink(f->backupname);
    }
    fclose(f->fp);
    free(f);
    errno = errno_orig;
    return retval<0 ? errno_save : 0;
}

/*************************************************************************/

/* Close a database file.  If the file was opened for write, remove the
 * backup we (may have) created earlier.
 */

void close_db(dbFILE *f)
{
    if (f->mode == 'w' && *f->backupname
			&& strcmp(f->backupname, f->filename) != 0) {
	if (f->backupfp)
	    fclose(f->backupfp);
	unlink(f->backupname);
    }
    fclose(f->fp);
    free(f);
}

/*************************************************************************/
/*************************************************************************/

/* Read and write 2- and 4-byte quantities, pointers, and strings.  All
 * multibyte values are stored in big-endian order (most significant byte
 * first).  A pointer is stored as a byte, either 0 if NULL or 1 if not,
 * and read pointers are returned as either (void *)0 or (void *)1.  A
 * string is stored with a 2-byte unsigned length (including the trailing
 * \0) first; a length of 0 indicates that the string pointer is NULL.
 * Written strings are truncated silently at 65534 bytes, and are always
 * null-terminated.
 *
 * All routines return -1 on error, 0 otherwise.
 */

/*************************************************************************/

int read_int8(unsigned char *ret, dbFILE *f)
{
    int c = fgetc(f->fp);
    if (c == EOF)
	return -1;
    *ret = c;
    return 0;
}

int write_int8(unsigned char val, dbFILE *f)
{
    if (fputc(val, f->fp) == EOF)
	return -1;
    return 0;
}

/*************************************************************************/

/* These two are inline to help out {read,write}_string. */

inline int read_int16(uint16 *ret, dbFILE *f)
{
    int c1, c2;

    c1 = fgetc(f->fp);
    c2 = fgetc(f->fp);
    if (c2 == EOF)
	return -1;
    *ret = c1<<8 | c2;
    return 0;
}

inline int write_int16(uint16 val, dbFILE *f)
{
    fputc((val>>8), f->fp);
    if (fputc(val, f->fp) == EOF)
	return -1;
    return 0;
}

/*************************************************************************/

int read_int32(uint32 *ret, dbFILE *f)
{
    int c1, c2, c3, c4;

    c1 = fgetc(f->fp);
    c2 = fgetc(f->fp);
    c3 = fgetc(f->fp);
    c4 = fgetc(f->fp);
    if (c4 == EOF)
	return -1;
    *ret = c1<<24 | c2<<16 | c3<<8 | c4;
    return 0;
}

int write_int32(uint32 val, dbFILE *f)
{
    fputc((val>>24), f->fp);
    fputc((val>>16), f->fp);
    fputc((val>> 8), f->fp);
    if (fputc((val & 0xFF), f->fp) == EOF)
	return -1;
    return 0;
}

/*************************************************************************/

int read_ptr(void **ret, dbFILE *f)
{
    int c;

    c = fgetc(f->fp);
    if (c == EOF)
	return -1;
    *ret = (c ? (void *)1 : (void *)0);
    return 0;
}

int write_ptr(const void *ptr, dbFILE *f)
{
    if (fputc(ptr ? 1 : 0, f->fp) == EOF)
	return -1;
    return 0;
}

/*************************************************************************/

int read_string(char **ret, dbFILE *f)
{
    char *s;
    uint16 len;

    if (read_int16(&len, f) < 0)
	return -1;
    if (len == 0) {
	*ret = NULL;
	return 0;
    }
    s = smalloc(len);
    if (len != fread(s, 1, len, f->fp)) {
	free(s);
	return -1;
    }
    *ret = s;
    return 0;
}

int copy_string(char **dest, const char *source) {
  char *s;
  uint16 len;

  if((len = strlen(source)) < 1)
    return(-1);

  s = smalloc(len + 1);
  strncpy(s, source, len);
  s[len] = 0;
  
  *dest = s;
  return(0);

}

int write_string(const char *s, dbFILE *f)
{
    uint32 len;

    if((s == NULL) || ((int)s == 0x8))
    {
     	if(debug)
    		log("write_string parsed a NULL pointer.");
   	write_int16(0, f);
    	return(1); 
    }
		
    if (!s)
	return write_int16(0, f);
    len = strlen(s);
    if (len > 65534)
	len = 65534;
    write_int16((uint16)(len+1), f);
    fwrite(s, 1, len, f->fp);
    if (fputc(0, f->fp) == EOF)
	return -1;
    return 0;
}

/*************************************************************************/
/*************************************************************************/
