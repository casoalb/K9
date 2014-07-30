# Emacs mode: -*- text -*-

# Japanese language file (EUC encoding) / 日本語のメッセージファイル
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
# 言語の名前
#
###########################################################################

LANG_NAME
	日本語（EUCコード） (Japanese / EUC encoding)

###########################################################################
#
# 多用のメッセージ
#
###########################################################################

# strftime()の日時フォーマット
STRFTIME_DATE_TIME_FORMAT
	%Y.%m.%d %H:%M:%S %Z
# strftime()の年月日フォーマット（１）
STRFTIME_LONG_DATE_FORMAT
	%Y年%m月%d日（%a）
# strftime()の年月日フォーマット（２）
STRFTIME_SHORT_DATE_FORMAT
	%Y.%m.%d

# strftime()のフォーマットで使用される文字列
STRFTIME_DAYS_SHORT
	日
	月
	火
	水
	木
	金
	土
STRFTIME_DAYS_LONG
	日曜日
	月曜日
	火曜日
	水曜日
	木曜日
	金曜日
	土曜日
STRFTIME_MONTHS_SHORT
	1月
	2月
	3月
	4月
	5月
	6月
	7月
	8月
	9月
	10月
	11月
	12月
STRFTIME_MONTHS_LONG
	1月
	2月
	3月
	4月
	5月
	6月
	7月
	8月
	9月
	10月
	11月
	12月


# "day", "hour", "minute", and "second" in singular and plural.
STR_DAY
	日
STR_DAYS
	日
STR_HOUR
	時間
STR_HOURS
	時間
STR_MINUTE
	分
STR_MINUTES
	分
STR_SECOND
	秒
STR_SECONDS
	秒


# ChanServ、DogTag INFOで使われるもの
COMMA_SPACE
	、


# エラーメッセージ
USER_RECORD_NOT_FOUND
	エラーが発生しました。
UNKNOWN_COMMAND
	%s というコマンドは分かりません。
UNKNOWN_COMMAND_HELP
	%s というコマンドは分かりません。ヘルプを見る場合は「/msg %s HELP」を入力して下さい。
SYNTAX_ERROR
	用法：%s
MORE_INFO
	ヘルプを見る場合は「/msg %s HELP %s」を入力して下さい。
NO_HELP_AVAILABLE
	「%s」のヘルプはありません。

BAD_USERHOST_MASK
	マスクを user@host という形で入力して下さい。

SERVICE_OFFLINE
	%sは現在使用できません。
READ_ONLY_MODE
	注意：Services は読み込み専用モードで動いていますので、変更は保存されません。
ACCESS_DENIED
	アクセス不能。
PERMISSION_DENIED
	アクセス不能。
PASSWORD_INCORRECT
	パスワードは違います。

MORE_OBSCURE_PASSWORD
	もっと複雑なパスワードにして下さい。パスワードは、お名前・ニック等のような分かりやすいものでなく、かつ５文字以上のものにして下さい。また、スペース（空白）はパスワードでは使えません。
PASSWORD_TRUNCATED
	注意：入力したパスワードが %d 文字で切られました。

NICK_NOT_REGISTERED
	ニックは登録されていません。
NICK_NOT_REGISTERED_HELP
	ニックは登録されていません。登録したい場合は「/msg %s HELP」を入力して下さい。
NICK_X_NOT_REGISTERED
	%s というニックは登録されていません。
NICK_X_NOT_IN_USE
	%s というニックは現在使用されていません。
NICK_X_FORBIDDEN
	%s というニックを使用禁止です。
NICK_X_SUSPENDED
	%s というニックは使用停止のため、使用できません。
NICK_X_SUSPENDED_MEMOS
	%s というニックは使用停止のため、メモを受信できません。
NICK_IDENTIFY_REQUIRED
	そのコマンドを使うにはパスワードを入力する必要があります。
	「/msg %s IDENTIFY パスワード」を入力して下さい。
NICK_X_NOT_ON_CHAN_X
	%s は %s に入っていません。

CHAN_X_NOT_REGISTERED
	%s というチャンネルは登録されていません。
CHAN_X_NOT_IN_USE
	%s というチャンネルは現在使用されていません。
CHAN_X_FORBIDDEN
	%s というチャンネルは使用禁止です。
CHAN_X_SUSPENDED
	%s というチャンネルは使用停止のため、使用できません。
CHAN_X_SUSPENDED_MEMOS
	%s というチャンネルは使用停止のため、メモを受信できません。
CHAN_IDENTIFY_REQUIRED
	そのコマンドを使うにはパスワードを入力する必要があります。
	「/msg %s IDENTIFY %s パスワード」を入力して下さい。

SERV_X_NOT_FOUND
	%s というサーバは見つかりません。

EXPIRES_NONE
	切れない
EXPIRES_SOON
	次のデータ保存時に切れる
EXPIRES_M
	%d分後切れる
EXPIRES_1M
	%d分後切れる
EXPIRES_HM
	%d時%d分後切れる
EXPIRES_H1M
	%d時%d分後切れる
EXPIRES_1HM
	%d時%d分後切れる
EXPIRES_1H1M
	%d時%d分後切れる
EXPIRES_D
	%d日後切れる
EXPIRES_1D
	%d日後切れる

###########################################################################
#
# DogTagのメッセージ
#
###########################################################################

# 自動メッセージ
NICK_IS_REGISTERED
	このニックは登録されています。他のニックに変えて下さい。
	（保有者なら、「/msg %s IDENTIFY パスワード」を入力して下さい。）
NICK_IS_SECURE
	このニックは登録保護されています。保有者なら、
	「/msg %s IDENTIFY パスワード」を入力して下さい。
	保有者でなければ、他のニックに変えて下さい。
NICK_MAY_NOT_BE_USED
	このニックはお使いになれません。
DISCONNECT_IN_1_MINUTE
	1分以内にニックを変えないと、切断されてしまいます。
DISCONNECT_IN_20_SECONDS
	20秒以内にニックを変えないと、切断されてしまいます。
DISCONNECT_NOW
	このニックは登録されていますので、お使いになれません。
	再接続する前に他のニックにお変え下さい。
FORCENICKCHANGE_IN_1_MINUTE
	1分以内にニックを変えないと、ニックが変更されます。
FORCENICKCHANGE_IN_20_SECONDS
	20秒以内にニックを変えないと、ニックが変更されます。
FORCENICKCHANGE_NOW
	このニックは登録されていますので、お使いになれません。
	あなたのニックは「%s」に変更されました。

# REGISTER応答
NICK_REGISTER_SYNTAX
	REGISTER パスワード [メールアドレス]
NICK_REGISTER_REQ_EMAIL_SYNTAX
	REGISTER パスワード メールアドレス
NICK_REGISTRATION_DISABLED
	ニックの登録はただ今出来ません。
NICK_REGISTRATION_FAILED
	登録は失敗しました。
NICK_REG_PLEASE_WAIT
	REGISTERのコマンドを再入力する前に、%d 秒お待ち下さい。
NICK_CANNOT_BE_REGISTERED
	%s は使用禁止ですので登録できません。
NICK_ALREADY_REGISTERED
	%s は既に登録されています。
NICK_REGISTERED
	ニック「%s」を登録しました。
NICK_PASSWORD_IS
	ニックのパスワードは %s です。忘れないようにして下さい。

# IDENTIFY応答
NICK_IDENTIFY_SYNTAX
	IDENTIFY パスワード
NICK_IDENTIFY_FAILED
	IDENTIFYは失敗しました。
NICK_IDENTIFY_SUCCEEDED
	正しいパスワードです。

# DROP応答
NICK_DROP_SYNTAX
	DROP
NICK_DROP_DISABLED
	ニック登録の消去はただ今出来ません。
NICK_DROPPED
	ニックの登録を消去しました。
NICK_X_DROPPED
	%s の登録を消去しました。

# SET応答
NICK_SET_SYNTAX
	SET オプション名 パラメータ
NICK_SET_SERVADMIN_SYNTAX
	SET [ニック] オプション名 パラメータ
NICK_SET_DISABLED
	ニックのオプション設定はただ今不可能です。
NICK_SET_UNKNOWN_OPTION
	%s というオプションはありません。
NICK_SET_UNKNOWN_OPTION_OR_BAD_NICK
	%s はオプション名でも登録済みニックでもありません。

# SET PASSWORD応答
NICK_SET_PASSWORD_FAILED
	パスワードの変更は失敗しました。
NICK_SET_PASSWORD_CHANGED
	パスワードを変更しました。
NICK_SET_PASSWORD_CHANGED_TO
	パスワードを %s に変更しました。

# SET LANGUAGE応答
NICK_SET_LANGUAGE_SYNTAX
	SET LANGUAGE 番号
NICK_SET_LANGUAGE_UNKNOWN
	%d 番の言語は存在しません。言語表を見る場合、「msg %s HELP SET LANGUAGE」を入力して下さい。
NICK_SET_LANGUAGE_CHANGED
	言語を日本語（EUCコード）に変更しました。

# SET URL応答
NICK_SET_URL_CHANGED
	%s のホームページアドレスを %s に変更しました。

# SET EMAIL応答
NICK_SET_EMAIL_CHANGED
	%s の電子メールアドレスを %s に変更しました。

# SET KILL応答
NICK_SET_KILL_SYNTAX
	SET KILL {ON | QUICK | OFF}
NICK_SET_KILL_IMMED_SYNTAX
	SET KILL {ON | QUICK | IMMED | OFF}
NICK_SET_KILL_ON
	ニック保護設定を有効に設定しました。
NICK_SET_KILL_QUICK
	ニック保護設定を有効（ニック変更期限は20秒）に設定しました。
NICK_SET_KILL_IMMED
	ニック保護設定を有効（即時切断）に設定しました。
NICK_SET_KILL_IMMED_DISABLED
	このネットワークでは、IMMED を選択できません。
NICK_SET_KILL_OFF
	ニック保護設定を無効に設定しました。

# SET SECURE応答
NICK_SET_SECURE_SYNTAX
	SET SECURE {ON | OFF}
NICK_SET_SECURE_ON
	セキュア設定を有効に設定しました。
NICK_SET_SECURE_OFF
	セキュア設定を無効に設定しました。

# SET PRIVATE応答
NICK_SET_PRIVATE_SYNTAX
	SET PRIVATE {ON | OFF}
NICK_SET_PRIVATE_ON
	プライベート設定を有効に設定しました。
NICK_SET_PRIVATE_OFF
	プライベート設定を無効に設定しました。

# SET HIDE応答
NICK_SET_HIDE_SYNTAX
	SET HIDE {EMAIL | USERMASK | QUIT} {ON | OFF}
NICK_SET_HIDE_EMAIL_ON
	電子メールアドレスは INFO 応答で表示されません。
NICK_SET_HIDE_EMAIL_OFF
	電子メールアドレスは INFO 応答で表示されます。
NICK_SET_HIDE_MASK_ON
	前のユーザアドレスは INFO 応答で表示されません。
NICK_SET_HIDE_MASK_OFF
	前のユーザアドレスは INFO 応答で表示されます。
NICK_SET_HIDE_QUIT_ON
	前の切断メッセージは INFO 応答で表示されません。
NICK_SET_HIDE_QUIT_OFF
	前の切断メッセージは INFO 応答で表示されます。

# SET NOEXPIRE応答
NICK_SET_NOEXPIRE_SYNTAX
	SET [ニック] NOEXPIRE {ON | OFF}
NICK_SET_NOEXPIRE_ON
	%s の登録は切れません。
NICK_SET_NOEXPIRE_OFF
	%s の登録は切れます。

# UNSET応答
NICK_UNSET_SYNTAX
	UNSET {URL | EMAIL}
NICK_UNSET_SYNTAX_REQ_EMAIL
	UNSET URL
NICK_UNSET_URL
	%s のホームページアドレスを消去しました。
NICK_UNSET_EMAIL
	%s の電子メールアドレスを消去しました。
NICK_UNSET_EMAIL_BAD
	電子メールアドレスを消去できません。
NICK_UNSET_EMAIL_OTHER_BAD
	ニックの電子メールアドレスを消去できません。

# ACCESS応答
NICK_ACCESS_SYNTAX
	ACCESS {ADD | DEL | LIST} [マスク]
NICK_ACCESS_REACHED_LIMIT
	ニックのアクセス一覧のエントリ数は上限（%d）に達していますので追加できません。
NICK_ACCESS_ALREADY_PRESENT
	%s はすでにアクセス一覧で存在しています。
NICK_ACCESS_ADDED
	%s をアクセス一覧に追加しました。
NICK_ACCESS_NOT_FOUND
	%s はアクセス一覧で存在しません。
NICK_ACCESS_DELETED
	%s をアクセス一覧から消去しました。
NICK_ACCESS_LIST
	アクセス一覧：
NICK_ACCESS_LIST_X
	%s のアクセス一覧：

# LINK応答
NICK_LINK_SYNTAX
	LINK ニック パスワード
NICK_LINK_DISABLED
	LINK はただ今使用できません。
NICK_LINK_FAILED
	リンクは失敗しました。
NICK_NO_LINK_SAME
	同じニックにリンクできません。
NICK_LINK_CIRCULAR
	環状リンクが発見されましたので %s にリンクできません。
NICK_LINK_TOO_DEEP
	ニックの階層上限（%d）を越えますのでリンクできません。
NICK_LINK_TOO_MANY_CHANNELS
	ニックの合計登録チャンネル数の上限（%d）を越えますのでリンクできません。
NICK_LINKED
	ニックを %s にリンクしました。

# UNLINK応答
NICK_UNLINK_SYNTAX
	UNLINK [ニック パスワード]
NICK_UNLINK_FAILED
	アンリンクは失敗しました。
NICK_NOT_LINKED
	ニックはリンクされていません。
NICK_UNLINKED
	ニックを %s からアンリンクしました。
NICK_X_NOT_LINKED
	%s はリンクされていません。
NICK_X_UNLINKED
	%s を %s からアンリンクしました。

# LISTLINKS応答
NICK_LISTLINKS_SYNTAX
	LISTLINKS ニック [ALL]
NICK_LISTLINKS_HEADER
	%s にリンクされているニック：
NICK_LISTLINKS_FOOTER
	%d 個見つかりました。
NICK_X_IS_LINKED
	    %s
NICK_X_IS_LINKED_VIA_X
	    %-20s (via %s)

# INFO応答
NICK_INFO_SYNTAX
	INFO nick
NICK_INFO_REALNAME
	%s は %s
NICK_INFO_ADDRESS
	前回ユーザアドレス：%s
NICK_INFO_ADDRESS_ONLINE
	現在使用中アドレス：%s
NICK_INFO_ADDRESS_ONLINE_NOHOST
	このユーザは現在接続しています。
NICK_INFO_TIME_REGGED
	　　　　　登録日時：%s
NICK_INFO_LAST_SEEN
	　　　前回使用日時：%s
NICK_INFO_LAST_QUIT
	前回切断メッセージ：%s
NICK_INFO_URL
	　　　ホームページ：%s
NICK_INFO_EMAIL
	電子メールアドレス：%s
NICK_INFO_OPTIONS
	　　　　オプション：%s
NICK_INFO_LINKED_TO
	　　　　　リンク先：%s
# These strings MUST NOT be empty
NICK_INFO_OPT_KILL
	ニック保護
NICK_INFO_OPT_SECURE
	セキュア
NICK_INFO_OPT_PRIVATE
	プライベート
NICK_INFO_OPT_NONE
	無し
NICK_INFO_NO_EXPIRE
	このニックの登録は切れません。
NICK_INFO_SUSPEND_DETAILS
	このニックは %s により使用停止中です。
	停止日時：%s（%s）
NICK_INFO_SUSPEND_REASON
	停止理由：%s
NICK_INFO_SHOW_ALL
	詳細情報を見る場合は、「/msg %s INFO %s ALL」を入力して下さい。

# LIST応答
NICK_LIST_SYNTAX
	LIST パターン
NICK_LIST_SERVADMIN_SYNTAX
	LIST パターン [FORBIDDEN] [NOEXPIRE] [SUSPENDED]
NICK_LIST_HEADER
	%s に一致するニック：
NICK_LIST_RESULTS
	LIST 終了（%d/%d個）。

# RECOVER応答
NICK_RECOVER_SYNTAX
	RECOVER ニック [パスワード]
NICK_NO_RECOVER_SELF
	自分をリカバーできません。
NICK_RECOVERED
	ニックを使用していたユーザを切断しました。
	１分間のタイムアウトが経つ前にニックを使用したい場合は、
	「/msg %s RELEASE %s」を入力して下さい。

# RELEASE応答
NICK_RELEASE_SYNTAX
	RELEASE ニック [パスワード]
NICK_RELEASE_NOT_HELD
	%s は保留されていません。
NICK_RELEASED
	%s を解放しました。

# GHOST応答
NICK_GHOST_SYNTAX
	GHOST ニック [パスワード]
NICK_NO_GHOST_SELF
	自分を切断できません。
NICK_GHOST_KILLED
	%s のゴーストを切断しました。

# GETPASS応答
NICK_GETPASS_SYNTAX
	GETPASS ニック
NICK_GETPASS_UNAVAILABLE
	パスワードは暗号化されていますので GETPASS は使用できません。
NICK_GETPASS_PASSWORD_IS
	%s のパスワードは %s です。

# FORBID応答
NICK_FORBID_SYNTAX
	FORBID ニック
NICK_FORBID_SUCCEEDED
	%s を使用禁止にしました。
NICK_FORBID_FAILED
	%s を使用禁止にするのが失敗しました。

# SUSPEND responses
NICK_SUSPEND_SYNTAX
	SUSPEND [+期限] ニック 理由
NICK_SUSPEND_SUCCEEDED
	%s 及びそれにリンクされている全てのニックを使用停止にしました。
NICK_SUSPEND_ALREADY_SUSPENDED
	%s は既に使用停止になっています。

# UNSUSPEND responses
NICK_UNSUSPEND_SYNTAX
	UNSUSPEND ニック
NICK_UNSUSPEND_SUCCEEDED
	%s の使用停止を解除しました。
NICK_SUSPEND_NOT_SUSPENDED
	%s は使用停止になっていません。

###########################################################################
#
# ChanServ messages
#
###########################################################################

# アクセスレベルの説明文
CHAN_LEVEL_AUTOOP
	チャンネルに入ると +o モード
CHAN_LEVEL_AUTOVOICE
	チャンネルに入ると +v モード
CHAN_LEVEL_AUTODEOP
	+o モード禁止
CHAN_LEVEL_AUTODEOP_HALFOP
	+o、+h モード禁止
CHAN_LEVEL_NOJOIN
	RESTRICTED であればチャンネルに入れない
CHAN_LEVEL_INVITE
	INVITE コマンドが使える
CHAN_LEVEL_AKICK
	AKICK コマンドが使える
CHAN_LEVEL_SET
	SET（FOUNDER・PASSWORD 以外）が使える
CHAN_LEVEL_CLEAR
	CLEAR コマンドが使える
CHAN_LEVEL_UNBAN
	UNBAN コマンドが使える
CHAN_LEVEL_OPDEOP
	OP・DEOP コマンドが使える
CHAN_LEVEL_ACCESS_LIST
	アクセス一覧を表示できる
CHAN_LEVEL_ACCESS_CHANGE
	アクセス一覧を変更できる
CHAN_LEVEL_MEMO
	メモを読める
CHAN_LEVEL_VOICE
	VOICE・DEVOICE コマンドが使える
CHAN_LEVEL_AUTOHALFOP
	チャンネルに入ると +h モード
CHAN_LEVEL_HALFOP
	HALFOP・DEHALFOP コマンドが使える

# 自動メッセージ
CHAN_IS_REGISTERED
	このチャンネルは登録されています。
CHAN_NOT_ALLOWED_OP
	%s で +o モードにはなれません。
CHAN_MAY_NOT_BE_USED
	このチャンネルは使用禁止です。
CHAN_NOT_ALLOWED_TO_JOIN
	このチャンネルには入れません。

# 多用応答
CHAN_BOUNCY_MODES
	そのコマンドは現在使えません。

# REGISTER応答
CHAN_REGISTER_SYNTAX
	REGISTER チャンネル パスワード 説明
CHAN_REGISTER_DISABLED
	チャンネルの登録はただ今出来ません。
CHAN_REGISTER_NOT_LOCAL
	ローカルチャンネルの登録は出来ません。
CHAN_MUST_REGISTER_NICK
	チャンネルを登録するには、まずニックを登録しなければなりません。ニック登録情報を見るには「/msg %s HELP」を入力して下さい。
CHAN_MUST_IDENTIFY_NICK
	チャンネルを登録するには、ニックのパスワードを入力する必要があります。「/msg %s IDENTIFY パスワード」を入力して下さい。
CHAN_MAY_NOT_BE_REGISTERED
	%s は使用禁止ですので登録できません。
CHAN_ALREADY_REGISTERED
	%s は既に登録されています。
CHAN_MUST_BE_CHANOP
	チャンネルを登録するには、そのオペレータでなければなりません。
CHAN_REACHED_CHANNEL_LIMIT
	チャンネル登録数の上限（%d）に達していますので登録できません。
CHAN_EXCEEDED_CHANNEL_LIMIT
	チャンネル登録数の上限（%d）を超えていますので登録できません。
CHAN_REGISTRATION_FAILED
	登録は失敗しました。
CHAN_REGISTERED
	%s を登録しました。
CHAN_PASSWORD_IS
	チャンネルのパスワードは %s です。忘れないようにして下さい。

# IDENTIFY応答
CHAN_IDENTIFY_SYNTAX
	IDENTIFY チャンネル パスワード
CHAN_IDENTIFY_FAILED
	IDENTIFYは失敗しました。
CHAN_IDENTIFY_SUCCEEDED
	正しいパスワードです。

# DROP応答
CHAN_DROP_SYNTAX
	DROP チャンネル
CHAN_DROP_DISABLED
	チャンネルの消去はただ今出来ません。
CHAN_DROPPED
	%s の登録を消去しました。

# SET応答
CHAN_SET_SYNTAX
	SET チャンネル オプション パラメータ
CHAN_SET_DISABLED
	チャンネルのオプション設定はただ今出来ません。
CHAN_SET_UNKNOWN_OPTION
	%s というオプションはありません。

# SET FOUNDER応答
CHAN_SET_FOUNDER_TOO_MANY_CHANS
	%s はチャンネル登録数の上限を越えていますのでファウンダーに設定できません。
CHAN_FOUNDER_CHANGED
	%s のファウンダーを %s に変更しました。

# SET SUCCESSOR応答
#@@@: 「次期ファウンダー」？ (also see UNSET)
CHAN_SUCCESSOR_CHANGED
	%s の次期ファウンダーを %s に変更しました。
CHAN_SUCCESSOR_IS_FOUNDER
	ファウンダと次期ファウンダ両方に同じニックを設定することはできません。

# SET PASSWORD応答
CHAN_SET_PASSWORD_FAILED
	パスワードの変更は失敗しました。
CHAN_PASSWORD_CHANGED
	%s のパスワードを変更しました。
CHAN_PASSWORD_CHANGED_TO
	%s のパスワードを %s に変更しました。

# SET DESC応答
CHAN_DESC_CHANGED
	%s の説明は「%s」に変更しました。

# SET URL応答
CHAN_URL_CHANGED
	%s のホームページのアドレスを %s に設定しました。

# SET EMAIL応答
CHAN_EMAIL_CHANGED
	%s の電子メールのアドレスを %s に設定しました。

# SET ENTRYMSG応答
CHAN_ENTRY_MSG_CHANGED
	%s の加入時メッセージを設定しました。

# SET TOPIC応答
CHAN_SET_TOPIC_FAILED
	トピックの変更は失敗しました。

# SET MLOCK応答
CHAN_SET_MLOCK_KEY_REQUIRED
	モードロック +k にはパラメータが必要です。
CHAN_SET_MLOCK_LIMIT_REQUIRED
	モードロック +l にはパラメータが必要です。
CHAN_SET_MLOCK_LIMIT_POSITIVE
	モードロック +l には正数のパラメータが必要です。
CHAN_SET_MLOCK_UNKNOWN_CHAR
	%c というモードは分かりません。
CHAN_MLOCK_CHANGED
	%s のモードロックを %s に設定しました。
CHAN_MLOCK_REMOVED
	%s のモードロックを解除しました。

# SET KEEPTOPIC応答
CHAN_SET_KEEPTOPIC_SYNTAX
	SET チャンネル KEEPTOPIC {ON | OFF}
CHAN_SET_KEEPTOPIC_ON
	トピック記録設定を有効に設定しました。
CHAN_SET_KEEPTOPIC_OFF
	トピック記録設定を無効に設定しました。

# SET TOPICLOCK応答
CHAN_SET_TOPICLOCK_SYNTAX
	SET channel TOPICLOCK {ON | OFF}
CHAN_SET_TOPICLOCK_ON
	トピックロック設定を有効に設定しました。
CHAN_SET_TOPICLOCK_OFF
	トピックロック設定を無効に設定しました。

# SET PRIVATE応答
CHAN_SET_PRIVATE_SYNTAX
	SET channel PRIVATE {ON | OFF}
CHAN_SET_PRIVATE_ON
	プライベート設定を有効に設定しました。
CHAN_SET_PRIVATE_OFF
	プライベート設定を無効に設定しました。

# SET SECUREOPS応答
CHAN_SET_SECUREOPS_SYNTAX
	SET channel SECUREOPS {ON | OFF}
CHAN_SET_SECUREOPS_ON
	+o モード制限設定を有効に設定しました。
CHAN_SET_SECUREOPS_OFF
	+o モード制限設定を無効に設定しました。

# SET LEAVEOPS応答
CHAN_SET_LEAVEOPS_SYNTAX
	SET channel LEAVEOPS {ON | OFF}
CHAN_SET_LEAVEOPS_ON
	+o モード放置設定を有効に設定しました。
CHAN_SET_LEAVEOPS_OFF
	+o モード放置設定を無効に設定しました。

# SET RESTRICTED応答
CHAN_SET_RESTRICTED_SYNTAX
	SET channel RESTRICTED {ON | OFF}
CHAN_SET_RESTRICTED_ON
	アクセス制限設定を有効に設定しました。
CHAN_SET_RESTRICTED_OFF
	アクセス制限設定を無効に設定しました。

# SET SECURE応答
CHAN_SET_SECURE_SYNTAX
	SET channel SECURE {ON | OFF}
CHAN_SET_SECURE_ON
	セキュア設定を有効に設定しました。
CHAN_SET_SECURE_OFF
	セキュア設定を無効に設定しました。

# SET OPNOTICE応答
CHAN_SET_OPNOTICE_SYNTAX
	SET channel OPNOTICE {ON | OFF}
CHAN_SET_OPNOTICE_ON
	OP 周知設定を有効に設定しました。
CHAN_SET_OPNOTICE_OFF
	OP 周知設定を無効に設定しました。

# SET NOEXPIRE応答
CHAN_SET_NOEXPIRE_SYNTAX
	SET channel NOEXPIRE {ON | OFF}
CHAN_SET_NOEXPIRE_ON
	%s というチャンネルの登録は切れません。
CHAN_SET_NOEXPIRE_OFF
	%s というチャンネルの登録は切れます。

# UNSET responses
CHAN_SUCCESSOR_UNSET
	%s の次期ファウンダー設定を解除しました。
CHAN_URL_UNSET
	%s のホームページアドレスを消去しました。
CHAN_EMAIL_UNSET
	%s の電子メールアドレスを消去しました。
CHAN_ENTRY_MSG_UNSET
	%s の加入時メッセージを消去しました。

# ACCESS messages
CHAN_ACCESS_SYNTAX
	ACCESS チャンネル {ADD|DEL|LIST} [ニック [レベル] | エントリ番号]
CHAN_ACCESS_DISABLED
	アクセス一覧の変更はただ今不可能です。
CHAN_ACCESS_LEVEL_NONZERO
	アクセスレベルはゼロに設定できません。
CHAN_ACCESS_LEVEL_RANGE
	アクセスレベルの許容範囲は、%d〜%dです。
CHAN_ACCESS_NICKS_ONLY
	アクセス一覧に追加できるのは登録されたニックのみです。
CHAN_ACCESS_REACHED_LIMIT
	アクセス一覧のニック数は上限（%d）に達していますので追加できません。
CHAN_ACCESS_LEVEL_UNCHANGED
	%s の %s でのアクセスレベルはすでに %d となっています。
CHAN_ACCESS_LEVEL_CHANGED
	%s の %s でのアクセスレベルを %d に変更しました。
CHAN_ACCESS_ADDED
	%s を %s のアクセス一覧に、レベル %d で追加しました。
CHAN_ACCESS_NO_SUCH_ENTRY
	%d 番のエントリーは %s のアクセス一覧に存在しません。
CHAN_ACCESS_NO_MATCH
	%s に一致するエントリーは %s のアクセス一覧に存在しません。
CHAN_ACCESS_NOT_FOUND
	%s は %s のアクセス一覧に存在しません。
CHAN_ACCESS_DELETED
	%s を %s のアクセス一覧から消去しました。
CHAN_ACCESS_DELETED_ONE
	%s のアクセス一覧からエントリーを 1 個消去しました。
CHAN_ACCESS_DELETED_SEVERAL
	%s のアクセス一覧からエントリーを %d 個消去しました。
CHAN_ACCESS_LIST_EMPTY
	%s のアクセス一覧は空です。
CHAN_ACCESS_LIST_HEADER
	%s のアクセス一覧：

# AKICK応答
CHAN_AKICK_SYNTAX
	AKICK チャンネル {ADD | DEL | LIST} [ニック・マスク]
CHAN_AKICK_DISABLED
	自動キック一覧の変更はただ今できません。
CHAN_AKICK_ALREADY_EXISTS
	%s は既に %s の自動キック一覧に存在しています。
CHAN_AKICK_REACHED_LIMIT
	自動キック一覧のマスク数は上限（%d）に達していますので追加できません。
CHAN_AKICK_ADDED
	%s を %s の自動キック一覧に追加しました。
CHAN_AKICK_NO_SUCH_ENTRY
	%d 番のエントリーは %s の自動キック一覧で存在しません。
CHAN_AKICK_NO_MATCH
	%s に一致するエントリーは %s の自動キック一覧で存在しません。
CHAN_AKICK_NOT_FOUND
	%s は %s の自動キック一覧で存在しません。
CHAN_AKICK_DELETED
	%s を %s の自動キック一覧から消去しました。
CHAN_AKICK_DELETED_ONE
	%s の自動キック一覧からエントリーを 1 個消去しました。
CHAN_AKICK_DELETED_SEVERAL
	%s の自動キック一覧からエントリーを %d 個消去しました。
CHAN_AKICK_LIST_EMPTY
	%s の自動キック一覧は空です。
CHAN_AKICK_LIST_HEADER
	%sの自動キック一覧：
CHAN_AKICK_LIST_FORMAT
	  %3d %s%s

# LEVELS応答
CHAN_LEVELS_SYNTAX
	LEVELS チャンネル {SET | DIS[ABLE] | LIST | RESET} [項目 [レベル]]
CHAN_LEVELS_RANGE
	レベルは、%d〜%d の数値を入力して下さい。
CHAN_LEVELS_CHANGED
	%s のレベルを %s で %d に変更しました。
CHAN_LEVELS_UNKNOWN
	%s という項目はありません。項目一覧を見る場合は、「/msg %s HELP LEVELS DESC」を入力して下さい。
CHAN_LEVELS_DISABLED
	%s を %s で無効にしました。
CHAN_LEVELS_LIST_HEADER
	%s のレベル一覧：
CHAN_LEVELS_LIST_DISABLED
	    %-*s  無効
CHAN_LEVELS_LIST_FOUNDER
	    %-*s  ファウンダーのみ
CHAN_LEVELS_LIST_NORMAL
	    %-*s  %d
CHAN_LEVELS_RESET
	%s のレベル表を既定値に戻しました。

# INFO応答
CHAN_INFO_SYNTAX
	INFO channel
CHAN_INFO_HEADER
	%sの情報：
CHAN_INFO_FOUNDER
	　　　ファウンダー：%s (%s)
CHAN_INFO_NO_FOUNDER
	　　　ファウンダー：%s
CHAN_INFO_DESCRIPTION
	　　　　　　　説明：%s
CHAN_INFO_TIME_REGGED
	　　　　　登録日時：%s
CHAN_INFO_LAST_USED
	　　　前回使用日時：%s
CHAN_INFO_LAST_TOPIC
	　　前回のトピック：%s
CHAN_INFO_TOPIC_SET_BY
	　トピックの設定者：%s
CHAN_INFO_URL
	　　　ホームページ：%s
CHAN_INFO_EMAIL
	電子メールアドレス：%s
CHAN_INFO_OPTIONS
	　　　　オプション：%s
CHAN_INFO_OPT_PRIVATE
	プライベート
CHAN_INFO_OPT_KEEPTOPIC
	トピック記録
CHAN_INFO_OPT_TOPICLOCK
	トピックロック
CHAN_INFO_OPT_SECUREOPS
	+o モード制限
CHAN_INFO_OPT_LEAVEOPS
	+o モード放置
CHAN_INFO_OPT_RESTRICTED
	アクセス制限
CHAN_INFO_OPT_SECURE
	セキュア
CHAN_INFO_OPT_NONE
	無し
CHAN_INFO_MODE_LOCK
	　　　モードロック：%s

# LIST応答
CHAN_LIST_SYNTAX
	LIST パターン
CHAN_LIST_HEADER
	%s に一致するチャンネル：
CHAN_LIST_FORMAT
	    %-20s  %s
CHAN_LIST_END
	LIST 終了。

# INVITE応答
CHAN_INVITE_SYNTAX
	INVITE チャンネル

# OP/DEOP/VOICE/DEVOICE応答
CHAN_OPVOICE_SYNTAX
	%s チャンネル ニック

# UNBAN応答
CHAN_UNBAN_SYNTAX
	UNBAN チャンネル
CHAN_UNBANNED
	あなたに対する %s の追放マスクを消去しました。

# CLEAR応答
CHAN_CLEAR_SYNTAX
	CLEAR チャンネル 項目
CHAN_CLEARED_BANS
	%s の追放マスクを全て消去しました。
CHAN_CLEARED_MODES
	%s のモードを既定値に戻しました。
CHAN_CLEARED_OPS
	+o モードを %s から消去しました。
CHAN_CLEARED_VOICES
	+v モードを %s から消去しました。
CHAN_CLEARED_USERS
	%s のユーザを全てキックしました。

# GETPASS応答
CHAN_GETPASS_SYNTAX
	GETPASS チャンネル
CHAN_GETPASS_UNAVAILABLE
	パスワードは暗号化されていますので GETPASS は使用できません。
CHAN_GETPASS_PASSWORD_IS
	%s のパスワードは %s です。

# FORBID応答
CHAN_FORBID_SYNTAX
	FORBID チャンネル
CHAN_FORBID_SUCCEEDED
	%s を使用禁止にしました。
CHAN_FORBID_FAILED
	%s を使用禁止にするのが失敗しました。

###########################################################################
#
# MemoServのメッセージ
#
###########################################################################

# 自動メッセージ
MEMO_HAVE_NEW_MEMO
	新着メモが 1 件あります。
MEMO_HAVE_NEW_MEMOS
	新着メモが %d 件あります。
MEMO_TYPE_READ_LAST
	読むには「/msg %s READ LAST」を入力して下さい。
MEMO_TYPE_READ_NUM
	読むには「/msg %s READ %d」を入力して下さい。
MEMO_TYPE_LIST_NEW
	表示するには「/msg %s LIST NEW」を入力して下さい。
MEMO_AT_LIMIT
	注意：メモ数の上限（%d）に達しています。メモを消去するまで新たなメモは届きません。
MEMO_OVER_LIMIT
	注意：メモ数の上限（%d）を超えています。メモを消去するまで新たなメモは届きません。
MEMO_NEW_MEMO_ARRIVED
	%s からメモが届きました。
	読むには「/msg %s READ %d」を入力して下さい。

# 多用応答
MEMO_HAVE_NO_MEMOS
	メモはありません。
MEMO_X_HAS_NO_MEMOS
	%s はメモがありません。
MEMO_DOES_NOT_EXIST
	%d 番のメモは存在しません。
MEMO_LIST_NOT_FOUND
	%s に一致するメモはありません。

# SEND応答
MEMO_SEND_SYNTAX
	SEND {ニック | チャンネル} テキスト
MEMO_SEND_DISABLED
	メモの送信はただ今できません。
MEMO_SEND_PLEASE_WAIT
	SEND コマンドを再入力する前に %d 秒お待ち下さい。
MEMO_X_HAS_TOO_MANY_MEMOS
	%s は現在メモが多すぎますので新たなメモを受信できません。
MEMO_X_GETS_NO_MEMOS
	%s はメモを受信できません。
MEMO_SENT
	%s にメモを送信しました。

# LIST応答
MEMO_LIST_SYNTAX
	LIST [チャンネル] [リスト | NEW]
MEMO_HAVE_NO_NEW_MEMOS
	新着メモはありません。
MEMO_X_HAS_NO_NEW_MEMOS
	%s は新着メモがありません。
MEMO_LIST_MEMOS
	%s のメモ一覧。読むには「/msg %s READ num」
MEMO_LIST_NEW_MEMOS
	%s の新着メモ一覧。読むには「/msg %s READ num」
MEMO_LIST_CHAN_MEMOS
	%s のメモ一覧。読むには「/msg %s READ %s num」
MEMO_LIST_CHAN_NEW_MEMOS
	%s の新着メモ一覧。読むには「/msg %s READ %s num」
MEMO_LIST_HEADER
	 番号   差出人            日時
MEMO_LIST_FORMAT
	%c%4d   %-16s  %s

# READ応答
MEMO_READ_SYNTAX
	READ [チャンネル] {リスト | LAST | NEW}
MEMO_HEADER
	%d 番のメモ（%s、%s）。消去するには「/msg %s DEL %d」
MEMO_CHAN_HEADER
	%d 番のメモ（%s、%s）。消去するには「/msg %s DEL %s %d」
MEMO_TEXT
	%s

# DEL応答
MEMO_DEL_SYNTAX
	DEL [チャンネル] {番号 | リスト | ALL}
MEMO_DELETED_NONE
	入力した番号に一致するメモはありません。
MEMO_DELETED_ONE
	%d 番のメモを消去しました。
MEMO_DELETED_SEVERAL
	メモを %d 件消去しました。
MEMO_DELETED_ALL
	メモを全て消去しました。

# SET応答
MEMO_SET_SYNTAX
	SET オプション パラメータ
MEMO_SET_DISABLED
	メモのオプション設定はただ今できません。
MEMO_SET_UNKNOWN_OPTION
	%s というオプションはありません。

# SET NOTIFY応答
MEMO_SET_NOTIFY_SYNTAX
	SET NOTIFY {ON | LOGON | NEW | OFF}
MEMO_SET_NOTIFY_ON
	%s はログオンする時に新着メモがあれば知らせ、メモが届く時にも知らせます。
MEMO_SET_NOTIFY_LOGON
	%s はログオンする時とIRCに戻る時に、新着メモがあれば知らせます。
MEMO_SET_NOTIFY_NEW
	%s はメモが届く時に知らせます。
MEMO_SET_NOTIFY_OFF
	%s はメモの知らせをしません。

# SET LIMIT応答
MEMO_SET_LIMIT_SYNTAX
	SET LIMIT [チャンネル] 上限
MEMO_SET_LIMIT_SERVADMIN_SYNTAX
	SET LIMIT [ニック | チャンネル] {上限 | NONE} [HARD]
MEMO_SET_YOUR_LIMIT_FORBIDDEN
	メモ数の上限を変更できません。
MEMO_SET_LIMIT_FORBIDDEN
	%s のメモ数の上限を変更できません。
MEMO_SET_YOUR_LIMIT_TOO_HIGH
	メモ数の上限は、ゼロか %d 以下の正数に設定して下さい。
MEMO_SET_LIMIT_TOO_HIGH
	%s のメモ数の上限は、ゼロか %d 以下の正数に設定して下さい。
MEMO_SET_LIMIT_OVERFLOW
	上限は大きすぎますので、%d となります。
MEMO_SET_YOUR_LIMIT
	メモ数の上限を %d 件に設定しました。
MEMO_SET_YOUR_LIMIT_ZERO
	これからメモを受信しません。
MEMO_UNSET_YOUR_LIMIT
	メモ数の上限を無限に設定しました。
MEMO_SET_LIMIT
	%s のメモ数の上限を %d 件に設定しました。
MEMO_SET_LIMIT_ZERO
	%s のメモ数の上限を 0 件に設定しました。
MEMO_UNSET_LIMIT
	%s のメモ数の上限は無限に設定しました。

# INFO応答
MEMO_INFO_SYNTAX
	INFO [チャンネル]
MEMO_INFO_SERVADMIN_SYNTAX
	INFO [ニック | チャンネル]
MEMO_INFO_NO_MEMOS
	メモはありません。
MEMO_INFO_MEMO
	メモが 1 件あります。
MEMO_INFO_MEMO_UNREAD
	メモが 1 件あり、未読です。
MEMO_INFO_MEMOS
	メモが %d 件あります。
MEMO_INFO_MEMOS_ONE_UNREAD
	メモが %d 件あり、1 件は未読です。
MEMO_INFO_MEMOS_SOME_UNREAD
	メモが %d 件あり、%d 件は未読です。
MEMO_INFO_MEMOS_ALL_UNREAD
	メモが %d 件あり、全て未読です。
MEMO_INFO_LIMIT
	メモ数の上限は %d 件です。
MEMO_INFO_HARD_LIMIT
	メモ数の上限は %d 件で、変更できません。
MEMO_INFO_LIMIT_ZERO
	メモ数の上限は 0 件で、メモを受信できません。
MEMO_INFO_HARD_LIMIT_ZERO
	メモ数の上限は 0 件で、メモを受信できません。また、上限を変更できません。
MEMO_INFO_NO_LIMIT
	メモ数の上限はありません。
MEMO_INFO_X_NO_MEMOS
	%s はメモがありません。
MEMO_INFO_X_MEMO
	%s はメモが 1 件あります。
MEMO_INFO_X_MEMO_UNREAD
	%s はメモが 1 件あり、未読です。
MEMO_INFO_X_MEMOS
	%s はメモが %d 件あります。
MEMO_INFO_X_MEMOS_ONE_UNREAD
	%s はメモが %d 件あり、1 件は未読です。
MEMO_INFO_X_MEMOS_SOME_UNREAD
	%s はメモが %d 件あり、%d 件は未読です。
MEMO_INFO_X_MEMOS_ALL_UNREAD
	%s はメモが %d 件あり、全て未読です。
MEMO_INFO_X_LIMIT
	%s のメモ数の上限は %d 件です。
MEMO_INFO_X_HARD_LIMIT
	%s のメモ数の上限は %d 件で、変更できません。
MEMO_INFO_X_NO_LIMIT
	%s のメモ数の上限はありません。

###########################################################################
#
# OperServのメッセージ
#
###########################################################################

# 多用メッセージ
OPER_BOUNCY_MODES
	Servicesはモードを変更できません。サーバーの設定を確認して下さい。
OPER_BOUNCY_MODES_U_LINE
	Servicesはモードを変更できません。サーバーの「U:ライン」の設定を確認して下さい。

# GLOBAL応答
OPER_GLOBAL_SYNTAX
	GLOBAL メッセージ

# STATS応答
OPER_STATS_UNKNOWN_OPTION
	%s というSTATSのオプションはありません。
OPER_STATS_CURRENT_USERS
	現在ユーザ数：%d
	オペレータ数：%d
OPER_STATS_MAX_USERS
	最大ユーザ数：%d（%s）
OPER_STATS_UPTIME_DHMS
	起動から：%d%s%02d時間%02d分
OPER_STATS_UPTIME_HM_MS
	起動から：%02d%s%02d%s
OPER_STATS_USER_MEM
	ユーザ　　：%6dレコード・%5dキロバイト
OPER_STATS_CHANNEL_MEM
	チャンネル：%6dレコード・%5dキロバイト
OPER_STATS_NICKSERV_MEM
	DogTag　：%6dレコード・%5dキロバイト
OPER_STATS_CHANSERV_MEM
	ChanServ　：%6dレコード・%5dキロバイト
OPER_STATS_OPERSERV_MEM
	OperServ　：%6dレコード・%5dキロバイト
OPER_STATS_AKILL_COUNT
	自動切断マスク数：%d
OPER_STATS_AKILL_EXPIRE_DAYS
	自動切断マスクの既定有効期間：%d日
OPER_STATS_AKILL_EXPIRE_DAY
	自動切断マスクの既定有効期間：%d日
OPER_STATS_AKILL_EXPIRE_HOURS
	自動切断マスクの既定有効期間：%d時間
OPER_STATS_AKILL_EXPIRE_HOUR
	自動切断マスクの既定有効期間：%d時間
OPER_STATS_AKILL_EXPIRE_MINS
	自動切断マスクの既定有効期間：%d分
OPER_STATS_AKILL_EXPIRE_MIN
	自動切断マスクの既定有効期間：%d分
OPER_STATS_AKILL_EXPIRE_NONE
	自動切断マスクの既定有効期間：無し

# MODE応答
OPER_MODE_SYNTAX
	MODE チャンネル モード

# CLEARMODES応答
OPER_CLEARMODES_SYNTAX
	CLEARMODES チャンネル [ALL]
OPER_CLEARMODES_DONE
	%s のバイナリモードと追放マスクをクリアしました。
OPER_CLEARMODES_ALL_DONE
	%s のモードを全てクリアしました。

# KICK応答
OPER_KICK_SYNTAX
	KICK チャンネル ニック 理由

# ADMIN応答
OPER_ADMIN_SYNTAX
	ADMIN {ADD | DEL | LIST} [ニック]
OPER_ADMIN_ADD_SYNTAX
	ADMIN ADD ニック
OPER_ADMIN_DEL_SYNTAX
	ADMIN DEL ニック
OPER_ADMIN_SKELETON
	Services はスケレトンモードで動いているため、ADMIN コマンドは使用できません。
OPER_ADMIN_EXISTS
	%s は既に Services のアドミン表で存在しています。
OPER_ADMIN_ADDED
	%s を Services のアドミン表に追加しました。
OPER_ADMIN_TOO_MANY
	Services のアドミン表はいっぱいですので追加できません。
OPER_ADMIN_REMOVED
	%s を Services のアドミン表から消去しました。
OPER_ADMIN_NOT_FOUND
	%s は Services のアドミン表に存在しません。
OPER_ADMIN_LIST_HEADER
	Services のアドミン表：

# OPER応答
OPER_OPER_SYNTAX
	OPER {ADD | DEL | LIST} [nick]
OPER_OPER_ADD_SYNTAX
	OPER ADD nick
OPER_OPER_DEL_SYNTAX
	OPER DEL nick
OPER_OPER_SKELETON
	Services はスケレトンモードで動いているため、OPER のコマンドは使用できません。
OPER_OPER_EXISTS
	%s は既に Services のオペレータ表で存在しています。
OPER_OPER_ADDED
	%s を Services のオペレータ表に追加しました。
OPER_OPER_TOO_MANY
	Services のオペレータ表はいっぱいですので追加できません。
OPER_OPER_REMOVED
	%s を Services のオペレータ表から消去しました。
OPER_OPER_NOT_FOUND
	%s は Services のオペレータ表で存在しません。
OPER_OPER_LIST_HEADER
	Services のオペレータ表：

# AKILL応答
OPER_AKILL_SYNTAX
	AKILL {ADD | DEL | LIST | VIEW} [[+有効期間] マスク [理由]]
OPER_AKILL_ADD_SYNTAX
	AKILL ADD [+有効期間] マスク 理由
OPER_AKILL_DEL_SYNTAX
	AKILL DEL マスク
OPER_AKILL_NO_NICK
	注意：自動切断マスクにはニックを入れてはいけません。マスクを確認して下さい。
OPER_TOO_MANY_AKILLS
	自動切断表はいっぱいですので追加できません。
OPER_AKILL_ADDED
	%s を自動切断表に追加しました。
OPER_AKILL_REMOVED
	%s を自動切断表から消去しました。
OPER_AKILL_NOT_FOUND
	%s は自動切断表で存在しません。
OPER_AKILL_LIST_HEADER
	自動切断表：
# mask, reason
OPER_AKILL_LIST_FORMAT
	%-32s  %s
# mask, set-by, set-time, expires, reason
OPER_AKILL_VIEW_FORMAT
	%s (%s に %s に追加され、%s)
	    %s

# SET応答
OPER_SET_SYNTAX
	SET オプション名 パラメータ
OPER_SET_IGNORE_ON
	ユーザ無視処理は動作します。
OPER_SET_IGNORE_OFF
	ユーザ無視処理は動作しません。
OPER_SET_IGNORE_ERROR
	IGNORE のパラメータは ON か OFF にして下さい。
OPER_SET_READONLY_ON
	Services はこれからリードオンリー（読み取り専用）モードで動作します。
OPER_SET_READONLY_OFF
	Services はこれからリードライト（通常）モードで動作します。
OPER_SET_READONLY_ERROR
	READONLY のパラメータは、ON か OFF にして下さい。
OPER_SET_DEBUG_ON
	Services はこれからデバッグモードで動作します。
OPER_SET_DEBUG_OFF
	Services はこれから通常（デバッグなし）モードで動作します。
OPER_SET_DEBUG_LEVEL
	Services はこれからデバーグモードで動作します。
OPER_SET_DEBUG_ERROR
	DEBUG のパラメータは、ON、OFF または正数にして下さい。
OPER_SET_UNKNOWN_OPTION
	%s というオプションはありません。

# JUPE応答
OPER_JUPE_SYNTAX
	JUPE サーバ名 [理由]

# RAW応答
OPER_RAW_SYNTAX
	RAW テキスト

# UPDATE応答
OPER_UPDATING
	データベースを保存しています。

# IGNORE応答
OPER_IGNORE_LIST
	Servicesのイグノア表：
OPER_IGNORE_LIST_EMPTY
	Servicesのイグノア表は空です。

###########################################################################
#
# 案内システムのメッセージ
#
###########################################################################

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
NEWS_LOGON_TEXT
	（ログオン案内  %s） %s
NEWS_OPER_TEXT
	（オペレータ案内  %s） %s

NEWS_LOGON_SYNTAX
	LOGONNEWS {ADD|DEL|LIST} [text|num]
NEWS_LOGON_ADD_SYNTAX
	LOGONNEWS ADD text
NEWS_LOGON_DEL_SYNTAX
	LOGONNEWS DEL {num | ALL}
NEWS_LOGON_LIST_HEADER
	ログオン案内表：
NEWS_LOGON_LIST_ENTRY
	%5d (%s  %s)
	    %s
NEWS_LOGON_LIST_NONE
	ログオン案内件はありません。
NEWS_LOGON_ADD_FULL
	ログオン案内表は満杯です。
NEWS_LOGON_ADDED
	新ログオン案内件（%d番）を追加しました。
NEWS_LOGON_DEL_NOT_FOUND
	%d 番目のログオン案内件は存在しません。
NEWS_LOGON_DELETED
	%d 番目のログオン案内件は消去されました。
NEWS_LOGON_DEL_NONE
	ログオン案内件はありません。
NEWS_LOGON_DELETED_ALL
	ログオン案内件は全て消去されました。

NEWS_OPER_SYNTAX
	OPERNEWS {ADD|DEL|LIST} [text|num]
NEWS_OPER_ADD_SYNTAX
	OPERNEWS ADD text
NEWS_OPER_DEL_SYNTAX
	OPERNEWS DEL {num | ALL}
NEWS_OPER_LIST_HEADER
	オペレータ案内表：
NEWS_OPER_LIST_ENTRY
	%5d (%s  %s)
	    %s
NEWS_OPER_LIST_NONE
	オペレータ案内件はありません。
NEWS_OPER_ADD_FULL
	オペレータ案内表は満杯です。
NEWS_OPER_ADDED
	新オペレータ案内件（%d番）を追加しました。
NEWS_OPER_DEL_NOT_FOUND
	%d 番目のオペレータ案内件は存在しません。
NEWS_OPER_DELETED
	%d 番目のオペレータ案内件は消去されました。
NEWS_OPER_DEL_NONE
	オペレータ案内件はありません。
NEWS_OPER_DELETED_ALL
	オペレータ案内件は全て消去されました。

NEWS_HELP_LOGON
	シンタクス：LOGONNEWS ADD text
	　　　　　　LOGONNEWS DEL {num | ALL}
	　　　　　　LOGONNEWS LIST
	
	ログオン案内表の編集と表示のコマンドです。ユーザはネット
	ワークに接続と、Services はこのメッセージをユーザに送りま
	す。ただし、メッセージが４つ以上の場合、ユーザに大量のメッ
	セージを送らないように最新の３つだけを送ります。
	
	LOGONNEWS LIST という形で、IRC オペレータはログオン案内表
	を表すことが出来ますが、ADD・DEL の編集コマンドを使うのは
	Services のアドミンのみです。

NEWS_HELP_OPER
	シンタクス：OPERNEWS ADD text
	　　　　　　OPERNEWS DEL {num | ALL}
	　　　　　　OPERNEWS LIST
	
	オペレータ案内表の編集と表示のコマンドです。ユーザが
	IRC オペレータになると、Services はこのメッセージをユー
	ザーに送ります。ただし、メッセージが４つ以上の場合、ユー
	ザーに大量のメッセージを送らないように最新の３つだけを送り
	ます。
	
	OPERNEWS LIST という形で、IRC オペレータはログオン案内表
	を表すことが出来ますが、ADD・DEL の編集コマンドを使うのは
	Services のアドミンのみです。

###########################################################################
#
# DogTagのヘルプメッセージ
#
###########################################################################

NICK_HELP
	%S は、ニックの登録サービスです。このサービスを使い
	ニックを登録すれば、他のユーザはそのニックを使えなくなり
	ます。ただし、ニックを%d日間使わないと登録は切れてしまいま
	す。次のコマンドでニックを登録やオプションの変更が出来ます。
	コマンドを使う場合は「/msg %S command」を入力して下
	さい。コマンドのヘルプを読む場合は、「/msg %S HELP
	command」を入力して下さい。
	
	    REGISTER   ニックの登録
#@@@ 「identify」
	    IDENTIFY   パスワードでidentifyする
	    ACCESS     アクセス一覧の変更
	    LINK       他のニックにリンクを作る
	    SET        オプションの設定
	    DROP       登録の消去
	    RECOVER    ニックを使用しているユーザを切断する
	    RELEASE    RECOVER を使ってからニックを使用可能にする
	
	他のコマンド：UNLINK・UNSET・GHOST・INFO・LIST・LISTCHANS・
	              STATUS
	
	警告：このサービスは、ユーザの身元を守る為のサービスです。
	ニックの「盗み」等の悪用のためのサービスではありませんので、
	そのような行為はおやめ下さい。

NICK_HELP_EXPIRE_ZERO
	%S は、ニックの登録サービスです。このサービスを使い
	ニックを登録すれば、他のユーザはそのニックを使えなくなり
	ます。次のコマンドでニックを登録やオプションの変更が出来ま
	す。コマンドを使う場合は「/msg %S command」を入力して
	下さい。コマンドのヘルプを読む場合は、「/msg %S HELP
	command」を入力して下さい。
	
	    REGISTER   ニックの登録
#@@@ 「identify」
	    IDENTIFY   パスワードでidentifyする
	    ACCESS     アクセス一覧の変更
	    LINK       他のニックにリンクを作る
	    SET        オプションの設定
	    DROP       登録の消去
	    RECOVER    ニックを使用しているユーザを切断する
	    RELEASE    RECOVER を使ってからニックを使用可能にする
	
	他のコマンド：UNLINK・UNSET・GHOST・INFO・LIST・LISTCHANS・
	              STATUS
	
	警告：このサービスは、ユーザの身元を守る為のサービスです。
	ニックの「盗み」等の悪用のためのサービスではありませんので、
	そのような行為はおやめ下さい。

NICK_HELP_REGISTER
	シンタクス：REGISTER password email
	
	現在使用しているニックを%Sのデータベースに登録します。
	ニックを登録してから、SET・ACCESS等のコマンドでニックのオ
	プションの変更が出来ます。ただし、設定を変更するのにはパス
	ワードが必要ですので、登録するときに選んだパスワードをよく
	覚えておいて下さい。また、ニックやチャンネルと違って、パス
	ワードで大文字と小文字は違います。例えば、FIDO・Fido・fido
	等は全て違います。
	
	登録時に電子メールアドレスも登録できます。登録しなかった場
	合でも、SET EMAILコマンドを使って後で登録することもできま
	す。
	
	パスワードを選ぶときは、不明な方のパスワードにして下さい。
	お名前・ニック等のような当てやすいパスワードはお止め下さい。
	４文字以下のパスワードは何でも当てやすい方ですので、５文字
	以上のパスワードにして下さい。なお、パスワードでスペースを
	使えません。一方、日本語（仮名と漢字）でパスワードを入力す
	ることも出来ます。

NICK_HELP_IDENTIFY
	シンタクス：IDENTIFY password
	
#@@@  「証拠」など・ChanServのもある
	%Sにニックの保有者である証拠を示します。このコマンド
	を使わなければ、ほとんどのServicesのコマンドは使えません。
	passwordはREGISTERのコマンドを入力したときのと同じパスワー
	ドです。

NICK_HELP_DROP
	シンタクス：DROP
	
	%Sのデータベースからニックを消去します。消去したニッ
	クは、誰でも再登録が出来ます。
	
	このコマンドを使うのには、パスワードを入力する必要がありま
	す。パスワードの入力のヘルプを見るのには、
	「/msg %S HELP IDENTIFY」を入力して下さい。

NICK_HELP_ACCESS
	シンタクス：ACCESS ADD mask
	　　　　　　ACCESS DEL mask
	　　　　　　ACCESS LIST
	
	ニックのアクセス一覧の変更と表示のコマンドです。アクセス一覧と
	は、保有者のユーザアドレス（user@hostというアドレス）のリ
	ストです。ユーザのアドレスはアクセス一覧のマスクの一つに合
	えば、%Sに切断されません。また、SECUREというオプションをOFF
	にすればパスワードを入力せずにServicesのコマンドを使えます。
	
	例：
	    ACCESS ADD achurch@*.dragonfire.net
	        dragonfire.netというドメーンのホストからachurchとい
	        うユーザをアクセス一覧に追加します。
	
	    ACCESS DEL achurch@*.dragonfire.net
	        前の例と逆の結果です。
	
	    ACCESS LIST
	        アクセス一覧を表します。

#NICK_HELP_LINK
#	シンタクス：LINK nick password
#	
#	nickというニックにリンクを作り、現在のニックを入力したニッ
#	クの仮名にします。このコマンドを使うと、現在のニックのアク
#	セス表は消え、メモは入力したニックのメモ表に追加されます
#	（それで入力したニックのメモ表がメモの数の限りを過ぎること
#	もありますのでご注意下さい）。
#	
#	リンクが作られてから、現在のニックはServicesのデータベース
#	で入力したニックに変化します。%SのUNLINKとDROPのコマ
#	ンド以外、全てのServicesのコマンドは現在のニックの代わりに
#	リンクされたニックを使います。例えば、リンクされたニックの
#	メモを見たい場合は、どちらのニックでも見られます。そして、
#	他のユーザからメモを受ける場合は、そのユーザはどちらの
#	ニックに送っても同じメモ表に追加されます。また、チャンネル
#	のアクセス一覧でどちらかのニックが存在していれば、どちらの
#	ニックでも同じ特権を得ます。
#	
#	このコマンドを使うのには、パスワードを入力する必要がありま
#	す。なお、リンクしたいニックのパスワードをこのコマンドのパ
#	ラメーターとして入力する必要があります。

NICK_HELP_UNLINK
	シンタクス：UNLINK [nick password]
	
	ニックのリンクを消去します。このコマンドを使うと、リンクさ
	れていたニックのアクセス一覧とオプションの設定は現在のニック
	にコピーされますが、メモはコピーされません。
	
	このコマンドを使うのには、パスワードを入力する必要がありま
	す。パスワードの入力のヘルプを見るのには、「/msg %S
	HELP IDENTIFY」を入力して下さい。
	
	別のニックのリンクを消去したい時は、そのニックとパスワード
	を入力すれば消去できます。

NICK_HELP_SET
	シンタクス：SET option parameters
	
	ニックのオプションを設定します。optionの選択は次の通りです。
	
	    PASSWORD   パスワードの変更
	    LANGUAGE   Servicesが使う言語の設定
	    URL        ホームページのアドレスの入力
	    EMAIL      電子メールのアドレスの入力
#@@@  切断「オプション」、それと「守」...？
	    KILL       切断オプションの入切
	    SECURE     セキュアオプションの入切
	    PRIVATE    LISTのコマンドからニックを隠す
	    HIDE       INFOのコマンドからニックの情報を隠す
	
	このコマンドを使うのには、パスワードを入力する必要がありま
	す。パスワードの入力のヘルプを見るのには、「/msg %S
	HELP IDENTIFY」を入力して下さい。
	
	オプションの情報を読むのには、「/msg %S HELP SET option」を
	入力して下さい。

NICK_HELP_SET_PASSWORD
	シンタクス：SET PASSWORD new-password
	
	ニックの保有者のパスワードを変更します。

NICK_HELP_SET_LANGUAGE
	シンタクス：SET LANGUAGE number
	
	Servicesが使う言語を設定します。numberの選択は次の通りです。
	

NICK_HELP_SET_URL
	シンタクス：SET URL url
	
	urlというホームページのアドレスをニックの情報に追加します。
	このアドレスはINFOのコマンドの情報で表れます。

NICK_HELP_SET_EMAIL
	シンタクス：SET EMAIL address
	
	addressという電子メールのアドレスをニックの情報に追加します。
	このアドレスはINFOのコマンドの情報で表れます。

NICK_HELP_SET_KILL
	シンタクス：SET KILL {ON | QUICK | IMMED | OFF}
	
	ニックの切断オプションを設定します。ONにすると、他のユー
	ザーがニックを使おうとすれば、%Sに警告され、一分以内
	でニックを変えないと切断されます。QUICKにすると、ニックを変
	える時限は20秒になります。IMMEDにすると、%Sは警告せず
	にユーザを切断しますので、必要な場合にしかこの選択にしな
	いで下さい。なお、この選択はネットの運営者により使用不可能
	なこともあります。

NICK_HELP_SET_SECURE
	シンタクス：SET SECURE {ON | OFF}
	
	セキュアオプションを設定します。ONにすると、ユーザアドレ
	スがアクセス一覧に存在していてもパスワードを入力しなければ保
	有者の特権を得ません。ただし、ユーザアドレスがアクセス一覧
	にあれば、切断オプションがオンに設定されても切断されません。

NICK_HELP_SET_PRIVATE
	シンタクス：SET PRIVATE {ON | OFF}
	
	「私的」というオプションを設定します。ONにすると、ニックは
	「/msg %S LIST」のリストで表れません。ただし、ONにし
	てもニックを知っているユーザはINFOのコマンドでニックの情
	報を見ることが出来ます。

NICK_HELP_SET_HIDE
	シンタクス：SET HIDE {EMAIL | USERMASK | QUIT} {ON | OFF}
	
	ニックの情報を%SのINFOのコマンドから隠します。隠せる
	のは、電子メールのアドレス（EMAIL）、前のユーザアドレス
	（USERMASK）、前の切断メッセージ（QUIT）です。二番目のパラ
	メーターは、ONにすると情報を隠し、OFFにすると情報を表しま
	す。

NICK_HELP_RECOVER
	シンタクス：RECOVER nickname [password]
	
	他のユーザにニックが取られたらそのニックを取り戻します。
#@@@  切断守の「ある」
	このコマンドを使うと、切断守が設定してあるニックから一分以
	内でニックを変えない場合と同じ結果が出ます。ニックを使用し
	ているユーザを切断してから、%Sはそのニックを取り、
	一分間誰も使えなくなります。その一分がたってからニックを取
	り戻せます。それと、%SのRELEASEのコマンドを使えば一
	分が経つ前に取り戻せます。
	
	RECOVERのコマンドを使うのには、現在のユーザアドレスが
	nicknameというニックのアクセス一覧にある必要があります。また、
	パスワードを入力すればニックを取り戻せます。

NICK_HELP_RELEASE
	シンタクス：RELEASE nickname [password]
	
#@@@  「ホルド」
	ニックのホルドを解放します。ニックを使用していたユーザが
	切断されてから、ニックは一分間使えなくなります。その一分が
	たつ前にニックを使用したい場合はこのコマンドを使うのです。
	
	RELEASEのコマンドを使うのには、現在のユーザアドレスが
	nicknameというニックのアクセス一覧にある必要があります。また、
	パスワードを入力すればニックのホルドが解放されます。

NICK_HELP_GHOST
	シンタクス：GHOST nickname [password]
	
	「ゴースト」という接続を切断します。ゴーストは、本当に存在
	していない接続のことです。普通は、ゴーストが出るのはパソコ
	ンがフレーズしたりモデムの接続が切断されたりするときです。
	もちろん、ゴーストだけでなく普通のユーザもこのコマンドで
	切断できますが、多くのIRCクライアントは切断されたらすぐ再接
	続しますので、このコマンドを使ってもニックを取り戻せないこ
	ともあります。その場合は、RECOVERのコマンドを使って下さい。
	
	GHOSTのコマンドを使うのには、現在のユーザアドレスが
	nicknameというニックのアクセス一覧にある必要があります。また、
	パスワードを入力すればゴーストを切断できます。

NICK_HELP_INFO
	シンタクス：INFO nickname
	
	nicknameというニックの情報（保有者の名前・ユーザアドレス、
	前の使用した日時、オプションの設定など）を表します。

NICK_HELP_LIST
	シンタクス：LIST pattern
	
	patternに合うニックとそのニックのユーザアドレスを表しま
	す。ただし、私的オプションが ON のニックは表れません。
	patternをnick!user@hostという形で入力して下さい。
	
	例：
	    LIST *!joeuser@foo.com
	        joeuser@foo.comが保有しているニックを表します。
	    LIST *Bot*!*@*
	        「Bot」を含むニックを表します。
	    LIST *!*@*.bar.org
	        bar.orgのユーザが保有しているニックを表します。

NICK_HELP_STATUS
	シンタクス：STATUS nickname...
	
#@@@ 名状・ChanServにもある
	nicknameというニックを使用しているユーザはそのニックの保
	有者であるかそうでないかということを表示します。応答はこの
	形です：
	
	    nickname status-code
	
	nicknameはコマンドを入力したときと同じニックで、status-code
	は次の数値の一つです。
	
	    0 - ユーザは現在接続していないか、ニックは登録されて
	        　　いない
	    1 - ユーザは保有者ではないか、セキュアオプションは入
	        　　に設定されていてユーザはパスワードを入力して
	        　　いない
	    2 - ユーザのアドレスはアクセス一覧にあり、セキュアオプ
	        　　ションはオフに設定されている
	    3 - ユーザはIDENTIFYでパスワードを入力した
	
	コマンドずつにニックを16以下を入力できますが、17以上の場合
	とニックを入力しない場合にはエラーメッセージは出ません。

NICK_SERVADMIN_HELP
	
	Servicesのアドミンは次のコマンドも使えます。
	
	    GETPASS    ニックのパスワードを見る
	               　　（暗号化が使われていない場合のみ）
	    FORBID     ニックを使用不可能にする
	
	なお、Servicesのアドミンはパスワードを入力せずにニックの登
	録を消去することもアクセス一覧を見ることも出来ます。アクセス
	表を見るのには「/msg %S ACCESS LIST nick」という形を
	使うのです。

NICK_SERVADMIN_HELP_DROP
	シンタクス：DROP [nickname]
	
	パラメータがない場合は、現在使用しているニックを%S
	のデータベースから消去します。
	
	パラメータがある場合は、入力したニックをデータベースから
	消去します。この使い方を使えるのはServicesのアドミンのみで
	す。

NICK_SERVADMIN_HELP_SET
	
	ServicesのアドミンはNOEXPIREというオプションを設定できます。
	このオプションでニックの登録を切れなくすることが出来ます。
	なお、Servicesのアドミンはパスワードを入力せずにどのニック
	でもオプションを設定できます。他のニックのオプションを設定
	する場合は「SET nickname option parameters」という形です。

NICK_SERVADMIN_HELP_SET_NOEXPIRE
	シンタクス：SET NOEXPIRE [nickname] {ON | OFF}
	
	nicknameというニックの登録は切れるかを設定します。ONにする
	と、登録は切れません。ニックを入力しない場合は、自分のニッ
	クのオプションを設定します。
	
	このコマンドの使用はServicesのアドミンに限っています。

NICK_SERVADMIN_HELP_UNLINK
	
	Servicesのアドミンは、パスワードを入力せずにどのニックのリン
	クでも消去できます。

NICK_SERVADMIN_HELP_LISTLINKS
	シンタクス：LISTLINKS nickname [ALL]
	
	入力したニックにリンクしているニックを表します。ALL を入力す
	ると、対象ニックと同じ権利を持っているニックを全て表し、入力
	しない場合は、対象ニックがリンクの直接対象になっているニック
	だけを表します。
	
	このコマンドの使用はServicesのアドミンに限っています。

NICK_SERVADMIN_HELP_LIST
	シンタクス：LIST pattern [FORBIDDEN] [NOEXPIRE]
	
	patternに合うニックとそのニックのユーザアドレスを表しま
	す。ただし、私的オプションのONのニックはServicesのアドミン
	にしか表れません。patternをnick!user@hostという形で入力
	して下さい。
	
	また、Servicesのアドミンにのみ、登録の切れないニックの頭に
	「!」印が表れます。
	
	FORBIDDEN または NOEXPIRE を追加すれば、リストに表れるニッ
	クを制限することが出来ます。FORBIDDEN の場合は使用禁止ニッ
	ク、NOEXPIRE の場合は登録の切れないニックが表れます。両方
	を入力すれば、両方のタイプのニックが表れます。ただし、この
	オプションを使うのはServicesのアドミンのみです。
	
	例：
	    LIST *!joeuser@foo.com
	        joeuser@foo.comが保有しているニックを表します。
	    LIST *Bot*!*@*
	        「Bot」を含むニックを表します。
	    LIST * NOEXPIRE
	        登録の切れないニックを全て表します。

NICK_SERVADMIN_HELP_GETPASS
	シンタクス：GETPASS nickname
	
	nicknameというニックのパスワードを表示します。このコマンド
	を使うと、コマンドを入力したユーザのニックとパスワードを
	出したニックを含むメッセージはロッグされ、WALLOPSかGLOBOPS
	でオペレータに放送されます。
	
	このコマンドの使用はServicesのアドミンに限っています。
	
	暗号化が使われている場合は、このコマンドを使えません。

NICK_SERVADMIN_HELP_FORBID
	シンタクス：FORBID nickname
	
	ニックを使用不可能にします。キャンセルにはDROPのコマンドが
	使えます。
	
	このコマンドの使用はServicesのアドミンに限っています。

###########################################################################
#
# ChanServのヘルプメッセージ
#
###########################################################################

#CHAN_HELP
#	%Sは、チャンネルの登録サービスです。このサービスを使
#	ってチャンネルを登録すれば、チャンネルのアクセスを制御出来
#	るし、色々なオプションも設定できます。チャンネルの登録や制
#	御のコマンドは次の通りです。コマンドを使う場合は、「/msg
#	%S command」を入力して下さい。また、コマンドのヘルプ
#	を読む場合は「/msg %S HELP command」を入力して下さい。
#	
#	    REGISTER   チャンネルの登録
#	    IDENTIFY   チャンネルのパスワードの入力
#	    SET        チャンネルのオプションの変更
#	    ACCESS     特権のユーザ表の変更
##@@@ 「追放」
#	    AKICK      追放したユーザ表の変更
#	    DROP       チャンネルの登録の消去
#	
#	他のコマンド：INFO・LIST・INVITE・OP・DEOP・UNBAN・CLEAR

CHAN_HELP_EXPIRES
	
	注意：登録したチャンネルは%d日間使用されないと、登録は切
	れます。

CHAN_HELP_REGISTER
	シンタクス：REGISTER channel password description
	
	%Sのデータベースでチャンネルを登録します。このコマン
	ドを使うのは、チャンネルのオペレータのみです。passwordは
	チャンネルのオプションを変更する為のパスワードです。最後の
	パラメータはチャンネルの名状です。
	
	チャンネルを登録すると、登録したユーザはそのチャンネルの
	「ファウンダー」になります。チャンネルのファウンダーは全て
	のチャンネルのオプションを変更出来るし、チャンネルに入ると
	%Sは自動的にファウンダーを+oモードにします。この特権
	の一部を他のユーザに上げたい場合は「/msg %S HELP
	ACCESS」を入力して下さい。
	
	注意：チャンネルを登録するのには、ニックを登録する必要があ
	ります。ニックを登録していないユーザは「/msg %s HELP」
	を入力して下さい。

CHAN_HELP_IDENTIFY
	シンタクス：IDENTIFY channel password
	
	%Sにチャンネルの保有者である証拠を示します。このコマ
	ンドを使わなければ、LEVELS・SET FOUNDER・SET PASSWORD・DROP
	のコマンドが使えません。なお、ファウンダーのニックを使用し
	ていないときは、このコマンドを入力すればファウンダーの特権
	を得ます。passwordはREGISTERのコマンドを入力したときのと
	同じパスワードです。

CHAN_HELP_DROP
	シンタクス：DROP channel
	
	channelというチャンネルを%Sのデータベースから消去します。
	このコマンドの使用はファウンダーに限っていて、パスワード
	を入力する必要もあります。

#CHAN_HELP_SET
#	シンタクス：SET channel option parameters
#	
#	チャンネルのオプションや情報を変更します。ファウンダーとパ
#	スワードを変更するのには、チャンネルのパスワードをIDENTIFY
#	のコマンドで入力する必要があります。オプションは次の通りで
#	す。
#	
#	    FOUNDER     ファウンダーの変更
#	    SUCCESSOR   次期ファウンダーの変更
#	    PASSWORD    パスワードの変更
#	    DESC        チャンネルの名状の変更
#	    URL         ホームページのアドレスの入力
#	    EMAIL       電子メールのアドレスの入力
#	    ENTRYMSG    チャンネルに入るときに出るメッセージの入力
#	    TOPIC       現在のチャンネルのトピックの変更
##@@@  「覚える」・下の「こと」、「というオプション」
#	    KEEPTOPIC   チャンネルが使用されていない間にもトピック
#	                　　を覚えることの入切
#	    TOPICLOCK   SET TOPICコマンドでしかトピックを変更させ
#	                　　ないというオプションの入切
#	    MLOCK       チャンネルのモードをオン・オフにロックする
#	    PRIVATE     LISTコマンドからチャンネルを隠す
#	    RESTRICTED  特権を持っていないユーザをチャンネルに入
#	                　　れないというオプションの入切
#	    SECURE      セキュアオプションの入切
#	    SECUREOPS   +oモードの制御を厳しくする
#	    LEAVEOPS	DEOPコマンドでしか-oモードを掛けない
#	    OPNOTICE	OP・DEOPコマンドが使われる度に報告
#	
#	オプションの情報を読むのには、「/msg %S HELP option」
#	を入力して下さい。

CHAN_HELP_SET_FOUNDER
	シンタクス：SET channel FOUNDER nick
	
	ファウンダーを変更します。ただし、nickというニックが登録
	されていないと変更出来ません。

CHAN_HELP_SET_SUCCESSOR
	シンタクス：SET channel SUCCESSOR nick
	
	次期ファウンダーを変更します。次期ファウンダーとは、現在の
	ファウンダーのニックの登録が切れたり消去されたりするとファウ
	ンダーになるユーザです。次期ファウンダーが設定されていない
	場合は、ファウンダーのニックの登録が切れると、チャンネルの登
	録も消去されてしまいます。ただし、ファウンダーのニックの登録
	が切れる時点で次期ファウンダーはチャンネルの限り（%d）を越え
	ていれば、次期ファウンダーが設定されていないようにチャンネル
	の登録は消えてしまいます。
	
	次期ファウンダーにするニック（nick）は登録していなければなり
	ません。

CHAN_HELP_SET_PASSWORD
	シンタクス：SET channel PASSWORD password
	
	ファウンダーのパスワードを変更します。

CHAN_HELP_SET_DESC
	シンタクス：SET channel DESC description
	
	チャンネルの名状を変更します。名状はLIST・INFOのコマンドの
	情報で表れます。

#CHAN_HELP_SET_URL
#	シンタクス：SET channel URL [url]
#	
#	urlというホームページのアドレスをチャンネルの情報に追加しま
#	す。このアドレスはINFOのコマンドの情報で表れます。パラメー
#	ターを入力しない場合は、ホームページのアドレスは消去されま
#	す。

#CHAN_HELP_SET_EMAIL
#	シンタクス：SET channel EMAIL [address]
#	
#	addressという電子メールのアドレスをチャンネルの情報に追加し
#	ます。このアドレスはINFOのコマンドの情報で表れます。パラ
#	メーターを入力しない場合は、電子メールのアドレスは消去され
#	ます。

#CHAN_HELP_SET_ENTRYMSG
#	シンタクス：SET channel ENTRYMSG [message]
#	
#	messageというテキストをチャンネルに入るユーザに出します。
#	パラメータを入力しない場合は、メッセージは消去されます。

CHAN_HELP_SET_TOPIC
	シンタクス：SET channel TOPIC topic
	
	%Sにチャンネルのトピックを変更させます。だいたい、
	SET LOCKTOPICのコマンドと一緒に使われます。

CHAN_HELP_SET_KEEPTOPIC
	シンタクス：SET channel KEEPTOPIC {ON | OFF}
	
	「トピック記録」というオプションを設定します。トピック記録
	は、チャンネルの現在のトピックを記録し、チャンネルが消えて
	もそのトピックを覚え、チャンネルがまた作られるときにトピッ
	クを戻すというオプションです。

CHAN_HELP_SET_TOPICLOCK
	シンタクス：SET channel TOPICLOCK {ON | OFF}
	
	「トピックロック」というオプションを設定します。ONにすると、
	トピックは%SのSET TOPICのコマンドでしか変えられなくなりま
	す。

CHAN_HELP_SET_MLOCK
	シンタクス：SET channel MLOCK modes
	
	モードロックを設定します。%Sによって、チャンネルの入
	切モード（i・k・l・m・n・p・s・t）をオンかオフにロックでき
	ます。modesというパラメータはIRCの「/MODE」というコマンド
	と同じ形で、「+」の後のモードはオンにロックされ、「-」の後
	のモードはオフにロックされます。
	
	注意：下の二番目の例のようにチャンネルキーをロックすれば、
	RESTRICTEDというオプションをオンにしなければ誰にでもキーが
	見えます。
	
	例：
	    SET #channel MLOCK +nt-iklps
	       n・tモードをオンにロックし、i・k・l・p・sモードをオ
	       フにロックします。mモードはロックされません。
	
	    SET #channel MLOCK +knst-ilmp my-key
	       k・n・s・tモードをオンにロックし、i・l・m・pモードを
	       オフにロックします。キーを「my-key」にロックします。
	
	    SET #channel MLOCK +
	       モードロックを解きます。

CHAN_HELP_SET_PRIVATE
	シンタクス：SET channel PRIVATE {ON | OFF}
	
	「私的」というオプションを設定します。ONにすると、チャンネ
	ルは「/msg %S LIST」のリストで表れません。

CHAN_HELP_SET_RESTRICTED
	シンタクス：SET channel RESTRICTED {ON | OFF}
	
	アクセス制御オプションを設定します。ONにすると、+oモードを
	得られないユーザ（負数のレベルのユーザ、そしてセキュア
	オプションをONにするとアクセス一覧にないユーザ）はチャンネ
	ルからに入れなくなります。

CHAN_HELP_SET_SECURE
	シンタクス：SET channel SECURE {ON | OFF}
	
	セキュアオプションを設定します。ONにすると、ニックのパス
	ワードを入力していないユーザは特権を得ません。アクセス制
	御オプションと一緒に使えば、パスワードを入力していないユー
	ザーはチャンネルに入れなくなります。

CHAN_HELP_SET_SECUREOPS
	シンタクス：SET channel SECUREOPS {ON | OFF}
	
	+oモードの制御を厳しくすることを設定します。ONにすると、ア
	クセス表にないユーザは+oモードを得られなくなります。

#CHAN_HELP_SET_LEAVEOPS
#	シンタクス：SET channel LEAVEOPS {ON | OFF}
#	
#	+oモードの制御をやさしくすることを設定します。ONにすると、
#	%Sは自動的に-oモードをかけません。

CHAN_HELP_SET_OPNOTICE
	シンタクス：SET channel LEAVEOPS {ON | OFF}
	
	OP・DEOP報告オプションを設定します。ONにすると、OPとDEOPコマ
	ンドが使用される度に、%Sはチャンネルにメッセージ（/NOTICE）
	を出します。

CHAN_HELP_ACCESS
	シンタクス：ACCESS channel ADD nick level
	　　　　　　ACCESS channel DEL {nick | entry-num | list}
	　　　　　　ACCESS channel LIST [mask | list]
	
	チャンネルのアクセス一覧の変更と表示のコマンドです。アクセス
	表は、特権のあるユーザのリストで、どのユーザが+oモード
	を得られるかどのユーザが%Sのコマンドを使えるか含み
	ます。level（レベル）の数値によってどの特権を得るか変わり
	ます。詳しい事なら、「/msg %S HELP ACCESS LEVELS」を
	入力して下さい。
	
	ACCESS ADDという形でユーザをアクセス一覧に追加できますが、
	すでにアクセス一覧に存在しているユーザのレベルを変更するこ
	とも出来ます。追加と変更出来るのは、コマンドを入力するユー
	ザーの現在のレベルを含まず、そのレベル以下のみです。また、
	ユーザのレベルを変更する場合は、そのユーザの現在のレベ
	ルは入力するユーザのレベル以上なら変更出来ません。ファウ
	ンダーならどのレベルでも追加できます。
	
	ACCESS DELという形でユーザをアクセス一覧から消去できます。
	消去出来るのは、入力するユーザのレベルを含まず、そのレベ
	ル以下のユーザのみです。番号列を入力することも出来ます
	（下記のLISTの例へ参照）。
	
	ACCESS LISTという形でアクセス一覧を見ることが出来ます。マスク
	を入力すれば、そのマスクに合うユーザしか表れません。下記の
	例の通り、番号列を入力することも出来ます：
	
	    ACCESS #channel LIST 2-5,7-9
	       ２〜５、７〜９番目のアクセス一覧のエントリーを表します。

CHAN_HELP_ACCESS_LEVELS
	チャンネルのアクセスレベル
	
	既定的なレベルは次の通りです。
	
	ファウンダー　　全ての%Sのコマンドを使える
	　　　　　　　　チャンネルに入ると自動的に+oモード
	　　　10　　　　自動的に+oモード
	　　　　　　　　AKICKのコマンドも使える
	       5　　　　自動的に+oモード
	       3　　　　自動的に+vモード
	       0　　　　特権無し
	　　　　　　　　オペレータから+oモードを得られる
	      -1以下　　+oモードを得られない
	
	このレベルを変えたり新しいレベルをつくったりすることが
	LEVELSのコマンドで出来ます。

CHAN_HELP_AKICK
	シンタクス：AKICK channel ADD mask [reason]
	　　　　　　AKICK channel DEL mask
	　　　　　　AKICK channel LIST [mask]
	
	「自動キック一覧」（オートキック表）を変更と表示のコマンドです。
	自動キック一覧にあるユーザがチャンネルに入ると、%Sはその
	ユーザを蹴り追放マスクを付けます。
	
	AKICK ADDという形で自動キック一覧にマスクとニックを追加できます。
	マスクなら、user@hostという形で入力して下さい。reason（理由）
	はキックメッセージで表れます。理由を入力しない場合は、「You
	have been banned from the channel」（チャンネルから追放され
	ました）になります。
	
	AKICK DELという形で自動キック一覧からマスクとニックを消去できま
	す。ただし、追放マスクがチャンネルに付いている場合は、その
	マスクは自動に解かれません。
	
	AKICK LISTという形で自動キック一覧を見ることが出来ます。マスクを
	入力すれば、そのマスクに合うエントリーしか表れません。

CHAN_HELP_LEVELS
	シンタクス：LEVELS channel SET type level
	　　　　　　LEVELS channel {DIS | DISABLE} type
	　　　　　　LEVELS channel LIST
	　　　　　　LEVELS channel RESET
	
	チャンネルのアクセスレベルの番号の意味を変更します。このコ
	マンドで%Sの自動的な作用とほとんどの%Sのコマン
	ドが使えるレベルのを設定できます。ただし、SET FOUNDER・SET
	PASSWORD・LEVELSのコマンドは、ファウンダーしか使えません。
	
	LEVELS SETという形で作用やコマンドのレベルを変更できます。
	LEVELS DISABLEという形（それとLEVELS DISという省略）で自動
	的な作用を停止することと、コマンドをファウンダー以外に禁制
	することが出来ます。LEVELS LISTという形で自動的な作用とコマ
	ンドのレベルを表示できます。LEVELS RESETという形でレベルを
	既定値に戻せます。
	
	type（作用の名前）の選択を見る場合は、「/msg %S HELP
	LEVELS DESC」を入力して下さい。

CHAN_HELP_LEVELS_DESC
	LEVELSの作用とコマンドの名前は次の通りです。
	注意：AUTODEOPとNOJOINは最大値で、他のは最小値です。

CHAN_HELP_LEVELS_DESC_FORMAT
	    %-*s  %s

CHAN_HELP_INFO
	シンタクス：INFO channel
	
	チャンネルの情報（ファウンダー、名状、登録の日時、モード
	ロック等）を表します。

CHAN_HELP_LIST
	シンタクス：LIST pattern
	
	patternに合うチャンネルを表します。ただし、私的オプション
	が ON のチャンネルは表れません。

CHAN_HELP_OP
	シンタクス：OP #channel nick
	
	チャンネルのユーザにオペレータにします。使用は既定的に
	レベル5以上に限っています。

CHAN_HELP_DEOP
	シンタクス：DEOP #channel nick
	
	チャンネルのユーザを-oモードにします。使用は既定的にレベ
	ル5以上に限っています。

#CHAN_HELP_INVITE
#	シンタクス：INVITE channel
#	
#	%Sに自分を誘わせます。使用は既定的にレベル1以上に限っ
#	ています。

#CHAN_HELP_UNBAN
#	シンタクス：UNBAN channel
#	
#	現在のユーザアドレスに合う追放マスクを解きます。使用は既
#	定的にレベル1以上に限っています。

#CHAN_HELP_CLEAR
#	シンタクス：CLEAR channel what
#	
#	チャンネルのあるモードをクリアしたり、ユーザを全て蹴った
#	りします。whatの選択は次の通りです。
#	
#	     modes   チャンネルの入切モード（i・k・l・m・n・p・s・t）
#	             　　をクリアする
#	     bans    追放マスクを全て解く
#	     ops     全てのユーザから+oモードをクリアする
#	     voices  全てのユーザから+vモードをクリアする
#	     users   全てのユーザをチャンネルから蹴る
#	
#	使用は既定的にレベル 10 以上に限っています。

#CHAN_SERVADMIN_HELP
#	
#	Servicesのアドミンは次のコマンドも使えます。
#	
#	    GETPASS    チャンネルのパスワードを見る
#	               　　（暗号化が使われていない場合のみ）
#	    FORBID     チャンネルを使用不可能にする
#	    STATUS     ユーザのチャンネルでのアクセスレベル
#	
#	なお、Servicesのアドミンはパスワードを入力せずにチャンネル
#	の登録を消去することも、アクセス一覧・自動キック一覧・レベル表を見
#	ることも出来ます。

CHAN_SERVADMIN_HELP_DROP
	シンタクス：DROP channel
	
	channelというチャンネルを%Sのデータベースから消去します。
	このコマンドの使用はファウンダーとServicesのアドミンに
	限っていて、Servicesのアドミンでなければパスワードを入力す
	る必要もあります。

CHAN_SERVADMIN_HELP_SET
	
	ServicesのアドミンはNOEXPIREというオプションを設定できます。
	このオプションでチャンネルの登録を切れなくすることが出来ま
	す。なお、Servicesのアドミンはパスワードを入力せずにチャン
	ネルのオプションを設定できます。

CHAN_SERVADMIN_HELP_SET_NOEXPIRE
	シンタクス：SET channel NOEXPIRE {ON | OFF}
	
	channelというチャンネルの登録は切れるかを設定します。ONにす
	ると、登録は切れません。
	
	このコマンドの使用はServicesのアドミンに限っています。

CHAN_SERVADMIN_HELP_LIST
	シンタクス：LIST pattern
	
	patternに合うチャンネルを表します。ただし、私的オプション
	を入したチャンネルはServicesのアドミンにしか表れません。

CHAN_SERVADMIN_HELP_GETPASS
	シンタクス：GETPASS channel
	
	channelというチャンネルのパスワードを表示します。このコマ
	ンドを使うと、コマンドを入力したユーザのニックとパスワー
	ドを出したチャンネルを含むメッセージはロッグされ、WALLOPSか
	GLOBOPSでオペレータに放送されます。
	
	このコマンドの使用はServicesのアドミンに限っています。
	
	暗号化が使われている場合は、このコマンドを使えません。

CHAN_SERVADMIN_HELP_FORBID
	シンタクス：FORBID channel
	
	ニックを使用不可能にします。キャンセルにはDROPのコマンドが
	使えます。
	
	このコマンドの使用はServicesのアドミンに限っています。

CHAN_SERVADMIN_HELP_STATUS
	シンタクス：STATUS channel nickname
	
	nicknameというニックのchannelというチャンネルでのアクセ
	スレベルを表示します。応答はこの形です：
	
	    STATUS channel nickname access-level
	
	エラーが発生した場合は、応答は次の形です：
	
	    STATUS ERROR error-message
	
	このコマンドの使用はServicesのアドミンに限っています。

###########################################################################
#
# MemoServのヘルプメッセージ
#
###########################################################################

#MEMO_HELP
#	%Sは、ユーザとチャンネルにメモを送るためのサービス
#	です。メモはServicesにより保存され、受信ニックかチャンネル
#	のオペレータは読みたい時に読めます。ただし、差出人のニッ
#	クも受信ニックかチャンネルも登録しなければ%Sを使えません。
#	
#	%Sのコマンドは次の通りです。
#	
#	    SEND   ユーザかチャンネルにメモを送る
#	    LIST   受信メモ表を表す
#	    READ   メモを読む
#	    DEL    メモを消去する
#	    SET    メモのオプションを設定する
#	
#	コマンドのヘルプを読む場合は、「/msg %S HELP command」
#	を入力して下さい。
#	
#	※チャンネルのメモが読めるのは既定的にレベル10以上のユーザ
#	　のみですが、%sの「LEVELS」というコマンドでそのレベルを変
#	　更できます。

MEMO_HELP_SEND
	シンタクス：SEND {nick | channel} memo-text
	
	nickかchannelにmemo-textを含むメモを送ります。ニックに出す
	場合には、受信者のニックオプションによって、%Sは受信
	者に新たなメモが届いたとのことを報告します。

MEMO_HELP_LIST
	シンタクス：LIST [channel] [list | NEW]
	
	受信メモ表を表します。NEWを入力すれば、読んでいないメモのみ
	が表れます。読んでいないメモは、メモの番号の左側に＊印が表
	示されます。下記の例の通り、番号列も入力可能：
	
	    LIST 2-5,7-9
	       ２〜５、７〜９番目のメモをリストします。

MEMO_HELP_READ
	シンタクス：READ [channel] {num | list | LAST | NEW}
	
	メモを読みます。番号を入力するとその番号のメモが表れ、LASTを
	入力すると最新のメモが表れ、NEWを入力すると読んでいないメモ
	が全て表れます。下記の例の通り、番号列も入力可能：
	
	    LIST 2-5,7-9
	       ２〜５、７〜９番目のメモをリストします。

MEMO_HELP_DEL
	シンタクス：DEL [channel] {num | list | ALL}
	
	メモを消去します。番号を入力するとその番号のメモが消去され、
	ALLを入力すると全てのメモが消去されます。
	
	例：
	   DEL 1
	      １番目のメモを消去します。
	   DEL 2-5,7-9
	      ２番目〜５番目と７番目〜９番目のメモを消去します。

MEMO_HELP_SET
	シンタクス：SET option parameters
	
	メモのオプションを設定します。optionの選択は次の通りです。
	
	    NOTIFY      どの場合に%Sが新メモの報告するかの設定
	                　（ニックのみ）
	    LIMIT       メモの数の限りの設定
	
	オプションの情報を読む場合は、「/msg %S HELP SET option」
	を入力して下さい。

MEMO_HELP_SET_NOTIFY
	シンタクス：SET NOTIFY {ON | LOGON | NEW | OFF}
	
	どの場合に%Sが新メモの報告するかの設定のコマンドです。
	設定の選択は次の通りです。
	
	    ON      ログオンするとき、IRCに戻るとき、メモが届くとき
	    LOGON   ログオンするとき、IRCに戻るとき
	    NEW     メモが届くとき
	    OFF     報告は無し
	
	ONの結果はLOGONとNEWの結果を合わせることと思えます。

MEMO_HELP_SET_LIMIT
	シンタクス：SET LIMIT [channel] limit
	
	メモの数の限りを設定します。ゼロにすると、メモを受けられな
	くなります。ただし、正数の場合は%d以下の数値しか入力できま
	せん。

MEMO_HELP_INFO
	シンタクス：INFO [channel]
	
	メモの情報を見ます。このコマンドで表れるのは、現在のメモの
	数と読んでいないメモの数とメモの数の限りです。パラメータ
	を入力すればそのチャンネルの情報が表れます。

MEMO_SERVADMIN_HELP_SET_LIMIT
	シンタクス：SET LIMIT [user | channel] {limit | NONE} [HARD]
	
	ユーザかチャンネルのメモの数の限りを設定します。ゼロにす
	るとユーザはメモを受けられなくなり、NONEにすると限りは無
	くなります。ニックを入力しない場合は、コマンドを出すユーザ
	ーのニックのメモの限りが設定されます。HARDを入力すれば、ユー
	ザーは限りを変更できなくなり、入力しなければユーザは限り
	を変更できます。
	
	この使い方が使えるのはServicesのアドミンのみです。一般の
	ユーザは、他のユーザの限りを設定できないし、限りをのけ
	られないし、HARDも入力できません。

MEMO_SERVADMIN_HELP_INFO
	シンタクス：INFO [nick | channel]
	
	メモの情報を見ます。このコマンドで表れるのは、現在のメモの
	数と読んでいないメモの数とメモの数の限りです。パラメータ
	がある場合にそのユーザかチャンネルの情報が表れ、パラメー
	ターが無い場合に自分の情報が表れます。
	
	ニックのパラメータを入力できるのはServicesのアドミンのみ
	です。

###########################################################################
#
# OperServのヘルプメッセージ
#
###########################################################################

#OPER_HELP
#	%Sのコマンドは次の通りです。
#	
#	一般のIRCのオペレータが使えるコマンド：
#	    GLOBAL      全てのユーザにメッセージを送る
#	    STATS       Servicesとネットのステータスを表す
#	    OPER LIST   Servicesのオペレータ表を表す
#	    ADMIN LIST  Servicesのアドミン表を表す
#	
#	Servicesのオペレータとアドミンだけが使えるコマンド：
#	    MODE        チャンネルのモードを変更する
#	    KICK        チャンネルからユーザをキックする
#	    AKILL       自動切断表を変更する
#	
#	Servicesのアドミンだけが使えるコマンド：
#	    OPER        Servicesのオペレータ表を変更する
#	    LOGONNEWS   ユーザが接続する時に出されるメッセージを
#	                　　作る
#	    OPERNEWS    ユーザがオペレータ（+oモード）になる時
#	                　　に出されるメッセージを作る
#	    JUPE        サーバーを「ジュピター」（接続拒否）する
#	    RAW         Servicesの接続サーバーにテキストを出す
#	    SET         Servicesのオプションの設定
#	    UPDATE      データベースを直接保存させる
#	    QUIT        Servicesを止める
#	    RESTART     Servicesを再起動させる
#	
#	Services root（スーパーユーザ）だけが使えるコマンド：
#	    ADMIN       Servicesのアドミン表を変更する
#	
#	注意：%Sに出されたコマンドは全てロッグされます。

OPER_HELP_GLOBAL
	シンタクス：GLOBAL message
	
	全てのネットに接続しているユーザにメッセージを出します。
	メッセージの指出ニックは%sです。

OPER_HELP_STATS
	シンタクス：STATS [AKILL | ALL]
	
	パラメータがない場合は、現在のユーザ数とオペレータ数、
	最大ユーザ数、起動からの時間を表します。
	
	AKILLというパラメータがある場合は、現在の自動切断マスクの
	数と既定的な寿命を表します。
	
	ALLというオプションが使えるのはServicesのアドミンのみです。
	このオプションを付けると、普通の情報（ユーザ数と起動から
#@@@ 「memory usage」の翻訳
	の時間）の下でServicesの使用しているメモリー量も表れます。
	この形を使うとServicesは少しの間フリーズしてしまいますので、
	ご注意下さい。
	
	「STATS」の代わりに「UPTIME」も使えます。

OPER_HELP_OPER
	シンタクス：OPER ADD nick
	　　　　　　OPER DEL nick
	　　　　　　OPER LIST
	
	Servicesのオペレータ表の変更と表示のコマンドです。このリ
	ストにあるユーザは、%sのIDENTIFYのコマンドでパスワー
	ドを入力すればServicesのオペレータのコマンドが使えます。
	
	誰でもOPER LISTという形が使えます。他の使用はServicesのアド
	ミンに限っています。

OPER_HELP_ADMIN
	シンタクス：ADMIN ADD nick
	　　　　　　ADMIN DEL nick
	　　　　　　ADMIN LIST
	
	Servicesのアドミン表の変更と表示のコマンドです。このリスト
	にあるユーザは、%sのIDENTIFYのコマンドでパスワード
	を入力すればServicesのアドミンのコマンドが使えます。
	
	誰でもADMIN LISTという形が使えます。他の使用はServices root
	に限っています。

OPER_HELP_MODE
	シンタクス：MODE channel modes
	
	チャンネルのモードを変更します。パラメータはIRCの「/MODE」
	のコマンドと同じです。
	
	このコマンドの使用はServicesのオペレータに限っています。

OPER_HELP_CLEARMODES
	シンタクス：CLEARMODES channel [ALL]
	
	チャンネルの入切モード（i・k・l・m・n・p・s・t）と追放マス
	クを全てクリアします。ALLというパラメータを入力すると、
	o・vモードもクリアされます。
	
	このコマンドの使用はServicesのオペレータに限っています。

OPER_HELP_KICK
	シンタクス：KICK channel user reason
	
	チャンネルからユーザをキックします。パラメータはIRCの
	/KICKというコマンドと同じですが、キックメッセージの前にこの
	コマンドを使ったユーザのニックが表れます。
#@@@ 例が必要
	
	このコマンドの使用はServicesのオペレータに限っています。

OPER_HELP_AKILL
	シンタクス：AKILL ADD [+expiry] mask reason
	　　　　　　AKILL DEL mask
	　　　　　　AKILL LIST [mask]
	　　　　　　AKILL VIEW [mask]
	
	「自動切断表」（オートキル表）の変更と表示のコマンドです。
	自動切断マスクに合うユーザが接続すると、Servicesはその
	ユーザを切断し、サーバーのプロトコルによってそのマスクを
	「K:ライン」にします。
	
	AKILL ADDという形でマスクを自動切断表に追加できます。
	reason（理由）は必要ですが、オペレータの為だけですので、
	切断されたユーザの切断メッセージに表れません。
	expiryを入力すれば、自動切断エントリーの寿命を指定できます。
	形は正数に時間の単位を指示する文字を付けます。単位の文字は
	「d」（日）、「h」（時間）、「m」（分）で、文字を付けないと
	日になります。ただし、文字を合わせること（「1h30m」など）は
	出来ません。「+0」にすれば、自動切断エントリーは切れません。
	寿命を入力しない場合は、既定寿命になります。STATS AKILLとい
	うコマンドでその既定値を表すことが出来ます。
	　※マスクは「+」で始まる場合は、寿命を入力しなければなりま
	　　せん。
	
	AKILL DELという形でマスクを自動切断表から消去できます。
	
	AKILL LISTという形で自動切断表を表せます。パラメータを入
	力すれば、そのマスクに合うエントリーしか表れません。
	
	AKILL VIEWという形でAKILL LISTのように自動切断表を表すこと
	が出来ますが、LISTより多くの情報（入力したユーザと日時、
	切れる日時）が出ます。
	
	このコマンドの使用はServicesのオペレータに限っています。

OPER_HELP_JUPE
	シンタクス：JUPE server [reason]
	
	サーバーを「ジュピター」します。ジュピター（jupiter）とは、
	サーバーをネットに接続させない為に仮サーバーを作リネットにつ
	なげることです。仮サーバーは「/SQUIT」というIRCのコマンドで
	消すことが出来ます。reason（理由）を入力すれば、その文字
	列は仮サーバーの/LINKSなどでサーバー情報として表れます。理由
	を入力しない場合は、サーバー名がサーバー情報として使用されま
	す。
	
	このコマンドの使用はServicesのアドミンに限っています。

OPER_HELP_RAW
	シンタクス：RAW text
	
	Servicesが接続しているサーバーにテキストを出します。IRCのプ
	ロトコルがはっきり分からずにこのコマンドを使ったり、入力で
	間違いをしてこのコマンドを出したりしてしまえば、ネットを狂
	わせることがありますので、充分ご注意下さい。
	
	このコマンドの使用はServicesのアドミンに限っています。

#OPER_HELP_SET
#	シンタクス：SET option setting
#	
#	Services全体のオプションを設定します。オプションの名前は次
#	の通りです。
#	    READONLY   リードオンリーモードの入切
#	    DEBUG      デバッグモードの入切
#	
#	このコマンドの使用はServicesのアドミンに限っています。

OPER_HELP_SET_READONLY
	シンタクス：SET READONLY {ON | OFF}
	
	リードオンリーモードを入切します。ONにすれば、ユーザは
	Servicesのデータを変更できなくなり、ニックとチャンネルの登
	録と消去も不可能になります。Servicesのオペレータとアドミ
	ンは自動切断表を変更でき、アドミンならニックとチャンネルを
	使用禁止にできますが、Servicesを消す（それと再起動する）前
	にリードオンリーモードをOFFにしなければその変更は保存されま
	せんので、ご注意下さい。
	
	このコマンドは「-readonly」というコマンドラインオプションと
	同じ結果を出します。

OPER_HELP_SET_DEBUG
	シンタクス：SET DEBUG {ON | OFF | num}
	
	デバッグモードを入切します。ONにすれば、Servicesが受けたり
	出したりするテキストと他のデバッグメッセージはロッグされま
	す。numという正数を入力すると、デバッグのレベルはnumに設定
	されます。
	
	このコマンドは「-debug」というコマンドラインオプションと同
	じ結果を出します。

OPER_HELP_UPDATE
	シンタクス：UPDATE
	
	Servicesのデータベースを直接保存させます。
	
	このコマンドの使用はServicesのアドミンに限っています。

OPER_HELP_QUIT
	シンタクス：QUIT
	
	データベースを保存せずにServicesを消します。このコマンド
	を使うべき場合は、データベースの狂いの恐れがある場合のみで
	す。他の場合は、SHUTDOWNのコマンドをお使い下さい。
	
	このコマンドの使用はServicesのアドミンに限っています。

OPER_HELP_SHUTDOWN
	シンタクス：SHUTDOWN
	
	データベースを保存してServicesを消します。
	
	このコマンドの使用はServicesのアドミンに限っています。

OPER_HELP_RESTART
	シンタクス：RESTART
	
	データベースを保存してServicesを再起動させます。
	
	このコマンドの使用はServicesのアドミンに限っています。


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

