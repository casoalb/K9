# Emacs mode: -*- text -*-

# Japanese language file (SJIS encoding) / “ú–{Œê‚ÌƒƒbƒZ[ƒWƒtƒ@ƒCƒ‹
#
# K9 IRC Services (c) 2001-2002 |SaMaN|
# Contact me at linuxworm@turk.net
# This program is free but copyrighted software; see the file COPYING for
# details.
#
# Based on the original code of Services by Andy Church.
#

###########################################################################
#
# Œ¾Œê‚Ì–¼‘O
#
###########################################################################

LANG_NAME
	“ú–{ŒêiSJISƒR[ƒhj (Japanese / SJIS encoding)

###########################################################################
#
# ‘½—p‚ÌƒƒbƒZ[ƒW
#
###########################################################################

# strftime()‚Ì“úŽžƒtƒH[ƒ}ƒbƒg
STRFTIME_DATE_TIME_FORMAT
	%Y.%m.%d %H:%M:%S %Z
# strftime()‚Ì”NŒŽ“úƒtƒH[ƒ}ƒbƒgi‚Pj
STRFTIME_LONG_DATE_FORMAT
	%Y”N%mŒŽ%d“úi%aj
# strftime()‚Ì”NŒŽ“úƒtƒH[ƒ}ƒbƒgi‚Qj
STRFTIME_SHORT_DATE_FORMAT
	%Y.%m.%d

# strftime()‚ÌƒtƒH[ƒ}ƒbƒg‚ÅŽg—p‚³‚ê‚é•¶Žš—ñ
STRFTIME_DAYS_SHORT
	“ú
	ŒŽ
	‰Î
	…
	–Ø
	‹à
	“y
STRFTIME_DAYS_LONG
	“ú—j“ú
	ŒŽ—j“ú
	‰Î—j“ú
	…—j“ú
	–Ø—j“ú
	‹à—j“ú
	“y—j“ú
STRFTIME_MONTHS_SHORT
	1ŒŽ
	2ŒŽ
	3ŒŽ
	4ŒŽ
	5ŒŽ
	6ŒŽ
	7ŒŽ
	8ŒŽ
	9ŒŽ
	10ŒŽ
	11ŒŽ
	12ŒŽ
STRFTIME_MONTHS_LONG
	1ŒŽ
	2ŒŽ
	3ŒŽ
	4ŒŽ
	5ŒŽ
	6ŒŽ
	7ŒŽ
	8ŒŽ
	9ŒŽ
	10ŒŽ
	11ŒŽ
	12ŒŽ


# "day", "hour", "minute", and "second" in singular and plural.
STR_DAY
	“ú
STR_DAYS
	“ú
STR_HOUR
	ŽžŠÔ
STR_HOURS
	ŽžŠÔ
STR_MINUTE
	•ª
STR_MINUTES
	•ª
STR_SECOND
	•b
STR_SECONDS
	•b


# ChanServADogTag INFO‚ÅŽg‚í‚ê‚é‚à‚Ì
COMMA_SPACE
	A


# ƒGƒ‰[ƒƒbƒZ[ƒW
USER_RECORD_NOT_FOUND
	ƒGƒ‰[‚ª”­¶‚µ‚Ü‚µ‚½B
UNKNOWN_COMMAND
	%s ‚Æ‚¢‚¤ƒRƒ}ƒ“ƒh‚Í•ª‚©‚è‚Ü‚¹‚ñB
UNKNOWN_COMMAND_HELP
	%s ‚Æ‚¢‚¤ƒRƒ}ƒ“ƒh‚Í•ª‚©‚è‚Ü‚¹‚ñBƒwƒ‹ƒv‚ðŒ©‚éê‡‚Íu/msg %s HELPv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B
SYNTAX_ERROR
	—p–@F%s
MORE_INFO
	ƒwƒ‹ƒv‚ðŒ©‚éê‡‚Íu/msg %s HELP %sv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B
NO_HELP_AVAILABLE
	u%sv‚Ìƒwƒ‹ƒv‚Í‚ ‚è‚Ü‚¹‚ñB

BAD_USERHOST_MASK
	ƒ}ƒXƒN‚ð user@host ‚Æ‚¢‚¤Œ`‚Å“ü—Í‚µ‚Ä‰º‚³‚¢B

SERVICE_OFFLINE
	%s‚ÍŒ»ÝŽg—p‚Å‚«‚Ü‚¹‚ñB
READ_ONLY_MODE
	’ˆÓFServices ‚Í“Ç‚Ýž‚Ýê—pƒ‚[ƒh‚Å“®‚¢‚Ä‚¢‚Ü‚·‚Ì‚ÅA•ÏX‚Í•Û‘¶‚³‚ê‚Ü‚¹‚ñB
ACCESS_DENIED
	ƒAƒNƒZƒX•s”\B
PERMISSION_DENIED
	ƒAƒNƒZƒX•s”\B
PASSWORD_INCORRECT
	ƒpƒXƒ[ƒh‚Íˆá‚¢‚Ü‚·B

MORE_OBSCURE_PASSWORD
	‚à‚Á‚Æ•¡ŽG‚ÈƒpƒXƒ[ƒh‚É‚µ‚Ä‰º‚³‚¢BƒpƒXƒ[ƒh‚ÍA‚¨–¼‘OEƒjƒbƒN“™‚Ì‚æ‚¤‚È•ª‚©‚è‚â‚·‚¢‚à‚Ì‚Å‚È‚­A‚©‚Â‚T•¶ŽšˆÈã‚Ì‚à‚Ì‚É‚µ‚Ä‰º‚³‚¢B‚Ü‚½AƒXƒy[ƒXi‹ó”’j‚ÍƒpƒXƒ[ƒh‚Å‚ÍŽg‚¦‚Ü‚¹‚ñB
PASSWORD_TRUNCATED
	’ˆÓF“ü—Í‚µ‚½ƒpƒXƒ[ƒh‚ª %d •¶Žš‚ÅØ‚ç‚ê‚Ü‚µ‚½B

NICK_NOT_REGISTERED
	ƒjƒbƒN‚Í“o˜^‚³‚ê‚Ä‚¢‚Ü‚¹‚ñB
NICK_NOT_REGISTERED_HELP
	ƒjƒbƒN‚Í“o˜^‚³‚ê‚Ä‚¢‚Ü‚¹‚ñB“o˜^‚µ‚½‚¢ê‡‚Íu/msg %s HELPv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B
NICK_X_NOT_REGISTERED
	%s ‚Æ‚¢‚¤ƒjƒbƒN‚Í“o˜^‚³‚ê‚Ä‚¢‚Ü‚¹‚ñB
NICK_X_NOT_IN_USE
	%s ‚Æ‚¢‚¤ƒjƒbƒN‚ÍŒ»ÝŽg—p‚³‚ê‚Ä‚¢‚Ü‚¹‚ñB
NICK_X_FORBIDDEN
	%s ‚Æ‚¢‚¤ƒjƒbƒN‚ðŽg—p‹ÖŽ~‚Å‚·B
NICK_X_SUSPENDED
	%s ‚Æ‚¢‚¤ƒjƒbƒN‚ÍŽg—p’âŽ~‚Ì‚½‚ßAŽg—p‚Å‚«‚Ü‚¹‚ñB
NICK_X_SUSPENDED_MEMOS
	%s ‚Æ‚¢‚¤ƒjƒbƒN‚ÍŽg—p’âŽ~‚Ì‚½‚ßAƒƒ‚‚ðŽóM‚Å‚«‚Ü‚¹‚ñB
NICK_IDENTIFY_REQUIRED
	‚»‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚¤‚É‚ÍƒpƒXƒ[ƒh‚ð“ü—Í‚·‚é•K—v‚ª‚ ‚è‚Ü‚·B
	u/msg %s IDENTIFY ƒpƒXƒ[ƒhv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B
NICK_X_NOT_ON_CHAN_X
	%s ‚Í %s ‚É“ü‚Á‚Ä‚¢‚Ü‚¹‚ñB

CHAN_X_NOT_REGISTERED
	%s ‚Æ‚¢‚¤ƒ`ƒƒƒ“ƒlƒ‹‚Í“o˜^‚³‚ê‚Ä‚¢‚Ü‚¹‚ñB
CHAN_X_NOT_IN_USE
	%s ‚Æ‚¢‚¤ƒ`ƒƒƒ“ƒlƒ‹‚ÍŒ»ÝŽg—p‚³‚ê‚Ä‚¢‚Ü‚¹‚ñB
CHAN_X_FORBIDDEN
	%s ‚Æ‚¢‚¤ƒ`ƒƒƒ“ƒlƒ‹‚ÍŽg—p‹ÖŽ~‚Å‚·B
CHAN_X_SUSPENDED
	%s ‚Æ‚¢‚¤ƒ`ƒƒƒ“ƒlƒ‹‚ÍŽg—p’âŽ~‚Ì‚½‚ßAŽg—p‚Å‚«‚Ü‚¹‚ñB
CHAN_X_SUSPENDED_MEMOS
	%s ‚Æ‚¢‚¤ƒ`ƒƒƒ“ƒlƒ‹‚ÍŽg—p’âŽ~‚Ì‚½‚ßAƒƒ‚‚ðŽóM‚Å‚«‚Ü‚¹‚ñB
CHAN_IDENTIFY_REQUIRED
	‚»‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚¤‚É‚ÍƒpƒXƒ[ƒh‚ð“ü—Í‚·‚é•K—v‚ª‚ ‚è‚Ü‚·B
	u/msg %s IDENTIFY %s ƒpƒXƒ[ƒhv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B

SERV_X_NOT_FOUND
	%s ‚Æ‚¢‚¤ƒT[ƒo‚ÍŒ©‚Â‚©‚è‚Ü‚¹‚ñB

EXPIRES_NONE
	Ø‚ê‚È‚¢
EXPIRES_SOON
	ŽŸ‚Ìƒf[ƒ^•Û‘¶Žž‚ÉØ‚ê‚é
EXPIRES_M
	%d•ªŒãØ‚ê‚é
EXPIRES_1M
	%d•ªŒãØ‚ê‚é
EXPIRES_HM
	%dŽž%d•ªŒãØ‚ê‚é
EXPIRES_H1M
	%dŽž%d•ªŒãØ‚ê‚é
EXPIRES_1HM
	%dŽž%d•ªŒãØ‚ê‚é
EXPIRES_1H1M
	%dŽž%d•ªŒãØ‚ê‚é
EXPIRES_D
	%d“úŒãØ‚ê‚é
EXPIRES_1D
	%d“úŒãØ‚ê‚é

###########################################################################
#
# DogTag‚ÌƒƒbƒZ[ƒW
#
###########################################################################

# Ž©“®ƒƒbƒZ[ƒW
NICK_IS_REGISTERED
	‚±‚ÌƒjƒbƒN‚Í“o˜^‚³‚ê‚Ä‚¢‚Ü‚·B‘¼‚ÌƒjƒbƒN‚É•Ï‚¦‚Ä‰º‚³‚¢B
	i•Û—LŽÒ‚È‚çAu/msg %s IDENTIFY ƒpƒXƒ[ƒhv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢Bj
NICK_IS_SECURE
	‚±‚ÌƒjƒbƒN‚Í“o˜^•ÛŒì‚³‚ê‚Ä‚¢‚Ü‚·B•Û—LŽÒ‚È‚çA
	u/msg %s IDENTIFY ƒpƒXƒ[ƒhv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B
	•Û—LŽÒ‚Å‚È‚¯‚ê‚ÎA‘¼‚ÌƒjƒbƒN‚É•Ï‚¦‚Ä‰º‚³‚¢B
NICK_MAY_NOT_BE_USED
	‚±‚ÌƒjƒbƒN‚Í‚¨Žg‚¢‚É‚È‚ê‚Ü‚¹‚ñB
DISCONNECT_IN_1_MINUTE
	1•ªˆÈ“à‚ÉƒjƒbƒN‚ð•Ï‚¦‚È‚¢‚ÆAØ’f‚³‚ê‚Ä‚µ‚Ü‚¢‚Ü‚·B
DISCONNECT_IN_20_SECONDS
	20•bˆÈ“à‚ÉƒjƒbƒN‚ð•Ï‚¦‚È‚¢‚ÆAØ’f‚³‚ê‚Ä‚µ‚Ü‚¢‚Ü‚·B
DISCONNECT_NOW
	‚±‚ÌƒjƒbƒN‚Í“o˜^‚³‚ê‚Ä‚¢‚Ü‚·‚Ì‚ÅA‚¨Žg‚¢‚É‚È‚ê‚Ü‚¹‚ñB
	ÄÚ‘±‚·‚é‘O‚É‘¼‚ÌƒjƒbƒN‚É‚¨•Ï‚¦‰º‚³‚¢B
FORCENICKCHANGE_IN_1_MINUTE
	1•ªˆÈ“à‚ÉƒjƒbƒN‚ð•Ï‚¦‚È‚¢‚ÆAƒjƒbƒN‚ª•ÏX‚³‚ê‚Ü‚·B
FORCENICKCHANGE_IN_20_SECONDS
	20•bˆÈ“à‚ÉƒjƒbƒN‚ð•Ï‚¦‚È‚¢‚ÆAƒjƒbƒN‚ª•ÏX‚³‚ê‚Ü‚·B
FORCENICKCHANGE_NOW
	‚±‚ÌƒjƒbƒN‚Í“o˜^‚³‚ê‚Ä‚¢‚Ü‚·‚Ì‚ÅA‚¨Žg‚¢‚É‚È‚ê‚Ü‚¹‚ñB
	‚ ‚È‚½‚ÌƒjƒbƒN‚Íu%sv‚É•ÏX‚³‚ê‚Ü‚µ‚½B

# REGISTER‰ž“š
NICK_REGISTER_SYNTAX
	REGISTER ƒpƒXƒ[ƒh [ƒ[ƒ‹ƒAƒhƒŒƒX]
NICK_REGISTER_REQ_EMAIL_SYNTAX
	REGISTER ƒpƒXƒ[ƒh ƒ[ƒ‹ƒAƒhƒŒƒX
NICK_REGISTRATION_DISABLED
	ƒjƒbƒN‚Ì“o˜^‚Í‚½‚¾¡o—ˆ‚Ü‚¹‚ñB
NICK_REGISTRATION_FAILED
	“o˜^‚ÍŽ¸”s‚µ‚Ü‚µ‚½B
NICK_REG_PLEASE_WAIT
	REGISTER‚ÌƒRƒ}ƒ“ƒh‚ðÄ“ü—Í‚·‚é‘O‚ÉA%d •b‚¨‘Ò‚¿‰º‚³‚¢B
NICK_CANNOT_BE_REGISTERED
	%s ‚ÍŽg—p‹ÖŽ~‚Å‚·‚Ì‚Å“o˜^‚Å‚«‚Ü‚¹‚ñB
NICK_ALREADY_REGISTERED
	%s ‚ÍŠù‚É“o˜^‚³‚ê‚Ä‚¢‚Ü‚·B
NICK_REGISTERED
	ƒjƒbƒNu%sv‚ð“o˜^‚µ‚Ü‚µ‚½B
NICK_PASSWORD_IS
	ƒjƒbƒN‚ÌƒpƒXƒ[ƒh‚Í %s ‚Å‚·B–Y‚ê‚È‚¢‚æ‚¤‚É‚µ‚Ä‰º‚³‚¢B

# IDENTIFY‰ž“š
NICK_IDENTIFY_SYNTAX
	IDENTIFY ƒpƒXƒ[ƒh
NICK_IDENTIFY_FAILED
	IDENTIFY‚ÍŽ¸”s‚µ‚Ü‚µ‚½B
NICK_IDENTIFY_SUCCEEDED
	³‚µ‚¢ƒpƒXƒ[ƒh‚Å‚·B

# DROP‰ž“š
NICK_DROP_SYNTAX
	DROP
NICK_DROP_DISABLED
	ƒjƒbƒN“o˜^‚ÌÁ‹Ž‚Í‚½‚¾¡o—ˆ‚Ü‚¹‚ñB
NICK_DROPPED
	ƒjƒbƒN‚Ì“o˜^‚ðÁ‹Ž‚µ‚Ü‚µ‚½B
NICK_X_DROPPED
	%s ‚Ì“o˜^‚ðÁ‹Ž‚µ‚Ü‚µ‚½B

# SET‰ž“š
NICK_SET_SYNTAX
	SET ƒIƒvƒVƒ‡ƒ“–¼ ƒpƒ‰ƒ[ƒ^
NICK_SET_SERVADMIN_SYNTAX
	SET [ƒjƒbƒN] ƒIƒvƒVƒ‡ƒ“–¼ ƒpƒ‰ƒ[ƒ^
NICK_SET_DISABLED
	ƒjƒbƒN‚ÌƒIƒvƒVƒ‡ƒ“Ý’è‚Í‚½‚¾¡•s‰Â”\‚Å‚·B
NICK_SET_UNKNOWN_OPTION
	%s ‚Æ‚¢‚¤ƒIƒvƒVƒ‡ƒ“‚Í‚ ‚è‚Ü‚¹‚ñB
NICK_SET_UNKNOWN_OPTION_OR_BAD_NICK
	%s ‚ÍƒIƒvƒVƒ‡ƒ“–¼‚Å‚à“o˜^Ï‚ÝƒjƒbƒN‚Å‚à‚ ‚è‚Ü‚¹‚ñB

# SET PASSWORD‰ž“š
NICK_SET_PASSWORD_FAILED
	ƒpƒXƒ[ƒh‚Ì•ÏX‚ÍŽ¸”s‚µ‚Ü‚µ‚½B
NICK_SET_PASSWORD_CHANGED
	ƒpƒXƒ[ƒh‚ð•ÏX‚µ‚Ü‚µ‚½B
NICK_SET_PASSWORD_CHANGED_TO
	ƒpƒXƒ[ƒh‚ð %s ‚É•ÏX‚µ‚Ü‚µ‚½B

# SET LANGUAGE‰ž“š
NICK_SET_LANGUAGE_SYNTAX
	SET LANGUAGE ”Ô†
NICK_SET_LANGUAGE_UNKNOWN
	%d ”Ô‚ÌŒ¾Œê‚Í‘¶Ý‚µ‚Ü‚¹‚ñBŒ¾Œê•\‚ðŒ©‚éê‡Aumsg %s HELP SET LANGUAGEv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B
NICK_SET_LANGUAGE_CHANGED
	Œ¾Œê‚ð“ú–{ŒêiSJISƒR[ƒhj‚É•ÏX‚µ‚Ü‚µ‚½B

# SET URL‰ž“š
NICK_SET_URL_CHANGED
	%s ‚Ìƒz[ƒƒy[ƒWƒAƒhƒŒƒX‚ð %s ‚É•ÏX‚µ‚Ü‚µ‚½B

# SET EMAIL‰ž“š
NICK_SET_EMAIL_CHANGED
	%s ‚Ì“dŽqƒ[ƒ‹ƒAƒhƒŒƒX‚ð %s ‚É•ÏX‚µ‚Ü‚µ‚½B

# SET KILL‰ž“š
NICK_SET_KILL_SYNTAX
	SET KILL {ON | QUICK | OFF}
NICK_SET_KILL_IMMED_SYNTAX
	SET KILL {ON | QUICK | IMMED | OFF}
NICK_SET_KILL_ON
	ƒjƒbƒN•ÛŒìÝ’è‚ð—LŒø‚ÉÝ’è‚µ‚Ü‚µ‚½B
NICK_SET_KILL_QUICK
	ƒjƒbƒN•ÛŒìÝ’è‚ð—LŒøiƒjƒbƒN•ÏXŠúŒÀ‚Í20•bj‚ÉÝ’è‚µ‚Ü‚µ‚½B
NICK_SET_KILL_IMMED
	ƒjƒbƒN•ÛŒìÝ’è‚ð—LŒøi‘¦ŽžØ’fj‚ÉÝ’è‚µ‚Ü‚µ‚½B
NICK_SET_KILL_IMMED_DISABLED
	‚±‚Ìƒlƒbƒgƒ[ƒN‚Å‚ÍAIMMED ‚ð‘I‘ð‚Å‚«‚Ü‚¹‚ñB
NICK_SET_KILL_OFF
	ƒjƒbƒN•ÛŒìÝ’è‚ð–³Œø‚ÉÝ’è‚µ‚Ü‚µ‚½B

# SET SECURE‰ž“š
NICK_SET_SECURE_SYNTAX
	SET SECURE {ON | OFF}
NICK_SET_SECURE_ON
	ƒZƒLƒ…ƒAÝ’è‚ð—LŒø‚ÉÝ’è‚µ‚Ü‚µ‚½B
NICK_SET_SECURE_OFF
	ƒZƒLƒ…ƒAÝ’è‚ð–³Œø‚ÉÝ’è‚µ‚Ü‚µ‚½B

# SET PRIVATE‰ž“š
NICK_SET_PRIVATE_SYNTAX
	SET PRIVATE {ON | OFF}
NICK_SET_PRIVATE_ON
	ƒvƒ‰ƒCƒx[ƒgÝ’è‚ð—LŒø‚ÉÝ’è‚µ‚Ü‚µ‚½B
NICK_SET_PRIVATE_OFF
	ƒvƒ‰ƒCƒx[ƒgÝ’è‚ð–³Œø‚ÉÝ’è‚µ‚Ü‚µ‚½B

# SET HIDE‰ž“š
NICK_SET_HIDE_SYNTAX
	SET HIDE {EMAIL | USERMASK | QUIT} {ON | OFF}
NICK_SET_HIDE_EMAIL_ON
	“dŽqƒ[ƒ‹ƒAƒhƒŒƒX‚Í INFO ‰ž“š‚Å•\Ž¦‚³‚ê‚Ü‚¹‚ñB
NICK_SET_HIDE_EMAIL_OFF
	“dŽqƒ[ƒ‹ƒAƒhƒŒƒX‚Í INFO ‰ž“š‚Å•\Ž¦‚³‚ê‚Ü‚·B
NICK_SET_HIDE_MASK_ON
	‘O‚Ìƒ†[ƒUƒAƒhƒŒƒX‚Í INFO ‰ž“š‚Å•\Ž¦‚³‚ê‚Ü‚¹‚ñB
NICK_SET_HIDE_MASK_OFF
	‘O‚Ìƒ†[ƒUƒAƒhƒŒƒX‚Í INFO ‰ž“š‚Å•\Ž¦‚³‚ê‚Ü‚·B
NICK_SET_HIDE_QUIT_ON
	‘O‚ÌØ’fƒƒbƒZ[ƒW‚Í INFO ‰ž“š‚Å•\Ž¦‚³‚ê‚Ü‚¹‚ñB
NICK_SET_HIDE_QUIT_OFF
	‘O‚ÌØ’fƒƒbƒZ[ƒW‚Í INFO ‰ž“š‚Å•\Ž¦‚³‚ê‚Ü‚·B

# SET NOEXPIRE‰ž“š
NICK_SET_NOEXPIRE_SYNTAX
	SET [ƒjƒbƒN] NOEXPIRE {ON | OFF}
NICK_SET_NOEXPIRE_ON
	%s ‚Ì“o˜^‚ÍØ‚ê‚Ü‚¹‚ñB
NICK_SET_NOEXPIRE_OFF
	%s ‚Ì“o˜^‚ÍØ‚ê‚Ü‚·B

# UNSET‰ž“š
NICK_UNSET_SYNTAX
	UNSET {URL | EMAIL}
NICK_UNSET_SYNTAX_REQ_EMAIL
	UNSET URL
NICK_UNSET_URL
	%s ‚Ìƒz[ƒƒy[ƒWƒAƒhƒŒƒX‚ðÁ‹Ž‚µ‚Ü‚µ‚½B
NICK_UNSET_EMAIL
	%s ‚Ì“dŽqƒ[ƒ‹ƒAƒhƒŒƒX‚ðÁ‹Ž‚µ‚Ü‚µ‚½B
NICK_UNSET_EMAIL_BAD
	“dŽqƒ[ƒ‹ƒAƒhƒŒƒX‚ðÁ‹Ž‚Å‚«‚Ü‚¹‚ñB
NICK_UNSET_EMAIL_OTHER_BAD
	ƒjƒbƒN‚Ì“dŽqƒ[ƒ‹ƒAƒhƒŒƒX‚ðÁ‹Ž‚Å‚«‚Ü‚¹‚ñB

# ACCESS‰ž“š
NICK_ACCESS_SYNTAX
	ACCESS {ADD | DEL | LIST} [ƒ}ƒXƒN]
NICK_ACCESS_REACHED_LIMIT
	ƒjƒbƒN‚ÌƒAƒNƒZƒXˆê——‚ÌƒGƒ“ƒgƒŠ”‚ÍãŒÀi%dj‚É’B‚µ‚Ä‚¢‚Ü‚·‚Ì‚Å’Ç‰Á‚Å‚«‚Ü‚¹‚ñB
NICK_ACCESS_ALREADY_PRESENT
	%s ‚Í‚·‚Å‚ÉƒAƒNƒZƒXˆê——‚Å‘¶Ý‚µ‚Ä‚¢‚Ü‚·B
NICK_ACCESS_ADDED
	%s ‚ðƒAƒNƒZƒXˆê——‚É’Ç‰Á‚µ‚Ü‚µ‚½B
NICK_ACCESS_NOT_FOUND
	%s ‚ÍƒAƒNƒZƒXˆê——‚Å‘¶Ý‚µ‚Ü‚¹‚ñB
NICK_ACCESS_DELETED
	%s ‚ðƒAƒNƒZƒXˆê——‚©‚çÁ‹Ž‚µ‚Ü‚µ‚½B
NICK_ACCESS_LIST
	ƒAƒNƒZƒXˆê——F
NICK_ACCESS_LIST_X
	%s ‚ÌƒAƒNƒZƒXˆê——F

# LINK‰ž“š
NICK_LINK_SYNTAX
	LINK ƒjƒbƒN ƒpƒXƒ[ƒh
NICK_LINK_DISABLED
	LINK ‚Í‚½‚¾¡Žg—p‚Å‚«‚Ü‚¹‚ñB
NICK_LINK_FAILED
	ƒŠƒ“ƒN‚ÍŽ¸”s‚µ‚Ü‚µ‚½B
NICK_NO_LINK_SAME
	“¯‚¶ƒjƒbƒN‚ÉƒŠƒ“ƒN‚Å‚«‚Ü‚¹‚ñB
NICK_LINK_CIRCULAR
	ŠÂóƒŠƒ“ƒN‚ª”­Œ©‚³‚ê‚Ü‚µ‚½‚Ì‚Å %s ‚ÉƒŠƒ“ƒN‚Å‚«‚Ü‚¹‚ñB
NICK_LINK_TOO_DEEP
	ƒjƒbƒN‚ÌŠK‘wãŒÀi%dj‚ð‰z‚¦‚Ü‚·‚Ì‚ÅƒŠƒ“ƒN‚Å‚«‚Ü‚¹‚ñB
NICK_LINK_TOO_MANY_CHANNELS
	ƒjƒbƒN‚Ì‡Œv“o˜^ƒ`ƒƒƒ“ƒlƒ‹”‚ÌãŒÀi%dj‚ð‰z‚¦‚Ü‚·‚Ì‚ÅƒŠƒ“ƒN‚Å‚«‚Ü‚¹‚ñB
NICK_LINKED
	ƒjƒbƒN‚ð %s ‚ÉƒŠƒ“ƒN‚µ‚Ü‚µ‚½B

# UNLINK‰ž“š
NICK_UNLINK_SYNTAX
	UNLINK [ƒjƒbƒN ƒpƒXƒ[ƒh]
NICK_UNLINK_FAILED
	ƒAƒ“ƒŠƒ“ƒN‚ÍŽ¸”s‚µ‚Ü‚µ‚½B
NICK_NOT_LINKED
	ƒjƒbƒN‚ÍƒŠƒ“ƒN‚³‚ê‚Ä‚¢‚Ü‚¹‚ñB
NICK_UNLINKED
	ƒjƒbƒN‚ð %s ‚©‚çƒAƒ“ƒŠƒ“ƒN‚µ‚Ü‚µ‚½B
NICK_X_NOT_LINKED
	%s ‚ÍƒŠƒ“ƒN‚³‚ê‚Ä‚¢‚Ü‚¹‚ñB
NICK_X_UNLINKED
	%s ‚ð %s ‚©‚çƒAƒ“ƒŠƒ“ƒN‚µ‚Ü‚µ‚½B

# LISTLINKS‰ž“š
NICK_LISTLINKS_SYNTAX
	LISTLINKS ƒjƒbƒN [ALL]
NICK_LISTLINKS_HEADER
	%s ‚ÉƒŠƒ“ƒN‚³‚ê‚Ä‚¢‚éƒjƒbƒNF
NICK_LISTLINKS_FOOTER
	%d ŒÂŒ©‚Â‚©‚è‚Ü‚µ‚½B
NICK_X_IS_LINKED
	    %s
NICK_X_IS_LINKED_VIA_X
	    %-20s (via %s)

# INFO‰ž“š
NICK_INFO_SYNTAX
	INFO nick
NICK_INFO_REALNAME
	%s ‚Í %s
NICK_INFO_ADDRESS
	‘O‰ñƒ†[ƒUƒAƒhƒŒƒXF%s
NICK_INFO_ADDRESS_ONLINE
	Œ»ÝŽg—p’†ƒAƒhƒŒƒXF%s
NICK_INFO_ADDRESS_ONLINE_NOHOST
	‚±‚Ìƒ†[ƒU‚ÍŒ»ÝÚ‘±‚µ‚Ä‚¢‚Ü‚·B
NICK_INFO_TIME_REGGED
	@@@@@“o˜^“úŽžF%s
NICK_INFO_LAST_SEEN
	@@@‘O‰ñŽg—p“úŽžF%s
NICK_INFO_LAST_QUIT
	‘O‰ñØ’fƒƒbƒZ[ƒWF%s
NICK_INFO_URL
	@@@ƒz[ƒƒy[ƒWF%s
NICK_INFO_EMAIL
	“dŽqƒ[ƒ‹ƒAƒhƒŒƒXF%s
NICK_INFO_OPTIONS
	@@@@ƒIƒvƒVƒ‡ƒ“F%s
NICK_INFO_LINKED_TO
	@@@@@ƒŠƒ“ƒNæF%s
# These strings MUST NOT be empty
NICK_INFO_OPT_KILL
	ƒjƒbƒN•ÛŒì
NICK_INFO_OPT_SECURE
	ƒZƒLƒ…ƒA
NICK_INFO_OPT_PRIVATE
	ƒvƒ‰ƒCƒx[ƒg
NICK_INFO_OPT_NONE
	–³‚µ
NICK_INFO_NO_EXPIRE
	‚±‚ÌƒjƒbƒN‚Ì“o˜^‚ÍØ‚ê‚Ü‚¹‚ñB
NICK_INFO_SUSPEND_DETAILS
	‚±‚ÌƒjƒbƒN‚Í %s ‚É‚æ‚èŽg—p’âŽ~’†‚Å‚·B
	’âŽ~“úŽžF%si%sj
NICK_INFO_SUSPEND_REASON
	’âŽ~——RF%s
NICK_INFO_SHOW_ALL
	Ú×î•ñ‚ðŒ©‚éê‡‚ÍAu/msg %s INFO %s ALLv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B

# LIST‰ž“š
NICK_LIST_SYNTAX
	LIST ƒpƒ^[ƒ“
NICK_LIST_SERVADMIN_SYNTAX
	LIST ƒpƒ^[ƒ“ [FORBIDDEN] [NOEXPIRE] [SUSPENDED]
NICK_LIST_HEADER
	%s ‚Éˆê’v‚·‚éƒjƒbƒNF
NICK_LIST_RESULTS
	LIST I—¹i%d/%dŒÂjB

# RECOVER‰ž“š
NICK_RECOVER_SYNTAX
	RECOVER ƒjƒbƒN [ƒpƒXƒ[ƒh]
NICK_NO_RECOVER_SELF
	Ž©•ª‚ðƒŠƒJƒo[‚Å‚«‚Ü‚¹‚ñB
NICK_RECOVERED
	ƒjƒbƒN‚ðŽg—p‚µ‚Ä‚¢‚½ƒ†[ƒU‚ðØ’f‚µ‚Ü‚µ‚½B
	‚P•ªŠÔ‚Ìƒ^ƒCƒƒAƒEƒg‚ªŒo‚Â‘O‚ÉƒjƒbƒN‚ðŽg—p‚µ‚½‚¢ê‡‚ÍA
	u/msg %s RELEASE %sv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B

# RELEASE‰ž“š
NICK_RELEASE_SYNTAX
	RELEASE ƒjƒbƒN [ƒpƒXƒ[ƒh]
NICK_RELEASE_NOT_HELD
	%s ‚Í•Û—¯‚³‚ê‚Ä‚¢‚Ü‚¹‚ñB
NICK_RELEASED
	%s ‚ð‰ð•ú‚µ‚Ü‚µ‚½B

# GHOST‰ž“š
NICK_GHOST_SYNTAX
	GHOST ƒjƒbƒN [ƒpƒXƒ[ƒh]
NICK_NO_GHOST_SELF
	Ž©•ª‚ðØ’f‚Å‚«‚Ü‚¹‚ñB
NICK_GHOST_KILLED
	%s ‚ÌƒS[ƒXƒg‚ðØ’f‚µ‚Ü‚µ‚½B

# GETPASS‰ž“š
NICK_GETPASS_SYNTAX
	GETPASS ƒjƒbƒN
NICK_GETPASS_UNAVAILABLE
	ƒpƒXƒ[ƒh‚ÍˆÃ†‰»‚³‚ê‚Ä‚¢‚Ü‚·‚Ì‚Å GETPASS ‚ÍŽg—p‚Å‚«‚Ü‚¹‚ñB
NICK_GETPASS_PASSWORD_IS
	%s ‚ÌƒpƒXƒ[ƒh‚Í %s ‚Å‚·B

# FORBID‰ž“š
NICK_FORBID_SYNTAX
	FORBID ƒjƒbƒN
NICK_FORBID_SUCCEEDED
	%s ‚ðŽg—p‹ÖŽ~‚É‚µ‚Ü‚µ‚½B
NICK_FORBID_FAILED
	%s ‚ðŽg—p‹ÖŽ~‚É‚·‚é‚Ì‚ªŽ¸”s‚µ‚Ü‚µ‚½B

# SUSPEND responses
NICK_SUSPEND_SYNTAX
	SUSPEND [+ŠúŒÀ] ƒjƒbƒN ——R
NICK_SUSPEND_SUCCEEDED
	%s ‹y‚Ñ‚»‚ê‚ÉƒŠƒ“ƒN‚³‚ê‚Ä‚¢‚é‘S‚Ä‚ÌƒjƒbƒN‚ðŽg—p’âŽ~‚É‚µ‚Ü‚µ‚½B
NICK_SUSPEND_ALREADY_SUSPENDED
	%s ‚ÍŠù‚ÉŽg—p’âŽ~‚É‚È‚Á‚Ä‚¢‚Ü‚·B

# UNSUSPEND responses
NICK_UNSUSPEND_SYNTAX
	UNSUSPEND ƒjƒbƒN
NICK_UNSUSPEND_SUCCEEDED
	%s ‚ÌŽg—p’âŽ~‚ð‰ðœ‚µ‚Ü‚µ‚½B
NICK_SUSPEND_NOT_SUSPENDED
	%s ‚ÍŽg—p’âŽ~‚É‚È‚Á‚Ä‚¢‚Ü‚¹‚ñB

###########################################################################
#
# ChanServ messages
#
###########################################################################

# ƒAƒNƒZƒXƒŒƒxƒ‹‚Ìà–¾•¶
CHAN_LEVEL_AUTOOP
	ƒ`ƒƒƒ“ƒlƒ‹‚É“ü‚é‚Æ +o ƒ‚[ƒh
CHAN_LEVEL_AUTOVOICE
	ƒ`ƒƒƒ“ƒlƒ‹‚É“ü‚é‚Æ +v ƒ‚[ƒh
CHAN_LEVEL_AUTODEOP
	+o ƒ‚[ƒh‹ÖŽ~
CHAN_LEVEL_AUTODEOP_HALFOP
	+oA+h ƒ‚[ƒh‹ÖŽ~
CHAN_LEVEL_NOJOIN
	RESTRICTED ‚Å‚ ‚ê‚Îƒ`ƒƒƒ“ƒlƒ‹‚É“ü‚ê‚È‚¢
CHAN_LEVEL_INVITE
	INVITE ƒRƒ}ƒ“ƒh‚ªŽg‚¦‚é
CHAN_LEVEL_AKICK
	AKICK ƒRƒ}ƒ“ƒh‚ªŽg‚¦‚é
CHAN_LEVEL_SET
	SETiFOUNDEREPASSWORD ˆÈŠOj‚ªŽg‚¦‚é
CHAN_LEVEL_CLEAR
	CLEAR ƒRƒ}ƒ“ƒh‚ªŽg‚¦‚é
CHAN_LEVEL_UNBAN
	UNBAN ƒRƒ}ƒ“ƒh‚ªŽg‚¦‚é
CHAN_LEVEL_OPDEOP
	OPEDEOP ƒRƒ}ƒ“ƒh‚ªŽg‚¦‚é
CHAN_LEVEL_ACCESS_LIST
	ƒAƒNƒZƒXˆê——‚ð•\Ž¦‚Å‚«‚é
CHAN_LEVEL_ACCESS_CHANGE
	ƒAƒNƒZƒXˆê——‚ð•ÏX‚Å‚«‚é
CHAN_LEVEL_MEMO
	ƒƒ‚‚ð“Ç‚ß‚é
CHAN_LEVEL_VOICE
	VOICEEDEVOICE ƒRƒ}ƒ“ƒh‚ªŽg‚¦‚é
CHAN_LEVEL_AUTOHALFOP
	ƒ`ƒƒƒ“ƒlƒ‹‚É“ü‚é‚Æ +h ƒ‚[ƒh
CHAN_LEVEL_HALFOP
	HALFOPEDEHALFOP ƒRƒ}ƒ“ƒh‚ªŽg‚¦‚é

# Ž©“®ƒƒbƒZ[ƒW
CHAN_IS_REGISTERED
	‚±‚Ìƒ`ƒƒƒ“ƒlƒ‹‚Í“o˜^‚³‚ê‚Ä‚¢‚Ü‚·B
CHAN_NOT_ALLOWED_OP
	%s ‚Å +o ƒ‚[ƒh‚É‚Í‚È‚ê‚Ü‚¹‚ñB
CHAN_MAY_NOT_BE_USED
	‚±‚Ìƒ`ƒƒƒ“ƒlƒ‹‚ÍŽg—p‹ÖŽ~‚Å‚·B
CHAN_NOT_ALLOWED_TO_JOIN
	‚±‚Ìƒ`ƒƒƒ“ƒlƒ‹‚É‚Í“ü‚ê‚Ü‚¹‚ñB

# ‘½—p‰ž“š
CHAN_BOUNCY_MODES
	‚»‚ÌƒRƒ}ƒ“ƒh‚ÍŒ»ÝŽg‚¦‚Ü‚¹‚ñB

# REGISTER‰ž“š
CHAN_REGISTER_SYNTAX
	REGISTER ƒ`ƒƒƒ“ƒlƒ‹ ƒpƒXƒ[ƒh à–¾
CHAN_REGISTER_DISABLED
	ƒ`ƒƒƒ“ƒlƒ‹‚Ì“o˜^‚Í‚½‚¾¡o—ˆ‚Ü‚¹‚ñB
CHAN_REGISTER_NOT_LOCAL
	ƒ[ƒJƒ‹ƒ`ƒƒƒ“ƒlƒ‹‚Ì“o˜^‚Ío—ˆ‚Ü‚¹‚ñB
CHAN_MUST_REGISTER_NICK
	ƒ`ƒƒƒ“ƒlƒ‹‚ð“o˜^‚·‚é‚É‚ÍA‚Ü‚¸ƒjƒbƒN‚ð“o˜^‚µ‚È‚¯‚ê‚Î‚È‚è‚Ü‚¹‚ñBƒjƒbƒN“o˜^î•ñ‚ðŒ©‚é‚É‚Íu/msg %s HELPv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B
CHAN_MUST_IDENTIFY_NICK
	ƒ`ƒƒƒ“ƒlƒ‹‚ð“o˜^‚·‚é‚É‚ÍAƒjƒbƒN‚ÌƒpƒXƒ[ƒh‚ð“ü—Í‚·‚é•K—v‚ª‚ ‚è‚Ü‚·Bu/msg %s IDENTIFY ƒpƒXƒ[ƒhv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B
CHAN_MAY_NOT_BE_REGISTERED
	%s ‚ÍŽg—p‹ÖŽ~‚Å‚·‚Ì‚Å“o˜^‚Å‚«‚Ü‚¹‚ñB
CHAN_ALREADY_REGISTERED
	%s ‚ÍŠù‚É“o˜^‚³‚ê‚Ä‚¢‚Ü‚·B
CHAN_MUST_BE_CHANOP
	ƒ`ƒƒƒ“ƒlƒ‹‚ð“o˜^‚·‚é‚É‚ÍA‚»‚ÌƒIƒyƒŒ[ƒ^‚Å‚È‚¯‚ê‚Î‚È‚è‚Ü‚¹‚ñB
CHAN_REACHED_CHANNEL_LIMIT
	ƒ`ƒƒƒ“ƒlƒ‹“o˜^”‚ÌãŒÀi%dj‚É’B‚µ‚Ä‚¢‚Ü‚·‚Ì‚Å“o˜^‚Å‚«‚Ü‚¹‚ñB
CHAN_EXCEEDED_CHANNEL_LIMIT
	ƒ`ƒƒƒ“ƒlƒ‹“o˜^”‚ÌãŒÀi%dj‚ð’´‚¦‚Ä‚¢‚Ü‚·‚Ì‚Å“o˜^‚Å‚«‚Ü‚¹‚ñB
CHAN_REGISTRATION_FAILED
	“o˜^‚ÍŽ¸”s‚µ‚Ü‚µ‚½B
CHAN_REGISTERED
	%s ‚ð“o˜^‚µ‚Ü‚µ‚½B
CHAN_PASSWORD_IS
	ƒ`ƒƒƒ“ƒlƒ‹‚ÌƒpƒXƒ[ƒh‚Í %s ‚Å‚·B–Y‚ê‚È‚¢‚æ‚¤‚É‚µ‚Ä‰º‚³‚¢B

# IDENTIFY‰ž“š
CHAN_IDENTIFY_SYNTAX
	IDENTIFY ƒ`ƒƒƒ“ƒlƒ‹ ƒpƒXƒ[ƒh
CHAN_IDENTIFY_FAILED
	IDENTIFY‚ÍŽ¸”s‚µ‚Ü‚µ‚½B
CHAN_IDENTIFY_SUCCEEDED
	³‚µ‚¢ƒpƒXƒ[ƒh‚Å‚·B

# DROP‰ž“š
CHAN_DROP_SYNTAX
	DROP ƒ`ƒƒƒ“ƒlƒ‹
CHAN_DROP_DISABLED
	ƒ`ƒƒƒ“ƒlƒ‹‚ÌÁ‹Ž‚Í‚½‚¾¡o—ˆ‚Ü‚¹‚ñB
CHAN_DROPPED
	%s ‚Ì“o˜^‚ðÁ‹Ž‚µ‚Ü‚µ‚½B

# SET‰ž“š
CHAN_SET_SYNTAX
	SET ƒ`ƒƒƒ“ƒlƒ‹ ƒIƒvƒVƒ‡ƒ“ ƒpƒ‰ƒ[ƒ^
CHAN_SET_DISABLED
	ƒ`ƒƒƒ“ƒlƒ‹‚ÌƒIƒvƒVƒ‡ƒ“Ý’è‚Í‚½‚¾¡o—ˆ‚Ü‚¹‚ñB
CHAN_SET_UNKNOWN_OPTION
	%s ‚Æ‚¢‚¤ƒIƒvƒVƒ‡ƒ“‚Í‚ ‚è‚Ü‚¹‚ñB

# SET FOUNDER‰ž“š
CHAN_SET_FOUNDER_TOO_MANY_CHANS
	%s ‚Íƒ`ƒƒƒ“ƒlƒ‹“o˜^”‚ÌãŒÀ‚ð‰z‚¦‚Ä‚¢‚Ü‚·‚Ì‚Åƒtƒ@ƒEƒ“ƒ_[‚ÉÝ’è‚Å‚«‚Ü‚¹‚ñB
CHAN_FOUNDER_CHANGED
	%s ‚Ìƒtƒ@ƒEƒ“ƒ_[‚ð %s ‚É•ÏX‚µ‚Ü‚µ‚½B

# SET SUCCESSOR‰ž“š
#@@@: uŽŸŠúƒtƒ@ƒEƒ“ƒ_[vH (also see UNSET)
CHAN_SUCCESSOR_CHANGED
	%s ‚ÌŽŸŠúƒtƒ@ƒEƒ“ƒ_[‚ð %s ‚É•ÏX‚µ‚Ü‚µ‚½B
CHAN_SUCCESSOR_IS_FOUNDER
	ƒtƒ@ƒEƒ“ƒ_‚ÆŽŸŠúƒtƒ@ƒEƒ“ƒ_—¼•û‚É“¯‚¶ƒjƒbƒN‚ðÝ’è‚·‚é‚±‚Æ‚Í‚Å‚«‚Ü‚¹‚ñB

# SET PASSWORD‰ž“š
CHAN_SET_PASSWORD_FAILED
	ƒpƒXƒ[ƒh‚Ì•ÏX‚ÍŽ¸”s‚µ‚Ü‚µ‚½B
CHAN_PASSWORD_CHANGED
	%s ‚ÌƒpƒXƒ[ƒh‚ð•ÏX‚µ‚Ü‚µ‚½B
CHAN_PASSWORD_CHANGED_TO
	%s ‚ÌƒpƒXƒ[ƒh‚ð %s ‚É•ÏX‚µ‚Ü‚µ‚½B

# SET DESC‰ž“š
CHAN_DESC_CHANGED
	%s ‚Ìà–¾‚Íu%sv‚É•ÏX‚µ‚Ü‚µ‚½B

# SET URL‰ž“š
CHAN_URL_CHANGED
	%s ‚Ìƒz[ƒƒy[ƒW‚ÌƒAƒhƒŒƒX‚ð %s ‚ÉÝ’è‚µ‚Ü‚µ‚½B

# SET EMAIL‰ž“š
CHAN_EMAIL_CHANGED
	%s ‚Ì“dŽqƒ[ƒ‹‚ÌƒAƒhƒŒƒX‚ð %s ‚ÉÝ’è‚µ‚Ü‚µ‚½B

# SET ENTRYMSG‰ž“š
CHAN_ENTRY_MSG_CHANGED
	%s ‚Ì‰Á“üŽžƒƒbƒZ[ƒW‚ðÝ’è‚µ‚Ü‚µ‚½B

# SET TOPIC‰ž“š
CHAN_SET_TOPIC_FAILED
	ƒgƒsƒbƒN‚Ì•ÏX‚ÍŽ¸”s‚µ‚Ü‚µ‚½B

# SET MLOCK‰ž“š
CHAN_SET_MLOCK_KEY_REQUIRED
	ƒ‚[ƒhƒƒbƒN +k ‚É‚Íƒpƒ‰ƒ[ƒ^‚ª•K—v‚Å‚·B
CHAN_SET_MLOCK_LIMIT_REQUIRED
	ƒ‚[ƒhƒƒbƒN +l ‚É‚Íƒpƒ‰ƒ[ƒ^‚ª•K—v‚Å‚·B
CHAN_SET_MLOCK_LIMIT_POSITIVE
	ƒ‚[ƒhƒƒbƒN +l ‚É‚Í³”‚Ìƒpƒ‰ƒ[ƒ^‚ª•K—v‚Å‚·B
CHAN_SET_MLOCK_UNKNOWN_CHAR
	%c ‚Æ‚¢‚¤ƒ‚[ƒh‚Í•ª‚©‚è‚Ü‚¹‚ñB
CHAN_MLOCK_CHANGED
	%s ‚Ìƒ‚[ƒhƒƒbƒN‚ð %s ‚ÉÝ’è‚µ‚Ü‚µ‚½B
CHAN_MLOCK_REMOVED
	%s ‚Ìƒ‚[ƒhƒƒbƒN‚ð‰ðœ‚µ‚Ü‚µ‚½B

# SET KEEPTOPIC‰ž“š
CHAN_SET_KEEPTOPIC_SYNTAX
	SET ƒ`ƒƒƒ“ƒlƒ‹ KEEPTOPIC {ON | OFF}
CHAN_SET_KEEPTOPIC_ON
	ƒgƒsƒbƒN‹L˜^Ý’è‚ð—LŒø‚ÉÝ’è‚µ‚Ü‚µ‚½B
CHAN_SET_KEEPTOPIC_OFF
	ƒgƒsƒbƒN‹L˜^Ý’è‚ð–³Œø‚ÉÝ’è‚µ‚Ü‚µ‚½B

# SET TOPICLOCK‰ž“š
CHAN_SET_TOPICLOCK_SYNTAX
	SET channel TOPICLOCK {ON | OFF}
CHAN_SET_TOPICLOCK_ON
	ƒgƒsƒbƒNƒƒbƒNÝ’è‚ð—LŒø‚ÉÝ’è‚µ‚Ü‚µ‚½B
CHAN_SET_TOPICLOCK_OFF
	ƒgƒsƒbƒNƒƒbƒNÝ’è‚ð–³Œø‚ÉÝ’è‚µ‚Ü‚µ‚½B

# SET PRIVATE‰ž“š
CHAN_SET_PRIVATE_SYNTAX
	SET channel PRIVATE {ON | OFF}
CHAN_SET_PRIVATE_ON
	ƒvƒ‰ƒCƒx[ƒgÝ’è‚ð—LŒø‚ÉÝ’è‚µ‚Ü‚µ‚½B
CHAN_SET_PRIVATE_OFF
	ƒvƒ‰ƒCƒx[ƒgÝ’è‚ð–³Œø‚ÉÝ’è‚µ‚Ü‚µ‚½B

# SET SECUREOPS‰ž“š
CHAN_SET_SECUREOPS_SYNTAX
	SET channel SECUREOPS {ON | OFF}
CHAN_SET_SECUREOPS_ON
	+o ƒ‚[ƒh§ŒÀÝ’è‚ð—LŒø‚ÉÝ’è‚µ‚Ü‚µ‚½B
CHAN_SET_SECUREOPS_OFF
	+o ƒ‚[ƒh§ŒÀÝ’è‚ð–³Œø‚ÉÝ’è‚µ‚Ü‚µ‚½B

# SET LEAVEOPS‰ž“š
CHAN_SET_LEAVEOPS_SYNTAX
	SET channel LEAVEOPS {ON | OFF}
CHAN_SET_LEAVEOPS_ON
	+o ƒ‚[ƒh•ú’uÝ’è‚ð—LŒø‚ÉÝ’è‚µ‚Ü‚µ‚½B
CHAN_SET_LEAVEOPS_OFF
	+o ƒ‚[ƒh•ú’uÝ’è‚ð–³Œø‚ÉÝ’è‚µ‚Ü‚µ‚½B

# SET RESTRICTED‰ž“š
CHAN_SET_RESTRICTED_SYNTAX
	SET channel RESTRICTED {ON | OFF}
CHAN_SET_RESTRICTED_ON
	ƒAƒNƒZƒX§ŒÀÝ’è‚ð—LŒø‚ÉÝ’è‚µ‚Ü‚µ‚½B
CHAN_SET_RESTRICTED_OFF
	ƒAƒNƒZƒX§ŒÀÝ’è‚ð–³Œø‚ÉÝ’è‚µ‚Ü‚µ‚½B

# SET SECURE‰ž“š
CHAN_SET_SECURE_SYNTAX
	SET channel SECURE {ON | OFF}
CHAN_SET_SECURE_ON
	ƒZƒLƒ…ƒAÝ’è‚ð—LŒø‚ÉÝ’è‚µ‚Ü‚µ‚½B
CHAN_SET_SECURE_OFF
	ƒZƒLƒ…ƒAÝ’è‚ð–³Œø‚ÉÝ’è‚µ‚Ü‚µ‚½B

# SET OPNOTICE‰ž“š
CHAN_SET_OPNOTICE_SYNTAX
	SET channel OPNOTICE {ON | OFF}
CHAN_SET_OPNOTICE_ON
	OP Žü’mÝ’è‚ð—LŒø‚ÉÝ’è‚µ‚Ü‚µ‚½B
CHAN_SET_OPNOTICE_OFF
	OP Žü’mÝ’è‚ð–³Œø‚ÉÝ’è‚µ‚Ü‚µ‚½B

# SET NOEXPIRE‰ž“š
CHAN_SET_NOEXPIRE_SYNTAX
	SET channel NOEXPIRE {ON | OFF}
CHAN_SET_NOEXPIRE_ON
	%s ‚Æ‚¢‚¤ƒ`ƒƒƒ“ƒlƒ‹‚Ì“o˜^‚ÍØ‚ê‚Ü‚¹‚ñB
CHAN_SET_NOEXPIRE_OFF
	%s ‚Æ‚¢‚¤ƒ`ƒƒƒ“ƒlƒ‹‚Ì“o˜^‚ÍØ‚ê‚Ü‚·B

# UNSET responses
CHAN_SUCCESSOR_UNSET
	%s ‚ÌŽŸŠúƒtƒ@ƒEƒ“ƒ_[Ý’è‚ð‰ðœ‚µ‚Ü‚µ‚½B
CHAN_URL_UNSET
	%s ‚Ìƒz[ƒƒy[ƒWƒAƒhƒŒƒX‚ðÁ‹Ž‚µ‚Ü‚µ‚½B
CHAN_EMAIL_UNSET
	%s ‚Ì“dŽqƒ[ƒ‹ƒAƒhƒŒƒX‚ðÁ‹Ž‚µ‚Ü‚µ‚½B
CHAN_ENTRY_MSG_UNSET
	%s ‚Ì‰Á“üŽžƒƒbƒZ[ƒW‚ðÁ‹Ž‚µ‚Ü‚µ‚½B

# ACCESS messages
CHAN_ACCESS_SYNTAX
	ACCESS ƒ`ƒƒƒ“ƒlƒ‹ {ADD|DEL|LIST} [ƒjƒbƒN [ƒŒƒxƒ‹] | ƒGƒ“ƒgƒŠ”Ô†]
CHAN_ACCESS_DISABLED
	ƒAƒNƒZƒXˆê——‚Ì•ÏX‚Í‚½‚¾¡•s‰Â”\‚Å‚·B
CHAN_ACCESS_LEVEL_NONZERO
	ƒAƒNƒZƒXƒŒƒxƒ‹‚Íƒ[ƒ‚ÉÝ’è‚Å‚«‚Ü‚¹‚ñB
CHAN_ACCESS_LEVEL_RANGE
	ƒAƒNƒZƒXƒŒƒxƒ‹‚Ì‹–—e”ÍˆÍ‚ÍA%d`%d‚Å‚·B
CHAN_ACCESS_NICKS_ONLY
	ƒAƒNƒZƒXˆê——‚É’Ç‰Á‚Å‚«‚é‚Ì‚Í“o˜^‚³‚ê‚½ƒjƒbƒN‚Ì‚Ý‚Å‚·B
CHAN_ACCESS_REACHED_LIMIT
	ƒAƒNƒZƒXˆê——‚ÌƒjƒbƒN”‚ÍãŒÀi%dj‚É’B‚µ‚Ä‚¢‚Ü‚·‚Ì‚Å’Ç‰Á‚Å‚«‚Ü‚¹‚ñB
CHAN_ACCESS_LEVEL_UNCHANGED
	%s ‚Ì %s ‚Å‚ÌƒAƒNƒZƒXƒŒƒxƒ‹‚Í‚·‚Å‚É %d ‚Æ‚È‚Á‚Ä‚¢‚Ü‚·B
CHAN_ACCESS_LEVEL_CHANGED
	%s ‚Ì %s ‚Å‚ÌƒAƒNƒZƒXƒŒƒxƒ‹‚ð %d ‚É•ÏX‚µ‚Ü‚µ‚½B
CHAN_ACCESS_ADDED
	%s ‚ð %s ‚ÌƒAƒNƒZƒXˆê——‚ÉAƒŒƒxƒ‹ %d ‚Å’Ç‰Á‚µ‚Ü‚µ‚½B
CHAN_ACCESS_NO_SUCH_ENTRY
	%d ”Ô‚ÌƒGƒ“ƒgƒŠ[‚Í %s ‚ÌƒAƒNƒZƒXˆê——‚É‘¶Ý‚µ‚Ü‚¹‚ñB
CHAN_ACCESS_NO_MATCH
	%s ‚Éˆê’v‚·‚éƒGƒ“ƒgƒŠ[‚Í %s ‚ÌƒAƒNƒZƒXˆê——‚É‘¶Ý‚µ‚Ü‚¹‚ñB
CHAN_ACCESS_NOT_FOUND
	%s ‚Í %s ‚ÌƒAƒNƒZƒXˆê——‚É‘¶Ý‚µ‚Ü‚¹‚ñB
CHAN_ACCESS_DELETED
	%s ‚ð %s ‚ÌƒAƒNƒZƒXˆê——‚©‚çÁ‹Ž‚µ‚Ü‚µ‚½B
CHAN_ACCESS_DELETED_ONE
	%s ‚ÌƒAƒNƒZƒXˆê——‚©‚çƒGƒ“ƒgƒŠ[‚ð 1 ŒÂÁ‹Ž‚µ‚Ü‚µ‚½B
CHAN_ACCESS_DELETED_SEVERAL
	%s ‚ÌƒAƒNƒZƒXˆê——‚©‚çƒGƒ“ƒgƒŠ[‚ð %d ŒÂÁ‹Ž‚µ‚Ü‚µ‚½B
CHAN_ACCESS_LIST_EMPTY
	%s ‚ÌƒAƒNƒZƒXˆê——‚Í‹ó‚Å‚·B
CHAN_ACCESS_LIST_HEADER
	%s ‚ÌƒAƒNƒZƒXˆê——F

# AKICK‰ž“š
CHAN_AKICK_SYNTAX
	AKICK ƒ`ƒƒƒ“ƒlƒ‹ {ADD | DEL | LIST} [ƒjƒbƒNEƒ}ƒXƒN]
CHAN_AKICK_DISABLED
	Ž©“®ƒLƒbƒNˆê——‚Ì•ÏX‚Í‚½‚¾¡‚Å‚«‚Ü‚¹‚ñB
CHAN_AKICK_ALREADY_EXISTS
	%s ‚ÍŠù‚É %s ‚ÌŽ©“®ƒLƒbƒNˆê——‚É‘¶Ý‚µ‚Ä‚¢‚Ü‚·B
CHAN_AKICK_REACHED_LIMIT
	Ž©“®ƒLƒbƒNˆê——‚Ìƒ}ƒXƒN”‚ÍãŒÀi%dj‚É’B‚µ‚Ä‚¢‚Ü‚·‚Ì‚Å’Ç‰Á‚Å‚«‚Ü‚¹‚ñB
CHAN_AKICK_ADDED
	%s ‚ð %s ‚ÌŽ©“®ƒLƒbƒNˆê——‚É’Ç‰Á‚µ‚Ü‚µ‚½B
CHAN_AKICK_NO_SUCH_ENTRY
	%d ”Ô‚ÌƒGƒ“ƒgƒŠ[‚Í %s ‚ÌŽ©“®ƒLƒbƒNˆê——‚Å‘¶Ý‚µ‚Ü‚¹‚ñB
CHAN_AKICK_NO_MATCH
	%s ‚Éˆê’v‚·‚éƒGƒ“ƒgƒŠ[‚Í %s ‚ÌŽ©“®ƒLƒbƒNˆê——‚Å‘¶Ý‚µ‚Ü‚¹‚ñB
CHAN_AKICK_NOT_FOUND
	%s ‚Í %s ‚ÌŽ©“®ƒLƒbƒNˆê——‚Å‘¶Ý‚µ‚Ü‚¹‚ñB
CHAN_AKICK_DELETED
	%s ‚ð %s ‚ÌŽ©“®ƒLƒbƒNˆê——‚©‚çÁ‹Ž‚µ‚Ü‚µ‚½B
CHAN_AKICK_DELETED_ONE
	%s ‚ÌŽ©“®ƒLƒbƒNˆê——‚©‚çƒGƒ“ƒgƒŠ[‚ð 1 ŒÂÁ‹Ž‚µ‚Ü‚µ‚½B
CHAN_AKICK_DELETED_SEVERAL
	%s ‚ÌŽ©“®ƒLƒbƒNˆê——‚©‚çƒGƒ“ƒgƒŠ[‚ð %d ŒÂÁ‹Ž‚µ‚Ü‚µ‚½B
CHAN_AKICK_LIST_EMPTY
	%s ‚ÌŽ©“®ƒLƒbƒNˆê——‚Í‹ó‚Å‚·B
CHAN_AKICK_LIST_HEADER
	%s‚ÌŽ©“®ƒLƒbƒNˆê——F
CHAN_AKICK_LIST_FORMAT
	  %3d %s%s

# LEVELS‰ž“š
CHAN_LEVELS_SYNTAX
	LEVELS ƒ`ƒƒƒ“ƒlƒ‹ {SET | DIS[ABLE] | LIST | RESET} [–Ú [ƒŒƒxƒ‹]]
CHAN_LEVELS_RANGE
	ƒŒƒxƒ‹‚ÍA%d`%d ‚Ì”’l‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B
CHAN_LEVELS_CHANGED
	%s ‚ÌƒŒƒxƒ‹‚ð %s ‚Å %d ‚É•ÏX‚µ‚Ü‚µ‚½B
CHAN_LEVELS_UNKNOWN
	%s ‚Æ‚¢‚¤–Ú‚Í‚ ‚è‚Ü‚¹‚ñB–Úˆê——‚ðŒ©‚éê‡‚ÍAu/msg %s HELP LEVELS DESCv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B
CHAN_LEVELS_DISABLED
	%s ‚ð %s ‚Å–³Œø‚É‚µ‚Ü‚µ‚½B
CHAN_LEVELS_LIST_HEADER
	%s ‚ÌƒŒƒxƒ‹ˆê——F
CHAN_LEVELS_LIST_DISABLED
	    %-*s  –³Œø
CHAN_LEVELS_LIST_FOUNDER
	    %-*s  ƒtƒ@ƒEƒ“ƒ_[‚Ì‚Ý
CHAN_LEVELS_LIST_NORMAL
	    %-*s  %d
CHAN_LEVELS_RESET
	%s ‚ÌƒŒƒxƒ‹•\‚ðŠù’è’l‚É–ß‚µ‚Ü‚µ‚½B

# INFO‰ž“š
CHAN_INFO_SYNTAX
	INFO channel
CHAN_INFO_HEADER
	%s‚Ìî•ñF
CHAN_INFO_FOUNDER
	@@@ƒtƒ@ƒEƒ“ƒ_[F%s (%s)
CHAN_INFO_NO_FOUNDER
	@@@ƒtƒ@ƒEƒ“ƒ_[F%s
CHAN_INFO_DESCRIPTION
	@@@@@@@à–¾F%s
CHAN_INFO_TIME_REGGED
	@@@@@“o˜^“úŽžF%s
CHAN_INFO_LAST_USED
	@@@‘O‰ñŽg—p“úŽžF%s
CHAN_INFO_LAST_TOPIC
	@@‘O‰ñ‚ÌƒgƒsƒbƒNF%s
CHAN_INFO_TOPIC_SET_BY
	@ƒgƒsƒbƒN‚ÌÝ’èŽÒF%s
CHAN_INFO_URL
	@@@ƒz[ƒƒy[ƒWF%s
CHAN_INFO_EMAIL
	“dŽqƒ[ƒ‹ƒAƒhƒŒƒXF%s
CHAN_INFO_OPTIONS
	@@@@ƒIƒvƒVƒ‡ƒ“F%s
CHAN_INFO_OPT_PRIVATE
	ƒvƒ‰ƒCƒx[ƒg
CHAN_INFO_OPT_KEEPTOPIC
	ƒgƒsƒbƒN‹L˜^
CHAN_INFO_OPT_TOPICLOCK
	ƒgƒsƒbƒNƒƒbƒN
CHAN_INFO_OPT_SECUREOPS
	+o ƒ‚[ƒh§ŒÀ
CHAN_INFO_OPT_LEAVEOPS
	+o ƒ‚[ƒh•ú’u
CHAN_INFO_OPT_RESTRICTED
	ƒAƒNƒZƒX§ŒÀ
CHAN_INFO_OPT_SECURE
	ƒZƒLƒ…ƒA
CHAN_INFO_OPT_NONE
	–³‚µ
CHAN_INFO_MODE_LOCK
	@@@ƒ‚[ƒhƒƒbƒNF%s

# LIST‰ž“š
CHAN_LIST_SYNTAX
	LIST ƒpƒ^[ƒ“
CHAN_LIST_HEADER
	%s ‚Éˆê’v‚·‚éƒ`ƒƒƒ“ƒlƒ‹F
CHAN_LIST_FORMAT
	    %-20s  %s
CHAN_LIST_END
	LIST I—¹B

# INVITE‰ž“š
CHAN_INVITE_SYNTAX
	INVITE ƒ`ƒƒƒ“ƒlƒ‹

# OP/DEOP/VOICE/DEVOICE‰ž“š
CHAN_OPVOICE_SYNTAX
	%s ƒ`ƒƒƒ“ƒlƒ‹ ƒjƒbƒN

# UNBAN‰ž“š
CHAN_UNBAN_SYNTAX
	UNBAN ƒ`ƒƒƒ“ƒlƒ‹
CHAN_UNBANNED
	‚ ‚È‚½‚É‘Î‚·‚é %s ‚Ì’Ç•úƒ}ƒXƒN‚ðÁ‹Ž‚µ‚Ü‚µ‚½B

# CLEAR‰ž“š
CHAN_CLEAR_SYNTAX
	CLEAR ƒ`ƒƒƒ“ƒlƒ‹ –Ú
CHAN_CLEARED_BANS
	%s ‚Ì’Ç•úƒ}ƒXƒN‚ð‘S‚ÄÁ‹Ž‚µ‚Ü‚µ‚½B
CHAN_CLEARED_MODES
	%s ‚Ìƒ‚[ƒh‚ðŠù’è’l‚É–ß‚µ‚Ü‚µ‚½B
CHAN_CLEARED_OPS
	+o ƒ‚[ƒh‚ð %s ‚©‚çÁ‹Ž‚µ‚Ü‚µ‚½B
CHAN_CLEARED_VOICES
	+v ƒ‚[ƒh‚ð %s ‚©‚çÁ‹Ž‚µ‚Ü‚µ‚½B
CHAN_CLEARED_USERS
	%s ‚Ìƒ†[ƒU‚ð‘S‚ÄƒLƒbƒN‚µ‚Ü‚µ‚½B

# GETPASS‰ž“š
CHAN_GETPASS_SYNTAX
	GETPASS ƒ`ƒƒƒ“ƒlƒ‹
CHAN_GETPASS_UNAVAILABLE
	ƒpƒXƒ[ƒh‚ÍˆÃ†‰»‚³‚ê‚Ä‚¢‚Ü‚·‚Ì‚Å GETPASS ‚ÍŽg—p‚Å‚«‚Ü‚¹‚ñB
CHAN_GETPASS_PASSWORD_IS
	%s ‚ÌƒpƒXƒ[ƒh‚Í %s ‚Å‚·B

# FORBID‰ž“š
CHAN_FORBID_SYNTAX
	FORBID ƒ`ƒƒƒ“ƒlƒ‹
CHAN_FORBID_SUCCEEDED
	%s ‚ðŽg—p‹ÖŽ~‚É‚µ‚Ü‚µ‚½B
CHAN_FORBID_FAILED
	%s ‚ðŽg—p‹ÖŽ~‚É‚·‚é‚Ì‚ªŽ¸”s‚µ‚Ü‚µ‚½B

###########################################################################
#
# MemoServ‚ÌƒƒbƒZ[ƒW
#
###########################################################################

# Ž©“®ƒƒbƒZ[ƒW
MEMO_HAVE_NEW_MEMO
	V’…ƒƒ‚‚ª 1 Œ‚ ‚è‚Ü‚·B
MEMO_HAVE_NEW_MEMOS
	V’…ƒƒ‚‚ª %d Œ‚ ‚è‚Ü‚·B
MEMO_TYPE_READ_LAST
	“Ç‚Þ‚É‚Íu/msg %s READ LASTv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B
MEMO_TYPE_READ_NUM
	“Ç‚Þ‚É‚Íu/msg %s READ %dv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B
MEMO_TYPE_LIST_NEW
	•\Ž¦‚·‚é‚É‚Íu/msg %s LIST NEWv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B
MEMO_AT_LIMIT
	’ˆÓFƒƒ‚”‚ÌãŒÀi%dj‚É’B‚µ‚Ä‚¢‚Ü‚·Bƒƒ‚‚ðÁ‹Ž‚·‚é‚Ü‚ÅV‚½‚Èƒƒ‚‚Í“Í‚«‚Ü‚¹‚ñB
MEMO_OVER_LIMIT
	’ˆÓFƒƒ‚”‚ÌãŒÀi%dj‚ð’´‚¦‚Ä‚¢‚Ü‚·Bƒƒ‚‚ðÁ‹Ž‚·‚é‚Ü‚ÅV‚½‚Èƒƒ‚‚Í“Í‚«‚Ü‚¹‚ñB
MEMO_NEW_MEMO_ARRIVED
	%s ‚©‚çƒƒ‚‚ª“Í‚«‚Ü‚µ‚½B
	“Ç‚Þ‚É‚Íu/msg %s READ %dv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B

# ‘½—p‰ž“š
MEMO_HAVE_NO_MEMOS
	ƒƒ‚‚Í‚ ‚è‚Ü‚¹‚ñB
MEMO_X_HAS_NO_MEMOS
	%s ‚Íƒƒ‚‚ª‚ ‚è‚Ü‚¹‚ñB
MEMO_DOES_NOT_EXIST
	%d ”Ô‚Ìƒƒ‚‚Í‘¶Ý‚µ‚Ü‚¹‚ñB
MEMO_LIST_NOT_FOUND
	%s ‚Éˆê’v‚·‚éƒƒ‚‚Í‚ ‚è‚Ü‚¹‚ñB

# SEND‰ž“š
MEMO_SEND_SYNTAX
	SEND {ƒjƒbƒN | ƒ`ƒƒƒ“ƒlƒ‹} ƒeƒLƒXƒg
MEMO_SEND_DISABLED
	ƒƒ‚‚Ì‘—M‚Í‚½‚¾¡‚Å‚«‚Ü‚¹‚ñB
MEMO_SEND_PLEASE_WAIT
	SEND ƒRƒ}ƒ“ƒh‚ðÄ“ü—Í‚·‚é‘O‚É %d •b‚¨‘Ò‚¿‰º‚³‚¢B
MEMO_X_HAS_TOO_MANY_MEMOS
	%s ‚ÍŒ»Ýƒƒ‚‚ª‘½‚·‚¬‚Ü‚·‚Ì‚ÅV‚½‚Èƒƒ‚‚ðŽóM‚Å‚«‚Ü‚¹‚ñB
MEMO_X_GETS_NO_MEMOS
	%s ‚Íƒƒ‚‚ðŽóM‚Å‚«‚Ü‚¹‚ñB
MEMO_SENT
	%s ‚Éƒƒ‚‚ð‘—M‚µ‚Ü‚µ‚½B

# LIST‰ž“š
MEMO_LIST_SYNTAX
	LIST [ƒ`ƒƒƒ“ƒlƒ‹] [ƒŠƒXƒg | NEW]
MEMO_HAVE_NO_NEW_MEMOS
	V’…ƒƒ‚‚Í‚ ‚è‚Ü‚¹‚ñB
MEMO_X_HAS_NO_NEW_MEMOS
	%s ‚ÍV’…ƒƒ‚‚ª‚ ‚è‚Ü‚¹‚ñB
MEMO_LIST_MEMOS
	%s ‚Ìƒƒ‚ˆê——B“Ç‚Þ‚É‚Íu/msg %s READ numv
MEMO_LIST_NEW_MEMOS
	%s ‚ÌV’…ƒƒ‚ˆê——B“Ç‚Þ‚É‚Íu/msg %s READ numv
MEMO_LIST_CHAN_MEMOS
	%s ‚Ìƒƒ‚ˆê——B“Ç‚Þ‚É‚Íu/msg %s READ %s numv
MEMO_LIST_CHAN_NEW_MEMOS
	%s ‚ÌV’…ƒƒ‚ˆê——B“Ç‚Þ‚É‚Íu/msg %s READ %s numv
MEMO_LIST_HEADER
	 ”Ô†   ·ol            “úŽž
MEMO_LIST_FORMAT
	%c%4d   %-16s  %s

# READ‰ž“š
MEMO_READ_SYNTAX
	READ [ƒ`ƒƒƒ“ƒlƒ‹] {ƒŠƒXƒg | LAST | NEW}
MEMO_HEADER
	%d ”Ô‚Ìƒƒ‚i%sA%sjBÁ‹Ž‚·‚é‚É‚Íu/msg %s DEL %dv
MEMO_CHAN_HEADER
	%d ”Ô‚Ìƒƒ‚i%sA%sjBÁ‹Ž‚·‚é‚É‚Íu/msg %s DEL %s %dv
MEMO_TEXT
	%s

# DEL‰ž“š
MEMO_DEL_SYNTAX
	DEL [ƒ`ƒƒƒ“ƒlƒ‹] {”Ô† | ƒŠƒXƒg | ALL}
MEMO_DELETED_NONE
	“ü—Í‚µ‚½”Ô†‚Éˆê’v‚·‚éƒƒ‚‚Í‚ ‚è‚Ü‚¹‚ñB
MEMO_DELETED_ONE
	%d ”Ô‚Ìƒƒ‚‚ðÁ‹Ž‚µ‚Ü‚µ‚½B
MEMO_DELETED_SEVERAL
	ƒƒ‚‚ð %d ŒÁ‹Ž‚µ‚Ü‚µ‚½B
MEMO_DELETED_ALL
	ƒƒ‚‚ð‘S‚ÄÁ‹Ž‚µ‚Ü‚µ‚½B

# SET‰ž“š
MEMO_SET_SYNTAX
	SET ƒIƒvƒVƒ‡ƒ“ ƒpƒ‰ƒ[ƒ^
MEMO_SET_DISABLED
	ƒƒ‚‚ÌƒIƒvƒVƒ‡ƒ“Ý’è‚Í‚½‚¾¡‚Å‚«‚Ü‚¹‚ñB
MEMO_SET_UNKNOWN_OPTION
	%s ‚Æ‚¢‚¤ƒIƒvƒVƒ‡ƒ“‚Í‚ ‚è‚Ü‚¹‚ñB

# SET NOTIFY‰ž“š
MEMO_SET_NOTIFY_SYNTAX
	SET NOTIFY {ON | LOGON | NEW | OFF}
MEMO_SET_NOTIFY_ON
	%s ‚ÍƒƒOƒIƒ“‚·‚éŽž‚ÉV’…ƒƒ‚‚ª‚ ‚ê‚Î’m‚ç‚¹Aƒƒ‚‚ª“Í‚­Žž‚É‚à’m‚ç‚¹‚Ü‚·B
MEMO_SET_NOTIFY_LOGON
	%s ‚ÍƒƒOƒIƒ“‚·‚éŽž‚ÆIRC‚É–ß‚éŽž‚ÉAV’…ƒƒ‚‚ª‚ ‚ê‚Î’m‚ç‚¹‚Ü‚·B
MEMO_SET_NOTIFY_NEW
	%s ‚Íƒƒ‚‚ª“Í‚­Žž‚É’m‚ç‚¹‚Ü‚·B
MEMO_SET_NOTIFY_OFF
	%s ‚Íƒƒ‚‚Ì’m‚ç‚¹‚ð‚µ‚Ü‚¹‚ñB

# SET LIMIT‰ž“š
MEMO_SET_LIMIT_SYNTAX
	SET LIMIT [ƒ`ƒƒƒ“ƒlƒ‹] ãŒÀ
MEMO_SET_LIMIT_SERVADMIN_SYNTAX
	SET LIMIT [ƒjƒbƒN | ƒ`ƒƒƒ“ƒlƒ‹] {ãŒÀ | NONE} [HARD]
MEMO_SET_YOUR_LIMIT_FORBIDDEN
	ƒƒ‚”‚ÌãŒÀ‚ð•ÏX‚Å‚«‚Ü‚¹‚ñB
MEMO_SET_LIMIT_FORBIDDEN
	%s ‚Ìƒƒ‚”‚ÌãŒÀ‚ð•ÏX‚Å‚«‚Ü‚¹‚ñB
MEMO_SET_YOUR_LIMIT_TOO_HIGH
	ƒƒ‚”‚ÌãŒÀ‚ÍAƒ[ƒ‚© %d ˆÈ‰º‚Ì³”‚ÉÝ’è‚µ‚Ä‰º‚³‚¢B
MEMO_SET_LIMIT_TOO_HIGH
	%s ‚Ìƒƒ‚”‚ÌãŒÀ‚ÍAƒ[ƒ‚© %d ˆÈ‰º‚Ì³”‚ÉÝ’è‚µ‚Ä‰º‚³‚¢B
MEMO_SET_LIMIT_OVERFLOW
	ãŒÀ‚Í‘å‚«‚·‚¬‚Ü‚·‚Ì‚ÅA%d ‚Æ‚È‚è‚Ü‚·B
MEMO_SET_YOUR_LIMIT
	ƒƒ‚”‚ÌãŒÀ‚ð %d Œ‚ÉÝ’è‚µ‚Ü‚µ‚½B
MEMO_SET_YOUR_LIMIT_ZERO
	‚±‚ê‚©‚çƒƒ‚‚ðŽóM‚µ‚Ü‚¹‚ñB
MEMO_UNSET_YOUR_LIMIT
	ƒƒ‚”‚ÌãŒÀ‚ð–³ŒÀ‚ÉÝ’è‚µ‚Ü‚µ‚½B
MEMO_SET_LIMIT
	%s ‚Ìƒƒ‚”‚ÌãŒÀ‚ð %d Œ‚ÉÝ’è‚µ‚Ü‚µ‚½B
MEMO_SET_LIMIT_ZERO
	%s ‚Ìƒƒ‚”‚ÌãŒÀ‚ð 0 Œ‚ÉÝ’è‚µ‚Ü‚µ‚½B
MEMO_UNSET_LIMIT
	%s ‚Ìƒƒ‚”‚ÌãŒÀ‚Í–³ŒÀ‚ÉÝ’è‚µ‚Ü‚µ‚½B

# INFO‰ž“š
MEMO_INFO_SYNTAX
	INFO [ƒ`ƒƒƒ“ƒlƒ‹]
MEMO_INFO_SERVADMIN_SYNTAX
	INFO [ƒjƒbƒN | ƒ`ƒƒƒ“ƒlƒ‹]
MEMO_INFO_NO_MEMOS
	ƒƒ‚‚Í‚ ‚è‚Ü‚¹‚ñB
MEMO_INFO_MEMO
	ƒƒ‚‚ª 1 Œ‚ ‚è‚Ü‚·B
MEMO_INFO_MEMO_UNREAD
	ƒƒ‚‚ª 1 Œ‚ ‚èA–¢“Ç‚Å‚·B
MEMO_INFO_MEMOS
	ƒƒ‚‚ª %d Œ‚ ‚è‚Ü‚·B
MEMO_INFO_MEMOS_ONE_UNREAD
	ƒƒ‚‚ª %d Œ‚ ‚èA1 Œ‚Í–¢“Ç‚Å‚·B
MEMO_INFO_MEMOS_SOME_UNREAD
	ƒƒ‚‚ª %d Œ‚ ‚èA%d Œ‚Í–¢“Ç‚Å‚·B
MEMO_INFO_MEMOS_ALL_UNREAD
	ƒƒ‚‚ª %d Œ‚ ‚èA‘S‚Ä–¢“Ç‚Å‚·B
MEMO_INFO_LIMIT
	ƒƒ‚”‚ÌãŒÀ‚Í %d Œ‚Å‚·B
MEMO_INFO_HARD_LIMIT
	ƒƒ‚”‚ÌãŒÀ‚Í %d Œ‚ÅA•ÏX‚Å‚«‚Ü‚¹‚ñB
MEMO_INFO_LIMIT_ZERO
	ƒƒ‚”‚ÌãŒÀ‚Í 0 Œ‚ÅAƒƒ‚‚ðŽóM‚Å‚«‚Ü‚¹‚ñB
MEMO_INFO_HARD_LIMIT_ZERO
	ƒƒ‚”‚ÌãŒÀ‚Í 0 Œ‚ÅAƒƒ‚‚ðŽóM‚Å‚«‚Ü‚¹‚ñB‚Ü‚½AãŒÀ‚ð•ÏX‚Å‚«‚Ü‚¹‚ñB
MEMO_INFO_NO_LIMIT
	ƒƒ‚”‚ÌãŒÀ‚Í‚ ‚è‚Ü‚¹‚ñB
MEMO_INFO_X_NO_MEMOS
	%s ‚Íƒƒ‚‚ª‚ ‚è‚Ü‚¹‚ñB
MEMO_INFO_X_MEMO
	%s ‚Íƒƒ‚‚ª 1 Œ‚ ‚è‚Ü‚·B
MEMO_INFO_X_MEMO_UNREAD
	%s ‚Íƒƒ‚‚ª 1 Œ‚ ‚èA–¢“Ç‚Å‚·B
MEMO_INFO_X_MEMOS
	%s ‚Íƒƒ‚‚ª %d Œ‚ ‚è‚Ü‚·B
MEMO_INFO_X_MEMOS_ONE_UNREAD
	%s ‚Íƒƒ‚‚ª %d Œ‚ ‚èA1 Œ‚Í–¢“Ç‚Å‚·B
MEMO_INFO_X_MEMOS_SOME_UNREAD
	%s ‚Íƒƒ‚‚ª %d Œ‚ ‚èA%d Œ‚Í–¢“Ç‚Å‚·B
MEMO_INFO_X_MEMOS_ALL_UNREAD
	%s ‚Íƒƒ‚‚ª %d Œ‚ ‚èA‘S‚Ä–¢“Ç‚Å‚·B
MEMO_INFO_X_LIMIT
	%s ‚Ìƒƒ‚”‚ÌãŒÀ‚Í %d Œ‚Å‚·B
MEMO_INFO_X_HARD_LIMIT
	%s ‚Ìƒƒ‚”‚ÌãŒÀ‚Í %d Œ‚ÅA•ÏX‚Å‚«‚Ü‚¹‚ñB
MEMO_INFO_X_NO_LIMIT
	%s ‚Ìƒƒ‚”‚ÌãŒÀ‚Í‚ ‚è‚Ü‚¹‚ñB

###########################################################################
#
# OperServ‚ÌƒƒbƒZ[ƒW
#
###########################################################################

# ‘½—pƒƒbƒZ[ƒW
OPER_BOUNCY_MODES
	Services‚Íƒ‚[ƒh‚ð•ÏX‚Å‚«‚Ü‚¹‚ñBƒT[ƒo[‚ÌÝ’è‚ðŠm”F‚µ‚Ä‰º‚³‚¢B
OPER_BOUNCY_MODES_U_LINE
	Services‚Íƒ‚[ƒh‚ð•ÏX‚Å‚«‚Ü‚¹‚ñBƒT[ƒo[‚ÌuU:ƒ‰ƒCƒ“v‚ÌÝ’è‚ðŠm”F‚µ‚Ä‰º‚³‚¢B

# GLOBAL‰ž“š
OPER_GLOBAL_SYNTAX
	GLOBAL ƒƒbƒZ[ƒW

# STATS‰ž“š
OPER_STATS_UNKNOWN_OPTION
	%s ‚Æ‚¢‚¤STATS‚ÌƒIƒvƒVƒ‡ƒ“‚Í‚ ‚è‚Ü‚¹‚ñB
OPER_STATS_CURRENT_USERS
	Œ»Ýƒ†[ƒU”F%d
	ƒIƒyƒŒ[ƒ^”F%d
OPER_STATS_MAX_USERS
	Å‘åƒ†[ƒU”F%di%sj
OPER_STATS_UPTIME_DHMS
	‹N“®‚©‚çF%d%s%02dŽžŠÔ%02d•ª
OPER_STATS_UPTIME_HM_MS
	‹N“®‚©‚çF%02d%s%02d%s
OPER_STATS_USER_MEM
	ƒ†[ƒU@@F%6dƒŒƒR[ƒhE%5dƒLƒƒoƒCƒg
OPER_STATS_CHANNEL_MEM
	ƒ`ƒƒƒ“ƒlƒ‹F%6dƒŒƒR[ƒhE%5dƒLƒƒoƒCƒg
OPER_STATS_NICKSERV_MEM
	DogTag@F%6dƒŒƒR[ƒhE%5dƒLƒƒoƒCƒg
OPER_STATS_CHANSERV_MEM
	ChanServ@F%6dƒŒƒR[ƒhE%5dƒLƒƒoƒCƒg
OPER_STATS_OPERSERV_MEM
	OperServ@F%6dƒŒƒR[ƒhE%5dƒLƒƒoƒCƒg
OPER_STATS_AKILL_COUNT
	Ž©“®Ø’fƒ}ƒXƒN”F%d
OPER_STATS_AKILL_EXPIRE_DAYS
	Ž©“®Ø’fƒ}ƒXƒN‚ÌŠù’è—LŒøŠúŠÔF%d“ú
OPER_STATS_AKILL_EXPIRE_DAY
	Ž©“®Ø’fƒ}ƒXƒN‚ÌŠù’è—LŒøŠúŠÔF%d“ú
OPER_STATS_AKILL_EXPIRE_HOURS
	Ž©“®Ø’fƒ}ƒXƒN‚ÌŠù’è—LŒøŠúŠÔF%dŽžŠÔ
OPER_STATS_AKILL_EXPIRE_HOUR
	Ž©“®Ø’fƒ}ƒXƒN‚ÌŠù’è—LŒøŠúŠÔF%dŽžŠÔ
OPER_STATS_AKILL_EXPIRE_MINS
	Ž©“®Ø’fƒ}ƒXƒN‚ÌŠù’è—LŒøŠúŠÔF%d•ª
OPER_STATS_AKILL_EXPIRE_MIN
	Ž©“®Ø’fƒ}ƒXƒN‚ÌŠù’è—LŒøŠúŠÔF%d•ª
OPER_STATS_AKILL_EXPIRE_NONE
	Ž©“®Ø’fƒ}ƒXƒN‚ÌŠù’è—LŒøŠúŠÔF–³‚µ

# MODE‰ž“š
OPER_MODE_SYNTAX
	MODE ƒ`ƒƒƒ“ƒlƒ‹ ƒ‚[ƒh

# CLEARMODES‰ž“š
OPER_CLEARMODES_SYNTAX
	CLEARMODES ƒ`ƒƒƒ“ƒlƒ‹ [ALL]
OPER_CLEARMODES_DONE
	%s ‚ÌƒoƒCƒiƒŠƒ‚[ƒh‚Æ’Ç•úƒ}ƒXƒN‚ðƒNƒŠƒA‚µ‚Ü‚µ‚½B
OPER_CLEARMODES_ALL_DONE
	%s ‚Ìƒ‚[ƒh‚ð‘S‚ÄƒNƒŠƒA‚µ‚Ü‚µ‚½B

# KICK‰ž“š
OPER_KICK_SYNTAX
	KICK ƒ`ƒƒƒ“ƒlƒ‹ ƒjƒbƒN ——R

# ADMIN‰ž“š
OPER_ADMIN_SYNTAX
	ADMIN {ADD | DEL | LIST} [ƒjƒbƒN]
OPER_ADMIN_ADD_SYNTAX
	ADMIN ADD ƒjƒbƒN
OPER_ADMIN_DEL_SYNTAX
	ADMIN DEL ƒjƒbƒN
OPER_ADMIN_SKELETON
	Services ‚ÍƒXƒPƒŒƒgƒ“ƒ‚[ƒh‚Å“®‚¢‚Ä‚¢‚é‚½‚ßAADMIN ƒRƒ}ƒ“ƒh‚ÍŽg—p‚Å‚«‚Ü‚¹‚ñB
OPER_ADMIN_EXISTS
	%s ‚ÍŠù‚É Services ‚ÌƒAƒhƒ~ƒ“•\‚Å‘¶Ý‚µ‚Ä‚¢‚Ü‚·B
OPER_ADMIN_ADDED
	%s ‚ð Services ‚ÌƒAƒhƒ~ƒ“•\‚É’Ç‰Á‚µ‚Ü‚µ‚½B
OPER_ADMIN_TOO_MANY
	Services ‚ÌƒAƒhƒ~ƒ“•\‚Í‚¢‚Á‚Ï‚¢‚Å‚·‚Ì‚Å’Ç‰Á‚Å‚«‚Ü‚¹‚ñB
OPER_ADMIN_REMOVED
	%s ‚ð Services ‚ÌƒAƒhƒ~ƒ“•\‚©‚çÁ‹Ž‚µ‚Ü‚µ‚½B
OPER_ADMIN_NOT_FOUND
	%s ‚Í Services ‚ÌƒAƒhƒ~ƒ“•\‚É‘¶Ý‚µ‚Ü‚¹‚ñB
OPER_ADMIN_LIST_HEADER
	Services ‚ÌƒAƒhƒ~ƒ“•\F

# OPER‰ž“š
OPER_OPER_SYNTAX
	OPER {ADD | DEL | LIST} [nick]
OPER_OPER_ADD_SYNTAX
	OPER ADD nick
OPER_OPER_DEL_SYNTAX
	OPER DEL nick
OPER_OPER_SKELETON
	Services ‚ÍƒXƒPƒŒƒgƒ“ƒ‚[ƒh‚Å“®‚¢‚Ä‚¢‚é‚½‚ßAOPER ‚ÌƒRƒ}ƒ“ƒh‚ÍŽg—p‚Å‚«‚Ü‚¹‚ñB
OPER_OPER_EXISTS
	%s ‚ÍŠù‚É Services ‚ÌƒIƒyƒŒ[ƒ^•\‚Å‘¶Ý‚µ‚Ä‚¢‚Ü‚·B
OPER_OPER_ADDED
	%s ‚ð Services ‚ÌƒIƒyƒŒ[ƒ^•\‚É’Ç‰Á‚µ‚Ü‚µ‚½B
OPER_OPER_TOO_MANY
	Services ‚ÌƒIƒyƒŒ[ƒ^•\‚Í‚¢‚Á‚Ï‚¢‚Å‚·‚Ì‚Å’Ç‰Á‚Å‚«‚Ü‚¹‚ñB
OPER_OPER_REMOVED
	%s ‚ð Services ‚ÌƒIƒyƒŒ[ƒ^•\‚©‚çÁ‹Ž‚µ‚Ü‚µ‚½B
OPER_OPER_NOT_FOUND
	%s ‚Í Services ‚ÌƒIƒyƒŒ[ƒ^•\‚Å‘¶Ý‚µ‚Ü‚¹‚ñB
OPER_OPER_LIST_HEADER
	Services ‚ÌƒIƒyƒŒ[ƒ^•\F

# AKILL‰ž“š
OPER_AKILL_SYNTAX
	AKILL {ADD | DEL | LIST | VIEW} [[+—LŒøŠúŠÔ] ƒ}ƒXƒN [——R]]
OPER_AKILL_ADD_SYNTAX
	AKILL ADD [+—LŒøŠúŠÔ] ƒ}ƒXƒN ——R
OPER_AKILL_DEL_SYNTAX
	AKILL DEL ƒ}ƒXƒN
OPER_AKILL_NO_NICK
	’ˆÓFŽ©“®Ø’fƒ}ƒXƒN‚É‚ÍƒjƒbƒN‚ð“ü‚ê‚Ä‚Í‚¢‚¯‚Ü‚¹‚ñBƒ}ƒXƒN‚ðŠm”F‚µ‚Ä‰º‚³‚¢B
OPER_TOO_MANY_AKILLS
	Ž©“®Ø’f•\‚Í‚¢‚Á‚Ï‚¢‚Å‚·‚Ì‚Å’Ç‰Á‚Å‚«‚Ü‚¹‚ñB
OPER_AKILL_ADDED
	%s ‚ðŽ©“®Ø’f•\‚É’Ç‰Á‚µ‚Ü‚µ‚½B
OPER_AKILL_REMOVED
	%s ‚ðŽ©“®Ø’f•\‚©‚çÁ‹Ž‚µ‚Ü‚µ‚½B
OPER_AKILL_NOT_FOUND
	%s ‚ÍŽ©“®Ø’f•\‚Å‘¶Ý‚µ‚Ü‚¹‚ñB
OPER_AKILL_LIST_HEADER
	Ž©“®Ø’f•\F
# mask, reason
OPER_AKILL_LIST_FORMAT
	%-32s  %s
# mask, set-by, set-time, expires, reason
OPER_AKILL_VIEW_FORMAT
	%s (%s ‚É %s ‚É’Ç‰Á‚³‚êA%s)
	    %s

# SET‰ž“š
OPER_SET_SYNTAX
	SET ƒIƒvƒVƒ‡ƒ“–¼ ƒpƒ‰ƒ[ƒ^
OPER_SET_IGNORE_ON
	ƒ†[ƒU–³Ž‹ˆ—‚Í“®ì‚µ‚Ü‚·B
OPER_SET_IGNORE_OFF
	ƒ†[ƒU–³Ž‹ˆ—‚Í“®ì‚µ‚Ü‚¹‚ñB
OPER_SET_IGNORE_ERROR
	IGNORE ‚Ìƒpƒ‰ƒ[ƒ^‚Í ON ‚© OFF ‚É‚µ‚Ä‰º‚³‚¢B
OPER_SET_READONLY_ON
	Services ‚Í‚±‚ê‚©‚çƒŠ[ƒhƒIƒ“ƒŠ[i“Ç‚ÝŽæ‚èê—pjƒ‚[ƒh‚Å“®ì‚µ‚Ü‚·B
OPER_SET_READONLY_OFF
	Services ‚Í‚±‚ê‚©‚çƒŠ[ƒhƒ‰ƒCƒgi’Êíjƒ‚[ƒh‚Å“®ì‚µ‚Ü‚·B
OPER_SET_READONLY_ERROR
	READONLY ‚Ìƒpƒ‰ƒ[ƒ^‚ÍAON ‚© OFF ‚É‚µ‚Ä‰º‚³‚¢B
OPER_SET_DEBUG_ON
	Services ‚Í‚±‚ê‚©‚çƒfƒoƒbƒOƒ‚[ƒh‚Å“®ì‚µ‚Ü‚·B
OPER_SET_DEBUG_OFF
	Services ‚Í‚±‚ê‚©‚ç’ÊíiƒfƒoƒbƒO‚È‚µjƒ‚[ƒh‚Å“®ì‚µ‚Ü‚·B
OPER_SET_DEBUG_LEVEL
	Services ‚Í‚±‚ê‚©‚çƒfƒo[ƒOƒ‚[ƒh‚Å“®ì‚µ‚Ü‚·B
OPER_SET_DEBUG_ERROR
	DEBUG ‚Ìƒpƒ‰ƒ[ƒ^‚ÍAONAOFF ‚Ü‚½‚Í³”‚É‚µ‚Ä‰º‚³‚¢B
OPER_SET_UNKNOWN_OPTION
	%s ‚Æ‚¢‚¤ƒIƒvƒVƒ‡ƒ“‚Í‚ ‚è‚Ü‚¹‚ñB

# JUPE‰ž“š
OPER_JUPE_SYNTAX
	JUPE ƒT[ƒo–¼ [——R]

# RAW‰ž“š
OPER_RAW_SYNTAX
	RAW ƒeƒLƒXƒg

# UPDATE‰ž“š
OPER_UPDATING
	ƒf[ƒ^ƒx[ƒX‚ð•Û‘¶‚µ‚Ä‚¢‚Ü‚·B

# IGNORE‰ž“š
OPER_IGNORE_LIST
	Services‚ÌƒCƒOƒmƒA•\F
OPER_IGNORE_LIST_EMPTY
	Services‚ÌƒCƒOƒmƒA•\‚Í‹ó‚Å‚·B

###########################################################################
#
# ˆÄ“àƒVƒXƒeƒ‚ÌƒƒbƒZ[ƒW
#
###########################################################################

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
NEWS_LOGON_TEXT
	iƒƒOƒIƒ“ˆÄ“à  %sj %s
NEWS_OPER_TEXT
	iƒIƒyƒŒ[ƒ^ˆÄ“à  %sj %s

NEWS_LOGON_SYNTAX
	LOGONNEWS {ADD|DEL|LIST} [text|num]
NEWS_LOGON_ADD_SYNTAX
	LOGONNEWS ADD text
NEWS_LOGON_DEL_SYNTAX
	LOGONNEWS DEL {num | ALL}
NEWS_LOGON_LIST_HEADER
	ƒƒOƒIƒ“ˆÄ“à•\F
NEWS_LOGON_LIST_ENTRY
	%5d (%s  %s)
	    %s
NEWS_LOGON_LIST_NONE
	ƒƒOƒIƒ“ˆÄ“àŒ‚Í‚ ‚è‚Ü‚¹‚ñB
NEWS_LOGON_ADD_FULL
	ƒƒOƒIƒ“ˆÄ“à•\‚Í–ž”t‚Å‚·B
NEWS_LOGON_ADDED
	VƒƒOƒIƒ“ˆÄ“àŒi%d”Ôj‚ð’Ç‰Á‚µ‚Ü‚µ‚½B
NEWS_LOGON_DEL_NOT_FOUND
	%d ”Ô–Ú‚ÌƒƒOƒIƒ“ˆÄ“àŒ‚Í‘¶Ý‚µ‚Ü‚¹‚ñB
NEWS_LOGON_DELETED
	%d ”Ô–Ú‚ÌƒƒOƒIƒ“ˆÄ“àŒ‚ÍÁ‹Ž‚³‚ê‚Ü‚µ‚½B
NEWS_LOGON_DEL_NONE
	ƒƒOƒIƒ“ˆÄ“àŒ‚Í‚ ‚è‚Ü‚¹‚ñB
NEWS_LOGON_DELETED_ALL
	ƒƒOƒIƒ“ˆÄ“àŒ‚Í‘S‚ÄÁ‹Ž‚³‚ê‚Ü‚µ‚½B

NEWS_OPER_SYNTAX
	OPERNEWS {ADD|DEL|LIST} [text|num]
NEWS_OPER_ADD_SYNTAX
	OPERNEWS ADD text
NEWS_OPER_DEL_SYNTAX
	OPERNEWS DEL {num | ALL}
NEWS_OPER_LIST_HEADER
	ƒIƒyƒŒ[ƒ^ˆÄ“à•\F
NEWS_OPER_LIST_ENTRY
	%5d (%s  %s)
	    %s
NEWS_OPER_LIST_NONE
	ƒIƒyƒŒ[ƒ^ˆÄ“àŒ‚Í‚ ‚è‚Ü‚¹‚ñB
NEWS_OPER_ADD_FULL
	ƒIƒyƒŒ[ƒ^ˆÄ“à•\‚Í–ž”t‚Å‚·B
NEWS_OPER_ADDED
	VƒIƒyƒŒ[ƒ^ˆÄ“àŒi%d”Ôj‚ð’Ç‰Á‚µ‚Ü‚µ‚½B
NEWS_OPER_DEL_NOT_FOUND
	%d ”Ô–Ú‚ÌƒIƒyƒŒ[ƒ^ˆÄ“àŒ‚Í‘¶Ý‚µ‚Ü‚¹‚ñB
NEWS_OPER_DELETED
	%d ”Ô–Ú‚ÌƒIƒyƒŒ[ƒ^ˆÄ“àŒ‚ÍÁ‹Ž‚³‚ê‚Ü‚µ‚½B
NEWS_OPER_DEL_NONE
	ƒIƒyƒŒ[ƒ^ˆÄ“àŒ‚Í‚ ‚è‚Ü‚¹‚ñB
NEWS_OPER_DELETED_ALL
	ƒIƒyƒŒ[ƒ^ˆÄ“àŒ‚Í‘S‚ÄÁ‹Ž‚³‚ê‚Ü‚µ‚½B

NEWS_HELP_LOGON
	ƒVƒ“ƒ^ƒNƒXFLOGONNEWS ADD text
	@@@@@@LOGONNEWS DEL {num | ALL}
	@@@@@@LOGONNEWS LIST
	
	ƒƒOƒIƒ“ˆÄ“à•\‚Ì•ÒW‚Æ•\Ž¦‚ÌƒRƒ}ƒ“ƒh‚Å‚·Bƒ†[ƒU‚Íƒlƒbƒg
	ƒ[ƒN‚ÉÚ‘±‚ÆAServices ‚Í‚±‚ÌƒƒbƒZ[ƒW‚ðƒ†[ƒU‚É‘—‚è‚Ü
	‚·B‚½‚¾‚µAƒƒbƒZ[ƒW‚ª‚S‚ÂˆÈã‚Ìê‡Aƒ†[ƒU‚É‘å—Ê‚Ìƒƒb
	ƒZ[ƒW‚ð‘—‚ç‚È‚¢‚æ‚¤‚ÉÅV‚Ì‚R‚Â‚¾‚¯‚ð‘—‚è‚Ü‚·B
	
	LOGONNEWS LIST ‚Æ‚¢‚¤Œ`‚ÅAIRC ƒIƒyƒŒ[ƒ^‚ÍƒƒOƒIƒ“ˆÄ“à•\
	‚ð•\‚·‚±‚Æ‚ªo—ˆ‚Ü‚·‚ªAADDEDEL ‚Ì•ÒWƒRƒ}ƒ“ƒh‚ðŽg‚¤‚Ì‚Í
	Services ‚ÌƒAƒhƒ~ƒ“‚Ì‚Ý‚Å‚·B

NEWS_HELP_OPER
	ƒVƒ“ƒ^ƒNƒXFOPERNEWS ADD text
	@@@@@@OPERNEWS DEL {num | ALL}
	@@@@@@OPERNEWS LIST
	
	ƒIƒyƒŒ[ƒ^ˆÄ“à•\‚Ì•ÒW‚Æ•\Ž¦‚ÌƒRƒ}ƒ“ƒh‚Å‚·Bƒ†[ƒU‚ª
	IRC ƒIƒyƒŒ[ƒ^‚É‚È‚é‚ÆAServices ‚Í‚±‚ÌƒƒbƒZ[ƒW‚ðƒ†[
	ƒU[‚É‘—‚è‚Ü‚·B‚½‚¾‚µAƒƒbƒZ[ƒW‚ª‚S‚ÂˆÈã‚Ìê‡Aƒ†[
	ƒU[‚É‘å—Ê‚ÌƒƒbƒZ[ƒW‚ð‘—‚ç‚È‚¢‚æ‚¤‚ÉÅV‚Ì‚R‚Â‚¾‚¯‚ð‘—‚è
	‚Ü‚·B
	
	OPERNEWS LIST ‚Æ‚¢‚¤Œ`‚ÅAIRC ƒIƒyƒŒ[ƒ^‚ÍƒƒOƒIƒ“ˆÄ“à•\
	‚ð•\‚·‚±‚Æ‚ªo—ˆ‚Ü‚·‚ªAADDEDEL ‚Ì•ÒWƒRƒ}ƒ“ƒh‚ðŽg‚¤‚Ì‚Í
	Services ‚ÌƒAƒhƒ~ƒ“‚Ì‚Ý‚Å‚·B

###########################################################################
#
# DogTag‚Ìƒwƒ‹ƒvƒƒbƒZ[ƒW
#
###########################################################################

NICK_HELP
	%S ‚ÍAƒjƒbƒN‚Ì“o˜^ƒT[ƒrƒX‚Å‚·B‚±‚ÌƒT[ƒrƒX‚ðŽg‚¢
	ƒjƒbƒN‚ð“o˜^‚·‚ê‚ÎA‘¼‚Ìƒ†[ƒU‚Í‚»‚ÌƒjƒbƒN‚ðŽg‚¦‚È‚­‚È‚è
	‚Ü‚·B‚½‚¾‚µAƒjƒbƒN‚ð%d“úŠÔŽg‚í‚È‚¢‚Æ“o˜^‚ÍØ‚ê‚Ä‚µ‚Ü‚¢‚Ü
	‚·BŽŸ‚ÌƒRƒ}ƒ“ƒh‚ÅƒjƒbƒN‚ð“o˜^‚âƒIƒvƒVƒ‡ƒ“‚Ì•ÏX‚ªo—ˆ‚Ü‚·B
	ƒRƒ}ƒ“ƒh‚ðŽg‚¤ê‡‚Íu/msg %S commandv‚ð“ü—Í‚µ‚Ä‰º
	‚³‚¢BƒRƒ}ƒ“ƒh‚Ìƒwƒ‹ƒv‚ð“Ç‚Þê‡‚ÍAu/msg %S HELP
	commandv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B
	
	    REGISTER   ƒjƒbƒN‚Ì“o˜^
#@@@ uidentifyv
	    IDENTIFY   ƒpƒXƒ[ƒh‚Åidentify‚·‚é
	    ACCESS     ƒAƒNƒZƒXˆê——‚Ì•ÏX
	    LINK       ‘¼‚ÌƒjƒbƒN‚ÉƒŠƒ“ƒN‚ðì‚é
	    SET        ƒIƒvƒVƒ‡ƒ“‚ÌÝ’è
	    DROP       “o˜^‚ÌÁ‹Ž
	    RECOVER    ƒjƒbƒN‚ðŽg—p‚µ‚Ä‚¢‚éƒ†[ƒU‚ðØ’f‚·‚é
	    RELEASE    RECOVER ‚ðŽg‚Á‚Ä‚©‚çƒjƒbƒN‚ðŽg—p‰Â”\‚É‚·‚é
	
	‘¼‚ÌƒRƒ}ƒ“ƒhFUNLINKEUNSETEGHOSTEINFOELISTELISTCHANSE
	              STATUS
	
	ŒxF‚±‚ÌƒT[ƒrƒX‚ÍAƒ†[ƒU‚ÌgŒ³‚ðŽç‚éˆ×‚ÌƒT[ƒrƒX‚Å‚·B
	ƒjƒbƒN‚Ìu“‚Ýv“™‚Ìˆ«—p‚Ì‚½‚ß‚ÌƒT[ƒrƒX‚Å‚Í‚ ‚è‚Ü‚¹‚ñ‚Ì‚ÅA
	‚»‚Ì‚æ‚¤‚Èsˆ×‚Í‚¨‚â‚ß‰º‚³‚¢B

NICK_HELP_EXPIRE_ZERO
	%S ‚ÍAƒjƒbƒN‚Ì“o˜^ƒT[ƒrƒX‚Å‚·B‚±‚ÌƒT[ƒrƒX‚ðŽg‚¢
	ƒjƒbƒN‚ð“o˜^‚·‚ê‚ÎA‘¼‚Ìƒ†[ƒU‚Í‚»‚ÌƒjƒbƒN‚ðŽg‚¦‚È‚­‚È‚è
	‚Ü‚·BŽŸ‚ÌƒRƒ}ƒ“ƒh‚ÅƒjƒbƒN‚ð“o˜^‚âƒIƒvƒVƒ‡ƒ“‚Ì•ÏX‚ªo—ˆ‚Ü
	‚·BƒRƒ}ƒ“ƒh‚ðŽg‚¤ê‡‚Íu/msg %S commandv‚ð“ü—Í‚µ‚Ä
	‰º‚³‚¢BƒRƒ}ƒ“ƒh‚Ìƒwƒ‹ƒv‚ð“Ç‚Þê‡‚ÍAu/msg %S HELP
	commandv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B
	
	    REGISTER   ƒjƒbƒN‚Ì“o˜^
#@@@ uidentifyv
	    IDENTIFY   ƒpƒXƒ[ƒh‚Åidentify‚·‚é
	    ACCESS     ƒAƒNƒZƒXˆê——‚Ì•ÏX
	    LINK       ‘¼‚ÌƒjƒbƒN‚ÉƒŠƒ“ƒN‚ðì‚é
	    SET        ƒIƒvƒVƒ‡ƒ“‚ÌÝ’è
	    DROP       “o˜^‚ÌÁ‹Ž
	    RECOVER    ƒjƒbƒN‚ðŽg—p‚µ‚Ä‚¢‚éƒ†[ƒU‚ðØ’f‚·‚é
	    RELEASE    RECOVER ‚ðŽg‚Á‚Ä‚©‚çƒjƒbƒN‚ðŽg—p‰Â”\‚É‚·‚é
	
	‘¼‚ÌƒRƒ}ƒ“ƒhFUNLINKEUNSETEGHOSTEINFOELISTELISTCHANSE
	              STATUS
	
	ŒxF‚±‚ÌƒT[ƒrƒX‚ÍAƒ†[ƒU‚ÌgŒ³‚ðŽç‚éˆ×‚ÌƒT[ƒrƒX‚Å‚·B
	ƒjƒbƒN‚Ìu“‚Ýv“™‚Ìˆ«—p‚Ì‚½‚ß‚ÌƒT[ƒrƒX‚Å‚Í‚ ‚è‚Ü‚¹‚ñ‚Ì‚ÅA
	‚»‚Ì‚æ‚¤‚Èsˆ×‚Í‚¨‚â‚ß‰º‚³‚¢B

NICK_HELP_REGISTER
	ƒVƒ“ƒ^ƒNƒXFREGISTER password email
	
	Œ»ÝŽg—p‚µ‚Ä‚¢‚éƒjƒbƒN‚ð%S‚Ìƒf[ƒ^ƒx[ƒX‚É“o˜^‚µ‚Ü‚·B
	ƒjƒbƒN‚ð“o˜^‚µ‚Ä‚©‚çASETEACCESS“™‚ÌƒRƒ}ƒ“ƒh‚ÅƒjƒbƒN‚ÌƒI
	ƒvƒVƒ‡ƒ“‚Ì•ÏX‚ªo—ˆ‚Ü‚·B‚½‚¾‚µAÝ’è‚ð•ÏX‚·‚é‚Ì‚É‚ÍƒpƒX
	ƒ[ƒh‚ª•K—v‚Å‚·‚Ì‚ÅA“o˜^‚·‚é‚Æ‚«‚É‘I‚ñ‚¾ƒpƒXƒ[ƒh‚ð‚æ‚­
	Šo‚¦‚Ä‚¨‚¢‚Ä‰º‚³‚¢B‚Ü‚½AƒjƒbƒN‚âƒ`ƒƒƒ“ƒlƒ‹‚Æˆá‚Á‚ÄAƒpƒX
	ƒ[ƒh‚Å‘å•¶Žš‚Æ¬•¶Žš‚Íˆá‚¢‚Ü‚·B—á‚¦‚ÎAFIDOEFidoEfido
	“™‚Í‘S‚Äˆá‚¢‚Ü‚·B
	
	“o˜^Žž‚É“dŽqƒ[ƒ‹ƒAƒhƒŒƒX‚à“o˜^‚Å‚«‚Ü‚·B“o˜^‚µ‚È‚©‚Á‚½ê
	‡‚Å‚àASET EMAILƒRƒ}ƒ“ƒh‚ðŽg‚Á‚ÄŒã‚Å“o˜^‚·‚é‚±‚Æ‚à‚Å‚«‚Ü
	‚·B
	
	ƒpƒXƒ[ƒh‚ð‘I‚Ô‚Æ‚«‚ÍA•s–¾‚È•û‚ÌƒpƒXƒ[ƒh‚É‚µ‚Ä‰º‚³‚¢B
	‚¨–¼‘OEƒjƒbƒN“™‚Ì‚æ‚¤‚È“–‚Ä‚â‚·‚¢ƒpƒXƒ[ƒh‚Í‚¨Ž~‚ß‰º‚³‚¢B
	‚S•¶ŽšˆÈ‰º‚ÌƒpƒXƒ[ƒh‚Í‰½‚Å‚à“–‚Ä‚â‚·‚¢•û‚Å‚·‚Ì‚ÅA‚T•¶Žš
	ˆÈã‚ÌƒpƒXƒ[ƒh‚É‚µ‚Ä‰º‚³‚¢B‚È‚¨AƒpƒXƒ[ƒh‚ÅƒXƒy[ƒX‚ð
	Žg‚¦‚Ü‚¹‚ñBˆê•ûA“ú–{Œêi‰¼–¼‚ÆŠ¿Žšj‚ÅƒpƒXƒ[ƒh‚ð“ü—Í‚·
	‚é‚±‚Æ‚ào—ˆ‚Ü‚·B

NICK_HELP_IDENTIFY
	ƒVƒ“ƒ^ƒNƒXFIDENTIFY password
	
#@@@  uØ‹’v‚È‚ÇEChanServ‚Ì‚à‚ ‚é
	%S‚ÉƒjƒbƒN‚Ì•Û—LŽÒ‚Å‚ ‚éØ‹’‚ðŽ¦‚µ‚Ü‚·B‚±‚ÌƒRƒ}ƒ“ƒh
	‚ðŽg‚í‚È‚¯‚ê‚ÎA‚Ù‚Æ‚ñ‚Ç‚ÌServices‚ÌƒRƒ}ƒ“ƒh‚ÍŽg‚¦‚Ü‚¹‚ñB
	password‚ÍREGISTER‚ÌƒRƒ}ƒ“ƒh‚ð“ü—Í‚µ‚½‚Æ‚«‚Ì‚Æ“¯‚¶ƒpƒXƒ[
	ƒh‚Å‚·B

NICK_HELP_DROP
	ƒVƒ“ƒ^ƒNƒXFDROP
	
	%S‚Ìƒf[ƒ^ƒx[ƒX‚©‚çƒjƒbƒN‚ðÁ‹Ž‚µ‚Ü‚·BÁ‹Ž‚µ‚½ƒjƒb
	ƒN‚ÍA’N‚Å‚àÄ“o˜^‚ªo—ˆ‚Ü‚·B
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚¤‚Ì‚É‚ÍAƒpƒXƒ[ƒh‚ð“ü—Í‚·‚é•K—v‚ª‚ ‚è‚Ü
	‚·BƒpƒXƒ[ƒh‚Ì“ü—Í‚Ìƒwƒ‹ƒv‚ðŒ©‚é‚Ì‚É‚ÍA
	u/msg %S HELP IDENTIFYv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B

NICK_HELP_ACCESS
	ƒVƒ“ƒ^ƒNƒXFACCESS ADD mask
	@@@@@@ACCESS DEL mask
	@@@@@@ACCESS LIST
	
	ƒjƒbƒN‚ÌƒAƒNƒZƒXˆê——‚Ì•ÏX‚Æ•\Ž¦‚ÌƒRƒ}ƒ“ƒh‚Å‚·BƒAƒNƒZƒXˆê——‚Æ
	‚ÍA•Û—LŽÒ‚Ìƒ†[ƒUƒAƒhƒŒƒXiuser@host‚Æ‚¢‚¤ƒAƒhƒŒƒXj‚ÌƒŠ
	ƒXƒg‚Å‚·Bƒ†[ƒU‚ÌƒAƒhƒŒƒX‚ÍƒAƒNƒZƒXˆê——‚Ìƒ}ƒXƒN‚Ìˆê‚Â‚É‡
	‚¦‚ÎA%S‚ÉØ’f‚³‚ê‚Ü‚¹‚ñB‚Ü‚½ASECURE‚Æ‚¢‚¤ƒIƒvƒVƒ‡ƒ“‚ðOFF
	‚É‚·‚ê‚ÎƒpƒXƒ[ƒh‚ð“ü—Í‚¹‚¸‚ÉServices‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚¦‚Ü‚·B
	
	—áF
	    ACCESS ADD achurch@*.dragonfire.net
	        dragonfire.net‚Æ‚¢‚¤ƒhƒ[ƒ“‚ÌƒzƒXƒg‚©‚çachurch‚Æ‚¢
	        ‚¤ƒ†[ƒU‚ðƒAƒNƒZƒXˆê——‚É’Ç‰Á‚µ‚Ü‚·B
	
	    ACCESS DEL achurch@*.dragonfire.net
	        ‘O‚Ì—á‚Æ‹t‚ÌŒ‹‰Ê‚Å‚·B
	
	    ACCESS LIST
	        ƒAƒNƒZƒXˆê——‚ð•\‚µ‚Ü‚·B

#NICK_HELP_LINK
#	ƒVƒ“ƒ^ƒNƒXFLINK nick password
#	
#	nick‚Æ‚¢‚¤ƒjƒbƒN‚ÉƒŠƒ“ƒN‚ðì‚èAŒ»Ý‚ÌƒjƒbƒN‚ð“ü—Í‚µ‚½ƒjƒb
#	ƒN‚Ì‰¼–¼‚É‚µ‚Ü‚·B‚±‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚¤‚ÆAŒ»Ý‚ÌƒjƒbƒN‚ÌƒAƒN
#	ƒZƒX•\‚ÍÁ‚¦Aƒƒ‚‚Í“ü—Í‚µ‚½ƒjƒbƒN‚Ìƒƒ‚•\‚É’Ç‰Á‚³‚ê‚Ü‚·
#	i‚»‚ê‚Å“ü—Í‚µ‚½ƒjƒbƒN‚Ìƒƒ‚•\‚ªƒƒ‚‚Ì”‚ÌŒÀ‚è‚ð‰ß‚¬‚é‚±‚Æ
#	‚à‚ ‚è‚Ü‚·‚Ì‚Å‚²’ˆÓ‰º‚³‚¢jB
#	
#	ƒŠƒ“ƒN‚ªì‚ç‚ê‚Ä‚©‚çAŒ»Ý‚ÌƒjƒbƒN‚ÍServices‚Ìƒf[ƒ^ƒx[ƒX
#	‚Å“ü—Í‚µ‚½ƒjƒbƒN‚É•Ï‰»‚µ‚Ü‚·B%S‚ÌUNLINK‚ÆDROP‚ÌƒRƒ}
#	ƒ“ƒhˆÈŠOA‘S‚Ä‚ÌServices‚ÌƒRƒ}ƒ“ƒh‚ÍŒ»Ý‚ÌƒjƒbƒN‚Ì‘ã‚í‚è‚É
#	ƒŠƒ“ƒN‚³‚ê‚½ƒjƒbƒN‚ðŽg‚¢‚Ü‚·B—á‚¦‚ÎAƒŠƒ“ƒN‚³‚ê‚½ƒjƒbƒN‚Ì
#	ƒƒ‚‚ðŒ©‚½‚¢ê‡‚ÍA‚Ç‚¿‚ç‚ÌƒjƒbƒN‚Å‚àŒ©‚ç‚ê‚Ü‚·B‚»‚µ‚ÄA
#	‘¼‚Ìƒ†[ƒU‚©‚çƒƒ‚‚ðŽó‚¯‚éê‡‚ÍA‚»‚Ìƒ†[ƒU‚Í‚Ç‚¿‚ç‚Ì
#	ƒjƒbƒN‚É‘—‚Á‚Ä‚à“¯‚¶ƒƒ‚•\‚É’Ç‰Á‚³‚ê‚Ü‚·B‚Ü‚½Aƒ`ƒƒƒ“ƒlƒ‹
#	‚ÌƒAƒNƒZƒXˆê——‚Å‚Ç‚¿‚ç‚©‚ÌƒjƒbƒN‚ª‘¶Ý‚µ‚Ä‚¢‚ê‚ÎA‚Ç‚¿‚ç‚Ì
#	ƒjƒbƒN‚Å‚à“¯‚¶“ÁŒ ‚ð“¾‚Ü‚·B
#	
#	‚±‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚¤‚Ì‚É‚ÍAƒpƒXƒ[ƒh‚ð“ü—Í‚·‚é•K—v‚ª‚ ‚è‚Ü
#	‚·B‚È‚¨AƒŠƒ“ƒN‚µ‚½‚¢ƒjƒbƒN‚ÌƒpƒXƒ[ƒh‚ð‚±‚ÌƒRƒ}ƒ“ƒh‚Ìƒp
#	ƒ‰ƒ[ƒ^[‚Æ‚µ‚Ä“ü—Í‚·‚é•K—v‚ª‚ ‚è‚Ü‚·B

NICK_HELP_UNLINK
	ƒVƒ“ƒ^ƒNƒXFUNLINK [nick password]
	
	ƒjƒbƒN‚ÌƒŠƒ“ƒN‚ðÁ‹Ž‚µ‚Ü‚·B‚±‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚¤‚ÆAƒŠƒ“ƒN‚³
	‚ê‚Ä‚¢‚½ƒjƒbƒN‚ÌƒAƒNƒZƒXˆê——‚ÆƒIƒvƒVƒ‡ƒ“‚ÌÝ’è‚ÍŒ»Ý‚ÌƒjƒbƒN
	‚ÉƒRƒs[‚³‚ê‚Ü‚·‚ªAƒƒ‚‚ÍƒRƒs[‚³‚ê‚Ü‚¹‚ñB
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚¤‚Ì‚É‚ÍAƒpƒXƒ[ƒh‚ð“ü—Í‚·‚é•K—v‚ª‚ ‚è‚Ü
	‚·BƒpƒXƒ[ƒh‚Ì“ü—Í‚Ìƒwƒ‹ƒv‚ðŒ©‚é‚Ì‚É‚ÍAu/msg %S
	HELP IDENTIFYv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B
	
	•Ê‚ÌƒjƒbƒN‚ÌƒŠƒ“ƒN‚ðÁ‹Ž‚µ‚½‚¢Žž‚ÍA‚»‚ÌƒjƒbƒN‚ÆƒpƒXƒ[ƒh
	‚ð“ü—Í‚·‚ê‚ÎÁ‹Ž‚Å‚«‚Ü‚·B

NICK_HELP_SET
	ƒVƒ“ƒ^ƒNƒXFSET option parameters
	
	ƒjƒbƒN‚ÌƒIƒvƒVƒ‡ƒ“‚ðÝ’è‚µ‚Ü‚·Boption‚Ì‘I‘ð‚ÍŽŸ‚Ì’Ê‚è‚Å‚·B
	
	    PASSWORD   ƒpƒXƒ[ƒh‚Ì•ÏX
	    LANGUAGE   Services‚ªŽg‚¤Œ¾Œê‚ÌÝ’è
	    URL        ƒz[ƒƒy[ƒW‚ÌƒAƒhƒŒƒX‚Ì“ü—Í
	    EMAIL      “dŽqƒ[ƒ‹‚ÌƒAƒhƒŒƒX‚Ì“ü—Í
#@@@  Ø’fuƒIƒvƒVƒ‡ƒ“vA‚»‚ê‚ÆuŽçv...H
	    KILL       Ø’fƒIƒvƒVƒ‡ƒ“‚Ì“üØ
	    SECURE     ƒZƒLƒ…ƒAƒIƒvƒVƒ‡ƒ“‚Ì“üØ
	    PRIVATE    LIST‚ÌƒRƒ}ƒ“ƒh‚©‚çƒjƒbƒN‚ð‰B‚·
	    HIDE       INFO‚ÌƒRƒ}ƒ“ƒh‚©‚çƒjƒbƒN‚Ìî•ñ‚ð‰B‚·
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚¤‚Ì‚É‚ÍAƒpƒXƒ[ƒh‚ð“ü—Í‚·‚é•K—v‚ª‚ ‚è‚Ü
	‚·BƒpƒXƒ[ƒh‚Ì“ü—Í‚Ìƒwƒ‹ƒv‚ðŒ©‚é‚Ì‚É‚ÍAu/msg %S
	HELP IDENTIFYv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B
	
	ƒIƒvƒVƒ‡ƒ“‚Ìî•ñ‚ð“Ç‚Þ‚Ì‚É‚ÍAu/msg %S HELP SET optionv‚ð
	“ü—Í‚µ‚Ä‰º‚³‚¢B

NICK_HELP_SET_PASSWORD
	ƒVƒ“ƒ^ƒNƒXFSET PASSWORD new-password
	
	ƒjƒbƒN‚Ì•Û—LŽÒ‚ÌƒpƒXƒ[ƒh‚ð•ÏX‚µ‚Ü‚·B

NICK_HELP_SET_LANGUAGE
	ƒVƒ“ƒ^ƒNƒXFSET LANGUAGE number
	
	Services‚ªŽg‚¤Œ¾Œê‚ðÝ’è‚µ‚Ü‚·Bnumber‚Ì‘I‘ð‚ÍŽŸ‚Ì’Ê‚è‚Å‚·B
	

NICK_HELP_SET_URL
	ƒVƒ“ƒ^ƒNƒXFSET URL url
	
	url‚Æ‚¢‚¤ƒz[ƒƒy[ƒW‚ÌƒAƒhƒŒƒX‚ðƒjƒbƒN‚Ìî•ñ‚É’Ç‰Á‚µ‚Ü‚·B
	‚±‚ÌƒAƒhƒŒƒX‚ÍINFO‚ÌƒRƒ}ƒ“ƒh‚Ìî•ñ‚Å•\‚ê‚Ü‚·B

NICK_HELP_SET_EMAIL
	ƒVƒ“ƒ^ƒNƒXFSET EMAIL address
	
	address‚Æ‚¢‚¤“dŽqƒ[ƒ‹‚ÌƒAƒhƒŒƒX‚ðƒjƒbƒN‚Ìî•ñ‚É’Ç‰Á‚µ‚Ü‚·B
	‚±‚ÌƒAƒhƒŒƒX‚ÍINFO‚ÌƒRƒ}ƒ“ƒh‚Ìî•ñ‚Å•\‚ê‚Ü‚·B

NICK_HELP_SET_KILL
	ƒVƒ“ƒ^ƒNƒXFSET KILL {ON | QUICK | IMMED | OFF}
	
	ƒjƒbƒN‚ÌØ’fƒIƒvƒVƒ‡ƒ“‚ðÝ’è‚µ‚Ü‚·BON‚É‚·‚é‚ÆA‘¼‚Ìƒ†[
	ƒU[‚ªƒjƒbƒN‚ðŽg‚¨‚¤‚Æ‚·‚ê‚ÎA%S‚ÉŒx‚³‚êAˆê•ªˆÈ“à
	‚ÅƒjƒbƒN‚ð•Ï‚¦‚È‚¢‚ÆØ’f‚³‚ê‚Ü‚·BQUICK‚É‚·‚é‚ÆAƒjƒbƒN‚ð•Ï
	‚¦‚éŽžŒÀ‚Í20•b‚É‚È‚è‚Ü‚·BIMMED‚É‚·‚é‚ÆA%S‚ÍŒx‚¹‚¸
	‚Éƒ†[ƒU‚ðØ’f‚µ‚Ü‚·‚Ì‚ÅA•K—v‚Èê‡‚É‚µ‚©‚±‚Ì‘I‘ð‚É‚µ‚È
	‚¢‚Å‰º‚³‚¢B‚È‚¨A‚±‚Ì‘I‘ð‚Íƒlƒbƒg‚Ì‰^‰cŽÒ‚É‚æ‚èŽg—p•s‰Â”\
	‚È‚±‚Æ‚à‚ ‚è‚Ü‚·B

NICK_HELP_SET_SECURE
	ƒVƒ“ƒ^ƒNƒXFSET SECURE {ON | OFF}
	
	ƒZƒLƒ…ƒAƒIƒvƒVƒ‡ƒ“‚ðÝ’è‚µ‚Ü‚·BON‚É‚·‚é‚ÆAƒ†[ƒUƒAƒhƒŒ
	ƒX‚ªƒAƒNƒZƒXˆê——‚É‘¶Ý‚µ‚Ä‚¢‚Ä‚àƒpƒXƒ[ƒh‚ð“ü—Í‚µ‚È‚¯‚ê‚Î•Û
	—LŽÒ‚Ì“ÁŒ ‚ð“¾‚Ü‚¹‚ñB‚½‚¾‚µAƒ†[ƒUƒAƒhƒŒƒX‚ªƒAƒNƒZƒXˆê——
	‚É‚ ‚ê‚ÎAØ’fƒIƒvƒVƒ‡ƒ“‚ªƒIƒ“‚ÉÝ’è‚³‚ê‚Ä‚àØ’f‚³‚ê‚Ü‚¹‚ñB

NICK_HELP_SET_PRIVATE
	ƒVƒ“ƒ^ƒNƒXFSET PRIVATE {ON | OFF}
	
	uŽ„“Iv‚Æ‚¢‚¤ƒIƒvƒVƒ‡ƒ“‚ðÝ’è‚µ‚Ü‚·BON‚É‚·‚é‚ÆAƒjƒbƒN‚Í
	u/msg %S LISTv‚ÌƒŠƒXƒg‚Å•\‚ê‚Ü‚¹‚ñB‚½‚¾‚µAON‚É‚µ
	‚Ä‚àƒjƒbƒN‚ð’m‚Á‚Ä‚¢‚éƒ†[ƒU‚ÍINFO‚ÌƒRƒ}ƒ“ƒh‚ÅƒjƒbƒN‚Ìî
	•ñ‚ðŒ©‚é‚±‚Æ‚ªo—ˆ‚Ü‚·B

NICK_HELP_SET_HIDE
	ƒVƒ“ƒ^ƒNƒXFSET HIDE {EMAIL | USERMASK | QUIT} {ON | OFF}
	
	ƒjƒbƒN‚Ìî•ñ‚ð%S‚ÌINFO‚ÌƒRƒ}ƒ“ƒh‚©‚ç‰B‚µ‚Ü‚·B‰B‚¹‚é
	‚Ì‚ÍA“dŽqƒ[ƒ‹‚ÌƒAƒhƒŒƒXiEMAILjA‘O‚Ìƒ†[ƒUƒAƒhƒŒƒX
	iUSERMASKjA‘O‚ÌØ’fƒƒbƒZ[ƒWiQUITj‚Å‚·B“ñ”Ô–Ú‚Ìƒpƒ‰
	ƒ[ƒ^[‚ÍAON‚É‚·‚é‚Æî•ñ‚ð‰B‚µAOFF‚É‚·‚é‚Æî•ñ‚ð•\‚µ‚Ü
	‚·B

NICK_HELP_RECOVER
	ƒVƒ“ƒ^ƒNƒXFRECOVER nickname [password]
	
	‘¼‚Ìƒ†[ƒU‚ÉƒjƒbƒN‚ªŽæ‚ç‚ê‚½‚ç‚»‚ÌƒjƒbƒN‚ðŽæ‚è–ß‚µ‚Ü‚·B
#@@@  Ø’fŽç‚Ìu‚ ‚év
	‚±‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚¤‚ÆAØ’fŽç‚ªÝ’è‚µ‚Ä‚ ‚éƒjƒbƒN‚©‚çˆê•ªˆÈ
	“à‚ÅƒjƒbƒN‚ð•Ï‚¦‚È‚¢ê‡‚Æ“¯‚¶Œ‹‰Ê‚ªo‚Ü‚·BƒjƒbƒN‚ðŽg—p‚µ
	‚Ä‚¢‚éƒ†[ƒU‚ðØ’f‚µ‚Ä‚©‚çA%S‚Í‚»‚ÌƒjƒbƒN‚ðŽæ‚èA
	ˆê•ªŠÔ’N‚àŽg‚¦‚È‚­‚È‚è‚Ü‚·B‚»‚Ìˆê•ª‚ª‚½‚Á‚Ä‚©‚çƒjƒbƒN‚ðŽæ
	‚è–ß‚¹‚Ü‚·B‚»‚ê‚ÆA%S‚ÌRELEASE‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚¦‚Îˆê
	•ª‚ªŒo‚Â‘O‚ÉŽæ‚è–ß‚¹‚Ü‚·B
	
	RECOVER‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚¤‚Ì‚É‚ÍAŒ»Ý‚Ìƒ†[ƒUƒAƒhƒŒƒX‚ª
	nickname‚Æ‚¢‚¤ƒjƒbƒN‚ÌƒAƒNƒZƒXˆê——‚É‚ ‚é•K—v‚ª‚ ‚è‚Ü‚·B‚Ü‚½A
	ƒpƒXƒ[ƒh‚ð“ü—Í‚·‚ê‚ÎƒjƒbƒN‚ðŽæ‚è–ß‚¹‚Ü‚·B

NICK_HELP_RELEASE
	ƒVƒ“ƒ^ƒNƒXFRELEASE nickname [password]
	
#@@@  uƒzƒ‹ƒhv
	ƒjƒbƒN‚Ìƒzƒ‹ƒh‚ð‰ð•ú‚µ‚Ü‚·BƒjƒbƒN‚ðŽg—p‚µ‚Ä‚¢‚½ƒ†[ƒU‚ª
	Ø’f‚³‚ê‚Ä‚©‚çAƒjƒbƒN‚Íˆê•ªŠÔŽg‚¦‚È‚­‚È‚è‚Ü‚·B‚»‚Ìˆê•ª‚ª
	‚½‚Â‘O‚ÉƒjƒbƒN‚ðŽg—p‚µ‚½‚¢ê‡‚Í‚±‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚¤‚Ì‚Å‚·B
	
	RELEASE‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚¤‚Ì‚É‚ÍAŒ»Ý‚Ìƒ†[ƒUƒAƒhƒŒƒX‚ª
	nickname‚Æ‚¢‚¤ƒjƒbƒN‚ÌƒAƒNƒZƒXˆê——‚É‚ ‚é•K—v‚ª‚ ‚è‚Ü‚·B‚Ü‚½A
	ƒpƒXƒ[ƒh‚ð“ü—Í‚·‚ê‚ÎƒjƒbƒN‚Ìƒzƒ‹ƒh‚ª‰ð•ú‚³‚ê‚Ü‚·B

NICK_HELP_GHOST
	ƒVƒ“ƒ^ƒNƒXFGHOST nickname [password]
	
	uƒS[ƒXƒgv‚Æ‚¢‚¤Ú‘±‚ðØ’f‚µ‚Ü‚·BƒS[ƒXƒg‚ÍA–{“–‚É‘¶Ý
	‚µ‚Ä‚¢‚È‚¢Ú‘±‚Ì‚±‚Æ‚Å‚·B•’Ê‚ÍAƒS[ƒXƒg‚ªo‚é‚Ì‚Íƒpƒ\ƒR
	ƒ“‚ªƒtƒŒ[ƒY‚µ‚½‚èƒ‚ƒfƒ‚ÌÚ‘±‚ªØ’f‚³‚ê‚½‚è‚·‚é‚Æ‚«‚Å‚·B
	‚à‚¿‚ë‚ñAƒS[ƒXƒg‚¾‚¯‚Å‚È‚­•’Ê‚Ìƒ†[ƒU‚à‚±‚ÌƒRƒ}ƒ“ƒh‚Å
	Ø’f‚Å‚«‚Ü‚·‚ªA‘½‚­‚ÌIRCƒNƒ‰ƒCƒAƒ“ƒg‚ÍØ’f‚³‚ê‚½‚ç‚·‚®ÄÚ
	‘±‚µ‚Ü‚·‚Ì‚ÅA‚±‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚Á‚Ä‚àƒjƒbƒN‚ðŽæ‚è–ß‚¹‚È‚¢‚±
	‚Æ‚à‚ ‚è‚Ü‚·B‚»‚Ìê‡‚ÍARECOVER‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚Á‚Ä‰º‚³‚¢B
	
	GHOST‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚¤‚Ì‚É‚ÍAŒ»Ý‚Ìƒ†[ƒUƒAƒhƒŒƒX‚ª
	nickname‚Æ‚¢‚¤ƒjƒbƒN‚ÌƒAƒNƒZƒXˆê——‚É‚ ‚é•K—v‚ª‚ ‚è‚Ü‚·B‚Ü‚½A
	ƒpƒXƒ[ƒh‚ð“ü—Í‚·‚ê‚ÎƒS[ƒXƒg‚ðØ’f‚Å‚«‚Ü‚·B

NICK_HELP_INFO
	ƒVƒ“ƒ^ƒNƒXFINFO nickname
	
	nickname‚Æ‚¢‚¤ƒjƒbƒN‚Ìî•ñi•Û—LŽÒ‚Ì–¼‘OEƒ†[ƒUƒAƒhƒŒƒXA
	‘O‚ÌŽg—p‚µ‚½“úŽžAƒIƒvƒVƒ‡ƒ“‚ÌÝ’è‚È‚Çj‚ð•\‚µ‚Ü‚·B

NICK_HELP_LIST
	ƒVƒ“ƒ^ƒNƒXFLIST pattern
	
	pattern‚É‡‚¤ƒjƒbƒN‚Æ‚»‚ÌƒjƒbƒN‚Ìƒ†[ƒUƒAƒhƒŒƒX‚ð•\‚µ‚Ü
	‚·B‚½‚¾‚µAŽ„“IƒIƒvƒVƒ‡ƒ“‚ª ON ‚ÌƒjƒbƒN‚Í•\‚ê‚Ü‚¹‚ñB
	pattern‚ðnick!user@host‚Æ‚¢‚¤Œ`‚Å“ü—Í‚µ‚Ä‰º‚³‚¢B
	
	—áF
	    LIST *!joeuser@foo.com
	        joeuser@foo.com‚ª•Û—L‚µ‚Ä‚¢‚éƒjƒbƒN‚ð•\‚µ‚Ü‚·B
	    LIST *Bot*!*@*
	        uBotv‚ðŠÜ‚ÞƒjƒbƒN‚ð•\‚µ‚Ü‚·B
	    LIST *!*@*.bar.org
	        bar.org‚Ìƒ†[ƒU‚ª•Û—L‚µ‚Ä‚¢‚éƒjƒbƒN‚ð•\‚µ‚Ü‚·B

NICK_HELP_STATUS
	ƒVƒ“ƒ^ƒNƒXFSTATUS nickname...
	
#@@@ –¼óEChanServ‚É‚à‚ ‚é
	nickname‚Æ‚¢‚¤ƒjƒbƒN‚ðŽg—p‚µ‚Ä‚¢‚éƒ†[ƒU‚Í‚»‚ÌƒjƒbƒN‚Ì•Û
	—LŽÒ‚Å‚ ‚é‚©‚»‚¤‚Å‚È‚¢‚©‚Æ‚¢‚¤‚±‚Æ‚ð•\Ž¦‚µ‚Ü‚·B‰ž“š‚Í‚±‚Ì
	Œ`‚Å‚·F
	
	    nickname status-code
	
	nickname‚ÍƒRƒ}ƒ“ƒh‚ð“ü—Í‚µ‚½‚Æ‚«‚Æ“¯‚¶ƒjƒbƒN‚ÅAstatus-code
	‚ÍŽŸ‚Ì”’l‚Ìˆê‚Â‚Å‚·B
	
	    0 - ƒ†[ƒU‚ÍŒ»ÝÚ‘±‚µ‚Ä‚¢‚È‚¢‚©AƒjƒbƒN‚Í“o˜^‚³‚ê‚Ä
	        @@‚¢‚È‚¢
	    1 - ƒ†[ƒU‚Í•Û—LŽÒ‚Å‚Í‚È‚¢‚©AƒZƒLƒ…ƒAƒIƒvƒVƒ‡ƒ“‚Í“ü
	        @@‚ÉÝ’è‚³‚ê‚Ä‚¢‚Äƒ†[ƒU‚ÍƒpƒXƒ[ƒh‚ð“ü—Í‚µ‚Ä
	        @@‚¢‚È‚¢
	    2 - ƒ†[ƒU‚ÌƒAƒhƒŒƒX‚ÍƒAƒNƒZƒXˆê——‚É‚ ‚èAƒZƒLƒ…ƒAƒIƒv
	        @@ƒVƒ‡ƒ“‚ÍƒIƒt‚ÉÝ’è‚³‚ê‚Ä‚¢‚é
	    3 - ƒ†[ƒU‚ÍIDENTIFY‚ÅƒpƒXƒ[ƒh‚ð“ü—Í‚µ‚½
	
	ƒRƒ}ƒ“ƒh‚¸‚Â‚ÉƒjƒbƒN‚ð16ˆÈ‰º‚ð“ü—Í‚Å‚«‚Ü‚·‚ªA17ˆÈã‚Ìê‡
	‚ÆƒjƒbƒN‚ð“ü—Í‚µ‚È‚¢ê‡‚É‚ÍƒGƒ‰[ƒƒbƒZ[ƒW‚Ío‚Ü‚¹‚ñB

NICK_SERVADMIN_HELP
	
	Services‚ÌƒAƒhƒ~ƒ“‚ÍŽŸ‚ÌƒRƒ}ƒ“ƒh‚àŽg‚¦‚Ü‚·B
	
	    GETPASS    ƒjƒbƒN‚ÌƒpƒXƒ[ƒh‚ðŒ©‚é
	               @@iˆÃ†‰»‚ªŽg‚í‚ê‚Ä‚¢‚È‚¢ê‡‚Ì‚Ýj
	    FORBID     ƒjƒbƒN‚ðŽg—p•s‰Â”\‚É‚·‚é
	
	‚È‚¨AServices‚ÌƒAƒhƒ~ƒ“‚ÍƒpƒXƒ[ƒh‚ð“ü—Í‚¹‚¸‚ÉƒjƒbƒN‚Ì“o
	˜^‚ðÁ‹Ž‚·‚é‚±‚Æ‚àƒAƒNƒZƒXˆê——‚ðŒ©‚é‚±‚Æ‚ào—ˆ‚Ü‚·BƒAƒNƒZƒX
	•\‚ðŒ©‚é‚Ì‚É‚Íu/msg %S ACCESS LIST nickv‚Æ‚¢‚¤Œ`‚ð
	Žg‚¤‚Ì‚Å‚·B

NICK_SERVADMIN_HELP_DROP
	ƒVƒ“ƒ^ƒNƒXFDROP [nickname]
	
	ƒpƒ‰ƒ[ƒ^‚ª‚È‚¢ê‡‚ÍAŒ»ÝŽg—p‚µ‚Ä‚¢‚éƒjƒbƒN‚ð%S
	‚Ìƒf[ƒ^ƒx[ƒX‚©‚çÁ‹Ž‚µ‚Ü‚·B
	
	ƒpƒ‰ƒ[ƒ^‚ª‚ ‚éê‡‚ÍA“ü—Í‚µ‚½ƒjƒbƒN‚ðƒf[ƒ^ƒx[ƒX‚©‚ç
	Á‹Ž‚µ‚Ü‚·B‚±‚ÌŽg‚¢•û‚ðŽg‚¦‚é‚Ì‚ÍServices‚ÌƒAƒhƒ~ƒ“‚Ì‚Ý‚Å
	‚·B

NICK_SERVADMIN_HELP_SET
	
	Services‚ÌƒAƒhƒ~ƒ“‚ÍNOEXPIRE‚Æ‚¢‚¤ƒIƒvƒVƒ‡ƒ“‚ðÝ’è‚Å‚«‚Ü‚·B
	‚±‚ÌƒIƒvƒVƒ‡ƒ“‚ÅƒjƒbƒN‚Ì“o˜^‚ðØ‚ê‚È‚­‚·‚é‚±‚Æ‚ªo—ˆ‚Ü‚·B
	‚È‚¨AServices‚ÌƒAƒhƒ~ƒ“‚ÍƒpƒXƒ[ƒh‚ð“ü—Í‚¹‚¸‚É‚Ç‚ÌƒjƒbƒN
	‚Å‚àƒIƒvƒVƒ‡ƒ“‚ðÝ’è‚Å‚«‚Ü‚·B‘¼‚ÌƒjƒbƒN‚ÌƒIƒvƒVƒ‡ƒ“‚ðÝ’è
	‚·‚éê‡‚ÍuSET nickname option parametersv‚Æ‚¢‚¤Œ`‚Å‚·B

NICK_SERVADMIN_HELP_SET_NOEXPIRE
	ƒVƒ“ƒ^ƒNƒXFSET NOEXPIRE [nickname] {ON | OFF}
	
	nickname‚Æ‚¢‚¤ƒjƒbƒN‚Ì“o˜^‚ÍØ‚ê‚é‚©‚ðÝ’è‚µ‚Ü‚·BON‚É‚·‚é
	‚ÆA“o˜^‚ÍØ‚ê‚Ü‚¹‚ñBƒjƒbƒN‚ð“ü—Í‚µ‚È‚¢ê‡‚ÍAŽ©•ª‚Ìƒjƒb
	ƒN‚ÌƒIƒvƒVƒ‡ƒ“‚ðÝ’è‚µ‚Ü‚·B
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚ÍServices‚ÌƒAƒhƒ~ƒ“‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

NICK_SERVADMIN_HELP_UNLINK
	
	Services‚ÌƒAƒhƒ~ƒ“‚ÍAƒpƒXƒ[ƒh‚ð“ü—Í‚¹‚¸‚É‚Ç‚ÌƒjƒbƒN‚ÌƒŠƒ“
	ƒN‚Å‚àÁ‹Ž‚Å‚«‚Ü‚·B

NICK_SERVADMIN_HELP_LISTLINKS
	ƒVƒ“ƒ^ƒNƒXFLISTLINKS nickname [ALL]
	
	“ü—Í‚µ‚½ƒjƒbƒN‚ÉƒŠƒ“ƒN‚µ‚Ä‚¢‚éƒjƒbƒN‚ð•\‚µ‚Ü‚·BALL ‚ð“ü—Í‚·
	‚é‚ÆA‘ÎÛƒjƒbƒN‚Æ“¯‚¶Œ —˜‚ðŽ‚Á‚Ä‚¢‚éƒjƒbƒN‚ð‘S‚Ä•\‚µA“ü—Í
	‚µ‚È‚¢ê‡‚ÍA‘ÎÛƒjƒbƒN‚ªƒŠƒ“ƒN‚Ì’¼Ú‘ÎÛ‚É‚È‚Á‚Ä‚¢‚éƒjƒbƒN
	‚¾‚¯‚ð•\‚µ‚Ü‚·B
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚ÍServices‚ÌƒAƒhƒ~ƒ“‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

NICK_SERVADMIN_HELP_LIST
	ƒVƒ“ƒ^ƒNƒXFLIST pattern [FORBIDDEN] [NOEXPIRE]
	
	pattern‚É‡‚¤ƒjƒbƒN‚Æ‚»‚ÌƒjƒbƒN‚Ìƒ†[ƒUƒAƒhƒŒƒX‚ð•\‚µ‚Ü
	‚·B‚½‚¾‚µAŽ„“IƒIƒvƒVƒ‡ƒ“‚ÌON‚ÌƒjƒbƒN‚ÍServices‚ÌƒAƒhƒ~ƒ“
	‚É‚µ‚©•\‚ê‚Ü‚¹‚ñBpattern‚ðnick!user@host‚Æ‚¢‚¤Œ`‚Å“ü—Í
	‚µ‚Ä‰º‚³‚¢B
	
	‚Ü‚½AServices‚ÌƒAƒhƒ~ƒ“‚É‚Ì‚ÝA“o˜^‚ÌØ‚ê‚È‚¢ƒjƒbƒN‚Ì“ª‚É
	u!vˆó‚ª•\‚ê‚Ü‚·B
	
	FORBIDDEN ‚Ü‚½‚Í NOEXPIRE ‚ð’Ç‰Á‚·‚ê‚ÎAƒŠƒXƒg‚É•\‚ê‚éƒjƒb
	ƒN‚ð§ŒÀ‚·‚é‚±‚Æ‚ªo—ˆ‚Ü‚·BFORBIDDEN ‚Ìê‡‚ÍŽg—p‹ÖŽ~ƒjƒb
	ƒNANOEXPIRE ‚Ìê‡‚Í“o˜^‚ÌØ‚ê‚È‚¢ƒjƒbƒN‚ª•\‚ê‚Ü‚·B—¼•û
	‚ð“ü—Í‚·‚ê‚ÎA—¼•û‚Ìƒ^ƒCƒv‚ÌƒjƒbƒN‚ª•\‚ê‚Ü‚·B‚½‚¾‚µA‚±‚Ì
	ƒIƒvƒVƒ‡ƒ“‚ðŽg‚¤‚Ì‚ÍServices‚ÌƒAƒhƒ~ƒ“‚Ì‚Ý‚Å‚·B
	
	—áF
	    LIST *!joeuser@foo.com
	        joeuser@foo.com‚ª•Û—L‚µ‚Ä‚¢‚éƒjƒbƒN‚ð•\‚µ‚Ü‚·B
	    LIST *Bot*!*@*
	        uBotv‚ðŠÜ‚ÞƒjƒbƒN‚ð•\‚µ‚Ü‚·B
	    LIST * NOEXPIRE
	        “o˜^‚ÌØ‚ê‚È‚¢ƒjƒbƒN‚ð‘S‚Ä•\‚µ‚Ü‚·B

NICK_SERVADMIN_HELP_GETPASS
	ƒVƒ“ƒ^ƒNƒXFGETPASS nickname
	
	nickname‚Æ‚¢‚¤ƒjƒbƒN‚ÌƒpƒXƒ[ƒh‚ð•\Ž¦‚µ‚Ü‚·B‚±‚ÌƒRƒ}ƒ“ƒh
	‚ðŽg‚¤‚ÆAƒRƒ}ƒ“ƒh‚ð“ü—Í‚µ‚½ƒ†[ƒU‚ÌƒjƒbƒN‚ÆƒpƒXƒ[ƒh‚ð
	o‚µ‚½ƒjƒbƒN‚ðŠÜ‚ÞƒƒbƒZ[ƒW‚ÍƒƒbƒO‚³‚êAWALLOPS‚©GLOBOPS
	‚ÅƒIƒyƒŒ[ƒ^‚É•ú‘—‚³‚ê‚Ü‚·B
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚ÍServices‚ÌƒAƒhƒ~ƒ“‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B
	
	ˆÃ†‰»‚ªŽg‚í‚ê‚Ä‚¢‚éê‡‚ÍA‚±‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚¦‚Ü‚¹‚ñB

NICK_SERVADMIN_HELP_FORBID
	ƒVƒ“ƒ^ƒNƒXFFORBID nickname
	
	ƒjƒbƒN‚ðŽg—p•s‰Â”\‚É‚µ‚Ü‚·BƒLƒƒƒ“ƒZƒ‹‚É‚ÍDROP‚ÌƒRƒ}ƒ“ƒh‚ª
	Žg‚¦‚Ü‚·B
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚ÍServices‚ÌƒAƒhƒ~ƒ“‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

###########################################################################
#
# ChanServ‚Ìƒwƒ‹ƒvƒƒbƒZ[ƒW
#
###########################################################################

#CHAN_HELP
#	%S‚ÍAƒ`ƒƒƒ“ƒlƒ‹‚Ì“o˜^ƒT[ƒrƒX‚Å‚·B‚±‚ÌƒT[ƒrƒX‚ðŽg
#	‚Á‚Äƒ`ƒƒƒ“ƒlƒ‹‚ð“o˜^‚·‚ê‚ÎAƒ`ƒƒƒ“ƒlƒ‹‚ÌƒAƒNƒZƒX‚ð§Œäo—ˆ
#	‚é‚µAFX‚ÈƒIƒvƒVƒ‡ƒ“‚àÝ’è‚Å‚«‚Ü‚·Bƒ`ƒƒƒ“ƒlƒ‹‚Ì“o˜^‚â§
#	Œä‚ÌƒRƒ}ƒ“ƒh‚ÍŽŸ‚Ì’Ê‚è‚Å‚·BƒRƒ}ƒ“ƒh‚ðŽg‚¤ê‡‚ÍAu/msg
#	%S commandv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B‚Ü‚½AƒRƒ}ƒ“ƒh‚Ìƒwƒ‹ƒv
#	‚ð“Ç‚Þê‡‚Íu/msg %S HELP commandv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B
#	
#	    REGISTER   ƒ`ƒƒƒ“ƒlƒ‹‚Ì“o˜^
#	    IDENTIFY   ƒ`ƒƒƒ“ƒlƒ‹‚ÌƒpƒXƒ[ƒh‚Ì“ü—Í
#	    SET        ƒ`ƒƒƒ“ƒlƒ‹‚ÌƒIƒvƒVƒ‡ƒ“‚Ì•ÏX
#	    ACCESS     “ÁŒ ‚Ìƒ†[ƒU•\‚Ì•ÏX
##@@@ u’Ç•úv
#	    AKICK      ’Ç•ú‚µ‚½ƒ†[ƒU•\‚Ì•ÏX
#	    DROP       ƒ`ƒƒƒ“ƒlƒ‹‚Ì“o˜^‚ÌÁ‹Ž
#	
#	‘¼‚ÌƒRƒ}ƒ“ƒhFINFOELISTEINVITEEOPEDEOPEUNBANECLEAR

CHAN_HELP_EXPIRES
	
	’ˆÓF“o˜^‚µ‚½ƒ`ƒƒƒ“ƒlƒ‹‚Í%d“úŠÔŽg—p‚³‚ê‚È‚¢‚ÆA“o˜^‚ÍØ
	‚ê‚Ü‚·B

CHAN_HELP_REGISTER
	ƒVƒ“ƒ^ƒNƒXFREGISTER channel password description
	
	%S‚Ìƒf[ƒ^ƒx[ƒX‚Åƒ`ƒƒƒ“ƒlƒ‹‚ð“o˜^‚µ‚Ü‚·B‚±‚ÌƒRƒ}ƒ“
	ƒh‚ðŽg‚¤‚Ì‚ÍAƒ`ƒƒƒ“ƒlƒ‹‚ÌƒIƒyƒŒ[ƒ^‚Ì‚Ý‚Å‚·Bpassword‚Í
	ƒ`ƒƒƒ“ƒlƒ‹‚ÌƒIƒvƒVƒ‡ƒ“‚ð•ÏX‚·‚éˆ×‚ÌƒpƒXƒ[ƒh‚Å‚·BÅŒã‚Ì
	ƒpƒ‰ƒ[ƒ^‚Íƒ`ƒƒƒ“ƒlƒ‹‚Ì–¼ó‚Å‚·B
	
	ƒ`ƒƒƒ“ƒlƒ‹‚ð“o˜^‚·‚é‚ÆA“o˜^‚µ‚½ƒ†[ƒU‚Í‚»‚Ìƒ`ƒƒƒ“ƒlƒ‹‚Ì
	uƒtƒ@ƒEƒ“ƒ_[v‚É‚È‚è‚Ü‚·Bƒ`ƒƒƒ“ƒlƒ‹‚Ìƒtƒ@ƒEƒ“ƒ_[‚Í‘S‚Ä
	‚Ìƒ`ƒƒƒ“ƒlƒ‹‚ÌƒIƒvƒVƒ‡ƒ“‚ð•ÏXo—ˆ‚é‚µAƒ`ƒƒƒ“ƒlƒ‹‚É“ü‚é‚Æ
	%S‚ÍŽ©“®“I‚Éƒtƒ@ƒEƒ“ƒ_[‚ð+oƒ‚[ƒh‚É‚µ‚Ü‚·B‚±‚Ì“ÁŒ 
	‚Ìˆê•”‚ð‘¼‚Ìƒ†[ƒU‚Éã‚°‚½‚¢ê‡‚Íu/msg %S HELP
	ACCESSv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B
	
	’ˆÓFƒ`ƒƒƒ“ƒlƒ‹‚ð“o˜^‚·‚é‚Ì‚É‚ÍAƒjƒbƒN‚ð“o˜^‚·‚é•K—v‚ª‚ 
	‚è‚Ü‚·BƒjƒbƒN‚ð“o˜^‚µ‚Ä‚¢‚È‚¢ƒ†[ƒU‚Íu/msg %s HELPv
	‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B

CHAN_HELP_IDENTIFY
	ƒVƒ“ƒ^ƒNƒXFIDENTIFY channel password
	
	%S‚Éƒ`ƒƒƒ“ƒlƒ‹‚Ì•Û—LŽÒ‚Å‚ ‚éØ‹’‚ðŽ¦‚µ‚Ü‚·B‚±‚ÌƒRƒ}
	ƒ“ƒh‚ðŽg‚í‚È‚¯‚ê‚ÎALEVELSESET FOUNDERESET PASSWORDEDROP
	‚ÌƒRƒ}ƒ“ƒh‚ªŽg‚¦‚Ü‚¹‚ñB‚È‚¨Aƒtƒ@ƒEƒ“ƒ_[‚ÌƒjƒbƒN‚ðŽg—p‚µ
	‚Ä‚¢‚È‚¢‚Æ‚«‚ÍA‚±‚ÌƒRƒ}ƒ“ƒh‚ð“ü—Í‚·‚ê‚Îƒtƒ@ƒEƒ“ƒ_[‚Ì“ÁŒ 
	‚ð“¾‚Ü‚·Bpassword‚ÍREGISTER‚ÌƒRƒ}ƒ“ƒh‚ð“ü—Í‚µ‚½‚Æ‚«‚Ì‚Æ
	“¯‚¶ƒpƒXƒ[ƒh‚Å‚·B

CHAN_HELP_DROP
	ƒVƒ“ƒ^ƒNƒXFDROP channel
	
	channel‚Æ‚¢‚¤ƒ`ƒƒƒ“ƒlƒ‹‚ð%S‚Ìƒf[ƒ^ƒx[ƒX‚©‚çÁ‹Ž‚µ‚Ü‚·B
	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚Íƒtƒ@ƒEƒ“ƒ_[‚ÉŒÀ‚Á‚Ä‚¢‚ÄAƒpƒXƒ[ƒh
	‚ð“ü—Í‚·‚é•K—v‚à‚ ‚è‚Ü‚·B

#CHAN_HELP_SET
#	ƒVƒ“ƒ^ƒNƒXFSET channel option parameters
#	
#	ƒ`ƒƒƒ“ƒlƒ‹‚ÌƒIƒvƒVƒ‡ƒ“‚âî•ñ‚ð•ÏX‚µ‚Ü‚·Bƒtƒ@ƒEƒ“ƒ_[‚Æƒp
#	ƒXƒ[ƒh‚ð•ÏX‚·‚é‚Ì‚É‚ÍAƒ`ƒƒƒ“ƒlƒ‹‚ÌƒpƒXƒ[ƒh‚ðIDENTIFY
#	‚ÌƒRƒ}ƒ“ƒh‚Å“ü—Í‚·‚é•K—v‚ª‚ ‚è‚Ü‚·BƒIƒvƒVƒ‡ƒ“‚ÍŽŸ‚Ì’Ê‚è‚Å
#	‚·B
#	
#	    FOUNDER     ƒtƒ@ƒEƒ“ƒ_[‚Ì•ÏX
#	    SUCCESSOR   ŽŸŠúƒtƒ@ƒEƒ“ƒ_[‚Ì•ÏX
#	    PASSWORD    ƒpƒXƒ[ƒh‚Ì•ÏX
#	    DESC        ƒ`ƒƒƒ“ƒlƒ‹‚Ì–¼ó‚Ì•ÏX
#	    URL         ƒz[ƒƒy[ƒW‚ÌƒAƒhƒŒƒX‚Ì“ü—Í
#	    EMAIL       “dŽqƒ[ƒ‹‚ÌƒAƒhƒŒƒX‚Ì“ü—Í
#	    ENTRYMSG    ƒ`ƒƒƒ“ƒlƒ‹‚É“ü‚é‚Æ‚«‚Éo‚éƒƒbƒZ[ƒW‚Ì“ü—Í
#	    TOPIC       Œ»Ý‚Ìƒ`ƒƒƒ“ƒlƒ‹‚ÌƒgƒsƒbƒN‚Ì•ÏX
##@@@  uŠo‚¦‚évE‰º‚Ìu‚±‚ÆvAu‚Æ‚¢‚¤ƒIƒvƒVƒ‡ƒ“v
#	    KEEPTOPIC   ƒ`ƒƒƒ“ƒlƒ‹‚ªŽg—p‚³‚ê‚Ä‚¢‚È‚¢ŠÔ‚É‚àƒgƒsƒbƒN
#	                @@‚ðŠo‚¦‚é‚±‚Æ‚Ì“üØ
#	    TOPICLOCK   SET TOPICƒRƒ}ƒ“ƒh‚Å‚µ‚©ƒgƒsƒbƒN‚ð•ÏX‚³‚¹
#	                @@‚È‚¢‚Æ‚¢‚¤ƒIƒvƒVƒ‡ƒ“‚Ì“üØ
#	    MLOCK       ƒ`ƒƒƒ“ƒlƒ‹‚Ìƒ‚[ƒh‚ðƒIƒ“EƒIƒt‚ÉƒƒbƒN‚·‚é
#	    PRIVATE     LISTƒRƒ}ƒ“ƒh‚©‚çƒ`ƒƒƒ“ƒlƒ‹‚ð‰B‚·
#	    RESTRICTED  “ÁŒ ‚ðŽ‚Á‚Ä‚¢‚È‚¢ƒ†[ƒU‚ðƒ`ƒƒƒ“ƒlƒ‹‚É“ü
#	                @@‚ê‚È‚¢‚Æ‚¢‚¤ƒIƒvƒVƒ‡ƒ“‚Ì“üØ
#	    SECURE      ƒZƒLƒ…ƒAƒIƒvƒVƒ‡ƒ“‚Ì“üØ
#	    SECUREOPS   +oƒ‚[ƒh‚Ì§Œä‚ðŒµ‚µ‚­‚·‚é
#	    LEAVEOPS	DEOPƒRƒ}ƒ“ƒh‚Å‚µ‚©-oƒ‚[ƒh‚ðŠ|‚¯‚È‚¢
#	    OPNOTICE	OPEDEOPƒRƒ}ƒ“ƒh‚ªŽg‚í‚ê‚é“x‚É•ñ
#	
#	ƒIƒvƒVƒ‡ƒ“‚Ìî•ñ‚ð“Ç‚Þ‚Ì‚É‚ÍAu/msg %S HELP optionv
#	‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B

CHAN_HELP_SET_FOUNDER
	ƒVƒ“ƒ^ƒNƒXFSET channel FOUNDER nick
	
	ƒtƒ@ƒEƒ“ƒ_[‚ð•ÏX‚µ‚Ü‚·B‚½‚¾‚µAnick‚Æ‚¢‚¤ƒjƒbƒN‚ª“o˜^
	‚³‚ê‚Ä‚¢‚È‚¢‚Æ•ÏXo—ˆ‚Ü‚¹‚ñB

CHAN_HELP_SET_SUCCESSOR
	ƒVƒ“ƒ^ƒNƒXFSET channel SUCCESSOR nick
	
	ŽŸŠúƒtƒ@ƒEƒ“ƒ_[‚ð•ÏX‚µ‚Ü‚·BŽŸŠúƒtƒ@ƒEƒ“ƒ_[‚Æ‚ÍAŒ»Ý‚Ì
	ƒtƒ@ƒEƒ“ƒ_[‚ÌƒjƒbƒN‚Ì“o˜^‚ªØ‚ê‚½‚èÁ‹Ž‚³‚ê‚½‚è‚·‚é‚Æƒtƒ@ƒE
	ƒ“ƒ_[‚É‚È‚éƒ†[ƒU‚Å‚·BŽŸŠúƒtƒ@ƒEƒ“ƒ_[‚ªÝ’è‚³‚ê‚Ä‚¢‚È‚¢
	ê‡‚ÍAƒtƒ@ƒEƒ“ƒ_[‚ÌƒjƒbƒN‚Ì“o˜^‚ªØ‚ê‚é‚ÆAƒ`ƒƒƒ“ƒlƒ‹‚Ì“o
	˜^‚àÁ‹Ž‚³‚ê‚Ä‚µ‚Ü‚¢‚Ü‚·B‚½‚¾‚µAƒtƒ@ƒEƒ“ƒ_[‚ÌƒjƒbƒN‚Ì“o˜^
	‚ªØ‚ê‚éŽž“_‚ÅŽŸŠúƒtƒ@ƒEƒ“ƒ_[‚Íƒ`ƒƒƒ“ƒlƒ‹‚ÌŒÀ‚èi%dj‚ð‰z‚¦
	‚Ä‚¢‚ê‚ÎAŽŸŠúƒtƒ@ƒEƒ“ƒ_[‚ªÝ’è‚³‚ê‚Ä‚¢‚È‚¢‚æ‚¤‚Éƒ`ƒƒƒ“ƒlƒ‹
	‚Ì“o˜^‚ÍÁ‚¦‚Ä‚µ‚Ü‚¢‚Ü‚·B
	
	ŽŸŠúƒtƒ@ƒEƒ“ƒ_[‚É‚·‚éƒjƒbƒNinickj‚Í“o˜^‚µ‚Ä‚¢‚È‚¯‚ê‚Î‚È‚è
	‚Ü‚¹‚ñB

CHAN_HELP_SET_PASSWORD
	ƒVƒ“ƒ^ƒNƒXFSET channel PASSWORD password
	
	ƒtƒ@ƒEƒ“ƒ_[‚ÌƒpƒXƒ[ƒh‚ð•ÏX‚µ‚Ü‚·B

CHAN_HELP_SET_DESC
	ƒVƒ“ƒ^ƒNƒXFSET channel DESC description
	
	ƒ`ƒƒƒ“ƒlƒ‹‚Ì–¼ó‚ð•ÏX‚µ‚Ü‚·B–¼ó‚ÍLISTEINFO‚ÌƒRƒ}ƒ“ƒh‚Ì
	î•ñ‚Å•\‚ê‚Ü‚·B

#CHAN_HELP_SET_URL
#	ƒVƒ“ƒ^ƒNƒXFSET channel URL [url]
#	
#	url‚Æ‚¢‚¤ƒz[ƒƒy[ƒW‚ÌƒAƒhƒŒƒX‚ðƒ`ƒƒƒ“ƒlƒ‹‚Ìî•ñ‚É’Ç‰Á‚µ‚Ü
#	‚·B‚±‚ÌƒAƒhƒŒƒX‚ÍINFO‚ÌƒRƒ}ƒ“ƒh‚Ìî•ñ‚Å•\‚ê‚Ü‚·Bƒpƒ‰ƒ[
#	ƒ^[‚ð“ü—Í‚µ‚È‚¢ê‡‚ÍAƒz[ƒƒy[ƒW‚ÌƒAƒhƒŒƒX‚ÍÁ‹Ž‚³‚ê‚Ü
#	‚·B

#CHAN_HELP_SET_EMAIL
#	ƒVƒ“ƒ^ƒNƒXFSET channel EMAIL [address]
#	
#	address‚Æ‚¢‚¤“dŽqƒ[ƒ‹‚ÌƒAƒhƒŒƒX‚ðƒ`ƒƒƒ“ƒlƒ‹‚Ìî•ñ‚É’Ç‰Á‚µ
#	‚Ü‚·B‚±‚ÌƒAƒhƒŒƒX‚ÍINFO‚ÌƒRƒ}ƒ“ƒh‚Ìî•ñ‚Å•\‚ê‚Ü‚·Bƒpƒ‰
#	ƒ[ƒ^[‚ð“ü—Í‚µ‚È‚¢ê‡‚ÍA“dŽqƒ[ƒ‹‚ÌƒAƒhƒŒƒX‚ÍÁ‹Ž‚³‚ê
#	‚Ü‚·B

#CHAN_HELP_SET_ENTRYMSG
#	ƒVƒ“ƒ^ƒNƒXFSET channel ENTRYMSG [message]
#	
#	message‚Æ‚¢‚¤ƒeƒLƒXƒg‚ðƒ`ƒƒƒ“ƒlƒ‹‚É“ü‚éƒ†[ƒU‚Éo‚µ‚Ü‚·B
#	ƒpƒ‰ƒ[ƒ^‚ð“ü—Í‚µ‚È‚¢ê‡‚ÍAƒƒbƒZ[ƒW‚ÍÁ‹Ž‚³‚ê‚Ü‚·B

CHAN_HELP_SET_TOPIC
	ƒVƒ“ƒ^ƒNƒXFSET channel TOPIC topic
	
	%S‚Éƒ`ƒƒƒ“ƒlƒ‹‚ÌƒgƒsƒbƒN‚ð•ÏX‚³‚¹‚Ü‚·B‚¾‚¢‚½‚¢A
	SET LOCKTOPIC‚ÌƒRƒ}ƒ“ƒh‚Æˆê‚ÉŽg‚í‚ê‚Ü‚·B

CHAN_HELP_SET_KEEPTOPIC
	ƒVƒ“ƒ^ƒNƒXFSET channel KEEPTOPIC {ON | OFF}
	
	uƒgƒsƒbƒN‹L˜^v‚Æ‚¢‚¤ƒIƒvƒVƒ‡ƒ“‚ðÝ’è‚µ‚Ü‚·BƒgƒsƒbƒN‹L˜^
	‚ÍAƒ`ƒƒƒ“ƒlƒ‹‚ÌŒ»Ý‚ÌƒgƒsƒbƒN‚ð‹L˜^‚µAƒ`ƒƒƒ“ƒlƒ‹‚ªÁ‚¦‚Ä
	‚à‚»‚ÌƒgƒsƒbƒN‚ðŠo‚¦Aƒ`ƒƒƒ“ƒlƒ‹‚ª‚Ü‚½ì‚ç‚ê‚é‚Æ‚«‚Éƒgƒsƒb
	ƒN‚ð–ß‚·‚Æ‚¢‚¤ƒIƒvƒVƒ‡ƒ“‚Å‚·B

CHAN_HELP_SET_TOPICLOCK
	ƒVƒ“ƒ^ƒNƒXFSET channel TOPICLOCK {ON | OFF}
	
	uƒgƒsƒbƒNƒƒbƒNv‚Æ‚¢‚¤ƒIƒvƒVƒ‡ƒ“‚ðÝ’è‚µ‚Ü‚·BON‚É‚·‚é‚ÆA
	ƒgƒsƒbƒN‚Í%S‚ÌSET TOPIC‚ÌƒRƒ}ƒ“ƒh‚Å‚µ‚©•Ï‚¦‚ç‚ê‚È‚­‚È‚è‚Ü
	‚·B

CHAN_HELP_SET_MLOCK
	ƒVƒ“ƒ^ƒNƒXFSET channel MLOCK modes
	
	ƒ‚[ƒhƒƒbƒN‚ðÝ’è‚µ‚Ü‚·B%S‚É‚æ‚Á‚ÄAƒ`ƒƒƒ“ƒlƒ‹‚Ì“ü
	Øƒ‚[ƒhiiEkElEmEnEpEsEtj‚ðƒIƒ“‚©ƒIƒt‚ÉƒƒbƒN‚Å‚«
	‚Ü‚·Bmodes‚Æ‚¢‚¤ƒpƒ‰ƒ[ƒ^‚ÍIRC‚Ìu/MODEv‚Æ‚¢‚¤ƒRƒ}ƒ“ƒh
	‚Æ“¯‚¶Œ`‚ÅAu+v‚ÌŒã‚Ìƒ‚[ƒh‚ÍƒIƒ“‚ÉƒƒbƒN‚³‚êAu-v‚ÌŒã
	‚Ìƒ‚[ƒh‚ÍƒIƒt‚ÉƒƒbƒN‚³‚ê‚Ü‚·B
	
	’ˆÓF‰º‚Ì“ñ”Ô–Ú‚Ì—á‚Ì‚æ‚¤‚Éƒ`ƒƒƒ“ƒlƒ‹ƒL[‚ðƒƒbƒN‚·‚ê‚ÎA
	RESTRICTED‚Æ‚¢‚¤ƒIƒvƒVƒ‡ƒ“‚ðƒIƒ“‚É‚µ‚È‚¯‚ê‚Î’N‚É‚Å‚àƒL[‚ª
	Œ©‚¦‚Ü‚·B
	
	—áF
	    SET #channel MLOCK +nt-iklps
	       nEtƒ‚[ƒh‚ðƒIƒ“‚ÉƒƒbƒN‚µAiEkElEpEsƒ‚[ƒh‚ðƒI
	       ƒt‚ÉƒƒbƒN‚µ‚Ü‚·Bmƒ‚[ƒh‚ÍƒƒbƒN‚³‚ê‚Ü‚¹‚ñB
	
	    SET #channel MLOCK +knst-ilmp my-key
	       kEnEsEtƒ‚[ƒh‚ðƒIƒ“‚ÉƒƒbƒN‚µAiElEmEpƒ‚[ƒh‚ð
	       ƒIƒt‚ÉƒƒbƒN‚µ‚Ü‚·BƒL[‚ðumy-keyv‚ÉƒƒbƒN‚µ‚Ü‚·B
	
	    SET #channel MLOCK +
	       ƒ‚[ƒhƒƒbƒN‚ð‰ð‚«‚Ü‚·B

CHAN_HELP_SET_PRIVATE
	ƒVƒ“ƒ^ƒNƒXFSET channel PRIVATE {ON | OFF}
	
	uŽ„“Iv‚Æ‚¢‚¤ƒIƒvƒVƒ‡ƒ“‚ðÝ’è‚µ‚Ü‚·BON‚É‚·‚é‚ÆAƒ`ƒƒƒ“ƒl
	ƒ‹‚Íu/msg %S LISTv‚ÌƒŠƒXƒg‚Å•\‚ê‚Ü‚¹‚ñB

CHAN_HELP_SET_RESTRICTED
	ƒVƒ“ƒ^ƒNƒXFSET channel RESTRICTED {ON | OFF}
	
	ƒAƒNƒZƒX§ŒäƒIƒvƒVƒ‡ƒ“‚ðÝ’è‚µ‚Ü‚·BON‚É‚·‚é‚ÆA+oƒ‚[ƒh‚ð
	“¾‚ç‚ê‚È‚¢ƒ†[ƒUi•‰”‚ÌƒŒƒxƒ‹‚Ìƒ†[ƒUA‚»‚µ‚ÄƒZƒLƒ…ƒA
	ƒIƒvƒVƒ‡ƒ“‚ðON‚É‚·‚é‚ÆƒAƒNƒZƒXˆê——‚É‚È‚¢ƒ†[ƒUj‚Íƒ`ƒƒƒ“ƒl
	ƒ‹‚©‚ç‚É“ü‚ê‚È‚­‚È‚è‚Ü‚·B

CHAN_HELP_SET_SECURE
	ƒVƒ“ƒ^ƒNƒXFSET channel SECURE {ON | OFF}
	
	ƒZƒLƒ…ƒAƒIƒvƒVƒ‡ƒ“‚ðÝ’è‚µ‚Ü‚·BON‚É‚·‚é‚ÆAƒjƒbƒN‚ÌƒpƒX
	ƒ[ƒh‚ð“ü—Í‚µ‚Ä‚¢‚È‚¢ƒ†[ƒU‚Í“ÁŒ ‚ð“¾‚Ü‚¹‚ñBƒAƒNƒZƒX§
	ŒäƒIƒvƒVƒ‡ƒ“‚Æˆê‚ÉŽg‚¦‚ÎAƒpƒXƒ[ƒh‚ð“ü—Í‚µ‚Ä‚¢‚È‚¢ƒ†[
	ƒU[‚Íƒ`ƒƒƒ“ƒlƒ‹‚É“ü‚ê‚È‚­‚È‚è‚Ü‚·B

CHAN_HELP_SET_SECUREOPS
	ƒVƒ“ƒ^ƒNƒXFSET channel SECUREOPS {ON | OFF}
	
	+oƒ‚[ƒh‚Ì§Œä‚ðŒµ‚µ‚­‚·‚é‚±‚Æ‚ðÝ’è‚µ‚Ü‚·BON‚É‚·‚é‚ÆAƒA
	ƒNƒZƒX•\‚É‚È‚¢ƒ†[ƒU‚Í+oƒ‚[ƒh‚ð“¾‚ç‚ê‚È‚­‚È‚è‚Ü‚·B

#CHAN_HELP_SET_LEAVEOPS
#	ƒVƒ“ƒ^ƒNƒXFSET channel LEAVEOPS {ON | OFF}
#	
#	+oƒ‚[ƒh‚Ì§Œä‚ð‚â‚³‚µ‚­‚·‚é‚±‚Æ‚ðÝ’è‚µ‚Ü‚·BON‚É‚·‚é‚ÆA
#	%S‚ÍŽ©“®“I‚É-oƒ‚[ƒh‚ð‚©‚¯‚Ü‚¹‚ñB

CHAN_HELP_SET_OPNOTICE
	ƒVƒ“ƒ^ƒNƒXFSET channel LEAVEOPS {ON | OFF}
	
	OPEDEOP•ñƒIƒvƒVƒ‡ƒ“‚ðÝ’è‚µ‚Ü‚·BON‚É‚·‚é‚ÆAOP‚ÆDEOPƒRƒ}
	ƒ“ƒh‚ªŽg—p‚³‚ê‚é“x‚ÉA%S‚Íƒ`ƒƒƒ“ƒlƒ‹‚ÉƒƒbƒZ[ƒWi/NOTICEj
	‚ðo‚µ‚Ü‚·B

CHAN_HELP_ACCESS
	ƒVƒ“ƒ^ƒNƒXFACCESS channel ADD nick level
	@@@@@@ACCESS channel DEL {nick | entry-num | list}
	@@@@@@ACCESS channel LIST [mask | list]
	
	ƒ`ƒƒƒ“ƒlƒ‹‚ÌƒAƒNƒZƒXˆê——‚Ì•ÏX‚Æ•\Ž¦‚ÌƒRƒ}ƒ“ƒh‚Å‚·BƒAƒNƒZƒX
	•\‚ÍA“ÁŒ ‚Ì‚ ‚éƒ†[ƒU‚ÌƒŠƒXƒg‚ÅA‚Ç‚Ìƒ†[ƒU‚ª+oƒ‚[ƒh
	‚ð“¾‚ç‚ê‚é‚©‚Ç‚Ìƒ†[ƒU‚ª%S‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚¦‚é‚©ŠÜ‚Ý
	‚Ü‚·BleveliƒŒƒxƒ‹j‚Ì”’l‚É‚æ‚Á‚Ä‚Ç‚Ì“ÁŒ ‚ð“¾‚é‚©•Ï‚í‚è
	‚Ü‚·BÚ‚µ‚¢Ž–‚È‚çAu/msg %S HELP ACCESS LEVELSv‚ð
	“ü—Í‚µ‚Ä‰º‚³‚¢B
	
	ACCESS ADD‚Æ‚¢‚¤Œ`‚Åƒ†[ƒU‚ðƒAƒNƒZƒXˆê——‚É’Ç‰Á‚Å‚«‚Ü‚·‚ªA
	‚·‚Å‚ÉƒAƒNƒZƒXˆê——‚É‘¶Ý‚µ‚Ä‚¢‚éƒ†[ƒU‚ÌƒŒƒxƒ‹‚ð•ÏX‚·‚é‚±
	‚Æ‚ào—ˆ‚Ü‚·B’Ç‰Á‚Æ•ÏXo—ˆ‚é‚Ì‚ÍAƒRƒ}ƒ“ƒh‚ð“ü—Í‚·‚éƒ†[
	ƒU[‚ÌŒ»Ý‚ÌƒŒƒxƒ‹‚ðŠÜ‚Ü‚¸A‚»‚ÌƒŒƒxƒ‹ˆÈ‰º‚Ì‚Ý‚Å‚·B‚Ü‚½A
	ƒ†[ƒU‚ÌƒŒƒxƒ‹‚ð•ÏX‚·‚éê‡‚ÍA‚»‚Ìƒ†[ƒU‚ÌŒ»Ý‚ÌƒŒƒx
	ƒ‹‚Í“ü—Í‚·‚éƒ†[ƒU‚ÌƒŒƒxƒ‹ˆÈã‚È‚ç•ÏXo—ˆ‚Ü‚¹‚ñBƒtƒ@ƒE
	ƒ“ƒ_[‚È‚ç‚Ç‚ÌƒŒƒxƒ‹‚Å‚à’Ç‰Á‚Å‚«‚Ü‚·B
	
	ACCESS DEL‚Æ‚¢‚¤Œ`‚Åƒ†[ƒU‚ðƒAƒNƒZƒXˆê——‚©‚çÁ‹Ž‚Å‚«‚Ü‚·B
	Á‹Žo—ˆ‚é‚Ì‚ÍA“ü—Í‚·‚éƒ†[ƒU‚ÌƒŒƒxƒ‹‚ðŠÜ‚Ü‚¸A‚»‚ÌƒŒƒx
	ƒ‹ˆÈ‰º‚Ìƒ†[ƒU‚Ì‚Ý‚Å‚·B”Ô†—ñ‚ð“ü—Í‚·‚é‚±‚Æ‚ào—ˆ‚Ü‚·
	i‰º‹L‚ÌLIST‚Ì—á‚ÖŽQÆjB
	
	ACCESS LIST‚Æ‚¢‚¤Œ`‚ÅƒAƒNƒZƒXˆê——‚ðŒ©‚é‚±‚Æ‚ªo—ˆ‚Ü‚·Bƒ}ƒXƒN
	‚ð“ü—Í‚·‚ê‚ÎA‚»‚Ìƒ}ƒXƒN‚É‡‚¤ƒ†[ƒU‚µ‚©•\‚ê‚Ü‚¹‚ñB‰º‹L‚Ì
	—á‚Ì’Ê‚èA”Ô†—ñ‚ð“ü—Í‚·‚é‚±‚Æ‚ào—ˆ‚Ü‚·F
	
	    ACCESS #channel LIST 2-5,7-9
	       ‚Q`‚TA‚V`‚X”Ô–Ú‚ÌƒAƒNƒZƒXˆê——‚ÌƒGƒ“ƒgƒŠ[‚ð•\‚µ‚Ü‚·B

CHAN_HELP_ACCESS_LEVELS
	ƒ`ƒƒƒ“ƒlƒ‹‚ÌƒAƒNƒZƒXƒŒƒxƒ‹
	
	Šù’è“I‚ÈƒŒƒxƒ‹‚ÍŽŸ‚Ì’Ê‚è‚Å‚·B
	
	ƒtƒ@ƒEƒ“ƒ_[@@‘S‚Ä‚Ì%S‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚¦‚é
	@@@@@@@@ƒ`ƒƒƒ“ƒlƒ‹‚É“ü‚é‚ÆŽ©“®“I‚É+oƒ‚[ƒh
	@@@10@@@@Ž©“®“I‚É+oƒ‚[ƒh
	@@@@@@@@AKICK‚ÌƒRƒ}ƒ“ƒh‚àŽg‚¦‚é
	       5@@@@Ž©“®“I‚É+oƒ‚[ƒh
	       3@@@@Ž©“®“I‚É+vƒ‚[ƒh
	       0@@@@“ÁŒ –³‚µ
	@@@@@@@@ƒIƒyƒŒ[ƒ^‚©‚ç+oƒ‚[ƒh‚ð“¾‚ç‚ê‚é
	      -1ˆÈ‰º@@+oƒ‚[ƒh‚ð“¾‚ç‚ê‚È‚¢
	
	‚±‚ÌƒŒƒxƒ‹‚ð•Ï‚¦‚½‚èV‚µ‚¢ƒŒƒxƒ‹‚ð‚Â‚­‚Á‚½‚è‚·‚é‚±‚Æ‚ª
	LEVELS‚ÌƒRƒ}ƒ“ƒh‚Åo—ˆ‚Ü‚·B

CHAN_HELP_AKICK
	ƒVƒ“ƒ^ƒNƒXFAKICK channel ADD mask [reason]
	@@@@@@AKICK channel DEL mask
	@@@@@@AKICK channel LIST [mask]
	
	uŽ©“®ƒLƒbƒNˆê——viƒI[ƒgƒLƒbƒN•\j‚ð•ÏX‚Æ•\Ž¦‚ÌƒRƒ}ƒ“ƒh‚Å‚·B
	Ž©“®ƒLƒbƒNˆê——‚É‚ ‚éƒ†[ƒU‚ªƒ`ƒƒƒ“ƒlƒ‹‚É“ü‚é‚ÆA%S‚Í‚»‚Ì
	ƒ†[ƒU‚ðR‚è’Ç•úƒ}ƒXƒN‚ð•t‚¯‚Ü‚·B
	
	AKICK ADD‚Æ‚¢‚¤Œ`‚ÅŽ©“®ƒLƒbƒNˆê——‚Éƒ}ƒXƒN‚ÆƒjƒbƒN‚ð’Ç‰Á‚Å‚«‚Ü‚·B
	ƒ}ƒXƒN‚È‚çAuser@host‚Æ‚¢‚¤Œ`‚Å“ü—Í‚µ‚Ä‰º‚³‚¢Breasoni——Rj
	‚ÍƒLƒbƒNƒƒbƒZ[ƒW‚Å•\‚ê‚Ü‚·B——R‚ð“ü—Í‚µ‚È‚¢ê‡‚ÍAuYou
	have been banned from the channelviƒ`ƒƒƒ“ƒlƒ‹‚©‚ç’Ç•ú‚³‚ê
	‚Ü‚µ‚½j‚É‚È‚è‚Ü‚·B
	
	AKICK DEL‚Æ‚¢‚¤Œ`‚ÅŽ©“®ƒLƒbƒNˆê——‚©‚çƒ}ƒXƒN‚ÆƒjƒbƒN‚ðÁ‹Ž‚Å‚«‚Ü
	‚·B‚½‚¾‚µA’Ç•úƒ}ƒXƒN‚ªƒ`ƒƒƒ“ƒlƒ‹‚É•t‚¢‚Ä‚¢‚éê‡‚ÍA‚»‚Ì
	ƒ}ƒXƒN‚ÍŽ©“®‚É‰ð‚©‚ê‚Ü‚¹‚ñB
	
	AKICK LIST‚Æ‚¢‚¤Œ`‚ÅŽ©“®ƒLƒbƒNˆê——‚ðŒ©‚é‚±‚Æ‚ªo—ˆ‚Ü‚·Bƒ}ƒXƒN‚ð
	“ü—Í‚·‚ê‚ÎA‚»‚Ìƒ}ƒXƒN‚É‡‚¤ƒGƒ“ƒgƒŠ[‚µ‚©•\‚ê‚Ü‚¹‚ñB

CHAN_HELP_LEVELS
	ƒVƒ“ƒ^ƒNƒXFLEVELS channel SET type level
	@@@@@@LEVELS channel {DIS | DISABLE} type
	@@@@@@LEVELS channel LIST
	@@@@@@LEVELS channel RESET
	
	ƒ`ƒƒƒ“ƒlƒ‹‚ÌƒAƒNƒZƒXƒŒƒxƒ‹‚Ì”Ô†‚ÌˆÓ–¡‚ð•ÏX‚µ‚Ü‚·B‚±‚ÌƒR
	ƒ}ƒ“ƒh‚Å%S‚ÌŽ©“®“I‚Èì—p‚Æ‚Ù‚Æ‚ñ‚Ç‚Ì%S‚ÌƒRƒ}ƒ“
	ƒh‚ªŽg‚¦‚éƒŒƒxƒ‹‚Ì‚ðÝ’è‚Å‚«‚Ü‚·B‚½‚¾‚µASET FOUNDERESET
	PASSWORDELEVELS‚ÌƒRƒ}ƒ“ƒh‚ÍAƒtƒ@ƒEƒ“ƒ_[‚µ‚©Žg‚¦‚Ü‚¹‚ñB
	
	LEVELS SET‚Æ‚¢‚¤Œ`‚Åì—p‚âƒRƒ}ƒ“ƒh‚ÌƒŒƒxƒ‹‚ð•ÏX‚Å‚«‚Ü‚·B
	LEVELS DISABLE‚Æ‚¢‚¤Œ`i‚»‚ê‚ÆLEVELS DIS‚Æ‚¢‚¤È—ªj‚ÅŽ©“®
	“I‚Èì—p‚ð’âŽ~‚·‚é‚±‚Æ‚ÆAƒRƒ}ƒ“ƒh‚ðƒtƒ@ƒEƒ“ƒ_[ˆÈŠO‚É‹Ö§
	‚·‚é‚±‚Æ‚ªo—ˆ‚Ü‚·BLEVELS LIST‚Æ‚¢‚¤Œ`‚ÅŽ©“®“I‚Èì—p‚ÆƒRƒ}
	ƒ“ƒh‚ÌƒŒƒxƒ‹‚ð•\Ž¦‚Å‚«‚Ü‚·BLEVELS RESET‚Æ‚¢‚¤Œ`‚ÅƒŒƒxƒ‹‚ð
	Šù’è’l‚É–ß‚¹‚Ü‚·B
	
	typeiì—p‚Ì–¼‘Oj‚Ì‘I‘ð‚ðŒ©‚éê‡‚ÍAu/msg %S HELP
	LEVELS DESCv‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B

CHAN_HELP_LEVELS_DESC
	LEVELS‚Ìì—p‚ÆƒRƒ}ƒ“ƒh‚Ì–¼‘O‚ÍŽŸ‚Ì’Ê‚è‚Å‚·B
	’ˆÓFAUTODEOP‚ÆNOJOIN‚ÍÅ‘å’l‚ÅA‘¼‚Ì‚ÍÅ¬’l‚Å‚·B

CHAN_HELP_LEVELS_DESC_FORMAT
	    %-*s  %s

CHAN_HELP_INFO
	ƒVƒ“ƒ^ƒNƒXFINFO channel
	
	ƒ`ƒƒƒ“ƒlƒ‹‚Ìî•ñiƒtƒ@ƒEƒ“ƒ_[A–¼óA“o˜^‚Ì“úŽžAƒ‚[ƒh
	ƒƒbƒN“™j‚ð•\‚µ‚Ü‚·B

CHAN_HELP_LIST
	ƒVƒ“ƒ^ƒNƒXFLIST pattern
	
	pattern‚É‡‚¤ƒ`ƒƒƒ“ƒlƒ‹‚ð•\‚µ‚Ü‚·B‚½‚¾‚µAŽ„“IƒIƒvƒVƒ‡ƒ“
	‚ª ON ‚Ìƒ`ƒƒƒ“ƒlƒ‹‚Í•\‚ê‚Ü‚¹‚ñB

CHAN_HELP_OP
	ƒVƒ“ƒ^ƒNƒXFOP #channel nick
	
	ƒ`ƒƒƒ“ƒlƒ‹‚Ìƒ†[ƒU‚ÉƒIƒyƒŒ[ƒ^‚É‚µ‚Ü‚·BŽg—p‚ÍŠù’è“I‚É
	ƒŒƒxƒ‹5ˆÈã‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

CHAN_HELP_DEOP
	ƒVƒ“ƒ^ƒNƒXFDEOP #channel nick
	
	ƒ`ƒƒƒ“ƒlƒ‹‚Ìƒ†[ƒU‚ð-oƒ‚[ƒh‚É‚µ‚Ü‚·BŽg—p‚ÍŠù’è“I‚ÉƒŒƒx
	ƒ‹5ˆÈã‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

#CHAN_HELP_INVITE
#	ƒVƒ“ƒ^ƒNƒXFINVITE channel
#	
#	%S‚ÉŽ©•ª‚ð—U‚í‚¹‚Ü‚·BŽg—p‚ÍŠù’è“I‚ÉƒŒƒxƒ‹1ˆÈã‚ÉŒÀ‚Á
#	‚Ä‚¢‚Ü‚·B

#CHAN_HELP_UNBAN
#	ƒVƒ“ƒ^ƒNƒXFUNBAN channel
#	
#	Œ»Ý‚Ìƒ†[ƒUƒAƒhƒŒƒX‚É‡‚¤’Ç•úƒ}ƒXƒN‚ð‰ð‚«‚Ü‚·BŽg—p‚ÍŠù
#	’è“I‚ÉƒŒƒxƒ‹1ˆÈã‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

#CHAN_HELP_CLEAR
#	ƒVƒ“ƒ^ƒNƒXFCLEAR channel what
#	
#	ƒ`ƒƒƒ“ƒlƒ‹‚Ì‚ ‚éƒ‚[ƒh‚ðƒNƒŠƒA‚µ‚½‚èAƒ†[ƒU‚ð‘S‚ÄR‚Á‚½
#	‚è‚µ‚Ü‚·Bwhat‚Ì‘I‘ð‚ÍŽŸ‚Ì’Ê‚è‚Å‚·B
#	
#	     modes   ƒ`ƒƒƒ“ƒlƒ‹‚Ì“üØƒ‚[ƒhiiEkElEmEnEpEsEtj
#	             @@‚ðƒNƒŠƒA‚·‚é
#	     bans    ’Ç•úƒ}ƒXƒN‚ð‘S‚Ä‰ð‚­
#	     ops     ‘S‚Ä‚Ìƒ†[ƒU‚©‚ç+oƒ‚[ƒh‚ðƒNƒŠƒA‚·‚é
#	     voices  ‘S‚Ä‚Ìƒ†[ƒU‚©‚ç+vƒ‚[ƒh‚ðƒNƒŠƒA‚·‚é
#	     users   ‘S‚Ä‚Ìƒ†[ƒU‚ðƒ`ƒƒƒ“ƒlƒ‹‚©‚çR‚é
#	
#	Žg—p‚ÍŠù’è“I‚ÉƒŒƒxƒ‹ 10 ˆÈã‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

#CHAN_SERVADMIN_HELP
#	
#	Services‚ÌƒAƒhƒ~ƒ“‚ÍŽŸ‚ÌƒRƒ}ƒ“ƒh‚àŽg‚¦‚Ü‚·B
#	
#	    GETPASS    ƒ`ƒƒƒ“ƒlƒ‹‚ÌƒpƒXƒ[ƒh‚ðŒ©‚é
#	               @@iˆÃ†‰»‚ªŽg‚í‚ê‚Ä‚¢‚È‚¢ê‡‚Ì‚Ýj
#	    FORBID     ƒ`ƒƒƒ“ƒlƒ‹‚ðŽg—p•s‰Â”\‚É‚·‚é
#	    STATUS     ƒ†[ƒU‚Ìƒ`ƒƒƒ“ƒlƒ‹‚Å‚ÌƒAƒNƒZƒXƒŒƒxƒ‹
#	
#	‚È‚¨AServices‚ÌƒAƒhƒ~ƒ“‚ÍƒpƒXƒ[ƒh‚ð“ü—Í‚¹‚¸‚Éƒ`ƒƒƒ“ƒlƒ‹
#	‚Ì“o˜^‚ðÁ‹Ž‚·‚é‚±‚Æ‚àAƒAƒNƒZƒXˆê——EŽ©“®ƒLƒbƒNˆê——EƒŒƒxƒ‹•\‚ðŒ©
#	‚é‚±‚Æ‚ào—ˆ‚Ü‚·B

CHAN_SERVADMIN_HELP_DROP
	ƒVƒ“ƒ^ƒNƒXFDROP channel
	
	channel‚Æ‚¢‚¤ƒ`ƒƒƒ“ƒlƒ‹‚ð%S‚Ìƒf[ƒ^ƒx[ƒX‚©‚çÁ‹Ž‚µ‚Ü‚·B
	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚Íƒtƒ@ƒEƒ“ƒ_[‚ÆServices‚ÌƒAƒhƒ~ƒ“‚É
	ŒÀ‚Á‚Ä‚¢‚ÄAServices‚ÌƒAƒhƒ~ƒ“‚Å‚È‚¯‚ê‚ÎƒpƒXƒ[ƒh‚ð“ü—Í‚·
	‚é•K—v‚à‚ ‚è‚Ü‚·B

CHAN_SERVADMIN_HELP_SET
	
	Services‚ÌƒAƒhƒ~ƒ“‚ÍNOEXPIRE‚Æ‚¢‚¤ƒIƒvƒVƒ‡ƒ“‚ðÝ’è‚Å‚«‚Ü‚·B
	‚±‚ÌƒIƒvƒVƒ‡ƒ“‚Åƒ`ƒƒƒ“ƒlƒ‹‚Ì“o˜^‚ðØ‚ê‚È‚­‚·‚é‚±‚Æ‚ªo—ˆ‚Ü
	‚·B‚È‚¨AServices‚ÌƒAƒhƒ~ƒ“‚ÍƒpƒXƒ[ƒh‚ð“ü—Í‚¹‚¸‚Éƒ`ƒƒƒ“
	ƒlƒ‹‚ÌƒIƒvƒVƒ‡ƒ“‚ðÝ’è‚Å‚«‚Ü‚·B

CHAN_SERVADMIN_HELP_SET_NOEXPIRE
	ƒVƒ“ƒ^ƒNƒXFSET channel NOEXPIRE {ON | OFF}
	
	channel‚Æ‚¢‚¤ƒ`ƒƒƒ“ƒlƒ‹‚Ì“o˜^‚ÍØ‚ê‚é‚©‚ðÝ’è‚µ‚Ü‚·BON‚É‚·
	‚é‚ÆA“o˜^‚ÍØ‚ê‚Ü‚¹‚ñB
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚ÍServices‚ÌƒAƒhƒ~ƒ“‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

CHAN_SERVADMIN_HELP_LIST
	ƒVƒ“ƒ^ƒNƒXFLIST pattern
	
	pattern‚É‡‚¤ƒ`ƒƒƒ“ƒlƒ‹‚ð•\‚µ‚Ü‚·B‚½‚¾‚µAŽ„“IƒIƒvƒVƒ‡ƒ“
	‚ð“ü‚µ‚½ƒ`ƒƒƒ“ƒlƒ‹‚ÍServices‚ÌƒAƒhƒ~ƒ“‚É‚µ‚©•\‚ê‚Ü‚¹‚ñB

CHAN_SERVADMIN_HELP_GETPASS
	ƒVƒ“ƒ^ƒNƒXFGETPASS channel
	
	channel‚Æ‚¢‚¤ƒ`ƒƒƒ“ƒlƒ‹‚ÌƒpƒXƒ[ƒh‚ð•\Ž¦‚µ‚Ü‚·B‚±‚ÌƒRƒ}
	ƒ“ƒh‚ðŽg‚¤‚ÆAƒRƒ}ƒ“ƒh‚ð“ü—Í‚µ‚½ƒ†[ƒU‚ÌƒjƒbƒN‚ÆƒpƒXƒ[
	ƒh‚ðo‚µ‚½ƒ`ƒƒƒ“ƒlƒ‹‚ðŠÜ‚ÞƒƒbƒZ[ƒW‚ÍƒƒbƒO‚³‚êAWALLOPS‚©
	GLOBOPS‚ÅƒIƒyƒŒ[ƒ^‚É•ú‘—‚³‚ê‚Ü‚·B
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚ÍServices‚ÌƒAƒhƒ~ƒ“‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B
	
	ˆÃ†‰»‚ªŽg‚í‚ê‚Ä‚¢‚éê‡‚ÍA‚±‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚¦‚Ü‚¹‚ñB

CHAN_SERVADMIN_HELP_FORBID
	ƒVƒ“ƒ^ƒNƒXFFORBID channel
	
	ƒjƒbƒN‚ðŽg—p•s‰Â”\‚É‚µ‚Ü‚·BƒLƒƒƒ“ƒZƒ‹‚É‚ÍDROP‚ÌƒRƒ}ƒ“ƒh‚ª
	Žg‚¦‚Ü‚·B
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚ÍServices‚ÌƒAƒhƒ~ƒ“‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

CHAN_SERVADMIN_HELP_STATUS
	ƒVƒ“ƒ^ƒNƒXFSTATUS channel nickname
	
	nickname‚Æ‚¢‚¤ƒjƒbƒN‚Ìchannel‚Æ‚¢‚¤ƒ`ƒƒƒ“ƒlƒ‹‚Å‚ÌƒAƒNƒZ
	ƒXƒŒƒxƒ‹‚ð•\Ž¦‚µ‚Ü‚·B‰ž“š‚Í‚±‚ÌŒ`‚Å‚·F
	
	    STATUS channel nickname access-level
	
	ƒGƒ‰[‚ª”­¶‚µ‚½ê‡‚ÍA‰ž“š‚ÍŽŸ‚ÌŒ`‚Å‚·F
	
	    STATUS ERROR error-message
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚ÍServices‚ÌƒAƒhƒ~ƒ“‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

###########################################################################
#
# MemoServ‚Ìƒwƒ‹ƒvƒƒbƒZ[ƒW
#
###########################################################################

#MEMO_HELP
#	%S‚ÍAƒ†[ƒU‚Æƒ`ƒƒƒ“ƒlƒ‹‚Éƒƒ‚‚ð‘—‚é‚½‚ß‚ÌƒT[ƒrƒX
#	‚Å‚·Bƒƒ‚‚ÍServices‚É‚æ‚è•Û‘¶‚³‚êAŽóMƒjƒbƒN‚©ƒ`ƒƒƒ“ƒlƒ‹
#	‚ÌƒIƒyƒŒ[ƒ^‚Í“Ç‚Ý‚½‚¢Žž‚É“Ç‚ß‚Ü‚·B‚½‚¾‚µA·ol‚Ìƒjƒb
#	ƒN‚àŽóMƒjƒbƒN‚©ƒ`ƒƒƒ“ƒlƒ‹‚à“o˜^‚µ‚È‚¯‚ê‚Î%S‚ðŽg‚¦‚Ü‚¹‚ñB
#	
#	%S‚ÌƒRƒ}ƒ“ƒh‚ÍŽŸ‚Ì’Ê‚è‚Å‚·B
#	
#	    SEND   ƒ†[ƒU‚©ƒ`ƒƒƒ“ƒlƒ‹‚Éƒƒ‚‚ð‘—‚é
#	    LIST   ŽóMƒƒ‚•\‚ð•\‚·
#	    READ   ƒƒ‚‚ð“Ç‚Þ
#	    DEL    ƒƒ‚‚ðÁ‹Ž‚·‚é
#	    SET    ƒƒ‚‚ÌƒIƒvƒVƒ‡ƒ“‚ðÝ’è‚·‚é
#	
#	ƒRƒ}ƒ“ƒh‚Ìƒwƒ‹ƒv‚ð“Ç‚Þê‡‚ÍAu/msg %S HELP commandv
#	‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B
#	
#	¦ƒ`ƒƒƒ“ƒlƒ‹‚Ìƒƒ‚‚ª“Ç‚ß‚é‚Ì‚ÍŠù’è“I‚ÉƒŒƒxƒ‹10ˆÈã‚Ìƒ†[ƒU
#	@‚Ì‚Ý‚Å‚·‚ªA%s‚ÌuLEVELSv‚Æ‚¢‚¤ƒRƒ}ƒ“ƒh‚Å‚»‚ÌƒŒƒxƒ‹‚ð•Ï
#	@X‚Å‚«‚Ü‚·B

MEMO_HELP_SEND
	ƒVƒ“ƒ^ƒNƒXFSEND {nick | channel} memo-text
	
	nick‚©channel‚Émemo-text‚ðŠÜ‚Þƒƒ‚‚ð‘—‚è‚Ü‚·BƒjƒbƒN‚Éo‚·
	ê‡‚É‚ÍAŽóMŽÒ‚ÌƒjƒbƒNƒIƒvƒVƒ‡ƒ“‚É‚æ‚Á‚ÄA%S‚ÍŽóM
	ŽÒ‚ÉV‚½‚Èƒƒ‚‚ª“Í‚¢‚½‚Æ‚Ì‚±‚Æ‚ð•ñ‚µ‚Ü‚·B

MEMO_HELP_LIST
	ƒVƒ“ƒ^ƒNƒXFLIST [channel] [list | NEW]
	
	ŽóMƒƒ‚•\‚ð•\‚µ‚Ü‚·BNEW‚ð“ü—Í‚·‚ê‚ÎA“Ç‚ñ‚Å‚¢‚È‚¢ƒƒ‚‚Ì‚Ý
	‚ª•\‚ê‚Ü‚·B“Ç‚ñ‚Å‚¢‚È‚¢ƒƒ‚‚ÍAƒƒ‚‚Ì”Ô†‚Ì¶‘¤‚É–ˆó‚ª•\
	Ž¦‚³‚ê‚Ü‚·B‰º‹L‚Ì—á‚Ì’Ê‚èA”Ô†—ñ‚à“ü—Í‰Â”\F
	
	    LIST 2-5,7-9
	       ‚Q`‚TA‚V`‚X”Ô–Ú‚Ìƒƒ‚‚ðƒŠƒXƒg‚µ‚Ü‚·B

MEMO_HELP_READ
	ƒVƒ“ƒ^ƒNƒXFREAD [channel] {num | list | LAST | NEW}
	
	ƒƒ‚‚ð“Ç‚Ý‚Ü‚·B”Ô†‚ð“ü—Í‚·‚é‚Æ‚»‚Ì”Ô†‚Ìƒƒ‚‚ª•\‚êALAST‚ð
	“ü—Í‚·‚é‚ÆÅV‚Ìƒƒ‚‚ª•\‚êANEW‚ð“ü—Í‚·‚é‚Æ“Ç‚ñ‚Å‚¢‚È‚¢ƒƒ‚
	‚ª‘S‚Ä•\‚ê‚Ü‚·B‰º‹L‚Ì—á‚Ì’Ê‚èA”Ô†—ñ‚à“ü—Í‰Â”\F
	
	    LIST 2-5,7-9
	       ‚Q`‚TA‚V`‚X”Ô–Ú‚Ìƒƒ‚‚ðƒŠƒXƒg‚µ‚Ü‚·B

MEMO_HELP_DEL
	ƒVƒ“ƒ^ƒNƒXFDEL [channel] {num | list | ALL}
	
	ƒƒ‚‚ðÁ‹Ž‚µ‚Ü‚·B”Ô†‚ð“ü—Í‚·‚é‚Æ‚»‚Ì”Ô†‚Ìƒƒ‚‚ªÁ‹Ž‚³‚êA
	ALL‚ð“ü—Í‚·‚é‚Æ‘S‚Ä‚Ìƒƒ‚‚ªÁ‹Ž‚³‚ê‚Ü‚·B
	
	—áF
	   DEL 1
	      ‚P”Ô–Ú‚Ìƒƒ‚‚ðÁ‹Ž‚µ‚Ü‚·B
	   DEL 2-5,7-9
	      ‚Q”Ô–Ú`‚T”Ô–Ú‚Æ‚V”Ô–Ú`‚X”Ô–Ú‚Ìƒƒ‚‚ðÁ‹Ž‚µ‚Ü‚·B

MEMO_HELP_SET
	ƒVƒ“ƒ^ƒNƒXFSET option parameters
	
	ƒƒ‚‚ÌƒIƒvƒVƒ‡ƒ“‚ðÝ’è‚µ‚Ü‚·Boption‚Ì‘I‘ð‚ÍŽŸ‚Ì’Ê‚è‚Å‚·B
	
	    NOTIFY      ‚Ç‚Ìê‡‚É%S‚ªVƒƒ‚‚Ì•ñ‚·‚é‚©‚ÌÝ’è
	                @iƒjƒbƒN‚Ì‚Ýj
	    LIMIT       ƒƒ‚‚Ì”‚ÌŒÀ‚è‚ÌÝ’è
	
	ƒIƒvƒVƒ‡ƒ“‚Ìî•ñ‚ð“Ç‚Þê‡‚ÍAu/msg %S HELP SET optionv
	‚ð“ü—Í‚µ‚Ä‰º‚³‚¢B

MEMO_HELP_SET_NOTIFY
	ƒVƒ“ƒ^ƒNƒXFSET NOTIFY {ON | LOGON | NEW | OFF}
	
	‚Ç‚Ìê‡‚É%S‚ªVƒƒ‚‚Ì•ñ‚·‚é‚©‚ÌÝ’è‚ÌƒRƒ}ƒ“ƒh‚Å‚·B
	Ý’è‚Ì‘I‘ð‚ÍŽŸ‚Ì’Ê‚è‚Å‚·B
	
	    ON      ƒƒOƒIƒ“‚·‚é‚Æ‚«AIRC‚É–ß‚é‚Æ‚«Aƒƒ‚‚ª“Í‚­‚Æ‚«
	    LOGON   ƒƒOƒIƒ“‚·‚é‚Æ‚«AIRC‚É–ß‚é‚Æ‚«
	    NEW     ƒƒ‚‚ª“Í‚­‚Æ‚«
	    OFF     •ñ‚Í–³‚µ
	
	ON‚ÌŒ‹‰Ê‚ÍLOGON‚ÆNEW‚ÌŒ‹‰Ê‚ð‡‚í‚¹‚é‚±‚Æ‚ÆŽv‚¦‚Ü‚·B

MEMO_HELP_SET_LIMIT
	ƒVƒ“ƒ^ƒNƒXFSET LIMIT [channel] limit
	
	ƒƒ‚‚Ì”‚ÌŒÀ‚è‚ðÝ’è‚µ‚Ü‚·Bƒ[ƒ‚É‚·‚é‚ÆAƒƒ‚‚ðŽó‚¯‚ç‚ê‚È
	‚­‚È‚è‚Ü‚·B‚½‚¾‚µA³”‚Ìê‡‚Í%dˆÈ‰º‚Ì”’l‚µ‚©“ü—Í‚Å‚«‚Ü
	‚¹‚ñB

MEMO_HELP_INFO
	ƒVƒ“ƒ^ƒNƒXFINFO [channel]
	
	ƒƒ‚‚Ìî•ñ‚ðŒ©‚Ü‚·B‚±‚ÌƒRƒ}ƒ“ƒh‚Å•\‚ê‚é‚Ì‚ÍAŒ»Ý‚Ìƒƒ‚‚Ì
	”‚Æ“Ç‚ñ‚Å‚¢‚È‚¢ƒƒ‚‚Ì”‚Æƒƒ‚‚Ì”‚ÌŒÀ‚è‚Å‚·Bƒpƒ‰ƒ[ƒ^
	‚ð“ü—Í‚·‚ê‚Î‚»‚Ìƒ`ƒƒƒ“ƒlƒ‹‚Ìî•ñ‚ª•\‚ê‚Ü‚·B

MEMO_SERVADMIN_HELP_SET_LIMIT
	ƒVƒ“ƒ^ƒNƒXFSET LIMIT [user | channel] {limit | NONE} [HARD]
	
	ƒ†[ƒU‚©ƒ`ƒƒƒ“ƒlƒ‹‚Ìƒƒ‚‚Ì”‚ÌŒÀ‚è‚ðÝ’è‚µ‚Ü‚·Bƒ[ƒ‚É‚·
	‚é‚Æƒ†[ƒU‚Íƒƒ‚‚ðŽó‚¯‚ç‚ê‚È‚­‚È‚èANONE‚É‚·‚é‚ÆŒÀ‚è‚Í–³
	‚­‚È‚è‚Ü‚·BƒjƒbƒN‚ð“ü—Í‚µ‚È‚¢ê‡‚ÍAƒRƒ}ƒ“ƒh‚ðo‚·ƒ†[ƒU
	[‚ÌƒjƒbƒN‚Ìƒƒ‚‚ÌŒÀ‚è‚ªÝ’è‚³‚ê‚Ü‚·BHARD‚ð“ü—Í‚·‚ê‚ÎAƒ†[
	ƒU[‚ÍŒÀ‚è‚ð•ÏX‚Å‚«‚È‚­‚È‚èA“ü—Í‚µ‚È‚¯‚ê‚Îƒ†[ƒU‚ÍŒÀ‚è
	‚ð•ÏX‚Å‚«‚Ü‚·B
	
	‚±‚ÌŽg‚¢•û‚ªŽg‚¦‚é‚Ì‚ÍServices‚ÌƒAƒhƒ~ƒ“‚Ì‚Ý‚Å‚·Bˆê”Ê‚Ì
	ƒ†[ƒU‚ÍA‘¼‚Ìƒ†[ƒU‚ÌŒÀ‚è‚ðÝ’è‚Å‚«‚È‚¢‚µAŒÀ‚è‚ð‚Ì‚¯
	‚ç‚ê‚È‚¢‚µAHARD‚à“ü—Í‚Å‚«‚Ü‚¹‚ñB

MEMO_SERVADMIN_HELP_INFO
	ƒVƒ“ƒ^ƒNƒXFINFO [nick | channel]
	
	ƒƒ‚‚Ìî•ñ‚ðŒ©‚Ü‚·B‚±‚ÌƒRƒ}ƒ“ƒh‚Å•\‚ê‚é‚Ì‚ÍAŒ»Ý‚Ìƒƒ‚‚Ì
	”‚Æ“Ç‚ñ‚Å‚¢‚È‚¢ƒƒ‚‚Ì”‚Æƒƒ‚‚Ì”‚ÌŒÀ‚è‚Å‚·Bƒpƒ‰ƒ[ƒ^
	‚ª‚ ‚éê‡‚É‚»‚Ìƒ†[ƒU‚©ƒ`ƒƒƒ“ƒlƒ‹‚Ìî•ñ‚ª•\‚êAƒpƒ‰ƒ[
	ƒ^[‚ª–³‚¢ê‡‚ÉŽ©•ª‚Ìî•ñ‚ª•\‚ê‚Ü‚·B
	
	ƒjƒbƒN‚Ìƒpƒ‰ƒ[ƒ^‚ð“ü—Í‚Å‚«‚é‚Ì‚ÍServices‚ÌƒAƒhƒ~ƒ“‚Ì‚Ý
	‚Å‚·B

###########################################################################
#
# OperServ‚Ìƒwƒ‹ƒvƒƒbƒZ[ƒW
#
###########################################################################

#OPER_HELP
#	%S‚ÌƒRƒ}ƒ“ƒh‚ÍŽŸ‚Ì’Ê‚è‚Å‚·B
#	
#	ˆê”Ê‚ÌIRC‚ÌƒIƒyƒŒ[ƒ^‚ªŽg‚¦‚éƒRƒ}ƒ“ƒhF
#	    GLOBAL      ‘S‚Ä‚Ìƒ†[ƒU‚ÉƒƒbƒZ[ƒW‚ð‘—‚é
#	    STATS       Services‚Æƒlƒbƒg‚ÌƒXƒe[ƒ^ƒX‚ð•\‚·
#	    OPER LIST   Services‚ÌƒIƒyƒŒ[ƒ^•\‚ð•\‚·
#	    ADMIN LIST  Services‚ÌƒAƒhƒ~ƒ“•\‚ð•\‚·
#	
#	Services‚ÌƒIƒyƒŒ[ƒ^‚ÆƒAƒhƒ~ƒ“‚¾‚¯‚ªŽg‚¦‚éƒRƒ}ƒ“ƒhF
#	    MODE        ƒ`ƒƒƒ“ƒlƒ‹‚Ìƒ‚[ƒh‚ð•ÏX‚·‚é
#	    KICK        ƒ`ƒƒƒ“ƒlƒ‹‚©‚çƒ†[ƒU‚ðƒLƒbƒN‚·‚é
#	    AKILL       Ž©“®Ø’f•\‚ð•ÏX‚·‚é
#	
#	Services‚ÌƒAƒhƒ~ƒ“‚¾‚¯‚ªŽg‚¦‚éƒRƒ}ƒ“ƒhF
#	    OPER        Services‚ÌƒIƒyƒŒ[ƒ^•\‚ð•ÏX‚·‚é
#	    LOGONNEWS   ƒ†[ƒU‚ªÚ‘±‚·‚éŽž‚Éo‚³‚ê‚éƒƒbƒZ[ƒW‚ð
#	                @@ì‚é
#	    OPERNEWS    ƒ†[ƒU‚ªƒIƒyƒŒ[ƒ^i+oƒ‚[ƒhj‚É‚È‚éŽž
#	                @@‚Éo‚³‚ê‚éƒƒbƒZ[ƒW‚ðì‚é
#	    JUPE        ƒT[ƒo[‚ðuƒWƒ…ƒsƒ^[viÚ‘±‹‘”Ûj‚·‚é
#	    RAW         Services‚ÌÚ‘±ƒT[ƒo[‚ÉƒeƒLƒXƒg‚ðo‚·
#	    SET         Services‚ÌƒIƒvƒVƒ‡ƒ“‚ÌÝ’è
#	    UPDATE      ƒf[ƒ^ƒx[ƒX‚ð’¼Ú•Û‘¶‚³‚¹‚é
#	    QUIT        Services‚ðŽ~‚ß‚é
#	    RESTART     Services‚ðÄ‹N“®‚³‚¹‚é
#	
#	Services rootiƒX[ƒp[ƒ†[ƒUj‚¾‚¯‚ªŽg‚¦‚éƒRƒ}ƒ“ƒhF
#	    ADMIN       Services‚ÌƒAƒhƒ~ƒ“•\‚ð•ÏX‚·‚é
#	
#	’ˆÓF%S‚Éo‚³‚ê‚½ƒRƒ}ƒ“ƒh‚Í‘S‚ÄƒƒbƒO‚³‚ê‚Ü‚·B

OPER_HELP_GLOBAL
	ƒVƒ“ƒ^ƒNƒXFGLOBAL message
	
	‘S‚Ä‚Ìƒlƒbƒg‚ÉÚ‘±‚µ‚Ä‚¢‚éƒ†[ƒU‚ÉƒƒbƒZ[ƒW‚ðo‚µ‚Ü‚·B
	ƒƒbƒZ[ƒW‚ÌŽwoƒjƒbƒN‚Í%s‚Å‚·B

OPER_HELP_STATS
	ƒVƒ“ƒ^ƒNƒXFSTATS [AKILL | ALL]
	
	ƒpƒ‰ƒ[ƒ^‚ª‚È‚¢ê‡‚ÍAŒ»Ý‚Ìƒ†[ƒU”‚ÆƒIƒyƒŒ[ƒ^”A
	Å‘åƒ†[ƒU”A‹N“®‚©‚ç‚ÌŽžŠÔ‚ð•\‚µ‚Ü‚·B
	
	AKILL‚Æ‚¢‚¤ƒpƒ‰ƒ[ƒ^‚ª‚ ‚éê‡‚ÍAŒ»Ý‚ÌŽ©“®Ø’fƒ}ƒXƒN‚Ì
	”‚ÆŠù’è“I‚ÈŽõ–½‚ð•\‚µ‚Ü‚·B
	
	ALL‚Æ‚¢‚¤ƒIƒvƒVƒ‡ƒ“‚ªŽg‚¦‚é‚Ì‚ÍServices‚ÌƒAƒhƒ~ƒ“‚Ì‚Ý‚Å‚·B
	‚±‚ÌƒIƒvƒVƒ‡ƒ“‚ð•t‚¯‚é‚ÆA•’Ê‚Ìî•ñiƒ†[ƒU”‚Æ‹N“®‚©‚ç
#@@@ umemory usagev‚Ì–|–ó
	‚ÌŽžŠÔj‚Ì‰º‚ÅServices‚ÌŽg—p‚µ‚Ä‚¢‚éƒƒ‚ƒŠ[—Ê‚à•\‚ê‚Ü‚·B
	‚±‚ÌŒ`‚ðŽg‚¤‚ÆServices‚Í­‚µ‚ÌŠÔƒtƒŠ[ƒY‚µ‚Ä‚µ‚Ü‚¢‚Ü‚·‚Ì‚ÅA
	‚²’ˆÓ‰º‚³‚¢B
	
	uSTATSv‚Ì‘ã‚í‚è‚ÉuUPTIMEv‚àŽg‚¦‚Ü‚·B

OPER_HELP_OPER
	ƒVƒ“ƒ^ƒNƒXFOPER ADD nick
	@@@@@@OPER DEL nick
	@@@@@@OPER LIST
	
	Services‚ÌƒIƒyƒŒ[ƒ^•\‚Ì•ÏX‚Æ•\Ž¦‚ÌƒRƒ}ƒ“ƒh‚Å‚·B‚±‚ÌƒŠ
	ƒXƒg‚É‚ ‚éƒ†[ƒU‚ÍA%s‚ÌIDENTIFY‚ÌƒRƒ}ƒ“ƒh‚ÅƒpƒXƒ[
	ƒh‚ð“ü—Í‚·‚ê‚ÎServices‚ÌƒIƒyƒŒ[ƒ^‚ÌƒRƒ}ƒ“ƒh‚ªŽg‚¦‚Ü‚·B
	
	’N‚Å‚àOPER LIST‚Æ‚¢‚¤Œ`‚ªŽg‚¦‚Ü‚·B‘¼‚ÌŽg—p‚ÍServices‚ÌƒAƒh
	ƒ~ƒ“‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

OPER_HELP_ADMIN
	ƒVƒ“ƒ^ƒNƒXFADMIN ADD nick
	@@@@@@ADMIN DEL nick
	@@@@@@ADMIN LIST
	
	Services‚ÌƒAƒhƒ~ƒ“•\‚Ì•ÏX‚Æ•\Ž¦‚ÌƒRƒ}ƒ“ƒh‚Å‚·B‚±‚ÌƒŠƒXƒg
	‚É‚ ‚éƒ†[ƒU‚ÍA%s‚ÌIDENTIFY‚ÌƒRƒ}ƒ“ƒh‚ÅƒpƒXƒ[ƒh
	‚ð“ü—Í‚·‚ê‚ÎServices‚ÌƒAƒhƒ~ƒ“‚ÌƒRƒ}ƒ“ƒh‚ªŽg‚¦‚Ü‚·B
	
	’N‚Å‚àADMIN LIST‚Æ‚¢‚¤Œ`‚ªŽg‚¦‚Ü‚·B‘¼‚ÌŽg—p‚ÍServices root
	‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

OPER_HELP_MODE
	ƒVƒ“ƒ^ƒNƒXFMODE channel modes
	
	ƒ`ƒƒƒ“ƒlƒ‹‚Ìƒ‚[ƒh‚ð•ÏX‚µ‚Ü‚·Bƒpƒ‰ƒ[ƒ^‚ÍIRC‚Ìu/MODEv
	‚ÌƒRƒ}ƒ“ƒh‚Æ“¯‚¶‚Å‚·B
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚ÍServices‚ÌƒIƒyƒŒ[ƒ^‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

OPER_HELP_CLEARMODES
	ƒVƒ“ƒ^ƒNƒXFCLEARMODES channel [ALL]
	
	ƒ`ƒƒƒ“ƒlƒ‹‚Ì“üØƒ‚[ƒhiiEkElEmEnEpEsEtj‚Æ’Ç•úƒ}ƒX
	ƒN‚ð‘S‚ÄƒNƒŠƒA‚µ‚Ü‚·BALL‚Æ‚¢‚¤ƒpƒ‰ƒ[ƒ^‚ð“ü—Í‚·‚é‚ÆA
	oEvƒ‚[ƒh‚àƒNƒŠƒA‚³‚ê‚Ü‚·B
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚ÍServices‚ÌƒIƒyƒŒ[ƒ^‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

OPER_HELP_KICK
	ƒVƒ“ƒ^ƒNƒXFKICK channel user reason
	
	ƒ`ƒƒƒ“ƒlƒ‹‚©‚çƒ†[ƒU‚ðƒLƒbƒN‚µ‚Ü‚·Bƒpƒ‰ƒ[ƒ^‚ÍIRC‚Ì
	/KICK‚Æ‚¢‚¤ƒRƒ}ƒ“ƒh‚Æ“¯‚¶‚Å‚·‚ªAƒLƒbƒNƒƒbƒZ[ƒW‚Ì‘O‚É‚±‚Ì
	ƒRƒ}ƒ“ƒh‚ðŽg‚Á‚½ƒ†[ƒU‚ÌƒjƒbƒN‚ª•\‚ê‚Ü‚·B
#@@@ —á‚ª•K—v
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚ÍServices‚ÌƒIƒyƒŒ[ƒ^‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

OPER_HELP_AKILL
	ƒVƒ“ƒ^ƒNƒXFAKILL ADD [+expiry] mask reason
	@@@@@@AKILL DEL mask
	@@@@@@AKILL LIST [mask]
	@@@@@@AKILL VIEW [mask]
	
	uŽ©“®Ø’f•\viƒI[ƒgƒLƒ‹•\j‚Ì•ÏX‚Æ•\Ž¦‚ÌƒRƒ}ƒ“ƒh‚Å‚·B
	Ž©“®Ø’fƒ}ƒXƒN‚É‡‚¤ƒ†[ƒU‚ªÚ‘±‚·‚é‚ÆAServices‚Í‚»‚Ì
	ƒ†[ƒU‚ðØ’f‚µAƒT[ƒo[‚ÌƒvƒƒgƒRƒ‹‚É‚æ‚Á‚Ä‚»‚Ìƒ}ƒXƒN‚ð
	uK:ƒ‰ƒCƒ“v‚É‚µ‚Ü‚·B
	
	AKILL ADD‚Æ‚¢‚¤Œ`‚Åƒ}ƒXƒN‚ðŽ©“®Ø’f•\‚É’Ç‰Á‚Å‚«‚Ü‚·B
	reasoni——Rj‚Í•K—v‚Å‚·‚ªAƒIƒyƒŒ[ƒ^‚Ìˆ×‚¾‚¯‚Å‚·‚Ì‚ÅA
	Ø’f‚³‚ê‚½ƒ†[ƒU‚ÌØ’fƒƒbƒZ[ƒW‚É•\‚ê‚Ü‚¹‚ñB
	expiry‚ð“ü—Í‚·‚ê‚ÎAŽ©“®Ø’fƒGƒ“ƒgƒŠ[‚ÌŽõ–½‚ðŽw’è‚Å‚«‚Ü‚·B
	Œ`‚Í³”‚ÉŽžŠÔ‚Ì’PˆÊ‚ðŽwŽ¦‚·‚é•¶Žš‚ð•t‚¯‚Ü‚·B’PˆÊ‚Ì•¶Žš‚Í
	udvi“újAuhviŽžŠÔjAumvi•ªj‚ÅA•¶Žš‚ð•t‚¯‚È‚¢‚Æ
	“ú‚É‚È‚è‚Ü‚·B‚½‚¾‚µA•¶Žš‚ð‡‚í‚¹‚é‚±‚Æiu1h30mv‚È‚Çj‚Í
	o—ˆ‚Ü‚¹‚ñBu+0v‚É‚·‚ê‚ÎAŽ©“®Ø’fƒGƒ“ƒgƒŠ[‚ÍØ‚ê‚Ü‚¹‚ñB
	Žõ–½‚ð“ü—Í‚µ‚È‚¢ê‡‚ÍAŠù’èŽõ–½‚É‚È‚è‚Ü‚·BSTATS AKILL‚Æ‚¢
	‚¤ƒRƒ}ƒ“ƒh‚Å‚»‚ÌŠù’è’l‚ð•\‚·‚±‚Æ‚ªo—ˆ‚Ü‚·B
	@¦ƒ}ƒXƒN‚Íu+v‚ÅŽn‚Ü‚éê‡‚ÍAŽõ–½‚ð“ü—Í‚µ‚È‚¯‚ê‚Î‚È‚è‚Ü
	@@‚¹‚ñB
	
	AKILL DEL‚Æ‚¢‚¤Œ`‚Åƒ}ƒXƒN‚ðŽ©“®Ø’f•\‚©‚çÁ‹Ž‚Å‚«‚Ü‚·B
	
	AKILL LIST‚Æ‚¢‚¤Œ`‚ÅŽ©“®Ø’f•\‚ð•\‚¹‚Ü‚·Bƒpƒ‰ƒ[ƒ^‚ð“ü
	—Í‚·‚ê‚ÎA‚»‚Ìƒ}ƒXƒN‚É‡‚¤ƒGƒ“ƒgƒŠ[‚µ‚©•\‚ê‚Ü‚¹‚ñB
	
	AKILL VIEW‚Æ‚¢‚¤Œ`‚ÅAKILL LIST‚Ì‚æ‚¤‚ÉŽ©“®Ø’f•\‚ð•\‚·‚±‚Æ
	‚ªo—ˆ‚Ü‚·‚ªALIST‚æ‚è‘½‚­‚Ìî•ñi“ü—Í‚µ‚½ƒ†[ƒU‚Æ“úŽžA
	Ø‚ê‚é“úŽžj‚ªo‚Ü‚·B
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚ÍServices‚ÌƒIƒyƒŒ[ƒ^‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

OPER_HELP_JUPE
	ƒVƒ“ƒ^ƒNƒXFJUPE server [reason]
	
	ƒT[ƒo[‚ðuƒWƒ…ƒsƒ^[v‚µ‚Ü‚·BƒWƒ…ƒsƒ^[ijupiterj‚Æ‚ÍA
	ƒT[ƒo[‚ðƒlƒbƒg‚ÉÚ‘±‚³‚¹‚È‚¢ˆ×‚É‰¼ƒT[ƒo[‚ðìƒŠƒlƒbƒg‚É‚Â
	‚È‚°‚é‚±‚Æ‚Å‚·B‰¼ƒT[ƒo[‚Íu/SQUITv‚Æ‚¢‚¤IRC‚ÌƒRƒ}ƒ“ƒh‚Å
	Á‚·‚±‚Æ‚ªo—ˆ‚Ü‚·Breasoni——Rj‚ð“ü—Í‚·‚ê‚ÎA‚»‚Ì•¶Žš
	—ñ‚Í‰¼ƒT[ƒo[‚Ì/LINKS‚È‚Ç‚ÅƒT[ƒo[î•ñ‚Æ‚µ‚Ä•\‚ê‚Ü‚·B——R
	‚ð“ü—Í‚µ‚È‚¢ê‡‚ÍAƒT[ƒo[–¼‚ªƒT[ƒo[î•ñ‚Æ‚µ‚ÄŽg—p‚³‚ê‚Ü
	‚·B
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚ÍServices‚ÌƒAƒhƒ~ƒ“‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

OPER_HELP_RAW
	ƒVƒ“ƒ^ƒNƒXFRAW text
	
	Services‚ªÚ‘±‚µ‚Ä‚¢‚éƒT[ƒo[‚ÉƒeƒLƒXƒg‚ðo‚µ‚Ü‚·BIRC‚Ìƒv
	ƒƒgƒRƒ‹‚ª‚Í‚Á‚«‚è•ª‚©‚ç‚¸‚É‚±‚ÌƒRƒ}ƒ“ƒh‚ðŽg‚Á‚½‚èA“ü—Í‚Å
	ŠÔˆá‚¢‚ð‚µ‚Ä‚±‚ÌƒRƒ}ƒ“ƒh‚ðo‚µ‚½‚è‚µ‚Ä‚µ‚Ü‚¦‚ÎAƒlƒbƒg‚ð‹¶
	‚í‚¹‚é‚±‚Æ‚ª‚ ‚è‚Ü‚·‚Ì‚ÅA[•ª‚²’ˆÓ‰º‚³‚¢B
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚ÍServices‚ÌƒAƒhƒ~ƒ“‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

#OPER_HELP_SET
#	ƒVƒ“ƒ^ƒNƒXFSET option setting
#	
#	Services‘S‘Ì‚ÌƒIƒvƒVƒ‡ƒ“‚ðÝ’è‚µ‚Ü‚·BƒIƒvƒVƒ‡ƒ“‚Ì–¼‘O‚ÍŽŸ
#	‚Ì’Ê‚è‚Å‚·B
#	    READONLY   ƒŠ[ƒhƒIƒ“ƒŠ[ƒ‚[ƒh‚Ì“üØ
#	    DEBUG      ƒfƒoƒbƒOƒ‚[ƒh‚Ì“üØ
#	
#	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚ÍServices‚ÌƒAƒhƒ~ƒ“‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

OPER_HELP_SET_READONLY
	ƒVƒ“ƒ^ƒNƒXFSET READONLY {ON | OFF}
	
	ƒŠ[ƒhƒIƒ“ƒŠ[ƒ‚[ƒh‚ð“üØ‚µ‚Ü‚·BON‚É‚·‚ê‚ÎAƒ†[ƒU‚Í
	Services‚Ìƒf[ƒ^‚ð•ÏX‚Å‚«‚È‚­‚È‚èAƒjƒbƒN‚Æƒ`ƒƒƒ“ƒlƒ‹‚Ì“o
	˜^‚ÆÁ‹Ž‚à•s‰Â”\‚É‚È‚è‚Ü‚·BServices‚ÌƒIƒyƒŒ[ƒ^‚ÆƒAƒhƒ~
	ƒ“‚ÍŽ©“®Ø’f•\‚ð•ÏX‚Å‚«AƒAƒhƒ~ƒ“‚È‚çƒjƒbƒN‚Æƒ`ƒƒƒ“ƒlƒ‹‚ð
	Žg—p‹ÖŽ~‚É‚Å‚«‚Ü‚·‚ªAServices‚ðÁ‚·i‚»‚ê‚ÆÄ‹N“®‚·‚éj‘O
	‚ÉƒŠ[ƒhƒIƒ“ƒŠ[ƒ‚[ƒh‚ðOFF‚É‚µ‚È‚¯‚ê‚Î‚»‚Ì•ÏX‚Í•Û‘¶‚³‚ê‚Ü
	‚¹‚ñ‚Ì‚ÅA‚²’ˆÓ‰º‚³‚¢B
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚Íu-readonlyv‚Æ‚¢‚¤ƒRƒ}ƒ“ƒhƒ‰ƒCƒ“ƒIƒvƒVƒ‡ƒ“‚Æ
	“¯‚¶Œ‹‰Ê‚ðo‚µ‚Ü‚·B

OPER_HELP_SET_DEBUG
	ƒVƒ“ƒ^ƒNƒXFSET DEBUG {ON | OFF | num}
	
	ƒfƒoƒbƒOƒ‚[ƒh‚ð“üØ‚µ‚Ü‚·BON‚É‚·‚ê‚ÎAServices‚ªŽó‚¯‚½‚è
	o‚µ‚½‚è‚·‚éƒeƒLƒXƒg‚Æ‘¼‚ÌƒfƒoƒbƒOƒƒbƒZ[ƒW‚ÍƒƒbƒO‚³‚ê‚Ü
	‚·Bnum‚Æ‚¢‚¤³”‚ð“ü—Í‚·‚é‚ÆAƒfƒoƒbƒO‚ÌƒŒƒxƒ‹‚Ínum‚ÉÝ’è
	‚³‚ê‚Ü‚·B
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚Íu-debugv‚Æ‚¢‚¤ƒRƒ}ƒ“ƒhƒ‰ƒCƒ“ƒIƒvƒVƒ‡ƒ“‚Æ“¯
	‚¶Œ‹‰Ê‚ðo‚µ‚Ü‚·B

OPER_HELP_UPDATE
	ƒVƒ“ƒ^ƒNƒXFUPDATE
	
	Services‚Ìƒf[ƒ^ƒx[ƒX‚ð’¼Ú•Û‘¶‚³‚¹‚Ü‚·B
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚ÍServices‚ÌƒAƒhƒ~ƒ“‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

OPER_HELP_QUIT
	ƒVƒ“ƒ^ƒNƒXFQUIT
	
	ƒf[ƒ^ƒx[ƒX‚ð•Û‘¶‚¹‚¸‚ÉServices‚ðÁ‚µ‚Ü‚·B‚±‚ÌƒRƒ}ƒ“ƒh
	‚ðŽg‚¤‚×‚«ê‡‚ÍAƒf[ƒ^ƒx[ƒX‚Ì‹¶‚¢‚Ì‹°‚ê‚ª‚ ‚éê‡‚Ì‚Ý‚Å
	‚·B‘¼‚Ìê‡‚ÍASHUTDOWN‚ÌƒRƒ}ƒ“ƒh‚ð‚¨Žg‚¢‰º‚³‚¢B
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚ÍServices‚ÌƒAƒhƒ~ƒ“‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

OPER_HELP_SHUTDOWN
	ƒVƒ“ƒ^ƒNƒXFSHUTDOWN
	
	ƒf[ƒ^ƒx[ƒX‚ð•Û‘¶‚µ‚ÄServices‚ðÁ‚µ‚Ü‚·B
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚ÍServices‚ÌƒAƒhƒ~ƒ“‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B

OPER_HELP_RESTART
	ƒVƒ“ƒ^ƒNƒXFRESTART
	
	ƒf[ƒ^ƒx[ƒX‚ð•Û‘¶‚µ‚ÄServices‚ðÄ‹N“®‚³‚¹‚Ü‚·B
	
	‚±‚ÌƒRƒ}ƒ“ƒh‚ÌŽg—p‚ÍServices‚ÌƒAƒhƒ~ƒ“‚ÉŒÀ‚Á‚Ä‚¢‚Ü‚·B


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

