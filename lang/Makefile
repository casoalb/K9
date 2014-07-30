# Makefile for language module

include ../Makefile.inc


LANGOBJS = de en_us es it ja_euc ja_sjis nl pt tr
LANGSRCS = $(LANGOBJS:%=%.l)

LANGCOMP = ./langcomp
#LANGCOMP = ./langcomp -w


all: $(LANGOBJS)


install: all
	mkdir -p "$(DATDEST)/languages"
#ifdef RUNGROUP
	chgrp "$(RUNGROUP)" "$(DATDEST)/languages"
	chmod 770 "$(DATDEST)/languages"
#else
	chmod 700 "$(DATDEST)/languages"
#endif
	cp $(LANGOBJS) "$(DATDEST)/languages"
#ifdef RUNGROUP
	chgrp $(RUNGROUP) "$(DATDEST)/languages/"*
	chmod 660 "$(DATDEST)/languages/"*
#else
	chmod 600 "$(DATDEST)/languages/"*
#endif


clean:
	rm -f $(LANGOBJS) langcomp

spotless: clean
	rm -f language.h


$(LANGOBJS): %: %.l langcomp index
	$(LANGCOMP) $<

ja_jis.l: ja_euc.l jconv.pl
	perl jconv.pl -jis <ja_euc.l >$@
ja_sjis.l: ja_euc.l jconv.pl
	perl jconv.pl -sjis <ja_euc.l >$@

langcomp: langcomp.c
	$(CC) $(CFLAGS) langcomp.c -o $@


language.h: index Makefile
	@perl -e <index >$@ '\
		print STDERR "Generating language.h... "; \
		$$i=0; \
		while (<>) { \
			chop; \
			printf "#define %-32s %d\n", $$_, $$i++; \
		} \
		print "\n#define NUM_STRINGS $$i\n"; \
		print STDERR "$$i strings\n";'
