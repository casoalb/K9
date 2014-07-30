# Emacs mode: -*- text -*-¡¡

# Spanish language file.
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
	Español (Spanish)

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
	Dom
	Lun
	Mar
	Mie
	Jue
	Vie
	Sab
# %A
STRFTIME_DAYS_LONG
	Domingo
	Lunes
	Martes
	Miercoles
	Jueves
	Viernes
	Sabado
# %b
STRFTIME_MONTHS_SHORT
	Ene
	Feb
	Mar
	Abr
	May
	Jun
	Jul
	Ago
	Sep
	Oct
	Nov
	Dic
# %B
STRFTIME_MONTHS_LONG
	Enero
	Febrero
	Marzo
	Abril
	Mayo
	Junio
	Julio
	Agosto
	Septiembre
	Octubre
	Noviembre
	Diciembre


# "day", "hour", "minute", and "second" in singular and plural.
STR_DAY
	día
STR_DAYS
	días
STR_HOUR
	hora
STR_HOURS
	horas
STR_MINUTE
	minuto
STR_MINUTES
	minutos
STR_SECOND
	segundo
STR_SECONDS
	segundos


# This is used in ChanServ/DogTag INFO displays.
COMMA_SPACE
	, 


# Various error messages.
USER_RECORD_NOT_FOUND
	Error Interno - imposible procesar comando.
UNKNOWN_COMMAND
	Comando desconocido %s.
UNKNOWN_COMMAND_HELP
	Comando desconocido %s.  Escriba /msg %s HELP para ayuda.
SYNTAX_ERROR
	Sintaxis: %s
MORE_INFO
	Escriba /msg %s HELP %s para mas información.
NO_HELP_AVAILABLE
	No existe ayuda disponible para %s.

BAD_EMAIL
	Dirección e-mail debe ser en el formato Usuario@ProveedorWeb.  No debes usar colores, negritas, subrayado, ni reverso, o alguno de estos caracteres: , : ; | \ " ( ) < >
BAD_URL
	URLs deben ser en el formato http://ProveedorWeb[:puerto]/... (o ftp://, etc.).
BAD_USERHOST_MASK
	Máscara debe ser en el formato Usuario@ProveedorWeb.
BAD_EXPIRY_TIME
	Fecha de expiración inválida.

SERVICE_OFFLINE
	%s está actualmente fuera de servicio.
READ_ONLY_MODE
	Noticia: Los K9 Servicios están en modo de leer solamente ; cambios no seran grabados!
PASSWORD_INCORRECT
	Contraseña incorrecta.

# What's the difference between "Access denied" and "Permission denied"?
# Very little; you can safely make them the same message with no real loss
# of meaning.  If you want to make a distinction, "Access denied" is
# usually used more generally; for example, a non-oper trying to access
# OperServ gets "Access denied", while a non-Services admin trying to use
# DogTag SET NOEXPIRE gets "Permission denied".
ACCESS_DENIED
	Acceso negado.
PERMISSION_DENIED
	Permiso negado.

MORE_OBSCURE_PASSWORD
	Favor trate de nuevo con una contraseña mas difícil. Contraseñas deben ser de 5 caracteres mínimo,no debe ser algo fácil de descifrar (ejemplo. su verdadero nombre o su apodo), tampoco debe contener espacios.
PASSWORD_TRUNCATED
	Noticia:  Su contraseña a sido limitada a %d caracteres.

NICK_NOT_REGISTERED
	Su apodo no está registrado.
NICK_NOT_REGISTERED_HELP
	Su apodo no está registrado.  Escriba /msg %s HELP para mas información de como registrar su apodo.
NICK_X_NOT_REGISTERED
	Apodo %s no está registrado.
NICK_X_NOT_IN_USE
	Apodo %s no está en uso en este momento.
NICK_X_FORBIDDEN
	Apodo %s no puede ser registrado o utilizado.
NICK_X_SUSPENDED
	Apodo %s está suspendido y no se puede utilizar o identificarse por él.
NICK_X_SUSPENDED_MEMOS
	Apodo %s está suspendido y no puede recibir mensajes.
NICK_IDENTIFY_REQUIRED
	Identificación con su contraseña se requiere para usar ese comando.
	Vuelva a intentar después de escribir /msg %s IDENTIFY Contraseña.
NICK_X_NOT_ON_CHAN_X
	Apodo %s no está actualmente en el canal %s.

CHAN_X_NOT_REGISTERED
	Canal %s no está registrado.
CHAN_X_NOT_IN_USE
	Canal %s no está en uso actualmente.
CHAN_X_FORBIDDEN
	Canal %s no puede ser registrado o utilizado.
CHAN_X_SUSPENDED
	Canal %s está suspendido y no se puede utilizar o identificarse por él.
CHAN_X_SUSPENDED_MEMOS
	Canal %s está suspendido y no puede recibir mensajes.
CHAN_IDENTIFY_REQUIRED
	Identificación con su contraseña se requiere para usar ese comando.
	Vuelva a intentar después de escribir /msg %s IDENTIFY Contraseña.

SERV_X_NOT_FOUND
	Servidor %s no encontrado.

EXPIRES_NONE
	no expira
EXPIRES_SOON
	expira en la siguiente actualización de la base de datos
EXPIRES_M
	expira en %d minutos
EXPIRES_1M
	expira en %d minuto
EXPIRES_HM
	expira en %d horas, %d minutos
EXPIRES_H1M
	expira en %d horas, %d minutos
EXPIRES_1HM
	expira en %d hora, %d minutos
EXPIRES_1H1M
	expira en %d hora, %d minuto
EXPIRES_D
	expira en %d días
EXPIRES_1D
	expira en %d día

###########################################################################
#
# DogTag messages
#
###########################################################################

# Automatic messages
NICK_IS_REGISTERED
	Este apodo pertence a otra persona.  Favor de escoger otro.
	(Si este es su apodo, escriba /msg %s IDENTIFY Contraseña.)
NICK_IS_SECURE
	Este apodo está registrado y protegido.  Si es su apodo
	Escriba /msg %s IDENTIFY Contraseña.  De lo contrario,
	favor de escoger un apodo diferente.
NICK_MAY_NOT_BE_USED
	Este apodo no puede utilizarse. Favor de escoger otro.
DISCONNECT_IN_1_MINUTE
	Si no cambia dentro de un minuto, será desconectado.
DISCONNECT_IN_20_SECONDS
	Si no cambia dentro de 20 segundos, será desconectado.
DISCONNECT_NOW
	Este apodo ha sido registrado; no lo puedes utilizar. Favor
	de escoger otro apodo antes de reconectar.
FORCENICKCHANGE_IN_1_MINUTE
	Si no cambias dentro de un minuto, cambiaré tu apodo.
FORCENICKCHANGE_IN_20_SECONDS
	Si no cambias dentro de 20 segundos, cambiaré tu apodo.
FORCENICKCHANGE_NOW
	Este apodo ha sido registrado; no lo puedes utilizar.
	Su apodo está ahóra siendo cambiado a %s.
NICK_EXPIRES_SOON
	Nota: La registración de su apodo expirará en %d %s.  Si usted desea continuar utilizando su apodo, favor de identificarse a %s Escribiendo: /msg %s IDENTIFY Contraseña
NICK_EXPIRED
	Nota: La registración de su apodo ha expirado.  Favor de re-registrar su apodo si usted quiere continuar utilizandolo.

# REGISTER responses
NICK_REGISTER_SYNTAX
	REGISTER Contraseña [Correo-Electrónico]
NICK_REGISTER_REQ_EMAIL_SYNTAX
	REGISTER Contraseña Correo-Electrónico
NICK_REGISTRATION_DISABLED
	Lo sentimos, el registro de apodos está temporaralmente deshabilitado.
NICK_REGISTRATION_FAILED
	Lo sentimos, la registración falló.
NICK_REG_PLEASE_WAIT
	Favor de esperar %d segundos antes de utilizar nuevamente el comando REGISTER.
NICK_CANNOT_BE_REGISTERED
	Apodo %s no puede ser registrado.
NICK_ALREADY_REGISTERED
	Apodo %s ya está registrado!
NICK_REGISTERED
	Apodo %s registrado bajo tu cuenta: %s
NICK_PASSWORD_IS
	Tu contraseña es %s - recuerda esto para uso posterior.

# IDENTIFY responses
NICK_IDENTIFY_SYNTAX
	IDENTIFY Contraseña
NICK_IDENTIFY_FAILED
	Lo sentimos, la identificación falló.
NICK_IDENTIFY_SUCCEEDED
	Contraseña aceptada - ahóra se le ha reconocido.

# DROP responses
NICK_DROP_SYNTAX
	DROP
NICK_DROP_DISABLED
	Lo sentimos, la cancelación de apodos está temporalmente deshabilitada.
NICK_DROPPED
	Su apodo ha sido cancelado.
NICK_X_DROPPED
	Apodo %s ha sido cancelado.

# SET responses
NICK_SET_SYNTAX
	SET Opción Parámetros
NICK_SET_SERVADMIN_SYNTAX
	SET [Apodo] Opción Parámetros
NICK_SET_DISABLED
	Lo sentimos, la configuración de opciones del apodo está temporalmente deshabilitada.
NICK_SET_UNKNOWN_OPTION
	Opción SET desconocida %s.
NICK_SET_UNKNOWN_OPTION_OR_BAD_NICK
	Opción SET %s desconocida, o su apodo no está registrado.

# SET PASSWORD responses
NICK_SET_PASSWORD_FAILED
	Lo sentimos, la contraseña no se pudo cambiar.
NICK_SET_PASSWORD_CHANGED
	Contraseña cambiada.
NICK_SET_PASSWORD_CHANGED_TO
	Contraseña cambiada a %s.

# SET LANGUAGE responses
NICK_SET_LANGUAGE_SYNTAX
	SET LANGUAGE Número
NICK_SET_LANGUAGE_UNKNOWN
	Número %d de lenguaje desconocido.  Escriba /msg %s HELP SET LANGUAGE para una lista de lenguajes disponibles.
NICK_SET_LANGUAGE_CHANGED
	Lenguaje cambiado a Español.

# SET URL responses
NICK_SET_URL_CHANGED
	URL para %s cambiado a %s.

# SET EMAIL responses
NICK_SET_EMAIL_CHANGED
	Correo electrónico (EMAIL) para %s cambiada a %s.

# SET KILL responses
NICK_SET_KILL_SYNTAX
	SET KILL {ON | QUICK | OFF}
NICK_SET_KILL_IMMED_SYNTAX
	SET KILL {ON | QUICK | IMMED | OFF}
NICK_SET_KILL_ON
	Protección de KILL ahóra Activada (ON).
NICK_SET_KILL_QUICK
	Protección de KILL ahóra Activada (ON), con una espera reducida.
NICK_SET_KILL_IMMED
	Protección de KILL Activada (ON), sin espera reducida.
NICK_SET_KILL_IMMED_DISABLED
	La opción IMMED no está disponible en esta red.
NICK_SET_KILL_OFF
	Protección de KILL ahóra Desactivada (OFF).

# SET SECURE responses
NICK_SET_SECURE_SYNTAX
	SET SECURE {ON | OFF}
NICK_SET_SECURE_ON
	Opción SECURE ahóra Activada (ON).
NICK_SET_SECURE_OFF
	Opción SECURE ahóra Desactivada (OFF).

# SET PRIVATE responses
NICK_SET_PRIVATE_SYNTAX
	SET PRIVATE {ON | OFF}
NICK_SET_PRIVATE_ON
	Opción PRIVATE ahóra Activada (ON).
NICK_SET_PRIVATE_OFF
	Opción PRIVATE ahóra Desactivada (OFF).

# SET HIDE responses
NICK_SET_HIDE_SYNTAX
	SET HIDE {EMAIL | USERMASK | QUIT} {ON | OFF}
NICK_SET_HIDE_EMAIL_ON
	Su correo electrónico será ahóra ocultada en la opción de %s INFO.
NICK_SET_HIDE_EMAIL_OFF
	Su correo electrónico será ahóra visible en la opción de %s INFO.
NICK_SET_HIDE_MASK_ON
	Su última máscara de Usuario@ProveedorWeb será ahóra ocultada en la opción de %s INFO.
NICK_SET_HIDE_MASK_OFF
	Su última máscara de Usuario@ProveedorWeb será ahóra visible en la opción de %s INFO.
NICK_SET_HIDE_QUIT_ON
	Su último mensaje de salida será ahóra ocultado en la opción de %s INFO.
NICK_SET_HIDE_QUIT_OFF
	Su último mensaje de salida será ahóra visible en la opción de %s INFO.

# SET NOEXPIRE responses
NICK_SET_NOEXPIRE_SYNTAX
	SET [Apodo] NOEXPIRE {ON | OFF}
NICK_SET_NOEXPIRE_ON
	Apodo %s No expirará.
NICK_SET_NOEXPIRE_OFF
	Apodo %s Si expirará.

# UNSET responses
NICK_UNSET_SYNTAX
	UNSET {URL | EMAIL}
NICK_UNSET_SYNTAX_REQ_EMAIL
	UNSET URL
NICK_UNSET_URL
	URL para %s está ahóra Indefinido (Unset).
NICK_UNSET_EMAIL
	Correo electrónico (EMAIL) para %s está ahóra Indefinido (Unset).
NICK_UNSET_EMAIL_BAD
	Imposible remover su correo electrónico (EMAIL).
NICK_UNSET_EMAIL_OTHER_BAD
	Imposible remover la direccion electrónica (e-mail) relacionada a su apodo.

# ACCESS responses
NICK_ACCESS_SYNTAX
	ACCESS {ADD | DEL | LIST} [Máscara]
NICK_ACCESS_ALREADY_PRESENT
	Máscara %s ya existe en su lista de acceso.
NICK_ACCESS_REACHED_LIMIT
	Lo sentimos, solamente puede tener %d entradas de acceso para su apodo.
NICK_ACCESS_ADDED
	%s añadido a su lista de acceso.
NICK_ACCESS_NOT_FOUND
	%s no fue encontrado en su lista de acceso.
NICK_ACCESS_DELETED
	%s removido de su lista de acceso.
NICK_ACCESS_LIST
	Lista de acceso:
NICK_ACCESS_LIST_X
	Lista de acceso para %s:

# LINK responses
NICK_LINK_SYNTAX
	LINK Apodo Contraseña
NICK_LINK_DISABLED
	El comando LINK no está disponible.
NICK_LINK_FAILED
	Lo sentimos, liga de apodo falló.
NICK_NO_LINK_SAME
	No puede ligar su apodo actual!
NICK_LINK_CIRCULAR
	Imposible ligar a apodo %s: liga circular detectada.
NICK_LINK_TOO_DEEP
	No puede crear una liga mayor de %d niveles de profundidad.
NICK_LINK_TOO_MANY_CHANNELS
	Imposible ligar el apodo %s: demasiados canales registrados (combinación máxima %d).
NICK_LINKED
	Su apodo ha sido ligado a %s.

# UNLINK responses
NICK_UNLINK_SYNTAX
	UNLINK [Apodo Contraseña]
NICK_UNLINK_FAILED
	Lo sentimos, la liga no pudo ser removida.
NICK_NOT_LINKED
	Su apodo no está ligado.
NICK_UNLINKED
	Su apodo ha sido desligado de %s.
NICK_X_NOT_LINKED
	Apodo %s no está ligado.
NICK_X_UNLINKED
	Apodo %s ha sido desligado de %s.

# LISTLINKS responses
NICK_LISTLINKS_SYNTAX
	LISTLINKS Apodo [ALL]
NICK_LISTLINKS_HEADER
	Lista de apodos ligados a %s:
NICK_LISTLINKS_FOOTER
	%d apodos ligados.
NICK_X_IS_LINKED
	    %s
NICK_X_IS_LINKED_VIA_X
	    %-20s (via %s)

# INFO responses
NICK_INFO_SYNTAX
	INFO Apodos [ALL]
NICK_INFO_REALNAME
	%s es %s
NICK_INFO_ADDRESS
	Última dirección vista: %s
NICK_INFO_ADDRESS_ONLINE
	   Está en línea usando: %s
NICK_INFO_ADDRESS_ONLINE_NOHOST
	%s está actualmente en línea.
NICK_INFO_TIME_REGGED
	  Fecha de registro: %s
NICK_INFO_LAST_SEEN
	   Se le vio por última vez en: %s
NICK_INFO_LAST_QUIT
	Último mensaje de salida: %s
NICK_INFO_URL
	              URL: %s
NICK_INFO_EMAIL
	   Correo electrónico: %s
NICK_INFO_OPTIONS
	          Opciones: %s
NICK_INFO_LINKED_TO
	        Ligado a: %s
# These strings MUST NOT be empty
NICK_INFO_OPT_KILL
	Protección de KILL
NICK_INFO_OPT_SECURE
	Seguro
NICK_INFO_OPT_PRIVATE
	Privado
NICK_INFO_OPT_NONE
	Ninguna
NICK_INFO_NO_EXPIRE
	Este apodo no expirará.
NICK_INFO_SUSPEND_DETAILS
	Suspendido por %s en %s (%s).
NICK_INFO_SUSPEND_REASON
	Razón: %s
NICK_INFO_SHOW_ALL
	Para mas información, escriba: /msg %s INFO %s ALL

# LISTCHANS responses
NICK_LISTCHANS_SYNTAX
	LISTCHANS
NICK_LISTCHANS_SERVADMIN_SYNTAX
	LISTCHANS [Apodo]
NICK_LISTCHANS_NONE
	%s no ha registrado canal alguno.
NICK_LISTCHANS_HEADER
	Canales registrados por %s:
NICK_LISTCHANS_ENTRY
	    %s
NICK_LISTCHANS_END
	Fin del listado (%d canales registrados).

# LIST responses
NICK_LIST_SYNTAX
	LIST Patrón
NICK_LIST_SERVADMIN_SYNTAX
	LIST Patrón [FORBIDDEN] [NOEXPIRE] [SUSPENDED]
NICK_LIST_HEADER
	Lista de entradas asociadas a %s:
NICK_LIST_RESULTS
	Fin del listado - %d/%d asociaciones visibles.

# RECOVER responses
NICK_RECOVER_SYNTAX
	RECOVER Apodo [Contraseña]
NICK_NO_RECOVER_SELF
	No puedes recobrarte a ti mismo!
NICK_RECOVERED
	El usuario que reclamaba su apodo ha sido desconectado.
	Escriba /msg %s RELEASE %s para recuperarlo ahóra y no esperar a un minuto.

# RELEASE responses
NICK_RELEASE_SYNTAX
	RELEASE Apodo [Contraseña]
NICK_RELEASE_NOT_HELD
	Apodo %s no está siendo retenido.
NICK_RELEASED
	K9 Servicios' Espere su apodo ha sido liberado.

# GHOST responses
NICK_GHOST_SYNTAX
	GHOST Apodo [Contraseña]
NICK_NO_GHOST_SELF
	No puedes usar el comando GHOST en ti mismo!
NICK_GHOST_KILLED
	El fantasma con su apodo ha sido desconectado.

# GETPASS responses
NICK_GETPASS_SYNTAX
	GETPASS Apodo
NICK_GETPASS_UNAVAILABLE
	Comando GETPASS no está disponible porque esta red está usando encripción.
NICK_GETPASS_PASSWORD_IS
	Contraseña para %s es %s.

# FORBID responses
NICK_FORBID_SYNTAX
	FORBID Apodo
NICK_FORBID_SUCCEEDED
	Apodo %s está ahóra prohibido.
NICK_FORBID_FAILED
	No se pudo prohibir el apodo %s!

# SUSPEND responses
NICK_SUSPEND_SYNTAX
	SUSPEND [+Expiración] Apodo Razón
NICK_SUSPEND_SUCCEEDED
	Apodo %s, y todos los apodos con la misma raiz, han sido suspendidos.
NICK_SUSPEND_ALREADY_SUSPENDED
	Apodo %s ya está suspendido.

# UNSUSPEND responses
NICK_UNSUSPEND_SYNTAX
	UNSUSPEND Apodo
NICK_UNSUSPEND_SUCCEEDED
	Apodo %s ya no está suspendido.
NICK_SUSPEND_NOT_SUSPENDED
	Apodo %s no está suspendido.

###########################################################################
#
# ChanServ messages
#
###########################################################################

# Access level descriptions
CHAN_LEVEL_AUTOOP
	Estatus de operador de canal automático
CHAN_LEVEL_AUTOVOICE
	Modo +v automático
CHAN_LEVEL_AUTODEOP
	No es permitido obtener estatus de operador de canal
CHAN_LEVEL_AUTODEOP_HALFOP
	No es permitido obtener estatus de Operador/MedioOP de canal
CHAN_LEVEL_NOJOIN
	No puede entrar al canal si está en modo RESTRICTED (RESTRINGIDO)
CHAN_LEVEL_INVITE
	Permitido usar el comando INVITE
CHAN_LEVEL_AKICK
	Permitido usar el comando AKICK
CHAN_LEVEL_SET
	Permitido usar el comando SET (excluidos FOUNDER/PASSWORD)
CHAN_LEVEL_CLEAR
	Permitido usar el comando CLEAR
CHAN_LEVEL_UNBAN
	Permitido usar el comando UNBAN
CHAN_LEVEL_OPDEOP
	Permitido usar los comandos OP/DEOP
CHAN_LEVEL_ACCESS_LIST
	Permitido ver la lista de acceso
CHAN_LEVEL_ACCESS_CHANGE
	Permitido modificar la lista de acceso
CHAN_LEVEL_MEMO
	Permitido alistar/leer los mensajes del canal (list/read)
CHAN_LEVEL_VOICE
	Permitido usar los comandos VOICE/DEVOICE
CHAN_LEVEL_AUTOHALFOP
	Estatus MedioOP (+h) automático
CHAN_LEVEL_HALFOP
	Permitido usar los comandos HALFOP/DEHALFOP (MitadOP/No-MitadOP)
CHAN_LEVEL_AUTOPROTECT
	Estatus de Protección de canal (+a) automático
CHAN_LEVEL_PROTECT
	Permitido usar los comandos PROTECT/DEPROTECT (Proteger/desproteger)

# Automatic responses
CHAN_IS_REGISTERED
	Este canal ha sido registrado con %s.
CHAN_NOT_ALLOWED_OP
	Usted no puede obtener estatus de operador en el canal %s.
CHAN_MAY_NOT_BE_USED
	Este canal no puede ser utilizado.
CHAN_NOT_ALLOWED_TO_JOIN
	No le es permitido ingresar a este canal.

# Multi-purpose responses
CHAN_BOUNCY_MODES
	Lo sentimos, el comando %s está temporaralmente deshabilitado.

# REGISTER responses
CHAN_REGISTER_SYNTAX
	REGISTER Canal Contraseña Descripcción
CHAN_REGISTER_DISABLED
	Lo sentimos, la registración de canales está temporalmente deshabilitada.
CHAN_REGISTER_NOT_LOCAL
	Canales locales no pueden ser registrados.
CHAN_MUST_REGISTER_NICK
	Usted debe registrar su apodo primeramente.  Escriba /msg %s HELP para información sobre como registrar apodos.
CHAN_MUST_IDENTIFY_NICK
	Favor de identificarse con %s primeramente, usando el comando:
	/msg %s IDENTIFY Contraseña
CHAN_MAY_NOT_BE_REGISTERED
	Canal %s no puede ser registrado.
CHAN_ALREADY_REGISTERED
	Canal %s ya está registrado!
CHAN_MUST_BE_CHANOP
	Usted debe ser operador del canal para poder registrarlo.
CHAN_REACHED_CHANNEL_LIMIT
	Lo sentimos, usted ya ha alcazado su límite de %d canales.
CHAN_EXCEEDED_CHANNEL_LIMIT
	Lo sentimos, usted ya ha excedido su límite de %d canales.
CHAN_REGISTRATION_FAILED
	Lo sentimos, la registración falló.
CHAN_REGISTERED
	Canal %s registrado bajo su apodo: %s
CHAN_PASSWORD_IS
	La contraseña de su canal es %s - recuerdela para uso posterior.
	
# IDENTIFY responses
CHAN_AUTH_SYNTAX
	AUTH <Canal> <Contrase>
CHAN_SETPASS_SYNTAX
	SETPASS <Canal> <new Contrase>
CHAN_IDENTIFY_FAILED
	Lo sentimos, la identificación falló.
CHAN_IDENTIFY_SUCCEEDED
	Contraseña acceptada - usted ahóra tiene acceso a nivel de fundador con %s.

# DROP responses
CHAN_DROP_SYNTAX
	DROP Canal
CHAN_DROP_DISABLED
	Lo sentimos, la cancelación de registro de canal está temporalmente deshabilitada.
CHAN_DROPPED
	Canal %s ha sido cancelado.

# SET responses
CHAN_SET_SYNTAX
	SET Canal Opción Parámetros
CHAN_SET_DISABLED
	Lo sentimos, el ajuste de opciones de canal está temporalmente deshabilitada.
CHAN_SET_UNKNOWN_OPTION
	Opción SET %s desconocida.

# SET FOUNDER responses
CHAN_SET_FOUNDER_TOO_MANY_CHANS
	%s tiene demasiados canales registrados.
CHAN_FOUNDER_CHANGED
	Fundador de %s cambiado a %s.

# SET SUCCESSOR responses
CHAN_SUCCESSOR_CHANGED
	Sucesor para %s cambiado a %s.
CHAN_SUCCESSOR_IS_FOUNDER
	Usted no puede convertir al fundador de un canal también en sucesor.

# SET PASSWORD responses
CHAN_SET_PASSWORD_FAILED
	Lo sentimos, fue imposible establecer la contraseña.
CHAN_PASSWORD_CHANGED
	Contraseña para %s cambiada.
CHAN_PASSWORD_CHANGED_TO
	Contraseña para %s cambiada a %s.

# SET DESC responses
CHAN_DESC_CHANGED
	Descripción de %s cambiada a %s.

# SET URL responses
CHAN_URL_CHANGED
	URL para %s cambiado a %s.

# SET EMAIL responses
CHAN_EMAIL_CHANGED
	Correo electrónico para %s cambiado a %s.

# SET ENTRYMSG responses
CHAN_ENTRY_MSG_CHANGED
	Mensaje de entrada para %s cambió.

# SET TOPIC responses
CHAN_SET_TOPIC_FAILED
	Lo sentimos, fue imposible establecer el tópico.

# SET MLOCK responses
CHAN_SET_MLOCK_KEY_REQUIRED
	Parámetro requerido para MLOCK +k.
CHAN_SET_MLOCK_LIMIT_REQUIRED
	Parámetro requerido para MLOCK +l.
CHAN_SET_MLOCK_LIMIT_POSITIVE
	Parámetro para MLOCK +l debe ser un número positivo.
CHAN_SET_MLOCK_MODE_REG_BAD
	Modo +%c es siempre establecido en canales registrados, y no puede ser usado con MLOCK (Opción Candado).
CHAN_SET_MLOCK_MODE_F_BAD
	Modo +f no puede ser fijado con la opción candado.
CHAN_SET_MLOCK_UNKNOWN_CHAR
	Modo con caractér %c es desconocido e ignorado.
CHAN_MLOCK_CHANGED
	Modo de candado en canal %s cambiado a %s.
CHAN_MLOCK_REMOVED
	Modo de candado en canal %s removido.

# SET KEEPTOPIC responses
CHAN_SET_KEEPTOPIC_SYNTAX
	SET Canal KEEPTOPIC {ON | OFF}
CHAN_SET_KEEPTOPIC_ON
	Opción de retención de tópico ahóra ACTIVADA (ON).
CHAN_SET_KEEPTOPIC_OFF
	Opción de retención de tópico ahóra DESACTIVADA (OFF).

# SET TOPICLOCK responses
CHAN_SET_TOPICLOCK_SYNTAX
	SET Canal TOPICLOCK {ON | OFF}
CHAN_SET_TOPICLOCK_ON
	Opción de candado en tópico ACTIVADA (ON).
CHAN_SET_TOPICLOCK_OFF
	Opción de candado en tópico DESACTIVADA (OFF).

# SET PRIVATE responses
CHAN_SET_PRIVATE_SYNTAX
	SET Canal PRIVATE {ON | OFF}
CHAN_SET_PRIVATE_ON
	Opción de privacidad ACTIVADA (ON).
CHAN_SET_PRIVATE_OFF
	Opción de privacidad DESACTIVADA (OFF).

# SET SECUREOPS responses
CHAN_SET_SECUREOPS_SYNTAX
	SET Canal SECUREOPS {ON | OFF}
CHAN_SET_SECUREOPS_ON
	Opción de SecureOPs (OPs Seguros) ACTIVADA (ON).
CHAN_SET_SECUREOPS_OFF
	Opción de SecureOPs (OPs Seguros) DESACTIVADA (OFF).

# SET LEAVEOPS responses
CHAN_SET_LEAVEOPS_SYNTAX
	SET Canal LEAVEOPS {ON | OFF}
CHAN_SET_LEAVEOPS_ON
	Opción de LeaveOPs (OPs Dejados) ACTIVADA (ON).
CHAN_SET_LEAVEOPS_OFF
	Opción de LeaveOPs (OPs Dejados) DESACTIVADA (OFF).

# SET RESTRICTED responses
CHAN_SET_RESTRICTED_SYNTAX
	SET Canal RESTRICTED {ON | OFF}
CHAN_SET_RESTRICTED_ON
	Opción de acceso restringido ACTIVADA (ON).
CHAN_SET_RESTRICTED_OFF
	Opción de acceso restringido DESACTIVADA (OFF).

# SET SECURE responses
CHAN_SET_SECURE_SYNTAX
	SET Canal SECURE {ON | OFF}
CHAN_SET_SECURE_ON
	Opción Secure (Seguro) ahóra ACTIVADA (ON).
CHAN_SET_SECURE_OFF
	Opción Secure (Seguro) ahóra DESACTIVADA (OFF).

# SET OPNOTICE responses
CHAN_SET_OPNOTICE_SYNTAX
	SET Canal OPNOTICE {ON | OFF}
CHAN_SET_OPNOTICE_ON
	Opción de Op-notice (Nota a OPs) ahóra ACTIVADA (ON).
CHAN_SET_OPNOTICE_OFF
	Opción de Op-notice (Nota a OPs) ahóra DESACTIVADA (OFF).

# SET ENFORCE responses
CHAN_SET_ENFORCE_SYNTAX
	SET Canal ENFORCE {ON | OFF}
CHAN_SET_ENFORCE_ON
	Opción de Enforce (Implementar) está ahóra ACTIVADA (ON).
CHAN_SET_ENFORCE_OFF
	Opción de Enforce (Implementar) está ahóra DESACTIVADA (OFF).

# SET NOEXPIRE responses
CHAN_SET_NOEXPIRE_SYNTAX
	SET Canal NOEXPIRE {ON | OFF}
CHAN_SET_NOEXPIRE_ON
	Canal %s NO expirará.
CHAN_SET_NOEXPIRE_OFF
	Canal %s SI expirará.

# UNSET responses
CHAN_UNSET_SYNTAX
	UNSET Canal {SUCCESSOR | URL | EMAIL | ENTRYMSG}
CHAN_SUCCESSOR_UNSET
	Sucesor para %s ahóra indefinido.
CHAN_URL_UNSET
	URL para %s ahóra indefinido.
CHAN_EMAIL_UNSET
	Correo electrónico (EMAIL) para %s ahóra indefinida.
CHAN_ENTRY_MSG_UNSET
	Mensaje de entrada para %s ahóra indefinido.

# ACCESS messages
CHAN_ACCESS_SYNTAX
	ACCESS Canal {ADD | DEL | LIST | COUNT} [Apodo [Nivel] | Lista-De-Entrada]
CHAN_ACCESS_DISABLED
	Lo sentimos, modificación a la lista de acceso de canal está temporalmente deshabilitada.
CHAN_ACCESS_LEVEL_NONZERO
	Nivel de acceso debe ser diferente a cero.
CHAN_ACCESS_LEVEL_RANGE
	Nivel de acceso debe estar entre %d y %d.
CHAN_ACCESS_NICKS_ONLY
	Lista de acceso de canal debera contener solamente apodos registrados.
CHAN_ACCESS_REACHED_LIMIT
	Lo sentimos, usted solamente puede tener %d entradas de acceso en un canal.
CHAN_ACCESS_LEVEL_UNCHANGED
	Nivel de acceso para %s en %s no cambio de %d.
CHAN_ACCESS_LEVEL_CHANGED
	Nivel de acceso para %s en %s fue cambiado a %d.
CHAN_ACCESS_ADDED
	%s agregado a la lista de acceso de %s con nivel %d.
CHAN_ACCESS_NO_SUCH_ENTRY
	Entrada desconocida (#%d) en la lista de acceso de %s.
CHAN_ACCESS_NOT_FOUND
	%s no fue encontrado en la lista de acceso de %s.
CHAN_ACCESS_NO_MATCH
	No entrada alguna en la lista de acceso de %s.
CHAN_ACCESS_DELETED
	%s borrado de la lista de acceso de %s.
CHAN_ACCESS_DELETED_ONE
	Borrada 1 entrada de la lista de acceso de %s.
CHAN_ACCESS_DELETED_SEVERAL
	Borradas %d entradas de la lista de acceso de %s.
CHAN_ACCESS_LIST_EMPTY
	La lista de acceso de %s está vacía.
CHAN_ACCESS_LIST_HEADER
	Lista de acceso para %s:
CHAN_ACCESS_COUNT
	La lista de acceso de %s tiene %d entradas.

# XOP (AOP/SOP/VOP) responses
CHAN_SOP_SYNTAX
	SOP Canal {ADD | DEL | LIST | COUNT} [Apodo | Lista-De-Acceso]
CHAN_AOP_SYNTAX
	AOP Canal {ADD | DEL | LIST | COUNT} [Apodo | Lista-De-Acceso]
CHAN_HOP_SYNTAX
	HOP Canal {ADD | DEL | LIST | COUNT} [Apodo | Lista-De-Acceso]
CHAN_VOP_SYNTAX
	VOP Canal {ADD | DEL | LIST | COUNT} [Apodo | Lista-De-Acceso]
CHAN_XOP_ADDED
	%s agregado a la lista de %s %s.
CHAN_XOP_LEVEL_CHANGED
	%s movido a la lista de %s %s.
CHAN_XOP_LEVEL_UNCHANGED
	%s ya está en la lista de %s %s.
CHAN_XOP_NICKS_ONLY
	Las listas de SOP, AOP, y VOP solo pueden contener apodos registrados.
CHAN_XOP_NICKS_ONLY_HOP
	Las listas de SOP, AOP, HOP, y VOP solo pueden contener apodos registrados.
CHAN_XOP_REACHED_LIMIT
	Lo sentimos, el número de entradas en sus listas de SOP, AOP y VOP
	no puede sobrepasar mas de %d entradas.  Límite excedido.
CHAN_XOP_REACHED_LIMIT_HOP
	Lo sentimos, el número de entradas en sus listas de SOP, AOP, HOP y VOP
	no puede sobrepasar mas de %d entradas.  Límite excedido.
CHAN_XOP_NOT_FOUND
	%s no fue encontrado en la lista de %s %s.
CHAN_XOP_NO_SUCH_ENTRY
	Entrada desconocida (#%d) en la lista de %s %s.
CHAN_XOP_NO_MATCH
	No entrada alguna en la lista de %s %s.
CHAN_XOP_DELETED
	%s borrado de la lista de %s %s.
CHAN_XOP_DELETED_ONE
	Borrada 1 entrada de la lista de %s %s.
CHAN_XOP_DELETED_SEVERAL
	Borrada %d entradas de la lista de %s %s.
CHAN_XOP_LIST_EMPTY
	La lista de %s %s está vacía.
CHAN_XOP_LIST_HEADER
	Lista de %s para %s:
	  Núm   Apodo
CHAN_XOP_LIST_FORMAT
	  %3d   %s%s%s%s
CHAN_XOP_COUNT
	La lista de %s %s tiene %d entradas.

# AKICK responses
CHAN_AKICK_SYNTAX
	AKICK Canal {ADD | DEL | LIST | VIEW | ENFORCE | COUNT} [Máscara | Lista]
CHAN_AKICK_DISABLED
	Lo sentimos, modificación a la lista de pateo automático de canal está temporalmente deshabilitada.
CHAN_AKICK_ALREADY_EXISTS
	%s ya existe en la lista de pateo automático de %s.
CHAN_AKICK_REACHED_LIMIT
	Lo sentimos, usted solo puede tener %d máscaras de pateo automático en un canal.
CHAN_AKICK_ADDED
	%s agregado a la lista de pateo automático de %s.
CHAN_AKICK_NO_SUCH_ENTRY
	Entrada desconocida (#%d) en la lista de pateo automático de %s.
CHAN_AKICK_NOT_FOUND
	%s no se encuentra en la lista de pateo automático de %s.
CHAN_AKICK_NO_MATCH
	No entrada alguna en la lista de pateo automático de %s.
CHAN_AKICK_DELETED
	%s borrado de la lista de pateo automático de %s.
CHAN_AKICK_DELETED_ONE
	Borrada 1 entrada de la lista de pateo automático de %s.
CHAN_AKICK_DELETED_SEVERAL
	Borradas %d entradas de la lista de pateo automático de %s.
CHAN_AKICK_LIST_EMPTY
	Lista de pateo automático de %s está vacía.
CHAN_AKICK_LIST_HEADER
	Lista de pateo automático para %s:
CHAN_AKICK_LIST_FORMAT
	  %3d %s%s
CHAN_AKICK_VIEW_FORMAT
	  %3d %s (por %s)
	    %s
CHAN_AKICK_ENFORCE_DONE
	Implementación de auto pateo para %s completado; %d usuarios fueron afectados.
CHAN_AKICK_COUNT
	%s tiene %d entradas en su lista de Auto Pateo.

# LEVELS responses
CHAN_LEVELS_SYNTAX
	LEVELS Canal {SET | DIS[ABLE] | LIST | RESET} [Articulo [Nivel]]
CHAN_LEVELS_RANGE
	Nivel debe de estar entre %d y %d.
CHAN_LEVELS_CHANGED
	Nivel para %s en canal %s cambiado a %d.
CHAN_LEVELS_UNKNOWN
	Opción %s desconocida.  Escriba /msg %s HELP LEVELS DESC para una lista de opciones válidas.
CHAN_LEVELS_DISABLED
	%s deshabilitado en canal %s.
CHAN_LEVELS_LIST_HEADER
	Configuración de nivel de acceso para canal %s:
CHAN_LEVELS_LIST_DISABLED
	    %-*s  (deshabilitado)
CHAN_LEVELS_LIST_FOUNDER
	    %-*s  (fundador solamente)
CHAN_LEVELS_LIST_NORMAL
	    %-*s  %d
CHAN_LEVELS_RESET
	Niveles de acceso para %s reconfigurados a los niveles originales.

# INFO responses
CHAN_INFO_SYNTAX
	INFO Canal [ALL]
CHAN_INFO_HEADER
	Información del canal %s:
CHAN_INFO_FOUNDER
	        Fundador: %s (%s)
CHAN_INFO_NO_FOUNDER
	        Fundador: %s
CHAN_INFO_SUCCESSOR
	      Sucesor: %s (%s)
CHAN_INFO_NO_SUCCESSOR
	      Sucesor: %s
CHAN_INFO_DESCRIPTION
	    Descripción: %s
CHAN_INFO_ENTRYMSG
	  Mensaje de Entrada: %s
CHAN_INFO_TIME_REGGED
	     Registrado: %s
CHAN_INFO_LAST_USED
	      Último uso: %s
CHAN_INFO_LAST_TOPIC
	     Último tópico: %s
CHAN_INFO_TOPIC_SET_BY
	   Tópico ajustado por: %s
CHAN_INFO_URL
	            URL: %s
CHAN_INFO_EMAIL
	 Correo electrónico: %s
CHAN_INFO_OPTIONS
	        Opciones: %s
CHAN_INFO_OPT_PRIVATE
	Privado
CHAN_INFO_OPT_KEEPTOPIC
	Retención de tópico
CHAN_INFO_OPT_TOPICLOCK
	Candado en tópico
CHAN_INFO_OPT_SECUREOPS
	OPs Seguros
CHAN_INFO_OPT_LEAVEOPS
	OPs Dejados
CHAN_INFO_OPT_RESTRICTED
	Acceso restringido
CHAN_INFO_OPT_SECURE
	Seguro
CHAN_INFO_OPT_OPNOTICE
	Nota a OPs
CHAN_INFO_OPT_ENFORCE
	Implementar
CHAN_INFO_OPT_NONE
	Ninguna
CHAN_INFO_MODE_LOCK
	The current mode guards are [%s]
CHAN_INFO_NO_EXPIRE
	Este canal no expirará.
CHAN_INFO_SUSPEND_DETAILS
	Suspendido por %s en %s (%s).
CHAN_INFO_SUSPEND_REASON
	Razón: %s
CHAN_INFO_SHOW_ALL
	Para mas información, Escriba: /msg %s INFO %s ALL

# LIST responses
CHAN_LIST_SYNTAX
	LIST Patrón
CHAN_LIST_SERVADMIN_SYNTAX
	LIST Patrón [FORBIDDEN] [NOEXPIRE]
CHAN_LIST_HEADER
	Lista de entradas relacionadas con %s:
CHAN_LIST_FORMAT
	    %-20s  %s
CHAN_LIST_END
	Fin de la lista - %d/%d entradas mostradas.

# INVITE responses
CHAN_INVITE_SYNTAX
	INVITE Canal <Apodo>
CHAN_INVITE_OK
	Invitando %s al canal %s.

# OP/DEOP/VOICE/DEVOICE responses
CHAN_OPVOICE_SYNTAX
	%s Canal Apodo
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
	UNBAN Canal
CHAN_UNBANNED
	Usted ya no está bloqueado en %s.

# CLEAR responses
CHAN_CLEAR_SYNTAX
	CLEAR Canal Opción
CHAN_CLEARED_BANS
	Todos los bloqueos en el canal %s han sido removidos.
CHAN_CLEARED_EXCEPTIONS
	Todas las excepciones en el canal %s han sido removidas.
CHAN_CLEARED_MODES
	Todos los modos en el canal %s han sido borrados.
CHAN_CLEARED_OPS
	Modo +o ha sido desactivado en el canal %s.
CHAN_CLEARED_HALFOPS
	Modo +h ha sido desactivado en el canal %s.
CHAN_CLEARED_VOICES
	Modo +v ha sido desactivado en el canal %s.
CHAN_CLEARED_USERS
	Todos los usuarios han sido pateados del canal %s.

# GETPASS responses
CHAN_GETPASS_SYNTAX
	GETPASS Canal
CHAN_GETPASS_UNAVAILABLE
	Comando GETPASS no está disponible porque la red esta usando encripción.
CHAN_GETPASS_PASSWORD_IS
	Contraseña para el canal %s es %s.

# FORBID responses
CHAN_FORBID_SYNTAX
	FORBID Canal
CHAN_FORBID_SUCCEEDED
	Canal %s está ahóra prohibido.
CHAN_FORBID_FAILED
	No fue posible prohibir el canal %s!

# SUSPEND responses
CHAN_SUSPEND_SYNTAX
	SUSPEND [+Expiración] Canal Razón
CHAN_SUSPEND_SUCCEEDED
	Canal %s ha sido suspendido.
CHAN_SUSPEND_ALREADY_SUSPENDED
	Canal %s ya está suspendido.

# UNSUSPEND responses
CHAN_UNSUSPEND_SYNTAX
	UNSUSPEND Canal
CHAN_UNSUSPEND_SUCCEEDED
	Suspensión del canal %s ha sido desactivada.
CHAN_SUSPEND_NOT_SUSPENDED
	Canal %s no está suspendido.

# MODE responses
OPER_MODE_SYNTAX
	MODE Canal Modos

###########################################################################
#
# DogTag help messages
#
###########################################################################

NICK_HELP
	%S le permite "registrar" un apodo y previene que
	otros hagan uso de él.  Si el apodo no es utilizado por
	%d días, el registro expirará.  Los siguientes comandos
	permiten la registración y también el mantenimiento de
	apodos; para utilizarlos, escriba /msg %S Comando.
	Para mas información en un comando específico, escriba:
	/msg %S HELP Comando.
	
	    REGISTER   Registre un apodo
	    IDENTIFY   Identifiquese con su contraseña
	    ACCESS     Modifique la lista de direcciones autorizadas
	    LINK       Haga su apodo un alias de otro
	    SET        Ajuste opciones, incluyendo protección de kill
	    DROP       Cancele el registro de un apodo
	    RECOVER    Desconecte otro usuario que este usando su apodo
	    RELEASE    Tome custodia de su apodo después de utilizar el
	                   comando RECOVER
	
	Otros comandos: UNLINK, UNSET, GHOST, INFO, LIST, LISTCHANS,
	                STATUS
	
	NOTA: Este servicio está diseñado para proveer una forma en la
	que los usuarios de IRC se aseguran de que su identidad no sea
	comprometida.  Su intención NO es para facilitar el "robo"
	de apodos u otras acciones mal intencionadas.  Abuso de
	%S resultará, por lo menos, en la pérdida de el/los
	apodo(s) abusado(s).

NICK_HELP_EXPIRE_ZERO
	%S le permite "registrar" un apodo y previene que
	otros hagan uso de él.  Si el apodo no es utilizado por
	%d días, el registro expirará.  Los siguientes comandos
	permiten la registración y también el mantenimiento de
	apodos; para utilizarlos, escriba /msg %S Comando.
	Para mas información en un comando específico, escriba:
	/msg %S HELP Comando.
	
	    REGISTER   Registre un apodo
	    IDENTIFY   Identifiquese con su contraseña
	    ACCESS     Modifique la lista de direcciones autorizadas
	    LINK       Haga su apodo un alias de otro
	    SET        Ajuste opciones, incluyendo protección de kill
	    DROP       Cancele el registro de un apodo
	    RECOVER    Desconecte otro usuario que este usando su apodo
	    RELEASE    Tome custodia de su apodo después de utilizar el
	                   comando RECOVER
	
	Otros comandos: UNLINK, UNSET, GHOST, INFO, LIST, LISTCHANS,
	                STATUS
	
	NOTA: Este servicio está diseñado para proveer una forma en la
	que los usuarios de IRC se aseguran de que su identidad no sea
	comprometida.  Su intención NO es para facilitar el "robo"
	de apodos u otras acciones mal intencionadas.  Abuso de
	%S resultará, por lo menos, en la pérdida de el/los
	apodo(s) abusado(s).

NICK_HELP_REGISTER
	Sintaxis: REGISTER Contraseña [Correo-Electrónico ]
	
	Registra su apodo en la base de datos de %S.  Una vez registrado
	su apodo, usted puede utilizar los comandos SET y ACCESS
	para configurar los parámetros de su apodo como usted los desee.
	Asegúrese de recordar la contraseña que utilizó para
	registrarse--la necesitará para hacer cambios a su apodo
	posteriormente.  (Nótese que las mayúsculas importan
	FIDO, Fido, y fido son todas diferentes contraseñas!)
	
	Usted puede incluir una dirección de correo electrónico (e-mail)
	cuando registre su apodo; también puede fijar una mas tarde usando
	el comando SET EMAIL.
	
	Sugerencias para escoger contraseñas:
	
	Contraseñas no deben ser fácil de adivinar.  Por ejemplo,
	usar su verdadero nombre como contraseña es una mala idea.
	Usar su apodo como contraseña es una idea peor ;) y, por
	supuesto que, %S no lo permitirá.  También, contraseñas
	cortas son vulnerables a búsquedas de prueba y error, por lo
	que usted debe escoger una contraseña de por lo menos 5
	caracteres.  Finalmente, el caracter de "espacio" no se
	puede utilizar en contraseñas.

NICK_HELP_REGISTER_REQ_EMAIL
	Sintaxis: REGISTER Contraseña Correo-Electrónico
	
	Registra su apodo en la base de datos de %S.  Una vez registrado
	su apodo, usted puede utilizar los comandos SET y ACCESS
	para configurar los parámetros de su apodo como usted los desee.
	Asegúrese de recordar la contraseña que utilizó para
	registrarse--la necesitará para hacer cambios a su apodo
	posteriormente.  (Nótese que las mayúsculas importan
	FIDO, Fido, y fido son todas diferentes contraseñas!)
	
	Usted debe incluir una dirección de correo Electrónico (e-mail)
	cuando registre su apodo.  Usted puede prevenir que su correo
	electrónico sea mostrado a otros usuarios con el comando SET HIDE
	(Escriba /msg %S HELP SET HIDE para mas información).
	
	Sugerencias para escoger contraseñas:
	
	Contraseñas no deben ser fácil de adivinar.  Por ejemplo,
	usar su verdadero nombre como contraseña es una mala idea.
	Usar su apodo como contraseña es una idea peor ;) y, por
	supuesto que, %S no lo permitirá.  También, contraseñas
	cortas son vulnerables a búsquedas de prueba y error, por lo
	que usted debe escoger una contraseña de por lo menos 5
	caracteres.  Finalmente, el caracter de "espacio" no se
	puede utilizar en contraseñas.

NICK_HELP_IDENTIFY
	Sintaxis: IDENTIFY Contraseña
	
	Notifica a %S que usted es el verdadero dueño de este
	apodo.  Muchos de los comandos requieren que usted se
	identifique con este comando antes de poder utilizarlos.  La
	contraseña debe ser la misma que utilizó con el comando
	REGISTER.

NICK_HELP_DROP
	Sintaxis: DROP
	
	Elimina su apodo de la base de datos de %S.  Un apodo
	que ha sido eliminado está disponible para que cualquier
	persona lo vuelva a registrar.
	
	Para utilizar este comando , usted tiene que identificarse
	con su  contraseña Escriba (/msg %S HELP IDENTIFY para
	mayor información).

NICK_HELP_ACCESS
	Sintaxis: ACCESS ADD Máscara
	          ACCESS DEL Máscara
	          ACCESS LIST
	
	Modifica o muestra la lista de acceso para su apodo. Esta
	es la lista de direcciones que %S reconocerá automáticamente
	como válidas para utilizar este apodo. Si desea utilizar este
	apodo desde otra dirección, necesita enviar el comando
	IDENTIFY para que %S lo reconozca a usted.
	
	Ejemplos:
	
	    ACCESS ADD achurch@*.dragonfire.net
	        Permite acceso al usuario achurch desde cualquier
		  computadora en el dominio dragonfire.net.
	
	    ACCESS DEL achurch@*.dragonfire.net
	        Hace lo contrario al comando anterior.
	
	    ACCESS LIST
	        Muestra la lista de acceso actual.

NICK_HELP_LINK
	Sintaxis: LINK Apodo Contraseña
	
	Liga su apodo a otro, efectivamente haciendo del apodo que
	usted utiliza actualmente un alias del otro especificado.
	Cuando usted utiliza este comando, la lista de acceso de
	el apodo que está usando es eliminada y reemplazada por la 
	del apodo con la que usted hace la liga; todos los mensajes
	para el apodo actual son agregados a la lista de mensajes de
	el apodo a ligar (esto puede causar que el apodo se exceda
	en su límite de mensajes, en este caso necesitará borrar
	algunos de los mensajes antes de poder recibir nuevos
	mensajes para cualquiera de ambos apodos).
	
	Una vez establecida la liga, su apodo será convertido
	transparentemente a el apodo nuevo en todas las bases de
	datos de los K9 Servicios, excepto para los comandos %S UNLINK
	y DROP.  Por ejemplo, puede utilizar cualquiera de los
	apodos para leer los mismos mensajes (y los mensajes que se
	envían a cualquiera de los apodos irán a la misma lista).  Si
	se identifica para un apodo, automáticamente se identificará
	para el otro. Si cualquiera de ambos apodos está en la lista
	de acceso de un canal, ambos apodos tendrán los mismos
	privilegios y accesos.
	
	Para utilizar este comando, usted debe de identificarse para
	su apodo actual (usando el comando IDENTIFY), y debe
	proporcionar la contraseña para el apodo al que desea ligarse.

NICK_HELP_UNLINK
	Sintaxis: UNLINK [Apodo Contraseña]
	
	Elimina la liga de su apodo hacia otro. Cuando la liga se
	elimina, los modos de un apodo y la lista de acceso de el
	apodo previamente ligado son copiados a su apodo actual y
	pueden ser modificados independientemente.  Mensajes no son
	copiados; todos los mensajes permanecen con el apodo
	previamente ligado.
	
	Cuando dé un apodo y contraseña como parámetros, usted podrá
	desligar otro apodo aparte del que está usando actualmente.

NICK_HELP_SET
	Sintaxis: SET Opción Parámetros
	
	Ajusta varias opciones del apodo. Donde Opción puede ser:
	
	    PASSWORD   Ajusta la contraseña de su apodo
	    LANGUAGE   Ajusta el lenguaje que K9 Servicios utilizará cuando
	                   envié mensajes a usted
	    URL        Asocia un URL con su apodo
	    EMAIL      Asocia una dirección de E-mail con su apodo
	    KILL       Activa/desactiva la protección de kill
	    SECURE     Activa/desactiva el modo SECURE para su apodo
	    PRIVATE    Evita que su apodo aparezca en
	                   /msg %S LIST
	    HIDE       Esconde ciertas informaciones sobre su apodo
	
	Para utilizar este comando es necesario identificarse antes
	con su contraseña. Escriba (/msg %S HELP IDENTIFY para
	mayor información).
	
	Escriba /msg %S HELP SET Opción para mayor información
	sobre una opción específica.

NICK_HELP_SET_PASSWORD
	Sintaxis: SET PASSWORD Nueva-Contraseña
	
	Cambia la contraseña que utiliza para identificarse como el
	dueño de el apodo.

NICK_HELP_SET_LANGUAGE
	Sintaxis: SET LANGUAGE Número
	
	Cambia el lenguaje que los K9 Servicios utilizan cuando envían
	mensajes a usted (por ejemplo cuando responden a un comando
	que usted envió).  Número debe ser escogido de la siguiente
	lista de lenguajes disponibles:
	

NICK_HELP_SET_URL
	Sintaxis: SET URL url
	
	Asocia el URL dado con su apodo.  Este URL será  mostrado
	cuando alguien solicite información sobre su apodo con el
	comando INFO.

NICK_HELP_SET_EMAIL
	Sintaxis: SET EMAIL Dirección
	
	Asocia la dirección de E-mail dada con su apodo.  Esta
	dirección será mostrada cuando alguien solicite información
	sobre su apodo con el comando INFO.

NICK_HELP_SET_KILL
	Sintaxis: SET KILL {ON | QUICK | IMMED | OFF}
	
	Activa/desactiva la protección de kill para su apodo.  Con
	protección de kill activada, si algún otro usuario intenta
	utilizar tu apodo, se le dará un minuto para que cambie a
	otro, si no será removido forzosamente de IRC por %S.
	
	Si selecciona QUICK, el usuario solo tendrá 20 segundos para
	cambiar de apodo en lugar de lo usual (60 segundos).  Si
	seleccionas IMMED, el usuario será desconectado (killed)
	inmediatamente sin ser avisado primero o darle una
	oportunidad de cambiar de apodo, favor de no utilizar esta
	opción a menos que sea verdaderamente necesario.  Los
	Cservice Members       Servicios la red pueden haber deshabilitado esta opción.

NICK_HELP_SET_SECURE
	Sintaxis: SET SECURE {ON | OFF}
	
	Activa/desactiva las funciones de seguridad de %S para
	su apodo.  Con SECURE activado, usted deberá enviar su
	contraseña antes de que se le reconozca como el dueño de
	el apodo, sin importar si su dirección este o no en la lista
	de acceso.  Sin embargo, si aparece en la lista de acceso,
	%S no lo desconectará automáticamente, independientemente 
	de como este la opción de KILL.

NICK_HELP_SET_PRIVATE
	Sintaxis: SET PRIVATE {ON | OFF}
	
	Activa/desactiva la opción privacidad de %S sobre su
	apodo.  Con PRIVATE activado, su apodo no aparecerá en las
	listas de apodos generadas con el comando %S LIST.
	(Sin embargo, cualquiera que conozca su apodo puede obtener
	información usando el comando INFO.)

NICK_HELP_SET_HIDE
	Sintaxis: SET HIDE {EMAIL | USERMASK | QUIT} {ON | OFF}
	
	Permite que usted evite que ciertos pedazos de información
	sean mostradas cuando alguien usa el comando %S INFO en su
	apodo.  Usted puede esconder su correo electrónico (EMAIL),
	última máscara usuario@host (USERMASK), o su último mensaje
	de salida (QUIT).  El segundo parámetro especifica cual 
	información debe ser mostrada (OFF) o escondida (ON).

NICK_HELP_UNSET
	Sintaxis: UNSET {URL | EMAIL}
	
	Le permite borrar el URL o la dirección de E-mail asociada
	con su apodo.  Use el parámetro URL para borrar el
	URL, o el parámetro EMAIL para borrar la dirección E-mail.
	Usted no puede borrarlos ambos al mismo tiempo.

NICK_HELP_UNSET_REQ_EMAIL
	Sintaxis: UNSET URL
	
	Le permite borrar el URL asociado con su
	apodo.  El parámetro URL debe ser dado.

NICK_HELP_RECOVER
	Sintaxis: RECOVER Apodo [Contraseña]
	
	Permite que usted recupere su apodo si alguien mas lo ha
	tomado; esto es lo mismo que %S hace automáticamente si
	alguien intenta utilizar un apodo protegido con kill.
	
	Cuando usted envía este comando, %S conectará  en línea a un
	usuario falso con el mismo apodo del usuario del cual usted
	desea recuperar su apodo.  Esto causará  que los servidores 
	de IRC desconecten al otro usuario.  Este usuario falso 
	permanecerá en línea por un minuto para asegurar que el otro 
	usuario no se reconecte inmediatamente; después de ese minuto,
	usted puede tomar su apodo.  Alternativamente, use el comando
	RELEASE (/msg %S HELP RELEASE) para obtener su apodo
	mas rápidamente.
	
	Para usar el comando RECOVER para un apodo, su dirección
	actual como se muestra en un /WHOIS debe de estar en la
	lista de acceso de el apodo, o usted debe de proporcionar la
	contraseña correcta para el apodo.

NICK_HELP_RELEASE
	Sintaxis: RELEASE Apodo [Contraseña]
	
	Instruye a %S que elimine cualquier retención en su apodo
	causada por un kill automático de protección o por el uso de
	el comando RECOVER.  Normalmente, la espera dura un minuto;
	este comando lo libera mas rápidamente.
	
	Para usar el comando RELEASE para un apodo, su dirección
	actual como se muestra en un /WHOIS debe de estar en la
	lista de acceso de el apodo, o usted deberá proporcionar la
	contraseña correcta para el apodo.

NICK_HELP_GHOST
	Sintaxis: GHOST Apodo [Contraseña]
	
	Termina una sesión "fantasma" de IRC que este utilizando su
	apodo.  Una sesión "fantasma" es aquella que no está
	realmente conectada, pero que el servidor de IRC acredita
	como activa por una razón u otra.  Típicamente esto sucede
	si su computadora se atora o su conexión a Internet se
	desconecta muy brevemente mientras está en IRC.
	
	Para usar el comando GHOST para un apodo, su dirección
	actual como se muestra en un /WHOIS debe de estar en la
	lista de acceso de el apodo, o usted debe de proporcionar
	la contraseña correcta para el apodo.

NICK_HELP_INFO
	Sintaxis: INFO Apodo [ALL]
	
	Muestra información sobre el apodo dado, como quien es
	el dueño, última dirección utilizada y hora, y las
	diferentes opciones del apodo. Si se identificó por el apodo
	del cual está reclamando información y ALL es especificado,
	se le mostrará toda la información; independientemente de si
	esta esté escondida o no.

NICK_HELP_LISTCHANS
	Sintaxis: LISTCHANS
	
	Lista los nombres y el número total de canales que usted
	ha registrado bajo su apodo.

NICK_HELP_LIST
	Sintaxis: LIST Patrón
	
	Lista todos los apodos registrados que concuerdan con un
	patrón dado en formato Apodo!usuario@host.  Apodos con 
	la opción de PRIVATE activada no serán mostrados.
	
	Ejemplos:
	
	    LIST *!joeuser@foo.com
	        Lista los apodos registrados por joeuser@foo.com.
	
	    LIST *Bot*!*@*
	        Lista todos los apodos registrados que contengan Bot
		  en su nombre (no importa mayúsculas).
	
	    LIST *!*@*.bar.org
	        Lista cada apodo registrado por usuarios del dominio bar.org.

NICK_HELP_STATUS
	Sintaxis: STATUS Apodo...
	
	Informa si el usuario de un apodo es reconocido como el dueño
	de el mismo.  La respuesta tiene el siguiente formato:
	
	    Apodo código-De-Estatus
	
	donde Apodo es el apodo enviado con el comando,
	Código-De-Estatus es uno de los siguientes:
	
	    0 - usuario no está conectado o apodo no está registrado
	    1 - usuario no reconocido como dueño del apodo
	    2 - usuario reconocido por la lista de acceso solamente
	    3 - usuario reconocido por identificación con contraseña
	
	Hasta 16 apodos pueden ser enviados con cada comando; el
	resto serán ignorados. No se genera mensaje de error alguno si
	no se envía un apodo.

NICK_SERVADMIN_HELP
	
	Los siguientes comandos están disponibles para los
	Cservice Members:
	
	    GETPASS    Muestra la contraseña para un apodo
	                   (solo si encripción está desactivada)
	    SUSPEND     Previene que alguien se identifique por un apodo dado
	    FORBID      Previene que un apodo sea utilizado/registrado
	    LISTLINKS   Lista los apodos ligados a un apodo (ligas)
	
	Cservice Members también pueden usar los siguientes
	comandos en cualquier apodo sin necesidad de identificarse:
	
	    DROP, SET, ACCESS LIST, INFO ALL

	Vea la ayuda para cada comando para detalles específicos.

NICK_SERVADMIN_HELP_DROP
	Sintaxis: DROP [Apodo]
	
	Sin parámetros, cancela el registro de su apodo en la base de
	datos de %S.
	
	Con un parámetro, cancela el registro de ese apodo en la base
	de datos.  Este comando está restringido a Administradores
	de K9 Servicios.

NICK_SERVADMIN_HELP_SET
	
	Cservice Members pueden seleccionar la opción
	NOEXPIRE, con la cual se puede prevenir que algunos apodos 
	no expiren.  Adicionalmente, los Cservice Members
	pueden establecer opciones para cualquier apodo sin necesidad
	de proveer una contraseña, utilizando el formato
	SET Apodo Opción Parámetros.

NICK_SERVADMIN_HELP_SET_NOEXPIRE
	Sintaxis: SET [Apodo] NOEXPIRE {ON | OFF}
	
	Define si el apodo dado expirará.  Si se define ON previene
	que el apodo expire.  Si no se incluye un apodo, entonces se
	aplica a tu propio apodo.
	
	Limitado a Cservice Members.

NICK_SERVADMIN_HELP_UNSET
	
	Cservice Members pueden usar el comando UNSET en
	cualquier apodo por medio de incluír el apodo antes del nombre
	de la opción, como en el comando SET.

NICK_SERVADMIN_HELP_UNLINK
	
	Cservice Members pueden desligar cualquier apodo sin
	necesidad de enviar una contraseña.

NICK_SERVADMIN_HELP_LISTLINKS
	Sintaxis: LISTLINKS Apodo [ALL]
	
	Alista los apodos que estén ligados al apodo dado.  Si ALL es
	especificado, alista cada apodo con los mismos privilegios del
	apodo dado; de otra manera, alista solamente aquellos apodos 
	directamente ligados al apodo dado.
	
	Limitado a Cservice Members.

NICK_SERVADMIN_HELP_ACCESS
	
	Cservice Members pueden dar un apodo como parámetro
	al comando LIST para mostrar la lista de acceso para cualquier apodo.

NICK_SERVADMIN_HELP_INFO
	
	Cservice Members pueden usar parámetro ALL en cualquier apodo.

NICK_SERVADMIN_HELP_LISTCHANS
	
	Cservice Members pueden alistar canales para cualquier apodo
	usando el apodo con el comando (por ejemplo,
	/msg DogTag LISTCHANS Cualquier-Apodo).

NICK_SERVADMIN_HELP_LIST
	Sintaxis: LIST Patrón [FORBIDDEN] [NOEXPIRE] [SUSPENDED]
	
	Lista todos los apodos registrados que concuerden con el
	patrón definido, con el formato Apodo!usuario@host. 
	Apodos con la opción PRIVATE activada solo serán mostrados
	a Cservice Members. Para los Cservice Members
	los apodos con la opción NOEXPIRE establecida
	tendrán el signo ! precedido al apodo y aquellos que son
	SUSPENDidos serán precedidos del signo *.
	
	Si las opciones FORBIDDEN, SUSPENDED o NOEXPIRE son dadas,
	solo apodos que, respectivamente, están bajo FORBID, SUSPEND o
	que tengan el modo NOEXPIRE fijado serán mostrados. Las opciones
	pueden ser usadas en cualquier orden o combinación. Estas opciones
	están limitadas a los Cservice Members.
	
	Ejemplos:
	
	    LIST *!joeuser@foo.com
	        Lista todos los apodos registrados por joeuser@foo.com.
	
	    LIST *Bot*!*@*
	        Lista todos los apodos registrados que contenga Bot
		  en su nombre (no importa mayúsculas).
	
	    LIST * NOEXPIRE
	        Lista todos los apodos registrados que han sido ajustados
	        para que no expiren.

NICK_SERVADMIN_HELP_GETPASS
	Sintaxis: GETPASS Apodo
	
	Muestra la contraseña para el apodo dado.  Note que cuando
	este comando es utilizado, un mensaje incluyendo el apodo de
	la persona que lo utiliza, y el apodo sobre el cual se interroga
	es grabado en el archivo y enviado como un mensaje global
	(WALLOPS/GLOBOPS).
	
	Limitado a Cservice Members.
	
	Este comando no está disponible cuando encripción está en
	uso.

NICK_SERVADMIN_HELP_FORBID
	Sintaxis: FORBID Apodo
	
	Prohibe a todos el registro y el uso de un apodo. Se puede
	revertir utilizando el comando DROP.
	
	Limitado a Cservice Members.

NICK_SERVADMIN_HELP_SUSPEND
	Sintaxis: SUSPEND [+Expiración] Apodo Razón
	
	Previene que un apodo, y todos aquellos apodos con el
	mismo apodo raíz, sean utilizados o que alguien se identifique
	por ellos. Puede lograrse que un apodo deje de estar suspendido
	por medio del comando UNSUSPEND.
	
	A diferencia de un apodo prohibido (FORBIDDEN), uno suspendido
	no pierde su información pero si expirará!
	
	Limitado a Cservice Members.

NICK_SERVADMIN_HELP_UNSUSPEND
	Sintaxis: UNSUSPEND Apodo
	
	Permite a los usuarios el uso y habilidad de identificarse por
	un apodo previamente SUSPENDido.
	
	Limitado a Cservice Members.


###########################################################################
#
# ChanServ help messages
#
###########################################################################

CHAN_HELP
	%S le permite a usted registrar y controlar varios aspectos
	de los canales.  %S frecuentemente previene el que
	usuarios mal intecionados puedan "tomar" el control limitando
	a quién se permite obtener privilegios de operador del canal. los
	comandos disponibles están listados abajo;  para usarlos, escriba
	/msg %S Comando.  Para mas información sobre un
	comando específico, escriba /msg %S HELP Comando.
	
	    REGISTER   Registre un canal
	    IDENTIFY   Identifiquese con su contraseña
	    DROP       Cancele la registración de un canal
	    INFO       Muestra opciones e información del canal
	    SET        Fija opciones e información del canal
	    ACCESS     Mantiene la lista general de acceso al canal
	    SOP        Mantiene la lista de SuperOp
	    AOP        Mantiene la lista de AutoOp
	    VOP        Mantiene la lista de AutoVoice
	    AKICK      Mantiene la lista de AutoKick

CHAN_HELP_OTHERS
	
	Otros comandos: UNSET, LIST, INVITE, UNBAN, CLEAR,
	                LEVELS, OP, DEOP, VOICE, DEVOICE

CHAN_HELP_OTHERS_HALFOP_CHANPROT
	
	Otros comandos: UNSET, LIST, INVITE, UNBAN, CLEAR,
	                LEVELS, OP, DEOP, VOICE, DEVOICE,
	                HALFOP, DEHALFOP, PROTECT, DEPROTECT,
	                HOP

CHAN_HELP_EXPIRES
	
	Note que si un canal no es utilizado por %d días (es decir
	qué ningún usuario en la lista de acceso del canal entra en
	ese periodo de tiempo) será automáticamente cancelado.

CHAN_HELP_REGISTER
	Sintaxis: REGISTER Canal Contraseña Descripción
	
	Registra un nuevo canal en la base de datos de %S.
	Para poder utilizar este comando, usted primero debe ser
	operador del canal que está tratando de registrar.  La
	contraseña deberá ser utilizada con el comando IDENTIFY
	cuando necesite hacer modificaciones posteriores a las
	opciones del canal.  El último parámetro, que debe ser
	incluido, es una descripción de los propósitos del canal.
	
	Cuando usted registra un canal, usted queda grabado como
	el "fundador" del canal. El fundador de un canal puede
	modificar cualquiera de las opciones para un canal;
	%S le dará automáticamente privilegios de operador 
	al fundador del canal cuando él/ella ingresen al canal
	Vea el comando ACCESS; (/msg %S HELP ACCESS) para 
	obtener información de como dar privilegios de operador 
	a otros usuarios del canal.
	
	AVISO: para poder registrar un canal, su apodo debe estar
	registrado.  Si aún no lo registró, escriba
	/msg %s HELP para obtener información de cómo hacerlo.

CHAN_HELP_IDENTIFY
	Sintaxis: IDENTIFY Canal Contraseña
	
	Lo identifica a usted ante %S como el fundador
	del canal.  Muchos comandos requieren que usted
	ejecute este comando antes de poder utilizarlos.  La
	contraseña debe ser la misma que se ingresó al momento
	de registrar el canal (comando REGISTER).

CHAN_HELP_DROP
	Sintaxis: DROP Canal
	
	Borra el canal nombrado.  Esto Puede ser utilizado
	únicamente por el fundador del canal, quien deberá
	primeramente identificarse con el comando IDENTIFY.

CHAN_HELP_SET
	Sintaxis: SET Canal Opción Parámetros
	
	Habilita al fundador del canal a definir varias opciones 
	e información del canal.  El fundador, debe hacer uso del
	comando IDENTIFY antes de utilizar SET.
	
	Opciones disponibles:
	
	    FOUNDER     Cambia el fundador de un canal
	    SUCCESSOR   Establece el sucesor para un canal
	    PASSWORD    Cambia la contraseña del fundador
	    DESC        Cambia la descripción del canal
	    URL         Asocia un URL con el canal
	    EMAIL       Asocia una direccion E-mail con el canal
	    ENTRYMSG    Fija un mensaje que será enviado a los usuarios
	                   cuando ellos entran al canal
	    TOPIC       Cambia el tópico en el canal
	    KEEPTOPIC   Retenga el tópico cuando el canal no es usado
	    TOPICLOCK   Tópico solo podrá ser cambiado via SET TOPIC
	    MLOCK       Fija los modos del canal en 'ON' u 'OFF'
	    PRIVATE     Oculta al canal del comando LIST
	    RESTRICTED  Restringe el acceso al canal
	    SECURE      Activa las opciones de seguridad de %S
	    SECUREOPS   Control mas estricto del estatus de operador
	    LEAVEOPS    No remover OPs a los usuarios al entrar al canal
	    OPNOTICE    Notifíca cuando los comandos OP/DEOP son usados
	    ENFORCE     Impone estatus auto-op y auto-voice de immediato
	
	Escriba /msg %S HELP Opción para mas información sobre una
	opción en particular.

CHAN_HELP_SET_FOUNDER
	Sintaxis: SET Canal FOUNDER Apodo
	
	Cambia el fundador de un canal.  El nuevo apodo debe
	ser uno registrado.

CHAN_HELP_SET_SUCCESSOR
	Sintaxis: SET Canal SUCCESSOR Apodo
	
	Cambia el sucesor de un canal.  Si el apodo del fundador
	expira o si es cancelado mientras el canal está todavia
	registrado, el sucesor se convertirá en el nuevo fundador
	del canal.  Sin embargo, si el sucesor ya tiene demaciados
	canales registrados (%d), el canal será cancelado como
	resultado, justo como si ningun sucesor hubiese sido fijado.
	El nuevo apodo debe ser uno registrado.

CHAN_HELP_SET_PASSWORD
	Sintaxis: SET Canal PASSWORD Contraseña
	
	Cambia la contraseña usada para identificarse como el fundador
	de el canal.

CHAN_HELP_SET_DESC
	Sintaxis: SET Canal DESC Descripción
	
	Cambia la descripción para el canal, que se muestra con
	los comandos LIST e INFO.

CHAN_HELP_SET_URL
	Sintaxis: SET Canal URL url
	
	Asocia con el canal el URL dado.  Este URL será
	mostrado siempre que alguien pida información sobre
	el canal con el comando INFO.

CHAN_HELP_SET_EMAIL
	Sintaxis: SET Canal EMAIL Dirección
	
	Asocia con el canal la dirección E-mail (correo electrónico) dada.
	Esta dirección será mostrada siempre que alguien pida
	información sobre el canal con el comando INFO.

CHAN_HELP_SET_ENTRYMSG
	Sintaxis: SET Canal ENTRYMSG Mensaje
	
	Fija el mensaje que será enviado via /notice a los 
	usuarios cuando estos entren al canal.

CHAN_HELP_SET_TOPIC
	Sintaxis: SET Canal TOPIC Tópico
	
	Causa que %S fije el tópico del canal a aquel que se
	le especifica.  Este comando es muy útil en conjunción 
	con el comando SET TOPICLOCK.

CHAN_HELP_SET_KEEPTOPIC
	Sintaxis: SET Canal KEEPTOPIC {ON | OFF}
	
	Habilita o deshabilita la opción de retención del tópico
	para el canal.  Cuando retención del tópico está en ON
	(activada), el tópico del canal será recordado por %S
	aún después que el último usuario se haya retirado, y se
	restaurará la próxima vez que alguien ingrese al canal.

CHAN_HELP_SET_TOPICLOCK
	Sintaxis: SET Canal TOPICLOCK {ON | OFF}
	
	Habilita o deshabilita la opción para candado en tópico del
	canal.  Cuando TOPICLOCK (candado en tópico) está en ON, %S 
	no habilitará el cambio del tópico excepto vía el comando
	SET TOPIC.

CHAN_HELP_SET_MLOCK
	Sintaxis: SET Canal MLOCK Modos
	
	Fija los distintos modos para el canal.  %S lo habilita a
	usted para definir determinados modos del canal y que queden
	siempre habilitados (o no).  Los modos que pueden ser
	fijados son: i, k, l, m, n, p, s, y t; cada
	uno de estos modos puede estar activado (ON), desactivado
	(OFF) o no fijado.  Distintos modos se indican justo como si
	se utilizase el comando /MODE; esto es, modo seguido de + 
	indica activado (ON), modo seguido de - indica desactivado (OFF).
	
	Cuidado!:  Si usted fija un modo protegido por contraseña,
	como en el segundo ejemplo, también deberá fijar la opción
	RESTRICTED para el canal (vea HELP SET RESTRICTED), o alguien
	que entre al canal cuando esté vacío, verá la contraseña!!
	
	Ejemplos:
	
	    SET #canal MLOCK +nt-iklps
	       Activa los modos n y t, y desactiva los modos i, k,
	       l, p, y s.  El modo m puede ser activado o desactivado.
	
	    SET #canal MLOCK +knst-ilmp mi-clave
	       Activa los modos k, n, s, y t.
	       Desactiva los modos i, l, m, y p.
	       También establece "mi-clave" como la contraseña del canal.
	
	    SET #canal MLOCK +
	       Elimina los modos activos; todos los modos del canal
	       pueden ser libremente activados o desactivados.

CHAN_HELP_SET_PRIVATE
	Sintaxis: SET Canal PRIVATE {ON | OFF}
	
	Habilita o deshabilita la opción de Privado para el canal.
	Cuando esta opción está activada, el comando /msg %S LIST no
	incluirá el canal en ninguna lista.

CHAN_HELP_SET_RESTRICTED
	Sintaxis: SET Canal RESTRICTED {ON | OFF}
	
	Habilita o deshabilita la opción de Acceso Restringido para
	el canal.  Cuando el acceso restringido está activo (ON),
	usuarios que normalmente no tienen privilegio de operadores
	cuando entran al canal (usuarios con nivel de acceso
	negativo y, si secure ops está activada, usuarios que NO
	están en la lista de acceso) serán expulsados (y se les
	prohibirá el acceso) al canal.

CHAN_HELP_SET_SECURE
	Sintaxis: SET Canal SECURE {ON | OFF}
	
	Habilita o deshabilita la seguridad de %S para el
	canal.  Cuando SECURE está ACTIVO, SOLO los usuarios que
	tienen registrados sus apodos con %s y que se han
	IDENTIFICADO con sus contraseñas tendrán privilegios en
	el canal si es que figuran en la lista de ACCESS (acceso).

CHAN_HELP_SET_SECUREOPS
	Sintaxis: SET Canal SECUREOPS {ON | OFF}
	
	Habilita o deshabilita la opción de OPs Seguros para
	un canal.  Cuando SECUREOPS está activada (ON),
	usuarios que NO estén en la lista de usuarios del canal NO
	podrán obtener estatus de operadores.

CHAN_HELP_SET_LEAVEOPS
	Sintaxis: SET Canal LEAVEOPS {ON | OFF}
	
	Habilita o deshabilita la opción Dejar OPs para un canal.
	Cuando LEAVEOPS es activada (ON), %S permite al servidor
	dar OPs (+o a la primera persona que entre al canal) inclusíve
	cuando la persona normalmente no obtiene Auto-OPs.  Opciones
	SECUREOPS y de nivel de acceso de AUTODEOP serán aún impuestas.
	Cuidado!:  Esto puede permitir que personas no autorizadas
	"roben" el estatus de Operador durante una ruptura de la red.

CHAN_HELP_SET_OPNOTICE
	Sintaxis: SET Canal OPNOTICE {ON | OFF}
	
	Habilita o deshabilita la opción Nota de OPs para un canal.
	Cuando OPNOTICE es activada (ON), %S enviará una nota al 
	canal siempre que los comandos OP o DEOP sean usados por 
	un usuario en el canal.

CHAN_HELP_SET_ENFORCE
	Sintaxis: SET Canal ENFORCE {ON | OFF}
	
	Habilita o deshabilita la opción de IMPONER a un canal. Cuando
	ENFORCE es activado (ON), %S impondrá los niveles de
	auto-op y auto-voice para todos los usuarios.  Por ejemplo, si a
	un usuario con privilegios de auto-op se le remueven los OPs, %S
	automáticamente le dará OPs al usuario de nuevo, y %S tampoco
	permitirá que el comando DEOP sea usado en aquel usuario.

CHAN_HELP_UNSET
	Sintaxis: UNSET Canal {SUCCESSOR | URL | EMAIL | ENTRYMSG}
	
	Borra los ajustes especificados de un canal.

CHAN_HELP_SOP
	Sintaxis: SOP Canal ADD Apodo
	          SOP Canal DEL Apodo
	          SOP Canal LIST [Máscara | Lista]
	          SOP Canal COUNT
	
CHAN_HELP_SOP_NOPROT
	Mantiene la lista de SuperOp (SOP) para un canal.
	Usuarios con el estatus SOP reciben OPs automaticamente
	(reciben modo +o) cuando estos ingresan al canal.
CHAN_HELP_SOP_PROT
	Mantiene la lista de SuperOp (SOP) para un canal.
	Usuarios con el estatus SOP reciben OPs automaticamente
	(reciben modo +o) y son protegidos (modo +a) cuando estos
	ingresan al canal.
CHAN_HELP_SOP_END
	
	Un SOP puede modificar las listas de AOP y VOP. Solo
	el fundador del canal puede modificar la lista de SOP.
	
	El comando SOP LIST muestra la lista SOP.  Si una máscara de
	comodín (signo *) es insertada, solamente aquellas entradas que 
	concuerden con esa máscara son mostradas.  Si se da una lista de 
	números de entrada, solo esas entradas se muestran; por ejemplo:
	
	   SOP #canal LIST 2-5,7-9
	      Muestra la lista de entradas SOP del número 2 hasta el 5 y
	      del 7 hasta 9.
	
	El comando SOP COUNT retorna el númbero de entradas que
	existen en la lista SOP.

CHAN_HELP_AOP
	Sintaxis: AOP Canal ADD Apodo
	          AOP Canal DEL Apodo
	          AOP Canal LIST [Máscara | Lista]
	          AOP Canal COUNT
	
	Mantiene la lista AutoOp (AOP) para un canal.
	Usuarios con estatus AOP reciben OPs automaticamente
	(reciben modo +o) cuando ingresan al canal.
	
	Un AOP puede modificar la lista VOP.
	
	El comando AOP LIST muestra la lista AOP.  Si una máscara de
	comodín (signo *) es insertada, solamente aquellas entradas que 
	concuerden con esa máscara son mostradas.  Si se da una lista de 
	números de entrada, solo esas entradas se muestran; por ejemplo:
	
	   AOP #canal LIST 2-5,7-9
	      Muestra la lista de entradas SOP del número 2 hasta el 5 y
	      del 7 hasta 9.
	
	El comando AOP COUNT retorna el número de entradas que
	existen en la lista AOP.

CHAN_HELP_HOP
	Sintaxis: HOP Canal ADD Apodo
	          HOP Canal DEL Apodo
	          HOP Canal LIST [Máscara | Lista]
	          HOP Canal COUNT
	
	Mantiene la lista HalfOp (HOP) para un canal.  Usuarios
	con estatus HOP reciben privilegios de Mitad-OP (reciben
	modo +h) automaticamente cuando estos ingresan al canal.
	
	Un HOP puede modificar la lista VOP; SOPs y AOPs pueden
	modificar la lista HOP.
	
	El comando HOP LIST muestra la lista HOP.  Si una máscara de
	comodín (signo *) es insertada, solamente aquellas entradas que 
	concuerden con esa máscara son mostradas.  Si se da una lista de 
	números de entrada, solo esas entradas se muestran; por ejemplo:
	
	   HOP #canal LIST 2-5,7-9
	      Muestra la lista de entradas HOP del número 2 hasta el 5 y
	      del 7 hasta 9.
	
	El comando HOP COUNT retorna el número de entradas que
	existen en la lista HOP.

CHAN_HELP_VOP
	Sintaxis: VOP Canal ADD Apodo
	          VOP Canal DEL Apodo
	          VOP Canal LIST [Máscara | Lista]
	          VOP Canal COUNT
	
	Mantiene la lista VoiceOp (VOP) para un canal.
	Usuarios con estatus VOP reciben vóz automaticamente 
	(reciben modo +v) cuando estos ingresan al canal.
	
	El comando VOP LIST muestra la lista VOP.  Si una máscara de
	comodín (signo *) es insertada, solamente aquellas entradas que 
	concuerden con esa máscara son mostradas.  Si se da una lista de 
	números de entrada, solo esas entradas se muestran; por ejemplo:
	
	   VOP #canal LIST 2-5,7-9
	      Muestra la lista de entradas VOP del número 2 hasta el 5 y
	      del 7 hasta 9.
	
	El comando VOP COUNT retorna el número de entradas que
	existen en la lista VOP.

CHAN_HELP_ACCESS
	Sintaxis: ACCESS Canal ADD Apodo Nivel
	          ACCESS Canal DEL {Apodo | Núm-de-Entrada | Lista}
	          ACCESS Canal LIST [Máscara | Lista]
	          ACCESS Canal COUNT
	
	Mantiene la Lista De Accesos del canal.  La lista de acceso
	establece qué usuarios están habilitados a ser operadores
	del canal o acceder a comandos de %S en el canal.  Se pueden
	establecer diferentes niveles de usuarios para acceder a
	diferentes privilegios; utilice /msg %S HELP ACCESS LEVELS
	para obtener información mas específica.  Cualquier apodo que
	no esté en la lista de acceso tiene nivel de usuario 0
	(cero).
	
	Note que la lista de acceso puede también ser manipulada con los
	comandos SOP, AOP, y VOP, los cuales corresponden a los
	niveles de %d, %d, y %d respectivamente.
	
	El comando ACCESS ADD agrega el apodo con el nivel dado a
	la lista de acceso; si el usuario ya existe en la lista, se
	reemplazará su nivel con el dado.  El nivel especificado debe
	ser menor que el que tiene el usuario que está ingresando el
	comando, y si el apodo está actualmente en la lista, el nivel 
	actual de dicho apodo debe ser menor que el nivel del usuario que
	está ingresando el comando.
	
	El comando ACCESS DEL remueve el apodo dado de la 
	lista de acceso.  Si una lista de números de entrada es dada,
	aquellas entradas son borradas.  (Vea el ejemplo para LIST abajo.)
	
	El comando ACCESS LIST muestra la lista de acceso.  Si una máscara
	de comodín (signo *) es insertada, solamente aquellas entradas que 
	concuerden con esa máscara son mostradas.  Si se da una lista de 
	números de entrada, solo esas entradas se muestran; por ejemplo:
	
	   ACCESS #canal LIST 2-5,7-9
	      Muestra la lista de entradas del número 2 hasta el 5 y
	      del 7 hasta 9.
	
	El comando ACCESS COUNT retorna el número de entradas que
	existen en la lista de acceso.

CHAN_HELP_ACCESS_LEVELS
	Niveles De Acceso Del Usuario
	
	Originalmente, los siguientes niveles son definidos:
	
	   Founder   Acceso completo a las funciones de %S; obtención
	                     automática de OPs al entrar al canal.  Note
	                     que solo UNA persona puede tener estatus de
	                     fundador (el cual no puede ser dado usando el
	                     comando ACCESS).
	      %4d   Acceso al comando AKICK; obtención automática de OPs.
	      %4d   Obtención automática de OPs.
	      %4d   Obtención automática de vóz (voice +v).
	         0   Ningún privilegio especial; otros operadores pueden
	                     darle OPs (a menos que SECUREOPS este fijado).
	        <0   No puede obtener OPs.
	
	Estos niveles no pueden ser cambiados, ni nuevos agregados, usando el
	comando LEVELS; escriba /msg %S HELP LEVELS para mas
	información.

CHAN_HELP_AKICK
	Sintaxis: AKICK Canal ADD Máscara [Razón]
	          AKICK Canal DEL Máscara
	          AKICK Canal LIST [Máscara | Lista]
	          AKICK Canal VIEW [Máscara | Lista]
	          AKICK Canal ENFORCE
	          AKICK Canal COUNT
	
	Mantiene la lista de Auto-Patear (AKICK) para un canal.  Si un
	usuario en la lista de Auto-Patear intenta ingresar al canal,
	%S lo bloqueará (ban) del canal, despues lo pateará (kick).
	
	El comando AKICK ADD agrega un usuario a la lista de AKICK.
	Si una razón es dada con el comando, entonces la razón será
	utilizada por %S cuando expulse a dicho usuario; si
	no, el mensaje que se utilizará por defecto, es "You have
	been banned from the channel" (Estas bloqueado del canal).
	
	El comando AKICK DEL elimina el usuario o máscara dada de la
	lista AKICK.  Este comando no remueve sin embargo bloqueos (bans)
	existentes en el canal, los que deberán ser removidos manualmente.
	
	El comando AKICK LIST muestra la lista de usuarios en la
	lista de AKICK.  AKICK VIEW simplemente muestra mas detalles.
	
	El comando AKICK ENFORCE causa que %S imponga la lista AKICK
	actual por medio de remover aquellos usuarios que concuerdan con
	una máscara AKICK .
	
	El comando AKICK COUNT retorna cuantas entradas existen
	en la lista de Auto-Pateo (AKICK).

CHAN_HELP_LEVELS
	Sintaxis: LEVELS Canal SET Tipo Nivel
	          LEVELS Canal {DIS | DISABLE} Tipo
	          LEVELS Canal LIST
	          LEVELS Canal RESET
	
	El comando LEVELS permite un control fino sobre los accesos
	numéricos utilizados por los canales.  Con este comando,
	usted puede definir los niveles requeridos para muchas de
	las funciones de %S.  Los comandos SET FOUNDER,
	SET PASSWORD, así como éste comando están siempre
	restringidos al fundador.
	
	Cuidado!:  Este comando es solo para usuarios avanzados!  Cambiar
	las opciones de nivel con este comando puede causar que los comandos
	SOP, AOP, y VOP dejen de funcionar correctamente.
	
	LEVELS SET permite el nivel de acceso para una función o grupo
	de funciones a ser cambiadas.  LEVELS DISABLE (o DIS abreviado)
	deshabilita una opción automática o prohibe el acceso a una
	función por cualquiera que no sea el fundador del canal.
	LEVELS LIST muestra el nivel actual para cada función o
	grupo de funciones.  LEVELS RESET reajusta los niveles a los
	niveles originales de un canal recien creado (vea
	HELP ACCESS LEVELS para mas información).
	
	Para una lista de las opciones y funciones a los que se le puede 
	ajustar los niveles, vea HELP LEVELS DESC.

CHAN_HELP_LEVELS_DESC
	La siguiente lista muestra los valores/funciones originalemente
	establecidos.  Note que los niveles para AUTODEOP y NOJOIN son
	los máximos niveles, mientras que todos los demás, son los
	mínimos.

CHAN_HELP_LEVELS_DESC_FORMAT
	    %-*s  %s

CHAN_HELP_INFO
	Sintaxis: INFO Canal [ALL]
	
	Lista información sobre el canal registrado especificado,
	incluyendo su fundador, fecha de registro, última vez usado,
	descripción, y modo lock (candado), si existe.  Si usted se
	ha identificado como el fundador del canal del cual pide
	información y ALL es especificado, el mensaje de entrada
	y el sucesor también serán mostrado.

CHAN_HELP_LIST
	Sintaxis: LIST Patrón
	
	Lista todos los canales registrados que coincidan con el patrón dado.
	(Canales con la opción PRIVATE fijada no son alistados.)

CHAN_HELP_OP
	Sintaxis: OP #canal Apodo
	
	Convierte en Operador al usuario dado en el canal indicado.  Originalmente,
	esto está limitado a aquellos con nivel 5 de acceso o superior en el canal.

CHAN_HELP_DEOP
	Sintaxis: DEOP #Canal Apodo
	
	Retira estatus "operador" (+o) del usuario dado en el canal indicado. Originalmente
	esto está limitado a aquellos con nivel 5 de acceso o mayor en el canal.
	
CHAN_HELP_VOICE
	Sintaxis: VOICE #Canal Apodo
	
	Da voz (+v) al apodo seleccionado en un canal.  Originalmente, limitado 
	a aquellos con nivel 3 de acceso o superior en el canal.

CHAN_HELP_DEVOICE
	Sintaxis: DEVOICE #Canal Apodo
	
	Retira la voz (-v) del apodo seleccionado en el canal.  Originalmente,
	limitado a aquellos con nivel 3 de acceso o superior en el canal.

CHAN_HELP_HALFOP
	Sintaxis: HALFOP #Canal Apodo
	
	Da acceso midad-OP (+h) al apodo seleccionado en un canal.  Originalmente,
	limitado a aquellos con nivel 4 de acceso o superior en el canal.

CHAN_HELP_DEHALFOP
	Sintaxis: DEHALFOP #Canal Apodo
	
	Remueve el acceso mitad-OP (halfop +h) del apodo seleccionado en un canal.
	Originalmente, limitado a aquellos con nivel 4 de acceso o mayor en el canal.

CHAN_HELP_PROTECT
	Sintaxis: PROTECT #Canal Apodo
	
	Da protección de canal (modo +a) a un apodo seleccionado en un
	canal.  Originalmente, limitado a aquellos con nivel 10 de acceso
	o superior en el canal.

CHAN_HELP_DEPROTECT
	Sintaxis: DEPROTECT #Canal Apodo
	
	Remueve la protección de canal (modo +a) del apodo seleccionado
	en un canal.  Originalmente, limitado a aquellos con nivel 10
	de acceso o superior en el canal.

CHAN_HELP_INVITE
	Sintaxis: INVITE Canal
	
	Le dice a %S que lo invite a usted a ingresar al canal dado. 
	Originalmente, solamente funciona si su nivel de acceso en aquel
	canal es de por lo menos 5.

CHAN_HELP_UNBAN
	Sintaxis: UNBAN Canal
	
	Le dice a %S que remueva todos los bans (bloqueos) que lo retienen
	a usted de ingresar al canal especificado.  Originalmente, solo
	funciona si su nivel de acceso en aquel canal es por lo menos 5.

CHAN_HELP_CLEAR
	Sintaxis: CLEAR Canal Algo
	
	Le dice a %S que borre ciertos ajustes en un canal.  Algo
	puede ser cualquiera de las siguientes opciones:
	
	     MODES       Borra todos los modos en el canal excepto aquellos
	                     modos fijados con la opción MLOCK.
	     BANS        Borra todos los bans (bloqueos) en el canal.
CHAN_HELP_CLEAR_EXCEPTIONS
	     EXCEPTIONS  Borra todas las excepciones en el canal.
CHAN_HELP_CLEAR_MID
	     OPS         Remueve el estatus de operador de canal (modo +o)
	                     de todos los usuarios.
CHAN_HELP_CLEAR_HALFOPS
	     HALFOPS     Remueve el estatus de medio operador o halfop
	                     (modo +h) de todos los usuarios.
CHAN_HELP_CLEAR_END
	     VOICES      Remueve el estatus "voice" (modo +v) de todo usuario.
	     USERS       Remueve o Patea (kicks) todos los usuarios del canal.
	
	Originalmente, su nivel de acceso en el canal debe ser por
	lo menos 10 para poder utilizar este comando.

CHAN_SERVADMIN_HELP
	
	Comandos para los Cservice Members:
	
	    GETPASS   Recobre la contraseña de fundador para un canal
	                  (solo si encripción está deshabilitada)
	    FORBID    Prevenga el que un canal sea registrado/usado
	    SUSPEND   Prevenga el que un canal registrado sea usado
	    STATUS    Retorna el nivel de acceso actual para un usuario
	                  en un canal
	
	Cservice Members también pueden cancelar cualquier 
	canal sin identificarse via contraseña, y pueden ver las listas
	de acceso, AKICK, y de ajuste de niveles para cualquier canal.

CHAN_SERVADMIN_HELP_DROP
	Sintaxis: DROP Canal
	
	Elimina el canal seleccionado.  Solamente los 
	Cservice Members pueden eliminar un canal
	por el cual no se han identificado.

CHAN_SERVADMIN_HELP_SET
	
	Cservice Members también pueden fijar la opción NOEXPIRE,
	con la cual se puede prevenir el que los canales expiren. Adicionalmente,
	los Cservice Members pueden fijar opciones para cualquier 
	canal sin identificarse via contraseña por el canal.

CHAN_SERVADMIN_HELP_UNSET
	
	Igual que con el comando SET, los Cservice Members pueden
	borrar ajustes para cualquier canal sin identificarse por el canal.

CHAN_SERVADMIN_HELP_SET_NOEXPIRE
	Sintaxis: SET Canal NOEXPIRE {ON | OFF}
	
	Ajusta si el canal especificado expirará o no.  Ajustar esta opción
	a ON previene que el canal expire.
	
	Limitado a los Cservice Members.

CHAN_SERVADMIN_HELP_INFO
	
	Cservice Members pueden usar el parámetro ALL con cualquier canal.

CHAN_SERVADMIN_HELP_LIST
	Sintaxis: LIST Patrón [FORBIDDEN] [NOEXPIRE] [SUSPENDED]
	
	Lista todos los canales registrados que concuerden con el patrón dado.
	Canales con la opción PRIVATE activada solamente serán mostrados a 
	los Cservice Members. Canales con la opción NOEXPIRE activada
	tendrán un signo ! antecediendo al nombre del canal, Esto en el caso de
	los Cservice Members.
	
	Si las opciones FORBIDDEN, SUSPENDED o NOEXPIRE son dadas, solo
	aquellos canales que, respectivamente, tienen las opciones FORBID, SUSPEND
	o que tienen el modo NOEXPIRE activado serán mostrados. Las opciones pueden
	ser utilizadas en cualquier orden y en cualquier combinación. Estas opciones
	están limitadas a los Cservice Members.

CHAN_SERVADMIN_HELP_GETPASS
	Sintaxis: GETPASS Canal
	
	Retorna la contraseña para el canal indicado.  Note que
	siempre que este comando es usado, un mensaje incluyendo la
	persona que ejuctó el comando y el canal para el cual fue
	usado será archivado y enviado en forma de WALLOPS/GLOBOPS.
	
	Limitado a Cservice Members.

CHAN_SERVADMIN_HELP_FORBID
	Sintaxis: FORBID Canal
	
	Deshabilita el que alguien registre o utilice el canal indicado.
	Esto puede ser revertido por medio de eliminar el canal (drop).
	
	Limitado a Cservice Members.

CHAN_SERVADMIN_HELP_SUSPEND
	Sintaxis: SUSPEND [+Expiración] Canal Razón
	
	Previene el que un canal sea utilizado o el que alguien se 
	identifique por él. Esta acción puede ser revertida por medio
	de usar el comando UNSUSPEND.
	
	A diferencia de un canal prohibido (forbidden), uno suspendido no
	pierde su información y SI expirará!
	
	Limitado a Cservice Members.

CHAN_SERVADMIN_HELP_UNSUSPEND
	Sintaxis: UNSUSPEND Canal
	
	Permite a los usuarios el uso y el que se identifiquen por un
	canal que habia sido previamente suspendido (suspend).
	
	Limitado a Cservice Members.

CHAN_SERVADMIN_HELP_STATUS
	Sintaxis: STATUS Canal Apodo
	
	Retorna el nivel de acceso actual para el apodo indicado en el
	canal indicado.  La respuesta es de la forma:
	
	    STATUS Canal Apodo Nivel-De-Acceso
	
	Si ocurre un error, la respuesta será en la forma:
	
	    STATUS ERROR Mensaje-Del-Error
	
	Limitado a Cservice Members.


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

