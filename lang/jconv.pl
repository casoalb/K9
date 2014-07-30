#!/usr/bin/perl

undef $/;
$text = <STDIN>;
if ($ARGV[0] eq "-jis") {
	$text =~ s/EUC/JIS/g;
	$text =~ s#([\241-\376])([\241-\376])#
	           "\033\$B".pack("cc",ord($1)&127,ord($2)&127)."\033(B"#eg;
	# The language name (the only thing before the STRFTIME_* strings)
	# shouldn't have its %'s escaped; all other strings should, because
	# they go through sprintf().
	$pos = index($text, "STRFTIME");
	$pos = length($text) if $pos == 0;
	$t1 = substr($text, 0, $pos);
	$t2 = substr($text, $pos, length($text)-$pos);
	$t2 =~ s#(\033\$B.)%(\033\(B)#\1%%\2#g;
	$t2 =~ s#(\033\$B)%(.\033\(B)#\1%%\2#g;
	$text = $t1 . $t2;
	$text =~ s#\033\(B\033\$B##g;
} elsif ($ARGV[0] eq "-sjis") {
	$text =~ s/EUC/SJIS/g;
	$text =~ s#([\241-\376])([\241-\376])#
	           $x = 64+(ord($2)-0241)+((ord($1)-0241)%2)*0136;
	           $x++ if $x >= 0200;
	           pack("cc",129+(ord($1)-0241)/2,$x)#eg;
}
print $text;
