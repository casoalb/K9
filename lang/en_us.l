# Emacs mode: -*- text -*-

# United States English language file.
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
	English

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
	Sun
	Mon
	Tue
	Wed
	Thu
	Fri
	Sat
# %A
STRFTIME_DAYS_LONG
	Sunday
	Monday
	Tuesday
	Wednesday
	Thursday
	Friday
	Saturday
# %b
STRFTIME_MONTHS_SHORT
	Jan
	Feb
	Mar
	Apr
	May
	Jun
	Jul
	Aug
	Sep
	Oct
	Nov
	Dec
# %B
STRFTIME_MONTHS_LONG
	January
	February
	March
	April
	May
	June
	July
	August
	September
	October
	November
	December


# "day", "hour", "minute", and "second" in singular and plural.
STR_DAY
	day
STR_DAYS
	days
STR_HOUR
	hour
STR_HOURS
	hours
STR_MINUTE
	minute
STR_MINUTES
	minutes
STR_SECOND
	second
STR_SECONDS
	seconds


# This is used in ChanServ/DogTag INFO displays.
COMMA_SPACE
	, 


# Various error messages.
USER_RECORD_NOT_FOUND
	Internal error - unable to process request.
UNKNOWN_COMMAND
	Unknown command %s.
UNKNOWN_COMMAND_HELP
	Unknown command %s.  Type /msg %s HELP for help.
SYNTAX_ERROR
	Syntax: %s
MORE_INFO
	Type /msg %s HELP %s for more information.
NO_HELP_AVAILABLE
	No help available for %s.

BAD_EMAIL
	E-mail addresses must be in the form username@hostname.  You may not use colors, bold, underline, or reverse, or any of these characters: , : ; | \ " ( ) < >
BAD_URL
	URLs must be in the form http://hostname[:port]/... (or ftp://, etc.).
BAD_USERHOST_MASK
	Mask must be in the form user@host.
BAD_EXPIRY_TIME
	Invalid expiry time.

SERVICE_OFFLINE
	%s is currently offline.
READ_ONLY_MODE
	Notice: K9 Services is in read-only mode; changes will not be saved!
PASSWORD_INCORRECT
	Password incorrect.

# What's the difference between "Access denied" and "Permission denied"?
# Very little; you can safely make them the same message with no real loss
# of meaning.  If you want to make a distinction, "Access denied" is
# usually used more generally; for example, a non-oper trying to access
# OperServ gets "Access denied", while a non-Services admin trying to use
# DogTag SET NOEXPIRE gets "Permission denied".
ACCESS_DENIED
	Do I know you?
PERMISSION_DENIED
	Permission denied.

MORE_OBSCURE_PASSWORD
	Please try again with a more obscure password.  Passwords should be at least five characters long, should not be something easily guessed (e.g. your real name or your nick), and cannot contain the space or tab characters.
PASSWORD_TRUNCATED
	Notice:  Your password has been truncated to %d characters.

NICK_NOT_REGISTERED
	Your nick isn't registered.
NICK_NOT_REGISTERED_HELP
	Your nick isn't registered.  Type /msg %s HELP for information on registering your nickname.
NICK_X_NOT_REGISTERED
	Nick %s isn't registered.
NICK_X_NOT_IN_USE
	Nick %s isn't currently in use.
NICK_X_FORBIDDEN
	Nick %s may not be registered or used.
NICK_X_SUSPENDED
	Nick %s is suspended and may not be used or identified for.
NICK_X_SUSPENDED_MEMOS
	Nick %s is suspended and may not receive memos.
NICK_IDENTIFY_REQUIRED
	Password authentication required for that command.
	Retry after typing /msg %s IDENTIFY password.
NICK_X_NOT_ON_CHAN_X
	Nick %s isn't currently on channel %s.

CHAN_X_NOT_REGISTERED
	Channel %s isn't registered.
CHAN_X_NOT_IN_USE
	Channel %s isn't currently in use.
CHAN_X_FORBIDDEN
	Channel %s may not be registered or used.
CHAN_X_SUSPENDED
	Channel %s is suspended and may not be used or identified for.
CHAN_X_SUSPENDED_MEMOS
	Channel %s is suspended and may not receive memos.
CHAN_IDENTIFY_REQUIRED
	Password authentication required for that command.
	Retry after typing /msg %s AUTH %s password.

SERV_X_NOT_FOUND
	Server %s not found.

EXPIRES_NONE
	does not expire
EXPIRES_SOON
	expires at next database update
EXPIRES_M
	expires in %d minutes
EXPIRES_1M
	expires in %d minute
EXPIRES_HM
	expires in %d hours, %d minutes
EXPIRES_H1M
	expires in %d hours, %d minute
EXPIRES_1HM
	expires in %d hour, %d minutes
EXPIRES_1H1M
	expires in %d hour, %d minute
EXPIRES_D
	expires in %d days
EXPIRES_1D
	expires in %d day

###########################################################################
#
# DogTag messages
#
###########################################################################

# Automatic messages
NICK_IS_REGISTERED
	This nick is owned by someone else.  Please choose another.
	(If this is your nick, type /msg %s IDENTIFY password.)
NICK_IS_SECURE
	This nickname is registered and protected.  If it is your
	nick, type /msg %s IDENTIFY password.  Otherwise,
	please choose a different nick.
NICK_MAY_NOT_BE_USED
	This nickname may not be used. Please choose another one.
DISCONNECT_IN_1_MINUTE
	If you do not change within one minute, you will be disconnected.
DISCONNECT_IN_20_SECONDS
	If you do not change within 20 seconds, you will be disconnected.
DISCONNECT_NOW
	This nickname has been registered; you may not use it. Please
	choose another nickname before reconnecting.
FORCENICKCHANGE_IN_1_MINUTE
	If you do not change within one minute, I will change your nick.
FORCENICKCHANGE_IN_20_SECONDS
	If you do not change within 20 seconds, I will change your nick.
FORCENICKCHANGE_NOW
	This nickname has been registered; you may not use it.
	Your nickname is now being changed to %s.
NICK_EXPIRES_SOON
	Notice: Your nickname's registration will expire in %d %s.  If you want to continue using your nickname, please identify to %s by typing: /msg %s IDENTIFY password
NICK_EXPIRED
	Notice: Your nickname's registration has expired.  Please re-register your nickname if you want to continue using it.

# REGISTER responses
NICK_REGISTER_SYNTAX
	REGISTER password [email]
NICK_REGISTER_REQ_EMAIL_SYNTAX
	REGISTER password email
NICK_REGISTRATION_DISABLED
	Sorry, nickname registration is temporarily disabled.
NICK_REGISTRATION_FAILED
	Sorry, registration failed.
NICK_REG_PLEASE_WAIT
	Please wait %d seconds before using the REGISTER command again.
NICK_CANNOT_BE_REGISTERED
	Nickname %s may not be registered.
NICK_ALREADY_REGISTERED
	Nickname %s is already registered!
NICK_REGISTERED
	Nickname %s registered under your account: %s
NICK_PASSWORD_IS
	Your password is %s - remember this for later use.
NICK_REGISTERED2
	Nickname %s registered under this account: %s
NICK_PASSWORD2_IS
	It's password is %s

# IDENTIFY responses
NICK_IDENTIFY_SYNTAX
	IDENTIFY password
NICK_IDENTIFY_FAILED
	Sorry, identification failed.
NICK_IDENTIFY_SUCCEEDED
	Password accepted - you are now recognized.

# DROP responses
NICK_DROP_SYNTAX
	DROP
NICK_DROP_DISABLED
	Sorry, nickname de-registration is temporarily disabled.
NICK_DROPPED
	Your nickname has been dropped.
NICK_X_DROPPED
	Nickname %s has been dropped.

# SET responses
NICK_SET_SYNTAX
	SET option parameters
NICK_SET_SERVADMIN_SYNTAX
	SET [nick] option parameters
NICK_SET_DISABLED
	Sorry, nickname option setting is temporarily disabled.
NICK_SET_UNKNOWN_OPTION
	Unknown SET option %s.
NICK_SET_UNKNOWN_OPTION_OR_BAD_NICK
	Unknown SET option %s, or nickname not registered.

# SET PASSWORD responses
NICK_SET_PASSWORD_FAILED
	Sorry, couldn't change password.
NICK_SET_PASSWORD_CHANGED
	Password changed.
NICK_SET_PASSWORD_CHANGED_TO
	Password changed to %s.

# SET LANGUAGE responses
NICK_SET_LANGUAGE_SYNTAX
	SET LANGUAGE number
NICK_SET_LANGUAGE_UNKNOWN
	Unknown language number %d.  Type /msg %s HELP SET LANGUAGE for a list of languages.
NICK_SET_LANGUAGE_CHANGED
	Language changed to English.

# SET URL responses
NICK_SET_URL_CHANGED
	URL for %s changed to %s.

# SET EMAIL responses
NICK_SET_EMAIL_CHANGED
	E-mail address for %s changed to %s.

# SET KILL responses
NICK_SET_KILL_SYNTAX
	SET KILL {ON | QUICK | OFF}
NICK_SET_KILL_IMMED_SYNTAX
	SET KILL {ON | QUICK | IMMED | OFF}
NICK_SET_KILL_ON
	Kill protection is now ON.
NICK_SET_KILL_QUICK
	Kill protection is now ON, with a reduced kill delay.
NICK_SET_KILL_IMMED
	Kill protection is now ON, with no kill delay.
NICK_SET_KILL_IMMED_DISABLED
	The IMMED option is not available on this network.
NICK_SET_KILL_OFF
	Kill protection is now OFF.

# SET SECURE responses
NICK_SET_SECURE_SYNTAX
	SET SECURE {ON | OFF}
NICK_SET_SECURE_ON
	Secure option is now ON.
NICK_SET_SECURE_OFF
	Secure option is now OFF.

# SET PRIVATE responses
NICK_SET_PRIVATE_SYNTAX
	SET PRIVATE {ON | OFF}
NICK_SET_PRIVATE_ON
	Private option is now ON.
NICK_SET_PRIVATE_OFF
	Private option is now OFF.

# SET HIDE responses
NICK_SET_HIDE_SYNTAX
	SET HIDE {EMAIL | USERMASK | QUIT} {ON | OFF}
NICK_SET_HIDE_EMAIL_ON
	Your E-mail address will now be hidden from %s INFO displays.
NICK_SET_HIDE_EMAIL_OFF
	Your E-mail address will now be shown in %s INFO displays.
NICK_SET_HIDE_MASK_ON
	Your last seen user@host mask will now be hidden from %s INFO displays.
NICK_SET_HIDE_MASK_OFF
	Your last seen user@host mask will now be shown in %s INFO displays.
NICK_SET_HIDE_QUIT_ON
	Your last quit message will now be hidden from %s INFO displays.
NICK_SET_HIDE_QUIT_OFF
	Your last quit message will now be shown in %s INFO displays.

# SET NOEXPIRE responses
NICK_SET_NOEXPIRE_SYNTAX
	SET [nickname] NOEXPIRE {ON | OFF}
NICK_SET_NOEXPIRE_ON
	Nick %s will not expire.
NICK_SET_NOEXPIRE_OFF
	Nick %s will expire.

# UNSET responses
NICK_UNSET_SYNTAX
	UNSET {URL | EMAIL}
NICK_UNSET_SYNTAX_REQ_EMAIL
	UNSET URL
NICK_UNSET_URL
	URL for %s unset.
NICK_UNSET_EMAIL
	E-mail address for %s unset.
NICK_UNSET_EMAIL_BAD
	You may not clear your E-mail address.
NICK_UNSET_EMAIL_OTHER_BAD
	Nickname E-mail addresses may not be cleared.

# ACCESS responses
NICK_ACCESS_SYNTAX
	ACCESS {ADD | DEL | LIST} [mask]
NICK_ACCESS_ALREADY_PRESENT
	Mask %s already present on your access list.
NICK_ACCESS_REACHED_LIMIT
	Sorry, you can only have %d access entries for a nickname.
NICK_ACCESS_ADDED
	%s added to your access list.
NICK_ACCESS_NOT_FOUND
	%s not found on your access list.
NICK_ACCESS_DELETED
	%s deleted from your access list.
NICK_ACCESS_LIST
	Access list:
NICK_ACCESS_LIST_X
	Access list for %s:

# LINK responses
NICK_LINK_SYNTAX
	LINK nick password
NICK_LINK_DISABLED
	The LINK command is not available.
NICK_LINK_FAILED
	Sorry, linking failed.
NICK_NO_LINK_SAME
	You can't link to your current nick!
NICK_LINK_CIRCULAR
	Can't link to nick %s: circular link detected.
NICK_LINK_TOO_DEEP
	You can't create a link more than %d levels deep.
NICK_LINK_TOO_MANY_CHANNELS
	Can't link to nick %s: too many channels registered (combined maximum %d).
NICK_LINKED
	Your nick has been linked to %s.

# UNLINK responses
NICK_UNLINK_SYNTAX
	UNLINK [nick password]
NICK_UNLINK_FAILED
	Sorry, unlinking failed.
NICK_NOT_LINKED
	Your nick isn't linked.
NICK_UNLINKED
	Your nick has been unlinked from %s.
NICK_X_NOT_LINKED
	Nick %s isn't linked.
NICK_X_UNLINKED
	Nick %s has been unlinked from %s.

# LISTLINKS responses
NICK_LISTLINKS_SYNTAX
	LISTLINKS nick [ALL]
NICK_LISTLINKS_HEADER
	List of nicknames linked to %s:
NICK_LISTLINKS_FOOTER
	%d linked nicknames.
NICK_X_IS_LINKED
	    %s
NICK_X_IS_LINKED_VIA_X
	    %-20s (via %s)

# INFO responses
NICK_INFO_SYNTAX
	INFO nick [ALL]
NICK_INFO_REALNAME
	%s is %s
NICK_INFO_ADDRESS
	Last seen address: %s
NICK_INFO_ADDRESS_ONLINE
	   Is online from: %s
NICK_INFO_ADDRESS_ONLINE_NOHOST
	%s is currently online.
NICK_INFO_TIME_REGGED
	  Time registered: %s
NICK_INFO_LAST_SEEN
	   Last seen time: %s
NICK_INFO_LAST_QUIT
	Last quit message: %s
NICK_INFO_URL
	              URL: %s
NICK_INFO_EMAIL
	   E-mail address: %s
NICK_INFO_OPTIONS
	          Options: %s
NICK_INFO_LINKED_TO
	        Linked to: %s
# These strings MUST NOT be empty
NICK_INFO_OPT_KILL
	Kill protection
NICK_INFO_OPT_SECURE
	Security
NICK_INFO_OPT_PRIVATE
	Private
NICK_INFO_OPT_NONE
	None
NICK_INFO_NO_EXPIRE
	This nickname will not expire.
NICK_INFO_SUSPEND_DETAILS
	Suspended by %s on %s (%s).
NICK_INFO_SUSPEND_REASON
	Reason: %s
NICK_INFO_SHOW_ALL
	For more information, type: /msg %s INFO %s ALL

# LISTCHANS responses
NICK_LISTCHANS_SYNTAX
	LISTCHANS
NICK_LISTCHANS_SERVADMIN_SYNTAX
	LISTCHANS [nickname]
NICK_LISTCHANS_NONE
	%s has not registered any channels.
NICK_LISTCHANS_HEADER
	Channels registered by %s:
NICK_LISTCHANS_ENTRY
	    %s
NICK_LISTCHANS_END
	End of list (%d channels registered).

# LIST responses
NICK_LIST_SYNTAX
	LIST pattern
NICK_LIST_SERVADMIN_SYNTAX
	LIST pattern [FORBIDDEN] [NOEXPIRE] [SUSPENDED]
NICK_LIST_HEADER
	List of entries matching %s:
NICK_LIST_RESULTS
	End of list - %d/%d matches shown.

# RECOVER responses
NICK_RECOVER_SYNTAX
	RECOVER nickname [password]
NICK_NO_RECOVER_SELF
	You can't recover yourself!
NICK_RECOVERED
	User claiming your nick has been killed.
	/msg %s RELEASE %s to get it back before the one-minute timeout.

# RELEASE responses
NICK_RELEASE_SYNTAX
	RELEASE nickname [password]
NICK_RELEASE_NOT_HELD
	Nick %s isn't being held.
NICK_RELEASED
	K9 Services' hold on your nick has been released.

# GHOST responses
NICK_GHOST_SYNTAX
	GHOST nickname [password]
NICK_NO_GHOST_SELF
	You can't ghost yourself!
NICK_GHOST_KILLED
	Ghost with your nick has been killed.

# GETPASS responses
NICK_GETPASS_SYNTAX
	GETPASS nickname
NICK_GETPASS_UNAVAILABLE
	GETPASS command unavailable because encryption is in use.
NICK_GETPASS_PASSWORD_IS
	Password for %s is %s.

# FORBID responses
NICK_FORBID_SYNTAX
	FORBID nickname
NICK_FORBID_SUCCEEDED
	Nick %s is now forbidden.
NICK_FORBID_FAILED
	Couldn't forbid nick %s!

# SUSPEND responses
NICK_SUSPEND_SYNTAX
	SUSPEND [+expiry] nickname reason
NICK_SUSPEND_SUCCEEDED
	Nick %s, and all nicks with the same root nick, have been suspended.
NICK_SUSPEND_ALREADY_SUSPENDED
	Nick %s is already suspended.

# UNSUSPEND responses
NICK_UNSUSPEND_SYNTAX
	UNSUSPEND nickname
NICK_UNSUSPEND_SUCCEEDED
	Nick %s has been unsuspended.
NICK_SUSPEND_NOT_SUSPENDED
	Nick %s is not suspended.

###########################################################################
#
# ChanServ messages
#
###########################################################################

# Access level descriptions
CHAN_LEVEL_AUTOOP
	Automatic channel operator status
CHAN_LEVEL_AUTOVOICE
	Automatic mode +v
CHAN_LEVEL_AUTODEOP
	Channel operator status disallowed
CHAN_LEVEL_AUTODEOP_HALFOP
	Channel operator/halfop status disallowed
CHAN_LEVEL_NOJOIN
	Not allowed to join channel if RESTRICTED
CHAN_LEVEL_INVITE
	Allowed to use INVITE command
CHAN_LEVEL_AKICK
	Allowed to use AKICK command
CHAN_LEVEL_SET
	Allowed to use SET command (not FOUNDER/PASSWORD)
CHAN_LEVEL_CLEAR
	Allowed to use CLEAR command
CHAN_LEVEL_UNBAN
	Allowed to use UNBAN command
CHAN_LEVEL_OPDEOP
	Allowed to use OP/DEOP commands
CHAN_LEVEL_ACCESS_LIST
	Allowed to view the access list
CHAN_LEVEL_ACCESS_CHANGE
	Allowed to modify the access list
CHAN_LEVEL_MEMO
	Allowed to list/read channel memos
CHAN_LEVEL_VOICE
	Allowed to use VOICE/DEVOICE commands
CHAN_LEVEL_AUTOHALFOP
	Automatic halfop (+h) status
CHAN_LEVEL_HALFOP
	Allowed to use HALFOP/DEHALFOP commands
CHAN_LEVEL_AUTOPROTECT
	Automatic channel protect (+a) status
CHAN_LEVEL_PROTECT
	Allowed to use PROTECT/DEPROTECT commands

# Automatic responses
CHAN_IS_REGISTERED
	This channel has been registered with %s.
CHAN_NOT_ALLOWED_OP
	You are not allowed chanop status on channel %s.
CHAN_MAY_NOT_BE_USED
	This channel may not be used.
CHAN_NOT_ALLOWED_TO_JOIN
	You are not permitted to be on this channel.

# Multi-purpose responses
CHAN_BOUNCY_MODES
	Sorry, the %s command is temporarily unavailable.

# REGISTER responses
CHAN_REGISTER_SYNTAX
	REGISTER channel password description
CHAN_REGISTER_DISABLED
	Sorry, channel registration is temporarily disabled.
CHAN_REGISTER_NOT_LOCAL
	Local channels cannot be registered.
CHAN_MUST_REGISTER_NICK
	You must register your nickname first.  Type /msg %s HELP for information on registering nicknames.
CHAN_MUST_IDENTIFY_NICK
	Please identify with %s first, using the command:
	/msg %s IDENTIFY password
CHAN_MAY_NOT_BE_REGISTERED
	Channel %s may not be registered.
CHAN_ALREADY_REGISTERED
	Channel %s is already registered!
CHAN_MUST_BE_CHANOP
	You must be a channel operator to register the channel.
CHAN_REACHED_CHANNEL_LIMIT
	Sorry, you have already reached your limit of %d channels.
CHAN_EXCEEDED_CHANNEL_LIMIT
	Sorry, you have already exceeded your limit of %d channels.
CHAN_REGISTRATION_FAILED
	Sorry, registration failed.
CHAN_REGISTERED
	Channel %s registered under your nickname: %s
CHAN_PASSWORD_IS
	Your channel password is %s - remember it for later use.
	
# IDENTIFY responses
CHAN_AUTH_SYNTAX
	AUTH channel password
CHAN_SETPASS_SYNTAX
	SETPASS <channel> <new password>
CHAN_IDENTIFY_FAILED
	Sorry, identification failed.
CHAN_IDENTIFY_SUCCEEDED
	Password accepted - you now have founder-level access to %s.

# DROP responses
CHAN_DROP_SYNTAX
	REMCHAN channel
CHAN_DROP_DISABLED
	Sorry, channel de-registration is temporarily disabled.
CHAN_DROPPED
	Channel %s has been removed.

# SET responses
CHAN_SET_SYNTAX
	SET channel option parameters
CHAN_SET_DISABLED
	Sorry, channel option setting is temporarily disabled.
CHAN_SET_UNKNOWN_OPTION
	Unknown SET option %s.

# SET FOUNDER responses
CHAN_FOUNDER_SYNTAX
	FOUNDER <new founder>
CHAN_SET_FOUNDER_TOO_MANY_CHANS
	%s has too many channels registered.
CHAN_FOUNDER_CHANGED
	Founder of %s changed to %s.

# SET SUCCESSOR responses
CHAN_SUCCESSOR_CHANGED
	Successor for %s changed to %s.
CHAN_SUCCESSOR_IS_FOUNDER
	You can't make the founder of a channel the successor too.

# SET PASSWORD responses
CHAN_SET_PASSWORD_FAILED
	Sorry, couldn't set password.
CHAN_PASSWORD_CHANGED
	%s password changed.
CHAN_PASSWORD_CHANGED_TO
	%s password changed to %s.

# SET DESC responses
CHAN_DESC_CHANGED
	Description of %s changed to %s.

# SET URL responses
CHAN_URL_CHANGED
	URL for %s changed to %s.

# SET EMAIL responses
CHAN_EMAIL_CHANGED
	E-mail address for %s changed to %s.

# SET ENTRYMSG responses
CHAN_ENTRY_MSG_CHANGED
	Entry message for %s changed.

# SET TOPIC responses
CHAN_SET_TOPIC_FAILED
	Sorry, can't set topic.

# SET MLOCK responses
CHAN_SET_MLOCK_KEY_REQUIRED
	Parameter required for MLOCK +k.
CHAN_SET_MLOCK_LIMIT_REQUIRED
	Parameter required for MLOCK +l.
CHAN_SET_MLOCK_LIMIT_POSITIVE
	Parameter for MLOCK +l must be a positive number.
CHAN_SET_MLOCK_MODE_REG_BAD
	Mode +%c is always set on registered channels, and cannot be used with MLOCK.
CHAN_SET_MLOCK_MODE_F_BAD
	Mode +f cannot be locked.
CHAN_SET_MLOCK_UNKNOWN_CHAR
	Unknown mode character %c ignored.
CHAN_MLOCK_CHANGED
	Mode lock on channel %s changed to %s.
CHAN_MLOCK_REMOVED
	Mode lock on channel %s removed.

CHAN_ONJOIN_SYNTAX
	ONJOIN { ADD | CLEAR } { text to add }
CHAN_ONJOIN_FULL
	Your onjoin has reached the maximum size permitted (%d lines).

# SET KEEPTOPIC responses
CHAN_SET_KEEPTOPIC_SYNTAX
	SET channel KEEPTOPIC {ON | OFF}
CHAN_SET_KEEPTOPIC_ON
	Topic retention option is now ON.
CHAN_SET_KEEPTOPIC_OFF
	Topic retention option is now OFF.

# SET TOPICLOCK responses
CHAN_SET_TOPICLOCK_SYNTAX
	SET channel TOPICLOCK {ON | OFF}
CHAN_SET_TOPICLOCK_ON
	Topic lock option is now ON.
CHAN_SET_TOPICLOCK_OFF
	Topic lock option is now OFF.

# SET PRIVATE responses
CHAN_SET_PRIVATE_SYNTAX
	SET channel PRIVATE {ON | OFF}
CHAN_SET_PRIVATE_ON
	Private option is now ON.
CHAN_SET_PRIVATE_OFF
	Private option is now OFF.

# SET SECUREOPS responses
CHAN_SET_SECUREOPS_SYNTAX
	SET channel SECUREOPS {ON | OFF}
CHAN_SET_SECUREOPS_ON
	Secure ops option is now ON.
CHAN_SET_SECUREOPS_OFF
	Secure ops option is now OFF.

# SET LEAVEOPS responses
CHAN_SET_LEAVEOPS_SYNTAX
	SET channel LEAVEOPS {ON | OFF}
CHAN_SET_LEAVEOPS_ON
	Leave ops option is now ON.
CHAN_SET_LEAVEOPS_OFF
	Leave ops option is now OFF.

# SET RESTRICTED responses
CHAN_SET_RESTRICTED_SYNTAX
	SET channel RESTRICTED {ON | OFF}
CHAN_SET_RESTRICTED_ON
	Restricted access option is now ON.
CHAN_SET_RESTRICTED_OFF
	Restricted access option is now OFF.

# SET SECURE responses
CHAN_SET_SECURE_SYNTAX
	SET channel SECURE {ON | OFF}
CHAN_SET_SECURE_ON
	Secure option is now ON.
CHAN_SET_SECURE_OFF
	Secure option is now OFF.

# SET OPNOTICE responses
CHAN_SET_OPNOTICE_SYNTAX
	SET channel OPNOTICE {ON | OFF}
CHAN_SET_OPNOTICE_ON
	Op-notice option is now ON.
CHAN_SET_OPNOTICE_OFF
	Op-notice option is now OFF.

# SET ENFORCE responses
CHAN_SET_ENFORCE_SYNTAX
	SET channel ENFORCE {ON | OFF}
CHAN_SET_ENFORCE_ON
	Enforce option is now ON.
CHAN_SET_ENFORCE_OFF
	Enforce option is now OFF.

# SET NOEXPIRE responses
CHAN_SET_NOEXPIRE_SYNTAX
	SET channel NOEXPIRE {ON | OFF}
CHAN_SET_NOEXPIRE_ON
	Channel %s will not expire.
CHAN_SET_NOEXPIRE_OFF
	Channel %s will expire.

# UNSET responses
CHAN_UNSET_SYNTAX
	UNSET channel {SUCCESSOR | URL | EMAIL | ENTRYMSG}
CHAN_SUCCESSOR_UNSET
	Successor for %s unset.
CHAN_URL_UNSET
	URL for %s unset.
CHAN_EMAIL_UNSET
	E-mail address for %s unset.
CHAN_ENTRY_MSG_UNSET
	Entry message for %s unset.

# ACCESS messages
CHAN_ACCESS_SYNTAX
	ACCESS channel {ADD | DEL | LIST | COUNT} [nick [level] | entry-list]
CHAN_ACCESS_DISABLED
	Sorry, channel access list modification is temporarily disabled.
CHAN_ACCESS_LEVEL_NONZERO
	Access level must be non-zero.
CHAN_ACCESS_LEVEL_RANGE
	Access level must be between %d and %d inclusive.
CHAN_ACCESS_NICKS_ONLY
	Channel access lists may only contain registered nicknames.
CHAN_ACCESS_REACHED_LIMIT
	Sorry, you can only have %d access entries on a channel.
CHAN_ACCESS_LEVEL_UNCHANGED
	Access level for %s on %s unchanged from %d.
CHAN_ACCESS_LEVEL_CHANGED
	Access level for %s on %s changed to %d.
CHAN_ACCESS_ADDED
	%s added to access list at level %d.
CHAN_ACCESS_NO_SUCH_ENTRY
	No such entry (#%d) on %s access list.
CHAN_ACCESS_NOT_FOUND
	%s not found on %s access list.
CHAN_ACCESS_NO_MATCH
	No matching entries on %s access list.
CHAN_ACCESS_DELETED
	%s deleted from %s access list.
CHAN_ACCESS_DELETED_ONE
	Deleted 1 entry from %s access list.
CHAN_ACCESS_DELETED_SEVERAL
	Deleted %d entries from %s access list.
CHAN_ACCESS_LIST_EMPTY
	%s access list is empty.
CHAN_ACCESS_LIST_HEADER
	Access list for %s:
CHAN_ACCESS_LIST_FORMAT
	USERID:     %3d  NICK:%s
	ULEVEL:%d PLEVEL:  0 SLEVEL:  0 AUTOOP:%s
	COMMENT:%s
CHAN_ACCESS_LIST2_FORMAT
	USERID:     %3d  NICK:%s
	ULEVEL:%s PLEVEL:  0 SLEVEL:  0 AUTOOP:%s
	COMMENT:%s
CHAN_ACCESS_LIST_UNFINISHED
	For next set of entries enter: k9 access -%d 
CHAN_ACCESS_COUNT
	The %s access list has %d entries.

# XOP (AOP/SOP/VOP) responses
CHAN_SOP_SYNTAX
	SOP channel {ADD | DEL | LIST | COUNT} [nick | entry-list]
CHAN_AOP_SYNTAX
	AOP channel {ADD | DEL | LIST | COUNT} [nick | entry-list]
CHAN_HOP_SYNTAX
	HOP channel {ADD | DEL | LIST | COUNT} [nick | entry-list]
CHAN_VOP_SYNTAX
	VOP channel {ADD | DEL | LIST | COUNT} [nick | entry-list]
CHAN_XOP_ADDED
	%s added to %s %s list.
CHAN_XOP_LEVEL_CHANGED
	%s moved to %s %s list.
CHAN_XOP_LEVEL_UNCHANGED
	%s is already on the %s %s list.
CHAN_XOP_NICKS_ONLY
	SOP, AOP, and VOP lists may only contain registered nicknames.
CHAN_XOP_NICKS_ONLY_HOP
	SOP, AOP, HOP, and VOP lists may only contain registered nicknames.
CHAN_XOP_REACHED_LIMIT
	Sorry, the number of entries on your SOP, AOP and VOP lists
	may not total more than %d entries.  Limit exceeded.
CHAN_XOP_REACHED_LIMIT_HOP
	Sorry, the number of entries on your SOP, AOP, HOP and VOP
	lists may not total more than %d entries.  Limit exceeded.
CHAN_XOP_NOT_FOUND
	%s not found on %s %s list.
CHAN_XOP_NO_SUCH_ENTRY
	No such entry (#%d) on %s %s list.
CHAN_XOP_NO_MATCH
	No matching entries on %s %s list.
CHAN_XOP_DELETED
	%s deleted from %s %s list.
CHAN_XOP_DELETED_ONE
	Deleted 1 entry from %s %s list.
CHAN_XOP_DELETED_SEVERAL
	Deleted %d entries from %s %s list.
CHAN_XOP_LIST_EMPTY
	%s %s list is empty.
CHAN_XOP_LIST_HEADER
	%s list for %s:
	  Num   Nick
CHAN_XOP_LIST_FORMAT
	  %3d   %s%s%s%s
CHAN_XOP_COUNT
	The %s %s list has %d entries.

# AKICK responses
CHAN_AKICK_SYNTAX
	AKICK channel {ADD | DEL | LIST | VIEW | ENFORCE | COUNT} [mask | list]
CHAN_AKICK_DISABLED
	Sorry, channel autokick list modification is temporarily disabled.
CHAN_AKICK_ALREADY_EXISTS
	%s already exists on %s autokick list.
CHAN_AKICK_REACHED_LIMIT
	Sorry, you can only have %d autokick masks on a channel.
CHAN_AKICK_ADDED
	%s added to %s autokick list.
CHAN_AKICK_NO_SUCH_ENTRY
	No such entry (#%d) on %s autokick list.
CHAN_AKICK_NOT_FOUND
	%s not found on %s autokick list.
CHAN_AKICK_NO_MATCH
	No matching entries on %s autokick list.
CHAN_AKICK_DELETED
	%s deleted from %s autokick list.
CHAN_AKICK_DELETED_ONE
	Deleted 1 entry from %s autokick list.
CHAN_AKICK_DELETED_SEVERAL
	Deleted %d entries from %s autokick list.
CHAN_AKICK_LIST_EMPTY
	%s autokick list is empty.
CHAN_AKICK_LIST_HEADER
	Autokick list for %s:
CHAN_AKICK_LIST_FORMAT
	  %3d %s%s
CHAN_AKICK_VIEW_FORMAT
	  %3d %s (by %s)
	    %s
CHAN_AKICK_ENFORCE_DONE
	AKICK ENFORCE for %s complete; %d users were affected.
CHAN_AKICK_COUNT
	%s has %d entries on its AKICK list.

# LEVELS responses
CHAN_LEVELS_SYNTAX
	LEVELS channel {SET | DIS[ABLE] | LIST | RESET} [item [level]]
CHAN_LEVELS_RANGE
	Level must be between %d and %d inclusive.
CHAN_LEVELS_CHANGED
	Level for %s on channel %s changed to %d.
CHAN_LEVELS_UNKNOWN
	Setting %s not known.  Type /msg %s HELP LEVELS DESC for a list of valid settings.
CHAN_LEVELS_DISABLED
	%s disabled on channel %s.
CHAN_LEVELS_LIST_HEADER
	Access level settings for channel %s:
CHAN_LEVELS_LIST_DISABLED
	    %-*s  (disabled)
CHAN_LEVELS_LIST_FOUNDER
	    %-*s  (founder only)
CHAN_LEVELS_LIST_NORMAL
	    %-*s  %d
CHAN_LEVELS_RESET
	Access levels for %s reset to defaults.

# INFO responses
CHAN_INFO_SYNTAX
	INFO channel 
CHAN_INFO_HEADER
	Information for channel %s:
CHAN_INFO_FOUNDER
	        Founder: %s (%s)
CHAN_INFO_NO_FOUNDER
	        Founder: %s
CHAN_INFO_SUCCESSOR
	      Successor: %s (%s)
CHAN_INFO_NO_SUCCESSOR
	      Successor: %s
CHAN_INFO_DESCRIPTION
	    Description: %s
CHAN_INFO_ENTRYMSG
	  Entry message: %s
CHAN_INFO_TIME_REGGED
	     Registered: %s
CHAN_INFO_LAST_USED
	      Last used: %s
CHAN_INFO_LAST_TOPIC
	     Last topic: %s
CHAN_INFO_TOPIC_SET_BY
	   Topic set by: %s
CHAN_INFO_URL
	            URL: %s
CHAN_INFO_EMAIL
	 E-mail address: %s
CHAN_INFO_OPTIONS
	        Options: %s
CHAN_INFO_OPT_PRIVATE
	Private
CHAN_INFO_OPT_KEEPTOPIC
	Topic Retention
CHAN_INFO_OPT_TOPICLOCK
	Topic Lock
CHAN_INFO_OPT_SECUREOPS
	Secure Ops
CHAN_INFO_OPT_LEAVEOPS
	Leave Ops
CHAN_INFO_OPT_RESTRICTED
	Restricted Access
CHAN_INFO_OPT_SECURE
	Secure
CHAN_INFO_OPT_OPNOTICE
	Op-Notice
CHAN_INFO_OPT_ENFORCE
	Enforce
CHAN_INFO_OPT_NONE
	None
CHAN_INFO_MODE_LOCK
	The current mode guards are [%s]
CHAN_INFO_NO_EXPIRE
	This channel will not expire.
CHAN_INFO_SUSPEND_DETAILS
	Suspended by %s on %s (%s).
CHAN_INFO_SUSPEND_REASON
	Reason: %s
CHAN_INFO_SHOW_ALL
	For more information, type: /msg %s INFO %s ALL

# LIST responses
CHAN_LIST_SYNTAX
	LIST pattern
CHAN_LIST_SERVADMIN_SYNTAX
	LIST pattern [FORBIDDEN] [NOEXPIRE]
CHAN_LIST_HEADER
	List of entries matching %s:
CHAN_LIST_FORMAT
	    %-20s  %s
CHAN_LIST_END
	End of list - %d/%d matches shown.

# INVITE responses
CHAN_INVITE_SYNTAX
	INVITE channel <nick>
CHAN_INVITE_OK
	Inviting %s to channel %s.

# OP/DEOP/VOICE/DEVOICE responses
CHAN_OPVOICE_SYNTAX
	%s channel nick
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
	Protected %s on channel %s.
CHAN_PROTECT_FAILED
	Unable to protect %s on channel %s.
CHAN_DEPROTECT_SUCCEEDED
	Deprotected %s on channel %s.
CHAN_DEPROTECT_FAILED
	Unable to deprotect %s on channel %s.

CHAN_BANLIST
	Banlist for %s:
CHAN_BAN_LIST_UNFINISHED
	There are %d bans remaining for %s. For next set enter: k9 banlist %s -%d
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
	Nick %s is currently on channel %s
CHAN_STATUS_SYNTAX
	STATUS <channel> <nick> 
CHAN_DIEDIE_SYNTAX
	DIEDIE <reason>
CHAN_RESTART_SYNTAX
	RESTART <reason>
CHAN_UPDATE_SYNTAX
	UPDATE 
CHAN_LASTCMDS_SYNTAX
	LASTCMDS <nick>
CHAN_MODE_SYNTAX
	MODE <channel> <+/-imnpstklRrcOM>
CHAN_BROADCAST_SYNTAX
	BROADCAST <message>
CHAN_ADDUSER_SYNTAX
	ADDUSER <channel> <nick> <level>
CHAN_REMUSER_SYNTAX
	REMUSER <channel> <nick>
CHAN_MODUSER_SYNTAX
	MODUSER <channel> <nick> <new level>
CHAN_GUARDM_SYNTAX
	GUARDM <channel> <+/-MODES>
CHAN_GUARDT_SYNTAX
	GUARDT <channel> <T/F>
CHAN_AUTOOP_SYNTAX
	AUTOOP <channel> <T/F>
CHAN_ADDCHAN_SYNTAX
	ADDCHAN <channel> <nick> <password> <description>
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
CHAN_COMMANDS_HDR
	LEVEL: %d
CHAN_COMMANDS_LST
	%10.10s %10.10s %10.10s

# UNBAN responses
CHAN_UNBAN_SYNTAX
	UNBAN channel
CHAN_UNBANNED
	You have been unbanned from %s.

# CLEAR responses
CHAN_CLEAR_SYNTAX
	CLEAR channel what
CHAN_CLEARED_BANS
	All bans on channel %s have been removed.
CHAN_CLEARED_EXCEPTIONS
	All exceptions on channel %s have been removed.
CHAN_CLEARED_MODES
	All modes on channel %s have been reset.
CHAN_CLEARED_OPS
	Mode +o has been cleared from channel %s.
CHAN_CLEARED_HALFOPS
	Mode +h has been cleared from channel %s.
CHAN_CLEARED_VOICES
	Mode +v has been cleared from channel %s.
CHAN_CLEARED_USERS
	All users have been kicked from channel %s.

# GETPASS responses
CHAN_GETPASS_SYNTAX
	GETPASS channel
CHAN_GETPASS_UNAVAILABLE
	GETPASS command unavailable because encryption is in use.
CHAN_GETPASS_PASSWORD_IS
	Password for channel %s is %s.

# FORBID responses
CHAN_FORBID_SYNTAX
	FORBID channel
CHAN_FORBID_SUCCEEDED
	Channel %s is now forbidden.
CHAN_FORBID_FAILED
	Couldn't forbid channel %s!

# SUSPEND responses
CHAN_SUSPEND_SYNTAX
	SUSPEND [+expiry] channel reason
CHAN_SUSPEND_SUCCEEDED
	Channel %s has been suspended.
CHAN_SUSPEND_ALREADY_SUSPENDED
	Channel %s is already suspended.

# UNSUSPEND responses
CHAN_UNSUSPEND_SYNTAX
	UNSUSPEND channel
CHAN_UNSUSPEND_SUCCEEDED
	Channel %s has been unsuspended.
CHAN_SUSPEND_NOT_SUSPENDED
	Channel %s is not suspended.

# MODE responses
OPER_MODE_SYNTAX
	MODE channel modes

###########################################################################
#
# DogTag help messages
#
###########################################################################

NICK_HELP
	%S allows you to "register" a nickname and
	prevent others from using it.  If the nick is not used for
	%d days, the registration will expire.  The following
	commands allow for registration and maintenance of
	nicknames; to use them, type /msg %S command.
	For more information on a specific command, type
	/msg %S HELP command.
	
	    REGISTER   Register a nickname
	    IDENTIFY   Identify yourself with your password
	    ACCESS     Modify the list of authorized addresses
	    LINK       Make your nick an alias for another
	    SET        Set options, including kill protection
	    DROP       Cancel the registration of a nickname
	    RECOVER    Kill another user who has taken your nick
	    RELEASE    Regain custody of your nick after RECOVER
	
	Other commands: UNLINK, UNSET, GHOST, INFO, LIST, LISTCHANS,
	                STATUS
	
	NOTICE: This service is intended to provide a way for
	IRC users to ensure their identity is not compromised.
	It is NOT intended to facilitate "stealing" of
	nicknames or other malicious actions.  Abuse of %S
	will result in, at minimum, loss of the abused
	nickname(s).

NICK_HELP_EXPIRE_ZERO
	%S allows you to "register" a nickname and
	prevent others from using it.  The following commands allow
	for registration and maintenance of nicknames; to use them,
	type /msg %S command. For more information on a
	specific command, type /msg %S HELP command.
	
	    REGISTER   Register a nickname
	    IDENTIFY   Identify yourself with your password
	    ACCESS     Modify the list of authorized addresses
	    LINK       Make your nick an alias for another
	    SET        Set options, including kill protection
	    DROP       Cancel the registration of a nickname
	    RECOVER    Kill another user who has taken your nick
	    RELEASE    Regain custody of your nick after RECOVER
	
	Other commands: UNLINK, UNSET, GHOST, INFO, LIST, LISTCHANS,
	                STATUS
	
	NOTICE: This service is intended to provide a way for
	IRC users to ensure their identity is not compromised.
	It is NOT intended to facilitate "stealing" of
	nicknames or other malicious actions.  Abuse of %S
	will result in, at minimum, loss of the abused
	nickname(s).

NICK_HELP_REGISTER
	Syntax: REGISTER password [email]
	
	Registers your nickname in the %S database.  Once
	your nick is registered, you can use the SET and ACCESS
	commands to configure your nick's settings as you like
	them.  Make sure you remember the password you use when
	registering - you'll need it to make changes to your nick
	later.  (Note that case matters!  FIDO, Fido, and fido
	are all different passwords!)
	
	You may include an E-mail address when registering your
	nickname; you may also set one later using the SET EMAIL
	command.
	
	Guidelines on choosing passwords:
	
	Passwords should not be easily guessable.  For example,
	using your real name as a password is a bad idea.  Using
	your nickname as a password is a much worse idea ;) and,
	in fact, %S will not allow it.  Also, short
	passwords are vulnerable to trial-and-error searches, so
	you should choose a password at least 5 characters long.
	Finally, the space character cannot be used in passwords.

NICK_HELP_REGISTER_REQ_EMAIL
	Syntax: REGISTER password email
	
	Registers your nickname in the %S database.  Once
	your nick is registered, you can use the SET and ACCESS
	commands to configure your nick's settings as you like
	them.  Make sure you remember the password you use when
	registering - you'll need it to make changes to your nick
	later.  (Note that case matters!  FIDO, Fido, and fido
	are all different passwords!)
	
	You must include an E-mail address when registering your
	nickname.  You can prevent your E-mail address from being
	shown to other users with the SET HIDE command (type
	/msg %S HELP SET HIDE for more information).
	
	Guidelines on choosing passwords:
	
	Passwords should not be easily guessable.  For example,
	using your real name as a password is a bad idea.  Using
	your nickname as a password is a much worse idea ;) and,
	in fact, %S will not allow it.  Also, short
	passwords are vulnerable to trial-and-error searches, so
	you should choose a password at least 5 characters long.
	Finally, the space character cannot be used in passwords.

NICK_HELP_IDENTIFY
	Syntax: IDENTIFY password
	
	Tells %S that you are really the owner of this
	nick.  Many commands require you to authenticate yourself
	with this command before you use them.  The password
	should be the same one you sent with the REGISTER
	command.

NICK_HELP_DROP
	Syntax: DROP
	
	Drops your nickname from the %S database.  A nick
	that has been dropped is free for anyone to re-register.
	
	In order to use this command, you must first identify
	with your password (/msg %S HELP IDENTIFY for more
	information).

NICK_HELP_ACCESS
	Syntax: ACCESS ADD mask
	        ACCESS DEL mask
	        ACCESS LIST
	
	Modifies or displays the access list for your nick.  This
	is the list of addresses which will be automatically
	recognized by %S as allowed to use the nick.  If
	you want to use the nick from a different address, you
	need to send an IDENTIFY command to make %S
	recognize you.
	
	Examples:
	
	    ACCESS ADD achurch@*.dragonfire.net
	        Allows access to user achurch from any machine in
	        the dragonfire.net domain.
	
	    ACCESS DEL achurch@*.dragonfire.net
	        Reverses the previous command.
	
	    ACCESS LIST
	        Displays the current access list.

NICK_HELP_LINK
	Syntax: LINK nick password
	
	Links your nickname to another, effectively making the nick
	you are currently using an alias for the given nick.  When
	you give this command, the access list for the nick you are
	using is deleted and replaced by that of the nick you are
	linking to; all memos for your current nick are added to
	the list of memos for the target nick (this may cause the
	nick to exceed its limit of memos, in which case you will
	need to delete some before you can receive more for either
	nick).
	
	Once the link has been established, your nick will be
	transparently converted into the target nick everywhere in
	Services, except for the %S UNLINK and DROP commands.  For
	example, you can use either nick to read the same set of
	memos (and memos sent to either nick will go into the same
	list).  If either nick is on a channel's access list, then
	both nicks will get the same access privileges.  However,
	the nicks will expire independently; if you only use one of
	a set of linked nicks, all the rest will expire.
	
	In order to use this command, you must identify for your
	current nick (using the IDENTIFY command), and you must
	supply the password for the nick you wish to link to.

NICK_HELP_UNLINK
	Syntax: UNLINK [nick pass]
	
	Removes a link from your nick to another.  When the link is
	removed, the nickname flags and access list of the
	previously linked nick are copied to your current nick and
	can then be independently changed.  Memos are not copied;
	all memos will remain stored with the previously linked
	nick.
	
	By giving a nickname and password as parameters, you can
	unlink a nick besides the one you are currently using.

NICK_HELP_SET
	Syntax: SET option parameters
	
	Sets various nickname options.  option can be one of:
	
	    PASSWORD   Set your nickname password
	    LANGUAGE   Set the language Services will use when
	                   sending messages to you
	    URL        Associate a URL with your nickname
	    EMAIL      Associate an E-mail address with your nickname
	    KILL       Turn kill protection on or off
	    SECURE     Turn nickname security on or off
	    PRIVATE    Prevent your nickname from appearing in a
	                   /msg %S LIST
	    HIDE       Hide certain pieces of nickname information
	
	In order to use this command, you must first identify
	with your password (/msg %S HELP IDENTIFY for more
	information).
	
	Type /msg %S HELP SET option for more information
	on a specific option.

NICK_HELP_SET_PASSWORD
	Syntax: SET PASSWORD new-password
	
	Changes the password used to identify you as the nick's
	owner.

NICK_HELP_SET_LANGUAGE
	Syntax: SET LANGUAGE number
	
	Changes the language Services uses when sending messages to
	you (for example, when responding to a command you send).
	number should be chosen from the following list of
	supported languages:
	

NICK_HELP_SET_URL
	Syntax: SET URL url
	
	Associates the given URL with your nickname.  This URL
	will be displayed whenever someone requests information
	on your nick with the INFO command.

NICK_HELP_SET_EMAIL
	Syntax: SET EMAIL address
	
	Associates the given E-mail address with your nickname.
	This address will be displayed whenever someone requests
	information on the channel with the INFO command.

NICK_HELP_SET_KILL
	Syntax: SET KILL {ON | QUICK | IMMED | OFF}
	
	Turns the automatic kill protection option for your nick
	on or off.  With kill protection on, if another user
	tries to take your nick, they will be given one minute to
	change to another nick, after which they will be forcibly
	removed from IRC by %S.
	
	If you select QUICK, the user will be given only 20 seconds
	to change nicks instead of the usual 60.  If you select
	IMMED, the user will be killed immediately without being
	warned first or given a chance to change their nick; please
	do not use this option unless necessary.  Also, your
	network's administrators may have disabled this option.

NICK_HELP_SET_SECURE
	Syntax: SET SECURE {ON | OFF}
	
	Turns %S's security features on or off for your
	nick.  With SECURE set, you must enter your password
	before you will be recognized as the owner of the nick,
	regardless of whether your address is on the access
	list.  However, if you are on the access list, %S
	will not auto-kill you regardless of the setting of the
	KILL option.

NICK_HELP_SET_PRIVATE
	Syntax: SET PRIVATE {ON | OFF}
	
	Turns %S's privacy option on or off for your nick.
	With PRIVATE set, your nickname will not appear in
	nickname lists generated with %S's LIST command.
	(However, anyone who knows your nickname can still get
	information on it using the INFO command.)

NICK_HELP_SET_HIDE
	Syntax: SET HIDE {EMAIL | USERMASK | QUIT} {ON | OFF}
	
	Allows you to prevent certain pieces of information from
	being displayed when someone does a %S INFO on your
	nick.  You can hide your E-mail address (EMAIL), last seen
	user@host mask (USERMASK), and last quit message (QUIT).
	The second parameter specifies whether the information should
	be displayed (OFF) or hidden (ON).

NICK_HELP_UNSET
	Syntax: UNSET {URL | EMAIL}
	
	Allows you to clear the URL or E-mail address associated
	with your nickname.  Use the URL parameter to clear the
	URL, or the EMAIL parameter to clear the E-mail address.
	You cannot clear both at the same time.

NICK_HELP_UNSET_REQ_EMAIL
	Syntax: UNSET URL
	
	Allows you to clear the URL associated with your
	nickname.  The URL parameter must be given.

NICK_HELP_RECOVER
	Syntax: RECOVER nickname [password]
	
	Allows you to recover your nickname if someone else has
	taken it; this does the same thing that %S does
	automatically if someone tries to use a kill-protected
	nick.
	
	When you give this command, %S will bring a fake
	user online with the same nickname as the user you're
	trying to recover your nick from.  This causes the IRC
	servers to disconnect the other user.  This fake user will
	will remain online for one minute to ensure that the other
	user does not immediately reconnect; after that minute, you
	can reclaim your nick.  Alternatively, use the RELEASE
	command (/msg %S HELP RELEASE) to get the nick
	back sooner.
	
	In order to use the RECOVER command for a nick, your
	current address as shown in /WHOIS must be on that nick's
	access list, or you must supply the correct password for
	the nickname.

NICK_HELP_RELEASE
	Syntax: RELEASE nickname [password]
	
	Instructs %S to remove any hold on your nickname
	caused by automatic kill protection or use of the RECOVER
	command.  By default, such holds last for one minute;
	this command gets rid of them sooner.
	
	In order to use the RELEASE command for a nick, your
	current address as shown in /WHOIS must be on that nick's
	access list, or you must supply the correct password for
	the nickname.

NICK_HELP_GHOST
	Syntax: GHOST nickname [password]
	
	Terminates a "ghost" IRC session using your nick.  A
	"ghost" session is one which is not actually connected,
	but which the IRC server believes is still online for one
	reason or another.  Typically, this happens if your
	computer crashes or your Internet or modem connection
	goes down while you're on IRC.
	
	In order to use the GHOST command for a nick, your
	current address as shown in /WHOIS must be on that nick's
	access list, or you must supply the correct password for
	the nickname.

NICK_HELP_INFO
	Syntax: INFO nickname [ALL]
	
	Displays information about the given nickname, such as
	the nick's owner, last seen address and time, and nick
	options. If you are identified for the nick you're
	getting information for and ALL is specified, you will
	be shown all the information; regardless of whether
	it's hidden or not.

NICK_HELP_LISTCHANS
	Syntax: LISTCHANS
	
	Lists the names and the total number of channels you have
	registered under your nickname.

NICK_HELP_LIST
	Syntax: LIST pattern
	
	Lists all registered nicknames which match the given
	pattern, in nick!user@host format.  Nicks with the
	PRIVATE option set will not be displayed.
	
	Examples:
	
	    LIST *!joeuser@foo.com
	        Lists all nicks owned by joeuser@foo.com.
	
	    LIST *Bot*!*@*
	        Lists all registered nicks with Bot in their
	        names (case insensitive).
	
	    LIST *!*@*.bar.org
	        Lists all nicks owned by users in the bar.org
	        domain.

NICK_HELP_STATUS
	Syntax: STATUS nickname...
	
	Returns whether the user using the given nickname is
	recognized as the owner of the nickname.  The response has
	this format:
	
	    nickname status-code
	
	where nickname is the nickname sent with the command, and
	status-code is one of the following:
	
	    0 - no such user online or nickname not registered
	    1 - user not recognized as nickname's owner
	    2 - user recognized as owner via access list only
	    3 - user recognized as owner via password identification
	
	Up to sixteen nicknames may be sent with each command; the
	rest will be ignored.  No error message is generated if no
	nickname is given.

NICK_SERVADMIN_HELP
	
	The following commands are available to Cservice Members:
	
	    GETPASS     Retrieve the password for a nickname
	                    (only if encryption is disabled)
	    SUSPEND     Prevent a nick from being identified for
	    FORBID      Prevent a nick from being used/registered
	    LISTLINKS   Lists nicknames linked to a nickname
	
	Cservice Members can also use the following commands on any
	nickname without needing to identify for it:
	
	    DROP, SET, ACCESS LIST, INFO ALL

	See the help for each command for specific details.

NICK_SERVADMIN_HELP_DROP
	Syntax: DROP [nickname]
	
	Without a parameter, drops your nickname from the
	%S database.
	
	With a parameter, drops the named nick from the database.
	This use limited to CServices Members.

NICK_SERVADMIN_HELP_SET
	Cservice Members can also set the option NOEXPIRE, with
	which nicknames can be prevented from expiring.
	Additionally, Cservice Members can set options for any
	nickname without entering a password, using the format
	SET nickname option parameters.

NICK_SERVADMIN_HELP_SET_NOEXPIRE
	Syntax: SET [nickname] NOEXPIRE {ON | OFF}
	
	Sets whether the given nickname will expire.  Setting this
	to ON prevents the nickname from expiring.  If no
	nickname is given, sets the no-expire flag for your nick.
	
	Limited to Cservice Members.

NICK_SERVADMIN_HELP_UNSET
	
	Cservice Members may use the UNSET command on any nickname by
	including the nickname before the option name, as with the
	SET command.

NICK_SERVADMIN_HELP_UNLINK
	
	Cservice Members may unlink any nick without entering a
	password.

NICK_SERVADMIN_HELP_LISTLINKS
	Syntax: LISTLINKS nick [ALL]
	
	Lists nicks which are linked to the given nick.  If ALL is
	specified, lists all nicks with the same privileges as the
	given nick; otherwise, lists only those nicks which are
	directly linked to the given nick.
	
	Limited to Cservice Members.

NICK_SERVADMIN_HELP_ACCESS
	
	Cservice Members may give a nickname parameter to the LIST
	command to display the access list for any nickname.

NICK_SERVADMIN_HELP_INFO
	
	Cservice Members may use the ALL parameter with any nick.

NICK_SERVADMIN_HELP_LISTCHANS
	
	Cservice Members may list channels for any nickname by
	giving the nickname with the command (for example,
	/msg DogTag LISTCHANS OtherNick).

NICK_SERVADMIN_HELP_LIST
	Syntax: LIST pattern [FORBIDDEN] [NOEXPIRE] [SUSPENDED]
	
	Lists all registered nicknames which match the given
	pattern, in nick!user@host format.  Nicks with the PRIVATE
	option set will only be displayed to Cservice Members. For
	Cservice Members, nicks with the NOEXPIRE option set will
	have a ! prepended to the nickname and those that are
	SUSPENDed will be prepended by a *.
	
	If the FORBIDDEN, SUSPENDED or NOEXPIRE options are given,
	only nicks which, respectively, are FORBIDden, SUSPENDed or
	have the NOEXPIRE flag set will be displayed. The options can
	be used in any order and in any combination. These options
	are limited to Cservice Members.
	
	Examples:
	
	    LIST *!joeuser@foo.com
	        Lists all registered nicks owned by joeuser@foo.com.
	
	    LIST *Bot*!*@*
	        Lists all registered nicks with Bot in their
	        names (case insensitive).
	
	    LIST * NOEXPIRE
	        Lists all registered nicks which have been set to
	        not expire.

NICK_SERVADMIN_HELP_GETPASS
	Syntax: GETPASS nickname
	
	Returns the password for the given nickname.  Note that
	whenever this command is used, a message including the
	person who issued the command and the nickname it was used
	on will be logged and sent out as a WALLOPS/GLOBOPS.
	
	Limited to Cservice Members.
	
	This command is unavailable when encryption is enabled.

NICK_SERVADMIN_HELP_FORBID
	Syntax: FORBID nickname
	
	Disallows a nickname from being registered or used by
	anyone.  May be cancelled by dropping the nick.
	
	Limited to Cservice Members.

NICK_SERVADMIN_HELP_SUSPEND
	Syntax: SUSPEND [+expiry] nickname reason
	
	Prevents a nickname, and all those nicknames with the
	same root nickname, from being used or identified for
	by anyone. A nickname can be unsuspended with the
	UNSUSPEND command.
	
	Unlike a forbidden nickname, a suspended one does not
	lose its information and will expire!
	
	Limited to Cservice Members.

NICK_SERVADMIN_HELP_UNSUSPEND
	Syntax: UNSUSPEND nickname
	
	Allows people to use and identify for a previously
	SUSPENDed nickname.
	
	Limited to Cservice Members.


###########################################################################
#
# ChanServ help messages
#
###########################################################################

CHAN_HELP
	%S allows you to register and control various
	aspects of channels.  %S can often prevent
	malicious users from "taking over" channels by limiting
	who is allowed channel operator privileges.  Available
	commands are listed below; to use them, type
	/msg %S command.  For more information on a
	specific command, type /msg %S HELP command.
	
	    REGISTER   Register a channel
	    IDENTIFY   Identify yourself with your password
	    REMCHAN    Cancel the registration of a channel
	    INFO       Show channel options and information
	    SET        Set channel options and information
	    ACCESS     Maintain the overall channel access list

CHAN_HELP_OTHERS
	
	Other commands: LIST, INVITE, UNBAN, 
	                OP, DEOP, VOICE, DEVOICE

CHAN_HELP_OTHERS_HALFOP_CHANPROT
	
	Other commands: LIST, INVITE, UNBAN, 
	                OP, DEOP, VOICE, DEVOICE,
	                HALFOP, DEHALFOP
	                

CHAN_HELP_EXPIRES
	
	Note that any channel which is not used for %d days
	(i.e. which no user on the channel's access list enters
	for that period of time) will be automatically dropped.

CHAN_HELP_REGISTER
	Syntax: REGISTER channel password description
	
	Registers a channel in the %S database.  In order
	to use this command, you must first be a channel operator
	on the channel you're trying to register.  The password
	is used with the IDENTIFY command to allow you to
	make changes to the channel settings at a later time.
	The last parameter, which must be included, is a
	general description of the channel's purpose.
	
	When you register a channel, you are recorded as the
	"founder" of the channel.  The channel founder is allowed
	to change all of the channel settings for the channel;
	%S will also automatically give the founder
	channel-operator privileges when s/he enters the channel.
	See the ACCESS command (/msg %S HELP ACCESS) for
	information on giving a subset of these privileges to
	other channel users.
	
	NOTICE: In order to register a channel, you must have
	first registered your nickname.  If you haven't,
	/msg %s HELP for information on how to do so.

CHAN_HELP_IDENTIFY
	Syntax: IDENTIFY channel password
	
	Authenticates you to %S as the founder of the given
	channel.  Many commands require you to use this command
	before using them.  The password should be the same one
	you sent with the REGISTER command.

CHAN_HELP_DROP
	Syntax: REMCHAN channel
	
	Unregisters the named channel.  Can only be used by
	channel founder, who must use the IDENTIFY command first.

CHAN_HELP_SET
	Syntax: SET channel option parameters
	
	Allows the channel founder to set various channel options
	and other information.  The founder must use the IDENTIFY
	command before using SET.
	
	Available options:
	
	    FOUNDER     Set the founder of a channel
	    SUCCESSOR   Set the successor for a channel
	    PASSWORD    Set the founder password
	    DESC        Set the channel description
	    URL         Associate a URL with the channel
	    EMAIL       Associate an E-mail address with the channel
	    ENTRYMSG    Set a message to be sent to users when they
	                   enter the channel
	    TOPIC       Change the topic on the channel
	    KEEPTOPIC   Retain topic when channel is not in use
	    TOPICLOCK   Topic can only be changed with SET TOPIC
	    MLOCK       Lock channel modes on or off
	    PRIVATE     Hide channel from LIST command
	    RESTRICTED  Restrict access to the channel
	    SECURE      Activate %S security features
	    SECUREOPS   Stricter control of chanop status
	    LEAVEOPS    Do not de-op users on channel entry
	    OPNOTICE    Send a notice when OP/DEOP commands are used
	    ENFORCE     Enforce auto-op, auto-voice status
	
	Type /msg %S HELP option for more information on a
	particular option.

CHAN_HELP_SET_FOUNDER
	Syntax: SET channel FOUNDER nick
	
	Changes the founder of a channel.  The new nickname must
	be a registered one.

CHAN_HELP_SET_SUCCESSOR
	Syntax: SET channel SUCCESSOR nick
	
	Changes the successor of a channel.  If the founder's
	nickname expires or is dropped while the channel is still
	registered, the successor will become the new founder of the
	channel.  However, if the successor already has too many
	channels registered (%d), the channel will be dropped
	instead, just as if no successor had been set.  The new
	nickname must be a registered one.

CHAN_HELP_SET_PASSWORD
	Syntax: SET channel PASSWORD password
	
	Sets the password used to identify as the founder of the
	channel.

CHAN_HELP_SET_DESC
	Syntax: SET channel DESC description
	
	Sets the description for the channel, which shows up with
	the LIST and INFO commands.

CHAN_HELP_SET_URL
	Syntax: SET channel URL url
	
	Associates the given URL with the channel.  This URL will
	be displayed whenever someone requests information on the
	channel with the INFO command.

CHAN_HELP_SET_EMAIL
	Syntax: SET channel EMAIL address
	
	Associates the given E-mail address with the channel.
	This address will be displayed whenever someone requests
	information on the channel with the INFO command.

CHAN_HELP_SET_ENTRYMSG
	Syntax: SET channel ENTRYMSG message
	
	Sets the message which will be sent via /notice to users
	when they enter the channel.

CHAN_HELP_SET_TOPIC
	Syntax: SET channel TOPIC topic
	
	Causes %S to set the channel topic to the one
	specified.  This command is most useful in conjunction
	with SET TOPICLOCK.

CHAN_HELP_SET_KEEPTOPIC
	Syntax: SET channel KEEPTOPIC {ON | OFF}
	
	Enables or disables the topic retention option for a
	channel.  When topic retention is set, the topic for the
	channel will be remembered by %S even after the
	last user leaves the channel, and will be restored the
	next time the channel is created.

CHAN_HELP_SET_TOPICLOCK
	Syntax: SET channel TOPICLOCK {ON | OFF}
	
	Enables or disables the topic lock option for a channel.
	When topic lock is set, %S will not allow the
	channel topic to be changed except via the SET TOPIC
	command.

CHAN_HELP_SET_MLOCK
	Syntax: SET channel MLOCK modes
	
	Sets the mode-lock parameter for the channel.  %S
	allows you to define certain channel modes to be always
	on (or off).  The modes that can be locked are i, k, l,
	m, n, p, s, and t; each of these modes can be locked on,
	locked off, or not locked.  The modes parameter is
	constructed exactly the same way as a /MODE command; that
	is, modes followed by a + are locked on, and modes
	followed by a - are locked off.
	
	Warning:  If you set a mode-locked key, as in the second
	example below, you should also set the RESTRICTED option for
	the channel (see HELP SET RESTRICTED), or anyone entering
	the channel when it is empty will be able to see the key!
	
	Examples:
	
	    SET #channel MLOCK +nt-iklps
	        Forces modes n and t on, and modes i, k, l, p, and
	        s off.  Mode m is left free to be either on or off.
	
	    SET #channel MLOCK +knst-ilmp my-key
	        Forces modes k, n, s, and t on, and modes i, l, m,
	        and p off.  Also forces the channel key to be
	        "my-key".
	
	    SET #channel MLOCK +
	        Removes the mode lock; all channel modes are free
	        to be either on or off.

CHAN_HELP_SET_PRIVATE
	Syntax: SET channel PRIVATE {ON | OFF}
	
	Enables or disables the private option for a channel.
	When private is set, a /msg %S LIST will not
	include the channel in any lists.

CHAN_HELP_SET_RESTRICTED
	Syntax: SET channel RESTRICTED {ON | OFF}
	
	Enables or disables the restricted access option for a
	channel.  When restricted access is set, users who would
	normally be disallowed from having channel operator
	privileges (users with negative access levels and, if
	secure ops is set, users not on the access list) will
	instead be kicked and banned from the channel.

CHAN_HELP_SET_SECURE
	Syntax: SET channel SECURE {ON | OFF}
	
	Enables or disables %S's security features for a
	channel. When SECURE is set, only users who have registered
	their nicknames with %s and IDENTIFY'd with their
	password will be given privileges on the channel as
	controlled by the access list.

CHAN_HELP_SET_SECUREOPS
	Syntax: SET channel SECUREOPS {ON | OFF}
	
	Enables or disables the secure ops option for a channel.
	When secure ops is set, users who are not on the userlist
	will not be allowed chanop status.

CHAN_HELP_SET_LEAVEOPS
	Syntax: SET channel LEAVEOPS {ON | OFF}
	
	Enables or disables the leave ops option for a channel.
	When leave ops is set, %S will leave server ops (+o for
	the first person in the channel) in place even if the user
	would not normally get auto-opped.  The SECUREOPS option
	and AUTODEOP access level will still be enforced.
	Notice:  This can allow users to "steal" ops during a
	netsplit.

CHAN_HELP_SET_OPNOTICE
	Syntax: SET channel OPNOTICE {ON | OFF}
	
	Enables or disables the op-notice option for a channel.
	When op-notice is set, %S will send a notice to the
	channel whenever the OP or DEOP commands are used for a user
	in the channel.

CHAN_HELP_SET_ENFORCE
	Syntax: SET channel ENFORCE {ON | OFF}
	
	Enables or disables the enforce option for a channel.
	When enforce is set, %S will enforce the auto-op and
	auto-voice levels for all users.  For example, if a user
	with auto-op privileges is deopped, %S will
	automatically op the user again, and %S will also
	not allow the DEOP command to be used on that user.

CHAN_HELP_UNSET
	Syntax: UNSET channel {SUCCESSOR | URL | EMAIL | ENTRYMSG}
	
	Clears the given setting for a channel.

CHAN_HELP_SOP
	Syntax: SOP channel ADD nick
	        SOP channel DEL nick
	        SOP channel LIST [mask | list]
	        SOP channel COUNT
	
CHAN_HELP_SOP_NOPROT
	Maintains the SuperOp (SOP) list for a channel.
	Users with SOP status are automatically opped (set
	mode +o) when they join the channel.
CHAN_HELP_SOP_PROT
	Maintains the SuperOp (SOP) list for a channel.
	Users with SOP status are automatically opped (set
	mode +o) and protected (mode +a) when they join the
	channel.
CHAN_HELP_SOP_END
	
	An SOP can modify the AOP and VOP lists. Only
	a channel's founder can modify the SOP list.
	
	The SOP LIST command displays the SOP list.  If
	a wildcard mask is given, only those entries matching the
	mask are displayed.  If a list of entry numbers is given,
	only those entries are shown; for example:
	
	   SOP #channel LIST 2-5,7-9
	      Lists SOP list entries numbered 2 through 5 and
	      7 through 9.
	
	The SOP COUNT command returns the number of entries
	there are on the SOP list.

CHAN_HELP_AOP
	Syntax: AOP channel ADD nick
	        AOP channel DEL nick
	        AOP channel LIST [mask | list]
	        AOP channel COUNT
	
	Maintains the AutoOp (AOP) list for a channel.
	Users with AOP status are automatically opped (set
	mode +o) when they join the channel.
	
	An AOP can modify the VOP list.
	
	The AOP LIST command displays the AOP list.  If
	a wildcard mask is given, only those entries matching the
	mask are displayed.  If a list of entry numbers is given,
	only those entries are shown; for example:
	
	   AOP #channel LIST 2-5,7-9
	      Lists AOP list entries numbered 2 through 5 and
	      7 through 9.
	
	The AOP COUNT command returns the number of entries
	there are on the AOP list.

CHAN_HELP_HOP
	Syntax: HOP channel ADD nick
	        HOP channel DEL nick
	        HOP channel LIST [mask | list]
	        HOP channel COUNT
	
	Maintains the HalfOp (HOP) list for a channel.
	Users with HOP status are automatically halfopped
	(set mode +h) when they join the channel.
	
	An HOP can modify the VOP list; SOPs and AOPs can
	modify the HOP list.
	
	The HOP LIST command displays the HOP list.  If
	a wildcard mask is given, only those entries matching the
	mask are displayed.  If a list of entry numbers is given,
	only those entries are shown; for example:
	
	   HOP #channel LIST 2-5,7-9
	      Lists HOP list entries numbered 2 through 5 and
	      7 through 9.
	
	The HOP COUNT command returns the number of entries
	there are on the HOP list.

CHAN_HELP_VOP
	Syntax: VOP channel ADD nick
	        VOP channel DEL nick
	        VOP channel LIST [mask | list]
	        VOP channel COUNT
	
	Maintains the VoiceOp (VOP) list for a channel.
	Users with VOP status are automatically voiced (set
	mode +v) when they join the channel.
	
	The VOP LIST command displays the VOP list.  If
	a wildcard mask is given, only those entries matching the
	mask are displayed.  If a list of entry numbers is given,
	only those entries are shown; for example:
	
	   VOP #channel LIST 2-5,7-9
	      Lists VOP list entries numbered 2 through 5 and
	      7 through 9.
	
	The VOP COUNT command returns the number of entries
	there are on the VOP list.

CHAN_HELP_ACCESS
	Syntax: ACCESS channel ADD nick level
	        ACCESS channel DEL {nick | entry-num | list}
	        ACCESS channel LIST [mask | list]
	        ACCESS channel COUNT
	
	Maintains the access list for a channel.  The access
	list specifies which users are allowed chanop status or
	access to %S commands on the channel.  Different
	user levels allow for access to different subsets of
	privileges; /msg %S HELP ACCESS LEVELS for more
	specific information.  Any nick not on the access list has
	a user level of 0.
	
	Note that the access list may also be manipulated with the
	SOP, AOP, and VOP commands, which correspond to
	levels of %d, %d, and %d respectively.
	
	The ACCESS ADD command adds the given nickname to the
	access list with the given user level; if the nick is
	already present on the list, its access level is changed to
	the level specified in the command.  The level specified
	must be less than that of the user giving the command, and
	if the nick is already on the access list, the current
	access level of that nick must be less than the access level
	of the user giving the command.
	
	The ACCESS DEL command removes the given nick from the
	access list.  If a list of entry numbers is given, those
	entries are deleted.  (See the example for LIST below.)
	
	The ACCESS LIST command displays the access list.  If
	a wildcard mask is given, only those entries matching the
	mask are displayed.  If a list of entry numbers is given,
	only those entries are shown; for example:

	   ACCESS #channel LIST 2-5,7-9
	      Lists access entries numbered 2 through 5 and
	      7 through 9.
	
	The ACCESS COUNT command returns the number of entries
	there are on the access list.

CHAN_HELP_ACCESS_LEVELS
	User access levels
	
	By default, the following access levels are defined:
	
	   Founder   Full access to %S functions; automatic
	                     opping upon entering channel.  Note
	                     that only one person may have founder
	                     status (it cannot be given using the
	                     ACCESS command).
	      %4d   Access to AKICK command; automatic opping.
	      %4d   Automatic opping.
	      %4d   Automatic voicing.
	         0   No special privileges; can be opped by other
	                     ops (unless SECUREOPS is set).
	        <0   May not be opped.
	
	These levels may be changed, or new ones added, using the
	LEVELS command; type /msg %S HELP LEVELS for
	information.

CHAN_HELP_AKICK
	Syntax: AKICK channel ADD mask [reason]
	        AKICK channel DEL mask
	        AKICK channel LIST [mask | list]
	        AKICK channel VIEW [mask | list]
	        AKICK channel ENFORCE
	        AKICK channel COUNT
	
	Maintains the AutoKick list for a channel.  If a user
	on the AutoKick list attempts to join the channel,
	%S will ban that user from the channel, then kick
	the user.
	
	The AKICK ADD command adds the given nick or usermask
	to the AutoKick list.  If a reason is given with
	the command, that reason will be used when the user is
	kicked; if not, the default reason is "You have been
	banned from the channel".
	
	The AKICK DEL command removes the given nick or mask
	from the AutoKick list.  It does not, however, remove any
	bans placed by an AutoKick; those must be removed
	manually.
	
	The AKICK LIST command displays the AutoKick list, or
	optionally only those AutoKick entries which match the
	given mask. AKICK VIEW simply shows more details.
	
	The AKICK ENFORCE command causes %S to enforce the
	current AKICK list by removing those users who match an
	AKICK mask.
	
	The AKICK COUNT command returns how many entries there
	are on the AutoKick list.

CHAN_HELP_LEVELS
	Syntax: LEVELS channel SET type level
	        LEVELS channel {DIS | DISABLE} type
	        LEVELS channel LIST
	        LEVELS channel RESET
	
	The LEVELS command allows fine control over the meaning of
	the numeric access levels used by the ACCESS command.  With
	this command, you can define the access level required for
	most of %S's functions.  (The SET FOUNDER and SET PASSWORD
	commands, as well as this command, are always restricted to
	the channel founder.)
	
	Caution:  This command is for advanced users only!  Changing
	level settings with this command may cause the SOP, AOP, and
	VOP commands to stop working correctly.
	
	LEVELS SET allows the access level for a function or group of
	functions to be changed.  LEVELS DISABLE (or DIS for short)
	disables an automatic feature or disallows access to a
	function by anyone other than the channel founder.
	LEVELS LIST shows the current levels for each function or
	group of functions.  LEVELS RESET resets the levels to the
	default levels of a newly-created channel (see
	HELP ACCESS LEVELS).
	
	For a list of the features and functions whose levels can be
	set, see HELP LEVELS DESC.

CHAN_HELP_LEVELS_DESC
	The following feature/function names are understood.  Note
	that the levels for AUTODEOP and NOJOIN are maximum levels,
	while all others are minimum levels.

CHAN_HELP_LEVELS_DESC_FORMAT
	    %-*s  %s

CHAN_HELP_INFO
	Syntax: INFO channel [ALL]
	
	Lists information about the named registered channel,
	including its founder, time of registration, last time
	used, description, and mode lock, if any.  If you are
	identified as the founder of the channel you're getting
	information for and ALL is specified, the entry message
	and successor will also be displayed.

CHAN_HELP_LIST
	Syntax: LIST pattern
	
	Lists all registered channels matching the given pattern.
	(Channels with the PRIVATE option set are not listed.)

CHAN_HELP_OP
	Syntax: OP #channel nick
	
	Ops a selected nick on a channel.  By default, limited to
	those with level 5 access and above on the channel.

CHAN_HELP_DEOP
	Syntax: DEOP #channel nick
	
	Deops a selected nick on a channel.  By default, limited to
	those with level 5 access and above on the channel.

CHAN_HELP_VOICE
	Syntax: VOICE #channel nick
	
	Voices a selected nick on a channel.  By default, limited to
	those with level 3 access and above on the channel.

CHAN_HELP_DEVOICE
	Syntax: DEVOICE #channel nick
	
	Devoices a selected nick on a channel.  By default, limited
	to those with level 3 access and above on the channel.

CHAN_HELP_HALFOP
	Syntax: HALFOP #channel nick
	
	Gives halfop access to a selected nick on a channel.  By
	default, limited to those with level 4 access and above on
	the channel.

CHAN_HELP_DEHALFOP
	Syntax: DEHALFOP #channel nick
	
	Removes halfop access from a selected nick on a channel.
	By default, limited to those with level 4 access and above
	on the channel.

CHAN_HELP_PROTECT
	Syntax: PROTECT #channel nick
	
	Gives channel protection (mode +a) to a selected nick on a
	channel.  By default, limited to those with level 10 access
	and above on the channel.

CHAN_HELP_DEPROTECT
	Syntax: DEPROTECT #channel nick
	
	Removes channel protection (mode +a) from a selected nick
	on a channel.  By default, limited to those with level 10
	access and above on the channel.

CHAN_HELP_INVITE
	Syntax: INVITE channel
	
	Tells %S to invite you into the given channel.  By
	default, only works if your access level on that channel is
	at least 5.

CHAN_HELP_UNBAN
	Syntax: UNBAN channel
	
	Tells %S to remove all bans preventing you from
	entering the given channel.  By default, only works if your
	access level on that channel is at least 5.

CHAN_HELP_CLEAR
	Syntax: CLEAR channel what
	
	Tells %S to clear certain settings on a channel.  what
	can be any of the following:
	
	     MODES       Clears all modes on the channel except those
	                     set in the channel's mode lock.
	     BANS        Clears all bans on the channel.
CHAN_HELP_CLEAR_EXCEPTIONS
	     EXCEPTIONS  Clears all exceptions on the channel.
CHAN_HELP_CLEAR_MID
	     OPS         Removes channel-operator status (mode +o) from
	                     all users.
CHAN_HELP_CLEAR_HALFOPS
	     HALFOPS     Removes halfop status (mode +h) from all users.
CHAN_HELP_CLEAR_END
	     VOICES      Removes "voice" status (mode +v) from all users.
	     USERS       Removes (kicks) all users from the channel.
	
	By default, your access level on the channel must be at
	least 10 to use this command.

CHAN_SERVADMIN_HELP
	
	The following commands are available to Cservice Members:
	
	    GETPASS   Retrieve the founder password for a channel
	                  (only if encryption is disabled)
	    FORBID    Prevent a channel from being registered/used
	    SUSPEND   Prevent a registered channel from being used
	    STATUS    Returns the current access level of a user
	                  on a channel
	
	Cservice Members can also drop any channel without needing
	to identify via password, and may view the access.

CHAN_SERVADMIN_HELP_DROP
	Syntax: REMCHAN channel
	
	Unregisters the named channel.  Only CService Members
	can drop a channel for which they have not identified.

CHAN_SERVADMIN_HELP_SET
				
CHAN_SERVADMIN_HELP_UNSET
	
	As with the SET command, Cservice Members can clear settings
	for any channel without identifying for the channel.

CHAN_SERVADMIN_HELP_SET_NOEXPIRE
	Syntax: SET channel NOEXPIRE {ON | OFF}
	
	Sets whether the given channel will expire.  Setting this
	to ON prevents the channel from expiring.
	
	Limited to Cservice Members.

CHAN_SERVADMIN_HELP_INFO
	
	Cservice Members can use the ALL parameter with any channel.

CHAN_SERVADMIN_HELP_LIST
	Syntax: LIST pattern [FORBIDDEN] [NOEXPIRE] [SUSPENDED]
	
	Lists all registered channels matching the given pattern.
	Channels with the PRIVATE option set will only be displayed
	to Cservice Members. Channels with the NOEXPIRE option set
	will have a ! prepended to the channel name for Services
	admins.
	
	If the FORBIDDEN, SUSPENDED or NOEXPIRE options are given,
	only channels which, respectively, are FORBIDden, SUSPENDed or
	have the NOEXPIRE flag set will be displayed. The options can
	be used in any order and in any combination. These options
	are limited to Cservice Members.

CHAN_SERVADMIN_HELP_GETPASS
	Syntax: GETPASS channel
	
	Returns the password for the given channel.  Note that
	whenever this command is used, a message including the
	person who issued the command and the channel it was used
	on will be logged and sent out as a WALLOPS/GLOBOPS.
	
	Limited to Cservice Members.

CHAN_SERVADMIN_HELP_FORBID
	Syntax: FORBID channel
	
	Disallows anyone from registering or using the given
	channel.  May be cancelled by dropping the channel.
	
	Limited to Cservice Members.

CHAN_SERVADMIN_HELP_SUSPEND
	Syntax: SUSPEND [+expiry] channel reason
	
	Prevents a channel from being used or identified for
	by anyone. A channel can be unsuspended with the
	UNSUSPEND command.
	
	Unlike a forbidden channel, a suspended one does not
	lose its information and will expire!
	
	Limited to Cservice Members.

CHAN_SERVADMIN_HELP_UNSUSPEND
	Syntax: UNSUSPEND channel
	
	Allows people to use and identify for a previously
	SUSPENDed channel.
	
	Limited to Cservice Members.

CHAN_SERVADMIN_HELP_STATUS
	Syntax: STATUS channel nickname
	
	Returns the current access level of the given nick on the
	given channel.  The reply is of the form:
	
	    STATUS channel nickname access-level
	
	If an error occurs, the reply will be in the form:
	
	    STATUS ERROR error-message
	
	Limited to Cservice Members.

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
	A new password will be emailed to [%s] in a few minutes

NICK_GENPASS_SYNTAX
	GENPASS nickname

NICK_SERVADMIN_HELP_GENPASS
	Syntax: GENPASS nickname
	
	Generates a random password and emails it to the registered
	email address.
	
	Limited to Cservice Members^B.

NICK_GENPASS_OK
	A new password will be emailed to [%s] in a few minutes

