# Emacs mode: -*- text -*-¡¡

# Deutsch language file.
#
# K9 IRC Services (c) 2001-2002 |SaMaN|
# Contact me at linuxworm@turk.net
# This program is free but copyrighted software; see the file COPYING for
# details.
#
# Based on the original code of Services by Andy Church.
#

LANG_NAME
	Deutsch (German)
#########################################################
# Translated by TimeMr14C (uhc0@stud.uni-karlsruhe.de)  #
# Translated by freenet.de (www.freenet.de)             #
# Put together, corrected by jacek.margos@freenet-ag.de #
#########################################################

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
	%d. %b %H:%M:%S %Y %Z
# This is used as the format string for strftime() for a date alone in long
# format (English: including weekday).
STRFTIME_LONG_DATE_FORMAT
	%a %d.%b.%Y
# This is used as the format string for strftime() for a date alone in
# short format (English: without weekday).
STRFTIME_SHORT_DATE_FORMAT
	%d.%b.%Y

# These tell our strftime() what the names of months and days are.  If you
# don't use %a, %A, %b, or %B in your strftime() strings above, you can
# leave these empty.  However, if you enter names, they MUST stay in order,
# one per line, and the list MUST be complete!

# %a
STRFTIME_DAYS_SHORT
	So
	Mo
	Di
	Mi
	Do
	Fr
	Sa
# %A
STRFTIME_DAYS_LONG
	Sonntag
	Montag
	Dienstag
	Mittwoch
	Donnerstag
	Freitag
	Samstag
# %b
STRFTIME_MONTHS_SHORT
	Jan
	Feb
	Mrz
	Apr
	Mai
	Jun
	Jul
	Aug
	Sep
	Okt
	Nov
	Dez	
# %B
STRFTIME_MONTHS_LONG
	Januar
	Februar 	
	März
	April
	Mai
	Juni
	Juli
	August
	September
	Oktober
	November
	Dezember

# "day", "hour", "minute", and "second" in singular and plural.
STR_DAY
	Tag
STR_DAYS
	Tage
STR_HOUR
	Stunde
STR_HOURS
	Stunden
STR_MINUTE
	Minute
STR_MINUTES
	Minuten
STR_SECOND
	Sekunde
STR_SECONDS
	Sekunden


# This is used in ChanServ/DogTag INFO displays.
COMMA_SPACE
	,

# Various error messages.
USER_RECORD_NOT_FOUND
	Interner Fehler - Verarbeitung der Anfrage nicht möglich.	
UNKNOWN_COMMAND
	Unbekannter Befehl %s.
UNKNOWN_COMMAND_HELP
	Unbekannter Befehl %s. "/msg %s HELP" für Hilfe.
SYNTAX_ERROR
	Syntax: %s
MORE_INFO
	/msg %s HELP %s für weitere Informationen.
NO_HELP_AVAILABLE
	Keine Hilfe verfügbar für %s.

BAD_EMAIL
	Email Adressen müssen der Form benutzer@domain sein. Es dürfen keine Kontrol-Charaktere oder keine dieser Zeichen benutzt werden: , : ; | \ " ( ) < >
BAD_URL
	Eine URL muß der Form http://hostname[:port]/... (oder ftp://, etc.) entsprechen.
BAD_USERHOST_MASK
	Maske muß folgendes Format haben: user@host.
BAD_EXPIRY_TIME
	Ungültige Verfallsdauer.

SERVICE_OFFLINE
	%s ist momentan nicht verfügbar.
READ_ONLY_MODE
	Hinweis: K9 Services ist im schreibgeschützten Modus; 
	Änderungen werden nicht gespeichert !
PASSWORD_INCORRECT
	Falsches Passwort.
# What's the difference between "Access denied" and "Permission denied"?
# Very little; you can safely make them the same message with no real loss
# of meaning.  If you want to make a distinction, "Access denied" is
# usually used more generally; for example, a non-oper trying to access
# OperServ gets "Access denied", while a non-Services admin trying to use
# DogTag SET NOEXPIRE gets "Permission denied".
ACCESS_DENIED
	Zugriff verweigert.
PERMISSION_DENIED
	Zugriff verweigert.

MORE_OBSCURE_PASSWORD
	Versuchen Sie es erneut mit einem ungewöhnlicheren Passwort.
	Passwörter sollten mindestens fünf Zeichen lang sein und
	nicht zu leicht zu erraten
	(z.B. nicht Ihr wirklicher Name oder Ihr Chatname).
	Leerzeichen und Tabulatoren dürfen nicht verwendet werden.
PASSWORD_TRUNCATED
	Hinweis:  Ihr Passwort ist auf %d Zeichen verkürzt worden,
	die letzten Zeichen wurden abgeschnitten.

NICK_NOT_REGISTERED
	Ihr Chatname ist nicht registriert.
NICK_NOT_REGISTERED_HELP
	Ihr Chatname ist nicht registriert.
	Für weitere Informationen zur Chatnamen-Registrierung
	bitte /msg %s HELP eingeben.
NICK_X_NOT_REGISTERED
	Der Chatname %s ist nicht registriert.
NICK_X_NOT_IN_USE
	Der Chatname %s ist momentan nicht in Benutzung
NICK_X_FORBIDDEN
	Der Name %s darf weder genutzt noch registriert werden
NICK_X_SUSPENDED
	Der Chatname %s ist suspendiert, und kann nicht benutzt werden.
NICK_X_SUSPENDED_MEMOS
	Der Chatname %s ist suspendiert, und kann keine Memos erhalten.
NICK_IDENTIFY_REQUIRED
	Dieser Befehl benötigt eine Passwort-Authentizierung.
	Bitte versuchen Sie es erneut nach der Eingabe von
	/msg %s IDENTIFY Passwort.
NICK_X_NOT_ON_CHAN_X
	Der Chatname %s ist im Moment nicht im Raum %s.

CHAN_X_NOT_REGISTERED
	Der Raum %s ist nicht registriert.
CHAN_X_NOT_IN_USE
	Der Raum %s wird momentan nicht benutzt.
CHAN_X_FORBIDDEN
	Der Raum %s darf weder genutzt noch registriert werden.
CHAN_X_SUSPENDED
	Der Raum %s ist suspendiert, und kann nicht benutzt werden.
CHAN_X_SUSPENDED_MEMOS
	Der Raum %s ist suspendiert, und kann keine Memos erhalten.
CHAN_IDENTIFY_REQUIRED
	Dieser Befehl benötigt eine Passwort-Authentizierung.
	Bitte versuchen Sie es erneut nach der Eingabe von
	/msg %s IDENTIFY %s Passwort.
	
SERV_X_NOT_FOUND
	Server %s wurde gefunden.

EXPIRES_NONE
	Wird nicht verfallen.
EXPIRES_SOON
	Verfällt beim nächsten Update. 
EXPIRES_M
	Verfällt in %d Minuten. 
EXPIRES_1M
	Verfällt in %d Minute. 
EXPIRES_HM
	Verfällt in %d Stunden und %d Minuten.
EXPIRES_H1M
	Verfällt in %d Stunden und %d Minute.
EXPIRES_1HM
	Verfällt ind %d Stunde und %d Minuten. 
EXPIRES_1H1M
	Verfällt ind %d Stunde und %d Minute. 
EXPIRES_D
	Verfällt in %d Tage. 
EXPIRES_1D
	Verfällt in %d Tag.

###########################################################################
#
# DogTag messages
#
###########################################################################

# Automatic messages
NICK_IS_REGISTERED
	Dieser Chatname wird von jemand anderem benutzt.
	Bitte wählen Sie einen anderen.
	(Falls dies Ihr Chatname ist, geben Sie bitte
	/msg %s IDENTIFY Passwort ein.)
NICK_IS_SECURE
	Dieser Chatname ist registriert und geschützt.
	Falls dies Ihr Chatname ist, geben Sie bitte
	/msg %s IDENTIFY Passwort ein.
	Wählen Sie anderenfalls einen neuen Chatnamen.
NICK_MAY_NOT_BE_USED
	Dieser Chatname darf nicht genutzt werden.
	Wählen Sie bitte einen anderen.
DISCONNECT_IN_1_MINUTE
	Falls Sie nicht innerhalb der nächsten Minute
	Ihren Chatnamen ändern, werden Sie vom Server getrennt.
DISCONNECT_IN_20_SECONDS
	Falls Sie nicht innerhalb der nächsten 20 Sekunden
	Ihren Chatnamen ändern, werden Sie vom Server getrennt.
DISCONNECT_NOW
	Dieser Chatname ist bereits registriert;
	Sie dürfen ihn nicht benutzen.
	Wählen Sie einen anderen, bevor Sie sich neu verbinden.
FORCENICKCHANGE_IN_1_MINUTE
	Falls Sie nicht innerhalb der nächsten Minute
	Ihren Chatnamen ändern, wird er automatisch geändert.
FORCENICKCHANGE_IN_20_SECONDS
	Falls Sie nicht innerhalb der nächsten 20 Sekunden
	Ihren Chatnamen ändern, wird er automatisch geändert.
FORCENICKCHANGE_NOW
	Dieser Chatname ist bereits registriert;
	Sie dürfen Ihn nicht benutzen.
	Ihr Chatname wird jetzt in %s geändert.
NICK_EXPIRES_SOON
	Warnung: Ihre Chatnamen-Registrierung wird in %d %s
	verfallen. Wenn Sie weiterhinn Ihren Chatnamen werwenden
	wollen, müssen Sie sich durch folgendes identifizieren:
	/msg %s IDENTIFY Passwort
NICK_EXPIRED
	Warnung: Ihre Chatnamen-Registrierung ist bereits
	verfallen. Bitte registrieren Sie den Chatnamen neu,
	wenn sie Ihn weiter verwenden wollen.


# REGISTER responses
NICK_REGISTER_SYNTAX
	REGISTER Password [Email]
NICK_REGISTER_REQ_EMAIL_SYNTAX
	REGISTER Password Email
NICK_REGISTRATION_DISABLED
	Die Chatnamen-Registrierung ist temporär nicht verfügbar.
NICK_REGISTRATION_FAILED
	Die Registrierung hat nicht funktioniert.
NICK_REG_PLEASE_WAIT
	Bitte warten Sie %d Sekunden,
	bevor Sie den REGISTER-Befehl erneut benutzen.
NICK_CANNOT_BE_REGISTERED
	Chatname %s darf nicht registriert werden.
NICK_ALREADY_REGISTERED
	Der Chatname %s ist bereits registriert.
NICK_REGISTERED
	Der Chatname %s ist für Sie registriert: %s
NICK_PASSWORD_IS
	Ihr Passwort lautet: %s. Bitte merken Sie es sich.

# IDENTIFY responses
NICK_IDENTIFY_SYNTAX
	IDENTIFY Password
NICK_IDENTIFY_FAILED
	Leider schlug Ihre Identifikation fehl.
NICK_IDENTIFY_SUCCEEDED
	Passwort akzeptiert - Sie sind identifiziert worden.

# DROP responses
NICK_DROP_SYNTAX
	DROP
NICK_DROP_DISABLED
	Die Chatnamen-Deregistrierung ist temporär nicht verfügbar.
NICK_DROPPED
	Ihr Chatname ist wieder freigegeben worden.
NICK_X_DROPPED
	Der Chatname %s ist wieder freigegeben worden

# SET responses
NICK_SET_SYNTAX
	SET Option Parameter
NICK_SET_SERVADMIN_SYNTAX
	SET [Chatname] Option Parameter
NICK_SET_DISABLED
	Leider ist die Chatname-Option temporär nicht verfügbar.
NICK_SET_UNKNOWN_OPTION
	Unbekannte SET-Option: %s.
NICK_SET_UNKNOWN_OPTION_OR_BAD_NICK
	Unbekannte SET Option: %s oder Chatname ist nicht registriert.

# SET PASSWORD responses
NICK_SET_PASSWORD_FAILED
	Das Passwort konnte nicht geändert werden.
NICK_SET_PASSWORD_CHANGED
	Das Passwort wurde geändert.
NICK_SET_PASSWORD_CHANGED_TO
	Das Passwort wurde in %s geändert.

# SET LANGUAGE responses
NICK_SET_LANGUAGE_SYNTAX
	SET LANGUAGE Nummer
NICK_SET_LANGUAGE_UNKNOWN
	Unbekannte Sprachen-Nummer %d.
	Geben Sie für eine Liste aller Sprachen bitte
	/msg %s HELP SET LANGUAGE ein
NICK_SET_LANGUAGE_CHANGED
	Die Sprache wurde in Deutsch geändert.

# SET URL responses
NICK_SET_URL_CHANGED
	URL für %s wurde zu %s geändert.

# SET EMAIL responses
NICK_SET_EMAIL_CHANGED
	Email-Adresse für %s wurde zu %s geändert.

# SET KILL responses
NICK_SET_KILL_SYNTAX
	SET KILL {ON | QUICK | OFF}
NICK_SET_KILL_IMMED_SYNTAX
	SET KILL {ON | QUICK | IMMED | OFF}
NICK_SET_KILL_ON
	Der Chatnamen-Übernahmeschutz steht jetzt auf:
	ON (eingeschaltet).
NICK_SET_KILL_QUICK
	Der Chatnamen-Übernahmeschutz steht jetzt auf:
	QUICK (eingeschaltet mit kurzer Warnzeit,
	diese Option wird nicht empfohlen).
NICK_SET_KILL_IMMED
	Der Chatnamen-Übernahmeschutz steht jetzt auf:
	IMMED (eingeschaltet mit keiner Warnzeit,
	diese Option wird nicht empfohlen).
NICK_SET_KILL_IMMED_DISABLED
	Die IMMED-Option ist nicht verfügbar.
NICK_SET_KILL_OFF
	Der Chatnamen-Übernahmeschutz steht jetzt auf:
	OFF (ausgeschaltet).

# SET SECURE responses
NICK_SET_SECURE_SYNTAX
	SET SECURE {ON | OFF}
NICK_SET_SECURE_ON
	Die Secure-Option steht jetzt auf:
	ON (eingeschaltet).
NICK_SET_SECURE_OFF
	Die Secure-Option steht jetzt auf:
	OFF (ausgeschaltet).

# SET PRIVATE responses
NICK_SET_PRIVATE_SYNTAX
	SET PRIVATE {ON | OFF}
NICK_SET_PRIVATE_ON
	Die Privat-Option steht jetzt auf:
	ON (eingeschaltet).
NICK_SET_PRIVATE_OFF
	Die Privat-Option steht jetzt auf:
	OFF (ausgeschaltet).

# SET HIDE responses
NICK_SET_HIDE_SYNTAX
	SET HIDE {EMAIL | USERMASK | QUIT} {ON | OFF}
NICK_SET_HIDE_EMAIL_ON
	Ihre Email-Adresse wird nun bei einer '%s INFO'-Anfrage
	nicht angezeigt.
NICK_SET_HIDE_EMAIL_OFF
	Ihre Email-Adresse wird nun bei einer '%s INFO'-Anfrage
	angezeigt.
NICK_SET_HIDE_MASK_ON
	Ihre last seen user@host mask wird nun bei einer
	'%s INFO'-Anfrage nicht angezeigt.
NICK_SET_HIDE_MASK_OFF
	Ihre last seen user@host mask wird nun bei einer
	'%s INFO'-Anfrage angezeigt.
NICK_SET_HIDE_QUIT_ON
	Ihre Abschlussnachricht (QUIT) wird nun bei einer
	%s INFO'-Abfrage nicht angezeigt.
NICK_SET_HIDE_QUIT_OFF
	Ihre Abschlussnachricht (QUIT) wird nun bei einer
	'%s INFO'-Abfrage angezeigt.

# SET NOEXPIRE responses
NICK_SET_NOEXPIRE_SYNTAX
	SET [Chatname] NOEXPIRE {ON | OFF}
NICK_SET_NOEXPIRE_ON
	Der Chatname %s wird nicht verfallen
NICK_SET_NOEXPIRE_OFF
	Der Chatname %s wird verfallen .

# UNSET responses
NICK_UNSET_SYNTAX
	UNSET {URL | EMAIL}
NICK_UNSET_SYNTAX_REQ_EMAIL
	UNSET URL
NICK_UNSET_URL
	URL für %s wurde zurückgesetzt.
NICK_UNSET_EMAIL
	Email Adresse für %s wurde zurückgesetzt.
NICK_UNSET_EMAIL_BAD
	Email Adresse kann nicht zurückgesetzt werden. 
NICK_UNSET_EMAIL_OTHER_BAD
	Email-Adressen können nicht zurückgesetzt werden. 

# ACCESS responses
NICK_ACCESS_SYNTAX
	ACCESS {ADD | DEL | LIST} [Maske]
NICK_ACCESS_ALREADY_PRESENT
	Die Maske %s steht bereits auf Ihrer Zugriffsliste.
NICK_ACCESS_REACHED_LIMIT
	Limit der %d Einträge der Zugriffsliste erschöpft.
NICK_ACCESS_ADDED
	Maske %s wurde zu Ihrer Zugriffsliste eingetragen.
NICK_ACCESS_NOT_FOUND
	Maske %s wurde in Ihrer Zugriffsliste nicht gefunden.
NICK_ACCESS_DELETED
	Maske %s wurde von Ihrer Zugriffsliste gelöscht.
NICK_ACCESS_LIST
	Zugriffsliste:
NICK_ACCESS_LIST_X
	Zugriffsliste für %s:

# LINK responses
NICK_LINK_SYNTAX
	LINK Chatname Passwort
NICK_LINK_DISABLED
	Der Link-Befehl ist deaktiviert.
NICK_LINK_FAILED
	Der Link konnte nicht erzeugt werden.
NICK_NO_LINK_SAME
	Ein Link zum selben Chatnamen ist unmöglich!
NICK_LINK_CIRCULAR
	Ein Link zum %s unmöglich (es würde eine Schleife entstehen).
NICK_LINK_TOO_DEEP
	Sie können keine Links über %d Stufen erzeugen.
NICK_LINK_TOO_MANY_CHANNELS
	Kann keinen Link zu %s nicht erzeugen:
	Zu viele registrierte Räume (zusammen %d).
NICK_LINKED
	Der Link zu %s wurde erzeugt.

# UNLINK responses
NICK_UNLINK_SYNTAX
	UNLINK [Chatname Passwort]
NICK_UNLINK_FAILED
	Der Link konnte nicht gelöscht werden.
NICK_NOT_LINKED
	Der Chatname hat keinen Link.
NICK_UNLINKED
	Der Link zu %s wurde gelöscht.
NICK_X_NOT_LINKED
	Der Chatname %s hat keinen Link.
NICK_X_UNLINKED
	Der Link vom Chatnamen %s zu %s wurde gelöscht.

# LISTLINKS responses
NICK_LISTLINKS_SYNTAX
	LISTLINKS Chatname [ALL]
NICK_LISTLINKS_HEADER
	Links zum Chatnamen %s:
NICK_LISTLINKS_FOOTER
	%d Chatnamen mit Link.
NICK_X_IS_LINKED
	%s
NICK_X_IS_LINKED_VIA_X
	%-20s (via %s)

# INFO responses
NICK_INFO_SYNTAX
	INFO Chatname [ALL]
NICK_INFO_REALNAME
	%s ist %s
NICK_INFO_ADDRESS
	   Last-seen Adresse: %s
NICK_INFO_ADDRESS_ONLINE
	      Ist online von: %s
NICK_INFO_ADDRESS_ONLINE_NOHOST
	%s ist momentan online.
NICK_INFO_TIME_REGGED
	  Registrationsdatum: %s
NICK_INFO_LAST_SEEN
	      Last-seen Zeit: %s
NICK_INFO_LAST_QUIT
	Letzte QUIT-Nachricht: %s
NICK_INFO_URL
	                  URL: %s
NICK_INFO_EMAIL
	       Email Addresse: %s
NICK_INFO_OPTIONS
	             Optionen: %s
NICK_INFO_LINKED_TO
	              Link zu: %s
# These strings MUST NOT be empty
NICK_INFO_OPT_KILL
	Chatnamen-Übernahmeschutz
NICK_INFO_OPT_SECURE
	Secure Option
NICK_INFO_OPT_PRIVATE
	Privat
NICK_INFO_OPT_NONE
	Keine
NICK_INFO_NO_EXPIRE
	Dieser Chatname wird nicht verfallen.
NICK_INFO_SUSPEND_DETAILS
	Suspendiert von %s am %s (%s).
NICK_INFO_SUSPEND_REASON
	Grund: %s
NICK_INFO_SHOW_ALL
	/msg %s INFO %s ALL für weitere Informationen

# LISTCHANS responses
NICK_LISTCHANS_SYNTAX
	LISTCHANS
NICK_LISTCHANS_SERVADMIN_SYNTAX
	LISTCHANS [Chatname]
NICK_LISTCHANS_NONE
	%s hat keine registrierten Räume.
NICK_LISTCHANS_HEADER
	Registrierte Räume von %s:
NICK_LISTCHANS_ENTRY
	%s
NICK_LISTCHANS_END
	Ende der Liste (%d registrierte Räume)

# LIST responses
NICK_LIST_SYNTAX
	LIST Muster
NICK_LIST_SERVADMIN_SYNTAX
	LIST Muster [FORBIDDEN] [NOEXPIRE] [SUSPENDED]
NICK_LIST_HEADER
	Liste aller Einträge, auf die %s zutrifft:
NICK_LIST_RESULTS
	Ende der Liste - es wurden %d/%d Treffer angezeigt

# RECOVER responses
NICK_RECOVER_SYNTAX
	RECOVER Chatname [Passwort]
NICK_NO_RECOVER_SELF
	Sie können sich selbst nicht killen!
NICK_RECOVERED
	Der User mit Ihrem Chatnamen wurde aus dem Network gekillt.
	Mit /msg %s RELEASE %s können Sie Ihren Chatnamen vor
	der Zeit von 1 Minute zurückerhalten.

# RELEASE responses
NICK_RELEASE_SYNTAX
	RELEASE Chatname [Passwort]
NICK_RELEASE_NOT_HELD
	Chatname %s wird nicht eibehalten.
NICK_RELEASED
	Chatname wurde freigestellt.

# GHOST responses
NICK_GHOST_SYNTAX
	GHOST Chatname [Passwort]
NICK_NO_GHOST_SELF
	Sie können sich selbst nicht killen!
NICK_GHOST_KILLED
	Verbindung des hängengebliebenen Chatname wurde unterbrochen.

# GETPASS responses
NICK_GETPASS_SYNTAX
	GETPASS Chatname
NICK_GETPASS_UNAVAILABLE
	Aufgrund der Nutzung von Verschlüsselung
	ist der GETPASS-Befehl ist nicht verfügbar.
NICK_GETPASS_PASSWORD_IS
	Das Passwort des für %s lautet %s.

# FORBID responses
NICK_FORBID_SYNTAX
	FORBID Chatname
NICK_FORBID_SUCCEEDED
	Der Chatname %s ist jetzt gesperrt.
NICK_FORBID_FAILED
	Der Chatname %s konnte nicht gesperrt werden!

# SUSPEND responses
NICK_SUSPEND_SYNTAX
	SUSPEND [+Dauer] Chatname Grund
NICK_SUSPEND_SUCCEEDED
	Der Chatname %s und alle damit verbundene
	Chatnamen sind suspendiert. 
NICK_SUSPEND_ALREADY_SUSPENDED
	Der Chatname %s ist bereits suspendiert.

# UNSUSPEND responses
NICK_UNSUSPEND_SYNTAX
	UNSUSPEND Chatname
NICK_UNSUSPEND_SUCCEEDED
	Suspend von %s ist jetzt aufgehoben.
NICK_SUSPEND_NOT_SUSPENDED
	Der Chatname %s ist nicht suspendiert.

###########################################################################
#
# ChanServ messages
#
###########################################################################

# Access level descriptions
CHAN_LEVEL_AUTOOP
	Automatischer Raumoperator-Status
CHAN_LEVEL_AUTOVOICE
	Automatischer Moderator-Status
CHAN_LEVEL_AUTODEOP
	Der automatische Raumoperator-Status nicht erlaubt
CHAN_LEVEL_AUTODEOP_HALFOP
	Der automatische Raumoperator-Status (HalfOp) nicht erlaubt
CHAN_LEVEL_NOJOIN
	Der Raum darf nicht betreten werden,
	falls er RESTRICTED ist.
CHAN_LEVEL_INVITE
	Der INVITE-Befehl darf benutzt werden
CHAN_LEVEL_AKICK
	Der AKICK-Befehl darf benutzt werden
CHAN_LEVEL_SET
	Der SET-Befehl darf benutzt werden (bis auf FOUNDER/PASSWORD)
CHAN_LEVEL_CLEAR
	Der CLEAR-Befehl darf benutzt werden
CHAN_LEVEL_UNBAN
	Der UNBAN-Befehl darf benutzt werden
CHAN_LEVEL_OPDEOP
	Die OP/DEOP-Befehle dürfen benutzt werden
CHAN_LEVEL_VOICE
	Die VOICE/DEVOICE-Befehle dürfen benutzt werden
CHAN_LEVEL_ACCESS_LIST
	Die Zugriffsliste darf angezeigt werden
CHAN_LEVEL_ACCESS_CHANGE
	Die Zugriffsliste darf modifiziert werden
CHAN_LEVEL_MEMO
	Raum-Memos dürfen aufgelistet/gelesen werden
CHAN_LEVEL_AUTOHALFOP
	Automatischer Raumoperator-Status (HalfOp +h)
CHAN_LEVEL_HALFOP
	Die HALFOP/DEHALFOP-Befehle dürfen benutzt werden
CHAN_LEVEL_AUTOPROTECT
	Automatischer Raum-Schutz-Status (+a)
CHAN_LEVEL_PROTECT
	Die PROTECT/DEPROTECT-Befehle dürfen benutzt werden

# Automatic responses
CHAN_IS_REGISTERED
	Dieser Raum ist mit %s registriert worden.
CHAN_NOT_ALLOWED_OP
	Sie dürfen nicht Raum-Operator in Raum %s sein.
CHAN_MAY_NOT_BE_USED
	Dieser Raum darf nicht benutzt werden.
CHAN_NOT_ALLOWED_TO_JOIN
	Ihnen ist der Aufenthalt in diesem Raum untersagt.

# Multi-purpose responses
CHAN_BOUNCY_MODES
	Der %s-Befehl kann zur Zeit nicht benutzt werden.


# REGISTER responses
CHAN_REGISTER_SYNTAX
	REGISTER Raum Passwort Beschreibung
CHAN_REGISTER_DISABLED
	Leider ist die Raum-Registrierung temporär nicht verfügbar.
CHAN_REGISTER_NOT_LOCAL
	Lokale Räume können nicht registriert werden.
CHAN_MUST_REGISTER_NICK
	Sie müssen zuerst Ihren Chatnamen registrieren.
	Für weitere Informationen zur Chatnamen-Registrierung
	bitte /msg %s HELP eingeben.
CHAN_MUST_IDENTIFY_NICK
	Bitte identifzieren Sie sich zuerst mit %s. Befehl:
	/msg %s IDENTIFY Passwort
CHAN_MAY_NOT_BE_REGISTERED
	Der Raum %s darf nicht registriert werden.
CHAN_ALREADY_REGISTERED
	Der Raum %s ist bereits registriert!
CHAN_MUST_BE_CHANOP
	Sie müssen Raumoperator sein um diesen Raum zu registrieren.
CHAN_REACHED_CHANNEL_LIMIT
	Limit der %d registrierten Räume erreicht.
CHAN_EXCEEDED_CHANNEL_LIMIT
	Limit der %d registrierten Räume überschritten.
CHAN_REGISTRATION_FAILED
	Die Registrierung ist leider fehlgeschlagen.
CHAN_REGISTERED
	Der Raum %s ist auf Sie registriert: %s
CHAN_PASSWORD_IS
	Ihr Raum-Passwort lautet %s,
	bitte nicht vergessen.

# IDENTIFY responses
CHAN_AUTH_SYNTAX
	AUTH <Raum> <Passwort>
CHAN_SETPASS_SYNTAX
	SETPASS <Raum> <New Passwort>	
CHAN_IDENTIFY_SYNTAX
	IDENTIFY Raum Passwort
CHAN_IDENTIFY_FAILED
	Leider schlug die Identifizierung fehl.
CHAN_IDENTIFY_SUCCEEDED
	Passwort korrekt - Sie haben jetzt Zugriff
	auf Gründer-Stufe zu %s.

# DROP responses
CHAN_DROP_SYNTAX
	DROP Raum
CHAN_DROP_DISABLED
	Die Raum-Deregistrierung ist temporär nicht verfügbar.
CHAN_DROPPED
	Der Raum %s wurde freigegeben.

# SET responses
CHAN_SET_SYNTAX
	SET Raum Option Parameter
CHAN_SET_DISABLED
	Die Raum-Option ist temporär nicht verfügbar.
CHAN_SET_UNKNOWN_OPTION
	Unbekannte SET-Option %s.

# SET FOUNDER responses
CHAN_SET_FOUNDER_TOO_MANY_CHANS
	%s hat zu viele Räume registriert.
CHAN_FOUNDER_CHANGED
	Der Gründer vom Raum %s wurde zu %s geändert.

# SET SUCCESSOR responses
CHAN_SUCCESSOR_CHANGED
	Der Nachfolger für %s hat sich in %s geändert.
CHAN_SUCCESSOR_IS_FOUNDER
	Der Nachfolger kann nicht gleichzeitig Gründer sein.

# SET PASSWORD responses
CHAN_SET_PASSWORD_FAILED
	Das Passwort konnte nicht gesetzt werden.
CHAN_PASSWORD_CHANGED
	Das Passwort von %s wurde geändert.
CHAN_PASSWORD_CHANGED_TO
	Das Passwort von %s wurde in %s geändert.

# SET DESC responses
CHAN_DESC_CHANGED
	Die Beschreibung von %s wurde in %s geändert.

# SET URL responses
CHAN_URL_CHANGED
	URL für %s wurde zu %s geändert.

# SET EMAIL responses
CHAN_EMAIL_CHANGED
	Die EMail-Adresse für %s wurde in %s geändert.

# SET ENTRYMSG responses
CHAN_ENTRY_MSG_CHANGED
	Die Begrüßungsnachricht für %s wurde geändert.

# SET TOPIC responses
CHAN_SET_TOPIC_FAILED
	Leider konnte das Thema nicht gesetzt werden.

# SET MLOCK responses
CHAN_SET_MLOCK_KEY_REQUIRED
	MLOCK +k benötigt einen Parameter.
CHAN_SET_MLOCK_LIMIT_REQUIRED
	MLOCK +l benötigt einen Parameter.
CHAN_SET_MLOCK_LIMIT_POSITIVE
	Der Parameter für MLOCK +l muß eine positive Zahl sein.
CHAN_SET_MLOCK_MODE_REG_BAD
	Modus +%c kann mit MLOCK nicht benutzt werden. 
CHAN_SET_MLOCK_MODE_F_BAD
	Modus +f kann nicht gespeichert werden.
CHAN_SET_MLOCK_UNKNOWN_CHAR
	Unbekanntes Modus-Zeichen %c wird ignoriert.
CHAN_MLOCK_CHANGED
	Der Sperr-Modus für Raum %s wurde in %s geändert.
CHAN_MLOCK_REMOVED
	Der Sperr-Modus für Raum %s wurde zurückgenommen.

# SET KEEPTOPIC responses
CHAN_SET_KEEPTOPIC_SYNTAX
	SET Raum KEEPTOPIC {ON | OFF}
CHAN_SET_KEEPTOPIC_ON
	Die Option zur Beibehaltung des Themas steht jetzt auf:
	ON (eingeschaltet).
CHAN_SET_KEEPTOPIC_OFF
	Die Option zur Beibehaltung des Themas steht jetzt auf:
	OFF (ausgeschaltet).

# SET TOPICLOCK responses
CHAN_SET_TOPICLOCK_SYNTAX
	SET Raum TOPICLOCK {ON | OFF}
CHAN_SET_TOPICLOCK_ON
	Die Option zur Sperrung des Themas steht jetzt auf:
	ON (eingeschaltet).
CHAN_SET_TOPICLOCK_OFF
	Die Option zur Sperrung des Themas steht jetzt auf:
	OFF (ausgeschaltet).

# SET PRIVATE responses
CHAN_SET_PRIVATE_SYNTAX
	SET Raum PRIVATE {ON | OFF}
CHAN_SET_PRIVATE_ON
	Die Privat-Option steht jetzt auf:
	ON (eingeschaltet).
CHAN_SET_PRIVATE_OFF
	Die Privat-Option steht jetzt auf:
	OFF (ausgeschaltet).

# SET SECUREOPS responses
CHAN_SET_SECUREOPS_SYNTAX
	SET Raum SECUREOPS {ON | OFF}
CHAN_SET_SECUREOPS_ON
	Die Secure ops option steht jetzt auf:
	ON (eingeschaltet).
CHAN_SET_SECUREOPS_OFF
	Die Secure ops option steht jetzt auf:
	OFF (ausgeschaltet).

# SET LEAVEOPS responses
CHAN_SET_LEAVEOPS_SYNTAX
	SET Raum LEAVEOPS {ON | OFF}
CHAN_SET_LEAVEOPS_ON
	Die Leave ops option steht jetzt auf:
	ON (eingeschaltet).
CHAN_SET_LEAVEOPS_OFF
	Die Leave ops option steht jetzt auf:
	OFF (ausgeschaltet).

# SET RESTRICTED responses
CHAN_SET_RESTRICTED_SYNTAX
	SET Raum RESTRICTED {ON | OFF}
CHAN_SET_RESTRICTED_ON
	Die Zugangsbeschränkungs-Option steht jetzt auf:
	ON (eingeschaltet).
CHAN_SET_RESTRICTED_OFF
	Die Zugangsbeschränkungs-Option steht jetzt auf:
	OFF (ausgeschaltet).

# SET SECURE responses
CHAN_SET_SECURE_SYNTAX
	SET Raum SECURE {ON | OFF}
CHAN_SET_SECURE_ON
	Secure-Option steht jetzt auf:
	ON (eingeschaltet).
CHAN_SET_SECURE_OFF
	Secure-Option steht jetzt auf:
	OFF (ausgeschaltet).

# SET OPNOTICE responses
CHAN_SET_OPNOTICE_SYNTAX
	SET Raum OPNOTICE {ON | OFF}
CHAN_SET_OPNOTICE_ON
	Op-Notice-Option steht jetzt auf:
	ON (eingeschaltet).
CHAN_SET_OPNOTICE_OFF
	Op-Notice-Option steht jetzt auf:
	OFF (ausgeschaltet).

# SET ENFORCE responses
CHAN_SET_ENFORCE_SYNTAX
	SET Raum ENFORCE {ON | OFF}
CHAN_SET_ENFORCE_ON
	Enforce-Option steht jetzt auf:
	ON (eingeschaltet).
CHAN_SET_ENFORCE_OFF
	Enforce-Option steht jetzt auf:
	OFF (ausgeschaltet).

# SET NOEXPIRE responses
CHAN_SET_NOEXPIRE_SYNTAX
	SET Raum NOEXPIRE {ON | OFF}
CHAN_SET_NOEXPIRE_ON
	Der Raum %s wird nicht verfallen.
CHAN_SET_NOEXPIRE_OFF
	Der Raum %s wird verfallen.

# UNSET responses
CHAN_UNSET_SYNTAX
	UNSET Raum {SUCCESSOR | URL | EMAIL | ENTRYMSG}
CHAN_SUCCESSOR_UNSET
	Der Nachfolger für %s wurde zurückgesetzt.
CHAN_URL_UNSET
	URL für %s wurde zurückgesetzt.
CHAN_EMAIL_UNSET
	Die EMail-Adresse für %s wurde zurückgesetzt.
CHAN_ENTRY_MSG_UNSET
	Die Begrüßungsnachricht für %s wurde zurückgesetzt.



# ACCESS messages
CHAN_ACCESS_SYNTAX
	ACCESS Raum {ADD | DEL | LIST | COUNT} [Chatname [Stufe] | Eintragsliste]
CHAN_ACCESS_DISABLED
	Leider können Zugriffslisten der Räume Zeit nicht modifiziert werden.
CHAN_ACCESS_LEVEL_NONZERO
	Zugriffsstufe muß eine Zahl ausser 0 (Null) sein.
CHAN_ACCESS_LEVEL_RANGE
	Zugriffsstufe muß zwischen %d und %d sein (einschließlich).
CHAN_ACCESS_NICKS_ONLY
	Die Zugriffslisten für Räume
	können nur registrierte Chatnamen enthalten.
CHAN_ACCESS_REACHED_LIMIT
	Limit der %d Einträge in der Zugriffsliste erreicht.
CHAN_ACCESS_LEVEL_UNCHANGED
	Zugriffsstufe von %s in der Zugriffsliste von %s
	war bereits %d (blieb unverändert).
CHAN_ACCESS_LEVEL_CHANGED
	Zugriffsstufe von %s in der Zugriffsliste von %s
	wurde in %d geändert.
CHAN_ACCESS_ADDED
	%s wurde zur %s-Zugriffsliste
	mit Stufe %d hinzugefügt.
CHAN_ACCESS_NO_SUCH_ENTRY
	Kein derartiger Eintrag (#%d) auf der Zugriffsliste von %s.
CHAN_ACCESS_NOT_FOUND
	Der Chatname %s steht nicht auf der Zugriffsliste von %s.
CHAN_ACCESS_NO_MATCH
	Keine passenden Einträge auf der Zugriffsliste von %s.
CHAN_ACCESS_DELETED
	Der Chatname %s wurde von der Zugriffsliste von %s entfernt.
CHAN_ACCESS_DELETED_ONE
	Ein Eintrag aus der Zugriffsliste von %s wurde entfernt. 
CHAN_ACCESS_DELETED_SEVERAL
	%d Einträge aus der Zugriffsliste von %s wurden entfernt.
CHAN_ACCESS_LIST_EMPTY
	Die Zugriffsliste von %s ist leer.
CHAN_ACCESS_LIST_HEADER
	Zugriffsliste von %s:
CHAN_ACCESS_COUNT
	Die Zugriffsliste von %s hat %d Einträge.

# XOP (AOP/SOP/VOP) responses
CHAN_SOP_SYNTAX
	SOP Raum {ADD | DEL | LIST | COUNT} [Chatname | Eintragsliste]
CHAN_AOP_SYNTAX
	AOP Raum {ADD | DEL | LIST | COUNT} [Chatname | Eintragsliste]
CHAN_HOP_SYNTAX
	HOP Raum {ADD | DEL | LIST | COUNT} [Chatname | Eintragsliste]
CHAN_VOP_SYNTAX
	VOP Raum {ADD | DEL | LIST | COUNT} [Chatname | Eintragsliste]
CHAN_XOP_ADDED
	%s wurde zu %s %s-Liste hinzugefügt.
CHAN_XOP_LEVEL_CHANGED
	%s wurde von %s %s-Liste entfernt.
CHAN_XOP_LEVEL_UNCHANGED
	%s ist bereits auf %s %s-Liste.
CHAN_XOP_NICKS_ONLY
	Die SOP-, AOP-, und VOP-Listen können nur
	registrierte Chatnamen enthalten.
CHAN_XOP_NICKS_ONLY_HOP
	Die SOP-, AOP-, HOP-, und VOP-Listen können nur
	registrierte Chatnamen enthalten.
CHAN_XOP_REACHED_LIMIT
	Die AOP-, SOP- oder VOP-Listen können nicht mehr
	als %d Einträge haben.
CHAN_XOP_REACHED_LIMIT_HOP
	Die AOP-, SOP-, HOP- oder VOP-Listen können nicht mehr
	als %d Einträge haben.
CHAN_XOP_NOT_FOUND
	%s wurde in der %s %s-Liste nicht gefunden.
CHAN_XOP_NO_SUCH_ENTRY
	Kein derartiger Eintrag (#%d) in der %s %s-Liste.
CHAN_XOP_NO_MATCH
	Keine passenden Einträge in %s %s-Liste.
CHAN_XOP_DELETED
	%s wurde von der %s %s-Liste entfernt.
CHAN_XOP_DELETED_ONE
	Ein Eintrag vom %s %s-Liste entfernt.
CHAN_XOP_DELETED_SEVERAL
	%d Einträge von %s %s-Liste entfernt.
CHAN_XOP_LIST_EMPTY
	Die %s %s-Liste ist leer.
CHAN_XOP_LIST_HEADER
	%s-Liste für %s:
	  Nr.   Chatname
CHAN_XOP_LIST_FORMAT
	  %3d   %s%s%s%s
CHAN_XOP_COUNT
	%s %s-Liste hat %d Einträge.

# AKICK responses
CHAN_AKICK_SYNTAX
	AKICK Raum {ADD | DEL | LIST | VIEW | ENFORCE | COUNT} [Maske | Liste]
CHAN_AKICK_DISABLED
	Autokick-Listen der Räume können zur Zeit nicht modifiziert werden.
CHAN_AKICK_ALREADY_EXISTS
	Der Eintrag %s ist in der Autokick-Liste
	von %s bereits enthalten.
CHAN_AKICK_REACHED_LIMIT
	In der Autokick-Liste können maximal %d Einträge existieren.
CHAN_AKICK_ADDED
	Der Eintrag %s wurde in die Autokick-Liste von %s eingetragen.
CHAN_AKICK_NO_SUCH_ENTRY
	Kein derartiger Eintrag (#%d) in der Autokick-Liste von %s.
CHAN_AKICK_NOT_FOUND
	Der Eintrag %s steht nicht in der Autokick-Liste von %s.
CHAN_AKICK_NO_MATCH
	Ein passender Eintrag ist in der Autokick-Liste
	von %s nicht zu finden.
CHAN_AKICK_DELETED
	Der Eintrag %s wurde von der Autokick-Liste von %s entfernt.
CHAN_AKICK_DELETED_ONE
	Ein Eintrag wurde von der Autokick-Liste von %s entfernt.
CHAN_AKICK_DELETED_SEVERAL
	%d Einträge sind von der Autokick-Liste von %s entfernt.
CHAN_AKICK_LIST_EMPTY
	Die Autokick-Liste von %s ist leer.
CHAN_AKICK_LIST_HEADER
	Autokick-Liste von %s:
CHAN_AKICK_LIST_FORMAT
	  %3d %s%s
CHAN_AKICK_VIEW_FORMAT
	  %3d %s (bei %s)
	    %s
CHAN_AKICK_ENFORCE_DONE
	AKICK ENFORCE für %s beendet; %d Benutzer waren betroffen.
CHAN_AKICK_COUNT
	%s hat %d Einträge in der Autokick-Liste.

# LEVELS responses
CHAN_LEVELS_SYNTAX
	LEVELS Raum {SET | DIS[ABLE] | LIST | RESET} [Einstellung [Stufe]]
CHAN_LEVELS_RANGE
	Die Stufe muß zwischen %d und %d liegen (einschließlich).
CHAN_LEVELS_CHANGED
	Die Stufe für %s im Raum %s wurde in %d geändert.
CHAN_LEVELS_UNKNOWN
	Die Einstellung %s ist unbekannt.
	Geben Sie /msg %s HELP LEVELS DESC
	für eine Liste gültiger Einstellungen ein.
CHAN_LEVELS_DISABLED
	%s wurde im Raum %s ausgeschaltet.
CHAN_LEVELS_LIST_HEADER
	Zugriffsstufen-Einstellungen für Raum %s:
CHAN_LEVELS_LIST_DISABLED
	    %-*s  (ausgeschaltet)
CHAN_LEVELS_LIST_FOUNDER
	    %-*s  (nur für Gründer)
CHAN_LEVELS_LIST_NORMAL
	    %-*s  %d
CHAN_LEVELS_RESET
	Die Zugriffsstufen für %s
	wurden auf die Standardwerte zurückgesetzt.

# INFO responses
CHAN_INFO_SYNTAX
	INFO Raum [ALL]
CHAN_INFO_HEADER
	Information über Raum %s:
CHAN_INFO_FOUNDER
	            Gründer: %s (%s)
CHAN_INFO_NO_FOUNDER
	            Gründer: %s
CHAN_INFO_SUCCESSOR
	         Nachfolger: %s (%s)
CHAN_INFO_NO_SUCCESSOR
	         Nachfolger: %s
CHAN_INFO_DESCRIPTION
	       Beschreibung: %s
CHAN_INFO_ENTRYMSG
	Begrüßungsnachricht: %s
CHAN_INFO_TIME_REGGED
	Registrierungsdatum: %s
CHAN_INFO_LAST_USED
	     Letzte Nutzung: %s
CHAN_INFO_LAST_TOPIC
	      Letztes Thema: %s
CHAN_INFO_TOPIC_SET_BY
	  Thema gesetzt von: %s
CHAN_INFO_URL
	                URL: %s
CHAN_INFO_EMAIL
	      Email-Adresse: %s
CHAN_INFO_OPTIONS
	           Optionen: %s
CHAN_INFO_OPT_PRIVATE
	Privat (Mit LIST Befehl unsichtbar)
CHAN_INFO_OPT_KEEPTOPIC
	Beibehaltung des Themas
CHAN_INFO_OPT_TOPICLOCK
	Sperrung des Themas
CHAN_INFO_OPT_SECUREOPS
	Secure Ops
CHAN_INFO_OPT_LEAVEOPS
	Leave Ops
CHAN_INFO_OPT_RESTRICTED
	beschränkter Zugang
CHAN_INFO_OPT_SECURE
	Secure
CHAN_INFO_OPT_OPNOTICE
	Op-Notice
CHAN_INFO_OPT_ENFORCE
	Enforce
CHAN_INFO_OPT_NONE
	Keine
CHAN_INFO_MODE_LOCK
	The current mode guards are [%s]
CHAN_INFO_NO_EXPIRE
	Dieser Raum wird nicht verfallen.
CHAN_INFO_SUSPEND_DETAILS
	Suspendiert von %s am %s (%s).
CHAN_INFO_SUSPEND_REASON
	Begründung: %s
CHAN_INFO_SHOW_ALL
	/msg %s INFO %s ALL für weitere informationen

# LIST responses
CHAN_LIST_SYNTAX
	LIST Muster
CHAN_LIST_SERVADMIN_SYNTAX
	LIST Muster [FORBIDDEN] [NOEXPIRE]
CHAN_LIST_HEADER
	Liste der zu %s passenden Einträge:
CHAN_LIST_FORMAT
	    %-20s  %s
CHAN_LIST_END
	Ende der Liste - %d/%d Treffer.

# INVITE responses
CHAN_INVITE_SYNTAX
	INVITE Raum <Chatname>
CHAN_INVITE_OK
	Lade %s zum Raum %s ein.

# OP/DEOP/VOICE/DEVOICE responses
CHAN_OPVOICE_SYNTAX
	%s Raum Chatname
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
	UNBAN channel
CHAN_UNBANNED
	Ban im Raum %s wurde behoben.

# CLEAR responses
CHAN_CLEAR_SYNTAX
	CLEAR Raum Eintragtyp
CHAN_CLEARED_BANS
	Alle bans (+b) im Raum %s wurden aufbehoben.
CHAN_CLEARED_EXCEPTIONS
	Alle exceptions im Raum %s wurden zurückgesetzt.
CHAN_CLEARED_MODES
	Alle Modi (+ovbntispklm) im Raum %s wurden zurückgesetzt.
CHAN_CLEARED_OPS
	Der Modus +o im Raum %s wurde entfernt (massdeop).
CHAN_CLEARED_HALFOPS
	Der Modus +h im Raum %s wurden entfernt.
CHAN_CLEARED_VOICES
	Der Modus +v im Raum %s wurden entfernt (massdevoice).
CHAN_CLEARED_USERS
	Alle Benutzer wurden aus dem Raum %s gekickt (masskick).

# GETPASS responses
CHAN_GETPASS_SYNTAX
	GETPASS Raum
CHAN_GETPASS_UNAVAILABLE
	Aufgrund der Nutzung von Verschlüsselung
	ist der GETPASS-Befehl ist nicht verfügbar.
CHAN_GETPASS_PASSWORD_IS
	Das Passwort für Raum %s lautet %s.

# FORBID responses
CHAN_FORBID_SYNTAX
	FORBID Raum
CHAN_FORBID_SUCCEEDED
	Der Zugang zu Raum %s ist ab sofort verboten.
CHAN_FORBID_FAILED
	Der Zugang zu Raum %s kann nicht verboten werden!

# SUSPEND responses
CHAN_SUSPEND_SYNTAX
	SUSPEND [+Dauer] Raum Grund
CHAN_SUSPEND_SUCCEEDED
	Der Raum %s wurde suspendiert.
CHAN_SUSPEND_ALREADY_SUSPENDED
	Der Raum %s ist bereits suspendiert.

# UNSUSPEND responses
CHAN_UNSUSPEND_SYNTAX
	UNSUSPEND Raum
CHAN_UNSUSPEND_SUCCEEDED
	Suspend von %s ist jetzt aufgehoben.
CHAN_SUSPEND_NOT_SUSPENDED
	Der Raum %s ist nicht suspendiert.

# MODE responses
OPER_MODE_SYNTAX
	MODE Raum Modi

###########################################################################
#
# DogTag help messages
#
###########################################################################

NICK_HELP
	%S ermöglicht es Ihnen einen Chatnamen zu registrieren,
	so daß es für andere unmöglich wird, diesen Chatnamen zu benutzen.
	Wenn ein Chatname %d Tage nicht benutzt wird, dann wird der
	Eintrag gelöscht. Die Registrierung verfällt somit und der Chatname
	wird für andere wieder frei.
	Die folgenden Befehle sind für die die Registrierung und
	Verwaltung der Chatnamen: /msg %S Befehl.
	/msg %S HELP Befehl für weitere Informationen zu
	einem bestimmten Befehl.
	
	    REGISTER   Zum Registrieren des aktuellen Chatnames.
	    IDENTIFY   Zur Identifizierung des Chatnames.
	    ACCESS     Zum Bearbeiten der Zugriffsliste des Chatnames.
	    LINK       Um einen Link zu einem anderen Chatnamen zu machen.
	    SET        Verschiedene Optionen werden gesetzt.
	    DROP       Zum Löschen des Chatnamens.
	    RECOVER    Entfernt unbefugte Personen die Ihren Chatname benutzen.
	    RELEASE    Gibt Chatnames frei nach RECOVER.	
	
	Andere Befehle: UNLINK, GHOST, INFO, LIST, STATUS, LISTCHANS, UNSET
	
	WICHTIG: %S Ist nur dazu da, daß es im IRC einen gewissen Schutz
	für Identität der Personen zu gewährleisten. Es ist nicht dazu da, 
	daß man andere Leute die Chatnames stiehlt. %S darf nicht für andere 
	Zwecke benutzt werden, und falls so etwas entdeckt werden sollte, 
	kann es dazu führen, daß Chatnames und Räume unter Ihrem Namen 
	verboten werden.

NICK_HELP_EXPIRE_ZERO
	%S ermöglicht es Ihnen einen Chatnamen zu registrieren,
	so daß es für andere unmöglich wird, diesen Chatnamen zu benutzen.
	Die folgenden Befehle sind für die die Registrierung und
	Verwaltung der Chatnamen: /msg %S Befehl.
	/msg %S HELP Befehl für weitere Informationen zu
	einem bestimmten Befehl.
	
	    REGISTER   Zum Registrieren des aktuellen Chatnames.
	    IDENTIFY   Zur Identifizierung des Chatnames.
	    ACCESS     Zum Bearbeiten der Zugriffsliste des Chatnames.
	    LINK       Um einen Link zu einem anderen Chatnamen zu machen.
	    SET        Verschiedene Optionen werden gesetzt.
	    DROP       Zum Löschen des Chatnamens.
	    RECOVER    Entfernt unbefugte Personen die Ihren Chatname benutzen.
	    RELEASE    Gibt Chatnames frei nach RECOVER.	
	
	Andere Befehle: UNLINK, GHOST, INFO, LIST, STATUS, LISTCHANS, UNSET
	
	WICHTIG: %S Ist nur dazu da, daß es im IRC einen gewissen Schutz
	für Identität der Personen zu gewährleisten. Es ist nicht dazu da, 
	daß man andere Leute die Chatnames stiehlt. %S darf nicht für andere 
	Zwecke benutzt werden, und falls so etwas entdeckt werden sollte, 
	kann es dazu führen, daß Chatnames und Räume unter Ihrem Namen 
	verboten werden.

NICK_HELP_REGISTER
	Syntax: REGISTER Passwort [Email]
	
	Der Chatname wird in die %S-Datenbank eingetragen. Danach können
	Sie mit den Befehlen SET und ACCESS Ihre eigenen Optionen
	bestimmen. Das Passwort, das Sie beim Registrieren benutzt haben,
	sollte nicht vergessen werden. Auch zu beachten ist die Groß- und
	Kleinschreibung.

	Sie können eine Emailadresse angeben, wenn Sie den Chatnamen
	registrieren. Mit dem Befehl SET HIDE können Sie verhindern,
	daß diese Emailadresse von anderen gelesen wird. Mit dem Befehl
	SET EMAIL können Sie die Emailadresse später setzen.
	/msg %S HELP SET HIDE für weitere Informationen.

	Vorschläge für das Passwort:
	
	Beim Wählen eines Passwortes ist davon abzuraten, ein leicht
	auszudenkendes Passwort zu benutzen. Kürzere Passwörter sind auch
	nicht gut geeignet. Ein gutes Passwort enthält mindestens 5
	Buchstaben und es ist auch zu empfehlen, Ziffer im Passwort zu
	benutzen.

NICK_HELP_REGISTER_REQ_EMAIL
	Syntax: REGISTER Passwort Email
	
	Der Chatname wird in der %S-Datenbank eingetragen. Danach können
	Sie mit den Befehlen SET und ACCESS Ihre eigenen Optionen
	bestimmen. Das Passwort, das Sie beim Registrieren benutzt haben,
	sollte nicht vergessen werden. Auch zu beachten ist die Groß- und
	Kleinschreibung.

	Sie können eine Emailadresse angeben, wenn Sie den Chatnamen
	registrieren. Mit dem Befehl SET HIDE können Sie verhindern,
	daß diese Emailadresse von anderen gelesen wird. Mit dem Befehl
	SET EMAIL können Sie die Emailadresse später setzen.
	/msg %S HELP SET HIDE für weitere Informationen.

	Vorschläge für das Passwort:
	
	Beim Wählen eines Passwortes ist davon abzuraten, ein leicht
	auszudenkendes Passwort zu benutzen. Kürzere Passwörter sind auch
	nicht gut geeignet. Ein gutes Passwort enthält mindestens 5
	Buchstaben und es ist auch zu empfehlen, Ziffer im Passwort zu
	benutzen.


NICK_HELP_IDENTIFY
	Syntax: IDENTIFY Passwort
	
	Dieser Befehl ermöglicht es Ihnen, daß Sie vom %S erkannt
	werden. Es ist unbedingt erforderlich, um weitere Befehle zu
	benutzen. Das Passwort ist das Passwort, das Sie beim 
	Registrieren mit REGISTER benutzt haben.

NICK_HELP_DROP
	Syntax: DROP
	
	Ihr Chatname wird aus der %S-Datenbank gelöscht. Der Chatname
	wird für andere frei. Um diesen Befehl zu benutzen müssen Sie
	sich identifiziert haben.
	/msg %S HELP IDENTIFY für weitere Informationen.

NICK_HELP_ACCESS
	Syntax: ACCESS ADD Maske
	        ACCESS DEL Maske
	        ACCESS LIST
	
	Die Zugriffsliste für den Chatnamen wird mit diesen Befehlen
	bearbeitet. Diese sind die Adressen, welche vom %S automatisch
	erkannt werden. Falls sie sich von einer anderen Adresse verbinden,
	wird von Ihnen verlangt, den  IDENTIFY-Befehl zu benutzen. 
	
	Beispiele:
	
	    ACCESS ADD time@*.ira.uka.de
	      Der User time wird von allen Domänen unter
	      uni-karlsruhe.de anerkannt.
	
	    ACCESS DEL time@*.ira.uka.de
	        Das vorherige Befehl wird rückgängig gemacht.
	
	    ACCESS LIST
	        Die aktuelle Zugriffsliste wird gezeigt.

NICK_HELP_LINK
	Syntax: LINK Chatname Passwort
	
	Der Chatname wird praktisch mit dem anderen Chatname überall
	unter K9 Services gleichgesetzt. Die Aktuelle Zugriffsliste wird
	mit der des anderen Chatnames ersetzt, die Memos werden zu denen
	des neuen Chatnames hinzugefügt. Es kann vorkommen, daß Sie
	einige Ihrer Memos löschen müssen, weil es die Limit vielleicht
	überschreitet. Zum Beispiel haben gelinkte Chatnames gleiche   
	Rechte in den Access-Listen der Räume. Zu Beachten ist, daß
	die unbenutzten Chatnames ablaufen konnen, wenn diese nicht
	benutzt werden.

	Der Link ist für "UNLINK" und "DROP" Befehle aber irrelevant.
	Das heißt, mit DROP löschen sie nur den aktuellen Chatnamen. 
	
	Um diesen Befehl zu benutzen, müssen Sie sich Identifizieren,
	und auch das Passwort des zu linkenden Chatnamen geben.

NICK_HELP_UNLINK
	Syntax: UNLINK [Chatname Passwort]
	
	Der Link zu einem Chatname wird aufgehoben. Obwohl dadurch
	beide Chatnamen die gleiche Zugriffsliste erhalten, werden
	die Memos bei dem Chatnamen gelassen, von welchem der 
	Link getrennt wurde.

	Wenn sie einen Chatnamen und ein Passwort eingeben, können
	Sie den Link von einem anderen Chatnamen trennen.

NICK_HELP_SET
	Syntax: SET Option Parameter
	
	Verschiedene %S Optionen werden gesetzt. Diese sind:
	
	    PASSWORD   Um das Passwort des Chatnames zu ändern.
	    LANGUAGE   Um die Sprache von K9 Services zu bestimmen.
	    URL        Um die gegebene URL zu Ihrem Chatnamen-Eintrag
	               zuzufügen.
	    EMAIL      Um die gegebene Emailadresse zu Ihrem
	               Chatnamen-Eintrag zuzufügen.
	    KILL       Um die Kill Sicherheitsfunktion ein/auszuschalten.
	    SECURE     Um die Sicherheitsoption ein/auszuschalten.
	    PRIVATE    Um den Chatname auf jener Liste mit 
	               /msg %S LIST zu verstecken.
	    HIDE       Um verschiedene Attribute in INFO-Anzeigen
	               zu verstecken.

	Um diesen Befehl auszuführen, müssen Sie sich identifiziert
	haben.  /msg %S HELP IDENTIFY für weitere Informationen.
	
	/msg %S HELP SET Option für weitere Information einer
	bertimmten Option.

NICK_HELP_SET_PASSWORD
	Syntax: SET PASSWORD neues-Passwort
	
	Das Passwort des Chatnames wird dadurch neu gesetzt.

NICK_HELP_SET_LANGUAGE
	Syntax: SET LANGUAGE Nummer
	
	Bestimmt für Sie die Sprache für K9 Services. Die Nummer
	muß einer der unterstützten Sprachen entsprechen.

NICK_HELP_SET_URL
	Syntax: SET URL URL
	
	Die angegebene URL wird zu dem Chatnamen-Eintrag zugefügt.
	Diese URL wird in den INFO Anzeigen dann mitgezeigt.

NICK_HELP_SET_EMAIL
	Syntax: SET EMAIL Adresse
	
	Die angegebene Emailadresse wird zu dem Chatnamen-Eintrag
	zugefügt. Dies wird dadurch in den INFO Anzeigen 
	mitgezeigt.

NICK_HELP_SET_KILL
	Syntax: SET KILL {ON | QUICK | IMMED | OFF}
	
	Die Kill Sicherheitsfunktion wird ein oder ausgeschaltet. 
	Wenn eingeschaltet, dann wird es von jedem gewünscht, der 
	Ihren Chatname benutzt, sich per Passwort zu identifizieren.
	Wenn dieser in einer Minute sich nicht identifiziert, oder
	den Chatname verändert, wird dessen IRC Verbindung mit %S
	unterbrochen. 
	
	Die QUICK Option bewirkt, daß diese Person statt 
	in einer Minute, in 20 Sekunden das Passwort tippen muß, 
	bevor seine Verbindung getrennt wird. Die IMMED 
	Option bewirkt, daß es keine Warnung gibt, bevor die 
	Verbindung getrennt wird.
	Es ist davon abzuraten, dieses Befehl einzusetzten, 
	außerdem kann der Administrator es auch deaktiviert 
	haben. 

NICK_HELP_SET_SECURE
	Syntax: SET SECURE {ON | OFF}
	
	Die Sicherheits Optionen von %S werden ein/ausgeschaltet.
	Wenn eingeschaltet, wird es von Ihnen erwartet, das
	Passwort zu tippen, obwohl Ihre hostmask in der Access-Liste
	eingetragen sein kann. Aber, wenn Ihre hostmark dort 
	eingetragen ist, dann wird Ihre Verbindung nicht getrennt.

NICK_HELP_SET_PRIVATE
	Syntax: SET PRIVATE {ON | OFF}
	
	Der Chatname erscheint auf der Liste mit /msg %S LIST
	nicht mehr, aber das INFO kann immer aufgerufen werden

NICK_HELP_SET_HIDE
	Syntax: SET HIDE {EMAIL | USERMASK | QUIT} {ON | OFF}
	
	Verschiedene Attribute Ihres Chatnames werden in der Info
	Anzeige mit "/msg %S INFO" versteckt. Diese sind die
	email Adresse (EMAIL), user@host Maske (USERMASK) 
	und die letzte Quit Message (QUIT). Per (OFF) 
	oder (ON) werden diese Versteckoptionen deaktiviert/aktiviert.

NICK_HELP_UNSET
	Syntax: UNSET {URL | EMAIL}
	
	Ermöglicht, die URL die Emailadresse aus Ihrem Eintrag
	zu entfernen. Der URL Parameter entfernt die URL, der 
	EMAIL Parameter die Email Adresse. Sie können nicht
	beide gleichzeitig entfernen.

NICK_HELP_UNSET_REQ_EMAIL
	Syntax: UNSET URL
	
	Ermöglicht, die URL von Ihrem Eintrag zu entfernen.

NICK_HELP_RECOVER
	Syntax: RECOVER Chatname [Passwort]
	
	Ermöglicht die Verbindung einer Person, die Ihren Chatnamen
	benutzt, zu trennen. Wenn die KILL Sicherheitsfunktion aktiv
	wäre, würde %S das auch automatisch tun.
	
	Mit diesem Befehl, verbindet %S einen Klon mit ihrem Chatnamen
	zum Server, und das führt dazu, daß die Verbindung vom anderen
	Benutzer getrennt wird. Dieser Klon bleibt eine Minute online.
	Sie können nach einer Minute Ihren Chatnamen zurückhaben, Mit
	RELEASE Befehl wäre es möglich, den Chatnamen früher
	freizugeben (/msg %S HELP RELEASE).
	
	Um den RECOVER-Befehl zu benutzen, müssten Sie entweder auf der
	Zugriffsliste des Chatnames sein, oder sie müssen das Passwort
	angeben.

NICK_HELP_RELEASE
	Syntax: RELEASE Chatname [Passwort]
	
	Gibt den Chatname früher frei, der von %S gehalten ist. 
	
	Um RELEASE zu benutzen, müssten Sie entweder in der Zugriffsliste
	des Chatnames sein, oder sie müssen das Passwort angeben.

NICK_HELP_GHOST
	Syntax: GHOST Chatname [Passwort]
	
	Trennt die nicht mehr aktive Verbindung eines Chatnames, die
	vom Server noch als aktiv gehalten wird. Der GHOST-Befehl wird
	z.B. gelegentlich dann eingesetzt, wenn der Client-Computer
	abgestürzt ist oder Ihre Internet-Verbindung unerwartet getrennt
	wird. Diese verursachen, daß der Chatname immer noch im IRC ist,
	also ein Geist (Engl. GHOST) ist.  
	
	Um den GHOST-Befehl zu benutzen, müssten Sie entweder in der
	Zugriffsliste des Chatnames sein, oder sie müssen das Passwort
	angeben.

NICK_HELP_INFO
	Syntax: INFO Chatname [ALL]
	
	Zeigt Information über den gegebenen Chatnamen. So wie wem
	der Nick gehört, letzte gesehene Adresse und Zeit und eingestellte
	Optionen.  Wenn der Nick Ihnen gehört und sie ALL auch mit
	spezifizieren, dann werden alle Informationen gezeigt, auch wenn
	sie versteckt sind.

NICK_HELP_LIST
	Syntax: LIST Parameter
	
	Zeigt alle Chatnamen an, die zu den gegebenen Parametern 
	passen. Chatnames mit PRIVATE Option werden nicht gezeigt.
	
	Beispiele:
	
	    LIST *!Joseph_14@*.ira.uka.de
	         Chatnames, dessen Besitzer von *!Joseph_14@*.ira.uka.de	 
		 kommen, werden gelistet.
	
	    LIST *Bot*!*@*
	        Chatnames, die die Buchstaben BOT haben, werden
		aufgelistet. Gross Kleinschreibung ist unwichtig.
	
	    LIST *!*@*.ira.uka.de
	        Chatnames vom Domäne der ira.uka.de werden
	        aufgelistet.

NICK_HELP_LISTCHANS
	Syntax: LISTCHANS
	
	Zeigt die Namen der Räume an, die Sie registriert haben.

NICK_HELP_STATUS
	Syntax: STATUS [Chatname]
	
	Zeigt einen Code an, um herauszufinden, ob dieser Chatname
	dieser Person gehört. Antwort ist in dieser Form :
	
	    Chatname   Status-Code
	
	Chatname ist der, welchen sie gegeben haben, Status-Code
	ist einer von diesen:

	    0 - Chatname ist nicht registriert/user ist offline.
	    1 - Chatname wurde nicht identifiziert mit.
	    2 - Die Adresse dieser Benutzer ist auf der Access-Liste
	        des Chatnames.
	    3 - Der Benutzer wurde identifiziert.
	
	Sie können bis zu 16 Chatnames angeben, die weiteren werden
	ingoriert. Keine Fehlermeldung wird angezeigt, wenn der
	Chatname nicht angegeben wird.

NICK_SERVADMIN_HELP
	
	Diese Befehls stehen nur den Cservice Members zur Verfügung:
	
	    GETPASS    Zeigt das Passwort des gegebenen Chatnamens.
	    FORBID     Verbietet die Syntax des gegebenen Chatnamens.
	    SUSPEND    Suspendiert die Benutzung des gegebenen Chatnamens.
	    LISTLINKS  Zeigt die aktuellen Links zu einem Chatnamen.
	
	Cservice Members können andere Chatnamen mit folgenden Befehlen
	manipulieren, ohne sich für den Betroffenen Chatnamen zu
	identifizieren:
	    DROP, SET, ACCESS LIST, INFO ALL

NICK_SERVADMIN_HELP_DROP
	Syntax: DROP Chatname
	
	Ohne Parameter wird ihr aktueller Chatname aus der Datenbank
	gelöscht.
	Mit Parameter wird der angegebene Chatname aus der Datenbank
	gelöscht.
	Dies steht nur den Cservice Members zur Verfügung.	

NICK_SERVADMIN_HELP_SET
	
	Cservice Members können die Option NOEXPIRE setzen, so daß
	eine Chatnamenregistrierung nicht verfällt. Cservice Members
	können desweiteren Optionen sämtlicher Chatnamen, ohne das
	Passwort anzugeben, mit dem forgendem Befehl setzen: 
	SET Chatname Option Parameter.

NICK_SERVADMIN_HELP_SET_NOEXPIRE
	Syntax: SET Chatname NOEXPIRE {ON | OFF}
	
	Bestimmt, ob die Registrierung des Chatnamen verfällt.
	Wenn ON angegeben wird, wird der angegebene Chatname
	nicht verfallen und nicht aus der Datenbank gelöscht.

	Dieser Befehl steht nur den Cservice Members zur Verfügung.	

NICK_SERVADMIN_HELP_UNSET
	
	Cservice Members können auch den UNSET-Befehl für jeden
	Chatnamen benutzen, ohne das Passwort anzugeben.

NICK_SERVADMIN_HELP_UNLINK
	
	Cservice Members können von jedem Chatnamen einen Link aufheben,
	ohne Passwort anzugeben.

NICK_SERVADMIN_HELP_LISTLINKS
	Syntax: LISTLINKS Chatname [ALL]
	
	Zeigt alle Links zu dem gegebenen Chatnamen an. Wenn ALL auch
	angegeben ist, werden alle Chatnamen mit den gleichen Rechten
	gezeigt, sonst werden nur die direkten Links gezeigt.

	Dieser Befehl steht nur den Cservice Members zur Verfügung.	

NICK_SERVADMIN_HELP_ACCESS

	Cservice Members können mit einem Chatnamen-Parameter zu
	LIST die Zugriffsliste von jedem Chatnamen anzeigen.

NICK_SERVADMIN_HELP_INFO
	
	Cservice Members können den ALL Parameter für alle Chatnamen
	benutzen.

NICK_SERVADMIN_HELP_LIST
	Syntax: LIST Parameter [FORBIDDEN] [NOEXPIRE] [SUSPENDED]
	
	Zeigt alle Chatnamen an, die zu den angegebenen Parametern 
	passen. Chatnamen mit PRIVATE Option werden auch gezeigt.
	Die NOEXPIRE Nicks werden mit einem !, die suspendierten mit einem
	* markiert.
	
	Wenn  FORBIDDEN, SUSPENDED oder NOEXPIRE angegeben sind,
	werden nur verbotene, suspendierte, oder noexpire Chatnamen angezeigt.
	Diese Optionen können in beliebiger Reihenfolge oder Kombination
	gegeben werden. Sie sind nur von den Cservice Members anwendbar.
	
	Beispiele:
	
	    LIST *!Joseph_14@*.ira.uka.de
	         Chatnamen, dessen Besitzer von *!Joseph_14@*.ira.uka.de	 
		 kommen, werden gelistet.
	
	    LIST *Bot*!*@*
	        Chatnamen, die die Buchstaben BOT haben, werden
		aufgelistet. Gross Kleinschreibung ist unwichtig.
	
	    LIST * NOEXPIRE
	        Chatnamen, die nicht verfallen, werden aufgelistet.

NICK_SERVADMIN_HELP_LISTCHANS
	
	Cservice Members können jederzeit die Liste der registrierten Räume
	von einem Chatnamen erhalten:
	/msg DogTag LISTCHANS Chatname).

NICK_SERVADMIN_HELP_GETPASS
	Syntax: GETPASS Chatname
	
	Zeigt das Passwort des angegebenen Chatnamens. Ein WALLOPS
	oder ein GLOBOPS wird weitergeleitet mit dem Chatnamen des
	Admins, der GETPASS benutzt hat.
	
	Dieser Befehl steht nur den Cservice Members zur Verfügung.	

	Dieser Befehl ist nicht aufrufbar, wenn Verschlüsselung aktiv ist.

NICK_SERVADMIN_HELP_FORBID
	Syntax: FORBID Chatname
	
	Verbietet die Benutzung des gegebenen Chatnames. Der Verbot
	wird nur mit DROP aufgehoben.

	Dieser Befehl steht nur den Cservice Members zur Verfügung.	

NICK_SERVADMIN_HELP_SUSPEND
	Syntax: SUSPEND [+Dauer] Chatname Grund
	
	Verhindert, daß der Chatname, und alle damit verbundenen,
	benutzt, oder identifiziert werden.
	UNSUSPEND hebt die Suspendierung auf.
	
	Im Gegensatz zu Verbot (FORBID), verliert der Chatname
	seine Information nicht. Die Registrierung kann ebenfalls
	verfallen.
	
	Dieser Befehl steht nur den Cservice Members zur Verfügung.	

NICK_SERVADMIN_HELP_UNSUSPEND
	Syntax: UNSUSPEND Chatname
	
	Hebt die Suspendierung des Chatnamens auf.

	Dieser Befehl steht nur den Cservice Members zur Verfügung.	


###########################################################################
#
# ChanServ help messages
#
###########################################################################

CHAN_HELP
	%S ermöglicht es Ihnen, einen Raum zu registrieren
	und selbst zu kontrollieren. %S kann verhindern, daß ihr
	Raum von unbefügten übernommen wird. 
	Die verfügbaren Befehle sind unten aufgelistet. Um sie zu
	benutzen, versuchen Sie /msg %S Befehl. Für Hilfe
	über einen bestimmten Befehl, versuchen Sie
	/msg %S HELP Befehl .
	
	    REGISTER   Der Raum wird für Sie registriert.
	    IDENTIFY   Indentifiziert Sie als Eigentümer des Raumes.
	    DROP       Löscht den Raum aus der Datenbank.
	    INFO       Zeigt Optionen und Informationen über den Raum.
	    SET        Setzt Optionen und Informationen für den Raum.
	    ACCESS     Modifiziert die Zugriffsliste.
	    SOP        Modifiziert die SuperOp-Liste
	    AOP        Modifiziert die AutoOp-Liste
	    VOP        Modifiziert die VoiceOp-Liste
	    AKICK      Modifiziert die AutoKick-Liste.
	
CHAN_HELP_OTHERS
	
	Weitere Befehle: UNSET, LIST, INVITE, UNBAN, CLEAR,
	                 LEVELS, OP, DEOP, VOICE, DEVOICE

CHAN_HELP_OTHERS_HALFOP_CHANPROT
	
	Weitere Befehle: UNSET, LIST, INVITE, UNBAN, CLEAR,
	                 LEVELS, OP, DEOP, VOICE, DEVOICE,
	                 HALFOP, DEHALFOP, PROTECT, DEPROTECT,
	                 HOP

CHAN_HELP_EXPIRES

	Vergessen Sie Bitte nicht, daß Räume, die %d Tage nicht
	benutzt werden, automatisch verfallen und gelöscht werden.
	Zum Beispiel solche Räume, die niemand aus der Zugriffsliste
	besucht hat.

CHAN_HELP_REGISTER
	Syntax: REGISTER Raum Passwort Beschreibung
	
	Registriert ein Raum unter Ihrem Chatnamen. Um überhaupt
	diesen Befehl ausführen zu können, müssen sie ein ChanOp sein. 
	Das Passwort brauchen Sie später um sich als "Gründer" zu
	identifizieren (^BIDENTIFY^B).
	Die Beschreibung (letzter Parameter) muß angegeben werden.
	Das Passwort sollten Sie nicht vergessen. Dem Gründer gibt
	%S jedesmal automatisch das +o Modus (AutoOp).
	Mit Hilfe der Befehle ACCESS und LEVELS können
	Zugriffsrechte anderer Benutzer/Chatnamen modifiziert werden.
	
	WICHTIG: Um ein Raum überhaupt registrieren zu können,
	müssen Sie einen registrierten Chatnamen haben.
	/msg %s HELP für weitere Informationen.

CHAN_HELP_IDENTIFY
	Syntax: IDENTIFY Raum Passwort
	
	Sie indentifizieren sich dem %S gegenüber als Gründer des Raumes.
	Das Passwort ist das, das Sie beim Registrieren benutzt haben.
	Viele Befehle setzen voraus, daß Sie die Identifikation ausfühen,
	bevor sie diese nutzen können.

CHAN_HELP_DROP
	Syntax: DROP Raum

	Der gegebene Raum wird aus der Datenbank gelöscht. Nur der
	Gründer darf diesen Befehl nach dem IDENTIFY benutzen. 

CHAN_HELP_SET
	Syntax: SET Raum Optionen Parameter
	
	Bestimmt sämtliche Raum-Optionen. Dafür muß der Gründer
	mit IDENTIFY sich dem %S gegenüber identifiziert haben.
	
	Optionen:
	
	    FOUNDER     Bestimmt einen neuen Gründer.
	    SUCCESSOR   Bestimmt einen neuen Nachfolger.
	    PASSWORD    Bestimmt ein neues Raum-Passwort.
	    DESC        Bestimmt eine neue Beschreibung.
	    URL         Fügt eine URL dem Raum-Eintrag hinzu.
	    EMAIL       Fügt eine Emailadresse dem Raum-Eintrag hinzu.
	    ENTRYMSG    Ändert die Begrüßungsnachricht.
	    TOPIC       Ändert das Thema des Raumes.
	    KEEPTOPIC   Ändert die Option zur Beibehaltung des Themas.
	    TOPICLOCK   Ändert die Option zur Sperrung des Themas.
	    MLOCK       Setzt neues Sperr-Modus.
	    PRIVATE     In %S Listen wird der Raum nicht angezeigt.
	    SECUREOPS   Bis auf Chatnamen in der Zugriffsliste kann
	                niemand Op werden.
	    RESTRICTED  Bis auf Chatnamen in der Zugriffsliste kann
	                niemand den Raum betreten.
	    SECURE      %S Sicherheitsfunktionen werden aktiviert.
	    LEAVEOPS    Niemandem beim JOIN deoppen.
	    OPNOTICE    Eine NOTICE schicken, wenn OP/DEOP Befehle
	                benutzt werden.
	    ENFORCE     Zwingt die Autoop und Autovoice status.
	
	/msg %S HELP Option für weitere Informationen.

CHAN_HELP_SET_FOUNDER
	Syntax: SET Raum FOUNDER Chatname
	
	Setzt den Chatnamen als neuen Gründer des Raumes.
	Der Gründer muß einen registrierten Chatnamen haben.

CHAN_HELP_SET_SUCCESSOR
	Syntax: SET Raum SUCCESSOR Chatname
	
	Ändert den Nachfolger des Raumes. Wenn der Chatname des
	Gründers abläuft, oder gedropped wird, bekommt der Nachfolger
	den Gründerstatus. Dies erfolgt aber nicht, wenn des Nachfolger
	bereits %d registrierte Räume hat. Dann wird der Raum gelöscht,
	auch, wenn ein Nachfolger gesetzt war. Das Nachfolger muß ein
	registrierter Chatname sein.

CHAN_HELP_SET_PASSWORD
	Syntax: SET Raum PASSWORD neues_Passwort
	
	Setzt ein neues Raum-Passwort für den Gründer-Zugriff.

CHAN_HELP_SET_DESC
	Syntax: SET Raum DESC Beschreibung
	
	Setzt eine neue Beschreibung für den Raum, die bei LIST und
	INFO gezeigt wird. Man muß den Gründer-Zugriff haben,
	um dies zu benutzen.

CHAN_HELP_SET_URL
	Syntax: SET Raum URL [URL]
	
	Fügt URL dem Raum-Eintrag hinzu. Diese URL wird bei INFO
	angezeigt. Wenn keine URL angegeben ist, wird die aktuelle
	gelöscht.

CHAN_HELP_SET_EMAIL
	Syntax: SET Raum EMAIL [Adresse]
	
	Fügt dem Raum-Eintrag eine Emailadresse hinzu. Die wird bei
	INFO angezeigt. Wenn keine Adresse angegeben ist, wird die
	aktuelle gelöscht.

CHAN_HELP_SET_ENTRYMSG
	Syntax: SET Raum ENTRYMSG text
	
	Settz eine neue Begrüßungsnachricht, die man als /NOTICE
	erhält, wenn man diesen Raum betritt.

CHAN_HELP_SET_TOPIC
	Syntax: SET Raum TOPIC Topic
	
	Bewirkt, daß %S das Thema für den Raum setzt.
	Besonders nützlich, wenn TOPICLOCK aktiv ist.

CHAN_HELP_SET_KEEPTOPIC
	Syntax: SET Raum KEEPTOPIC {ON|OFF}
	
	Bewirkt, daß das Thema, nich verlorengeht, wenn niemand im
	Raum ist. Wenn topic retention aktiv ist, wird der Topic
	gespeichert, und, wenn jemand den Raum betritt, wird er gesetzt.

CHAN_HELP_SET_TOPICLOCK
	Syntax: SET Raum TOPICLOCK {ON|OFF}
	
	Die Topic Lock Option wird aktivert/deaktiviert.
	Wenn aktiv, verhindert %S, daß jemand das Thema ändert, 
	sofern SET TOPIC nicht benutzt ist.

CHAN_HELP_SET_MLOCK
	Syntax: SET Raum MLOCK Modi
	
	Aktiviert/deaktiviert die Mode-Lock Option für den Raum.
	%S ermöglicht, daß bestimmte Modi (Raumoptionen) immer
	eingeschaltet werden.
	Diese sind  i, k, l, m, n, p, s und t.
	Die Modi sind ähnlich dem /MODE-Befehl aufgebaut: die
	Modi, die einem + folgem werden aktiviert, die einem -
	folgen, werden deaktiviert.

	Warnung: Falls Sie, wie im zweiten Beispiel ein ModeLock 
	setzen wollen, dann sollten sie die RESTRICTED-Option 
	auch setzen, so daß wenn jemand den leeren Raum betritt, den 
	Schlüssel nicht sieht. (siehe HELP SET RESTRICTED).
	
	Beispiele:
	
	    SET #Raum MLOCK +nt-iklps
		Die Modes +tn sind aktiv, die iklps sind inaktiv, und
		%S wird verhindern, daß Sie gesetzt werden. Aber Mode
		m kann gesetzt werden.  
	
	    SET #Raum MLOCK +knst-ilmp schlüssel
		Die Modes +knst sind aktiv, mit schlüssel für k, und
		die Modes ilmp sind inaktiv.
	
	    SET #kanal MLOCK +
	        Deaktiviert ModeLock, alle Modes werden frei setzbar sein.

CHAN_HELP_SET_PRIVATE
	Syntax: SET Raum PRIVATE {ON|OFF}
	
	Setzt die private-Option für den Raum. Wenn aktiv, wird der
	Raum auf der Liste mit /msg %S LIST nicht erscheinen.
	
CHAN_HELP_SET_RESTRICTED
	Syntax: SET Raum RESTRICTED {ON|OFF}
	
	Setzt die RESTRICTED Option für den Raum. Wenn aktiv,
	kann niemand den Raum betreten, wenn er nicht in der
	Zugriffsliste eingetragen ist.

CHAN_HELP_SET_SECURE
	Syntax: SET Raum SECURE {ON|OFF}
	
	Aktiviert/deaktiviert %S Sicherheitsfunktionen für den Raum.
	Wenn aktiv, können nur die, die ihren Chatnamen mit %s
	registriert haben und sich mit IDENTIFY identifiziert haben,
	besondere Rechte zum Raum erhalten, folgend der Zugriffsliste.

CHAN_HELP_SET_SECUREOPS
	Syntax: SET Raum SECUREOPS {ON|OFF}
	
	Aktiviert/deaktiviert die Secureops-Option, so daß Benutzer,
	die nicht in der Zugriffsliste vermerkt sind, den Op-Status
	nicht erhalten können.

CHAN_HELP_SET_LEAVEOPS
	Syntax: SET Raum LEAVEOPS {ON | OFF}
	
	Aktiviert/deaktiviert die Leaveops-Option. Wenn aktiv, wird
	%S die erste Person im Raum nicht deoppen. Die Optionen
	SECUREOPS und AUTODEOP werden trotzdem beachtet.

CHAN_HELP_SET_OPNOTICE
	Syntax: SET Raum OPNOTICE {ON | OFF}
	
	Aktiviert/deaktiviert die OP-Notice-Option. Wenn aktiv, wird
	%S ein Notice zum Raum schicken, wo steht, wer für wen
	den OP oder DEOP-Befehl benutzt hat.

CHAN_HELP_SET_ENFORCE
	Syntax: SET Raum ENFORCE {ON | OFF}
	
	Aktiviert/deaktiviert die Zwangsoption für Auto-Op und
	Auto-Voice. Wenn aktiv, überprüft %S die Auto-Op und
	Auto-Voice Privilegien. Das bedeutet, wenn ein Benutzer mit
	Auto-Op Status gedeopped wird, wird %S ihn wieder oppen, und
	auch verhindern, daß der DEOP Befehl für den Benutzer
	eingesetzt wird.

CHAN_HELP_UNSET
	Syntax: UNSET Raum {SUCCESSOR | URL | EMAIL | ENTRYMSG}
	
	Löscht die gegebene Information von dem Raum-Eintrag.

CHAN_HELP_SOP
	Syntax: SOP Raum ADD Chatname
	        SOP Raum DEL Chatname
	        SOP Raum LIST [Maske | Liste]
	        SOP Raum COUNT
	
CHAN_HELP_SOP_NOPROT
	Modifiziert die SuperOp-Liste (SOP) des Raums.
	Benutzer mit SOP Status werden automatisch geopt (+o),
	wenn sie den Raum betreten.
CHAN_HELP_SOP_PROT
	Modifiziert die SuperOp-Liste (SOP) des Raums.
	Benutzer mit SOP-Status werden automatisch geopt (+o),
	und auch geschützt (+a), wenn sie das Raum betreten.
CHAN_HELP_SOP_END
	
	Ein SOP kann die AOP- und VOP-Listen bearbeiten, nur
	der Gründer kann die SOP-Liste bearbeiten.
	
	SOP LIST zeigt die SOP-Liste. Wenn eine Maske angegeben ist,
	werden nur die passenden Einträge angezeigt.
	Wenn ein Bereich angegeben ist, werden nur enthaltene Einträge
	angezeigt.
	
	   SOP #channel LIST 2-5,7-9
	      Zeigt SOP-Einträge zwischen 2 und 5, und 7 und 9
	
	SOP COUNT gibt die Anzahl der SOP-Einträge an.

CHAN_HELP_AOP
	Syntax: AOP Raum ADD Chatnam
	        AOP Raum DEL Chatnam
	        AOP Raum LIST [Maske | Liste]
	        AOP Raum COUNT
	
	Modifiziert die AutoOp-Liste (AOP) des Raums.
	Alle Benutzer mit AOP-Status werden automatisch geopt (+o),
	wenn sie den Raum betreten.
	
	Ein AOP kann die VOP-Liste bearbeiten.
	
	AOP LIST zeigt die AOP-Liste.  Wenn eie Maske angegeben ist,
	werden nur die passenden Einträge angezeigt.
	Wenn ein Bereich angegeben ist, werden nur enthaltene Einträge
	angezeigt.
	
	   AOP #channel LIST 2-5,7-9
	      Listet AOPs zwischen 2 und 5, und 7 und 9
	
	AOP COUNT gibt die Anzahl der AOP-Einträge an.

CHAN_HELP_HOP
	Syntax: HOP Raum ADD Chatname
	        HOP Raum DEL Chatname
	        HOP Raum LIST [Maske | Liste]
	        HOP Raum COUNT
	
	Modifiziert die HalfOp-Liste (HOP) des Raums.
	Alle Benutzer mit HOP-Status erhalten ein Halfop (+h),
	wenn sie den Raum betreten.
	
	Ein HOP kann die VOP-Liste bearbeiten, (SOP und
	AOPs ebenfalls).

	HOP LIST listet die Halfops auf.  Wenn eie Maske angegeben ist,
	werden nur die passende Einträge angezeigt.
	Wenn ein Bereich angegeben ist, werden nur enthaltene Einträge
	angezeigt.
	
	   HOP #channel LIST 2-5,7-9
	      Listet HOPs zwischen 2 und 5, und 7 und 9
	
	HOP COUNT gibt die Anzahl der HOP-Einträge an.

CHAN_HELP_VOP
	Syntax: VOP Raum ADD Chatname
	        VOP Raum DEL Chatname
	        VOP Raum LIST [Maske | Liste]
	        VOP Raum COUNT
	
	Modifiziert die VoiceOp-Liste (VOP) des Raums.
	Benutzer mit VOP-Status erhalten ein Voice (+v),
	wenn sie den Raum betreten.

	VOP LIST zeigt die Auto-Voices.  Wenn eine Maske angegeben
	ist, werden nur die passende Einträge angezeigt.
	Wenn ein Bereich angegeben ist, werden nur enthaltene Einträge
	angezeigt.
	
	   VOP #channel LIST 2-5,7-9
	      Listet VOPs zwischen 2 und 5, und 7 und 9
	
	VOP COUNT gibt die Anzahl der VOP-Einträge an.
	
CHAN_HELP_ACCESS
	Syntax: ACCESS Raum ADD [Chatname] Stufe}
	        ACCESS Raum DEL {Chatname | Nummer | Liste}
	        ACCESS Raum LIST [Maske]
	        ACCESS Raum COUNT

	Verwaltet die Zugriffsliste des Raumes. In dieser Liste sind
	die Chatnamen eingetragen, die autoop werden können, oder
	Zugriff auf andere %S Befehls habee können. Die Stufe bestimmt
	die verschiedenen Zugriffsrechte. Die Standarteinstellungen
	können natürlich von dem Gründer geändert werden. (siehe 
	/msg %S HELP ACCESS LEVELS) 
	Jeder Chatname, der nicht eingetragen ist, hat die Stufe 0.
	
	ACCESS ADD trägt den gegebenen Chatnamen in die Zugriffsliste
	mit der gegebenen Stufe ein. Die Stufe muß kleiner als Stufe von
	der Person sein, die diesen Befehl ausführen will. Außerdem kann
	man keine niedrigere Stufe für einen Chatnamen setzen, der mit
	einer höheren Stufe eingetragen ist, als die vom aktuellen
	Benutzer.
	
	ACCESS DEL löscht den angegebenen Chatnamen von der Liste.
	
	ACCESS LIST zeigt die Zugriffsliste; wenn ein Parameter
	angegeben worden ist, werden nur die Chatnamen angezeigt,
	die dem Parameter entsprechen.

	ACCESS COUNT gibt die Anzahl der VOP-Einträge an.

CHAN_HELP_ACCESS_LEVELS
	Die Zugriffsstufen
	
	Die Standarteinstellungen:      
	
	   Gründer  Als der Besitzer des Raums hat der Gründer 
	                vollständigen Zugriff auf alle %S-Befehle und
	                Auto-Op, wenn er den Raum betritt. Zu beachten
	                ist, daß es keinen zweiten Gründer geben kann.
	        10  Kann AKICK Befehl aufrufen.
	         5  Auto-Op (+o).
	         3  Auto-Voice (+v).
	         0  Normaler Benutzer.Wenn Secureops nicht 
	   			aktiv ist kann, normal op werden.
	        <0  Benutzer kann kein Op werden.
	
	Mit dem LEVELS-Befehl können diese Werte geändert, und neue
	hinzugefügt werden.
	/msg %S HELP LEVELS für weitere Informationen.

CHAN_HELP_AKICK
	Syntax: AKICK Raum ADD Maske [Grund]
	        AKICK Raum DEL Maske
	        AKICK Raum LIST	
	
	Bearbeitet die AutoKick-Liste eines Raumes. Wenn jemand,
	der in diese Liste eingeragen ist, den Raum betritt, wird
	er vom %S sofort gebannt und gekickt.
	
	AKICK ADD trägt die Maske oder den Chatnamen in diese Liste
	ein. Wenn ein Grund spezifiziert wurde, wird dieser als
	Kick-Grund benutzt.
	
	AKICK DEL löscht die Maske oder den Chatnamen von der Liste,
	aber falls es existierende Bans im Raum gibt, sollten diese durch
	einen Raum-Op aufgehoben werden. 
	
	AKICK LIST gibt die AutoKick Liste wieder, falls mit einem
	Parameter aufgerufen, werden die Einträge gezeigt,
	die dem Parameter entsprechen.

CHAN_HELP_LEVELS
	Syntax: LEVELS Raum SET Option Level
	        LEVELS Raum {DIS | DISABLE} Option
	        LEVELS Raum LIST
	        LEVELS Raum RESET
	
	LEVELS setzt die benötigten Zugriffsstufen für bestimmte
	Operationen neu (ACCESS LEVELS). Die Befehle SET FOUNDER,
	SET PASSWORD und dieser (LEVELS) stehen ausschließlich
	dem Gründer zur verfügung.

	Warnung: Dieser Befehl ist für erfahrene Benutzer. Das
	Ändern der Stufen kann dazu führen, daß die Befehle SOP,
	AOP und HOP nicht mehr richtig funktionieren.
	
	LEVELS SET setzt eine neue Stufe für die angegebene Option.
	LEVELS DISABLE oder DIS deaktiviert diese Option 
	für normale Benutzer (bis auf den Gründer).
	
	LEVELS LIST zeigt die aktuelle Stufenliste.
	LEVELS RESET ersetzt die Stufen mit den Standarteinstellungen.

	HELP ACCESS LEVELS für die Beschreibung der Standardeinstellungen.
	HELP LEVELS DESC für die Beschreibung der Optionen.

CHAN_HELP_LEVELS_DESC
	Folgende Optionen können mit LEVELS SET gesetzt werden.
	Zu beachten ist, daß die Stufen für AUTOOP und NOJOIN maximale,
	die anderen minimale Werte beschreiben.

CHAN_HELP_LEVELS_DESC_FORMAT
	    %-*s  %s

CHAN_HELP_INFO
	Syntax: INFO Raum [ALL]
	
	Zeigt Information über einen registrierten Raum, so wie den
	Gründer, Registrierungsdatum, letzte Benutzung, Sperr-Modi.
	Wenn Sie auch der Gründer sind, können Sie mit ALL alle
	Information wie Begrüßungstext und Nachfolger erhalten.
	
CHAN_HELP_LIST
	Syntax: LIST Parameter
	
	Zeigt alle Räume, die dem gegebenen Parameter entsprechen
	(bis auf die, die die PRIVATE-Option haben).

CHAN_HELP_OP
	Benuzung: OP Raum Chatname
	
	Gibt dem angegebenen Chatnamen den Raum-Op-Status (+o).
	Standardmäßig eingeschränkt zu den Personen, die in der
	Zugriffsliste die Stufe 5 oder höher haben.

CHAN_HELP_DEOP
	Syntax: DEOP Raum Chatname
	
	Entzieht dem Chatnamen den Raum-Op-Status (-o).
	Standardmäßig eingeschränkt zu den Personen, die in der
	Zugriffsliste die Stufe 5 oder höher haben.

CHAN_HELP_VOICE
	Syntax: VOICE Raum Chatname
	
	Gibt dem angegebenen Chatnamen den Voice-Status (+v).
	Standardmäßig eingeschränkt zu den Personen, die in der
	Zugriffsliste die Stufe 3 oder höher haben.

CHAN_HELP_DEVOICE
	Syntax: DEVOICE Raum Chatname
	
	Entzieht dem Chatnamen den Voide-Status (-v).
	Standardmäßig eingeschränkt zu den Personen, die in der
	Zugriffsliste die Stufe 3 oder höher haben.

CHAN_HELP_HALFOP
	Syntax: HALFOP Raum Chatname
	
	Gibt dem angegebenen Chatnamen den Halfop-Status (+h).
	Standardmäßig eingeschränkt zu den Personen, die in der
	Zugriffsliste die Stufe 4 oder höher haben.

CHAN_HELP_DEHALFOP
	Syntax: DEHALFOP Raum Chatname
	
	Entzieht dem Chatnamen den Halfop-Status (-h).
	Standardmäßig eingeschränkt zu den Personen, die in der
	Zugriffsliste die Stufe 4 oder höher haben.

CHAN_HELP_PROTECT
	Syntax: PROTECT Raum Chatname
	
	Gibt dem angegebenen Chatnamen den Protect-Status (+a).
	Standardmäßig eingeschränkt auf die Personen, die in der
	Zugriffsliste die Stufe 10 oder höher haben.

CHAN_HELP_DEPROTECT
	Syntax: DEPROTECT Raum Chatname
	
	Entzieht dem Chatnamen den Protect-Status (-a).
	Standardmäßig eingeschränkt auf die Personen, die in der
	Zugriffsliste die Stufe 10 oder höher haben.

CHAN_HELP_INVITE
	Syntax: INVITE Raum
	
	Lässt %S Sie zum angegebenen Raum einladen (invite). 
	Standardmäßig eingeschränkt auf die Personen, die in der
	Zugriffsliste die Stufe 5 oder höher haben.

CHAN_HELP_UNBAN
	Syntax: UNBAN Raum
	
	Lässt %S alle Bans aufheben, die Sie daran hindern den Raum
	zu betreten.
	Standardmäßig eingeschränkt auf die Personen, die in der
	Zugriffsliste die Stufe 5 oder höher haben.

CHAN_HELP_CLEAR
	Syntax: CLEAR Raum Einstellung
	
	Lässt %S bestimmte Typen von Einstellungen vom Raum entfernen.
	Die Einstellung kann eine der folgenden sein:
	
	     MODES       Alle Modi bis auf Mlock entfernen.
	     BANS        Alle Bans entfernen
CHAN_HELP_CLEAR_EXCEPTIONS
	     EXCEPTIONS  Alle Exceptions entfernen
CHAN_HELP_CLEAR_MID
	     OPS         Ein Massdeop ausführen.
CHAN_HELP_CLEAR_HALFOPS
	     HALFOPS     Ein Mass-de-halfop ausführen.
CHAN_HELP_CLEAR_END
	     VOICES      Ein Massdevoice ausführen.
	     USERS       Ein Masskick ausführen.
	
	Standardmäßig eingeschränkt auf die Personen, die in der
	Zugriffsliste die Stufe 10 oder höher haben.
	
CHAN_SERVADMIN_HELP
	
	Diese Befehle können nur Cservice Members benutzen:
	
	    GETPASS   Gibt das Passwort des gegebenen Raums.
	    FORBID    Verbietet die Benutzung des gegebenen Raums.
	    STATUS    Gibt die Stufe der Benutzers in der Zugriffsliste
	              des Raumes.
	    SUSPEND   Suspendiert die Benutzung eines Raums.
	
	Cservice Members können ohne IDENTIFY ein Raum-Eintrag
	löschen (DROP), das Passwort neu setzen, oder die Zugriffsliste 
	bearbeiten (/msg %S ACCESS Raum {ADD | DEL | LIST}) .

CHAN_SERVADMIN_HELP_DROP
	Syntax: DROP Raum
	
	Löscht den Raum Eintrag, ohne das Passwort geben zu müssen.

CHAN_SERVADMIN_HELP_SET
	
	Cservice Members können NOEXPIRE für einen Raum setzen,
	so daß die Raumregistrierung nicht verfällt. Cservice Members
	können desweiteren Optionen sämtlicher Räume setzen, ohne das
	Passwort anzugeben.

CHAN_SERVADMIN_HELP_SET_NOEXPIRE
	Syntax: SET Raum NOEXPIRE {ON | OFF}
	
	Bestimmt, ob die Raumregistrierung verfällt.
	Wenn On angegeben wird, wird der Raum nicht
	verfallen  und nicht aus der Datenbank gelöscht..
	
	Dieser Befehl steht nur den Cservice Members zur Verfügung.
	
CHAN_SERVADMIN_HELP_UNSET
	
	Cservice Members können auch den UNSET-Befehl für jeden
	Raum benutzen, ohne das Passwort anzugeben.

CHAN_SERVADMIN_HELP_INFO
	
	Cservice Members können den ALL Parameter für alle Räume
	benutzen.

CHAN_SERVADMIN_HELP_LIST
	Syntax: LIST Parameter
	
	Zeigt alle Räume, die dem Parameter entsprechen.

CHAN_SERVADMIN_HELP_GETPASS
	Syntax: GETPASS Raum
	
	Zeigt das Passwort für den angegebenen Raum. Ein WALLOPS
	oder ein GLOBOPS wird weitergeleitet mit dem Chatnamen des
	Admins, der GETPASS benutzt hat.
	
	Dieser Befehl steht nur den Cservice Members zur Verfügung.
	
	Dieser Befehl ist nicht aufrufbar, wenn Verschlüsselung aktiv ist.

CHAN_SERVADMIN_HELP_FORBID
	Syntax: FORBID Raum
	
	Verbietet die Benutzung des angegebenen Raumes. Der Verbot
	wird nur mit DROP aufgehoben.
	
	Dieser Befehl steht nur den Cservice Members zur Verfügung.

CHAN_SERVADMIN_HELP_SUSPEND
	Syntax: SUSPEND [+Dauer] Raum Grund
	
	Verhindert, daß der Raum benutzt wird.
	UNSUSPEND hebt die Suspendierung auf.
	
	Im Gegensatz zu Verbot (FORBID), verliert der Raum seine
	Information nicht. Die Registrierung kann ebenfalls verfallen.
	
	Dieser Befehl steht nur den Cservice Members zur Verfügung.

CHAN_SERVADMIN_HELP_UNSUSPEND
	Syntax: UNSUSPEND Raum
	
	Hebt die Suspension eines Raums auf.
	
	Dieser Befehl steht nur den Cservice Members zur Verfügung.


CHAN_SERVADMIN_HELP_STATUS
	Syntax: STATUS Raum Chatname
	
	Gibt den Stufe des Chatnamens in der Zugfiffsliste vom Raum.
	Die Antwort hat die Form:
	
	    STATUS Raum Chatname Access-Level
	
	Dieser Befehl steht nur den Cservice Members zur Verfügung.


CHAN_GENPASS_SYNTAX
	GENPASS channel

CHAN_SERVADMIN_HELP_GENPASS
	Syntax: GETPASS channel

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
	Syntax: GETPASS nickname
	
	Generates a random password and emails it to the registered
	email address.
	
	Limited to Cservice Members^B.

NICK_GENPASS_OK
	A new password was emailed to: %s

