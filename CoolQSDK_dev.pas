{
    This file is part of CoolQSDK for Pascal/Delphi
    Copyright (c) 2019 by Eric_Lian
 **********************************************************************}
{$IFDEF FPC}
	{$MODE DELPHI}
{$ENDIF}

{$I-}
{$h+}

unit CoolQSDK_dev;

interface
{$INCLUDE lib\CoolQ_variable.pas}
	// 下面的函数的确切含义请查阅lib文件夹下的文件。
	// lib\Tools.pas
	Function PtoS(a:PAnsiChar):ansistring;
	Function StoP(a:ansistring):PAnsiChar;
	Function NumToChar(a:int64):string;
	Function CharToNum(a:string):int64;
	Function RealToChar(a:real):string;
	Function CharToReal(a:string):real;
	Function RealToDisplay(a:real;b:longint):string;
	Function String_Choose(expression:boolean;a,b:ansistring):ansistring;
	Procedure Message_Replace(var a:ansistring;b,c:ansistring);
	Function UrlEncode(s:ansistring):ansistring;
	Function UrlDecode(s:ansistring):ansistring;
	// lib\CoolQ_Tools.pas
	Function Base64_Encryption(s:ansistring):ansistring;
	Function Base64_Decryption(s:ansistring):ansistring;
	// lib\CoolQ_CQapplication.pas
		// 酷Q码转义
	Function CQ_CharEncode(str:ansistring;Comma:boolean):ansistring;
	Function CQ_CharDecode(str:ansistring):ansistring;
		// 酷Q码封装
	function CQCode_Group_At(QQID:int64):ansistring;
	function CQCode_emoji(ID:int64):ansistring;
	function CQCode_face(ID:int64):ansistring;
	function CQCode_Shake:ansistring;
	function CQCode_anonymous(Force:boolean):ansistring;	
	function CQCode_image(url:ansistring):ansistring;
	function CQCode_Music(source:ansistring;musicid:int64;isnew:boolean):ansistring;
	function CQCode_Music_Custom(url,audio,title,content,image:ansistring):ansistring;
	function CQCode_Location(latitude,longitude:real;Zoom:longint;Name,Address:ansistring):ansistring;
	function CQCode_bface(ID:int64):ansistring;
	function CQCode_record(url:ansistring;magic:boolean):ansistring;
	function CQCode_rps(ID:int64):ansistring;
	function CQCode_dice(ID:int64):ansistring;
	function CQCode_share(url,title,Content,image:ansistring):ansistring;
	function CQCode_contact(t:ansistring;id:int64):ansistring;
		// 酷QAPI
	function CQ_i_sendPrivateMsg(QQID:int64;msg:ansistring):longint;				//Auth=106 //sendPrivateMsg
	function CQ_sendPrivateMsg(QQID:int64;msg:ansistring):longint;overload;			//Auth=106 //sendPrivateMsg
	function CQ_i_sendGroupMsg(groupid:int64;const msg:ansistring):longint;			//Auth=101 //sendGroupMsg
	function CQ_sendGroupMsg(groupid:int64;const msg:ansistring):longint;overload;	//Auth=101 //sendGroupMsg
	function CQ_i_sendDiscussMsg(DiscussID:int64;msg:ansistring):longint;			//Auth=103 //sendDiscussMsg
	function CQ_sendDiscussMsg(DiscussID:int64;msg:ansistring):longint;overload;	//Auth=103 //sendDiscussMsg
	function CQ_i_sendLike(QQID:int64):longint;overload;							//Auth=110 //sendLike
	function CQ_sendLike(QQID:int64):longint;overload;								//Auth=110 //sendLike
	function CQ_i_sendLike(QQID:int64;times:longint):longint;overload;				//Auth=110 //sendLike
	function CQ_sendLike(QQID:int64;times:longint):longint;overload;				//Auth=110 //sendLike
	function CQ_i_sendLikeV2(QQID:int64;times:longint):longint;						//Auth=110 //sendLike
	function CQ_sendLikeV2(QQID:int64;times:longint):longint;overload;				//Auth=110 //sendLike
	function CQ_i_getRecord(filename,format:ansistring):ansistring;					//Auth=30 接收消息中的语音(record),返回保存在 \data\record\ 目录下的文件名 //getRecord
	function CQ_getRecord(filename,format:ansistring):ansistring;overload;			//Auth=30 接收消息中的语音(record),返回保存在 \data\record\ 目录下的文件名 //getRecord		
	function CQ_Tools_TextToAnonymous(source:ansistring;Var Anonymous:CQ_Type_GroupAnonymous):boolean;
	Function CQ_Tools_TextToFile(source:ansistring;Var info:CQ_Type_GroupFile):boolean;
	Function CQ_i_GetCookies():ansistring;											//获取Cookies Auth=20 慎用,此接口需要严格授权 //getCookies
	Function CQ_GetCookies():ansistring;overload;									//获取Cookies Auth=20 慎用,此接口需要严格授权 //getCookies
	Function CQ_i_getCsrfToken():longint;											//获取CsrfToken Auth=20 即QQ网页用到的bkn/g_tk等 慎用,此接口需要严格授权 //getCsrfToken
	Function CQ_getCsrfToken():longint;overload;									//获取CsrfToken Auth=20 即QQ网页用到的bkn/g_tk等 慎用,此接口需要严格授权 //getCsrfToken
	Function CQ_i_GetLoginQQ():int64;												//取登陆QQ getLoginQQ
	Function CQ_GetLoginQQ():int64;overload;										//取登陆QQ getLoginQQ
	Function CQ_i_getLoginNick():ansistring;										//取登陆QQ昵称　getLoginNick
	Function CQ_getLoginNick():ansistring;overload;									//取登陆QQ昵称　getLoginNick
	Function CQ_i_GetStrangerInfo(QQ:int64;Var info:CQ_Type_QQ;nocache:boolean):longint;		//取陌生人信息 Auth=131 //CQ_getStrangerInfo
	Function CQ_GetStrangerInfo(QQ:int64;Var info:CQ_Type_QQ;nocache:boolean):longint;overload;	//取陌生人信息 Auth=131 //CQ_getStrangerInfo
	function CQ_i_getGroupMemberInfo(groupid,qqid:int64;Var info:CQ_Type_GroupMember;nocache:boolean):longint;	//取群成员信息 Auth=130 //getGroupMemberInfoV2
	function CQ_getGroupMemberInfo(groupid,qqid:int64;Var info:CQ_Type_GroupMember;nocache:boolean):longint;	//取群成员信息 Auth=130 //getGroupMemberInfoV2
	function CQ_i_getAppDirectory:ansistring;										//返回的路径末尾带"\" //getAppDirectory
	function CQ_getAppDirectory:ansistring;overload;								//返回的路径末尾带"\" //getAppDirectory
	function CQ_i_addLog(priority:longint;const category,content:ansistring):longint;			//成功返回日志ID	//addlog
	function CQ_addLog(priority:longint;const category,content:ansistring):longint;overload;	//成功返回日志ID	//addlog
	function CQ_i_setFriendAddRequest(const responseflag:pchar;responseoperation:longint;const remark:ansistring):longint;			//添加好友请求回复 Auth=150 //setFriendAddRequest
	function CQ_setFriendAddRequest(const responseflag:pchar;responseoperation:longint;const remark:ansistring):longint;overload;	//添加好友请求回复 Auth=150 //setFriendAddRequest
	function CQ_i_setGroupAnonymousMute(group:int64;fromAnonymous:ansistring;duration:int64):longint;	//置匿名群员禁言 Auth=124 //setGroupAnonymousBan
	function CQ_setGroupAnonymousMute(group:int64;fromAnonymous:ansistring;duration:int64):longint;		//置匿名群员禁言 Auth=124 //setGroupAnonymousBan
	function CQ_i_setGroupWholeMute(groupid:int64;enableban:boolean):longint;							//置全群禁言 Auth=123 //setGroupWholeBan
	function CQ_setGroupWholeMute(groupid:int64;enableban:boolean):longint;								//置全群禁言 Auth=123 //setGroupWholeBan
	function CQ_i_setGroupCard(group,qq:int64;nick:ansistring):longint;									//置群成员名片 Auth=126 //setGroupCard
	function CQ_setGroupCard(group,qq:int64;nick:ansistring):longint;overload;							//置群成员名片 Auth=126 //setGroupCard
	Function CQ_i_setGroupSpecialTitle(Group,ID:int64;Title:ansistring;duration:int64):longint;			//置群员专属头衔 Auth=128 需群主权限 //setGroupSpecialTitle
	Function CQ_setGroupSpecialTitle(Group,ID:int64;Title:ansistring;duration:int64):longint;overload;	//置群员专属头衔 Auth=128 需群主权限 //setGroupSpecialTitle
	Function CQ_i_setGroupAdmin(group,qq:int64;operation:boolean):longint;			//置群管理员 Auth=122 //setGroupAdmin
	Function CQ_setGroupAdmin(group,qq:int64;operation:boolean):longint;overload;	//置群管理员 Auth=122 //setGroupAdmin
	Function CQ_i_setGroupAnonymous(group:int64;operation:boolean):longint;			//置群匿名设置 Auth=125 //setGroupAnonymous
	Function CQ_setGroupAnonymous(group:int64;operation:boolean):longint;overload;	//置群匿名设置 Auth=125 //setGroupAnonymous
	Function CQ_i_setGroupAddRequest(responseflag:string;subtype:longint;responseoperation:longint;reason:string):longint;	//置群添加请求 Auth=151 //setGroupAddRequest
	Function CQ_setGroupAddRequest(responseflag:string;subtype:longint;responseoperation:longint;reason:string):longint;	//置群添加请求 Auth=151 //setGroupAddRequest
	Function CQ_i_setGroupLeave(group:int64;isdisband:boolean):longint;				//置群退出 Auth=127 慎用,此接口需要严格授权 //setGroupLeave
	Function CQ_setGroupLeave(group:int64;isdisband:boolean):longint;overload;		//置群退出 Auth=127 慎用,此接口需要严格授权 //setGroupLeave
	function CQ_i_setGroupMute(groupid,QQID,duration:int64):longint;				//置群员禁言 Auth=121 //setGroupBan
	function CQ_setGroupMute(groupid,QQID,duration:int64):longint;					//置群员禁言 Auth=121 //setGroupBan
	function CQ_i_setGroupKick(groupid,QQID:int64;rejectaddrequest:boolean):longint;		//置群员移除 Auth=120 //setGroupKick
	function CQ_setGroupKick(groupid,QQID:int64;rejectaddrequest:boolean):longint;overload;	//置群员移除 Auth=120 //setGroupKick
	function CQ_i_setDiscussLeave(DiscussID:int64):longint;							//置讨论组退出 Auth=140 //setDiscussLeave
	function CQ_setDiscussLeave(DiscussID:int64):longint;overload;					//置讨论组退出 Auth=140 //setDiscussLeave
	function CQ_i_setFatal(msg:ansistring):longint;									//置致命错误提示 //setFatal
	function CQ_setFatal(msg:ansistring):longint;overload;							//置致命错误提示 //setFatal
	function CQ_i_getGroupMemberList(GroupID:int64;Var GroupMemberList:CQ_Type_GroupMember_List):longint;			//取群成员列表 Auth=160 //getGroupMemberList
	function CQ_getGroupMemberList(GroupID:int64;Var GroupMemberList:CQ_Type_GroupMember_List):longint;overload;	//取群成员列表 Auth=160 //getGroupMemberList
	function CQ_i_getGroupList(Var GroupList:CQ_Type_GroupList):longint;			//取群列表 Auth=161  //getGroupList
	function CQ_getGroupList(Var GroupList:CQ_Type_GroupList):longint;overload;		//取群列表 Auth=161  //getGroupList
	function CQ_i_deleteMsg(msgID:int64):longint;									//撤回消息 Auth=180 //deleteMsg
	function CQ_deleteMsg(msgID:int64):longint;overload;							//撤回消息 Auth=180 //deleteMsg
		// 编码转换
	Function CoolQ_Tools_UTF8ToAnsi(Sstr:ansistring):ansistring;
	Function CoolQ_Tools_AnsiToUTF8(Sstr:ansistring):ansistring;
Var
	AuthCode:longint;
	//AuthCode CoolQ用来识别你是否是合法\调用的玩意儿
	CQAPPID		:ansistring='com.binkic.cqdemo';
	CQAPPINFO	:ansistring;
	
	GlobalUTF8Mode	:boolean;
	//请在应用主程序中修改APPID为你的APPID

implementation

uses math,sysutils,iconv; 

const
	Base64Chars='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
	Base64Table:array[0..63] of ansichar='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
var
	Base64DecoderTable:array[ansichar] of byte;

{$INCLUDE lib\Tools.pas}
{$INCLUDE lib\CoolQ_DllFunction.pas}
{$INCLUDE lib\CoolQ_Tools.pas}
{$INCLUDE lib\CoolQ_CQapplication.pas}

initialization
	InitBase64;
	GlobalUTF8Mode:=false;
end.
