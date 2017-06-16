{
    $Id: gplunit.pt,v 1.2 2002/09/07 15:40:47 peter Exp 2017/06/16 21:06:26 peter Exp $
    This file is part of CoolQSDK
    Copyright (c) 2017 by Eric_Lian



    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
unit CoolQSDK;

interface
{$INCLUDE lib\CoolQ_variable.pas}
	// 下面的函数的确切含义请查阅lib文件夹下的文件。
	// lib\Tools.pas
	Function PtoS(a:pchar):ansistring;
	Function StoP(a:ansistring):Pchar;
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
	function CQCode_Music(source:string;musicid:int64;isnew:boolean):ansistring;
	function CQCode_Music_Custom(url,audio,title,content,image:ansistring):ansistring;
	function CQCode_Location(latitude,longitude:real;Zoom:longint;Name,Address:ansistring):ansistring;
	function CQCode_bface(ID:int64):ansistring;
	function CQCode_record(url:ansistring;magic:boolean):ansistring;
	function CQCode_rps(ID:int64):ansistring;
	function CQCode_dice(ID:int64):ansistring;
	function CQCode_share(url,title,Content,image:ansistring):ansistring;
	function CQCode_contact(t:ansistring;id:int64):ansistring;
		// 酷QAPI
	function CQ_i_sendPrivateMsg(QQID:int64;msg:ansistring):longint;		
	function CQ_i_sendGroupMsg(groupid:int64;const msg:ansistring):longint;	
	function CQ_i_sendDiscussMsg(DiscussID:int64;msg:ansistring):longint;	
	function CQ_i_sendLike(QQID:int64):longint;								
	function CQ_i_sendLikeV2(QQID:int64;times:longint):longint;				
	function CQ_i_getRecord(filename,format:ansistring):ansistring;			
	function CQ_Tools_TextToAnonymous(source:ansistring;Var Anonymous:CQ_Type_GroupAnonymous):boolean;
	Function CQ_Tools_TextToFile(source:string;Var info:CQ_Type_GroupFile):boolean;
	Function CQ_i_GetCookies():ansistring;
	Function CQ_i_getCsrfToken():longint;
	Function CQ_i_GetLoginQQ():int64;
	Function CQ_i_getLoginNick():string;
	Function CQ_i_GetStrangerInfo(QQ:int64;Var info:CQ_Type_QQ;nocache:boolean):longint;
	function CQ_i_getGroupMemberInfo(groupid,qqid:int64;Var info:CQ_Type_GroupMember;nocache:boolean):longint;
	function CQ_i_getAppDirectory:ansistring;
	function CQ_i_addLog(priority:longint;const category,content:ansistring):longint;
	function CQ_i_setFriendAddRequest(const responseflag:pchar;responseoperation:longint;const remark:string):longint;
	function CQ_i_setGroupAnonymousMute(group:int64;fromAnonymous:string;duration:int64):longint;
	function CQ_i_setGroupWholeMute(groupid:int64;enableban:boolean):longint;
	function CQ_i_setGroupCard(group,qq:int64;nick:string):longint;
	Function CQ_i_setGroupSpecialTitle(Group,ID:int64;Title:string;duration:int64):longint;
	Function CQ_i_setGroupAdmin(group,qq:int64;operation:boolean):longint;
	Function CQ_i_setGroupAnonymous(group:int64;operation:boolean):longint;
	Function CQ_i_setGroupAddRequest(responseflag:string;subtype:longint;responseoperation:longint;reason:string):longint;
	Function CQ_i_setGroupLeave(group:int64;isdisband:boolean):longint;
	function CQ_i_setGroupMute(groupid,QQID,duration:int64):longint;
	function CQ_i_setGroupKick(groupid,QQID:int64;rejectaddrequest:boolean):longint;
	function CQ_i_setDiscussLeave(DiscussID:int64):longint;
	function CQ_i_setFatal(msg:ansistring):longint;
	function CQ_i_getGroupMemberList(GroupID:int64;Var GroupMemberList:CQ_Type_GroupMember_List):longint;
	function CQ_i_getGroupList(Var GroupList:CQ_Type_GroupList):longint;
	
Var
	AuthCode:longint;
	//AuthCode CoolQ用来识别你是否是合法\调用的玩意儿
	CQAPPID		:string='com.binkic.cqdemo';
	CQAPPINFO	:string;
	//请修改APPID为你的APPID

implementation

uses math,dateutils,sysutils,Classes;

{$INCLUDE lib\Tools.pas}
{$INCLUDE lib\CoolQ_DllFunction.pas}
{$INCLUDE lib\CoolQ_Tools.pas}
{$INCLUDE lib\CoolQ_CQapplication.pas}

end.
