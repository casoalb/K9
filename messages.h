/* Declarations of IRC message structures, variables, and functions.
**
** K9 IRC Services (c) 2001-2002
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

typedef struct {
    const char *name;
    void (*func)(char *source, int ac, char **av);
} Message;

extern Message messages[];

extern Message *find_message(const char *name);

/*************************************************************************/
