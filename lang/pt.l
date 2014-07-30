# Emacs mode: -*- text -*-$B!!(B

# Portuguese language file.
#
# K9 IRC Services (c) 2001-2002 |SaMaN|
# Contact me at linuxworm@turk.net
# This program is free but copyrighted software; see the file COPYING for
# details.
#
# Based on the original code of Services by Andy Church.
#

# Quando traduzindo este programa para outra idioma, lembre-se que a
# ordem dos parametros para sprintf() eh fixado no codigo de fonte, entao
# suas mensagens precisam ter os mesmos parametros nos mesmos padroes das
# mensagens em ingles.  (Obviamente, isto nao eh valido para linhas no formato
# strftime() que ficam uma abaixo das outras).  Se voce nao pode adquirir uma
# traducao das mensagens naturalmente sem mudar as ordens dos parametros, me
# avise (achurch@dragonfire.net) qual mensagem esta causando o problema e eu
# verei o que posso fazer.
#
# Nas mensagens de ajuda, "%S" (S maiusculo, nao minusculo) se refere ao nome
# do servico que envia a mensagem; por exemplo, na mensagem de ajuda do
# DogTag, "%S" eh substituido por "DogTag" (ou outro nome definido
# no config.h).  Os %S's nao contam como sendo parametros de sprintf(),
# assim podem ser reorganizados, removidos, ou adicionados se necessario.
#
# Finalmente, lembre-se de colocar TAB no comeco de toda linha do texto
# (incluindo linhas vazias). Tem que ser TAB, nao espacos.

###########################################################################
#
# Nome deste idioma
#
###########################################################################

# Para idiomas diferentes do ingles, essa string deve ter o seguinte formato:
#     language-name-in-language (language-name-in-English)
# Por exemplo, "Español (Spanish)" or "Français (French)".

LANG_NAME
	Portugues (Portuguese)

###########################################################################
#
# Mensagens Gerais
#
###########################################################################

# Strings no formato strftime(). "man 3 strftime" para informacoes sobre o
# significado da especificacao do formato.  Versao pequena:
#	%a = nome do dia da semana (pequeno)	%H = hora
#	%b = nome do mes (pequeno)		%M = minuto
#	%d = dia do mes				%S = segundo
#	%Y = ano				%Z = zona de fuso horario

# O seguinte eh usado para o formato de uma string da strftime(), com uma
# data e horario mostrados juntamente.
STRFTIME_DATE_TIME_FORMAT
	%d %b %H:%M:%S %Y %Z
# O seguinte eh usado para o formato de uma string da strftime(), com uma
# data sozinha de formato longo (Para o ingles inclui-se o dia da semana).
STRFTIME_LONG_DATE_FORMAT
	%a %d %b %Y
# O seguinte eh usado para o formato de uma string da strftime(), com apenas
# a data em formato curto (Para o ingles: sem o dia da semana).
STRFTIME_SHORT_DATE_FORMAT
	%d %b %Y

# Estes especificam para a strftime() quais sao os nomes dos dias e meses.
# Se voce nao usar %a, %A, %b, or %B nas suas strings da strftime(), pode
# deixar essas partes vazias.  No entanto, se voce colocar nomes, eles DEVEM ficar
# ordenados, um por linha, e a lista DEVE estar completa!

# %a
STRFTIME_DAYS_SHORT
	Dom
	Seg
	Ter
	Qua
	Qui
	Sex
	Sab
# %A
STRFTIME_DAYS_LONG
	Domingo
	Segunda
	Terca
	Quarta
	Quinta
	Sexta
	Sabado
# %b
STRFTIME_MONTHS_SHORT
	Jan
	Fev
	Mar
	Abr
	Mai
	Jun
	Jul
	Ago
	Set
	Out
	Nov
	Dez
# %B
STRFTIME_MONTHS_LONG
	Janeiro
	Fevereiro
	Marco
	Abril
	Maio
	Junho
	Julho
	Agosto
	Setembro
	Outubro
	Novembro
	Dezembro


# "day", "hour", "minute", and "second" in singular and plural.
STR_DAY
	dia
STR_DAYS
	dias
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
	Erro interno - impossivel processar o pedido.
UNKNOWN_COMMAND
	Comando %s desconhecido.
UNKNOWN_COMMAND_HELP
	Comando %s desconhecido.  Digite /msg %s HELP para ajuda.
SYNTAX_ERROR
	Sintaxe: %s
MORE_INFO
	Digite /msg %s HELP %s para maiores informacoes.
NO_HELP_AVAILABLE
	Ajuda nao disponivel para %s.

BAD_EMAIL
	Enderecos de e-mail precisam ser no formato username@hostname.  Voce nao pode usar cores, negrito, sublinhado, reverso ou os caracteres: , : ; \ " ( ) < >
BAD_URL
	URLs precisam ser no formato http://hostname[:port]/... (ou ftp://, etc.).
BAD_USERHOST_MASK
	Mascaras devem estar no formato ident@host.
BAD_EXPIRY_TIME
	Tempo de expiracao invalido.

SERVICE_OFFLINE
	%s esta atualmente desligado.
READ_ONLY_MODE
	Atencao: K9 Services esta no modo read-only; mudancas nao serao salvas!
PASSWORD_INCORRECT
	Senha incorreta.

ACCESS_DENIED
	Acesso negado.
PERMISSION_DENIED
	Permissao negada.

MORE_OBSCURE_PASSWORD
	Tente novamente com uma senha mais dificil.  As senhas devem ter no minimo cinco caracteres, nao devem ser algo deduzivel (ex: seu nome ou nick) e nao podem conter espacos ou TAB.
PASSWORD_TRUNCATED
	Notice:  Sua senha foi limitada a %d caracteres.

NICK_NOT_REGISTERED
	Seu nick nao esta registrado.
NICK_NOT_REGISTERED_HELP
	Seu nick nao esta registrado.  Digite /msg %s HELP para mais informacoes sobre como registra-lo.
NICK_X_NOT_REGISTERED
	Nick %s nao esta registrado.
NICK_X_NOT_IN_USE
	Nick %s nao esta em uso no momento.
NICK_X_FORBIDDEN
	Nick %s nao pode ser utilizado ou registrado.
NICK_X_SUSPENDED
	Nick %s esta suspenso e nao pode ser utilizado ou identificado.
NICK_X_SUSPENDED_MEMOS
	Nick %s esta suspenso e nao pode receber memos.
NICK_IDENTIFY_REQUIRED
	Autenticacao de senha eh necessaria para este comando.
	Tente novamente apos digitar /msg %s IDENTIFY senha.
NICK_X_NOT_ON_CHAN_X
	Nick %s nao esta no %s no momento.

CHAN_X_NOT_REGISTERED
	Canal %s nao esta registrado.
CHAN_X_NOT_IN_USE
	Canal %s nao existe.
CHAN_X_FORBIDDEN
	Canal %s nao pode ser utilizado ou registrado.
CHAN_X_SUSPENDED
	Canal %s esta suspenso e nao pode ser utilizado ou identificado.
CHAN_X_SUSPENDED_MEMOS
	Canal %s esta suspenso e nao pode receber memos.
CHAN_IDENTIFY_REQUIRED
	Autenticacao de senha eh necessaria para este comando.
	Tente novamente apos digitar /msg %s IDENTIFY %s senha.

SERV_X_NOT_FOUND
	Servidor %s nao encontrado.

EXPIRES_NONE
	nao expira
EXPIRES_SOON
	expira na proxima atualizacao do banco de dados
EXPIRES_M
	expira em %d minutos
EXPIRES_1M
	expira em %d minuto
EXPIRES_HM
	expira em %d horas, %d minutos
EXPIRES_H1M
	expira em %d horas, %d minuto
EXPIRES_1HM
	expira em %d hora, %d minutos
EXPIRES_1H1M
	expira em %d hora, %d minuto
EXPIRES_D
	expira em %d dias
EXPIRES_1D
	expira in %d dia

###########################################################################
#
# Mensagens do DogTag
#
###########################################################################

# Automatic messages
NICK_IS_REGISTERED
	Este nick pertence a outra pessoa.  Por favor escolha outro.
	(Se o nick pertence a voce, /msg %s IDENTIFY senha.)
NICK_IS_SECURE
	Este nick esta registrado e protegido.  Se o nick pertence
	a voce, digite /msg %s IDENTIFY senha. Caso contrario,
	escolha um nick diferente.
NICK_MAY_NOT_BE_USED
	Este nick nao pode ser utilizado.  Por favor escolha outro.
DISCONNECT_IN_1_MINUTE
	Se voce nao troca-lo em 1 minuto, sera desconectado.
DISCONNECT_IN_20_SECONDS
	Se voce nao troca-lo em 20 segundos, sera desconectado.
DISCONNECT_NOW
	Este nick esta registrado; voce nao pode usa-lo.  Por favor
	escolha um outro nick antes de reconectar.
FORCENICKCHANGE_IN_1_MINUTE
	Se voce nao troca-lo em 1 minuto, seu nick sera automaticamente trocado.
FORCENICKCHANGE_IN_20_SECONDS
	Se voce nao troca-lo em 20 segundos, seu nick sera automaticamente trocado.
FORCENICKCHANGE_NOW
	Este nick jah esta registrado; voce nao pode usa-lo.
	Seu nick foi mudado para %s.

# REGISTER responses
NICK_REGISTER_SYNTAX
	REGISTER senha [email]
NICK_REGISTER_REQ_EMAIL_SYNTAX
	REGISTER senha email
NICK_REGISTRATION_DISABLED
	Desculpe, registro de nicks esta temporariamente desativado.
NICK_REGISTRATION_FAILED
	Desculpe, falha na hora de registrar.
NICK_REG_PLEASE_WAIT
	Aguarde %d segundos antes de usar o comando REGISTER novamente.
NICK_CANNOT_BE_REGISTERED
	Nick %s nao pode ser registrado.
NICK_ALREADY_REGISTERED
	Nick %s ja esta registrado!
NICK_REGISTERED
	Nick %s registrado a partir de sua conta: %s
NICK_PASSWORD_IS
	Sua senha eh %s - lembre-se dela para uso posterior.

# IDENTIFY responses
NICK_IDENTIFY_SYNTAX
	IDENTIFY senha
NICK_IDENTIFY_FAILED
	Desculpe, identificacao sem sucesso.
NICK_IDENTIFY_SUCCEEDED
	Senha aceita - voce esta reconhecido.

# DROP responses
NICK_DROP_SYNTAX
	DROP
NICK_DROP_DISABLED
	Desculpe, cancelamento do registro de nicks esta temporariamente desativado.
NICK_DROPPED
	Seu nick teve o registro cancelado.
NICK_X_DROPPED
	Nick %s teve o registro cancelado.

# SET responses
NICK_SET_SYNTAX
	SET opcao parametros
NICK_SET_SERVADMIN_SYNTAX
	SET [nick] opcao parametros
NICK_SET_DISABLED
	Desculpe, configuracao de opcoes do nick esta temporariamente desativada.
NICK_SET_UNKNOWN_OPTION
	Opcao SET %s desconhecida.
NICK_SET_UNKNOWN_OPTION_OR_BAD_NICK
	Opcao SET %s desconhecida, ou nick nao registrado.

# SET PASSWORD responses
NICK_SET_PASSWORD_FAILED
	Desculpe, impossivel trocar senha.
NICK_SET_PASSWORD_CHANGED
	Senha alterada.
NICK_SET_PASSWORD_CHANGED_TO
	Senha alterada para %s.

# SET LANGUAGE responses
NICK_SET_LANGUAGE_SYNTAX
	SET LANGUAGE numero
NICK_SET_LANGUAGE_UNKNOWN
	Numero de linguagem %d desconhecido.  Digite /msg %s HELP SET LANGUAGE para uma lista de linguagens.
NICK_SET_LANGUAGE_CHANGED
	Linguagem modificada para Portugues.

# SET URL responses
NICK_SET_URL_CHANGED
	URL de %s trocada para %s.

# SET EMAIL responses
NICK_SET_EMAIL_CHANGED
	E-mail de %s trocado para %s.

# SET KILL responses
NICK_SET_KILL_SYNTAX
	SET KILL {ON | QUICK | OFF}
NICK_SET_KILL_IMMED_SYNTAX
	SET KILL {ON | QUICK | IMMED | OFF}
NICK_SET_KILL_ON
	Protecao de KILL ativada.
NICK_SET_KILL_QUICK
	Protecao de KILL ativada, com uma espera reduzida.
NICK_SET_KILL_IMMED
	Protecao de KILL ativada, sem espera.
NICK_SET_KILL_IMMED_DISABLED
	A opcao IMMED nao esta disponivel nesta rede.
NICK_SET_KILL_OFF
	Protecao de KILL desativada.

# SET SECURE responses
NICK_SET_SECURE_SYNTAX
	SET SECURE {ON | OFF}
NICK_SET_SECURE_ON
	Opcao SECURE ativada.
NICK_SET_SECURE_OFF
	Opcao SECURE desativada.

# SET PRIVATE responses
NICK_SET_PRIVATE_SYNTAX
	SET PRIVATE {ON | OFF}
NICK_SET_PRIVATE_ON
	Opcao PRIVATE ativada.
NICK_SET_PRIVATE_OFF
	Opcao PRIVATE desativada.

# SET HIDE responses
NICK_SET_HIDE_SYNTAX
	SET HIDE {EMAIL | USERMASK | QUIT} {ON | OFF}
NICK_SET_HIDE_EMAIL_ON
	Seu endereco de e-mail esta agora oculto na exibicao no %s INFO.
NICK_SET_HIDE_EMAIL_OFF
	Seu endereco de e-mail esta agora visivel para exibicao no %s INFO.
NICK_SET_HIDE_MASK_ON
	Sua ultima mascara ident@host esta agora oculta para exibicao no %s INFO.
NICK_SET_HIDE_MASK_OFF
	Sua ultima mascara ident@host esta visivel para exibicao no %s INFO.
NICK_SET_HIDE_QUIT_ON
	Sua ultima mensagem de quit esta agora oculta para exibicao no %s INFO.
NICK_SET_HIDE_QUIT_OFF
	Sua ultima mensagem de quit esta agora visivel para exibicao no %s INFO.

# SET NOEXPIRE responses
NICK_SET_NOEXPIRE_SYNTAX
	SET [nick] NOEXPIRE {ON | OFF}
NICK_SET_NOEXPIRE_ON
	Nick %s nao ira expirar.
NICK_SET_NOEXPIRE_OFF
	Nick %s ira expirar.

# UNSET responses
NICK_UNSET_SYNTAX
	UNSET {URL | EMAIL}
NICK_UNSET_SYNTAX_REQ_EMAIL
	UNSET URL
NICK_UNSET_URL
	URL de %s apagada.
NICK_UNSET_EMAIL
	E-mail de %s apagado.
NICK_UNSET_EMAIL_BAD
	Voce nao pode apagar seu E-mail.
NICK_UNSET_EMAIL_OTHER_BAD
	E-mail do nick nao pode ser apagado.

# ACCESS responses
NICK_ACCESS_SYNTAX
	ACCESS {ADD | DEL | LIST} [mascara]
NICK_ACCESS_ALREADY_PRESENT
	Mascara %s ja existe na sua lista de acesso.
NICK_ACCESS_REACHED_LIMIT
	Desculpe, voce soh pode ter %d entradas de acesso para um nick.
NICK_ACCESS_ADDED
	%s adicionado na sua lista de acesso.
NICK_ACCESS_NOT_FOUND
	%s nao encontrado na sua lista de acesso.
NICK_ACCESS_DELETED
	%s excluido da sua lista de acesso.
NICK_ACCESS_LIST
	Lista de acesso:
NICK_ACCESS_LIST_X
	Lista de acesso para %s:

# LINK responses
NICK_LINK_SYNTAX
	LINK nick senha
NICK_LINK_DISABLED
	O comando LINK nao esta disponivel.
NICK_LINK_FAILED
	Desculpe, ligacao falhou.
NICK_NO_LINK_SAME
	Voce nao pode fazer uma uma ligacao para o seu nick atual!
NICK_LINK_CIRCULAR
	Impossivel ligar o nick %s: ligacao circular detectada.
NICK_LINK_TOO_DEEP
	Voce nao pode criar um link com mais de %d niveis de profundidade.
NICK_LINK_TOO_MANY_CHANNELS
	Impossivel linkar ao nick %s: muitos canais registrados (combinacao maxima: %d).
NICK_LINKED
	Seu nick foi ligado ao nick %s.

# UNLINK responses
NICK_UNLINK_SYNTAX
	UNLINK [nick senha]
NICK_UNLINK_FAILED
	Desculpe, desligamento de nicks falhou.
NICK_NOT_LINKED
	Seu nick nao esta ligado.
NICK_UNLINKED
	Seu nick foi desligado do nick %s.
NICK_X_NOT_LINKED
	Nick %s nao esta ligado.
NICK_X_UNLINKED
	Nick %s foi desligado do nick %s.

# LISTLINKS responses
NICK_LISTLINKS_SYNTAX
	LISTLINKS nick [ALL]
NICK_LISTLINKS_HEADER
	Lista de nicks ligados ao nick %s:
NICK_LISTLINKS_FOOTER
	%d nicks ligados.
NICK_X_IS_LINKED
	    %s
NICK_X_IS_LINKED_VIA_X
	    %-20s (via %s)

# INFO responses
NICK_INFO_SYNTAX
	INFO nick [ALL]
NICK_INFO_REALNAME
	%s eh %s
NICK_INFO_ADDRESS
	         Ultimo endereco: %s
NICK_INFO_ADDRESS_ONLINE
	 Esta online no endereco: %s
NICK_INFO_ADDRESS_ONLINE_NOHOST
	%s esta online.
NICK_INFO_TIME_REGGED
	     Horario do registro: %s
NICK_INFO_LAST_SEEN
	    Ultimo horario visto: %s
NICK_INFO_LAST_QUIT
	Ultima mensagem de saida: %s
NICK_INFO_URL
	                     URL: %s
NICK_INFO_EMAIL
	                  E-mail: %s
NICK_INFO_OPTIONS
	                  Opcoes: %s
NICK_INFO_LINKED_TO
	               Linkado a: %s
# These strings MUST NOT be empty
NICK_INFO_OPT_KILL
	Protecao de Kill
NICK_INFO_OPT_SECURE
	Seguranca
NICK_INFO_OPT_PRIVATE
	Privado
NICK_INFO_OPT_NONE
	Nenhuma
NICK_INFO_NO_EXPIRE
	O registro deste nick nao ira expirar.
NICK_INFO_SUSPEND_DETAILS
	Suspenso por %s em %s (%s).
NICK_INFO_SUSPEND_REASON
	Razao: %s
NICK_INFO_SHOW_ALL
	Para maiores informacoes, digite: /msg %s INFO %s ALL

# LISTCHANS responses
NICK_LISTCHANS_SYNTAX
	LISTCHANS
NICK_LISTCHANS_SERVADMIN_SYNTAX
	LISTCHANS [nickname]
NICK_LISTCHANS_NONE
	%s não tem nenhum canal registrado.
NICK_LISTCHANS_HEADER
	Canais registrados por %s:
NICK_LISTCHANS_ENTRY
	    %s
NICK_LISTCHANS_END
	Fim da lista (%d canais registrados).

# LIST responses
NICK_LIST_SYNTAX
	LIST padrao
NICK_LIST_SERVADMIN_SYNTAX
	LIST padrao [FORBIDDEN] [NOEXPIRE] [SUSPENDED]
NICK_LIST_HEADER
	Lista das entradas que satisfazem %s:
NICK_LIST_RESULTS
	Fim da listagem - %d/%d entradas mostradas.

# RECOVER responses
NICK_RECOVER_SYNTAX
	RECOVER nick [senha]
NICK_NO_RECOVER_SELF
	Voce nao pode recuperar o seu proprio nick!
NICK_RECOVERED
	Usuario que voce reinvidicou o nick foi derrubado.
	Digite /msg %s RELEASE %s para pegar o nick antes da espera de 1 minuto.

# RELEASE responses
NICK_RELEASE_SYNTAX
	RELEASE nick [senha]
NICK_RELEASE_NOT_HELD
	Nick %s nao esta sendo protegido neste momento.
NICK_RELEASED
	A protecao dos K9 Services no seu nick foi desfeita.

# GHOST responses
NICK_GHOST_SYNTAX
	GHOST nick [senha]
NICK_NO_GHOST_SELF
	Voce nao pode aplicar um ghost em voce mesmo!
NICK_GHOST_KILLED
	Nick onde o ghost foi aplicado esta derrubado.

# GETPASS responses
NICK_GETPASS_SYNTAX
	GETPASS nick
NICK_GETPASS_UNAVAILABLE
	Comando invalido porque encriptacao esta em uso.
NICK_GETPASS_PASSWORD_IS
	Senha para %s eh %s.

# FORBID responses
NICK_FORBID_SYNTAX
	FORBID nick
NICK_FORBID_SUCCEEDED
	Nick %s esta proibido de ser usado.
NICK_FORBID_FAILED
	Nao se pode bloquear o uso do nick %s!

# SUSPEND responses
NICK_SUSPEND_SYNTAX
	SUSPEND [+expiracao] nickname razao
NICK_SUSPEND_SUCCEEDED
	Nick %s, e todos os nicks do mesmo dono, foram suspensos.
NICK_SUSPEND_ALREADY_SUSPENDED
	Nick %s jah esta suspenso.

# UNSUSPEND responses
NICK_UNSUSPEND_SYNTAX
	UNSUSPEND nickname
NICK_UNSUSPEND_SUCCEEDED
	Nick %s foi reestabelecido.
NICK_SUSPEND_NOT_SUSPENDED
	Nick %s nao esta suspenso.

###########################################################################
#
# Mensagens do ChanServ
#
###########################################################################

# Access level descriptions
CHAN_LEVEL_AUTOOP
	Status de operador de canal automatico
CHAN_LEVEL_AUTOVOICE
	Modo +v automatico
CHAN_LEVEL_AUTODEOP
	Nao pode ser operador de canal
CHAN_LEVEL_AUTODEOP_HALFOP
	Status de operator/halfop de canal desabilitado
CHAN_LEVEL_NOJOIN
	Nao pode entrar no canal se este estiver restrito (opcao RESTRICTED)
CHAN_LEVEL_INVITE
	Liberado a usar o comando INVITE
CHAN_LEVEL_AKICK
	Liberado a usar o comando AKICK
CHAN_LEVEL_SET
	Liberado a usar o comando SET (nao sendo FUNDADOR)
CHAN_LEVEL_CLEAR
	Liberado a usar o comando CLEAR
CHAN_LEVEL_UNBAN
	Liberado a usar o comando UNBAN
CHAN_LEVEL_OPDEOP
	Liberado a usar os comandos OP/DEOP
CHAN_LEVEL_ACCESS_LIST
	Liberado a ver a lista de acesso
CHAN_LEVEL_ACCESS_CHANGE
	Liberado a modificar a lista de acesso
CHAN_LEVEL_MEMO
	Liberado a listar/ler as mensagens do canal
CHAN_LEVEL_VOICE
	Permitido usar comandos VOICE/DEVOICE
CHAN_LEVEL_AUTOHALFOP
	Status halfop (+h) automatico
CHAN_LEVEL_HALFOP
	Permitido usar comandos HALFOP/DEHALFOP
CHAN_LEVEL_AUTOPROTECT
	Status de protecao de canal (+a) automatico
CHAN_LEVEL_PROTECT
	Permitido usar os comandos PROTECT/DEPROTECT

# Automatic responses
CHAN_IS_REGISTERED
	Este canal esta registrado com %s.
CHAN_NOT_ALLOWED_OP
	Voce nao esta com permissao de ser operador do canal %s.
CHAN_MAY_NOT_BE_USED
	Este canal nao pode ser usado.
CHAN_NOT_ALLOWED_TO_JOIN
	Voce nao esta com permissao para permanecer neste canal.

# Multi-purpose responses
CHAN_BOUNCY_MODES
	Desculpe, o comando %s temporariamente indisponivel.

# REGISTER responses
CHAN_REGISTER_SYNTAX
	REGISTER canal senha descricao
CHAN_REGISTER_DISABLED
	Desculpe, registro de canal esta temporariamente desativado.
CHAN_REGISTER_NOT_LOCAL
	Canais locais nao podem ser registrados.
CHAN_MUST_REGISTER_NICK
	Voce deve primeiro registrar seu nick.  Digite /msg %s HELP para obter informacao sobre o registro de nicks.
CHAN_MUST_IDENTIFY_NICK
	Por favor, identique-se com %s primeiro usando o comando:
	/msg %s IDENTIFY senha
CHAN_MAY_NOT_BE_REGISTERED
	Canal %s nao pode ser registrado.
CHAN_ALREADY_REGISTERED
	Canal %s ja esta registrado!
CHAN_MUST_BE_CHANOP
	Voce deve ser operador de canal para registrar o canal.
CHAN_REACHED_CHANNEL_LIMIT
	Desculpe, voce ja alcancou seu limite de %d canais.
CHAN_EXCEEDED_CHANNEL_LIMIT
	Desculpe, voce ja ultrapassou seu limite de %d canais.
CHAN_REGISTRATION_FAILED
	Desculpe, registro falhou.
CHAN_REGISTERED
	Canal %s registrado com o seu nick: %s
CHAN_PASSWORD_IS
	A senha do seu canal eh %s - lembre-se dela para uso posterior.

# IDENTIFY responses
CHAN_AUTH_SYNTAX
	AUTH <canal> <senha>
CHAN_SETPASS_SYNTAX
	SETPASS <canal> <new senha>
CHAN_IDENTIFY_FAILED
	Desculpe, identificacao falhou.
CHAN_IDENTIFY_SUCCEEDED
	Senha aceita - voce agora esta reconhecido como fundador do %s.

# DROP responses
CHAN_DROP_SYNTAX
	DROP canal
CHAN_DROP_DISABLED
	Desculpe, cancelamento do registro de canal esta temporariamente desabilitado.
CHAN_DROPPED
	Canal %s teve seu registro desfeito.

# SET responses
CHAN_SET_SYNTAX
	SET canal opcao parametros
CHAN_SET_DISABLED
	Desculpe, opcao de ajuste das opcoes do canal esta temporariamente desativada.
CHAN_SET_UNKNOWN_OPTION
	Opcao SET %s desconhecida.

# SET FOUNDER responses
CHAN_SET_FOUNDER_TOO_MANY_CHANS
	%s tem canais registrados em excesso.
CHAN_FOUNDER_CHANGED
	Fundador do canal %s alterado para %s.

# SET SUCCESSOR responses
CHAN_SUCCESSOR_CHANGED
	Sucessor de %s mudado para %s.
CHAN_SUCCESSOR_IS_FOUNDER
	Voce nao pode fazer o fundador do canal ser tambem o sucessor.

# SET PASSWORD responses
CHAN_SET_PASSWORD_FAILED
	Desculpe, nao foi possivel alterar a senha.
CHAN_PASSWORD_CHANGED
	%s senha trocada.
CHAN_PASSWORD_CHANGED_TO
	Senha do canal %s mudada para %s.

# SET DESC responses
CHAN_DESC_CHANGED
	Descricao do canal %s alterada para %s.

# SET URL responses
CHAN_URL_CHANGED
	URL do canal %s alterada para %s.

# SET EMAIL responses
CHAN_EMAIL_CHANGED
	Endereco do e-mail d do canal %s mudado para %s.

# SET ENTRYMSG responses
CHAN_ENTRY_MSG_CHANGED
	Mensagem de entrada do canal %s alterada.

# SET TOPIC responses
CHAN_SET_TOPIC_FAILED
	Desculpe, nao foi possivel por o topico.

# SET MLOCK responses
CHAN_SET_MLOCK_KEY_REQUIRED
	Parametro requerido para MLOCK +k.
CHAN_SET_MLOCK_LIMIT_REQUIRED
	Parametro requerido para MLOCK +l.
CHAN_SET_MLOCK_LIMIT_POSITIVE
	Parametro para MLOCK +l deve ser um numero positivo.
CHAN_SET_MLOCK_MODE_REG_BAD
	Modo +%c sempre eh colocado em canais registrados, e nao pode ser usado com MLOCK.
CHAN_SET_MLOCK_MODE_F_BAD
	Modo +f nao pode ser travado.
CHAN_SET_MLOCK_UNKNOWN_CHAR
	Modo %c eh desconhecido e foi ignorado.
CHAN_MLOCK_CHANGED
	Trava dos modos do canal %s alterada para %s.
CHAN_MLOCK_REMOVED
	Trava dos modos do canal %s removida.

# SET KEEPTOPIC responses
CHAN_SET_KEEPTOPIC_SYNTAX
	SET canal KEEPTOPIC {ON | OFF}
CHAN_SET_KEEPTOPIC_ON
	Opcao de retencao de topico esta ativada.
CHAN_SET_KEEPTOPIC_OFF
	Opcao de retencao de topico esta desativada.

# SET TOPICLOCK responses
CHAN_SET_TOPICLOCK_SYNTAX
	SET canal TOPICLOCK {ON | OFF}
CHAN_SET_TOPICLOCK_ON
	Opcao de trava do topico esta ativada.
CHAN_SET_TOPICLOCK_OFF
	Opcao de trava do topico esta desativada.

# SET PRIVATE responses
CHAN_SET_PRIVATE_SYNTAX
	SET canal PRIVATE {ON | OFF}
CHAN_SET_PRIVATE_ON
	Opcao private esta ativada.
CHAN_SET_PRIVATE_OFF
	opcao private esta desativada.

# SET SECUREOPS responses
CHAN_SET_SECUREOPS_SYNTAX
	SET canal SECUREOPS {ON | OFF}
CHAN_SET_SECUREOPS_ON
	Opcao Secure ops esta ativada.
CHAN_SET_SECUREOPS_OFF
	Opcao Secure ops esta desativada.

# SET LEAVEOPS responses
CHAN_SET_LEAVEOPS_SYNTAX
	SET canal LEAVEOPS {ON | OFF}
CHAN_SET_LEAVEOPS_ON
	Opcao LEAVE OPS esta ativada.
CHAN_SET_LEAVEOPS_OFF
	Opcao LEAVE OPS esta desativada.

# SET RESTRICTED responses
CHAN_SET_RESTRICTED_SYNTAX
	SET canal RESTRICTED {ON | OFF}
CHAN_SET_RESTRICTED_ON
	Opcao de acesso restrito esta ativada.
CHAN_SET_RESTRICTED_OFF
	Opcao de acesso restrito esta desativada.

# SET SECURE responses
CHAN_SET_SECURE_SYNTAX
	SET canal SECURE {ON | OFF}
CHAN_SET_SECURE_ON
	Opcao secure esta ativada.
CHAN_SET_SECURE_OFF
	Opcao secure esta desativada.

# SET OPNOTICE responses
CHAN_SET_OPNOTICE_SYNTAX
	SET canal OPNOTICE {ON | OFF}
CHAN_SET_OPNOTICE_ON
	Opcao Op-Notice esta ativada.
CHAN_SET_OPNOTICE_OFF
	Opcao Op-Notice esta desativada.

# SET ENFORCE responses
CHAN_SET_ENFORCE_SYNTAX
	SET canal ENFORCE {ON | OFF}
CHAN_SET_ENFORCE_ON
	Op$Bgc(Bo Enforce esta agora LIGADA.
CHAN_SET_ENFORCE_OFF
	Op$Bgc(Bo Enforce esta agora DESLIGADA.

# SET NOEXPIRE responses
CHAN_SET_NOEXPIRE_SYNTAX
	SET canal NOEXPIRE {ON | OFF}
CHAN_SET_NOEXPIRE_ON
	Canal %s nao ira expirar.
CHAN_SET_NOEXPIRE_OFF
	Canal %s ira expirar.

# UNSET responses
CHAN_UNSET_SYNTAX
	UNSET canal {SUCCESSOR | URL | EMAIL | ENTRYMSG}
CHAN_SUCCESSOR_UNSET
	Sucessor para %s retirado.
CHAN_URL_UNSET
	Associacao a URL para o canal %s foi desfeita.
CHAN_EMAIL_UNSET
	Associacao ao e-mail do canal %s foi desfeita.
CHAN_ENTRY_MSG_UNSET
	A designacao atual da mensagem de entrada do canal %s foi desfeita.

# ACCESS messages
CHAN_ACCESS_SYNTAX
	ACCESS canal {ADD | DEL | LIST | COUNT} [nick [nivel] | entry-list]
CHAN_ACCESS_DISABLED
	Desculpe, modificacao da lista de acesso do canal esta temporariamente desativada.
CHAN_ACCESS_LEVEL_NONZERO
	Nivel de acesso deve ser diferente de zero.
CHAN_ACCESS_LEVEL_RANGE
	Nivel de acesso deve estar entre %d e %d .
CHAN_ACCESS_NICKS_ONLY
	Listas de acesso de canais devem conter apenas nicks registrados.
CHAN_ACCESS_REACHED_LIMIT
	Desculpe, voce soh pode ter %d entradas de acesso en um canal.
CHAN_ACCESS_LEVEL_UNCHANGED
	Nivel de acesso de %s no canal %s nao foi mudado de %d.
CHAN_ACCESS_LEVEL_CHANGED
	Nivel de acesso para %s no canal %s mudado para %d.
CHAN_ACCESS_ADDED
	%s adicionado na lista de acesso do canal %s no nivel %d.
CHAN_ACCESS_NO_SUCH_ENTRY
	Entrada desconhecida (#%d) na lista de acesso do canal %s.
CHAN_ACCESS_NOT_FOUND
	%s nao foi encontrado na lista de acesso do canal %s.
CHAN_ACCESS_NO_MATCH
	Nenhuma entrada encontrada na lista de acesso do %s.
CHAN_ACCESS_DELETED
	%s apagado da lista de acesso do canal %s.
CHAN_ACCESS_DELETED_ONE
	Apagada uma entrada da lista de acesso do %s.
CHAN_ACCESS_DELETED_SEVERAL
	Apagada %d entradas da lista de acesso do %s.
CHAN_ACCESS_LIST_EMPTY
	Lista de acesso do %s esta vazia.
CHAN_ACCESS_LIST_HEADER
	Lista de acesso do canal %s:
CHAN_ACCESS_COUNT
	%s tem %d entradas na lista de acesso.

# XOP (AOP/SOP/VOP) responses
CHAN_SOP_SYNTAX
	SOP canal {ADD | DEL | LIST | COUNT} [nick | entry-list]
CHAN_AOP_SYNTAX
	AOP canal {ADD | DEL | LIST | COUNT} [nick | entry-list]
CHAN_HOP_SYNTAX
	HOP canal {ADD | DEL | LIST | COUNT} [nick | entry-list]
CHAN_VOP_SYNTAX
	VOP canal {ADD | DEL | LIST | COUNT} [nick | entry-list]
CHAN_XOP_ADDED
	%s adicionado ao %s na lista de %s
CHAN_XOP_LEVEL_CHANGED
	%s movido no %s para a lista de %s
CHAN_XOP_LEVEL_UNCHANGED
	%s jah esta no %s na lista de %s
CHAN_XOP_NICKS_ONLY
	As lista de SOP, AOP e VOP soh podem conter nicknames registrados.
CHAN_XOP_NICKS_ONLY_HOP
	As lista de SOP, AOP, HOP e VOP soh podem conter nicknames registrados.
CHAN_XOP_REACHED_LIMIT
	Desculpe, o numero de entradas na suas listas de SOP, AOP e VOP
	nao podem ter um total de mais de %d entradas. Limete excedido.
CHAN_XOP_REACHED_LIMIT_HOP
	Desculpe, o numero de entradas na suas listas de SOP, AOP, HOP e VOP
	nao podem ter um total de mais de %d entradas. Limete excedido.
CHAN_XOP_NOT_FOUND
	%s nao encontrado no %s na lista de %s.
CHAN_XOP_NO_SUCH_ENTRY
	Nenhuma entrada (#%d) no %s na lista de %s.
CHAN_XOP_NO_MATCH
	Nenhuma entrada similar no %s na lista de %s.
CHAN_XOP_DELETED
	%s apagado do %s da lista de %s.
CHAN_XOP_DELETED_ONE
	Apagada 1 entrada do %s da lista de %s.
CHAN_XOP_DELETED_SEVERAL
	Apagadas %d entradas do %s da lista de %s.
CHAN_XOP_LIST_EMPTY
	%s %s list is empty.
CHAN_XOP_LIST_HEADER
	%s list for %s:
	  Num   Nick
CHAN_XOP_LIST_FORMAT
	  %3d   %s%s%s%s
CHAN_XOP_COUNT
	O %s na lista de %s tem %d entradas.

# AKICK responses
CHAN_AKICK_SYNTAX
	AKICK canal {ADD | DEL | LIST | VIEW | ENFORCE | COUNT} [nick | mascara]
CHAN_AKICK_DISABLED
	Desculpe, modificacao da lista de autokicks do canal esta temporariamente desativado.
CHAN_AKICK_ALREADY_EXISTS
	%s ja existe na lista de autokicks do canal %s.
CHAN_AKICK_REACHED_LIMIT
	Desculpe, voce so deve ter %d mascaras na lista de autokicks do canal.
CHAN_AKICK_ADDED
	%s adicionado na lista de autokicks do canal  %s.
CHAN_AKICK_NO_SUCH_ENTRY
	Entrada desconhecida (#%d) na lista de autokicks do canal %s.
CHAN_AKICK_NOT_FOUND
	%s nao encontrado na lista de autokicks do canal %s.
CHAN_AKICK_NO_MATCH
	Nenhuma entrada encontrada na lista de autokick do %s.
CHAN_AKICK_DELETED
	%s retirado da lista de autokicks do canal %s.
CHAN_AKICK_DELETED_ONE
	Apagada uma entrada da lista de autokick do %s.
CHAN_AKICK_DELETED_SEVERAL
	Apagada %d entradas da lista de autokick do %s.
CHAN_AKICK_LIST_EMPTY
	Lista de autokick do %s esta vazia.
CHAN_AKICK_LIST_HEADER
	Lista de Autokicks do canal %s:
CHAN_AKICK_LIST_FORMAT
	  %3d %s%s
CHAN_AKICK_VIEW_FORMAT
	  %3d %s (por %s)
	    %s
CHAN_AKICK_ENFORCE_DONE
	AKICK ENFORCE para %s feito; %d usuarios foram afetados.
CHAN_AKICK_COUNT
	%s tem %d entradas na lista de AKICK.

# LEVELS responses
CHAN_LEVELS_SYNTAX
	LEVELS canal {SET | DIS[ABLE] | LIST | RESET} [item [nivel]]
CHAN_LEVELS_RANGE
	Nivel deve estar entre %d e %d.
CHAN_LEVELS_CHANGED
	Nivel de %s no canal %s alterado para %d.
CHAN_LEVELS_UNKNOWN
	Opcao %s desconhecida. Digite /msg %s HELP LEVELS DESC para uma lista valida de opcoes.
CHAN_LEVELS_DISABLED
	%s desabilitado no canal %s.
CHAN_LEVELS_LIST_HEADER
	Configuracao dos niveis de acesso do canal %s:
CHAN_LEVELS_LIST_DISABLED
	    %-*s  (desabilitado)
CHAN_LEVELS_LIST_FOUNDER
	    %-*s  (somente fundador)
CHAN_LEVELS_LIST_NORMAL
	    %-*s  %d
CHAN_LEVELS_RESET
	Niveis de acesso do canal %s foi refeita usando os padroes.

# INFO responses
CHAN_INFO_SYNTAX
	INFO canal [ALL]
CHAN_INFO_HEADER
	Informacao sobre o canal %s:
CHAN_INFO_FOUNDER
	           Fundador: %s (%s)
CHAN_INFO_NO_FOUNDER
	           Fundador: %s
CHAN_INFO_SUCCESSOR
	           Sucessor: %s (%s)
CHAN_INFO_NO_SUCCESSOR
	           Sucessor: %s
CHAN_INFO_DESCRIPTION
	          Descricao: %s
CHAN_INFO_ENTRYMSG
	Mensagem de entrada: %s
CHAN_INFO_TIME_REGGED
	         Registrado: %s
CHAN_INFO_LAST_USED
	         Ultimo uso: %s
CHAN_INFO_LAST_TOPIC
	      Ultimo topico: %s
CHAN_INFO_TOPIC_SET_BY
	Topico ajustado por: %s
CHAN_INFO_URL
	                URL: %s
CHAN_INFO_EMAIL
	             E-mail: %s
CHAN_INFO_OPTIONS
	             Opcoes: %s
CHAN_INFO_OPT_PRIVATE
	Privado
CHAN_INFO_OPT_KEEPTOPIC
	Retencao de topico
CHAN_INFO_OPT_TOPICLOCK
	Trava do topico
CHAN_INFO_OPT_SECUREOPS
	Protecao de ops
CHAN_INFO_OPT_LEAVEOPS
	LEAVE OPS
CHAN_INFO_OPT_RESTRICTED
	Acesso restrito
CHAN_INFO_OPT_SECURE
	Seguranca
CHAN_INFO_OPT_OPNOTICE
	Op-Notice
CHAN_INFO_OPT_ENFORCE
	Enforce
CHAN_INFO_OPT_NONE
	Nenhuma
CHAN_INFO_MODE_LOCK
	The current mode guards are [%s]
CHAN_INFO_NO_EXPIRE
	Este canal nao vai expirar.
CHAN_INFO_SUSPEND_DETAILS
	Suspenso por %s em %s (%s).
CHAN_INFO_SUSPEND_REASON
	Razao: %s
CHAN_INFO_SHOW_ALL
	Para maiores informacoes, digite: /msg %s INFO %s ALL

# LIST responses
CHAN_LIST_SYNTAX
	LIST padrao
CHAN_LIST_SERVADMIN_SYNTAX
	LIST modelo [FORBIDDEN] [NOEXPIRE]
CHAN_LIST_HEADER
	Listas das entradas que satisfazem %s:
CHAN_LIST_FORMAT
	    %-20s  %s
CHAN_LIST_END
	Fim da listagem - %d/%d entradas mostradas.

# INVITE responses
CHAN_INVITE_SYNTAX
	INVITE canal <nick>
CHAN_INVITE_OK
	Convidando %s  para o canal %s.

# OP/DEOP/VOICE/DEVOICE responses
CHAN_OPVOICE_SYNTAX
	%s canal nick
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
	UNBAN canal
CHAN_UNBANNED
	Voce foi desbanido do %s.

# CLEAR responses
CHAN_CLEAR_SYNTAX
	CLEAR canal tipo
CHAN_CLEARED_BANS
	Todos os bans do canal %s foram removidos.
CHAN_CLEARED_EXCEPTIONS
	Todas as excecoes do canal %s foram removidas.
CHAN_CLEARED_MODES
	Todos os modos do canal %s foram removidos.
CHAN_CLEARED_OPS
	Modo +o dos Operadores do canal %s foi retirado.
CHAN_CLEARED_HALFOPS
	Modo +h foi removido do canal %s.
CHAN_CLEARED_VOICES
	Modo +v de alguns usuarios do canal %s foi retirado.
CHAN_CLEARED_USERS
	Todos os usuarios foram kickados do canal %s.

# GETPASS responses
CHAN_GETPASS_SYNTAX
	GETPASS canal
CHAN_GETPASS_UNAVAILABLE
	Comando GETPASS nao esta disponivel porque a encriptacao esta em uso.
CHAN_GETPASS_PASSWORD_IS
	Senha do canal %s eh %s.

# FORBID responses
CHAN_FORBID_SYNTAX
	FORBID canal
CHAN_FORBID_SUCCEEDED
	Canal %s esta agora proibido de ser utilizado.
CHAN_FORBID_FAILED
	Nao foi possivel bloquear o uso do canal %s!

# SUSPEND responses
CHAN_SUSPEND_SYNTAX
	SUSPEND [+expiracao] canal razao
CHAN_SUSPEND_SUCCEEDED
	Canal %s foi suspenso.
CHAN_SUSPEND_ALREADY_SUSPENDED
	Canal %s jah esta suspenso.

# UNSUSPEND responses
CHAN_UNSUSPEND_SYNTAX
	UNSUSPEND channel
CHAN_UNSUSPEND_SUCCEEDED
	Canal %s foi reativado.
CHAN_SUSPEND_NOT_SUSPENDED
	Canal %s nao esta suspenso.

# MODE responses
OPER_MODE_SYNTAX
	MODE canal modos

###########################################################################
#
# Mensagens de help do DogTag
#
###########################################################################

NICK_HELP
	%S permite que voce "registre" um nick e evita que
	outras pessoas o utilizem.  Se o nick nao for usado por %d
	dias, o registro sera cancelado.  Os seguintes comandos
	permitem o registro e a manutencao dos nicks; para
	utiliza-los, digite /msg %S comando.  Para maiores
	informacoes sobre um comando, digite /msg %S HELP comando.
	
	    REGISTER   Registra um nick
	    IDENTIFY   Identifica seu nick com sua senha
	    ACCESS     Modifica a lista de enderecos autorizados
	    LINK       Faz uma ligacao de seu nick com outro
	    SET        Ajusta opcoes, incluindo protecao de kill
	    DROP       Cancela o registro de um nick
	    RECOVER    Derruba outro usuario que esteja usando seu nick
	    RELEASE    Retoma a custodia do seu nick apos um RECOVER
	
	Outros comandos: UNLINK, UNSET, GHOST, INFO, LIST, LISTCHANS,
	                 STATUS
	
	NOTA: Este servico tem a intencao de prover um modo para
	que usuarios do IRC nao tenham sua identidade comprometida.
	Isto NAO eh voltado para facilitar "roubo" dos nicks ou
	outras atitudes ma intencionadas.  O abuso do %S
	resultara em, no minimo, perda do(s) nick(s) abusivo(s).

NICK_HELP_EXPIRE_ZERO
	%S permite voce de "registrar" um nick e impede que
	outros o utilizem. Os comandos seguintes permitem o
	registro e a manutencao dos nicks;  para usa-los, digite
	/msg %S comando. Para mais informacoes sobre um
	comando especifico, digite /msg %S HELP comando.
	
	   REGISTER  Registra um nick
	   IDENTIFY  Identifica seu nick com sua senha
	   ACCESS    Modifica a lista de enderecos autorizados
	   LINK      Faz uma ligacao de seu nick com outro
	   SET       Ajusta opcoes, incluindo protecao de kill
	   DROP      Cancela o registro de um nick
	   RECOVER   Derruba outro usuario que esteja usando seu nick
	   RELEASE   Retoma a custodia do seu nick apos um RECOVER
	
	Outros comandos: UNLINK, UNSET, GHOST, INFO, LIST, LISTCHANS,
	                 STATUS
	
	NOTA: Este servico tem a intencao de prover um modo para que
	usuarios do IRC nao tenham sua identidade comprometida.
	Isto nao eh voltado para facilitar o "roubo" dos nicks ou
	outras atitudes ma intencionadas. O abuso do %S resultara
	em, no minimo, perda do(s) nick(s) abusivos.

NICK_HELP_REGISTER
	Sintaxe: REGISTER senha [email]
	
	Registra seu nick no banco de dados do %S.  Uma vez
	que seu nick esta registrado, voce pode usar os comandos
	SET e ACCESS para configurar as opcoes do seu nick como voce
	preferir depois.  Certifique-se de lembrar sua senha durante
	o registro, voce precisara dela para fazer alteracoes no seu
	nick futuramente.  (Lembre-se que maiusculas diferem: FIDO,
	Fido, e fido sao senhas diferentes!)
	
	Voce pode incluir um endereco de E-mail ao registar seu nickname;
	voce tambem pode colocar um depois usando o comando SET EMAIL.
	
	Sugestoes ao escolher sua senha:
	
	As senhas nao devem ser de facil adivinhacao.  Por exemplo,
	usar seu nome como senha eh uma pessima ideia.  Utilizar seu
	nick como senha eh uma ideia muito pior e, de fato, o %S
	nao permitira isso.  Da mesma maneira, senhas curtas sao
	vulneraveis a testes de erro-e-acerto, entao voce deve
	escolher uma senha com pelo menos 5 caracteres.  Finalmente,
	o caracter "ESPACO" nao pode ser usado em senhas.

NICK_HELP_REGISTER_REQ_EMAIL
	Sintaxe: REGISTER senha email
	 
	Registra seu nick no banco de dados do %S.  Uma vez
	que seu nick esta registrado, voce pode usar os comandos
	SET e ACCESS para configurar as opcoes do seu nick como voce
	preferir depois.  Certifique-se de lembrar sua senha durante
	o registro, voce precisara dela para fazer alteracoes no seu
	nick futuramente.  (Lembre-se que maiusculas diferem: FIDO,
	Fido, e fido sao senhas diferentes!)
	 
	Voce pode incluir um endereco de E-mail ao registar seu nickname;
	voce tambem pode colocar um depois usando o comando SET EMAIL.
	
	Voce deve incluir um endereco de E-mail ao registar seu
	nickname. Voce pode evitar que seu E-mail seja mostrado a outros
	usuarios com o comando SET HIDE (digite /msg %S HELP SET HIDE
	para maiores informacoes).
	
	Sugestoes ao escolher sua senha:
	
	As senhas nao devem ser de facil adivinhacao.  Por exemplo,
	usar seu nome como senha eh uma pessima ideia.  Utilizar seu
	nick como senha eh uma ideia muito pior e, de fato, o %S
	nao permitira isso.  Da mesma maneira, senhas curtas sao
	vulneraveis a testes de erro-e-acerto, entao voce deve
	escolher uma senha com pelo menos 5 caracteres.  Finalmente,
	o caracter "ESPACO" nao pode ser usado em senhas.

NICK_HELP_IDENTIFY
	Sintaxe: IDENTIFY senha
	
	Diz ao %S que voce realmente eh o dono deste nick.
	Muitos comandos exigem que voce se identifique com este
	comando antes de voce usa-los.  A senha deve ser a mesma que
	voce enviou com o comando REGISTER.
	
NICK_HELP_DROP
	Sintaxe: DROP
	
	Retira seu nick do banco de dados do %S.  O nick que
	foi retirado esta livre para qualquer pessoa registrar
	novamente.
	
	Para utilizar este comando, voce primeiro deve se
	identificar com sua senha (/msg %S HELP IDENTIFY para mais
	informacoes).

NICK_HELP_ACCESS
	Sintaxe: ACCESS ADD mascara
	         ACCESS DEL mascara
	         ACCESS LIST
	
	Modifica ou mostra a lista de acesso do seu nick.  Esta eh
	a lista de enderecos a qual sera automaticamente reconhecida
	pelo %S como as permitidas a usarem seu nick.  Se voce quer
	usar um nick de um endereco diferente, voce deve mandar o
	comando IDENTIFY para fazer o %S reconhecer voce.
	
	Exemplos:
	
	    ACCESS ADD mauritz@*.americasnet.com.br
	        Permite o acesso ao usuario mauritz de qualquer
	        maquina do dominio americasnet.com.br.
	
	    ACCESS DEL mauritz@*.americasnet.com.br
	        Desfaz o comando anterior.
	
	    ACCESS LIST
	        Mostra a lista de acesso atual.

NICK_HELP_LINK
	Sintaxe: LINK nick senha
	
	Liga seu nick a outro, efetivamente, fazendo uma ligacao
	do seu nick atual com um outro nick especificado.  Quando
	voce emite este comando, a lista de acesso do seu nick
	atualmente em uso eh apagada e substituida pelo nick que
	voce esta ligando, todos os memos do seu nick atual sao
	adicionados na lista de memos do nick alvo (isso pode
	causar um excesso no limite de memos do nick, em alguns
	casos voce precisa apagar alguns memos antes de poder
	receber mais memos de uma outra pessoa).
	
	Uma vez que a ligacao foi estabilizada, seu nick sera
	transparentemente convertido para o nick alvo em todos
	os lugares nos K9 Services, exceto para os comandos %S
	UNLINK e DROP.
	Por exemplo, voce pode usar um nick ou outro para ler
	o mesmo conjunto de memos (e mensagens enviadas para um nick
	ou outro irao para a mesma lista).  Se voce se identificar
	para um nick, estara automaticamente identificado para o
	outro.  Se um nick ou outro esta na lista de acesso de um
	canal, ambos nicks terao os mesmos privilegios de acesso.
	
	Para usar este comando, voce deve identificar o nick atual
	(usando o comando IDENTIFY), e voce deve fornecer a
	senha para o nick que voce deseja ligar.

NICK_HELP_UNLINK
	Sintaxe: UNLINK [nick senha]
	
	Remove a ligacao com outro nick.  Quando uma ligacao eh
	removida, os modos de um nick e a lista de acesso do nick
	previamente ligado sao copiados para seu nick atual e podem
	ser independetemente alterados.  Suas mensagens nao sao
	copiadas; todas as mensagens permanecerao armazenadas no
	nick ligado anteriormente.
	
	Informando nick e senha como parametros, voce pode desligar o seu
	nick do nick especificado.

NICK_HELP_SET
	Sintaxe: SET opcao parametros
	
	Ajusta varias opcoes de nick.  A opcao pode ser:
	
	    PASSWORD   Ajusta a senha do seu nick
	    LANGUAGE   Ajusta a linguagem dos K9 Services quando
	                   mensagens sao enviadas a voce
	    URL        Associa um endereco URL com seu nick
	    EMAIL      Associa um endereco de e-mail ao seu nick
	    KILL       Ativa/Desativa a protecao de kill para o seu
	                   nick
	    SECURE     Ativa/Desativa o dispostivo de seguranca para
	                   o seu nick
	    PRIVATE    Previne seu nick de aparecer em um /msg %S LIST
	    HIDE       Esconde certas informacoes sobre seu nick
	
	Para usar este comando, voce deve primeiro se identificar
	com sua senha (/msg %S HELP IDENTIFY para maiores
	informacoes).
	
	Digite /msg %S HELP SET opcao para mais informacoes
	sobre um comando especifico.

NICK_HELP_SET_PASSWORD
	Sintaxe: SET PASSWORD nova-senha
	
	Muda a senha que eh utilizada para identificar voce como
	dono do nick.

NICK_HELP_SET_LANGUAGE
	Sintaxe: SET LANGUAGE numero
	
	Muda a linguagem que os K9 Services usa ao enviar mensagens
	para voce (por exemplo, quando responde um comando que voce
	emite).  O numero deve ser escolhido da seguinte lista
	de linguas de apoio:
	

NICK_HELP_SET_URL
	Sintaxe: SET URL url
	
	Associa uma dada URL ao seu nick.  Esta URL sera mostrada
	sempre que alguem solicitar informacao sobre seu nick
	atraves do comando INFO.

NICK_HELP_SET_EMAIL
	Sintaxe: SET EMAIL endereco
	
	Associa um endereco de e-mail designado ao seu nick.  Este
	endereco sera sempre mostrado quando alguem solicitar
	informacao sobre seu nick atraves do comando INFO.

NICK_HELP_SET_KILL
	Sintaxe: SET KILL {ON | QUICK | IMMED | OFF}
	
	Possibilita a protecao de KILL do seu nick.  Com a protecao
	de KILL acionada, se outro usuario tentar tomar seu nick,
	sera dado 1 minuto para este mudar de nick, apos isso, sera
	forcadamente removido do IRC pelo %S.
	
	Se voce selecionar QUICK, sera dado ao usuario somente 20
	segundos para mudar de nick ao inves do usual (60 segundos).
	Se voce selecionar IMMED, o usuario sera derrubado (kill)
	imediatamente sem ser advertido ou ser dada uma chance para
	ele mudar de nick.  Por favor, nao use esta opcao a menos
	que seja necessaria.  Os Administradores da sua rede podem
	deixar essa opcao desabilitada.

NICK_HELP_SET_SECURE
	Sintaxe: SET SECURE {ON | OFF}
	
	Torna os recursos de seguranca do %S ativos (ON) ou
	desativos (OFF) sobre o seu nick. Com o SECURE acionado,
	voce deve entrar com sua senha antes de ser reconhecido
	como usuario do nick, independentemente do fato do seu
	endereco constar na lista de acesso.  Entretanto, se
	voce esta na lista de acesso, o %S nao ira dar auto-kill
	em voce de acordo com os ajustes da opcao KILL.

NICK_HELP_SET_PRIVATE
	Sintaxe: SET PRIVATE {ON | OFF}
	
	Torna a opcao de privacidade do %S sobre o seu nick
	em ativada (ON) ou desativada (OFF).  Com PRIVATE acionado,
	seu nick nao aparecera nas listagens de nicks geradas com
	o comando %S LIST.  (Entretando, alguem que sabe do seu
	nick ainda pode obter informacoes usando o comando INFO).

NICK_HELP_SET_HIDE
	Sintaxe: SET HIDE {EMAIL | USERMASK | QUIT} {ON | OFF}
	
	Permite que voce previna que certas informacoes sejam
	mostradas quando alguem da INFO no seu nick.  Voce pode
	esconder seu endereco de e-mail (EMAIL), utima mascara vista
	ident@host (USERMASK), e sua ultima mensagem de saida
	(QUIT).  O segundo parametro especifica quando a informacao
	deve ser mostrada (OFF) ou escondida (ON).

NICK_HELP_UNSET
	Sintaxe: UNSET {URL | EMAIL}
	
	Permite voce apagar a URL ou o E-mail associados ao seu
	nickname. Use o parametro URL para apagar o URL, ou o
	parametro EMAIL para apagar o E-mail. Voce nao pode
	apagar os dois ao mesmo tempo.

NICK_HELP_UNSET_REQ_EMAIL
	Sintaxe: UNSET URL
	
	Permite voce apagar a URL associada ao seu nickname.
	O parametro URL deve ser fornecido.

NICK_HELP_RECOVER
	Sintaxe: RECOVER nick [senha]
	
	Permite que voce recupere seu nick se alguem o tiver tomado;
	isso faz o mesmo que o %S faz automaticamente se
	alguem "rouba" um nick protegido com kill.
	
	Quando voce usa este comando, o %S trara um falso
	usuario online com o mesmo nick de quem o esta usando.
	Isto causara uma desconexao pelo servidor de IRC do outro
	usuario.  O falso usuario ficara online por 1 minuto para
	assegurar que o outro usuario nao reconecte imediatamente;
	Durante deste minuto, voce pode reivindicar seu nick.
	Alternativamente, use o comando RELEASE (/msg %S HELP
	RELEASE) para retomar seu nick mais rapidamente.
	
	Para usar o comando RECOVER para um nick, seu endereco atual
	como mostrado com /WHOIS deve estar na lista de acesso do
	nick, ou voce deve fornecer a senha correta para o nick.
	
NICK_HELP_RELEASE
	Sintaxe: RELEASE nick [senha]
	
	Instrui o %S a remover qualquer espera no seu nick
	causada pelo kill automatico de protecao ou pelo uso do
	comando RECOVER.  Por padrao, essas esperas duram 1 minuto;
	este comando libera o seu nick mais cedo.
	
	Para usar o comando RELEASE para um nick, seu endereco atual
	como mostrado com /WHOIS deve estar na lista de acesso do
	nick, ou voce deve fornecer a senha correta para o nick.

NICK_HELP_GHOST
	Sintaxe: GHOST nick [senha]
	
	Elimina uma sessao "fantasma" de IRC que esteja usando seu
	nick.  A sessao "fantasma" eh aquela que nao esta realmente
	conectada, mas que o servidor de IRC acredita estar ainda
	ativa por qualquer razao.  Isso acontece normalmente se seu
	computador travar ou se sua conexao Internet ou modem cair
	por um periodo curto de tempo enquanto voce esta no IRC.
	
	Para usar o comando GHOST em um nick, seu endereco atual
	como mostrado no /WHOIS deve pertencer a lista de acesso do
	nick, ou voce deve fornecer a senha correta para o nick.

NICK_HELP_INFO
	Sintaxe: INFO nickname [ALL]
	
	Mostra a informacao sobre o nick dado, como, o dono do nick,
	ultimo endereco utilizado, tempo e opcoes.  Se voce esta   
	identificado para o nick que voce esta obtendo informacoes 
	e a opcao ALL eh especificada, sera mostrado a voce toda
	informacao possivel; havendo opcoes para esconder 
	informacoes ou nao.
	
NICK_HELP_LISTCHANS
	Sintaxe: LISTCHANS
	
	Lista os nomes o numero total de canais que voce tem
	registrado pelo seu nickname.

NICK_HELP_LIST
	Sintaxe: LIST padrao
	
	Lista todos os nicks registrados que combinam com o padrao
	fornecido no formato nick!ident@host.  Nicks com a opcao
	PRIVATE ligada nao serao mostrados.
	
	Exemplos:
	
	    LIST *!mauritz@mauritz.americasnet.com.br
	        Lista todos os nicks de mauritz@mauritz.americasnet.com.br.
	
	    LIST *Bot*!*@*
	        Lista todos os nicks registrados com Bot em seus nomes.
	        	
	    LIST *!*@*.americasnet.com.br
	        Lista todos os nicks do dominio americasnet.com.br.
	
NICK_HELP_STATUS
	Sintaxe: STATUS nick
	
	Retorna se o usuario que esta usando um determinado nick e
	eh reconhecio como dono do nick.  A resposta tem este
	formato:
	
	    nickname codigo-de-status
	
	onde nick eh o nick enviado com o comando, e
	codigo-de-status eh um dos seguintes:
	
	    0 - usuario nao esta conectado ou o nick nao esta registrado
	    1 - usuario nao reconhecido como dono do nick
	    2 - usuario reconhecido como dono soh pela lista de acesso
	    3 - usuario reconhecido como dono via identificacao por senha
	
	Ate dezesseis nicks podem ser enviados com cada comando; o
	resto sera ignorado.  Nao eh gerado mensagem de erro se nenhum
	nick for fornecido.

NICK_SERVADMIN_HELP
	
	Os comandos abaixo estao disponiveis aos Cservice
	Members:
	
	    GETPASS    Recupera a senha de um nick
	                   (se a encriptacao esta desativada)
	    FORBID     Previne um nick de ser usado
	
	Cservice Members podem tambem cancelar registro
	de qualquer nick sem a necessidade de identificacao e podem
	ver a lista de acesso de qualquer nick
	(/msg %S ACCESS LIST nick).

NICK_SERVADMIN_HELP_DROP
	Sintaxe: DROP [nick]
	
	Sem parametros, cancela o registro seu nick do banco de
	dados do %S.
	
	Com parametros, cancela o registro de um nick especificado
	do banco de dados.
	Este comando eh restrito aos Cservice Members.

NICK_SERVADMIN_HELP_SET
	
	Cservice Members podem ajustar a opcao NOEXPIRE,
	com a qual os nicks podem ser protegidos de expirar.
	E ainda, Cservice Members podem ajustar opcoes
	para qualquer nick sem se identificar com a senha, usando o
	SET nick opcao parametros.

NICK_SERVADMIN_HELP_SET_NOEXPIRE
	Sintaxe: SET [nick] NOEXPIRE {ON | OFF}
	
	Determina se um nick fornecido podera ser expirado.
	Ajustando este para ON, evita que o nick seja expirado.
	
	Limitado aos Cservice Members.

NICK_SERVADMIN_HELP_UNSET
	
	Cservice Members podem usar o comando UNSET em qualquer
	nickname apenas incluindo o nickname antes do nome da opcao,
	como no comando SET.

NICK_SERVADMIN_HELP_UNLINK
	
	Os Cservice Members podem desfazer uma ligacao sem
	precisar da senha.

NICK_SERVADMIN_HELP_LISTLINKS
	Sintaxe: LISTLINKS nick [ALL]
	
	Lista os nicks ligados a um determinado nick. Se ALL eh
	fornecido, lista todos os nicks com os mesmos privilegios de
	um determinado nick; caso contrario, lista apenas os nicks
	que estao ligados ao nick especificado.
	
	Limitado aos Cservice Members.

NICK_SERVADMIN_HELP_ACCESS
	
	Cservice Members podem fornecer um parametro nickname no
	comando LIST para mostrar a lista de acesso de qualquer
	nickname.

NICK_SERVADMIN_HELP_INFO
	
	Cservice Members podem usar o comando ALL com qualquer nick

NICK_SERVADMIN_HELP_LISTCHANS
	
	Cservice Members podem listar canais de qualquer nickname
	fornecendo o nickname com o comando (por exemplo,,
	/msg DogTag LISTCHANS OutroNick).

NICK_SERVADMIN_HELP_LIST
	Sintaxe: LIST padrao [FORBIDDEN] [NOEXPIRE]
	
	Lista todos os nicks registrados que combinem com o padrao
	fornecido (formato nick!user@host). Nicks com opcao PRIVATE
	serao somente exibidos para os Cservice Members.
	Nicks com opcao NOEXPIRE ajustada terao um ! preposto ao nick
	na lista quando for a pedido de Cservice Members.
	Se as opcoes FORBIDDEN ou NOEXPIRE forem fornecidas, somente os
	nicks probidos (forbidden) ou os que tem a flag NOEXPIRE serao
	exibidos, respectivamente. Se ambas as opcoes sao fornecidas,
	ambos os tipos de nicks serao exibidos.
	
	Essas opcoes sao limitadas aos Cservice Members.
	
	Exemplos:
	
	     LIST *!mauritz@mauritz.americasnet.com.br
	        Lista todos os nicks de mauritz@mauritz.americasnet.com.br.
	
	     LIST *Bot*!*@*
	        Lista todos os nicks registrados com Bot em seus nomes.
	
	     LIST * NOEXPIRE
	        Lista todos os nicks registrados cujos registros foram
	        ajustados para nao expirar.
	
NICK_SERVADMIN_HELP_GETPASS
	Sintaxe: GETPASS nick
	
	Mostra a senha de um nick especificado.
	Note que sempre que este comando for usado, uma mensagem
	incluindo o nick da pessoa que emitiu o comando o nick
	requisitado sera gravado e enviado para WALLOPS/GLOBOPS.
	
	Limitado aos Cservice Members.
	
	Este comando nao eh disponivel quando a encriptacao esta habilitada.

NICK_SERVADMIN_HELP_FORBID
	Sintaxe: FORBID nick
	
	Nao permite que um nick seja registrado ou usado por
	ninguem.  Pode ser cancelado desregistrando o nick.
	
	Limitado aos Cservice Members.

NICK_SERVADMIN_HELP_SUSPEND
	Sintaxe: SUSPEND [+expiracao] nickname razao
	
	Evita que um nickname, e todos aqueles nicknames com
	mesmo root nickname, seja usado ou identificado. Um
	Nickname pode ser reabilitado com o comando UNSUSPEND
	
	Ao contrario de um nickname com forbidden, um suspenso ?????
	nao perde suas informacoes e ira expirar!
	
	Limitado a Cservice Members.

NICK_SERVADMIN_HELP_UNSUSPEND
	Sintaxe: UNSUSPEND nickname
	
	Permite pessoas usarem e identificarem um nickname
	anteriormente suspenso.
	
	Limitado a Cservice Members.

###########################################################################
#
# Mensagens de help do ChanServ
#
###########################################################################

CHAN_HELP
	%S permite que voce registre e controle varios
	aspectos do canal. %S pode prevenir o "take over"
	do canal de usuarios maliciosos, limitando quem possui
	o privilegio de OP do canal. Os comandos disponiveis
	estao listados abaixo; Para usa-los, digite
	/msg %S comando. Para mais informacoes sobre
	um comando, digite /msg %S HELP comando.
	
	    REGISTER   Registra um canal
	    IDENTIFY   Identifica voce com uma senha
	    DROP       Cancela o registro de um canal
	    INFO       Mostra as opcoes e informacoes de um canal
	    SET        Ajusta as opcoes e informacoes de um canal
	    ACCESS     Mantem a lista de usuarios privilegiados
	    SOP        Mantem a lista de SuperOp
	    AOP        Mantem a lista de AutoOp
	    VOP        Mantem a lista de AutoVoice
	    AKICK      Mantem a lista de AutoKick
	
CHAN_HELP_OTHERS
	
	Outros comandos: UNSET, LIST, INVITE, UNBAN, CLEAR,
	                 LEVELS, OP, DEOP, VOICE, DEVOICE

CHAN_HELP_OTHERS_HALFOP_CHANPROT
	
	Outros comandos: UNSET, LIST, INVITE, UNBAN, CLEAR,
	                 LEVELS, OP, DEOP, VOICE, DEVOICE,
	                 HALFOP, DEHALFOP, PROTECT, DEPROTECT,
	                 HOP

CHAN_HELP_EXPIRES
	
	Note que qualquer canal nao utilizado por %d dias
	(entenda como se nenhum usuario da lista de acesso
	desse canal entrar neste periodo de tempo) tera
	automaticamente cancelado o seu registro.

CHAN_HELP_REGISTER
	Sintaxe: REGISTER canal senha descricao
	
	Registra um canal no banco de dados do %S.  Para
	utilizar este comando, voce deve primeiro ser OP do
	canal que esta tentando registrar.  A senha eh usada
	com o comando IDENTIFY e permitira que voce faca
	mudancas nas opcoes do canal futuramente.  O ultimo
	parametro que deve ser incluido, eh uma breve
	descricao do proposito do canal.
	
	Quando voce registra um canal, voce sera registrado
	como o "fundador" do canal.  O fundador do canal tem
	permissao para mudar todas as opcoes do canal; o %S
	tambem ira dar ao fundador automaticamente o privilegio
	de OP do canal quando ele/ela entra no canal.  Veja o
	comando ACCESS (/msg %S HELP ACCESS) para
	informacoes dos subconjuntos destes privilegios para
	outros usuarios do canal.
	
	IMPORTANTE:  Para registrar um canal, voce deve antes ter
	registrado seu nick.  Se ainda nao, digite /msg %s HELP
	para mais informacoes de como faze-lo.

CHAN_HELP_IDENTIFY
	Sintaxe: IDENTIFY canal senha
	
	Identifica voce no %S como fundador do canal fornecido.
	Muitos comandos exigem que voce use este comando antes
	de usa-los.  A senha devera ser a mesma usada por voce
	no comando REGISTER.

CHAN_HELP_DROP
	Sintaxe: DROP #canal
	
	Cancela o registro do canal.  So poder ser usado pelo
	fundador do canal, que primeiramente devera usar o
	comando IDENTIFY.

CHAN_HELP_SET
	Sintaxe: SET canal opcao parametros
	
	Permite ao fundador do canal ajustar as varias opcoes do
	canal e outras informacoes.  O fundador deve utilizar o
	comando IDENTIFY antes de usar o SET.
	
	Comandos disponiveis:
	
	    FOUNDER     Ajusta o fundador do canal
	    SUCCESSOR   Ajusta o sucessor do canal
	    PASSWORD    Ajusta a senha do fundador
	    DESC        Ajusta a descricao do canal
	    URL         Associa uma URL a um canal
	    EMAIL       Associa um e-mail a um canal
	    ENTRYMSG    Ajusta a mensagem que deve ser mandada
	                   aos usuarios quando eles entram no canal
	    TOPIC       Altera o topico do canal
	    KEEPTOPIC   Mantem o topico quando o canal nao esta em uso
	    TOPICLOCK   O topico pode ser mudado apenas com SET TOPIC
	    MLOCK       Liga ou desliga a trava dos modos do canal
	    PRIVATE     Esconde o canal do comando LIST
	    RESTRICTED  Acesso restrito ao canal
	    SECURE      Ativa os recursos de seguranca do %S
	    SECUREOPS   Rigoroso o controle de status de OP
	    LEAVEOPS    Nao tirar op de usuarios ao entrarem no canal
	    OPNOTICE    Envia uma notice quando os comandos OP/DEOP
	                   sao usados
	    ENFORCE     Forca status de auto-op, auto-voice
	
	Digite /msg %S HELP SET opcoes para maiores informacoes
	sobre uma opcao em particular.

CHAN_HELP_SET_FOUNDER
	Sintaxe: SET canal FOUNDER nick
	
	Muda o fundador do canal.  O novo nick deve estar
	registrado.
	
CHAN_HELP_SET_SUCCESSOR
	Sintaxe: SET canal SUCCESSOR nick
	
	Muda o sucessor de um canal. Se o nick do founder expirar
	ou estiver dropado enquanto o canal ainda estiver registrado,
	o sucessor se tornara o novo founder do canal.
	No entanto, se o sucessor possuir muitos canais registrados
	(%d), o canal sera dropado, como se nenhum sucessor tivesse
	sido ajustado. O novo nick devera estar registrado.

CHAN_HELP_SET_PASSWORD
	Sintaxe: SET canal PASSWORD senha
	
	Ajusta a senha utilizada para identificacao do
	fundador do canal.
	
CHAN_HELP_SET_DESC
	Sintaxe: SET canal DESC descricao
	
	Ajusta a descricao para o canal, que sao mostradas com
	os comandos LIST e INFO.

CHAN_HELP_SET_URL
	Sintaxe: SET canal URL url
	 
	Associa a URL dada ao canal. Esta URL sera mostrada
	sempre que alguem solicitar informacao sobre o canal
	com o comando INFO.

CHAN_HELP_SET_EMAIL
	Sintaxe: SET canal EMAIL endereco
	 
	Associa o endereco de e-mail fornecido ao canal.
	Este endereco sera mostrado sempre que alguem solicitar
	informacao sobre o canal com o comando INFO.

CHAN_HELP_SET_ENTRYMSG
	Sintaxe: SET canal ENTRYMSG mensagem
	 
	Ajusta a mensagem a qual sera enviada via /notice para
	os usuarios quando eles entrarem no canal.

CHAN_HELP_SET_TOPIC
	Sintaxe: SET canal TOPIC topico
	
	Faz o %S mudar o topico do canal pelo topico dado.
	Este comando eh muito mais util em conjunto com o
	SET TOPICLOCK.

CHAN_HELP_SET_KEEPTOPIC
	Sintaxe: SET canal KEEPTOPIC {ON | OFF}
	
	Ativa ou desativa a opcao de retencao de topico para
	um canal.  Quando a retencao de topico esta acionada,
	o topico para o canal sera relembrado pelo %S mesmo
	depois que os usuarios deixarem o canal, e sera
	restaurado na proxima vez que o canal for re-aberto.

CHAN_HELP_SET_TOPICLOCK
	Sintaxe: SET canal TOPICLOCK {ON | OFF}
	
	Ativa ou desativa a opcao de trava do topico de um canal.
	Quando a Trava do topico esta ativada, o %S nao permitira
	a mudanca do topico do canal exceto pelo comando SET TOPIC.
	

CHAN_HELP_SET_MLOCK
	Sintaxe: SET canal MLOCK modos
	
	Ajusta o parametro da trava do modo para um canal.  O %S
	permite que voce defina certos modos no canal a serem
	sempre ativos (ou desativos).  Os modos podem ser
	i, k, l, m, n, p, s e t; cada um desses
	travado como ativo, desativo ou nao travado.  O parametro
	modos e usado exatamente do mesmo modo como o comando
	/MODE;  isto eh, modos seguidos de + sao travados como
	ativos, e modos seguidos de - sao travados como desativos.
	
	Cuidado: Se voce trava uma senha, como no segundo exemplo
	abaixo, voce deveria tambem ajustar a opcao RESTRICTED para
	o canal (veja HELP SET RESTRICTED), ou qualquer usuario
	que entra no canal que esta vazio sera capaz de ver a senha!
	
	Exemplos:
	
	    SET #canal MLOCK +nt-iklps
	        Trava os modos n e t ativados, e os modos i, k, l, p,
	        e s desligados.  Modo m eh livremente deixado para se
	        ligado(on)ou desligado(off).
	
	    SET #canal MLOCK +knst-ilmp minha-senha
	        Trava os modos k, n, s, t como ligados e os modos i,
	        l, m, p como desligados.  Tambem trava a senha do
	        canal como "minha-senha".
	
	    SET #canal MLOCK +
	        Elimina a trava do modos; todos os modos do canal
	        ficam livres para ser ativados ou desativados.

CHAN_HELP_SET_PRIVATE
	Sintaxe: SET canal PRIVATE {ON | OFF}
	
	Ativa ou desativa a opcao private para um canal.  Quando
	private esta ativada, um /msg %S LIST nao ira incluir
	o canal em qualquer listagem.
	
CHAN_HELP_SET_RESTRICTED
	Sintaxe: SET canal RESTRICTED {ON | OFF}
	
	Ativa ou desativa a opcao de acesso restrito para um canal.
	Quando o acesso restrito estiver ativado, usuarios que
	normalmente nao possuem privilegios de OP no canal
	(usuarios com nivel negativo de acesso e, se secure ops
	estiver ativado, usuarios que nao pertence a lista de
	acesso) serao imediatamente kickados e banidos do canal.
	
CHAN_HELP_SET_SECURE
	Sintaxe: SET canal SECURE {ON | OFF}
	
	Ativa ou desativa os recursos de seguranca do %S para
	um canal.  Quando o SECURE estiver ativo, somente
	usuarios que possuirem seus nicks registrados no %s
	e identificados com sua senha poderao entrar no canal
	controlado pela lista de acesso.
	
CHAN_HELP_SET_SECUREOPS
	Sintaxe: SET canal SECUREOPS {ON | OFF}
	
	Ativa ou desativa a opcao de seguranca de ops para um canal.
	Quando secure-ops estiver ativada, os usuarios que nao
	estiverem na lista de acesso nao poderao ter o status de
	OP.

CHAN_HELP_SET_LEAVEOPS
	Sintaxe: SET canal LEAVEOPS {ON | OFF}
	
	Ativa ou desativa a opcao leave ops para um canal.
	Quando leave ops estiver ligado, %S deixara com op
	o usuario que entrar primeiro no canal mesmo se o
	usuario nao deveria receber op normalmente.
	A opcao SECUREOPS e o nivel de acesso de AUTODEOP
	continuarao sendo reforcados.
	Observacao: Isso pode permitir usuarios "roubarem" ops
	durante um netsplit.

CHAN_HELP_SET_OPNOTICE
	Sintaxe: SET canal OPNOTICE {ON | OFF}
	
	Ativa e desativa a opcao Op-Notice para um canal. Quando
	Op-Notice estiver ativado, o %S enviara uma notice para
	o canal sempre que os comandos OP ou DEOP forem usados em
	um usuario no canal.

CHAN_HELP_SET_ENFORCE
	Sintaxe: SET canal ENFORCE {ON | OFF}
	
	Ativa ou desativa a op$Bgc(Bo de enforce para um canal.
	Quando a op$Bgc(Bo de enforce está ligada, %S forcara o nivel
	de auto-op e auto-voice para todos os usuarios. Por Exemplo,
	se um usuario com privilegio de auto-op for deopado, %S ira
	automaticamente da-lo op novamente, e %S nao ira permitir
	que o comando DEOP seja usado nesse usuario.

CHAN_HELP_UNSET
	Sintaxe: UNSET canal {SUCCESSOR | URL | EMAIL | ENTRYMSG}
	
	Apaga do canal a opcao fornecida.

CHAN_HELP_SOP
	Sintaxe: SOP canal ADD nick
	         SOP canal DEL nick
	         SOP canal LIST [mascara | lista]
	         SOP canal COUNT
	
CHAN_HELP_SOP_NOPROT
	Mantem a lista de SuperOp (SOP) de um canal. Usuarios
	com o status de SOP recebem automaticamente op (modo
	+o) ao entrarem no canal.
CHAN_HELP_SOP_PROT
	Faz manutencao da lista de SuperOp (SOP) de um canal.
	Usuários com estatus de SOP recebem automaticamente op
	(modo +o) e protegido (modo +a) quando entram no canal.
CHAN_HELP_SOP_END
	
	Um SOP pode modificar as listas de AOP e VOP.
	Apenas o fundador do canal pode modificar a lista de SOP.
	
	O comando SOP LIST mostra a lista de SOP. Se uma mascara
	for dada, apenas as entradas que combinarem com a mascara
	serao mostradas. Se uma lista de numeros for dada, apenas tais
	entradas serao mostradas; por exemplo:
	
	   SOP #canal LIST 2-5,7-9
	      Mostra as entradas da lista de SOP numeradas de 2 a 5 e
	      de 7 a 9.
	
	O comando SOP COUNT retorna o numero de entradas que existem
	na lista de SOP.

CHAN_HELP_AOP
	Sintaxe: AOP canal ADD nick
	         AOP canal DEL nick
	         AOP canal LIST [mascara | lista]
	         AOP canal COUNT
	
	Mantem a lista de AutoOp (AOP) de um canal. Usuarios
	com o status de AOP recebem automaticamente op (modo
	+o) ao entrarem no canal.
	
	Um AOP pode modificar a lista VOP.
	
	O comando AOP LIST mostra a lista de AOP. Se uma mascara
	for dada, apenas as entradas que combinarem com a mascara
	serao mostradas. Se uma lista de numeros for dada, apenas tais
	entradas serao mostradas; por exemplo:
	
	   AOP #canal LIST 2-5,7-9
	      Mostra as entradas da lista de AOP numeradas de 2 a 5 e
	      de 7 a 9.
	
	O comando AOP COUNT retorna o numero de entradas que existem
	na lista de AOP.

CHAN_HELP_HOP
	Sintaxe: HOP canal ADD nick
	         HOP canal DEL nick
	         HOP canal LIST [mascara | lista]
	         HOP canal COUNT
	
	Faz manunten$Bgc(Bo da lista de HalfOp (HOP) de um canal.
	Usuarios com status de HOP recebem automaticamente halfop
	(modo +h) quando entram no canal.
	
	Um HOP pode modificar a lista de VOP; SOPs e AOPs podem
	modificar a lista de HOP.
	
	O comando HOP LIST mostra a lista de HOP.  Se uma mascara
	wildcard eh dada, apenas as entradas que combinam com a
	mascara sao mostradas.  Se uma lista de numeros de entradas
	eh dada, apenas tais entradas sao mostradas; por exemplo:
	
	   HOP #canal LIST 2-5,7-9
	      Mostra as entradas da lista de HOP numeradas de 2 a 5
	      e de 7 a 9
	
	O comando HOP COUNT retorna o numero de entradas que existem
	na lista de HOP.

CHAN_HELP_VOP
	Sintaxe: VOP canal ADD nick
	         VOP canal DEL nick
	         VOP canal LIST [mascara | lista]
	         VOP canal COUNT
	
	Mantem a lista de VoiceOp (VOP) de um canal. Usuarios
	com o status de VOP recebem automaticamente voice
	(modo +v) ao entrarem no canal.
	
	O comando VOP LIST mostra a lista de VOP. Se uma mascara
	for dada, apenas as entradas que combinarem com a mascara
	serao mostradas. Se uma lista de numeros for dada, apenas tais
	entradas serao mostradas; por exemplo:
	
	   VOP #canal LIST 2-5,7-9
	      Mostra as entradas da lista de VOP numeradas de 2 a 5 e
	      de 7 a 9.
	
	O comando VOP COUNT retorna o numero de entradas que existem
	na lista de VOP.

CHAN_HELP_ACCESS
	Sintaxe: ACCESS canal ADD nick nivel
	         ACCESS canal DEL {nick | entry-num | list}
	         ACCESS canal LIST [mascara | list]
	
	Faz manutencao da lista de acesso de um canal.  A lista
	de acesso especifica que usuarios tem permissao para
	0 status de OP ou tem acesso aos comandos do %S em um
	canal.  Niveis diferentes de usuarios permitem acesso a
	diferentes subniveis de privilegios; /msg %S HELP ACCESS
	LEVELS para mais informacoes especificas.  Por padrao,
	qualquer nick nao presente na lista de acesso possui
	nivel 0.
	
	O comando ACCESS ADD adiciona um nick ou mascara de um
	usuario na lista de acesso com o nivel especificado; se o
	nick ou mascara ja estiver presente na lista, seu nivel
	de acesso sera alterado para o nivel especificado.
	O nivel especificado deve ser menor do que o usuario
	que emitiu o comando.
	
	O comando ACCESS DEL remove um nick especificado da lista
	de acesso. Se uma lista de numeros eh fornecida, essas
	entradas sao apagadas. (Veja o exemplo para LIST abaixo.)
	
	O comando ACCESS LIST mostra a lista de acesso do canal. Se
	uma mascara for fornecida, somente aquelas entradas que combinarem
	com o padrao especificado na mascara serao mostradas. Se uma
	lista de numeros eh fornecida, somente essas entradas serao
	mostradas; por exemplo:
	
	ACCESS #canal LIST 2-5,7-9
	   Lista as entradas de acesso numeradas de 2 a 5 e 7 a 9.

CHAN_HELP_ACCESS_LEVELS
	Niveis de Acesso do Usuario
	
	Por padrao, os seguintes niveis de acesso sao definidos:
	
	   Founder   Acesso total as funcoes do %S; OP automatico
	                     quando entrar no canal.  Note que de
	                     somente uma pessoa pode ter o status
	                     fundador (isto nao pode ser dado usando
	                     o comando ACCESS).
	        10   Acesso ao comando AKICK; OP automatico.
	         5   OP automatico.
	         3   Voice automatico.
	         0   Sem privilegios especiais; pode se tornar OP
	                     atraves de outros ops (a menos que
	                     secure-ops esteja ativada).
	        <0   Nao pode ser OP.
	
	Esses niveis podem ser mudados, ou adiconar novos, usando o
	comando LEVELS; digite /msg %S HELP LEVELS para informacoes.
	
CHAN_HELP_AKICK
	Sintaxe: AKICK canal ADD mascara [razao]
	         AKICK canal DEL mascara
	         AKICK canal LIST [mascara]	
	         AKICK canal ENFORCE
	
	Faz a manutencao da lista de Autokick de um canal.
	Se um usuario que estiver na lista de AutoKick tentar
	entrar no canal, o %S banira este usuario do canal,
	e depois kickara o usuario.
	
	O comando AKICK ADD adiciona o usuario especificado ou
	mascara na lista de Autokick.  Se uma razao eh dada com
	o comando, esta razao sera usada quando o usuario for
	kickado; senao, a razao padrao sera "Voce foi banido deste
	canal".
	
	O comando AKICK DEL remove um nick ou mascara da lista
	de AutoKick.  Isso, entretanto, nao remove qualquer ban
	colocado pelo AutoKick; estes devem ser removidos
	manualmente.
	
	O comando AKICK LIST mostra a lista de AutoKick, ou
	opcionalmente, soh os registros de AutoKick quem se
	encaixam com o padrao de uma mascara dada.
	
	O comando AKICK ENFORCE obriga o %S a verificar
	a lista de AKICKs para remover os usuarios conectados que
	sejam compativeis com a mascara dada.

CHAN_HELP_LEVELS
	Sintaxe: LEVELS canal SET tipo nivel
	         LEVELS canal {DIS | DISABLE} tipo
	         LEVELS canal LIST
	         LEVELS canal RESET
	
	O comando LEVELS permite ajuste detalhado sobre o
	significado numerico dos niveis de acesso usados pelos
	canais.  Com esse comando, voce pode definir o nivel de
	acesso requerido pela maioria das funcoes do %S.
	(Os comandos SET FOUNDER e SET PASSWORD, assim como este
	comando, sao sempre restritos ao fundador do canal).
	
	LEVELS SET permite que o nivel de acesso para uma funcao ou
	grupo de funcoes sejam alterados.  LEVELS DISABLE (ou DIS
	para encurtar) desabilita automaticamente os dispositivos ou
	nao permite o acesso a funcoes para qualquer outra pessoa
	que nao seja o fundador do canal.  LEVELS LIST mostra os
	niveis atuais para cada funcao ou para um grupo de funcoes.
	LEVELS RESET recoloca os niveis de acordo com o padrao de um
	canal recem-criado (veja HELP ACCESS LEVELS).
	
	Para lista de recursos e funcoes cujo niveis podem ser
	ajustados, veja HELP LEVELS DESC.

CHAN_HELP_LEVELS_DESC
	A seguinte caracteristica/funcao sao entendidas.  Note que
	estes niveis para AUTODEOP e NOJOIN sao os niveis maximos,
	enquanto que todos os outros sao niveis minimos.

CHAN_HELP_LEVELS_DESC_FORMAT
	    %-*s  %s

CHAN_HELP_INFO
	Sintaxe: INFO canal [ALL]
	
	Lista os dados referentes ao canal registrado dado, incluindo
	seu fundador, data do registro, ultima vez que foi usado,
	descricao, e trava dos modos (se existirem). Se voce esta 
	identificado como fundador do canal que esta solicitando
	informacoes e a opcao ALL eh especificada, informacoes 
	sobre a mensagem de entrada e sobre o sucessor do canal
	 tambem sera mostrada.

CHAN_HELP_LIST
	Sintaxe: LIST padrao
	
	Lista todos os canais registrados que combinam com o padrao
	dado.  (Canais com opcao PRIVATE ativada nao serao listados).

CHAN_HELP_OP
	Sintaxe: OP #canal nick
	
	Atribui status de Operador (modo +o) para o nick dado em
	um determinado canal.  Limitado aos usuarios de nivel 5,
	no minino, do canal especificado.

CHAN_HELP_DEOP
	Sintaxe: DEOP #canal nick
	
	Remove o status de Operador (modo +o) do nick dado para
	um determinado canal. Limitado aos usuarios de nivel 5,
	no minino, do canal especificado.

CHAN_HELP_VOICE
	Sintaxe: VOICE #canal nick
	
	Dah voice (modo +v) a um nick em um canal. Por padrão,
	limitado aqueles com nivel de acesso 3 ou mais no canal.

CHAN_HELP_DEVOICE
	Sintaxe: DEVOICE #canal nick
	
	Tira voice (modo -v) de um nick em um canal. Por padrão,
	limitado aqueles com nivel de acesso 3 ou mais no canal.

CHAN_HELP_HALFOP
	Sintaxe: HALFOP #canal nick
	
	Dah acesso de halfop (modo +h) a um nick em um canal. Por
	padrão, limitado aqueles com nivel de acesso 4 ou mais no
	canal.

CHAN_HELP_DEHALFOP
	Sintaxe: DEHALFOP #canal nick
	
	Tira acesso de halfop (modo -h) de um nick em um canal. Por
	padrão, limitado aqueles com nivel de acesso 4 ou mais no
	canal.

CHAN_HELP_PROTECT
	Sintaxe: PROTECT #canal nick
	
	Dá protecao de canal (modo +a) para um nick selecionado em um
	canal.  Por padrão, limitado aqueles com nivel de acesso igual
	ou superior a 10 no canal.

CHAN_HELP_DEPROTECT
	Sintaxe: DEPROTECT #canal nick
	
	Remove a protecao de canal (modo +a) de um nick selecionado em
	um canal.  Por padrão, limitado aqueles com nivel de acesso igual
	ou superior a 10 no canal.
	
CHAN_HELP_INVITE
	Sintaxe: INVITE #canal
	
	Manda o %S dar um invite em voce para o canal dado.
	Somente funcionara se seu nivel de acesso for pelo menos
	igual a 5.

CHAN_HELP_UNBAN
	Sintaxe: UNBAN #canal
	
	Diz ao %S para remover todos os bans permitindo que
	voce entre em um canal.  Por padrao, somente funciona
	se seu nivel de acesso no canal for pelo menos igual a 5.

CHAN_HELP_CLEAR
	Sintaxe: CLEAR canal opcao
	
	Diz ao %S para remover certas colocacoes de um canal.
	A opcap pode ser uma das seguintes:
	
	     MODES       Anula todos os modos do canal (isto eh, remove
	                     os modos i,k,l,m,n,p,s,t).
CHAN_HELP_CLEAR_EXCEPTIONS
	     EXCEPTIONS  Remove todas as excecoes de um canal.
CHAN_HELP_CLEAR_MID
	     BANS        Remove todos os bans do canal.
	     OPS         Remove o status de Operador do canal (mode +o)
	                     de todos os Operadores do canal.
CHAN_HELP_CLEAR_HALFOPS
	     HALFOPS     Remove o status de halfop (mode +h) de todos os usuarios.
CHAN_HELP_CLEAR_END
	     VOICES      Remove o status "voice" (mode +v) de qualquer
	                     pessoa que tenha esse modo.
	     USERS       Remove (kicka) todos os usuarios do canal.
	
	Por padrao, seu nivel de acesso no canal dever ser no
	minimo 10 para usar este comando.

CHAN_SERVADMIN_HELP
	
	Os seguintes comandos estao disponiveis para
	os Cservice Members:
	
	    GETPASS    Recupera a senha de fundador de um canal
	                   (somente se a encriptacao esta desativada)
	    FORBID     Proibe um canal de ser usado
	    SUSPEND    Proibe um canal registrado de ser usado
	    STATUS     Fornece o atual nivel de acesso de um
	                   usuario em um canal
	
	Administradores do Services podem tambem cancelar o registro sem
	a necessidade de identificacao atraves da senha, podem ver os
	acessos, AKICK, e ajuste da lista de niveis de qualquer canal.

CHAN_SERVADMIN_HELP_DROP
	Sintaxe: DROP canal
	
	Cancela o registro de um canal.  Somente Administradores dos
	Services podem cancelar canais para os quais eles nao tenham
	sido identificados.

CHAN_SERVADMIN_HELP_SET
	
	Cservice Members tambem pode ajustar a opcao
	NOEXPIRE, fazendo com canais sejam impedidos de ter seu
	registro expirado.  Cservice Members ainda podem
	ajustar opcoes para qualquer canal sem precisar da identificacao
	do canal atraves da senha.

CHAN_SERVADMIN_HELP_UNSET
	
	Como no comando SET, Cservice Members pode apagar configuracoes
	de qualquer canal sem estar identificado para o mesmo.

CHAN_SERVADMIN_HELP_SET_NOEXPIRE
	Sintaxe: SET canal NOEXPIRE {ON | OFF}
	
	Determina se o canal podera ter seu registro expirado.
	Ajustando para ON, evita que o canal seja desregistrado
	por passar do tempo de expiracao.
	
	Limitado aos Cservice Members.

CHAN_SERVADMIN_HELP_INFO
	
	Administradores de Services podem usar o comando ALL com qualquer canal.

CHAN_SERVADMIN_HELP_LIST
	Sintaxe: LIST padrao
	
	Lista todos os canais registrados que combinam com o
	padrao fornecido.  Canais com opcao PRIVATE ativada
	soh serao mostrados aos Cservice Members.

CHAN_SERVADMIN_HELP_GETPASS
	Sintaxe: GETPASS canal
	
	Retorna a senha de um canal. Note que toda vez que esse
	este comando for usado, uma mensagem incluindo o nick da
	pessoa que emitiu o comando e o canal que foi dado serao
	gravados e enviados para WALLOPS/GLOBOPS.
	
	Limitado aos Cservice Members.

CHAN_SERVADMIN_HELP_FORBID
	Sintaxe: FORBID canal
	
	Proibe que qualquer pessoa registre e utilize o canal
	dado.  Pode ser cancelado pelo desregistro do canal.
	
	Limitado aos Cservice Members.

CHAN_SERVADMIN_HELP_SUSPEND
	Sintaxe: SUSPEND [+expiracao] canal razao
	
	Evita que um canal seja usado ou identificado. Um
	Nickname pode ser reabilitado com o comando UNSUSPEND
	
	Ao contrario de um canal com forbidden, um canal suspenso
	nao perde suas informacoes e ira expirar!
	
	Limitado a Cservice Members.

CHAN_SERVADMIN_HELP_UNSUSPEND
	Sintaxe: UNSUSPEND canal
	
	Permite pessoas usarem e identificarem um canal
	anteriormente suspenso.
	
	Limitado a Cservice Members.

CHAN_SERVADMIN_HELP_STATUS
	Retorna o nivel de acesso atual de um determinado nick em um
	determinado canal. A resposta sera no formato:
	
	    STATUS canal nick nivel-de-acesso
	
	Se um erro ocorrer, a resposta sera no formato:
	
	    STATUS ERROR mensagem-de-erro


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

