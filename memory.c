/* Memory management routines.
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
	  
#define NO_MEMREDEF
#include "services.h"

/*************************************************************************/
/*************************************************************************/

/*
 * To enable memory leak checks add the _MEMCHCKS define to the 
 * config.h or the command line when compiling.
 *					-- Kelmar (2001-01-13)
 * Note that this is not very useful at present because Services does not
 * clean up after itself on exit, so there will always be large amounts of
 * memory "leaked".  --AC 2001/2/15
 */

/*
 * WARNING: The following define will bloat your log files VERY quickly!
 * Use at your own risk!
 *					-- Kelmar (2001-01-16)
 */

/* #define SHOWALLOCS */

#ifdef SHOWALLOCS
int showallocs = 1;	/* Actually log allocations? */
#endif

/*************************************************************************/

#ifdef MEMCHECKS
typedef struct _smemblock {
    int32 size;		/* Size of this block */
    int32 sig;		/* Signature word: 0x5AFEC0DE */
    void *data;		/* Start of the user's data */
} MemBlock;
#define SIGNATURE	0x5AFEC0DE
#define FREED_SIGNATURE	0xDEADBEEF	/* Used for freed memory */
#endif /* MEMCHECKS */

/*************************************************************************/
/*************************************************************************/

#ifdef MEMCHECKS
static uint runtime = 0;
static uint allocated = 0;

static void show_leaks(void)
{
    if ((allocated - runtime) > 0) {
	log("SAFEMEM: There were %d bytes leaked on exit!",
	    (allocated - runtime));
	allocated = 0;
    } else {
	log("SAFEMEM: No memory leaks detected.");
    }
}

void init_memory(void)
{
    runtime = allocated;
    fprintf(stderr, "init_memory(): runtime = %d\n", runtime);
    atexit(show_leaks);
}
#endif /* MEMCHECKS */

/*************************************************************************/

/* smalloc, scalloc, srealloc, (sfree), sstrdup:
 *	Versions of the memory allocation functions which will cause the
 *	program to terminate with an "Out of memory" error if the memory
 *	cannot be allocated.  (Hence, the return value from these functions
 *	is never NULL.)  sfree() is used only with MEMCHECKS enabled.
 */

/*************************************************************************/

void *smalloc(long size)
{
#ifdef MEMCHECKS
    MemBlock *mb;
#else
    void *buf;
#endif

    if (size == 0) {
	log("smalloc: Illegal attempt to allocate 0 bytes");
	size = 1;
    }

#ifdef MEMCHECKS

    mb = malloc(size + sizeof(MemBlock));
    if (mb == NULL)
	raise(SIGUSR1);
    mb->size = size;
    mb->sig = SIGNATURE;
    mb->data = (void *)((char *)(mb) + sizeof(MemBlock));
    allocated += size;
# ifdef SHOWALLOCS
    if (showallocs)
	log("smalloc(): Allocated %ld bytes at %p", size, mb->data);
# endif
    return mb->data;

#else /* !MEMCHECKS */

    buf = malloc(size);
    if (buf == NULL)
	raise(SIGUSR1);
    return buf;

#endif /* MEMCHECKS */
}

/*************************************************************************/

void *scalloc(long elsize, long els)
{
#ifdef MEMCHECKS
    MemBlock *mb;
#else
    void *buf;
#endif

    if (elsize == 0)
    {
	log("scalloc: Illegal attempt to allocate 0 bytes");
	wallops(s_ChanServ, "Warning: Internal memory allocation error. Please notify #k9dev");		
	elsize = els = 1;
    }

#ifdef MEMCHECKS

    mb = malloc(elsize * els + sizeof(MemBlock));
    if (mb == NULL)
	raise(SIGUSR1);
    mb->size = elsize * els;
    mb->sig = SIGNATURE;
    mb->data = (void *)((char *)(mb) + sizeof(MemBlock));
    memset(mb->data, 0, elsize * els);
    allocated += mb->size;
# ifdef SHOWALLOCS
    if (showallocs)
	log("scalloc(): Allocated %ld bytes at %p", els*elsize, mb->data);
# endif
    return mb->data;

#else /* !MEMCHECKS */

    buf = calloc(els, elsize);
    if (buf == NULL)
	raise(SIGUSR1);
    return buf;

#endif /* MEMCHECKS */
}

/*************************************************************************/

void *srealloc(void *oldptr, long newsize)
{
#ifdef MEMCHECKS
    MemBlock *newb, *oldb;
    long oldsize;
# ifdef SHOWALLOCS
    void *olddata;
# endif
#else
    void *buf;
#endif /* MEMCHECKS */

    if (newsize == 0) {
#ifdef MEMCHECKS
	sfree(oldptr);
#else
	free(oldptr);
#endif
	return NULL;
    }

#ifdef MEMCHECKS

    if (oldptr == NULL)
	return smalloc(newsize);
    oldb = (MemBlock *)((char *)(oldptr) - sizeof(MemBlock));
    if (oldb->sig != SIGNATURE)
	fatal("Attempt to realloc() block on an invalid pointer!");
# ifdef SHOWALLOCS
    olddata = oldb->data;
# endif
    oldsize = oldb->size;
    newb = realloc(oldb, newsize + sizeof(MemBlock));
    if (newb == NULL)
	raise(SIGUSR1);
    newb->size = newsize;
    newb->sig = SIGNATURE;
    newb->data = (void *)((char *)(newb) + sizeof(MemBlock));
    /* Adjust our tracker acordingly */
    allocated += (newsize - oldsize);
# ifdef SHOWALLOCS
    if (showallocs)
	log("srealloc(): Adjusted %ld bytes (%p) to %ld bytes (%p)",
	    oldsize, olddata, newsize, newb->data);
# endif
    return newb->data;

#else /* !MEMCHECKS */

    buf = realloc(oldptr, newsize);
    if (buf == NULL)
	raise(SIGUSR1);
    return buf;

#endif /* MEMCHECKS */
}

/*************************************************************************/

#ifdef MEMCHECKS
void sfree(void *ptr)
{
    MemBlock *mb;

    if (ptr == NULL)
	fatal("Attempt to sfree() a NULL pointer!");
    mb = (MemBlock *)((char *)(ptr) - sizeof(MemBlock));
    if (mb->sig != SIGNATURE)
	fatal("Attempt to sfree() an invalid pointer! (%p)", ptr);
    allocated -= mb->size;
# ifdef SHOWALLOCS
    if (showallocs)
	log("sfree(): Released %d bytes at %p", mb->size, mb->data);
# endif
    mb->sig = FREED_SIGNATURE;
    free(mb);
}
#endif /* MEMCHECKS */   

/*************************************************************************/

char *sstrdup(const char *s)
{
    char *t = smalloc(strlen(s) + 1);
    strcpy(t, s);
    return t;
}

/*************************************************************************/
