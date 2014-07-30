# Makefile for K9 IRC Services.
#
# Chatnet K9 Channel Services
# Based on ircdservices ver. by Andy Church
# Chatnet modifications (c) 2001-2002
#
# E-mail: routing@lists.chatnet.org
# Authors:
#
#      Vampire (vampire@alias.chatnet.org)
#      Thread  (thread@alias.chatnet.org)
#      MRX     (tom@rooted.net)
#      sloth   (sloth@nopninjas.com)
#
#      *** DO NOT DISTRIBUTE ***  

include Makefile.inc


###########################################################################
########################## Configuration section ##########################

# Note that changing any of these options (or, in fact, anything in this
# file) will automatically cause a full rebuild of k9.

# Compilation options:
#
#	-DCLEAN_COMPILE	 Attempt to compile without any warnings (note that
#			 this may reduce performance)
#
#	-DSTREAMLINED    Leave out "fancy" options to enhance performance
#
#	-DMEMCHECKS	 Performs more through memory operation checks.
#			 ONLY for debugging use--THIS WILL REDUCE
#			 PERFORMANCE and may cause k9 to crash in
#			 low-memory conditions!

CDEFS =-DUSE_MYSQL

# Add any extra flags you want here.  The default line enables warnings and
# debugging symbols on GCC.  If you have a non-GCC compiler, you may want
# to comment it out or change it.

MORE_CFLAGS = -Wall -g


######################## End configuration section ########################
###########################################################################


CFLAGS = -I/usr/local/include $(CDEFS) $(BASE_CFLAGS) $(MORE_CFLAGS)

# MYSQL libraries 
MYSQLLIB = /usr/local/lib/mysql

LFLAGS = -L$(MYSQLLIB) -lmysqlclient


OBJS =	actions.o channels.o k9.o mysql.o commands.o compat.o \
	config.o datafiles.o encrypt.o init.o language.o \
	list.o log.o main.o memory.o messages.o misc.o modes.o \
	nickserv.o ping.o process.o send.o servers.o \
	sockutil.o timeout.o users.o \
	$(VSNPRINTF_O)
SRCS =	actions.c channels.c k9.c commands.c compat.c \
	config.c datafiles.c encrypt.c init.c language.c \
	list.c log.c main.c memory.c messages.c misc.c modes.c \
	nickserv.c ping.c process.c send.c servers.c \
	sockutil.c timeout.c users.c \
	$(VSNPRINTF_C)

.c.o:
	$(CC) $(CFLAGS) -c $<


all: $(PROGRAM) languages 
	@echo Now run \"$(MAKE) install\" to install k9.

myclean:
	rm -f *.o $(PROGRAM) version.h.old

clean: myclean
	(cd lang ; $(MAKE) clean)

spotless: myclean
	(cd lang ; $(MAKE) spotless)
	rm -f config.cache configure.log sysconf.h Makefile.inc language.h \
		version.h

install: $(PROGRAM) languages
	$(INSTALL) k9 "$(BINDEST)/k9"
	rm -f "$(BINDEST)/listnicks" "$(BINDEST)/listchans"
	ln "$(BINDEST)/k9" "$(BINDEST)/listnicks"
	ln "$(BINDEST)/k9" "$(BINDEST)/listchans"
	(cd lang ; $(MAKE) install)
	@set -e ; if [ ! -d "$(DATDEST)/helpfiles" ] ; then \
		echo '$(CP_ALL) data/* "$(DATDEST)"' ; \
		$(CP_ALL) data/* "$(DATDEST)" ; \
	else \
		echo 'cp -p data/example.conf "$(DATDEST)/example.conf"' ; \
		cp -p data/example.conf "$(DATDEST)/example.conf" ; \
	fi
	@set -e ; if [ "$(RUNGROUP)" ] ; then \
		echo 'chgrp -R "$(RUNGROUP)" "$(DATDEST)"' ; \
		chgrp -R "$(RUNGROUP)" "$(DATDEST)" ; \
		echo 'chmod -R g+rw "$(DATDEST)"' ; \
		chmod -R g+rw "$(DATDEST)" ; \
		echo 'find "$(DATDEST)" -type d -exec chmod g+xs '\''{}'\'' \;' ; \
		find "$(DATDEST)" -type d -exec chmod g+xs '{}' \; ; \
	fi
	@set -e ; if [ ! -d "$(BINDEST)/help" ] ; then \
	        echo '$(CP_ALL) help "$(BINDEST)/help"' ; \
		$(CP_ALL) help "$(BINDEST)/help" ; \
	fi	
	
	cp killk9 $(BINDEST)/
	cp runk9 $(BINDEST)/
	@echo ""
	@echo "Don't forget to create/update your k9.conf file!"
	@echo ""

instbin: $(PROGRAM) languages
	$(INSTALL) k9 $(BINDEST)/k9
	rm -f $(BINDEST)/listnicks $(BINDEST)/listchans
	ln $(BINDEST)/k9 $(BINDEST)/listnicks
	ln $(BINDEST)/k9 $(BINDEST)/listchans

###########################################################################

$(PROGRAM): version.h $(OBJS)
	$(CC) $(LFLAGS) $(OBJS) $(LIBS) -o $@

languages: FRC
	(cd lang ; $(MAKE) CFLAGS="$(CFLAGS)")


# Catch any changes in compilation options at the top of this file
$(OBJS): Makefile

actions.o:	actions.c	services.h language.h
channels.o:	channels.c	services.h
k9.o:     	k9.c	        services.h pseudo.h cs-loadsave.c
commands.o:	commands.c	services.h commands.h language.h
compat.o:	compat.c	services.h
config.o:	config.c	services.h
datafiles.o:	datafiles.c	services.h datafiles.h
encrypt.o:	encrypt.c	encrypt.h sysconf.h
init.o:		init.c		services.h
language.o:	language.c	services.h language.h
list.o:		list.c		services.h language.h
log.o:		log.c		services.h pseudo.h
main.o:		main.c		services.h timeout.h version.h
memory.o:	memory.c	services.h
messages.o:	messages.c	services.h messages.h language.h
misc.o:		misc.c		services.h
modes.o:	modes.c		services.h
nickserv.o:	nickserv.c	services.h pseudo.h ns-loadsave.c
ping.o:		ping.c		services.h
process.o:	process.c	services.h messages.h
servers.o:	servers.c	services.h
send.o:		send.c		services.h
sockutil.o:	sockutil.c	services.h
timeout.o:	timeout.c	services.h timeout.h
users.o:	users.c		services.h
vsnprintf.o:	vsnprintf.c


services.h: sysconf.h config.h modes.h nickserv.h k9.h \
            extern.h memory.h
	touch $@

pseudo.h: commands.h language.h timeout.h encrypt.h datafiles.h
	touch $@

version.h: Makefile version.sh services.h pseudo.h messages.h $(SRCS)
	sh version.sh

language.h: lang/language.h
	cp -p lang/language.h .

lang/language.h: lang/Makefile lang/index
	(cd lang ; $(MAKE) language.h)


FRC:
