/* Chatnet K9 Channel Services
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
**      sloth   (sloth@nopninjas.com)
**
**      *** DO NOT DISTRIBUTE ***
*/

#include "services.h"

static int next_ping = 0; /* when do we send next ping to this server */
static struct timeval ping_sendt; /* When last ping was send.. = 0 => last ping received */
static int last_ping = 0; /* last ping time */

int got_ping_reply(char *id)
{
    struct timeval t;
    int itime;

    gettimeofday(&t,NULL);
    if(atoi(id)!=ping_sendt.tv_sec)
    {
        /* someone is faking this to fuck us up. do nothing */
        return 0;
    }
    itime=t.tv_sec-ping_sendt.tv_sec;
    if(itime<100)
    {
        itime=itime * 1000000;
        itime=itime + (t.tv_usec-ping_sendt.tv_usec);
    }else itime=-1;
    last_ping = itime;
    next_ping = time(NULL) + 90; /* 1 minz */
    ping_sendt.tv_sec=0;
    return 1;        
}

int check_pings(void)
{
    register int curtim=time(NULL);

    if (ping_sendt.tv_sec==0)
    {                
        if(next_ping<=curtim)
        {
                gettimeofday(&ping_sendt,NULL);
                send_cmd(ServerName, "WHOIS Routing.ChatNet.Org :TIMETEST_%ld",ping_sendt.tv_sec);
                return 0;
        }
        else     
                return 0;
    }
    else
    {
        if((ping_sendt.tv_sec+60)<=curtim)
        {
                // ping timeout...
                log("ping: Ping timeout. Attempted reconnect");
                return -1;
        }
        else
                return 0;
    }
}
