/* Routines for looking up commands in a *Serv command list.
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
*/   

#include "services.h"
#include "commands.h"    
#include "language.h"

/*************************************************************************/

/* Return the Command corresponding to the given name, or NULL if no such
 * command exists.
 */

Command *lookup_cmd(Command *list, const char *cmd)
{
    Command *c;

    for (c = list; c->name; c++) {
	if (stricmp(c->name, cmd) == 0)
	    return c;
    }
    return NULL;
}

/*************************************************************************/

/* Run the routine for the given command, if it exists and the user has
 * privilege to do so; if not, print an appropriate error message.
 */

void run_cmd(const char *service, User *u, Command *list, const char *cmd, ChannelInfo *ci)
{
	Command *c = lookup_cmd(list, cmd);
	int ulevel = 0;

	ulevel = check_cservice(u);
	if ( (ulevel == 0) && ci )
		ulevel = get_access(u, ci);
	if ( ulevel == 0 )
		if ( (stricmp(u->nick, ServicesRoot) == 0) && nick_recognized(u) )
			ulevel = ACCLEV_GOD;
            
	if (c && c->routine)
	{
		if ( ((c->has_priv == NULL) || c->has_priv(u)) && (ulevel >= c->level) )
			c->routine(u);
		else
			notice_lang(service, u, ACCESS_DENIED);
	} else {
		notice_lang(service, u, UNKNOWN_COMMAND_HELP, cmd, service);
	}
}

/*************************************************************************/

/* Print a help message for the given command. */

void help_cmd(const char *service, User *u, Command *list, const char *cmd)
{
	Command *c = lookup_cmd(list, cmd);

	if (c)
	{
		if (c->helpmsg_syntax || c->helpmsg_help || c->helpmsg_example)
		{
			if (c->helpmsg_syntax)
				notice_help(service, u, c->helpmsg_syntax );
			if (c->helpmsg_help)
				notice_help(service, u, c->helpmsg_help );
			if (c->helpmsg_example)
				notice_help(service, u, c->helpmsg_example );
		}
		else
		{
			notice_lang(service, u, NO_HELP_AVAILABLE, cmd);
		}
	} else {
		notice_lang(service, u, NO_HELP_AVAILABLE, cmd);
	}
}

/*************************************************************************/
