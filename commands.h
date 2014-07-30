/* Declarations for command data.
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

/* Structure for information about a *Serv command. */

typedef struct {
    const char *name;
    void (*routine)(User *u);
    int (*has_priv)(User *u);	/* Returns 1 if user may use command, else 0 */

    int level;

    int helpmsg_syntax;
    int helpmsg_help;
    int helpmsg_example;
} Command;

/*************************************************************************/

/* Routines for looking up commands.  Command lists are arrays that must be
 * terminated with a NULL name.
 */

extern Command *lookup_cmd(Command *list, const char *name);
extern void run_cmd(const char *service, User *u, Command *list,
		const char *name, ChannelInfo *ci);
extern void help_cmd(const char *service, User *u, Command *list,
		const char *name);

/*************************************************************************/
