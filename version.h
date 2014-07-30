/* Version information for K9 IRC Services.
 *
 * This program is free but copyrighted software; see the file COPYING for
 * details.
 */

#define BUILD	"362"

const char version_number[] = "1.0";
const char version_build[] = "build #" BUILD ", compiled Mon Sep  1 18:48:17 PDT 2008";
const char version_protocol[] =
#if defined(IRC_BAHAMUT)
	"ircd.dal Bahamut"
#elif defined(IRC_UNREAL)
	"Unreal"
#elif defined(IRC_DAL4_4_15)
	"ircd.dal 4.4.15+"
#elif defined(IRC_DALNET)
	"ircd.dal 4.4.13-"
#elif defined(IRC_UNDERNET_NEW)
	"ircu 2.10+"
#elif defined(IRC_UNDERNET)
	"ircu 2.9.32-"
#elif defined(IRC_TS8)
	"RFC1459 + TS8"
#elif defined(IRC_CLASSIC)
	"RFC1459"
#else
	"unknown"
#endif
	;


/* Look folks, please leave this INFO reply intact and unchanged. If you do
 * have the urge to mention yourself, please simply add your name to the list.
 * The other people listed below have just as much right, if not more, to be
 * mentioned. Leave everything else untouched. Thanks.
 */

const char *info_text[] =
    {
	"K9 IRC Services 2002",
	"General Public License.",
	0,
    };
