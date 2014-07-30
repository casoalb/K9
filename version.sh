#!/bin/sh
#
# Build the version.h file which contains all the version related info and
# needs to be updated on a per-build basis.

VERSION=1.0

# Increment K9 Services build number
if [ -f version.h ] ; then
	BUILD=`fgrep '#define BUILD' version.h | sed 's/^#define BUILD.*"\([0-9]*\)".*$/\1/'`
	BUILD=`expr $BUILD + 1 2>/dev/null`
else
	BUILD=1
fi
if [ ! "$BUILD" ] ; then
	BUILD=1
fi

DATE=`date`
if [ $? -ne "0" ] ; then
    DATE="\" __DATE__ \" \" __TIME__ \""
fi

cat >version.h <<EOF
/* Version information for K9 IRC Services.
 *
 * This program is free but copyrighted software; see the file COPYING for
 * details.
 */

#define BUILD	"$BUILD"

const char version_number[] = "$VERSION";
const char version_build[] = "build #" BUILD ", compiled $DATE";
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
EOF
