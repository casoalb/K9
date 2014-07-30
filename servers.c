/* Routines to maintain a list of online servers.
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
						       
#include "services.h"
#include "pseudo.h"

/*************************************************************************/

static Server *serverlist;	/* Pointer to first server in the list */
static int16 servercnt = 0;	/* Number of online servers */

static Server *lastserver = NULL; /* Points to the server last returned by
				   * findserver(). This should improve
				   * performance during netbursts of NICKs. */

/*************************************************************************/

/*************************************************************************/
/****************************** Statistics *******************************/
/*************************************************************************/

/* Return information on memory use. Assumes pointers are valid. */

void get_server_stats(long *nservers, long *memuse)
{
    Server *server;
    long mem;

    mem = sizeof(Server) * servercnt;
    for (server = serverlist; server; server = server->next)
	mem += strlen(server->name)+1;

    *nservers = servercnt;
    *memuse = mem;
}

/*************************************************************************/

#ifdef DEBUG_COMMANDS
void send_server_list(User *user)
{
    Server *server;

    for (server = serverlist; server; server = server->next) {

    }
}
#endif /* DEBUG_COMMANDS */

/*************************************************************************/
/**************************** Internal Functions *************************/
/*************************************************************************/

/* Allocate a new Server structure, fill in basic values, link it to the
 * overall list, and return it. Always successful.
 */

static Server *new_server(const char *servername)
{
    Server *server;

    servercnt++;
    server = scalloc(sizeof(Server), 1);
    server->name = sstrdup(servername);

    server->next = serverlist;
    if (server->next)
	server->next->prev = server;
    serverlist = server;

    return server;
}

/* Remove and free a Server structure. */

static void delete_server(Server *server)
{
    if (debug >= 2)
	log("debug: delete_server() called");

    if (server == lastserver)
	lastserver = NULL;

    servercnt--;
    free(server->name);
    if (server->prev)
	server->prev->next = server->next;
    else
	serverlist = server->next;
    if (server->next)
	server->next->prev = server->prev;
    free(server);

    if (debug >= 2)
	log("debug: delete_server() done");
}

/*************************************************************************/
/**************************** External Functions *************************/
/*************************************************************************/

Server *findserver(const char *servername)
{
    Server *server;

    if (!servername)
	return NULL;

    if (lastserver && stricmp(servername, lastserver->name) == 0)
	return lastserver;

    for (server = serverlist; server; server = server->next) {
	if (stricmp(servername, server->name) == 0) {
	    lastserver = server;
	    return server;
	}
    }

    return NULL;
}

/*************************************************************************/
/*************************************************************************/

/* Handle a server SERVER command.
 * 	source = server's hub; !*source indicates this is our hub.
 * 	av[0]  = server's name
 */

void do_server(const char *source, int ac, char **av)
{
    Server *server, *tmpserver;

    server = new_server(av[0]);
    server->t_join = time(NULL);
    server->child = NULL;
    server->sibling = NULL;

#ifdef STATISTICS
    server->stats = stats_do_server(av[0], source);
#endif

    if (!*source)
	return;

    server->hub = findserver(source);
    if (!server->hub) {
	/* PARANOIA: This should NEVER EVER happen, but we check anyway.
	 *
	 * I've heard that on older ircds it is possible for "source" not to
	 * be the new server's hub. This will cause problems. -TheShadow */
	log("server: could not find hub %s for %s", source, av[0]);
	return;
    }

    if (!server->hub->child) {
	server->hub->child = server;
    } else {
	tmpserver = server->hub->child;
	while (tmpserver->sibling)
	    tmpserver = tmpserver->sibling;
	tmpserver->sibling = server;
    }

    return;
}

/*************************************************************************/

/* "SQUIT" all servers who are linked to us via the specified server by
 * deleting them from the server list. The parent server is not deleted,
 * so this must be done by the calling function.
 */

void recursive_squit(Server *parent, const char *reason)
{
    Server *server, *nextserver;

    server = parent->child;
    if (debug >= 2)
	log("recursive_squit, parent: %s", parent->name);
    while (server) {
	if (server->child)
	    recursive_squit(server, reason);
	if (debug >= 2)
	    log("recursive_squit, child: %s", server->name);
	nextserver = server->sibling;
#ifdef STATISTICS
	stats_do_squit(server, reason);
#endif
	delete_server(server);
	server = nextserver;
    }
}

/* Handle a server SQUIT command.
 * 	av[0] = server's name
 * 	av[1] = quit message
 */

void do_squit(const char *source, int ac, char **av)
{
    Server *server, *tmpserver;

    server = findserver(av[0]);

    if (server) {
	recursive_squit(server, av[1]);
	if (server->hub) {
	    if (server->hub->child == server) {
		server->hub->child = server->sibling;
	    } else {
		for (tmpserver = server->hub->child; tmpserver->sibling;
				tmpserver = tmpserver->sibling) {
		    if (tmpserver->sibling == server) {
			tmpserver->sibling = server->sibling;
			break;
		    }
		}
	    }
#ifdef STATISTICS
	    stats_do_squit(server, av[1]);
#endif
	    delete_server(server);
	}

    } else {
	log("server: Tried to quit non-existent server: %s", av[0]);
	/* FIXME: debug code (why do we get weird hostnames here?) */
	log("server: Input buffer: %s", inbuf);
	return;
    }
}

/*************************************************************************/
