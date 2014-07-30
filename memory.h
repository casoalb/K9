#ifndef MEMORY_H
#define MEMORY_H

/*************************************************************************/

#ifdef MEMCHECKS
# ifdef SHOWALLOCS
extern int showallocs;
# endif
extern void init_memory(void);
#endif /* MEMCHECKS */

extern void *smalloc(long size);
extern void *scalloc(long elsize, long els);
extern void *srealloc(void *oldptr, long newsize);
extern char *sstrdup(const char *s);
#ifdef MEMCHECKS
extern void sfree(void *ptr);
#endif

/*************************************************************************/

#if defined(MEMCHECKS) && !defined(NO_MEMREDEF)

# undef malloc
# undef calloc
# undef realloc
# undef strdup
# undef free

# define malloc smalloc
# define calloc scalloc
# define realloc srealloc
# define strdup sstrdup
# define free sfree

#endif /* MEMCHECKS && !NO_MEMREDEF */

/*************************************************************************/

#endif /* MEMORY_H */
