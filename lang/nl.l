# Emacs mode: -*- text -*-

# Dutch language file.
#
# K9 IRC Services (c) 2001-2002 |SaMaN|
# Contact me at linuxworm@turk.net
# This program is free but copyrighted software; see the file COPYING for
# details.
#
# Based on the original code of Services by Andy Church.
#

# When translating this file to another language, keep in mind that the
# order of parameters for sprintf() is fixed in the source code, so your
# messages need to take the same parameters in the same order as the
# English messages do.  (Obviously, this doesn't hold for the strftime()
# format lines immediately below.)  If you can't get a natural translation
# of a message without changing the order of the parameters, please inform
# the Services developers.
#
# In help messages, "%S" (capital S, not lowercase) refers to the name of
# the service sending the message; for example, in DogTag help messages,
# "%S" is replaced by "DogTag" (or whatever it is renamed to in
# config.h).  The %S's do not count as sprintf() parameters, so they can be
# rearranged, removed, or added as necessary.
#
# Also in help messages, please try to limit line lengths to 60 characters
# of text (not including the leading tab).  This length was chosen because
# it does not cause line wrap under default settings on most current IRC
# clients.  Remember that format characters (control-B, control-_) are not
# included in that 60-character limit (since they don't show on the user's
# screen).  Also remember that format specifiers (%S, etc.) will expand
# when displayed, so remember to take this into account; you can assume
# that the length of a pseudoclient name (%S replacement) will be eight
# characters, so reduce the maximum line length by 6 for every %S on a
# line.
#
# Finally, remember to put a tab at the beginning of every line of text
# (including empty lines).  This has to be a tab, not spaces.

###########################################################################
#
# Name of this language
#
###########################################################################

# For languages other than English, this string should have the following
# format:
#     language-name-in-language (language-name-in-English)
# For example, "Español (Spanish)" or "Français (French)".

LANG_NAME
	Nederlands (Dutch)

###################################################
# Translated by Martin Pels (rodecker@mp3crew.nu) #
# Tested by Mp3CreW (www.mp3crew.nu)              #
###################################################

###########################################################################
#
# General messages
#
###########################################################################

# strftime() format strings.  man 3 strftime for information on the
# meanings of the format specifiers.  Short version:
#	%a = weekday name (short)	%H = hour
#	%b = month name (short)		%M = minute
#	%d = day of month		%S = second
#	%Y = year			%Z = time zone

# This is used as the format string for strftime() for a date and time
# together.
STRFTIME_DATE_TIME_FORMAT
	%b %d %H:%M:%S %Y %Z
# This is used as the format string for strftime() for a date alone in long
# format (English: including weekday).
STRFTIME_LONG_DATE_FORMAT
	%a %b %d %Y
# This is used as the format string for strftime() for a date alone in
# short format (English: without weekday).
STRFTIME_SHORT_DATE_FORMAT
	%b %d %Y

# These tell our strftime() what the names of months and days are.  If you
# don't use %a, %A, %b, or %B in your strftime() strings above, you can
# leave these empty.  However, if you enter names, they MUST stay in order,
# one per line, and the list MUST be complete!

# %a
STRFTIME_DAYS_SHORT
	Zo
	Ma
	Di
	Wo
	Do
	Vr
	Za
# %A
STRFTIME_DAYS_LONG
	Zondag
	Maandag
	Dinsdag
	Woensdag
	Donderdag
	Vrijdag
	Zaterdag
# %b
STRFTIME_MONTHS_SHORT
	Jan
	Feb
	Mrt
	Apr
	Mei
	Jun
	Jul
	Aug
	Sep
	Okt
	Nov
	Dec
# %B
STRFTIME_MONTHS_LONG
	Januari
	Februari
	Maart
	April
	Mei
	Juni
	Juli
	Augustus
	September
	Oktober
	November
	December


# "day", "hour", "minute", and "second" in singular and plural.
STR_DAY
	dag
STR_DAYS
	dagen
STR_HOUR
	uur
STR_HOURS
	uren
STR_MINUTE
	minuut
STR_MINUTES
	minuten
STR_SECOND
	seconde
STR_SECONDS
	seconden


# This is used in ChanServ/DogTag INFO displays.
COMMA_SPACE
	, 


# Various error messages.
USER_RECORD_NOT_FOUND
	Interne Fout - Opdracht kan niet worden uitgevoerd.
UNKNOWN_COMMAND
	Onbekend commando %s.
UNKNOWN_COMMAND_HELP
	Onbekend commando %s.  Typ /msg %s HELP voor hulp.
SYNTAX_ERROR
	Syntax: %s
MORE_INFO
	Typ /msg %s HELP %s voor meer informatie.
NO_HELP_AVAILABLE
	Geen hulp beschikbaar voor %s.

BAD_EMAIL
	E-mail adres dient gegeven te worden in de vorm 
	gebruikersnaam@hostnaam.  Kleur, vetgedrukte, 
	onderstreepte, omgekeerde tekst of één van deze karakters:
	 , : ; | \ " ( ) < > kunnen niet gebruikt worden.
BAD_URL
	Pagina's dienen in de volgende vorm gegeven te worden: 
	http://hostnaam[:poort]/... (of ftp://, enz.).
BAD_USERHOST_MASK
	Masker dient gegeven te worden in de vorm 
	gebruiker@host.
BAD_EXPIRY_TIME
	Ongeldige vervaltijd.

SERVICE_OFFLINE
	%s is op dit moment niet aanwezig.
READ_ONLY_MODE
	Notice: K9 Services staan in alleen-lezen modus. 
	Veranderingen worden niet opgeslagen!
PASSWORD_INCORRECT
	Wachtwoord onjuist.

# What's the difference between "Access denied" and "Permission denied"?
# Very little; you can safely make them the same message with no real loss
# of meaning.  If you want to make a distinction, "Access denied" is
# usually used more generally; for example, a non-oper trying to access
# OperServ gets "Access denied", while a non-Services admin trying to use
# DogTag SET NOEXPIRE gets "Permission denied".
ACCESS_DENIED
	Geen toegang.
PERMISSION_DENIED
	Geen permissie.

MORE_OBSCURE_PASSWORD
	Probeer het nogmaals met een ingewikkelder wachtwoord.  
	Wachtwoorden dienen minimaal 5 karakters te zijn, moeten 
	niet makkelijk te raden zijn (b.v. naam of bijnaam), en 
	mogen geen spatie of tab bevatten.
PASSWORD_TRUNCATED
	Opmerking:  Uw wachtwoord is verkleind tot %d karakters.

NICK_NOT_REGISTERED
	Uw bijnaam is niet geregistreerd.
NICK_NOT_REGISTERED_HELP
	Uw bijnaam is niet geregistreerd.  Typ /msg %s HELP voor 
	informatie over het registreren van bijnamen.
NICK_X_NOT_REGISTERED
	Bijnaam %s is niet geregistreerd.
NICK_X_NOT_IN_USE
	Bijnaam %s is momenteel niet in gebruik.
NICK_X_FORBIDDEN
	Bijnaam %s mag niet geregistreerd of gebruikt worden.
NICK_X_SUSPENDED
	Bijnaam %s is buiten werking en mag niet gebruikt of 
	geidentificeerd worden.
NICK_X_SUSPENDED_MEMOS
	Bijnaam %s is buiten werking en mag geen memo's ontvangen.
NICK_IDENTIFY_REQUIRED
	Wachtwoord verificatie vereist voor dit commando.
	Probeer het nogmaals na het typen van /msg %s 
	IDENTIFY wachtwoord.
NICK_X_NOT_ON_CHAN_X
	Bijnaam %s is momenteel niet in kamer %s.

CHAN_X_NOT_REGISTERED
	Kamer %s is niet geregistreerd.
CHAN_X_NOT_IN_USE
	Kamer %s is momenteel niet in gebruik.
CHAN_X_FORBIDDEN
	Kamer %s mag niet geregistreerd of gebruikt worden.
CHAN_X_SUSPENDED
	Kamer %s is buiten werking en mag niet gebruikt of 
	geidentificeerd worden.
CHAN_X_SUSPENDED_MEMOS
	Kamer %s is buiten gebruik en mag geen memo's ontvangen.
CHAN_IDENTIFY_REQUIRED
	Wachtwoord verificatie vereist voor dit commando.
	Probeer het nogmaals na het typen van /msg %s 
	IDENTIFY %s wachtwoord.

SERV_X_NOT_FOUND
	Server %s niet gevonden.

EXPIRES_NONE
	vervalt niet
EXPIRES_SOON
	vervalt na volgende database update
EXPIRES_M
	vervalt over %d minuten
EXPIRES_1M
	vervalt over %d minuut
EXPIRES_HM
	vervalt over %d uren, %d minuten
EXPIRES_H1M
	vervalt over %d uren, %d minuut
EXPIRES_1HM
	vervalt over %d uur, %d minuten
EXPIRES_1H1M
	vervalt over %d uur, %d minuut
EXPIRES_D
	vervalt over %d dagen
EXPIRES_1D
	vervalt over %d dag

###########################################################################
#
# DogTag messages
#
###########################################################################

# Automatic messages
NICK_IS_REGISTERED
	Deze bijnaam is van iemand anders. Kies een andere.
	(Als dit uw bijnaam is, typ /msg %s IDENTIFY 
	wachtwoord.)
NICK_IS_SECURE
	Deze bijnaam is geregistreerd en beschermd. typ 
	/msg %s IDENTIFY wachtwoord. Als dit uw bijnaam 
	is, anders dient u een andere bijnaam te kiezen.
NICK_MAY_NOT_BE_USED
	Deze bijnaam mag niet gebruikt worden. Kies een andere.
DISCONNECT_IN_1_MINUTE
	Als u niet veranderd binnen één minuut, wordt uw verbinding 
	verbroken.
DISCONNECT_IN_20_SECONDS
	Als u niet veranderd binnen 20 seconden, wordt uw verbinding
	verbroken.
DISCONNECT_NOW
	Deze bijnaam is geregistreerd: U kunt deze niet gebruiken. 
	Kies een andere bijnaam voordat u opnieuw verbinding maakt.
FORCENICKCHANGE_IN_1_MINUTE
	Als u niet binnen één minuut veranderd zal ik uw bijnaam 
	wijzigen.
FORCENICKCHANGE_IN_20_SECONDS
	Als u niet binnen 20 seconden veranderd zal ik uw bijnaam 
	wijzigen.
FORCENICKCHANGE_NOW
	Deze bijnaam is geregistreerd: U kunt deze niet gebruiken.
	Uw bijnaam wordt nu veranderd naar %s.
NICK_EXPIRES_SOON
	Opmerking: De registratie van uw bijnaam vervalt over 
	%d %s.  Als u de bijnaam %s wil blijven gebruiken, 
	identificeer dan d.m.v.: /msg %s IDENTIFY wachtwoord
NICK_EXPIRED
	Opmerking: De registratie van uw bijnaam is vervallen.  
	Registreer uw bijnaam opnieuw als u deze wilt blijven 
	gebruiken.

# REGISTER responses
NICK_REGISTER_SYNTAX
	REGISTER wachtwoord [e-mail]
NICK_REGISTER_REQ_EMAIL_SYNTAX
	REGISTER wachtwoord e-mail
NICK_REGISTRATION_DISABLED
	Sorry, bijnaam registratie is tijdelijk uitgeschakeld.
NICK_REGISTRATION_FAILED
	Sorry, registratie mislukt.
NICK_REG_PLEASE_WAIT
	Wacht a.u.b. %d seconden voordat u het REGISTER commando 
	opnieuw gebruikt.
NICK_CANNOT_BE_REGISTERED
	Bijnaam %s mag niet geregistreerd worden.
NICK_ALREADY_REGISTERED
	Bijnaam %s is al geregistreerd!
NICK_REGISTERED
	Bijnaam %s is geregsitreerd op uw naam: %s
NICK_PASSWORD_IS
	Uw wachtwoord is %s - onthoud dit voor later gebruik.

# IDENTIFY responses
NICK_IDENTIFY_SYNTAX
	IDENTIFY wachtwoord
NICK_IDENTIFY_FAILED
	Sorry, identificatie niet geslaagd.
NICK_IDENTIFY_SUCCEEDED
	Wachtwoord geaccepteerd - U bent nu herkend.

# DROP responses
NICK_DROP_SYNTAX
	DROP
NICK_DROP_DISABLED
	Sorry, bijnaam registratie ongedaan maken is tijdelijk 
	uitgeschakeld.
NICK_DROPPED
	Uw bijnaam registratie is geannuleerd.
NICK_X_DROPPED
	Registratie van bijnaam %s is geannuleerd.

# SET responses
NICK_SET_SYNTAX
	SET optie parameters
NICK_SET_SERVADMIN_SYNTAX
	SET [bijnaam] optie parameters
NICK_SET_DISABLED
	Sorry, veranderen van bijnaam opties is tijdelijk 
	uitgeschakeld.
NICK_SET_UNKNOWN_OPTION
	Onbekende SET optie %s.
NICK_SET_UNKNOWN_OPTION_OR_BAD_NICK
	Onbekende SET optie %s, of bijnaam is niet geregistreerd.

# SET PASSWORD responses
NICK_SET_PASSWORD_FAILED
	Sorry, kon wachtwoord niet veranderen.
NICK_SET_PASSWORD_CHANGED
	Wachtwoord veranderd.
NICK_SET_PASSWORD_CHANGED_TO
	Wachtwoord veranderd naar %s.

# SET LANGUAGE responses
NICK_SET_LANGUAGE_SYNTAX
	SET LANGUAGE nummer
NICK_SET_LANGUAGE_UNKNOWN
	Onbekend taal-nummer %d.  Typ /msg %s HELP SET 
	LANGUAGE voor een lijst van talen.
NICK_SET_LANGUAGE_CHANGED
	Taal veranderd naar Nederlands.

# SET URL responses
NICK_SET_URL_CHANGED
	Pagina van %s veranderd naar %s.

# SET EMAIL responses
NICK_SET_EMAIL_CHANGED
	E-mail adres van %s veranderd naar %s.

# SET KILL responses
NICK_SET_KILL_SYNTAX
	SET KILL {ON | QUICK | OFF}
NICK_SET_KILL_IMMED_SYNTAX
	SET KILL {ON | QUICK | IMMED | OFF}
NICK_SET_KILL_ON
	Kill protectie staat nu ON (aan).
NICK_SET_KILL_QUICK
	Kill protectie staat nu ON (aan), met een kleinere 
	kill-vertraging.
NICK_SET_KILL_IMMED
	Kill protectie staat nu ON (aan), zonder kill-vertraging.
NICK_SET_KILL_IMMED_DISABLED
	De IMMED optie is niet beschikbaar op dit netwerk.
NICK_SET_KILL_OFF
	Kill protectie staat nu OFF (uit).

# SET SECURE responses
NICK_SET_SECURE_SYNTAX
	SET SECURE {ON | OFF}
NICK_SET_SECURE_ON
	Beveiliging staat nu ON (aan).
NICK_SET_SECURE_OFF
	Beveiliging staat nu OFF (uit).

# SET PRIVATE responses
NICK_SET_PRIVATE_SYNTAX
	SET PRIVATE {ON | OFF}
NICK_SET_PRIVATE_ON
	Privé optie staat nu ON (aan).
NICK_SET_PRIVATE_OFF
	Privé optie staat nu OFF (uit).

# SET HIDE responses
NICK_SET_HIDE_SYNTAX
	SET HIDE {EMAIL | USERMASK | QUIT} {ON | OFF}
NICK_SET_HIDE_EMAIL_ON
	Uw e-mail adres wordt nu verborgen in %s INFO weergave.
NICK_SET_HIDE_EMAIL_OFF
	Uw e-mail adres wordt nu getoond in %s INFO weergave.
NICK_SET_HIDE_MASK_ON
	Uw laatst gebruikte gebruiker@host masker wordt nu verborgen
	in %s INFO weergave.
NICK_SET_HIDE_MASK_OFF
	Uw laatst gebruikte gebruiker@host masker wordt nu getoond 
	in %s INFO weergave.
NICK_SET_HIDE_QUIT_ON
	Uw laatste vertrek-boodschap wordt nu verborgen in %s INFO 
	weergave.
NICK_SET_HIDE_QUIT_OFF
	Uw laatste vertrek-boodschap wordt nu getoond in %s INFO 
	weergave.

# SET NOEXPIRE responses
NICK_SET_NOEXPIRE_SYNTAX
	SET [bijnaam] NOEXPIRE {ON | OFF}
NICK_SET_NOEXPIRE_ON
	Bijnaam %s zal niet vervallen.
NICK_SET_NOEXPIRE_OFF
	Bijnaam %s zal vervallen.

# UNSET responses
NICK_UNSET_SYNTAX
	UNSET {URL | EMAIL}
NICK_UNSET_SYNTAX_REQ_EMAIL
	UNSET URL
NICK_UNSET_URL
	Pagina van %s verwijderd.
NICK_UNSET_EMAIL
	E-mail adres van %s verwijderd.
NICK_UNSET_EMAIL_BAD
	U kunt uw e-mail adres niet verwijderen.
NICK_UNSET_EMAIL_OTHER_BAD
	Bijnaam E-mail adressen mogen niet verwijderd worden.

# ACCESS responses
NICK_ACCESS_SYNTAX
	ACCESS {ADD | DEL | LIST} [masker]
NICK_ACCESS_ALREADY_PRESENT
	Masker %s staat al op uw toeganglijst.
NICK_ACCESS_REACHED_LIMIT
	Sorry, het maximum aantal toegangen voor een bijnaam is %d.
NICK_ACCESS_ADDED
	%s is toegevoegd aan uw toegangslijst.
NICK_ACCESS_NOT_FOUND
	%s niet gevonden op uw toegangslijst.
NICK_ACCESS_DELETED
	%s verwijderd van uw toegangslijst.
NICK_ACCESS_LIST
	Toegangslijst:
NICK_ACCESS_LIST_X
	Toegangslijst van %s:

# LINK responses
NICK_LINK_SYNTAX
	LINK bijnaam wachtwoord
NICK_LINK_DISABLED
	Het LINK commando is niet beschikbaar.
NICK_LINK_FAILED
	Sorry, linken niet geslaagd.
NICK_NO_LINK_SAME
	U kunt niet linken naar uw huidige bijnaam!
NICK_LINK_CIRCULAR
	Kan niet linken naar %s: Cyclische link gevonden.
NICK_LINK_TOO_DEEP
	U kunt niet meer dan %d levels diep linken.
NICK_LINK_TOO_MANY_CHANNELS
	Kan niet linken aan bijnaam %s: teveel kamers 
	geregistreerd (gecombineerd maximum %d).
NICK_LINKED
	Uw bijnaam is gelinkt aan %s.

# UNLINK responses
NICK_UNLINK_SYNTAX
	UNLINK [bijnaam wachtwoord]
NICK_UNLINK_FAILED
	Sorry, link ongedaan maken niet geslaagd.
NICK_NOT_LINKED
	Uw bijnaam is niet gelinkt.
NICK_UNLINKED
	De link van uw bijnaam met %s is ongedaan gemaakt.
NICK_X_NOT_LINKED
	Bijnaam %s is niet gelinkt.
NICK_X_UNLINKED
	Bijnaam %s is niet meer gelinkt aan %s.

# LISTLINKS responses
NICK_LISTLINKS_SYNTAX
	LISTLINKS bijnaam [ALL]
NICK_LISTLINKS_HEADER
	Lijst van bijnamen gelinkt aan %s:
NICK_LISTLINKS_FOOTER
	%d gelinkte bijnamen.
NICK_X_IS_LINKED
	    %s
NICK_X_IS_LINKED_VIA_X
	    %-20s (via %s)

# INFO responses
NICK_INFO_SYNTAX
	INFO bijnaam [ALL]
NICK_INFO_REALNAME
	%s is %s
NICK_INFO_ADDRESS
	Laatst geziene adres: %s
NICK_INFO_ADDRESS_ONLINE
	Aanwezig vanaf: %s
NICK_INFO_ADDRESS_ONLINE_NOHOST
	%s is momenteel niet aanwezig.
NICK_INFO_TIME_REGGED
	Tijd geregistreerd: %s
NICK_INFO_LAST_SEEN
	Laatst gezien: %s
NICK_INFO_LAST_QUIT
	Laatste vertrek-boodschap: %s
NICK_INFO_URL
	Pagina: %s
NICK_INFO_EMAIL
	E-mail adres: %s
NICK_INFO_OPTIONS
	Opties: %s
NICK_INFO_LINKED_TO
	Gelinkt aan: %s
# These strings MUST NOT be empty
NICK_INFO_OPT_KILL
	Kill protectie
NICK_INFO_OPT_SECURE
	Beveiliging
NICK_INFO_OPT_PRIVATE
	Privé
NICK_INFO_OPT_NONE
	Geen
NICK_INFO_NO_EXPIRE
	Deze bijnaam zal niet vervallen.
NICK_INFO_SUSPEND_DETAILS
	Buiten werking gesteld door %s op %s (%s).
NICK_INFO_SUSPEND_REASON
	Reden: %s
NICK_INFO_SHOW_ALL
	Voor meer informatie, typ: /msg %s INFO %s ALL

# LISTCHANS responses
NICK_LISTCHANS_SYNTAX
	LISTCHANS
NICK_LISTCHANS_SERVADMIN_SYNTAX
	LISTCHANS [bijnaam]
NICK_LISTCHANS_NONE
	%s heeft geen kamers geregistreerd.
NICK_LISTCHANS_HEADER
	Kamers geregistreerd door %s:
NICK_LISTCHANS_ENTRY
	    %s
NICK_LISTCHANS_END
	Einde van de lijst (%d kamers geregistreerd).

# LIST responses
NICK_LIST_SYNTAX
	LIST patroon
NICK_LIST_SERVADMIN_SYNTAX
	LIST patroon [FORBIDDEN] [NOEXPIRE] [SUSPENDED]
NICK_LIST_HEADER
	Lijst van bijnamen met patroon %s:
NICK_LIST_RESULTS
	Einde van de lijst - %d/%d Gevonden bijnamen getoond.

# RECOVER responses
NICK_RECOVER_SYNTAX
	RECOVER bijnaam [wachtwoord]
NICK_NO_RECOVER_SELF
	U kunt RECOVER niet op uzelf uitvoeren!
NICK_RECOVERED
	Gebruiker met uw bijnaam is verwijderd.
	Typ /msg %s RELEASE %s om uw bijnaam terug te 
	krijgen voor de 1-minuut timeout.

# RELEASE responses
NICK_RELEASE_SYNTAX
	RELEASE bijnaam [wachtwoord]
NICK_RELEASE_NOT_HELD
	Bijnaam %s wordt niet vastgehouden.
NICK_RELEASED
	K9 Services houdt uw bijnaam niet langer vast.

# GHOST responses
NICK_GHOST_SYNTAX
	GHOST bijnaam [wachtwoord]
NICK_NO_GHOST_SELF
	U kunt GHOST niet op uzelf uitvoeren!
NICK_GHOST_KILLED
	Spook met uw bijnaam is verwijderd.

# GETPASS responses
NICK_GETPASS_SYNTAX
	GETPASS bijnaam
NICK_GETPASS_UNAVAILABLE
	GETPASS commando is niet beschikbaar omdat encryptie aan staat.
NICK_GETPASS_PASSWORD_IS
	Wachtwoord van %s is %s.

# FORBID responses
NICK_FORBID_SYNTAX
	FORBID bijnaam
NICK_FORBID_SUCCEEDED
	Bijnaam %s is nu onbruikbaar.
NICK_FORBID_FAILED
	Kan bijnaam %s niet onbruikbaar maken!

# SUSPEND responses
NICK_SUSPEND_SYNTAX
	SUSPEND [+vervaltijd] bijnaam reden
NICK_SUSPEND_SUCCEEDED
	Bijnaam %s, en alle bijnamen met dezelfde bodem-bijnaam 
	zijn buiten werking gesteld.
NICK_SUSPEND_ALREADY_SUSPENDED
	Bijnaam %s is al buiten werking.

# UNSUSPEND responses
NICK_UNSUSPEND_SYNTAX
	UNSUSPEND bijnaam
NICK_UNSUSPEND_SUCCEEDED
	Bijnaam %s is weer bruikbaar.
NICK_SUSPEND_NOT_SUSPENDED
	Bijnaam %s is niet buiten werking.

###########################################################################
#
# ChanServ messages
#
###########################################################################

# Access level descriptions
CHAN_LEVEL_AUTOOP
	Automatische kamer operator status
CHAN_LEVEL_AUTOVOICE
	Automatische voice (+v)
CHAN_LEVEL_AUTODEOP
	Kamer operator status niet toegestaan
CHAN_LEVEL_AUTODEOP_HALFOP
	Kamer operator/halfop status niet toegestaan
CHAN_LEVEL_NOJOIN
	Niet toegestaan om kamer binnen te gaan als deze 
	RESTRICTED is
CHAN_LEVEL_INVITE
	Mag INVITE gebruiken
CHAN_LEVEL_AKICK
	Mag AKICK gebruiken
CHAN_LEVEL_SET
	Mag SET gebruiken (niet FOUNDER/PASSWORD)
CHAN_LEVEL_CLEAR
	Mag CLEAR gebruiken
CHAN_LEVEL_UNBAN
	Mag UNBAN gebruiken
CHAN_LEVEL_OPDEOP
	Mag OP/DEOP commando's gebruiken
CHAN_LEVEL_ACCESS_LIST
	Mag de toegangslijst bekijken
CHAN_LEVEL_ACCESS_CHANGE
	Mag de toegangslijst aanpassen
CHAN_LEVEL_MEMO
	Mag kamer memo's lezen
CHAN_LEVEL_VOICE
	Mag VOICE/DEVOICE commando's gebruiken
CHAN_LEVEL_AUTOHALFOP
	Automatische halfop (+h) status
CHAN_LEVEL_HALFOP
	Mag HALFOP/DEHALFOP commando's gebruiken
CHAN_LEVEL_AUTOPROTECT
	Automatische kamer bescherming (+a) status
CHAN_LEVEL_PROTECT
	Mag PROTECT/DEPROTECT commando's gebruiken

# Automatic responses
CHAN_IS_REGISTERED
	Deze kamer is geregistreerd met %s.
CHAN_NOT_ALLOWED_OP
	U heeft geen recht op kamer operator status in kamer %s.
CHAN_MAY_NOT_BE_USED
	Deze kamer mag niet gebruikt worden.
CHAN_NOT_ALLOWED_TO_JOIN
	U bent niet bevoegd deze kamer binnen te gaan.

# Multi-purpose responses
CHAN_BOUNCY_MODES
	Sorry, het %s commando is tijdelijk niet beschikbaar.

# REGISTER responses
CHAN_REGISTER_SYNTAX
	REGISTER kamer wachtwoord beschrijving
CHAN_REGISTER_DISABLED
	Sorry, kamer registratie is tijdelijk uitgeschakeld.
CHAN_REGISTER_NOT_LOCAL
	Lokale kamers kunnen niet geregistreerd worden.
CHAN_MUST_REGISTER_NICK
	U dient uw bijnaam eerst te registreren.  Typ /msg %s 
	HELP voor info over registreren van bijnamen.
CHAN_MUST_IDENTIFY_NICK
	Identificeer eerst voor %s, door middel van:
	/msg %s IDENTIFY wachtwoord
CHAN_MAY_NOT_BE_REGISTERED
	Kamer %s mag niet geregistreerd worden.
CHAN_ALREADY_REGISTERED
	Kamer %s is al geregistreerd!
CHAN_MUST_BE_CHANOP
	U dient kamer operator te zijn om de kamer te registreren.
CHAN_REACHED_CHANNEL_LIMIT
	Sorry, u heeft uw limiet van %d kamers bereikt.
CHAN_EXCEEDED_CHANNEL_LIMIT
	Sorry, u heeft uw limiet van %d kamers overschreden.
CHAN_REGISTRATION_FAILED
	Sorry, registratie niet geslaagd.
CHAN_REGISTERED
	Kamer %s geregistreerd onder bijnaam: %s
CHAN_PASSWORD_IS
	Uw kamer wachtwoord is %s - Onthou dit voor later gebruik.

# IDENTIFY responses
CHAN_AUTH_SYNTAX
	AUTH <kamer> <wachtwoord>
CHAN_SETPASS_SYNTAX
	SETPASS <kamer> <new wachtwoord>	
CHAN_IDENTIFY_FAILED
	Sorry, identificatie niet geslaagd.
CHAN_IDENTIFY_SUCCEEDED
	Wachtwoord geaccepteerd - U heeft nu eigenaar rechten voor kamer %s.

# DROP responses
CHAN_DROP_SYNTAX
	DROP kamer
CHAN_DROP_DISABLED
	Sorry, kamer registratie ongedaan maken is tijdelijk 
	uitgeschakeld.
CHAN_DROPPED
	Registratie van kamer %s is ongedaan gemaakt.

# SET responses
CHAN_SET_SYNTAX
	SET kamer optie parameters
CHAN_SET_DISABLED
	Sorry, veranderen van kamer opties is tijdelijk 
	uitgeschakeld.
CHAN_SET_UNKNOWN_OPTION
	Onbekende SET optie %s.

# SET FOUNDER responses
CHAN_SET_FOUNDER_TOO_MANY_CHANS
	%s heeft te veel geregistreerde kamers.
CHAN_FOUNDER_CHANGED
	Eigenaar van %s veranderd naar %s.

# SET SUCCESSOR responses
CHAN_SUCCESSOR_CHANGED
	Opvolger van %s veranderd naar %s.
CHAN_SUCCESSOR_IS_FOUNDER
	Eigenaar en opvolger van een kamer kunnen niet dezelfde 
	persoon zijn.

# SET PASSWORD responses
CHAN_SET_PASSWORD_FAILED
	Sorry, kon wachtwoord niet veranderen.
CHAN_PASSWORD_CHANGED
	%s wachtwoord veranderd.
CHAN_PASSWORD_CHANGED_TO
	%s wachtwoord veranderd naar %s.

# SET DESC responses
CHAN_DESC_CHANGED
	Beschrijving van %s veranderd naar %s.

# SET URL responses
CHAN_URL_CHANGED
	Pagina van %s veranderd naar %s.

# SET EMAIL responses
CHAN_EMAIL_CHANGED
	E-mail adres van %s veranderd naar %s.

# SET ENTRYMSG responses
CHAN_ENTRY_MSG_CHANGED
	Binnenkomst bericht van %s veranderd.

# SET TOPIC responses
CHAN_SET_TOPIC_FAILED
	Sorry, kan onderwerp niet veranderen.

# SET MLOCK responses
CHAN_SET_MLOCK_KEY_REQUIRED
	Parameter vereist voor MLOCK +k.
CHAN_SET_MLOCK_LIMIT_REQUIRED
	Parameter vereist voor MLOCK +l.
CHAN_SET_MLOCK_LIMIT_POSITIVE
	Parameter voor MLOCK +l dient een positief nummer te zijn.
CHAN_SET_MLOCK_MODE_REG_BAD
	Mode +%c is is altijd aanwezig in geregistreerde kamers, 
	en kan niet gebruikt worden met MLOCK.
CHAN_SET_MLOCK_MODE_F_BAD
	Mode +f kan niet vastgezet worden.
CHAN_SET_MLOCK_UNKNOWN_CHAR
	Onbekend mode karakter %c genegeerd.
CHAN_MLOCK_CHANGED
	Mode slot van kamer %s veranderd naar %s.
CHAN_MLOCK_REMOVED
	Mode slot van kamer %s verwijderd.

# SET KEEPTOPIC responses
CHAN_SET_KEEPTOPIC_SYNTAX
	SET kamer KEEPTOPIC {ON | OFF}
CHAN_SET_KEEPTOPIC_ON
	Onderwerp behoud is nu ON (aan).
CHAN_SET_KEEPTOPIC_OFF
	Onderwerp behoud is nu OFF (uit).

# SET TOPICLOCK responses
CHAN_SET_TOPICLOCK_SYNTAX
	SET kamer TOPICLOCK {ON | OFF}
CHAN_SET_TOPICLOCK_ON
	Onderwerp slot is nu ON (aan).
CHAN_SET_TOPICLOCK_OFF
	Onderwerp slot is nu OFF (uit).

# SET PRIVATE responses
CHAN_SET_PRIVATE_SYNTAX
	SET channel PRIVATE {ON | OFF}
CHAN_SET_PRIVATE_ON
	Privé optie staat nu ON (aan).
CHAN_SET_PRIVATE_OFF
	Privé optie staat nu OFF (uit).

# SET SECUREOPS responses
CHAN_SET_SECUREOPS_SYNTAX
	SET kamer SECUREOPS {ON | OFF}
CHAN_SET_SECUREOPS_ON
	Operator beveiligingsoptie staat nu ON (aan).
CHAN_SET_SECUREOPS_OFF
	Operator beveiligingsoptie staat nu OFF (uit).

# SET LEAVEOPS responses
CHAN_SET_LEAVEOPS_SYNTAX
	SET kamer LEAVEOPS {ON | OFF}
CHAN_SET_LEAVEOPS_ON
	Operator behoud staat nu ON (aan).
CHAN_SET_LEAVEOPS_OFF
	Operator behoud optie staat nu OFF (uit).

# SET RESTRICTED responses
CHAN_SET_RESTRICTED_SYNTAX
	SET channel RESTRICTED {ON | OFF}
CHAN_SET_RESTRICTED_ON
	Beperkte toegang staat nu ON (aan).
CHAN_SET_RESTRICTED_OFF
	Beperkte toegang staat nu OFF (uit).

# SET SECURE responses
CHAN_SET_SECURE_SYNTAX
	SET kamer SECURE {ON | OFF}
CHAN_SET_SECURE_ON
	Beveiliging staat nu ON (aan).
CHAN_SET_SECURE_OFF
	Beveiliging staat nu OFF (uit).

# SET OPNOTICE responses
CHAN_SET_OPNOTICE_SYNTAX
	SET kamer OPNOTICE {ON | OFF}
CHAN_SET_OPNOTICE_ON
	Operator-alarm staat nu ON (aan).
CHAN_SET_OPNOTICE_OFF
	Operator-alarm staat nu OFF (uit).

# SET ENFORCE responses
CHAN_SET_ENFORCE_SYNTAX
	SET kamer ENFORCE {ON | OFF}
CHAN_SET_ENFORCE_ON
	Behoud optie staat nu ON (aan).
CHAN_SET_ENFORCE_OFF
	Behoud optie staat nu OFF (uit).

# SET NOEXPIRE responses
CHAN_SET_NOEXPIRE_SYNTAX
	SET kamer NOEXPIRE {ON | OFF}
CHAN_SET_NOEXPIRE_ON
	kamer %s zal niet vervallen.
CHAN_SET_NOEXPIRE_OFF
	Kamer %s zal vervallen.

# UNSET responses
CHAN_UNSET_SYNTAX
	UNSET kamer {SUCCESSOR | URL | EMAIL | ENTRYMSG}
CHAN_SUCCESSOR_UNSET
	Opvolger van %s verwijderd.
CHAN_URL_UNSET
	Pagina van %s verwijderd.
CHAN_EMAIL_UNSET
	E-mail adres van %s verwijderd.
CHAN_ENTRY_MSG_UNSET
	Binnenkomst bericht van %s verwijderd.

# ACCESS messages
CHAN_ACCESS_SYNTAX
	ACCESS channel {ADD | DEL | LIST | COUNT} [bijnaam [level] | invoerlijst]
CHAN_ACCESS_DISABLED
	Sorry, aanpassen van de kamer toegangslijst is tijdelijk 
	uitgeschakeld.
CHAN_ACCESS_LEVEL_NONZERO
	Toegangs-status mag geen nul zijn.
CHAN_ACCESS_LEVEL_RANGE
	Toegangs-status dient tussen %d en %d te zijn.
CHAN_ACCESS_NICKS_ONLY
	Kamer toegangslijst mag alleen geregistreerde bijnamen 
	bevatten.
CHAN_ACCESS_REACHED_LIMIT
	Sorry, Het aantal toegangen in de lijst is beperkt tot %d.
CHAN_ACCESS_LEVEL_UNCHANGED
	Toegangs-status van %s in %s onveranderd op %d.
CHAN_ACCESS_LEVEL_CHANGED
	Toegangs-status van %s in %s veranderd naar %d.
CHAN_ACCESS_ADDED
	%s toegevoegd aan %s toegangslijst met status %d.
CHAN_ACCESS_NO_SUCH_ENTRY
	Invoer (#%d) komt niet voor in toegangslijst van %s.
CHAN_ACCESS_NOT_FOUND
	%s niet gevonden in toegangslijst van %s.
CHAN_ACCESS_NO_MATCH
	Invoer niet gevonden in toegangslijst van %s.
CHAN_ACCESS_DELETED
	%s verwijderd uit toegangslijst van %s.
CHAN_ACCESS_DELETED_ONE
	1 invoer verwijderd uit toegangslijst van %s.
CHAN_ACCESS_DELETED_SEVERAL
	%d invoeren verwijderd uit toegangslijst van %s.
CHAN_ACCESS_LIST_EMPTY
	Toegangslijst van %s is leeg.
CHAN_ACCESS_LIST_HEADER
	Toegangslijst voor %s:
CHAN_ACCESS_COUNT
	De toegangslijst van %s heeft %d invoeren.

# XOP (AOP/SOP/VOP) responses
CHAN_SOP_SYNTAX
	SOP kamer {ADD | DEL | LIST | COUNT} [bijnaam | invoerlijst]
CHAN_AOP_SYNTAX
	AOP kamer {ADD | DEL | LIST | COUNT} [bijnaam | invoerlijst]
CHAN_HOP_SYNTAX
	HOP kamer {ADD | DEL | LIST | COUNT} [bijnaam | invoerlijst]
CHAN_VOP_SYNTAX
	VOP kamer {ADD | DEL | LIST | COUNT} [bijnaam | invoerlijst]
CHAN_XOP_ADDED
	%s toegevoegd aan %s %s lijst.
CHAN_XOP_LEVEL_CHANGED
	%s verplaatst naar %s %s lijst.
CHAN_XOP_LEVEL_UNCHANGED
	%s staat al in %s %s lijst.
CHAN_XOP_NICKS_ONLY
	SOP, AOP, en VOP lijsten mogen alleen geregistreerde 
	bijnamen bevatten.
CHAN_XOP_NICKS_ONLY_HOP
	SOP, AOP, HOP, en VOP lijsten mogen alleen geregistreerde 
	bijnamen bevatten.
CHAN_XOP_REACHED_LIMIT
	Sorry, het aantal invoeren in SOP, AOP en VOP lijsten
	mag niet groter zijn dan %d.  Aantal overschreden.
CHAN_XOP_REACHED_LIMIT_HOP
	Sorry, het aantal invoeren in SOP, AOP, HOP en VOP lijsten
	mag niet groter zijn dan %d.  Aantal overschreden.
CHAN_XOP_NOT_FOUND
	%s niet gevonden in %s %s lijst.
CHAN_XOP_NO_SUCH_ENTRY
	Invoer (#%d) komt niet voor in %s %s lijst.
CHAN_XOP_NO_MATCH
	Invoer niet gevonden in %s %s lijst.
CHAN_XOP_DELETED
	%s verwijderd uit %s %s lijst.
CHAN_XOP_DELETED_ONE
	1 invoer verwijderd uit %s %s lijst.
CHAN_XOP_DELETED_SEVERAL
	%d invoeren verwijderd uit %s %s lijst.
CHAN_XOP_LIST_EMPTY
	%s %s lijst is leeg.
CHAN_XOP_LIST_HEADER
	%s list for %s:
	  Nr   Naam
CHAN_XOP_LIST_FORMAT
	  %3d   %s%s%s%s
CHAN_XOP_COUNT
	De %s %s lijst heeft %d invoeren.

# AKICK responses
CHAN_AKICK_SYNTAX
	AKICK kamer {ADD | DEL | LIST | VIEW | ENFORCE | COUNT} [masker | lijst]
CHAN_AKICK_DISABLED
	Sorry, kamer snel-verwijder lijst is bewerking is tijdelijk 
	uitgeschakeld.
CHAN_AKICK_ALREADY_EXISTS
	%s bestaat al in snel-verwijder lijst van %s.
CHAN_AKICK_REACHED_LIMIT
	Sorry, u kunt slechts %d snel-verwijder maskers invoeren 
	per kamer.
CHAN_AKICK_ADDED
	%s toegevoegd aan %s snel-verwijder lijst.
CHAN_AKICK_NO_SUCH_ENTRY
	Invoer (#%d) bestaat niet in %s snel-verwijder lijst.
CHAN_AKICK_NOT_FOUND
	%s niet gevonden in %s snel-verwijder lijst.
CHAN_AKICK_NO_MATCH
	Invoer niet gevonden in %s snel-verwijder lijst.
CHAN_AKICK_DELETED
	%s verijderd uit %s snel-verwijder lijst.
CHAN_AKICK_DELETED_ONE
	1 invoer verwijderd uit %s snel-verwijder lijst.
CHAN_AKICK_DELETED_SEVERAL
	%d invoeren verwijderd uit %s snel-verwijder lijst.
CHAN_AKICK_LIST_EMPTY
	%s snel-verwijder lijst is leeg.
CHAN_AKICK_LIST_HEADER
	Snel-verwijder lijst van %s:
CHAN_AKICK_LIST_FORMAT
	  %3d %s%s
CHAN_AKICK_VIEW_FORMAT
	  %3d %s (bij %s)
	    %s
CHAN_AKICK_ENFORCE_DONE
	AKICK ENFORCE in %s voltooid; %d gebruikers verwijderd.
CHAN_AKICK_COUNT
	%s heeft %d invoeren in de snel-verwijder lijst.

# LEVELS responses
CHAN_LEVELS_SYNTAX
	LEVELS kamer {SET | DIS[ABLE] | LIST | RESET} [optie [level]]
CHAN_LEVELS_RANGE
	Level moet tussen %d en %d liggen.
CHAN_LEVELS_CHANGED
	Level van %s in kamer %s veranderd naar %d.
CHAN_LEVELS_UNKNOWN
	Optie %s onbekend.  Typ /msg %s HELP LEVELS DESC voor 
	een lijst van geldige opties.
CHAN_LEVELS_DISABLED
	%s uitgeschakeld in kamer %s.
CHAN_LEVELS_LIST_HEADER
	Toegangslevel van kamer %s ingesteld op:
CHAN_LEVELS_LIST_DISABLED
	    %-*s  (uitgeschakeld)
CHAN_LEVELS_LIST_FOUNDER
	    %-*s  (alleen voor eigenaar)
CHAN_LEVELS_LIST_NORMAL
	    %-*s  %d
CHAN_LEVELS_RESET
	Toegangslevels van %s Teruggezet naar standaardwaarden.

# INFO responses
CHAN_INFO_SYNTAX
	INFO kamer [ALL]
CHAN_INFO_HEADER
	Informatie over kamer %s:
CHAN_INFO_FOUNDER
	Eigenaar: %s (%s)
CHAN_INFO_NO_FOUNDER
	Eigenaar: %s
CHAN_INFO_SUCCESSOR
	Opvolger: %s (%s)
CHAN_INFO_NO_SUCCESSOR
	Opvolger: %s
CHAN_INFO_DESCRIPTION
	Beschrijving: %s
CHAN_INFO_ENTRYMSG
	Binnenkomst bericht: %s
CHAN_INFO_TIME_REGGED
	Geregistreerd: %s
CHAN_INFO_LAST_USED
	Laatst gebruikt: %s
CHAN_INFO_LAST_TOPIC
	Laatste onderwerp: %s
CHAN_INFO_TOPIC_SET_BY
	Onderwerp ingesteld door: %s
CHAN_INFO_URL
	Pagina: %s
CHAN_INFO_EMAIL
	E-mail adres: %s
CHAN_INFO_OPTIONS
	Opties: %s
CHAN_INFO_OPT_PRIVATE
	Privé
CHAN_INFO_OPT_KEEPTOPIC
	Onderwerp behoud
CHAN_INFO_OPT_TOPICLOCK
	Onderwerp slot
CHAN_INFO_OPT_SECUREOPS
	Operator beveiliging
CHAN_INFO_OPT_LEAVEOPS
	Operator behoud
CHAN_INFO_OPT_RESTRICTED
	Beperkte toegang
CHAN_INFO_OPT_SECURE
	Beveiligd
CHAN_INFO_OPT_OPNOTICE
	Operator alarm
CHAN_INFO_OPT_ENFORCE
	Behoud
CHAN_INFO_OPT_NONE
	Geen
CHAN_INFO_MODE_LOCK
	The current mode guards are [%s]
CHAN_INFO_NO_EXPIRE
	Deze kamer zal niet vervallen.
CHAN_INFO_SUSPEND_DETAILS
	Buiten werking gesteld door %s op %s (%s).
CHAN_INFO_SUSPEND_REASON
	Reden: %s
CHAN_INFO_SHOW_ALL
	Voor meer informatie, typ: /msg %s INFO %s ALL

# LIST responses
CHAN_LIST_SYNTAX
	LIST patroon
CHAN_LIST_SERVADMIN_SYNTAX
	LIST patroon [FORBIDDEN] [NOEXPIRE]
CHAN_LIST_HEADER
	Lijst van invoeren met %s:
CHAN_LIST_FORMAT
	    %-20s  %s
CHAN_LIST_END
	Einde van de lijst - %d/%d invoeren getoond.

# INVITE responses
CHAN_INVITE_SYNTAX
	INVITE kamer <bijnaam>
CHAN_INVITE_OK
	%s wordt uitgenodigd voor kamer %s.

# OP/DEOP/VOICE/DEVOICE responses
CHAN_OPVOICE_SYNTAX
	%s kamer bijnaam
CHAN_OP_SUCCEEDED
	Yes master.
CHAN_OP_FAILED
	Do i know you?
CHAN_DEOP_SUCCEEDED
	Yes master.
CHAN_DEOP_FAILED
	Do i know you?
CHAN_VOICE_SUCCEEDED
	Yes master.
CHAN_VOICE_FAILED
	Do i know you?
CHAN_DEVOICE_SUCCEEDED
	Yes master.
CHAN_DEVOICE_FAILED
	Do i know you?
CHAN_HALFOP_SUCCEEDED
	Yes master.
CHAN_HALFOP_FAILED
	Do i know you?
CHAN_DEHALFOP_SUCCEEDED
	Yes master.
CHAN_DEHALFOP_FAILED
	Do i know you?
CHAN_PROTECT_SUCCEEDED
	 Yes master.
CHAN_PROTECT_FAILED
	Do i know you?
CHAN_DEPROTECT_SUCCEEDED
	Yes master.
CHAN_DEPROTECT_FAILED
	Do i know you?

CHAN_BANLIST
	Banlist for %s:
CHAN_RIGHTS_FAILED
	Sorry you dont have rights to do that
CHAN_NOUSER_FOUND
	I don't see %s on that channel master. Sorry.
CHAN_USER_LIKE_THAT
	I Don't Think that %s would like that.
CHAN_USER_MUST_IDENTIFY
	Sorry but user has to identify with DogTag first
CHAN_USER_CSERVICE
	Sorry but you can't add cservice member.
CHAN_USER_ALREADY_ACC
	Sorry that user already has an account please remove it first.
CHAN_USER_ONLY_LOWER
	Sorry you can only add people lower than yourself.
CHAN_BAN_NOSUCH
	No such entry (#%d) on %s banlist.
CHAN_BAN_NOMATCH
	No matching entries on %s banlist.
CHAN_CSCHAN_GETPASS
	Sorry you are not permitted to use GETPASS on #Doghouse
CHAN_AOCHAN_GETPASS
	Sorry you are not permitted to use GETPASS on #Nuthouse
CHAN_CSCHAN_FORBID
	Sorry you are not permitted to set FORBID for #Doghouse
CHAN_AOCHAN_FORBID
	Sorry you are not permitted to set FORBID for #Nuthouse
CHAN_CSCHAN_SUSPEND
	Sorry you are not permitted to SUSPEND #Doghouse
CHAN_AOCHAN_SUSPEND
	Sorry you are not permitted to SUSPEND #Nuthouse
CHAN_CSCHAN_REMCHAN
	Sorry you are not permitted to use REMCHAN on #Doghouse
CHAN_AOCHAN_REMCHAN
	Sorry you are not permitted to use REMCHAN on #Nuthouse
CHAN_USER_NOACC
	Yes master %s Has no access.
CHAN_INCHAN
	I am already on that channel master.	
CHAN_USER_ADDED
	You have been added to K9 by: %s
	Info Follows....
	Your NICK   :%s
	Your CHANNEL:%s
	Your LEVEL  :%d
CHAN_USER_ADDED2
	Yes master. I have added
	NICK   :%s
	CHANNEL:%s
	LEVEL  :%d
CHAN_NOBANS
	Master, no bans found for this channel.
CHAN_INVITE
	%s wishes to invite you to %s
CHAN_NOINVITE
	Nick %s isn currently on channel %s	
CHAN_STATUS_SYNTAX
	Syntax: STATUS <channel> <nick>
CHAN_DIEDIE_SYNTAX
	Syntax: DIEDIE <reason>
CHAN_RESTART_SYNTAX
	Syntax: RESTART <reason>
CHAN_UPDATE_SYNTAX
	Syntax: UPDATE
CHAN_LASTCMDS_SYNTAX
	Syntax: LASTCMDS <nick>
CHAN_MODE_SYNTAX
	Syntax: MODE <channel> <+/-ntlmpski>
CHAN_BROADCAST_SYNTAX
	Syntax: BROADCAST <message>
CHAN_ADDUSER_SYNTAX
	Syntax: ADDUSER <channel> <nick> <level>
CHAN_REMUSER_SYNTAX
	Syntax: REMUSER <channel> <nick>
CHAN_MODUSER_SYNTAX
	Syntax: MODUSER <channel> <nick> <new level>
CHAN_GUARDM_SYNTAX
	Syntax: GUARDM <channel> <+/-MODES>
CHAN_GUARDT_SYNTAX
	Syntax: GUARDT <channel> <T/F>
CHAN_ADDCHAN_SYNTAX
	Syntax: ADDCHAN <channel> <nick> <password> <description>
CHAN_SAY_SYNTAX
	SAY <channel> <message>
CHAN_ACT_SYNTAX
	ACT <channel> <message>
CHAN_SND_SYNTAX
	SND <channel> <message>
CHAN_JOIN_SYNTAX
	JOIN <channel>
CHAN_PART_SYNTAX
	PART <channel>
CHAN_COMMANDS_SYNTAX
	COMMANDS <channel>
CHAN_BANLIST_SYNTAX
	BANLIST <channel>
CHAN_KICK_SYNTAX
	KICK <channel> <nick> <reason>
CHAN_AUTOOP_SYNTAX
	AUTOOP <channel> <T/F>
# UNBAN responses
CHAN_UNBAN_SYNTAX
	UNBAN kamer
CHAN_UNBANNED
	U bent niet langer verbannen van kamer %s.

# CLEAR responses
CHAN_CLEAR_SYNTAX
	CLEAR kamer optie
CHAN_CLEARED_BANS
	Alle verbannenen van kamer %s kunnen weer binnengaan.
CHAN_CLEARED_EXCEPTIONS
	Alle uitzonderingen van %s zijn verwijderd.
CHAN_CLEARED_MODES
	Alle modes van kamer %s zijn teruggezet naar de 
	standaardwaardes.
CHAN_CLEARED_OPS
	Mode +o verwijderd in kamer %s.
CHAN_CLEARED_HALFOPS
	Mode +h verwijderd in kamer %s.
CHAN_CLEARED_VOICES
	Mode +v verwijderd in kamer %s.
CHAN_CLEARED_USERS
	Alle gebruikers zijn verwijderd uit kamer %s.

# GETPASS responses
CHAN_GETPASS_SYNTAX
	GETPASS kamer
CHAN_GETPASS_UNAVAILABLE
	GETPASS niet beschikbaar omdat versleuteling aan staat.
CHAN_GETPASS_PASSWORD_IS
	Wachtwoord van kamer %s is %s.

# FORBID responses
CHAN_FORBID_SYNTAX
	FORBID kamer
CHAN_FORBID_SUCCEEDED
	Kamer %s is nu onbruikbaar.
CHAN_FORBID_FAILED
	Kon kamer %s niet onbruikbaar maken!

# SUSPEND responses
CHAN_SUSPEND_SYNTAX
	SUSPEND [+vervaltijd] kamer reden
CHAN_SUSPEND_SUCCEEDED
	Kamer %s is buiten werking gesteld.
CHAN_SUSPEND_ALREADY_SUSPENDED
	Kamer %s is reeds buiten werking.

# UNSUSPEND responses
CHAN_UNSUSPEND_SYNTAX
	UNSUSPEND kamer
CHAN_UNSUSPEND_SUCCEEDED
	Kamer %s is niet langer buiten werking.
CHAN_SUSPEND_NOT_SUSPENDED
	Kamer %s is niet buiten werking.

# MODE responses
OPER_MODE_SYNTAX
	MODE kamer modes

###########################################################################
#
# DogTag help messages
#
###########################################################################

NICK_HELP
	%S geeft u de mogelijkheid een bijnaam te registreren 
	zodat anderen deze niet gebruiken kunnen. Als de bijnaam
	%d dagen niet wordt gebruikt verloopt de registratie.  
	De volgende commando's zijn beschikbaar; om ze te gebruiken
	typ /msg %S commando.
	Voor meer informatie over een bepaald commando, typ
	/msg %S HELP commando.
	
	    REGISTER   Registreer een bijnaam
	    IDENTIFY   Identificeer u met uw wachtwoord
	    ACCESS     Pas de lijst met addressen aan
	    LINK       Maak de bijnaam een alias voor een andere
	    SET        Verander opties, zoals kill protectie
	    DROP       Maak de registratie van een bijnaam ongedaan
	    RECOVER    Kill een gebruiker die uw bijnaam gebruikt
	    RELEASE    Eigen de bijnaam weer toe na RECOVER
	
	Andere commando's: UNLINK, UNSET, GHOST, INFO, LIST, LISTCHANS,
	                   STATUS
	
	OPMERKING: Deze Service is bedoeld om IRC gebruikers een 
	manier te geven om hun identiteit vast te leggen.
	Het is NIET bedoeld voor het "stelen" van bijnamen of
	andersoort misbruik.  Misbruik van %S resulteert,
	op z'n minst, in het verlies van de misbruikte 
	bijnaam/bijnamen.

NICK_HELP_EXPIRE_ZERO
	%S geeft u de mogelijkheid een bijnaam te registreren 
	zodat anderen deze niet gebruiken kunnen. De volgende 
	commando's zijn beschikbaar; om ze te gebruiken
	typ /msg %S commando.
	Voor meer informatie over een bepaald commando, typ
	/msg %S HELP commando.
	
	    REGISTER   Registreer een bijnaam
	    IDENTIFY   Identificeer u met uw wachtwoord
	    ACCESS     Pas de lijst met adressen aan
	    LINK       Maak de bijnaam een alias voor een andere
	    SET        Verander opties, zoals kill protectie
	    DROP       Maak de registratie van een bijnaam ongedaan
	    RECOVER    Verwijderd een gebruiker die uw bijnaam 
	                  gebruikt van het netwerk
	    RELEASE    Eigen de bijnaam weer toe na RECOVER
	
	Andere commando's: UNLINK, UNSET, GHOST, INFO, LIST, STATUS
	
	OPMERKING: Deze Service is bedoeld om IRC gebruikers een 
	manier te geven om hun identiteit vast te leggen.
	Het is NIET bedoeld voor het "stelen" van bijnamen of
	andersoort misbruik.  Misbruik van %S resulteert,
	op z'n minst, in het verlies van de misbruikte 
	bijnaam/bijnamen.

NICK_HELP_REGISTER
	Syntax: REGISTER wachtwoord [email]
	
	Registreerd uw bijnaam in de %S database.  Wanneer 
	uw bijnaam is geregistreerd kan u met de SET en 
	ACCESS commando's intellingen van uw bijnaam veranderen.
	Let op dat u het wachtwoord waarmee u geregistreerd heeft
	niet vergeet - u heeft deze nog nodig later. 
	(Let op dat type letters uitmaakt!  FIDO, Fido, en 
	fido zijn allen verschillende wachtwoorden!)
	
	U mag een e-mail adres invoeren bij het registreren; 
	dit kan ook naderhand door middel van het SET EMAIL
	commando.
	
	Regels voor het kiezen van een wachtwoord:
	
	Wachtwoorden moeten niet makkelijk te raden zijn.  
	Uw echte naam als wachtwoord nemen is bijvoorbeeld een 
	slecht idee. Uw bijnaam als wachtwoord is nog slechter ;)
	en %S zal dat ook niet toestaan.  Korte wachtwoorden zijn 
	gevaarlijk als iemand zomaar wat probeerd, daarom dient 
	uw wachtwoord minimaal 5 tekens te zijn.
	Het spatie teken kan niet gebruikt worden.

NICK_HELP_REGISTER_REQ_EMAIL
	Syntax: REGISTER wachtwoord email
	
	Registreerd uw bijnaam in de %S database.  Wanneer 
	uw bijnaam is geregistreerd kan u met de SET en 
	ACCESS commando's intellingen van uw bijnaam veranderen.
	Let op dat u het wachtwoord waarmee u geregistreerd heeft
	niet vergeet - u heeft deze nog nodig later. 
	(Let op dat type letters uitmaakt!  FIDO, Fido, en 
	fido zijn allen verschillende wachtwoorden!)
	
	U MOET een e-mail adres invoeren bij het registreren; 
	u kunt deze verbergen doormiddel van het HIDE commando
	(typ /msg %S HELP SET HIDE voor meer informatie).
	
	Regels voor het kiezen van een wachtwoord:
	
	Wachtwoorden moeten niet makkelijk te raden zijn.  
	Uw echte naam als wachtwoord nemen is bijvoorbeeld een 
	slecht idee. Uw bijnaam als wachtwoord is nog slechter ;)
	en %S zal dat ook niet toestaan.  Korte wachtwoorden zijn 
	gevaarlijk als iemand zomaar wat probeerd, daarom dient 
	uw wachtwoord minimaal 5 tekens te zijn.
	Het spatie teken kan niet gebruikt worden.

NICK_HELP_IDENTIFY
	Syntax: IDENTIFY wachtwoord
	
	Verteld %S dat u werkelijk de eigenaar bent van uw
	bijnaam.  Veel commando's kunnen pas gebruikt worden
	nadat u zich geindentificeerd heeft.  Het wachtwoord
	is de zelfde die u gebruikt heeft bij het REGISTER
	commando.

NICK_HELP_DROP
	Syntax: DROP
	
	Verwijderd uw bijnaam uit de %S database.  Een bijnaam
	die verwijderd is kan door iedereen geregistreerd worden.
	
	Om dit commando te gebruiken dient u zich eerst te 
	identificeren met uw wachtwoord (/msg %S HELP IDENTIFY
	voor meer informatie).

NICK_HELP_ACCESS
	Syntax: ACCESS ADD masker
	        ACCESS DEL masker
	        ACCESS LIST
	
	Veranderd of toont de toegangslijst van uw bijnaam.  Dit
	is de lijst met adressen die %S automatisch toestaat om
	uw bijnaam te gebruiken.  Wilt u uw bijnaam op een ander
	adres gebruiken dan dient u zich eerst te identificeren
	met IDENTIFY zodat %S u herkent.
	
	Voorbeelden:
	
	    ACCESS ADD achurch@*.dragonfire.net
	        Geeft toegang aan gebruiker achurch vanaf elke
	        machine in het dragonfire.net domein.
	
	    ACCESS DEL achurch@*.dragonfire.net
	        Verwijderd de vorige toevoeging.
	
	    ACCESS LIST
	        Toont de huidige toegangslijst.

NICK_HELP_LINK
	Syntax: LINK bijnaam wachtwoord
	
	Koppelt uw bijnaam aan een andere waardoor de bijnaam die
	u op dat moment gebruikt een alias wordt voor de gegeven 
	bijnaam.   Wanneer u dit commando geeft wordt de 
	toegangslijst van uw huidige bijnaam verwijderd en vervangen
	door de bijnaam die u koppelt; alle memo's van uw huidige 
	bijnaam worden aan de lijst van de andere naam toegevoegd
	(hierdoor kan de bijnaam teveel memo's hebben, in dat geval
	dient u er een aantal te verwijderen om meer memo's te 
	kunnen ontvangen met beide bijnamen).
	
	Wanneer de bijnamen gekoppeld zijn wordt uw bijnaam 
	onzichtbaar veranderd naar de andere bijnaam in K9 Services, 
	behalve voor de %S UNLINK en DROP commando's. 
	U kunt bijvoorbeeld beide bijnamen gebruiken om dezelfde 
	memo's te lezen (en memo's voor beide bijnamen komen in 
	dezelfde lijst).
	Als een van de bijnamen op een kamer toegangslijst staat 
	krijgen	beide bijnamen dezelfde rechten.  Let op, de 
	bijnamen vervallen onafhankelijk; wanneer u slechts 1 van 
	de gekoppelde bijnamen gebruikt vervallen alle anderen.  
	
	Om dit commando te gebruiken dient u te identificeren voor 
	uw huidige bijnaam (d.m.v. het IDENTIFY commando) en u 
	dient het wachtwoord voor de bijnaam waaraan u wilt linken 
	te geven.

NICK_HELP_UNLINK
	Syntax: UNLINK [bijnaam wachtwoord]
	
	Verwijderd de koppeling tussen 2 bijnamen.  Wanneer de 
	koppeling verwijderd is kunnen bijnaam opties en 
	toegangslijsten onafhankelijk veranderd worden.  Memo's 
	worden niet naar uw huidige bijnaam gekopieerd; deze blijven 
	allemaal bij de voorheen gekoppelde bijnaam.
	
	Wanneer een bijnaam en wachtwoord als parameters gegeven 
	worden kan een andere bijnaam dan uw huidige ontkoppeld 
	worden.

NICK_HELP_SET
	Syntax: SET optie parameters
	
	Veranderd verschillende bijnaam opties.  optie kan zijn:
	
	    PASSWORD   Verander uw bijnaam wachtwoord
	    LANGUAGE   Verander de taal waarin K9 Services u berichten
	                   stuurt
	    URL        Associeer een pagina met uw bijnaam
	    EMAIL      Associeer een E-mail adres met uw bijnaam
	    KILL       Zet kill protectie aan of uit
	    SECURE     Zet bijnaam beveiliging aan of uit
	    PRIVATE    Zorg dat uw bijnaam niet voorkomt in een
	                   /msg %S LIST
	    HIDE       Verberg bepaalde bijnaam informatie
	
	Om dit commando te gebruiken dient u zich eerst te 
	identificeren met uw wachtwoord (/msg %S HELP IDENTIFY
	voor meer informatie).
	
	Typ /msg %S HELP SET optie voor meer informatie over
	een bepaalde optie.

NICK_HELP_SET_PASSWORD
	Syntax: SET PASSWORD nieuw-wachtwoord
	
	Veranderd het wachtwoord waarmee u zich identificeerd als
	de eigenaar van uw bijnaam.

NICK_HELP_SET_LANGUAGE
	Syntax: SET LANGUAGE nummer
	
	Veranderd de taal waarin K9 Services berichten naar u stuurt
	(bijvoorbeeld als antwoord op een commando dat u geeft).
	nummer moet 1 van de volgende punten zijn:
	

NICK_HELP_SET_URL
	Syntax: SET URL pagina
	
	Associeerd de gegeven pagina met uw bijnaam.  Deze pagina
	wordt getoond wanneer iemand informatie opvraagd over uw
	bijnaam met het INFO commando.

NICK_HELP_SET_EMAIL
	Syntax: SET EMAIL adres
	
	Associeerd het gegeven E-mail adres met uw bijnaam.  Dit 
	adres wordt getoond wanneer iemand informatie opvraagd over
	uw bijnaam met het INFO commando.

NICK_HELP_SET_KILL
	Syntax: SET KILL {ON | QUICK | IMMED | OFF}
	
	Zet de automatische kill protectie voor uw bijnaam aan of 
	uit.
	Wanneer kill protectie aanstaat krijgt iemand die uw bijnaam
	wil gebruiken 60 seconden de tijd om te identificeren. Doet
	hij/zij dit niet dan wordt de persoon verwidjerd van het IRC 
	netwerk door %S.
	
	Als u QUICK selecteerd krijgt de gebruiker slechts 20 
	seconden de tijd. Wanneer u IMMED selecteerd wordt de 
	gebruiker meteen verwijderd van het netwerk zonder kans
	te krijgen om zijn/haar	bijnaam te veranderen; gebruik
	deze optie alleen in geval van nood. Uw netwerk 
	administrators kunnen deze optie uitgeschakeld hebben.

NICK_HELP_SET_SECURE
	Syntax: SET SECURE {ON | OFF}
	
	Zet %S's beveiligings optie aan voor uw bijnaam.  Wanneer
	SECURE aanstaat dient u zich met uw wachtwoord te 
	identificeren voor uw bijnaam of uw adres nu op de toegangs-
	lijst van de bijnaam staat of niet. Let op, wanneer uw adres
	op de toegangslijst van de bijnaam staat zal kill protectie 
	niet in werking treden, ook al heeft u deze aan gezet met 
	de KILL optie.

NICK_HELP_SET_PRIVATE
	Syntax: SET PRIVATE {ON | OFF}
	
	Zet de %S privé optie aan of uit voor uw bijnaam. Wanneer 
	PRIVATE aan staat zal uw bijnaam niet getoond worden in 
	een %S LIST. (Let op, iemand die uw bijnaam weet kan nog
	steeds informatie over u verkrijgen met het INFO commando.)

NICK_HELP_SET_HIDE
	Syntax: SET HIDE {EMAIL | USERMASK | QUIT} {ON | OFF}
	
	Voorkomt dat bepaalde informatie over u getoond wordt 
	wanneer iemand %S INFO van uw bijnaam opvraagd. U kunt uw
	E-mail adres (EMAIL), laatst gebruikte user@host masker 
	(USERMASK) en laatste vertrek boodschap (QUIT) verbergen. 
	De tweede parameter geeft aan of de informatie verborgen 
	(ON) of niet (OFF) moet worden.

NICK_HELP_UNSET
	Syntax: UNSET {URL | EMAIL}
	
	Geeft u de mogelijkheid de pagina en e-mail adres van uw 
	bijnaam te verwijderen.  Gebruik de URL parameter om 
	de pagina te verwijderen of de EMAIL parameter voor het 
	E-mail adres.
	U kunt niet beide tegelijkertijd verwijderen.

NICK_HELP_UNSET_REQ_EMAIL
	Syntax: UNSET URL
	
	Geeft u de mogelijkheid de pagina van uw bijnaam te 
	verwijderen.  De URL parameter moet gegeven worden.

NICK_HELP_RECOVER
	Syntax: RECOVER bijnaam [wachtwoord]
	
	Geeft u de mogelijkheid uw bijnaam te heroveren als iemand 
	anders hem gebruikt; Dit doet hetzelfde als %S automatisch 
	doet als iemand een bijnaam probeert te gebruiken waarbij 
	kill protectie aan staat.
	
	Wanneer het commando gegeven wordt brengt %S een nep 
	gebruiker online met de bijnaam die heroverd wordt. Dit 
	zorgt ervoor dat de IRC server de andere gebruiker 
	verwijderd van het netwerk.  De nep gebruiker blijft 1 
	minuut online om te zorgen dat de andere gebruiker niet 
	meteen weer terugkomt; na die minuut kunt u uw bijnaam weer 
	gebruiken.  
	Als u de bijnaam eerder wilt gebruiken kan dat met het 
	RELEASE commando (/msg %S HELP RELEASE).
	
	Om het RECOVER commando te gebruiken dient uw huidige 
	adres (zoals vermeld in /WHOIS) in de toegangslijst van de 
	bijnaam te staan of dient u het wachtwoord van de bijnaam 
	te geven.

NICK_HELP_RELEASE
	Syntax: RELEASE bijnaam [wachtwoord]
	
	Geeft %S opdracht om een bijnaam die vastgehouden wordt 
	door kill protectie of gebruik van RECOVER los te laten.
	Normaal wordt een bijnaam 1 minuut vastgehouden; dit 
	commando zorgt dat dit korter duurt.
	
	Om het RELEASE commando te gebruiken dient uw huidige 
	adres (zoals 
	vermeld in /WHOIS) in de toegangslijst van de bijnaam te 
	staan of dient u het wachtwoord van de	bijnaam te geven.

NICK_HELP_GHOST
	Syntax: GHOST nickname [password]
	
	Verwijderd een "spook" met uw bijnaam.  Een "spook" sessie 
	is een gebruiker die niet werkelijk aanwezig is, maar 
	waarvan de server denkt dat deze nog online is voor 1 of 
	andere reden. Mogelijke oorzaak kan een computercrash
	of modemstoring zijn.
	
	Om het GHOST commando te gebruiken dient uw huidige adres 
	(zoals vermeld in /WHOIS) in de toegangslijst van de bijnaam 
	te staan of dient u het wachtwoord van de bijnaam te geven.

NICK_HELP_INFO
	Syntax: INFO bijnaam [ALL]
	
	Geeft informatie over de gegeven bijnaam, zoals eigenaar, 
	laatst geziene hostmask en tijd en bijnaam opties. Als u
	geidentificeerd bent voor de bijnaam en de optie ALL
	meegeeft, wordt alle informatie getoond, of deze nu 
	verborgen is of niet.

NICK_HELP_LISTCHANS
	Syntax: LISTCHANS
	
	Geeft een lijst van de kamers die geregistreerd zijn onder 
	uw bijnaam.

NICK_HELP_LIST
	Syntax: LIST patroon
	
	Geeft een lijst van alle bijnamen met een bepaald patroon in de vorm
	bijnaam!gebruiker@host.  Bijnamen waarbij PRIVATE aan 
	staat worden niet getoond.
	
	Voorbeelden:
	
	    LIST *!joeuser@foo.com
	        Geeft alle bijnamen van joeuser@foo.com.
	
	    LIST *Bot*!*@*
	        Geeft alle geregistreerde bijnamen met Bot in de 
	        naam (hoofd of kleine letters).
	
	    LIST *!*@*.bar.org
	        Geeft alle bijnamen van gebruikers in het bar.org
	        domein.

NICK_HELP_STATUS
	Syntax: STATUS bijnaam...
	
	Verteld of de gebruiker van de bijnaam op dat moment de 
	eigenaar van die bijnaam is.  Dit in de volgende vorm:
	
	    bijnaam status-code
	
	Waar bijnaam de gegeven bijnaam is en status-code 1 van 
	de volgende:
	
	    0 - Gebruiker niet online of bijnaam niet geregistreerd
	    1 - Gebruiker niet herkend als eigenaar van de bijnaam
	    2 - Gebruiker alleen herkend via toegangslijst
	    3 - Gebruiker herkend door wachtwoord identificatie
	
	Maximaal 16 bijnamen mogen gegeven worden met dit commando; 
	de rest wordt genegeerd. Er wordt geen error gegeven als 
	geen bijnaam gegeven is.

NICK_SERVADMIN_HELP
	
	De volgende commando's zijn beschikbaar voor Cservice Members:
	
	    GETPASS     Verkrijg het wachtwoord van een bijnaam
	                    (alleen als versleuteling uitstaat)
	    SUSPEND     Zorg dat voor een bijnaam niet 
	                geindentificeerd kan worden
	    FORBID      Zorg dat een bijnaam niet gebruikt kan worden
	    LISTLINKS   Geef een lijst van bijnamen gekoppeld aan de gegeven
	                bijnaam
	
	Cservice Members kunnen ook de volgende commando's voor een 
	bijnaam gebruiken zonder hiervoor te hoeven identificeren:
	
	    DROP, SET, ACCESS LIST, INFO ALL
	
	Voor details, zie de help van de verschillende commando's.

NICK_SERVADMIN_HELP_DROP
	Syntax: DROP [bijnaam]
	
	Zonder parameter, verwijderd uw bijnaam uit de %S database.
	
	Met een parameter, verwijderd de gegeven bijnaam uit de
	database.
	Gebruik beperkt tot Cservice Members.

NICK_SERVADMIN_HELP_SET
	
	Cservice Members kunnen ook de optie NOEXPIRE gebruiken, 
	waarmee voorkomen kan worden dat bijnamen vervallen.
	Ook kunnen Cservice Members opties veranderen voor elke 
	bijnaam zonder wachtwoord op de volgende manier:
	SET bijnaam optie parameters.

NICK_SERVADMIN_HELP_SET_NOEXPIRE
	Syntax: SET [bijnaam] NOEXPIRE {ON | OFF}
	
	Stelt in of een bijnaam vervalt of niet. ON zorgt dat de 
	bijnaam niet vervalt.  Als geen bijnaam gegeven is wordt de
	instelling toegepast op uw eigen bijnaam.
	
	Beperkt tot Cservice Members.

NICK_SERVADMIN_HELP_UNSET
	
	Cservice Members mogen het UNSET commando voor elke bijnaam 
	gebruiken op dezelfde manier als bij het SET commando.

NICK_SERVADMIN_HELP_UNLINK
	
	Cservice Members kunnen elke bijnaam ontkoppelen zonder 
	wachtwoord.

NICK_SERVADMIN_HELP_LISTLINKS
	Syntax: LISTLINKS bijnaam [ALL]
	
	Geeft een lijst van bijnamen die aan de gegeven bijnaam 
	gekoppeld zijn.  Wanneer ALL is gegeven worden alle bijnamen met dezelfde 
	rechten als de gegeven bijnaam gegeven; anders worden alleen direct
	gekoppelde bijnamen gegeven.
	
	Beperkt tot Cservice Members.

NICK_SERVADMIN_HELP_ACCESS
	
	Cservice Members kunnen een bijnaam parameter meegeven aan 
	het LIST commando om de toegangslijst voor elke bijnaam te 
	bekijken.

NICK_SERVADMIN_HELP_INFO
	
	Cservice Members kunnen de parameter ALL gebruiken bij elke
	bijnaam.

NICK_SERVADMIN_HELP_LISTCHANS
	
	Cservice Members kunnen een lijst opvragen van elke bijnaam 
	door een bijnaam mee te geven (bijvoorbeeld, /msg DogTag 
	LISTCHANS AndereBijnaam).

NICK_SERVADMIN_HELP_LIST
	Syntax: LIST patroon [FORBIDDEN] [NOEXPIRE] [SUSPENDED]
	
	Geeft een lijst van alle bijnamen met een bepaald patroon 
	volgens nick!user@host.  Bijnamen met de PRIVATE optie 
	aan worden alleen getoond aan Cservice Members. Aan Cservice 
	Members worden bijnamen die op NOEXPIRE staan aangeduidt 
	met een ! en bijnamen die buiten gebruik zijn met een *.
	
	Als de optie FORBIDDEN, SUSPENDED of NOEXPIRE gegeven 
	is, worden alleen corresponderende bijnamen getoond. De 
	opties kunnen gebruikt worden in elke volgorde of combinatie en zijn alleen 
	beschikbaar voor Cservice Members.
	
	Voorbeelden:
	
	    LIST *!joeuser@foo.com
	        Geeft alle bijnamen van joeuser@foo.com.
	
	    LIST *Bot*!*@*
	        Geeft alle geregistreerde bijnamen met Bot in de 
	        naam (hoofd of kleine letters).
	
	    LIST * NOEXPIRE
	        Geeft alle geregistreerde bijnamen die op NOEXPIRE
			staan.

NICK_SERVADMIN_HELP_GETPASS
	Syntax: GETPASS nickname
	
	Toont het wachtwoord van de gegeven bijnaam.  Let op dat
	elke keer wanneer iemand dit commando uitvoerd dit getoond
	wordt als WALLOPS/GLOBOPS, inclusief degene die het commando 
	uitvoerd.
	
	Alleen voor Cservice Members.
	
	Dit commando is niet beschikbaar wanneer versleuteling aan staat.

NICK_SERVADMIN_HELP_FORBID
	Syntax: FORBID bijnaam
	
	Zorgt dat een bijnaam niet geregistreerd of gebruikt kan 
	worden. Kan ongedaan worden gemaakt met het %S 
	DROP commando.
	
	Alleen voor Cservice Members.

NICK_SERVADMIN_HELP_SUSPEND
	Syntax: SUSPEND [+verlooptijd] bijnaam reden
	
	Stelt een bijnaam, en alle bijnamen met dezelfde opper-
	bijnaam	tijdelijk buiten werking.
	Dit kan ongedaan worden gemaakt met het %S 
	UNSUSPEND commando.
	
	Anders dan bij een verboden bijnaam verliest een buiten 
	werking gestelde bijnaam zijn informatie niet en kan hij 
	vervallen!
	
	Beperkt tot Cservice Members.

NICK_SERVADMIN_HELP_UNSUSPEND
	Syntax: UNSUSPEND bijnaam
	
	Maakt buitenwerkstelling van een bijnaam ongedaan.
	
	Beperkt tot Cservice Members.


###########################################################################
#
# ChanServ help messages
#
###########################################################################

CHAN_HELP
	%S Geeft u de mogelijkheid om kamers te registreren en te 
	beheren.  %S kan vaak voorkomen dat kwaadwillende gebruikers
	een kamer "overnemen" door het aantal operators te limiteren.
	Beschikbare commando's staan hieronder vermeld; om ze te
	gebruiken, typ /msg %S command.  Voor meer informatie 
	over een specifiek commando, typ /msg %S HELP commando.
	
	    REGISTER   Registreer een kamer
	    IDENTIFY   Identificeer uzelf met uw wachtwoord
	    DROP       Verwijder een kamer uit de database
	    INFO       Toon kamer opties en informatie
	    SET        Verander kamer opties en informatie
	    ACCESS     Bewerk de globale kamer toeganglijst
	    SOP        Bewerk de SuperOp lijst
	    AOP        Bewerk de AutoOp lijst
	    VOP        Bewerk de AutoVoice lijst
	    AKICK      Bewerk de AutoKick lijst

CHAN_HELP_OTHERS
	
	Andere commando's: UNSET, LIST, INVITE, UNBAN, CLEAR,
	                LEVELS, OP, DEOP, VOICE, DEVOICE

CHAN_HELP_OTHERS_HALFOP_CHANPROT
	
	Andere commando's: UNSET, LIST, INVITE, UNBAN, CLEAR,
	                LEVELS, OP, DEOP, VOICE, DEVOICE,
	                HALFOP, DEHALFOP, PROTECT, DEPROTECT,
	                HOP

CHAN_HELP_EXPIRES
	
	Let op dat elke kamer die niet gebruikt wordt voor %d 
	dagen (niemand van de toegangslijst komt binnen)
	automatisch vervalt.

CHAN_HELP_REGISTER
	Syntax: REGISTER kamer wachtwoord beschrijving
	
	Registreert een kamer in de %S database.  Om dit
	commando te kunnen gebruiken dient u eerst operator te
	zijn in de kamer die u wilt registreren.
	Het wachtwoord wordt gebruikt met het IDENTIFY commando
	zodat u achteraf instellingen van de kamer kunt veranderen.
	De laatste parameter, die gegeven moet worden, is een
	beschrijving van het doel van de kamer.
	
	Wanneer u een kamer registreerd, wordt u gezien als de 
	eigenaar van de kamer. De kamer eigenaar kan alle 
	instellingen van de kamer veranderen; %S geeft de eigenaar 
	ook autmatisch operator status wanneer hij/zij de kamer
	binnenkomt.
	Zie het ACCESS commando (/msg %S HELP ACCESS) voor
	informatie over het geven van delen van deze rechten aan
	andere kamer gebruikers.
	
	OPMERKING: Om een kamer te registreren dient uw bijnaam
	geregistreerd te zijn. Wanneer u dit nog niet gedaan heeft
	kunt u via /msg %s HELP informatie hierover krijgen.

CHAN_HELP_IDENTIFY
	Syntax: IDENTIFY kamer wachtwoord
	
	Identificeerd uzelf in %S als de eigenaar van de gegeven
	kamer.  Veel commando's kunnen pas uitgevoerd worden nadat
	u dit commando heeft gebruikt. Het wachtwoord is hetzelfde
	als dat u met het REGISTER commando gebruikt heeft.

CHAN_HELP_DROP
	Syntax: DROP kamer
	
	Verwijderd een kamer.  Kan alleen gebruikt worden door de 
	kamer eigenaar, die eerst het IDENTIFY commando gebruikt
	heeft.

CHAN_HELP_SET
	Syntax: SET kamer optie parameters
	
	Geeft de kamer eigenaar de mogelijkheid om verschillende 
	opties te veranderen. De eigenaar moet het IDENTIFY
	commando gebruiken voor het gebruik van SET.
	
	Beschikbare opties:
	
	    FOUNDER     Verandert de eigenaar van een kamer
	    SUCCESSOR   Verandert de opvolger van de kamer
	    PASSWORD    Verandert het eigenaar wachtwoord
	    DESC        Verandert de kamer omschrijving
	    URL         Associeert een pagina met de kamer
	    EMAIL       Associeert een E-mail adres met de kamer
	    ENTRYMSG    Stelt een welkomstboodschap in voor wie
	                        de kamer binnenkomt
	    TOPIC       Verandert het onderwerp van de kamer
	    KEEPTOPIC   Behoud het onderwerp wanneer de kamer niet
	                        gebruikt wordt
	    TOPICLOCK   Onderwerp kan alleen veranderd worden met 
	                        SET TOPIC
	    MLOCK       Zet een slot op bepaalde kamer modes
	    PRIVATE     Verbergt de kamer voor het LIST commando
	    RESTRICTED  Beperkt toegang tot de kamer
	    SECURE      Activeert %S beveiliging opties
	    SECUREOPS   Strengere controle op operator status
	    LEAVEOPS    Operator status wordt niet afgenomen bij 
	                        binnenkomst
	    OPNOTICE    Geeft een waarschuwing wanneer OP/DEOP 
	                        commando's gebruikt worden
	    ENFORCE     Behoudt auto-op en auto-voice in de kamer.
	
	Typ /msg %S HELP voor meer informatie over een 
	bepaald commando.

CHAN_HELP_SET_FOUNDER
	Syntax: SET kamer FOUNDER bijnaam
	
	Verandert de eigneaar van een kamer.  De nieuwe bijnaam moet
	een geregistreerde zijn.

CHAN_HELP_SET_SUCCESSOR
	Syntax: SET kamer SUCCESSOR bijnaam
	
	Verandert de opvolger van een kamer. Als de eigenaar
	bijnaam vervalt of verwijderd wordt als de kamer nog is
	geregistreerd wordt de opvolger de nieuwe eigenaar van de 
	kamer.  Let op, als de opvolger al te vele kamers op zijn
	naam heeft staan (%d), wordt de kamer verwijderd, alsof
	er geen opvolger in was gesteld.
	De nieuwe bijnaam moet geregistreerd zijn.

CHAN_HELP_SET_PASSWORD
	Syntax: SET kamer PASSWORD wachtwoord
	
	Verandert het wachtwoord waarmee de eigenaar zich moet 
	identificeren.

CHAN_HELP_SET_DESC
	Syntax: SET channel DESC description
	
	Verandert de beschrijving van de kamer, die getoond wordt
	in de LIST en INFO commando's.

CHAN_HELP_SET_URL
	Syntax: SET kamer URL pagina
	
	Associeert de gegeven pagina met de kamer.  Deze pagina
	wordt getoond wanneer iemand informatie over de kamer 
	opvraagt met het INFO commando.

CHAN_HELP_SET_EMAIL
	Syntax: SET kamer EMAIL adres
	
	Associeert het gegeven E-mail adres met de kamer.  Dit
	adres wordt getoond wanneer iemand informatie over de 
	kamer opvraagt met het INFO commando.

CHAN_HELP_SET_ENTRYMSG
	Syntax: SET kamer ENTRYMSG bericht
	
	Verandert het bericht dat gebruikers via /notice krijgen
	als zij de kamer binnenkomen.

CHAN_HELP_SET_TOPIC
	Syntax: SET kamer TOPIC onderwerp
	
	Zorgt dat %S het onderwerp in de kamer veranderd.  Dit
	commando is nuttig bij het gebruik van SET TOPICLOCK.

CHAN_HELP_SET_KEEPTOPIC
	Syntax: SET kamer KEEPTOPIC {ON | OFF}
	
	Schakeld de onderwerp behoud optie van een kamer aan
	of uit.  Wanneer onderwerp behoud aan staat, onthoudt
	%S het onderwerp, zelfs nadat de laaste gebruiker de
	kamer verlaat, en deze zal teruggezet worden wanneer er 
	weer iemand binnenkomt.

CHAN_HELP_SET_TOPICLOCK
	Syntax: SET kamer TOPICLOCK {ON | OFF}
	
	Schakelt de onderwerp slot optie can een kamer aan
	 of uit.  Wanneer onderwerp slot aan staat, zal
	%S niet toestaan dat het onderwerp van de kamer veranderd
	wordt, anders dan met het SET TOPIC commando.

CHAN_HELP_SET_MLOCK
	Syntax: SET kamer MLOCK modes
	
	Stelt de mode-slot optie van een kamer in. %S kan ervoor 
	zorgen dat bepaalde kamer modes altijd ana of uit staan.
	De modes die in het slot kunnen worden geplaatst zijn i,
	 k, l, m, n, p, s, en t; elke van deze modes
	kunnen altijd aan, altijd uit, of buiten het slot worden
	geplaatst.  De modes parameter werkt het zelfde als het 
	/MODE commando; wat inhoud dat modes die volgen op een + 
	altijd aangezet worden en modes volgend op een - altijd uit.
	
	Waarschuwing: Wanneer u mode k in het slot plaatst, 
	zoals in voorbeeld twee hieronder, dient u ook de 
	RESTRICTED optie aan te zetten voor de kamer (zie HELP 
	SET RESTRICTED), anders kan een ieder die de kamer 
	binnenkomt als deze leeg is de sleutel zien!
	
	Voorbeelden:
	
	    SET #channel MLOCK +nt-iklps
	        Zet modes n en t altijd aan, en modes i, k, l, p, en
	        s altijd uit.  Mode m is gewoon te veranderen.
	
	    SET #channel MLOCK +knst-ilmp mijn-sleutel
	        Zet modes k, n, s, en t altijd aan, en modes i, l, m,
	        en p altijd uit.  Tevens blijft de kamersleutel 
	        altijd op"mijn-sleutel" staan.
	
	    SET #channel MLOCK +
	        Verwijdert het mode slot; alle kamermodes zijn vrij 
	        aan of uit te zetten.

CHAN_HELP_SET_PRIVATE
	Syntax: SET kamer PRIVATE {ON | OFF}
	
	Zet de privé optie van een kamer aan of uit.
	Wanneer privé aan staat zal de kamer niet getoond worden 
	in een /msg %S LIST.

CHAN_HELP_SET_RESTRICTED
	Syntax: SET channel RESTRICTED {ON | OFF}
	
	Zet de beperkte toegang optie van een kamer aan of uit.
	Wanneer beperkte toegang aan staat kunnen gebruikers die
	normaal geen kamer operator status mogen hebben (gebruikers 
	met negatieve toegangslevels of, wanneer secure ops aan 
	staat, gebruikers die niet op de toegangslijst staan) de 
	kamer niet binnen gaan.

CHAN_HELP_SET_SECURE
	Syntax: SET kamer SECURE {ON | OFF}
	
	Zet de beveiligings optie van een kamer aan of uit.
	Wanneer SECURE aanstaat krijgen alleen gebruikers met 
	geregistreerde bijnamen waarvoor ze zich geindentificeerd 
	rechten volgens de toegangslijst. 

CHAN_HELP_SET_SECUREOPS
	Syntax: SET kamer SECUREOPS {ON | OFF}
	
	Zet de operator beveilging optie van een kamer aan of uit.
	Wanneer operator beveilging aan staat kunnen mensen de 
	niet op de auto-op lijst staan geen operator status krijgen.

CHAN_HELP_SET_LEAVEOPS
	Syntax: SET kamer LEAVEOPS {ON | OFF}
	
	Zet de operator behoud optie van een kamer aan of uit.
	Wanneer operator behoud aan staat zal %S de operator 
	status van iemand die als eerste de kamer binnen komt niet
	afnemen, ookal zou de gebruiker normaal geen auto-op krijgen.
	De SECUREOPS optie en AUTODEOP toegangslevel worden nog wel
	toegepast.
	Opmerking:  Dit kan er voor zorgen dat gebruikers operator 
	status "stelen" na een netsplit.

CHAN_HELP_SET_OPNOTICE
	Syntax: SET kamer OPNOTICE {ON | OFF}
	
	Zet de operator-alarm optie van een kamer aan of uit.
	Wanneer operator-alarm aan staat, geeft %S een melding aan de
	kamer wanneer de OP of DEOP commando's gebruikt worden
	voor iemand in de kamer.

CHAN_HELP_SET_ENFORCE
	Syntax: SET kamer ENFORCE {ON | OFF}
	
	Zet de behoud optie van een kamer aan of uit.
	Wanneer behoud aan staat, zal %S auto-op en auto-voice 
	levels van alle gebruikers naleven.  Bijvoorbeeld, als een 
	gebruiker met auto-op rechten operator status verliest, zal 
	%S deze automatisch teruggeven, en %S zal ook het 
	DEOP commando niet toestaan op de betreffende gebruiker.

CHAN_HELP_UNSET
	Syntax: UNSET kamer {SUCCESSOR | URL | EMAIL | ENTRYMSG}
	
	Verwijdert de gegeven optie van een kamer.

CHAN_HELP_SOP
	Syntax: SOP kamer ADD bijnaam
	        SOP kamer DEL bijnaam
	        SOP kamer LIST [masker | list]
	        SOP kamer COUNT
	
CHAN_HELP_SOP_NOPROT
	Berwerkt de SuperOp (SOP) lijst van een kamer.
	Gebruikers met SOP status krijgen autmatisch operator
	status (mode +o) wanneer zij de kamer binnengaan.
CHAN_HELP_SOP_PROT
	Berwerkt de SuperOp (SOP) lijst van een kamer.
	Gebruikers met SOP status krijgen autmatisch operator
	status (mode +o) en bescherming (mode +a) wanneer zij de 
	kamer binnengaan.
CHAN_HELP_SOP_END
	
	Een SOP kan de AOP en VOP lijsten bewerken. Alleen
	de kamer eigenaar kan de SOP lijst bewerken.
	
	Het SOP LIST commando toont de SOP lijst.  Wanneer een
	masker wordt gegeven, worden alleen die invoeren getoond.  
	Wanneer een lijst van invoernummers gegeven wordt,
	worden alleen deze invoeren getoond; bijvoorbeeld:
	
	   SOP #channel LIST 2-5,7-9
	      Geeft SOP lijst invoeren 2 tot en met 5 en
	      7 tot en met 9.
	
	Het SOP COUNT commando geeft het aantal invoeren op de
	SOP lijst.

CHAN_HELP_AOP
	Syntax: AOP kamer ADD bijnaam
	        AOP kamer DEL bijnaam
	        AOP kamer LIST [masker | lijst]
	        AOP kamer COUNT
	
	Bewerkt de AutoOp (AOP) lijst van een kamer.
	Gebruikers met AOP status krijgen automatisch operator
	status (mode +o) wanneer zij de kamer binnengaan.
	
	Een AOP kan de VOP lijst bewerken.
	
	Het AOP LIST commando toont de AOP lijst.  Wanneer een
	masker wordt gegeven, worden alleen die invoeren getoond.  
	Wanneer een lijst van invoernummers gegeven wordt,
	worden alleen deze invoeren getoond; bijvoorbeeld:
	
	   AOP #channel LIST 2-5,7-9
	      Geeft AOP lijst invoeren 2 tot en met 5 en
	      7 tot en met 9.
	
	Het AOP COUNT commando geeft het aantal invoeren op de
	AOP lijst.

CHAN_HELP_HOP
	Syntax: HOP kamer ADD bijnaam
	        HOP kamer DEL bijnaam
	        HOP kamer LIST [masker | list]
	        HOP kamer COUNT
	
	Bewerkt de HalfOp (HOP) lijst van een kamer.
	Gebruikers met HOP status krijgen automatisch halfop
	status (mode +h) wanneer zij de kamer binnengaan.
	
	Een HOP kan de VOP lijst bewerken; SOPs en AOPs kunnen
	de HOP lijst bewerken.
	
	Het HOP LIST commando toont de HOP lijst.  Wanneer een
	masker wordt gegeven, worden alleen die invoeren getoond.  
	Wanneer een lijst van invoernummers gegeven wordt,
	worden alleen deze invoeren getoond; bijvoorbeeld:
	
	   HOP #channel LIST 2-5,7-9
	      Geeft HOP lijst invoeren 2 tot en met 5 en
	      7 tot en met 9.
	
	Het HOP COUNT commando geeft het aantal invoeren op de
	HOP lijst.

CHAN_HELP_VOP
	Syntax: VOP kamer ADD bijnaam
	        VOP kamer DEL bijnaam
	        VOP kamer LIST [masker | list]
	        VOP kamer COUNT
	
	Bewerkt de HalfOp (VOP) lijst van een kamer.
	Gebruikers met VOP status krijgen automatisch voice
	(mode +v) wanneer zij de kamer binnengaan.
	
	Het VOP LIST commando toont de HOP lijst.  Wanneer een
	masker wordt gegeven, worden alleen die invoeren getoond.  
	Wanneer een lijst van invoernummers gegeven wordt,
	worden alleen deze invoeren getoond; bijvoorbeeld:
	
	   VOP #channel LIST 2-5,7-9
	      Geeft VOP lijst invoeren 2 tot en met 5 en
	      7 tot en met 9.
	
	Het VOP COUNT commando geeft het aantal invoeren op de
	VOP lijst.

CHAN_HELP_ACCESS
	Syntax: ACCESS kamer ADD bijnaam level
	        ACCESS kamer DEL {bijnaam | invoer-num | list}
	        ACCESS kamer LIST [masker | list]
	        ACCESS kamer COUNT
	
	Bewerkt de toegang lijst van een kamer. De toegang lijst
	houdt bij welke gebruikers toegang hebben tot operator 
	status en %S commando's in de kamer.  Verschillende 
	gebruiker levels geven de mogelijkheid toegang te geven tot 
	verschillende onderdelen van rechten;  /msg %S HELP 
	ACCESS LEVELS voor meer specifieke informatie.  Elke 
	bijnaam die niet op de toegang lijst staat heeft level 0.
	
	Let op, de toegangslijst kan ook berwerkt worden met de 
	SOP, AOP, en VOP commando's, welke respectievelijk 
	corresponderen met levels %d, %d, en %d.
	
	Het ACCESS ADD commando voegt de gegeven bijnaam toe aan 
	de toegangslijst met het gegeven toegangslevel; wanneer de 
	bijnaam al op de lijst staat wordt het toegangslevel 
	veranderd naar de gegeven waarde.  Het gegeven level dient
	lager te zijn dan dat van de gebruiker die het commando 
	geeft, en als de bijnaam al op de toegangslijst staat 
	dient zijn/haar level lager te zijn dan dat van de gebruiker
	die het commando geeft.
	
	Het ACCESS DEL commando verwijdert de gegeven bijnaam uit 
	de toegangslijst.  Wanneer een lijst van invoer nummers 
	wordt gegeven, worden deze verwijderd.  (Zie de voorbeelden 
	van LIST hieronder.)
	
	Het ACCESS LIST commando toont de toegangslijst.  Wanneer
	een masker gegeven wordt, worden alleen de invoeren volgens 
	het masker getoond.  Wanneer een lijt van invoernummers 
	gegeven wordt, worden alleen deze invoeren getoond.; 
	bijvoorbeeld:
	
	   ACCESS #channel LIST 2-5,7-9
	      Geeft toegangslijst invoeren 2 tot en met 5 en
	      7 tot en met 9.
	
	Het ACCESS COUNT commando geeft het aantal invoeren in de 
	toegangslijst.

CHAN_HELP_ACCESS_LEVELS
	Gebruiker toegangs levels
	
	Standaard zijn de volgende toegangs levels gedefinieerd:
	
	   Eigenaar   Volledige toegang tot %S functies; automatisch 
	                     operator status bij binnenkomst.  Let 
	                     op dat slechts 1 gebruiker als eigenaar 
	                     ingesteld kan worden (het kan niet 
	                     gegeven worden met het ACCESS 
	                     commando).
	      %4d   Toegang tot AKICK commando; automatische 
	                     operator status.
	      %4d   Automatische operator status.
	      %4d   Automatische voice.
	         0   Geen speciale rechten; kan ops krijgen van 
	                     anderen (behalve wanneer SECUREOPS 
	                     aan staat).
	        <0   Mag geen operator status krijgen.
	
	Deze levels kunnen veranderd worden, of aangevuld, met het 
	LEVELS commando; typ /msg %S HELP LEVELS voor informatie.

CHAN_HELP_AKICK
	Syntax: AKICK kamer ADD masker [reden]
	        AKICK kamer DEL masker
	        AKICK kamer LIST [masker | lijst]
	        AKICK kamer VIEW [masker | lijst]
	        AKICK kamer ENFORCE
	        AKICK kamer COUNT
	
	Bewerkt de AutoKick lijst van een kamer.  Wanneer een
	gebruiker op de AutoKick de kamer probeert binnen te gaan
	zal %S de gebruiker vna de kamer verwijderen en verbannen.
	
	Het AKICK ADD commando voegt een bijnaam of masker toe aan
	de AutoKick lijst.  Wanneer een reden wordt gegeven wordt
	deze als kick-boodschap gebruikt; zo niet, de standaard rede
	is "You have been banned from the channel".
	
	Het AKICK DEL commando verwijderd de gegeven bijnaam of 
	masker van de AutoKick lijst.  Het verwijderd echter geen 
	verbanningen die door AutoKick zijn geplaatst; deze dienen 
	handmatig verwijderd te worden.
	
	Het AKICK LIST commando toont de AutoKick lijst, of
	of alleen de AutoKick invoeren met het gegeven masker. 
	AKICK VIEW toont meer details.
	
	Het AKICK ENFORCE commando zoregt dat %S de huidige 
	AutoKick lijst uitvoerd door alle gebruikers die in de lijst
	staan te verwijderen uit de kamer.
	
	Het AKICK COUNT commando toont het aantal invoeren op de 
	AutoKick lijst.

CHAN_HELP_LEVELS
	Syntax: LEVELS kamer SET type level
	        LEVELS kamer {DIS | DISABLE} type
	        LEVELS kamer LIST
	        LEVELS kamer RESET
	
	Met het LEVELS commando kunnen de kamer toegangslevels 
	gebruikt door het ACCESS commando nauwkeurig bewerkt worden.  Met dit 
	commando kunt u de het vereisde toegangslevel voor de meeste
	van %S's functies bepalen. (De SET FOUNDER en SET PASSWORD
	commando's, en dit commando, kunnen alleen door de eigenaar 
	gebruikt worden.)
	
	PAS OP:  Dit commando is alleen voor gevorderde gebruikers!  Het 
	veranderen van level instellingen kan ervoor zorgen dat de 
	SOP, AOP en VOP commando's niet meer goed werken.
	
	LEVELS SET geeft de mogelijkheid om het toegangslevel voor
	een functie of groep van functies te veranderen. 
	LEVELS DISABLE (of DIS in het kort) schakelt een 
	automatische instelling	uit of maakt een bepaalde funcite 
	alleen toegangkelijk tot de kamer eigenaar.
	LEVELS LIST toont de huidige levels voor elke functie of 
	groep van functies.  LEVELS RESET herstelt de levels naar 
	de standaardwaardes voor een nieuwe kamer (zie HELP ACCESS 
	LEVELS).
	
	Voor de lijst van functies waarvan levels veranderd kunnen 
	worden, zie HELP LEVELS DESC.

CHAN_HELP_LEVELS_DESC
	De volgende functienamen zijn bekend.  Let op dat de levels voor
	AUTODEOP en NOJOIN maximum levels zijn, terwijl de anderen minimum 
	levels zijn.

CHAN_HELP_LEVELS_DESC_FORMAT
	    %-*s  %s

CHAN_HELP_INFO
	Syntax: INFO kamer [ALL]
	
	Geeft informatie over de gegeven geregistreerde kamer, 
	inclusief eigenaar, tijd van registratie, laatst gebruikte 
	tijd en mode-slot, als deze ingesteld is.  Als u 
	geidentificeerd bent als de kamer eigenaar van de gegeven 
	kamer en u geeft de parameter ALL mee, worden ook de kamer
	opvolger en binnenkomst bericht getoond.

CHAN_HELP_LIST
	Syntax: LIST patroon
	
	Geeft een lijst van alle geregistreerde kamers volgens een 
	bepaald patroon. (Kamers waar de PRIVATE optie aanstaat 
	worden niet getoond.)

CHAN_HELP_OP
	Syntax: OP #kamer bijnaam
	
	Geeft de gegeven gebruiker operator status in een kamer.  
	Standaard alleen beschikbaar voor gebruikers met 
	toegangslevel 5 of hoger in de kamer.

CHAN_HELP_DEOP
	Syntax: DEOP #kamer bijnaam
	
	Verwijdert de operator status van de gegeven gebruiker in 
	een kamer. Standaard alleen beschikbaar voor gebruikers met 
	toegangslevel 5 of hoger in de kamer.

CHAN_HELP_VOICE
	Syntax: VOICE #kamer bijnaam
	
	Geeft de gegeven gebruiker voice in een kamer.  Standaard 
	alleen beschikbaar voor gebruikers met toegangslevel 3 of 
	hoger in de kamer.

CHAN_HELP_DEVOICE
	Syntax: DEVOICE #kamer bijnaam
	
	Verwijdert de voice van de gegeven gebruiker in een kamer.  
	Standaard alleen beschikbaar voor gebruikers met 
	toegangslevel 3 of hoger in de kamer.

CHAN_HELP_HALFOP
	Syntax: HALFOP #kamer bijnaam
	
	Geeft de gegeven gebruiker halfop status in een kamer.  
	Standaard alleen beschikbaar voor gebruikers met 
	toegangslevel 4 of hoger in de kamer.

CHAN_HELP_DEHALFOP
	Syntax: DEHALFOP #kamer bijnaam
	
	Verwijdert de halfop status van de gegeven gebruiker in een 
	kamer. Standaard alleen beschikbaar voor gebruikers met 
	toegangslevel 4 of hoger in de kamer.

CHAN_HELP_PROTECT
	Syntax: PROTECT #kamer bijnaam
	
	Geeft de gegeven gebruiker protection (mode +a) in een kamer.  
	Standaard alleen beschikbaar voor gebruikers met 
	toegangslevel 10 of hoger in de kamer.

CHAN_HELP_DEPROTECT
	Syntax: DEPROTECT #kamer bijnaam
	
	Verwijdert de protection (mode +a) van de gegeven gebruiker 
	in een kamer.  Standaard alleen beschikbaar voor gebruikers 
	met toegangslevel 10 of hoger in de kamer.

CHAN_HELP_INVITE
	Syntax: INVITE kamer
	
	Zorgt dat %S u uitnodigt voor de gegeven kamer.  Standaard 
	werkt dit alleen als uw toegangslevel minstens 5 is.

CHAN_HELP_UNBAN
	Syntax: UNBAN kamer
	
	Zorgt dat %S alle verbanningen van u verwijderd uit de 
	gegeven kamer. Standaard werkt dit alleen als uw 
	toegangslevel minstens 5 is.

CHAN_HELP_CLEAR
	Syntax: CLEAR kamer wat
	
	Zorgt dat %S een bepaald iets verwijderd van de gegeven 
	kamer.  wat
	kan één van de volgende dingen zijn:
	
	     MODES       Verwijdert alle modes op de kamer behalve 
	                     die in het mode-slot.
	     BANS        Verwijdert alle verbanningen in de kamer.
CHAN_HELP_CLEAR_EXCEPTIONS
	     EXCEPTIONS  Verwijdert alle uitzonderingen in de kamer.
CHAN_HELP_CLEAR_MID
	     OPS         Verwijdert operator status (mode +o) van
	                     alle gebruikers.
CHAN_HELP_CLEAR_HALFOPS
	     HALFOPS     Verwijdert halfop status (mode +h) van
	                     alle gebruikers.
CHAN_HELP_CLEAR_END
	     VOICES      Verwijdert "voice" status (mode +v) van
	                     alle gebruikers.
	     USERS       Verwijdert (kicks) alle gebruikers van de 
	                     kamer.
	
	Standaard dient uw toegangslevel minimaal 10 te zijn voor 
	dit commando.

CHAN_SERVADMIN_HELP
	
	De volgende commando's zijn beschikbaar voor Cservice Members:
	
	    GETPASS   Verkrijg het eigenaar wachtwoord van een kamer
	                  (alleen wanneer versleuteling uit staat)
	    FORBID    Voorkom dat een kamer wordt geregistreerd/
	                  gebruikt
	    SUSPEND   Voorkom dat een geregistreerde kamer wordt 
	                  gebruikt
	    STATUS    Toont het huidige toegangslevel van een 
	                  gebruiker in een kamer
	
	Cservice Members kunnen ook een kamer verwijderen zonder gebruik 
	van een wachtwoord, en zij kunnen de ACCESS, AKICK en LEVEL 
	lijsten van elke kamer bekijken.

CHAN_SERVADMIN_HELP_DROP
	Syntax: DROP channel
	
	Verwijdert de gegeven kamer. Alleen Cservice Members
	kunnen een kamer verwijderen waar zij zich niet voor 
	geidentificeerd hebben.
	
CHAN_SERVADMIN_HELP_SET
	
	Cservice Members kunnen ook de optie NOEXPIRE gebruiken,
	waarmee voorkomen kan worden dat kamers vervallen. Ook 
	kunnen Cservice Members opties voor elke kamer veranderen 
	zonder wachtwoord identificatie voor de kamer.

CHAN_SERVADMIN_HELP_UNSET
	
	Net zoals bij het SET commando kunnen Cservice Members opties wissen
	voor elke kamer zonder wachtwoord identificatie voor de 
	kamer.

CHAN_SERVADMIN_HELP_SET_NOEXPIRE
	Syntax: SET kamer NOEXPIRE {ON | OFF}
	
	Stelt in of de gegeven kamer zal vervallen.  De optie ON 
	voorkomt dat de kamer vervalt.
	
	Beperkt tot Cservice Members.

CHAN_SERVADMIN_HELP_INFO
	
	Cservice Members kunnen de ALL parameter gebruiken bij elke
	kamer.

CHAN_SERVADMIN_HELP_LIST
	Syntax: LIST patroon [FORBIDDEN] [NOEXPIRE] [SUSPENDED]
	
	Geeft een lijst van alle geregistreerde kamers volgens het 
	gegeven patroon. Kamers die de PRIVATE optie aan hebben 
	staan worden alleen aan Cservice Members getoond. Kamers die 
	de NOEXPIRE optie aan hebben staan hebben een ! voor de 
	kamernaam staan voor Cservice Members.
	
	Wanneer de FORBIDDEN, SUSPENDED of NOEXPIRE optie is 
	gegeven, worden alleen kamers getoond die respectievelijk 
	verboden zijn, buiten werking zijn gesteld of niet vervallen. De opties kunnen gebruikt 
	worden in elke volgorde en combinatie. Deze opties zijn 
	alleen beschikbaar voor Cservice Members.

CHAN_SERVADMIN_HELP_GETPASS
	Syntax: GETPASS kamer
	
	Geeft het wachtwoord van de gegeven kamer.  Let op dat
	wanneer dit commando gebruikt wordt er een bericht met onder
	andere de persoon die het commando gebruikt en de kamer 
	waarvoor het gebruikt werd opgeslagen wordt en verstuurd als
	WALLOPS/GLOBOPS.
	
	Beperkt tot Cservice Members.

CHAN_SERVADMIN_HELP_FORBID
	Syntax: FORBID kamer
	
	Verbied iedereen de gegeven kamer te gebruiken of
	registreren.  Kan ongedana worden gemaakt door de kamer
	te verwijderen.
	
	Beperkt tot Cservice Members.

CHAN_SERVADMIN_HELP_SUSPEND
	Syntax: SUSPEND [+vervaltijd] kamer reden
	
	Voorkomt dat een kamer wordt gebruikt of voor wordt 
	geindentificeerd door wie dan ook. Dit kan ongedaan 
	worden gemaakt met het UNSUSPEND commando.
	
	Anders dan bij een verboden kamer verliest een buiten 
	werking gestelde kamer zijn informatie niet en zal deze 
	vervallen.
	
	Beperkt tot Cservice Members.

CHAN_SERVADMIN_HELP_UNSUSPEND
	Syntax: UNSUSPEND kamer
	
	Maakt het weer mogelijk om een voorheen buiten werking 
	gestelde kamer te gebruiken en voor te identificeren.
	
	Beperkt tot Cservice Members.

CHAN_SERVADMIN_HELP_STATUS
	Syntax: STATUS kamer bijnaam
	
	Geeft het huidige toegangslevel van de gegeven bijnaam in
	de gegeven kamer.  Dit in de vorm:
	
	    STATUS kamer bijnaam toegang-level
	
	Wanneer er een fout optreed, wordt deze op de volgende 
	   manier getoond:
	
	    STATUS ERROR fout-bericht
	
	Beperkt tot Cservice Members.


CHAN_GENPASS_SYNTAX
	GENPASS channel

CHAN_SERVADMIN_HELP_GENPASS
	Syntax: GENPASS channel
	
	Generates a random password and emails it to the registered 
	email address. 
	
	Limited to Cservice Members.

CHAN_CSCHAN_GENPASS
	Sorry you are not permitted to use GENPASS on #Doghouse

CHAN_AOCHAN_GENPASS
	Sorry you are not permitted to use GENPASS on #Nuthouse

CHAN_GENPASS_OK
	A new password was emailed to: %s

NICK_GENPASS_SYNTAX
	GENPASS nickname

NICK_SERVADMIN_HELP_GENPASS
	Syntax: GENPASS nickname
	
	Generates a random password and emails it to the registered
	email address.
	
	Limited to Cservice Members^B.

NICK_GENPASS_OK
	A new password was emailed to: %s

