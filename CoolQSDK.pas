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
{$IFDEF FPC}
	{$CODEPAGE UTF-8}
{$ENDIF}

{$IFDEF FPC}
	{$MODE DELPHI}
{$ENDIF}

{$I-}
{$h+}

unit CoolQSDK;

interface
Type
	CQ_Type_QQ=
		record
			QQID			: int64;	//QQ号
			nick			: widestring;	//昵称
			sex,						//性别
			age				: longint;	//年龄
		end;

	CQ_Type_GroupMember=
		record
			GroupID,					// 群号
			QQID			: int64;	// QQ号
			nick,						// QQ昵称
			card			: widestring;	// 群名片
			sex,						// 性别 0/男 1/女
			age				: longint;	// 年龄
			aera			: widestring;	// 地区
			jointime,					// 入群时间
			lastsent		: longint;	// 上次发言时间
			level_name		: widestring;	// 头衔名字
			permission		: longint;	// 权限等级 1/成员 2/管理员 3/群主
			unfriendly		: boolean;	// 不良成员记录
			title			: widestring;	// 自定义头衔
			titleExpiretime : longint;	// 头衔过期时间
			nickcanchange	: boolean;	// 管理员是否能协助改名
		end;

	CQ_Type_GroupMember_List=
		record
			l : longint; 						//数组长度
			s :	Array Of CQ_Type_GroupMember;	//群成员列表
			//上面的这个定义叫做动态数组，数组编号是从第0位到第l-1位。一共是l位。
		end;

	CQ_Type_GroupAnonymous=
		record
			AID				: int64;
			name			: widestring;
			Token			: ansistring;
		end;

	CQ_Type_GroupFile=
		record
			fileid			: ansistring;	//文件ID
			filename		: widestring;	//文件名
			size			: int64;	//文件大小
			busid			: longint;	//busid
		end;

	CQ_Type_GroupInfo=
		record
			GroupID			: int64;
			name			: widestring;
		end;

	CQ_Type_GroupList=
		record
			l : longint;					//数组长度
			s : Array Of CQ_Type_GroupInfo;	//群列表
		end;

	CQ_Type_Friend=
		record
			QQID 			: int64;	// QQ号
			nick			: widestring;
			alias			: widestring;
		end;

	CQ_Type_FriendsList=
		record
			l : longint; //数组长度
			s : Array of CQ_Type_Friend;
		end;

	CQ_Type_Group=
		record
			GroupID			: int64;
			name			: widestring;
			members			: record
									current,max : longint;
								end;
		end;

	{CQ_Type_MsgType=
		record
			key,msg			: widestring;
		end;
	CQ_Type_SuspensionWindow=
		record
			data,entity		: longint;
		end;}
	
Const
	CR = #$0d;
	LF = #$0a;
	CRLF = CR + LF;
	// 换行符
	
	CQAPIVER=9;
	CQAPIVERTEXT='9';
	// CoolQ API版本
	
	EVENT_IGNORE=0;        //事件_忽略
	EVENT_BLOCK=1;         //事件_拦截

	REQUEST_ALLOW=1;       //请求_通过
	REQUEST_ACCEPT=1;       //请求_通过
	REQUEST_DENY=2;        //请求_拒绝

	REQUEST_GROUPADD=1;    //请求_群添加
	REQUEST_GROUPINVITE=2; //请求_群邀请

	CQLOG_DEBUG=0;           //调试 灰色
	CQLOG_INFO=10;           //信息 黑色
	CQLOG_INFOSUCCESS=11;    //信息(成功) 紫色
	CQLOG_INFORECV=12;       //信息(接收) 蓝色
	CQLOG_INFOSEND=13;       //信息(发送) 绿色
	CQLOG_WARNING=20;        //警告 橙色
	CQLOG_ERROR=30;          //错误 红色
	CQLOG_FATAL=40;          //致命错误 深红

	//悬浮窗颜色
	CQSuspensionWindow_Green=1;
	CQSuspensionWindow_Orange=2;
	CQSuspensionWindow_Red=3;
	CQSuspensionWindow_DarkRed=4;
	CQSuspensionWindow_Black=5;
	CQSuspensionWindow_grey=6;
	
	// 下面的函数的确切含义请查阅lib文件夹下的文件。
	// lib\Tools.pas
	Function PtoS(a:pansichar):ansistring;
	Function StoP(a:ansistring):pansichar;
	Function NumToChar(a:int64):ansistring;
	Function NumToCharW(a:int64):widestring;
	Function CharToNum(a:ansistring):int64;overload;
	Function CharToNum(a:widestring):int64;overload;
	Function RealToChar(a:real):ansistring;
	Function RealToCharW(a:real):widestring;
	Function CharToReal(a:ansistring):real;overload;
	Function CharToReal(a:widestring):real;overload;
	Function RealToDisplay(a:real;b:longint):ansistring;
	Function String_Choose(expression:boolean;a,b:ansistring):ansistring;overload;
	Function String_Choose(expression:boolean;a,b:widestring):widestring;overload;
	Function String_Choose(expression:boolean;a:widestring;b:ansistring):widestring;overload;
	Function String_Choose(expression:boolean;a:ansistring;b:widestring):widestring;overload;
	Procedure Message_Replace(var a:ansistring;b,c:ansistring);overload;
	Procedure Message_Replace(var a:widestring;b,c:widestring);overload;
	Function UrlEncode(s:ansistring):ansistring;
	Function UrlDecode(s:ansistring):ansistring;
	// lib\CoolQ_Tools.pas
	Function Base64_Encryption(s:ansistring):ansistring;
	Function Base64_Decryption(s:ansistring):ansistring;
	// lib\CoolQ_CQapplication.pas
		// 酷Q码转义
	Function CQ_CharEncode(str:ansistring;Comma:boolean):ansistring;overload;
	Function CQ_CharEncode(str:widestring;Comma:boolean):widestring;overload;
	Function CQ_CharDecode(str:ansistring):ansistring;overload;
	Function CQ_CharDecode(str:widestring):widestring;overload;
		// 酷Q码封装
	function CQCode_Group_At(QQID:int64):ansistring;
	function CQCode_emoji(ID:int64):ansistring;
	function CQCode_face(ID:int64):ansistring;
	function CQCode_Shake:ansistring;
	function CQCode_anonymous(Force:boolean):ansistring;	
	function CQCode_image(url:ansistring):ansistring;overload;
	function CQCode_image(url:widestring):widestring;overload;
	function CQCode_Music(source:ansistring;musicid:int64;isnew:boolean):ansistring;overload;
	function CQCode_Music(source:ansistring;musicid:int64;style:longint):ansistring;overload;
	function CQCode_Music_Custom(url,audio,title,content,image:widestring):widestring;
	function CQCode_Location(latitude,longitude:real;Zoom:longint;Name,Address:widestring):widestring;
	function CQCode_bface(ID:int64):ansistring;
	function CQCode_record(url:ansistring;magic:boolean):ansistring;overload;
	function CQCode_record(url:widestring;magic:boolean):widestring;overload;
	function CQCode_rps(ID:int64):ansistring;
	function CQCode_dice(ID:int64):ansistring;
	function CQCode_share(url,title,Content,image:widestring):widestring;
	function CQCode_contact(t:ansistring;id:int64):ansistring;
		// 酷QAPI
	function CQ_i_sendPrivateMsg(QQID:int64;msg:ansistring):longint;overload;
	function CQ_i_sendPrivateMsg(QQID:int64;msg:widestring):longint;overload;	
	function CQ_i_sendGroupMsg(groupid:int64;const msg:ansistring):longint;overload;
	function CQ_i_sendGroupMsg(groupid:int64;const msg:widestring):longint;overload;
	function CQ_i_sendDiscussMsg(DiscussID:int64;msg:ansistring):longint;overload;
	function CQ_i_sendDiscussMsg(DiscussID:int64;msg:widestring):longint;overload;
	function CQ_i_sendLike(QQID:int64):longint;overload;								
	function CQ_i_sendLike(QQID:int64;times:longint):longint;overload;						//加料的一个函数
	function CQ_i_sendLikeV2(QQID:int64;times:longint):longint;				
	function CQ_i_getRecord(filename,format:ansistring):ansistring;overload;deprecated;
	function CQ_i_getRecord(filename:widestring;format:ansistring):ansistring;overload;deprecated;
	function CQ_i_getRecordV2(filename,format:ansistring):ansistring;overload;
	function CQ_i_getRecordV2(filename:widestring;format:ansistring):ansistring;overload;
	function CQ_i_getImage(filename:ansistring):ansistring;overload;
	function CQ_i_getImage(filename:widestring):ansistring;overload;
	function CQ_Tools_TextToAnonymous(source:ansistring;Var Anonymous:CQ_Type_GroupAnonymous):boolean;
	Function CQ_Tools_TextToFile(source:ansistring;Var info:CQ_Type_GroupFile):boolean;
	Function CQ_i_getCookies():ansistring;
	Function CQ_i_getCookiesV2(domain:ansistring):ansistring;
	Function CQ_i_getCsrfToken():longint;
	Function CQ_i_getLoginQQ():int64;
	Function CQ_i_getLoginNick():widestring;
	Function CQ_i_getStrangerInfo(QQ:int64;Var info:CQ_Type_QQ;nocache:boolean):longint;
	Function CQ_i_getGroupInfo(groupID:int64;Var info:CQ_Type_Group;nocache:boolean):longint;
	function CQ_i_getGroupMemberInfo(groupid,qqid:int64;Var info:CQ_Type_GroupMember;nocache:boolean):longint;
	function CQ_i_getAppDirectory:ansistring;
	function CQ_i_addLog(priority:longint;const category,content:ansistring):longint;overload;
	function CQ_i_addLog(priority:longint;const category,content:widestring):longint;overload;
	function CQ_i_setFriendAddRequest(const responseflag:ansistring;responseoperation:longint;const remark:ansistring):longint;overload;
	function CQ_i_setFriendAddRequest(const responseflag:ansistring;responseoperation:longint;const remark:widestring):longint;overload;
	function CQ_i_setGroupAnonymousMute(group:int64;fromAnonymous:ansistring;duration:int64):longint;
	function CQ_i_setGroupWholeMute(groupid:int64;enableban:boolean):longint;
	function CQ_i_setGroupCard(group,qq:int64;nick:ansistring):longint;overload;
	function CQ_i_setGroupCard(group,qq:int64;nick:widestring):longint;overload;
	Function CQ_i_setGroupSpecialTitle(Group,ID:int64;Title:ansistring;duration:int64):longint;overload;
	Function CQ_i_setGroupSpecialTitle(Group,ID:int64;Title:widestring;duration:int64):longint;overload;
	Function CQ_i_setGroupAdmin(group,qq:int64;operation:boolean):longint;
	Function CQ_i_setGroupAnonymous(group:int64;operation:boolean):longint;
	Function CQ_i_setGroupAddRequest(responseflag:ansistring;subtype:longint;responseoperation:longint;reason:ansistring):longint;overload;
	Function CQ_i_setGroupAddRequest(responseflag:ansistring;subtype:longint;responseoperation:longint;reason:widestring):longint;overload;
	Function CQ_i_setGroupLeave(group:int64;isdisband:boolean):longint;
	function CQ_i_setGroupMute(groupid,QQID,duration:int64):longint;
	function CQ_i_setGroupKick(groupid,QQID:int64;rejectaddrequest:boolean):longint;
	function CQ_i_setDiscussLeave(DiscussID:int64):longint;
	function CQ_i_setFatal(msg:ansistring):longint;overload;
	function CQ_i_setFatal(msg:widestring):longint;overload;
	function CQ_i_getGroupMemberList(GroupID:int64;Var GroupMemberList:CQ_Type_GroupMember_List):longint;
	function CQ_i_getGroupList(Var GroupList:CQ_Type_GroupList):longint;
	function CQ_i_deleteMsg(msgID:int64):longint;
	function CQ_i_getFriendList(Var friendList:CQ_Type_FriendsList):longint;
	function CQ_i_canSendImage():longint;
	function CQ_i_canSendRecord(AuthCode:longint):longint;
	
		// 编码转换
	Function CoolQ_Tools_WideToAnsi(Sstr:widestring):ansistring;
	Function CoolQ_Tools_AnsiToWide(Sstr:ansistring):widestring;
Var
	AuthCode:longint;
	//AuthCode CoolQ用来识别你是否是合法\调用的玩意儿
	CQAPPID		:ansistring='com.binkic.cqdemo';
	CQAPPINFO	:ansistring;
	//请在应用主程序中修改APPID为你的APPID

implementation

uses math,sysutils,iconv; 

const
	Base64Chars='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
	Base64Table:array[0..63] of ansichar='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
var
	Base64DecoderTable:array[ansichar] of byte;

{
	Char* 转换到 字符串
}
Function PtoS(a:pansichar):ansistring;
Begin
	result:=strPas(a)
End;

{
	字符串 转换到 Char*
}
Function StoP(a:ansistring):pansichar;
Begin
	result:=pansichar(@a[1]);
End;

{***********************************************************}

{
	数字 转换到 字符串
}
Function NumToChar(a:int64):ansistring;
Begin
	str(a,result);
End;
Function NumToCharW(a:int64):widestring;
Begin
	str(a,result);
End;


{
	字符串 转换到 数字
}
Function CharToNum(a:ansistring):int64;overload;
Begin
	//val(a,result);
	result:=StrToInt64Def(a,0);
End;
Function CharToNum(a:widestring):int64;overload;
Begin
	//val(a,result);
	result:=StrToInt64Def(ansistring(a),0);
End;


{
	双精浮点 转换到 字符串
}
Function RealToChar(a:real):ansistring;
Begin
	str(a,result)
End;
Function RealToCharW(a:real):widestring;
Begin
	str(a,result)
End;

{
	字符串 转换到 双精浮点
}
Function CharToReal(a:ansistring):real;overload;
Begin
	//val(a,result);
	result:=StrToFloatDef(a,0);
End;
Function CharToReal(a:widestring):real;overload;
Begin
	//val(a,result);
	result:=StrToFloatDef(ansistring(a),0);
End;


{
	双精浮点 转换到 能看的字符串
}

Function RealToDisplay(a:real;b:longint):ansistring;
Var
	display:ansistring;
	i:longint;
Begin
	if a>=0 
		then display:=''
		else
		begin
			display:='-';
			a:=-a;
		end;
	
	display:=display+NumToChar(trunc(a));
	a:=(a-trunc(a))*10;
	
	if b<0 then b:=16;
	b:=min(b,16);
	if b<>0 then display:=display+'.';
	
	for i:=1 to b do begin
		display:=display+NumToChar(trunc(a));
		a:=(a-trunc(a))*10;
	end;
	
	result:=display;
	exit;
End;

{***********************************************************}

Function String_Choose(expression:boolean;a,b:ansistring):ansistring;overload;
Begin
	if expression then result:=a else result:=b;
End;
Function String_Choose(expression:boolean;a,b:widestring):widestring;overload;
Begin
	if expression then result:=a else result:=b;
End;
Function String_Choose(expression:boolean;a:widestring;b:ansistring):widestring;overload;
Begin
	if expression then result:=a else result:=widestring(b);
End;
Function String_Choose(expression:boolean;a:ansistring;b:widestring):widestring;overload;
Begin
	if expression then result:=widestring(a) else result:=b;
End;

Procedure Message_Replace(var a:ansistring;b,c:ansistring);overload;
Var
	i:longint;
	lenb:longint;
Begin
	i:=0;
	lenb:=length(b);
	
	repeat
		inc(i);
		if copy(a,i,lenb) = b then begin
			a:=copy(a,1,i-1)+c+copy(a,i+lenb,length(a));
			i:=i+length(c)-1;
		end;
	until i>=length(a);
End;
Procedure Message_Replace(var a:widestring;b,c:widestring);overload;
Var
	i:longint;
	lenb:longint;
Begin
	i:=0;
	lenb:=length(b);
	
	repeat
		inc(i);
		if copy(a,i,lenb) = b then begin
			a:=copy(a,1,i-1)+c+copy(a,i+lenb,length(a));
			i:=i+length(c)-1;
		end;
	until i>=length(a);
End;

Function PowerInt(bas: Int64;expo: Int64) : Int64;
Var
	i:longint;
Begin
	if expo<0 then begin
		result:=0;
		exit;
	end;
	result:=1;
	for i:=1 to expo do
		result:=result*bas;
End;

{***********************************************************}
Function SDECtoHEX(a:integer):ansichar;
Begin
	case a of
		0 : result:=('0');
		1 : result:=('1');
		2 : result:=('2');
		3 : result:=('3');
		4 : result:=('4');
		5 : result:=('5');
		6 : result:=('6');
		7 : result:=('7');
		8 : result:=('8');
		9 : result:=('9');
		10 : result:=('A');
		11 : result:=('B');
		12 : result:=('C');
		13 : result:=('D');
		14 : result:=('E');
		15 : result:=('F');
		else result:='-';
	end;
End;

Function SHEXtoDec(a:ansichar):integer;
Begin
	case upcase(a) of
		'0' : result:=(0);
		'1' : result:=(1);
		'2' : result:=(2);
		'3' : result:=(3);
		'4' : result:=(4);
		'5' : result:=(5);
		'6' : result:=(6);
		'7' : result:=(7);
		'8' : result:=(8);
		'9' : result:=(9);
		'A' : result:=(10);
		'B' : result:=(11);
		'C' : result:=(12);
		'D' : result:=(13);
		'E' : result:=(14);
		'F' : result:=(15);
		else result:=(-1);
	end;
End;

{
	十进制转二进制
}
Function Hex_Conversion_10to2(s:longint):ansistring;
Begin
        result:='';
        while s>0 do begin
			result:=numtochar(s mod 2)+result;
			s:=s div 2;
        end;
        while length(result)<8 do result:='0'+result;
End;
{
	二进制转十进制
}
Function Hex_Conversion_2to10(s:ansistring):longint;
Var
        i:longint;
Begin
        result:=0;
        for i:=length(s) downto 1 do begin
                if s[i]='1' then
                result:=result+PowerInt( 2 , (length(s)-i) );
        end;
End;

Function UrlEncode(s:ansistring):ansistring;
//编码
Var
	a:ansistring;
	i:longint;
Begin
	a:='';

	for i:=1 to length(s) do
		if (integer(s[i])>32) and (integer(s[i])<128)
			and (s[i]<>'"') and (s[i]<>'''')
			and (s[i]<>'/') and (s[i]<>'\')
			and (s[i]<>':') and (s[i]<>'%')
			and (s[i]<>'[') and (s[i]<>']')
			and (s[i]<>',') and (s[i]<>'+') then a:=a+s[i]
		else a:=a+'%'+SDECtoHEX(integer(s[i])div 16)+SDECtoHEX(integer(s[i])mod 16);

	result:=(a);
End;

Function GB2312ASCtoChar(a,b:ansichar):ansichar;
Begin
	result:=(ansichar(SHEXtoDec(a)*16+SHEXtoDec(b)));
End;

Function UrlDecode(s:ansistring):ansistring;
//解码
Var
	i:longint;
	outs:ansistring;
Begin
	outs:='';
	i:=1;
	while i<=length(s) do begin
		if s[i]='%' then begin
			//也许需要转义
			if (SHEXtoDec(s[i+1])<>-1) and (SHEXtoDec(s[i+2])<>-1) then begin
				//需要转义
				outs:=outs+GB2312ASCtoChar(s[i+1],s[i+2]);
				i:=i+3;
			end
			else
			begin
				//依然不需要转义
				outs:=outs+s[i];
				i:=i+1;
			end;
		end
		else
		if s[i]='+' then begin
			outs:=outs+' ';
			i:=i+1;
		end
		else
		begin
			//不需要转义
			outs:=outs+s[i];
			i:=i+1;
		end;
	end;
        result:=(outs);
End;

function CQ_sendPrivateMsg(AuthCode:longint;QQID:int64;const msg:PAnsiChar):longint;
	stdcall; external 'CQP.dll' name 'CQ_sendPrivateMsg';
function CQ_sendGroupMsg(AuthCode:longint;groupid:int64;const msg:PAnsiChar):longint;
	stdcall; external 'CQP.dll' name 'CQ_sendGroupMsg';
function CQ_sendDiscussMsg(AuthCode:longint;discussid:int64;const msg:PAnsiChar):longint;
	stdcall; external 'CQP.dll' name 'CQ_sendDiscussMsg';
function CQ_sendLike(AuthCode:longint;QQID:int64):longint;
	stdcall; external 'CQP.dll' name 'CQ_sendLike';
function CQ_sendLikeV2(AuthCode:longint;QQID:int64;times:longint):longint;
	stdcall; external 'CQP.dll' name 'CQ_sendLikeV2';
function CQ_setGroupAdmin(AuthCode:longint;groupid,QQID:int64;state:longint):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupAdmin';	
function CQ_setGroupKick(AuthCode:longint;groupid,QQID:int64;rejectaddrequest:longint):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupKick';
function CQ_setGroupBan(AuthCode:longint;groupid,QQID,duration:int64):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupBan';
function CQ_setGroupWholeBan(AuthCode:longint;groupid:int64;enableban:longint):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupWholeBan';
function CQ_setGroupAnonymousBan(AuthCode:longint;groupid:int64;const anomymous:PAnsiChar;duration:int64):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupAnonymousBan';
function CQ_setGroupAnonymous(AuthCode:longint;groupid:int64;enableanomymous:longint):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupAnonymous';
function CQ_setGroupCard(AuthCode:longint;groupid,QQID:int64;newcard:PAnsiChar):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupCard';
function CQ_setGroupLeave(AuthCode:longint;groupid:int64;isdismiss:longint):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupLeave';
function CQ_setGroupSpecialTitle(AuthCode:longint;groupid,QQID:int64;newspecialtitle:PAnsiChar;duration:int64):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupSpecialTitle';
function CQ_setDiscussLeave(AuthCode:longint;discussid:int64):longint;
	stdcall; external 'CQP.dll' name 'CQ_setDiscussLeave';
function CQ_setFriendAddRequest(AuthCode:longint;const responseflag:PAnsiChar;responseoperation:longint;const remark:PAnsiChar):longint;
	stdcall; external 'CQP.dll' name 'CQ_setFriendAddRequest';
function CQ_setGroupAddRequestV2(AuthCode:longint;const responseflag:PAnsiChar;requesttype,responseoperation:longint;const reason:PAnsiChar):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupAddRequestV2';
function CQ_getGroupMemberInfoV2(AuthCode:longint;groupid,QQID:int64;nocache:longint):PAnsiChar;
	stdcall; external 'CQP.dll' name 'CQ_getGroupMemberInfoV2';	
function CQ_getStrangerInfo(AuthCode:longint;QQID:int64;nocache:longint):PAnsiChar;
	stdcall; external 'CQP.dll' name 'CQ_getStrangerInfo';	
function CQ_addLog(AuthCode,priority:longint;const category,content:PAnsiChar):longint;
	stdcall; external 'CQP.dll' name 'CQ_addLog';
function CQ_getRecord(AuthCode:longint;filename,format:PAnsiChar):PAnsiChar;		//【已弃用】接收语音，并返回语音文件相对路径
	stdcall; external 'CQP.dll' name 'CQ_getRecord';
function CQ_getRecordV2(AuthCode:longint;filename,format:PAnsiChar):PAnsiChar;
	stdcall; external 'CQP.dll' name 'CQ_getRecordV2';
function CQ_getCookies(AuthCode:longint):PAnsiChar;
	stdcall; external 'CQP.dll' name 'CQ_getCookies';
function CQ_getCookiesV2(AuthCode:longint;domain:PAnsiChar):PAnsiChar;
	stdcall; external 'CQP.dll' name 'CQ_getCookiesV2';
function CQ_getCsrfToken(AuthCode:longint):longint;
	stdcall; external 'CQP.dll' name 'CQ_getCsrfToken';
function CQ_getLoginQQ(AuthCode:longint):int64;
	stdcall; external 'CQP.dll' name 'CQ_getLoginQQ';
function CQ_getLoginNick(AuthCode:longint):PAnsiChar;
	stdcall; external 'CQP.dll' name 'CQ_getLoginNick';
function CQ_getAppDirectory(AuthCode:longint):PAnsiChar;
	stdcall; external 'CQP.dll' name 'CQ_getAppDirectory';
function CQ_setFatal(AuthCode:longint;const errorinfo:PAnsiChar):longint;
	stdcall; external 'CQP.dll' name 'CQ_setFatal';
function CQ_getGroupMemberList(AuthCode:longint;GroupID:int64):PAnsiChar;
	stdcall; external 'CQP.dll' name 'CQ_getGroupMemberList';
function CQ_getGroupList(AuthCode:longint):PAnsiChar;
	stdcall; external 'CQP.dll' name 'CQ_getGroupList';
function CQ_deleteMsg(AuthCode:longint;MsgId:int64):longint;
	stdcall; external 'CQP.dll' name 'CQ_deleteMsg';
function CQ_getImage(AuthCode:longint;fileName:PAnsiChar):PAnsiChar;	//接收图片，并返回图片文件绝对路径
	stdcall; external 'CQP.dll' name 'CQ_getImage';
function CQ_canSendImage(AuthCode:longint):longint;				//是否支持发送图片，返回大于 0 为支持，等于 0 为不支持
	stdcall; external 'CQP.dll' name 'CQ_canSendImage';
function CQ_canSendRecord(AuthCode:longint):longint;			//是否支持发送语音，返回大于 0 为支持，等于 0 为不支持
	stdcall; external 'CQP.dll' name 'CQ_canSendRecord';
function CQ_getFriendList(AuthCode:longint;reserved:longint):PAnsiChar; //取好友列表 //保留参数，请传入“假”
	stdcall; external 'CQP.dll' name 'CQ_getFriendList';
function CQ_getGroupInfo(AuthCode:longint;groupid:int64;nocache:longint):PAnsiChar; //取群信息(支持缓存)
	stdcall; external 'CQP.dll' name 'CQ_getGroupInfo';

	
procedure InitBase64;
var i:longint;
begin
 for i:=0 to 63 do begin
  Base64DecoderTable[Base64Table[i]]:=i;
 end;
end;

//function DecodeBase64(s:ansistring):ansistring;
Function Base64_Decryption(s:ansistring):ansistring;
var i,j,l:longint;
    c:longword;
begin
 setlength(result,((length(s)*3) shr 2)+3);
{while (length(s) and 3)<>0 do begin
  s:=s+'=';
 end;}
 l:=0;
 i:=1;
 while i<=length(s) do begin
  c:=0;
  for j:=1 to 4 do begin
   if i<=length(s) then begin
    case s[i] of
     'A'..'Z','a'..'z','0'..'9','+','/':begin
      c:=c or (Base64DecoderTable[s[i]] shl (24-((j shl 2)+(j shl 1))));
     end;
     '=':begin
      c:=(c and $00ffffff) or (((c shr 24)+1) shl 24);
     end;
     else begin
      c:=c or $f0000000;
      break;
     end;
    end;
   end else begin
    c:=(c and $00ffffff) or (((c shr 24)+1) shl 24);
   end;
   inc(i);
  end;
  if (c shr 24)<3 then begin
   inc(l);
   result[l]:=ansichar((c shr 16) and $ff);
   if (c shr 24)<2 then begin
    inc(l);
    result[l]:=ansichar((c shr 8) and $ff);
    if (c shr 24)<1 then begin
     inc(l);
     result[l]:=ansichar(c and $ff);
    end;
   end;
  end else begin
   break;
  end;
 end;
 setlength(result,l);
end;

//function EncodeBase64(s:ansistring):ansistring;
Function Base64_Encryption(s:ansistring):ansistring;
var i,l:longint;
    c:longword;
begin
 if length(s)=0 then begin
  result:='';
 end else begin
  setlength(result,((length(s)*4) div 3)+4);
  l:=1;
  i:=1;
  while (i+2)<=length(s) do begin
   c:=(byte(s[i]) shl 16) or (byte(s[i+1]) shl 8) or byte(s[i+2]);
   result[l]:=Base64Table[(c shr 18) and $3f];
   result[l+1]:=Base64Table[(c shr 12) and $3f];
   result[l+2]:=Base64Table[(c shr 6) and $3f];
   result[l+3]:=Base64Table[c and $3f];
   inc(i,3);
   inc(l,4);
  end;
  if (i+1)<=length(s) then begin
   c:=(byte(s[i]) shl 16) or (byte(s[i+1]) shl 8);
   result[l]:=Base64Table[(c shr 18) and $3f];
   result[l+1]:=Base64Table[(c shr 12) and $3f];
   result[l+2]:=Base64Table[(c shr 6) and $3f];
   result[l+3]:='=';
   inc(l,4);
  end else if i<=length(s) then begin
   c:=byte(s[i]) shl 16;
   result[l]:=Base64Table[(c shr 18) and $3f];
   result[l+1]:=Base64Table[(c shr 12) and $3f];
   result[l+2]:='=';
   result[l+3]:='=';
   inc(l,4);
  end;
  if l>1 then begin
   setlength(result,l-1);
  end else begin
   result:=trim(result);
  end;
 end;
end;

{
	反转字符串
}
Function CoolQ_Tools_Flip(s:ansistring):ansistring;
Var
	i:longint;
Begin
	result:='';
	for i:=length(s) downto 1 do 
		result:=result+s[i];
End;

Function BinToNum(bin:ansistring):int64;
Var
	i:longint;
Begin
	result:=0;
	bin:=CoolQ_Tools_Flip(bin);
	for i:=1 to length(bin) do begin
		result:=result+PowerInt(256,(i-1))*integer(bin[i]);
	end;
End;

{ //貌似有问题
Function NumToBin(num:int64;len:longint):ansistring;
Begin
	result:='';
	while num>0 do begin
		result:=NumToChar(num mod 256)+result;
		num:=num div 256;
	end;
	while length(result)<len*3 do result:='00'+result; //这一行
End;
}

Function BinToHex(bin:ansistring):ansistring;
Var
	i:longint;
Begin
	result:='';
	for i:=1 to length(bin) do begin
		result:=result+SDECtoHEX(integer(bin[i])div 16)+SDECtoHEX(integer(bin[i])mod 16)+' ';
	end;
End;

{
	解包
}
Function CoolQ_Tools_Unpack_GetStr_GivenLength(Var i:longint;
								len:longint;
								Var s:ansistring):ansistring;
Begin
	if len<=0 then begin
		result:='';
		exit;
	end;
	result:=copy(s,i,len);
	i:=i+len;
End;

Function CoolQ_Tools_Unpack_GetNum(Var i:longint;
								len:longint;
								Var s:ansistring):int64;
Begin
	result:=BinToNum(copy(S,i,len));
	i:=i+len;
End;

Function CoolQ_Tools_Unpack_GetStr(Var i:longint;
								Var s:ansistring):ansistring;
Var
	len:longint;
Begin
	len:=CoolQ_Tools_Unpack_GetNum(i,2,s);
	result:=CoolQ_Tools_Unpack_GetStr_GivenLength(i,len,s);
End;

Function CoolQ_Tools_Unpack_GetLenRemain(Var i:longint;
								Var s:ansistring):longint;
Begin
	result:=length(s)-i+1;
End;

Function iconvConvert(fromCode,toCode:PAnsiChar;srcBuf:PAnsiChar;srcLen:longint;destBuf:PAnsiChar;destLen:longint):longint;
Var
	cd	:	iconv_t;
	srcLen1,destLen1,status	:	longint;
Begin
	cd := libiconv_open(toCode,fromCode);
	srcLen1:=srcLen;
	destLen1:=destLen;
	status:=libiconv(cd,@srcBuf,@srcLen1,@destBuf,@destLen1);
	libiconv_close(cd);
	result:=status;
End;

Function CoolQ_Tools_WideToAnsi(Sstr:widestring):ansistring;
Var
	str:PAnsiChar;
	sResult:Array [0..262143] of ansichar;
	ret : longint;
Begin
	str:=@Sstr[1];
	fillchar(sResult,sizeof(sResult),0);
	//ret := iconvConvert('UTF-16LE//TRANSLIT//IGNORE','GB18030',Str,StrLen(Str),@sResult[0],sizeof(sResult));
	ret := iconvConvert('UTF-16LE//TRANSLIT//IGNORE','GB18030',Str,length(Sstr)*sizeof(widechar),@sResult[0],sizeof(sResult));
	//ret := iconvConvert('UTF-16LE//TRANSLIT//IGNORE','GB18030',Str,sizeof(Sstr),@sResult[0],sizeof(sResult));
	if ret<>0
		then result:=''
		else result:=sResult;
End;

Function CoolQ_Tools_AnsiToWide(Sstr:ansistring):widestring;
Var
	str:PAnsiChar;
	sResult:Array [0..262143] of widechar;
	ret :longint;
Begin
	str:=@Sstr[1];
	fillchar(sResult,sizeof(sResult),0);
	ret := iconvConvert('GB18030//IGNORE','UTF-16LE',Str,StrLen(Str),@sResult[0],sizeof(sResult));
	if ret<>0
		then result:=''
		else result:=sResult;
End;

Function CQ_CharEncode(str:ansistring;Comma:boolean):ansistring;overload;
Begin
	Message_Replace(str,'&','&amp;');
	Message_Replace(str,'[','&#91;');
	Message_Replace(str,']','&#93;');
	if Comma then begin
		Message_Replace(str,',','&#44;');
	end;
	result:=(Str);
End;
Function CQ_CharEncode(str:widestring;Comma:boolean):widestring;overload;
Begin
	Message_Replace(str,'&','&amp;');
	Message_Replace(str,'[','&#91;');
	Message_Replace(str,']','&#93;');
	if Comma then begin
		Message_Replace(str,',','&#44;');
	end;
	result:=(Str);
End;
Function CQ_CharDecode(str:ansistring):ansistring;overload;
Begin
	Message_Replace(str,'&#93;',']');
	Message_Replace(str,'&#91;','[');
	Message_Replace(str,'&#44;',',');
	Message_Replace(str,'&amp;','&');
	result:=(str);
End;
Function CQ_CharDecode(str:widestring):widestring;overload;
Begin
	Message_Replace(str,'&#93;',']');
	Message_Replace(str,'&#91;','[');
	Message_Replace(str,'&#44;',',');
	Message_Replace(str,'&amp;','&');
	result:=(str);
End;

{
QQID为被@的群成员QQ。该参数为-1，则@全体成员，若次数用尽或权限不足则会转换为文本。
举例：[CQ:at,qq=123456]
}
function CQCode_Group_At(QQID:int64):ansistring;
Begin
	result:=('[CQ:at,qq='+String_Choose(QQID=-1,'all',NumToChar(QQID))+']');
End;

{
ID为emoji字符的unicode编号
举例：[CQ:emoji,id=128513]（发送一个大笑的emoji表情）
}
function CQCode_emoji(ID:int64):ansistring;
Begin
	result:=('[CQ:emoji,id='+NumToChar(ID)+']');
End;

{
ID为0-170的数字
举例：[CQ:face,id=14]（发送一个微笑的QQ表情）
}
function CQCode_face(ID:int64):ansistring;
Begin
	result:=('[CQ:at,face='+NumToChar(ID)+']');
End;

//窗口抖动（仅支持好友消息使用）
function CQCode_Shake:ansistring;
Begin
	result:=('[CQ:shake]');
End;

{
本CQ码需加在消息的开头。
当 Force 为false时，代表不强制使用匿名，如果匿名失败将转为普通消息发送。
当 Force 为true时，代表强制使用匿名，如果匿名失败将取消该消息的发送。
举例：
}
function CQCode_anonymous(Force:boolean):ansistring;	
Begin
	result:=('[CQ:anonymous'+String_Choose(Force,'',',ignore=true')+']');
End;

{
url为图片文件名称，图片存放在酷Q目录的data\image\下
举例：[CQ:image,file=1.jpg]（发送data\image\1.jpg）
}
function CQCode_image(url:ansistring):ansistring;overload;
Begin
	result:=('[CQ:image,file='+CQ_CharEncode(url,true)+']')
End;
function CQCode_image(url:widestring):widestring;overload;
Begin
	result:=('[CQ:image,file='+CQ_CharEncode(url,true)+']')
End;

{
source为音乐平台类型，目前支持qq、163、xiami
musicid为对应音乐平台的数字音乐id
注意：音乐只能作为单独的一条消息发送
举例：
[CQ:music,type=qq,id=422594]（发送一首QQ音乐的“Time after time”歌曲到群内）
[CQ:music,type=163,id=28406557]（发送一首网易云音乐的“桜咲く”歌曲到群内）
}
function CQCode_Music(source:ansistring;musicid:int64;isnew:boolean):ansistring;overload;
Begin
	result:=('[CQ:music,type='+source+',id='+NumToChar(musicid)+String_Choose(isnew,',style=1','')+']')
	{返回 (“[CQ:music,id=” ＋ 到文本 (歌曲ID) ＋ “]”)}
End;
function CQCode_Music(source:ansistring;musicid:int64;style:longint):ansistring;overload;
Begin
	result:=('[CQ:music,type='+source+',id='+NumToChar(musicid)+',style'+NumToChar(style)+']')
	{返回 (“[CQ:music,id=” ＋ 到文本 (歌曲ID) ＋ “]”)}
End;

{
发送音乐自定义分享(music)
url 点击分享后进入的音乐页面（如歌曲介绍页）
audio 音乐的音频链接（如mp3链接）
title 音乐的标题，建议12字以内
content 音乐的简介，建议30字以内
image 音乐的封面图片链接，留空则为默认图片
}
function CQCode_Music_Custom(url,audio,title,content,image:widestring):widestring;
Begin
	result:='[CQ:music,type=custom,url='+CQ_CharEncode(url,true)
						+',audio='+CQ_CharEncode(audio,true)
						+String_Choose(title='','',',title='+CQ_CharEncode(title,true))
						+String_Choose(content='','',',content='+CQ_CharEncode(content,true))
						+String_Choose(image='','',',image='+CQ_CharEncode(image,true))
						+']';
End;

{
发送位置分享(location)

}
function CQCode_Location(latitude,longitude:real;Zoom:longint;Name,Address:widestring):widestring;
Begin
	result:='[CQ:location,lat='+widestring(RealToDisplay(latitude,6))+',lon='+widestring(RealToDisplay(longitude,6));
	if zoom>0 then result:=result+',zoom='+widestring(NumToChar(zoom));
	result:=result+',title='+CQ_CharEncode(Name,true)+',content'+CQ_CharEncode(Address,true)+']';
ENd;

{
id为该原创表情的ID，存放在酷Q目录的data\bface\下
}
function CQCode_bface(ID:int64):ansistring;
Begin
	result:=('[CQ:bface,id='+NumToChar(ID)+']');
End;

{
1为音频文件名称，音频存放在酷Q目录的data\record\下
2为是否为变声，若该参数为true则显示变声标记。该参数可被忽略。
举例：[CQ:record,file=1.silk，magic=true]（发送data\record\1.silk，并标记为变声）
}
function CQCode_record(url:ansistring;magic:boolean):ansistring;overload;
Begin
	result:=('[CQ:record,file='+CQ_CharEncode(url,true)+String_Choose(magic,',magic=true','')+']');
End;
function CQCode_record(url:widestring;magic:boolean):widestring;overload;
Begin
	result:=('[CQ:record,file='+CQ_CharEncode(url,true)+String_Choose(magic,widestring(',magic=true'),widestring(''))+']');
End;

{
id为猜拳结果的类型，暂不支持发送时自定义。该参数可被忽略。
1 - 猜拳结果为石头
2 - 猜拳结果为剪刀
3 - 猜拳结果为布
}
function CQCode_rps(ID:int64):ansistring;
Begin
	result:=('[CQ:rps,id='+NumToChar(ID)+']');
End;

{
id对应掷出的点数，暂不支持发送时自定义。该参数可被忽略。
}
function CQCode_dice(ID:int64):ansistring;
Begin
	result:=('[CQ:dice,id='+NumToChar(ID)+']');
End;

{
[CQ:share,url=” ＋ CQ码_转义 (url地址, 真) ＋ “,title=” ＋ CQ码_转义 (卡片标题, 真) ＋ “,content=” ＋ CQ码_转义 (卡片内容, 真) ＋ “,image=” ＋ CQ码_转义 (卡片图片url, 真) ＋ “]
}
function CQCode_share(url,title,Content,image:widestring):widestring;
Begin
	result:=('[CQ:share,url='+CQ_CharEncode(url,true)+',title='+CQ_CharEncode(title,true)+',content='+CQ_CharEncode(content,true)+',image='+CQ_CharEncode(image,true)+']');
End;

{
[CQ:contact,type=qq/group,id=Q号/群号]
}
function CQCode_contact(t:ansistring;id:int64):ansistring;
Begin
	result:=('[CQ:contact,type='+t+',id='+NumToChar(id)+']');
End;

{API}
//发送私聊 Auth=106 //sendPrivateMsg
function CQ_i_sendPrivateMsg(QQID:int64;msg:ansistring):longint;overload;		//Auth=106 //sendPrivateMsg
Begin
	result:=CQ_sendPrivateMsg(AuthCode,QQID,StoP(msg));
End;
function CQ_i_sendPrivateMsg(QQID:int64;msg:widestring):longint;overload;		//Auth=106 //sendPrivateMsg
Begin
	result:=CQ_sendPrivateMsg(AuthCode,QQID,StoP(CoolQ_Tools_WideToAnsi(msg)));
End;

//发送群聊 Auth=101 //sendGroupMsg
function CQ_i_sendGroupMsg(groupid:int64;const msg:ansistring):longint;overload;	//Auth=101 //sendGroupMsg
Begin
	result:=CQ_sendGroupMsg(AuthCode,groupid,StoP(msg));
End;
function CQ_i_sendGroupMsg(groupid:int64;const msg:widestring):longint;overload;	//Auth=101 //sendGroupMsg
Begin
	result:=CQ_sendGroupMsg(AuthCode,groupid,StoP(CoolQ_Tools_WideToAnsi(msg)));
End;
//发送讨论组 Auth=103 //sendDiscussMsg
function CQ_i_sendDiscussMsg(DiscussID:int64;msg:ansistring):longint;overload;	//Auth=103 //sendDiscussMsg
Begin
	result:=CQ_sendDiscussMsg(AuthCode,DiscussID,StoP(msg));
End;
function CQ_i_sendDiscussMsg(DiscussID:int64;msg:widestring):longint;overload;	//Auth=103 //sendDiscussMsg
Begin
	result:=(CQ_sendDiscussMsg(AuthCode,DiscussID,StoP(CoolQ_Tools_WideToAnsi(msg))));
End;
//发送赞 Auth=110 //sendLike
function CQ_i_sendLike(QQID:int64):longint;overload;								//Auth=110 //sendLike
Begin
	result:=(CQ_sendLike(AuthCode,QQID));
End;
function CQ_i_sendLike(QQID:int64;times:longint):longint;overload;								//Auth=110 //sendLike
Begin
	result:=(CQ_sendLikeV2(AuthCode,QQID,min(times,10)));
End;
function CQ_i_sendLikeV2(QQID:int64;times:longint):longint;								//Auth=110 //sendLike
Begin
	result:=(CQ_sendLikeV2(AuthCode,QQID,min(times,10)));
End;

//接受语音 Auth=30 接收消息中的语音(record),返回保存在 \data\record\ 目录下的文件名 //getRecord
function CQ_i_getRecord(filename,format:ansistring):ansistring;overload;deprecated;
{
filename 收到消息中的语音文件名(file)
format 应用所需的语音文件格式，目前支持 mp3,amr,wma,m4a,spx,ogg,wav,flac
}
Begin
	result:=(
		PtoS(
			CQ_getRecord(AuthCode,StoP(filename),StoP(format))
		)
	)
End;
function CQ_i_getRecord(filename:widestring;format:ansistring):ansistring;overload;deprecated;
{
filename 收到消息中的语音文件名(file)
format 应用所需的语音文件格式，目前支持 mp3,amr,wma,m4a,spx,ogg,wav,flac
}
Begin
	result:=(
		PtoS(
			CQ_getRecord(AuthCode,StoP(CoolQ_Tools_WideToAnsi(filename)),StoP(format))
		)
	)
End;

//Auth=30 接收消息中的语音(record),返回语音文件绝对路径 //getRecordV2
function CQ_i_getRecordV2(filename,format:ansistring):ansistring;overload;
{
filename 收到消息中的语音文件名(file)
format 应用所需的语音文件格式，目前支持 mp3,amr,wma,m4a,spx,ogg,wav,flac
}
Begin
	result:=(
		PtoS(
			CQ_getRecordV2(AuthCode,StoP(filename),StoP(format))
		)
	)
End;
function CQ_i_getRecordV2(filename:widestring;format:ansistring):ansistring;overload;
{
filename 收到消息中的语音文件名(file)
format 应用所需的语音文件格式，目前支持 mp3,amr,wma,m4a,spx,ogg,wav,flac
}
Begin
	result:=(
		PtoS(
			CQ_getRecordV2(AuthCode,StoP(CoolQ_Tools_WideToAnsi(filename)),StoP(format))
		)
	)
End;

//Auth=30 接收消息中的图片(image),返回图片文件绝对路径 //getImage
function CQ_i_getImage(filename:ansistring):ansistring;overload;
{
filename 收到消息中的图片文件名(file)
}
Begin
	result:=(
		PtoS(
			CQ_getImage(AuthCode,StoP(filename))
		)
	)
End;
function CQ_i_getImage(filename:widestring):ansistring;overload;
{
filename 收到消息中的图片文件名(file)
}
Begin
	result:=(
		PtoS(
			CQ_getImage(AuthCode,StoP(CoolQ_Tools_WideToAnsi(filename)))
		)
	)
End;

//文本到匿名
function CQ_Tools_TextToAnonymous(source:ansistring;
									Var Anonymous:CQ_Type_GroupAnonymous):boolean;
Var
	data:ansistring;
	i	:longint;
Begin
	if source='' then begin
		result:=false;
		exit;
	end;
	data:=Base64_Decryption(source);
	if length(data)<12 then begin
		result:=false;
		exit;
	end;
	i:=1;
	Anonymous.AID:=CoolQ_Tools_Unpack_GetNum(i,8,data);
	Anonymous.name:=CoolQ_Tools_AnsiToWide(CoolQ_Tools_Unpack_GetStr(i,data));
	Anonymous.Token:=CoolQ_Tools_Unpack_GetStr(i,data);

	result:=true;
End;

//文本到群员 -- 传递的data内容是已Base64解码后的内容
function CQ_Tools_TextToGroupMember_Main(data:ansistring;
									Var info:CQ_Type_GroupMember):boolean;
Var
	i:longint;
Begin
	if length(data)<40 then begin
		result:=false;
		exit;
	end;
	i:=1;
	info.groupid:=CoolQ_Tools_Unpack_GetNum(i,8,data);
	info.QQID:=CoolQ_Tools_Unpack_GetNum(i,8,data);
	info.nick:=CoolQ_Tools_AnsiToWide(CoolQ_Tools_Unpack_GetStr(i,data));
	info.card:=CoolQ_Tools_AnsiToWide(CoolQ_Tools_Unpack_GetStr(i,data));
	info.sex:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.age:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.aera:=CoolQ_Tools_AnsiToWide(CoolQ_Tools_Unpack_GetStr(i,data));
	info.jointime:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.lastsent:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.level_name:=CoolQ_Tools_AnsiToWide(CoolQ_Tools_Unpack_GetStr(i,data));
	info.permission:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.unfriendly:=CoolQ_Tools_Unpack_GetNum(i,4,data)=1;
	info.title:=CoolQ_Tools_AnsiToWide(CoolQ_Tools_Unpack_GetStr(i,data));
	info.titleExpiretime:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.nickcanchange:=CoolQ_Tools_Unpack_GetNum(i,4,data)=1;

	result:=(true);
End;

//文本到群成员 -- 传递的scource内容是未Base64解码后的内容
function CQ_Tools_TextToGroupMember(source:ansistring;
									Var info:CQ_Type_GroupMember):boolean;
Var
	data:ansistring;
Begin
	if source='' then begin
		result:=false;
		exit;
	end;
	data:=Base64_Decryption(source);
	result:=(CQ_Tools_TextToGroupMember_Main(data,info));
End;


//文本到群成员列表
function CQ_Tools_TextToGroupMemberList(source:ansistring;Var GroupMemberList:CQ_Type_GroupMember_List):boolean;
Var
	data	:	ansistring;
	i,j		:	longint;
Begin
	if source='' then begin
		result:=false;
		exit;
	end;
	data:=Base64_Decryption(source);
	if length(data)<10 then begin
		result:=false;
		exit;
	end;
	i:=1;
	GroupMemberList.l:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	SetLength(GroupMemberList.s,GroupMemberList.l);
	for j:=0 to GroupMemberList.l-1 do begin
		if CoolQ_Tools_Unpack_GetLenRemain(i,data)<=0
			then
			begin
				result:=false;
				exit;
			end
			else
			begin
				if CQ_Tools_TextToGroupMember_Main(CoolQ_Tools_Unpack_GetStr(i,data),GroupMemberList.s[j])=false then begin
					result:=false;
					exit;
				end;
			end;
	end;
	result:=true;
End;

//文本到群文件
Function CQ_Tools_TextToFile(source:ansistring;Var info:CQ_Type_GroupFile):boolean;
Var
	data:ansistring;
	i:longint;
Begin
	if source='' then begin
		result:=false;
		exit;
	end;
	data:=Base64_Decryption(source);
	if length(data)<20 then begin
		result:=false;
		exit;
	end;
	i:=1;
	info.FileID:=CoolQ_Tools_Unpack_GetStr(i,data);
	info.FileName:=CoolQ_Tools_AnsiToWide(CoolQ_Tools_Unpack_GetStr(i,data));
	info.Size:=CoolQ_Tools_Unpack_GetNum(i,8,data);
	info.busid:=CoolQ_Tools_Unpack_GetNum(i,8,data);
	
	result:=true;
End;

//其他_转换_ansihex到群信息
Function CQ_Tools_TextToGroupInfo(source:ansistring;Var GroupInfo:CQ_Type_GroupInfo):boolean;
Var
	i:longint;
Begin
	if length(source)<10 then begin
		result:=false;
		exit;
	end;
	i:=1;
	GroupInfo.GroupID:=CoolQ_Tools_Unpack_GetNum(i,8,source);
	GroupInfo.name:=CoolQ_Tools_AnsiToWide(CoolQ_Tools_Unpack_GetStr(i,source));

	result:=true;
End;

//其他_转换_文本到群列表信息a
Function CQ_Tools_TextToGroupListInfo(source:ansistring;Var GroupList:CQ_Type_GroupList):boolean;
Var
	data:ansistring;
	i,j:longint;
Begin
	if source='' then begin
		result:=false;
		exit;
	end;
	data:=Base64_Decryption(source);
	if length(data)<4 then begin
		result:=false;
		exit;
	end;
	i:=1;
	GroupList.l:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	SetLength(GroupList.s,GroupList.l);
	for j:=0 to GroupList.l-1 do begin
		if CoolQ_Tools_Unpack_GetLenRemain(i,data)<=0
			then
			begin
				result:=false;
				exit;
			end
			else
			begin
				if CQ_Tools_TextToGroupInfo(CoolQ_Tools_Unpack_GetStr(i,data),GroupList.s[j])=false then begin
					result:=false;
					exit;
				end;
			end;
	end;
	result:=true;
End;

//其他_转换_ansihex到好友信息
Function CQ_Tools_TextToFriendInfo(source:ansistring;Var FriendInfo:CQ_Type_Friend):boolean;
Var
	i:longint;
Begin
	if length(source)<12 then begin
		result:=false;
		exit;
	end;
	i:=1;
	FriendInfo.QQID:=CoolQ_Tools_Unpack_GetNum(i,8,source);
	FriendInfo.nick:=CoolQ_Tools_AnsiToWide(CoolQ_Tools_Unpack_GetStr(i,source));
	FriendInfo.alias:=CoolQ_Tools_AnsiToWide(CoolQ_Tools_Unpack_GetStr(i,source));

	result:=true;
End;

Function CQ_Tools_TextToFriendsListInfo(source:ansistring;Var FriendsList:CQ_Type_FriendsList):boolean;
Var
	data:ansistring;
	i,j:longint;
Begin
	if source='' then begin
		result:=false;
		exit;
	end;
	data:=Base64_Decryption(source);
	if length(data)<4 then begin
		result:=false;
		exit;
	end;
	i:=1;
	FriendsList.l:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	SetLength(FriendsList.s,FriendsList.l);
	for j:=0 to FriendsList.l-1 do begin
		if CoolQ_Tools_Unpack_GetLenRemain(i,data)<=0
			then
			begin
				result:=false;
				exit;
			end
			else
			begin
				if CQ_Tools_TextToFriendInfo(CoolQ_Tools_Unpack_GetStr(i,data),FriendsList.s[j])=false then begin
					result:=false;
					exit;
				end;
			end;
	end;
	result:=true;
End;


//获取Cookies Auth=20 慎用,此接口需要严格授权 //getCookies
Function CQ_i_getCookies():ansistring;
Begin
	result:=PtoS(CQ_GetCookies(AuthCode));
End;

//获取Cookies Auth=20 慎用,此接口需要严格授权 //getCookiesV2
{
	domain 目标域名，如 api.example.com
}
Function CQ_i_getCookiesV2(domain:ansistring):ansistring;
Begin
	result:=PtoS(CQ_getCookiesV2(AuthCode,StoP(domain)));
End;

//获取CsrfToken Auth=20 即QQ网页用到的bkn/g_tk等 慎用,此接口需要严格授权 //getCsrfToken
Function CQ_i_getCsrfToken():longint;
Begin
	result:=(CQ_GetCsrfToken(AuthCode));
End;

//取登陆QQ getLoginQQ
Function CQ_i_getLoginQQ():int64;
Begin
	result:=(CQ_GetLoginQQ(authcode));
End;

//取登陆QQ昵称　getLoginNick
Function CQ_i_getLoginNick():widestring;
Begin
	result:=CoolQ_Tools_AnsiToWide(CQ_GetLoginNick(AuthCode))
End;

//取陌生人信息 Auth=131 //CQ_getStrangerInfo
Function CQ_i_getStrangerInfo(QQ:int64;Var info:CQ_Type_QQ;nocache:boolean):longint;
Var
	data:ansistring;
	i:longint;
Begin
	if nocache
		then data:=PtoS(CQ_GetStrangerInfo(AuthCode,QQ,1))
		else data:=PtoS(CQ_GetStrangerInfo(AuthCode,QQ,0));
	data:=Base64_Decryption(data);
	if length(data)<18 then begin
		result:=-1000;
		exit;
	end;
	i:=1;
	info.QQID:=CoolQ_Tools_Unpack_GetNum(i,8,data);
	info.nick:=CoolQ_Tools_AnsiToWide(CoolQ_Tools_Unpack_GetStr(i,data));
	info.sex:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.age:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	
	result:=0;
End;

// 取群信息 Auth=132 //getGroupInfo
Function CQ_i_getGroupInfo(groupID:int64;Var info:CQ_Type_Group;nocache:boolean):longint;
Var
	data:ansistring;
	i:longint;
Begin
	if nocache
		then data:=PtoS(CQ_getGroupInfo(AuthCode,groupID,1))
		else data:=PtoS(CQ_getGroupInfo(AuthCode,groupID,0));
	data:=Base64_Decryption(data);
	if length(data)<18 then begin
		result:=-1000;
		exit;
	end;
	i:=1;
	info.groupID:=CoolQ_Tools_Unpack_GetNum(i,8,data);
	info.name:=CoolQ_Tools_AnsiToWide(CoolQ_Tools_Unpack_GetStr(i,data));
	info.members.current:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.members.max:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	
	result:=0;
End;

//取群成员信息 Auth=130 //getGroupMemberInfoV2
function CQ_i_getGroupMemberInfo(groupid,qqid:int64;
								Var info:CQ_Type_GroupMember;
								nocache:boolean):longint;
Var
	return:ansistring;
Begin
	if nocache
		then return:=PtoS(CQ_getGroupMemberInfoV2(AuthCode,groupid,QQID,1))
		else return:=PtoS(CQ_getGroupMemberInfoV2(AuthCode,groupid,QQID,0));
	if return='' then begin
		result:=-1000;
		exit;
	end;
	if CQ_Tools_TextToGroupMember(return,info)=false then begin
		result:=-1000;
		exit;
	end;
	result:=0;
End;

//返回的路径末尾带"\" //getAppDirectory
function CQ_i_getAppDirectory:ansistring;
Begin
	result:=(PtoS(CQ_getAppDirectory(AuthCode)));
End;

{成功返回日志ID //addlog
	priority 数值请看常量列表 CQLOG_*
	category 是类型
	content 是日志内容
}
function CQ_i_addLog(priority:longint;const category,content:ansistring):longint;overload;
Begin
	result:=(CQ_addLog(AuthCode,priority,StoP(category),StoP(content)));
End;
function CQ_i_addLog(priority:longint;const category,content:widestring):longint;overload;
Begin
	result:=(CQ_addLog(AuthCode,priority,StoP(CoolQ_Tools_WideToAnsi(category)),StoP(CoolQ_Tools_WideToAnsi(content))));
End;

//添加好友请求回复 Auth=150 //setFriendAddRequest
function CQ_i_setFriendAddRequest(const responseflag:ansistring;responseoperation:longint;const remark:ansistring):longint;overload;
Begin
	result:=(CQ_setFriendAddRequest(authcode,
								StoP(responseflag),			//通过事件函数传递获得
								responseoperation,		//通过常量表获得
								StoP(remark)))			//添加后好友备注
End;
function CQ_i_setFriendAddRequest(const responseflag:ansistring;responseoperation:longint;const remark:widestring):longint;overload;
Begin
	result:=(CQ_setFriendAddRequest(authcode,
								StoP(responseflag),			//通过事件函数传递获得
								responseoperation,		//通过常量表获得
								StoP(CoolQ_Tools_WideToAnsi(remark))));			//添加后好友备注
End;

//置匿名群员禁言 Auth=124 //setGroupAnonymousBan
function CQ_i_setGroupAnonymousMute(group:int64;fromAnonymous:ansistring;duration:int64):longint;
Begin
	result:=(CQ_setGroupAnonymousBan(authcode,
								group,
								StoP(fromAnonymous),		//通过事件函数传递获得
								duration));					//禁言时长 单位秒 不支持解禁
End;

//置全群禁言 Auth=123 //setGroupWholeBan
function CQ_i_setGroupWholeMute(groupid:int64;enableban:boolean):longint;
Begin
	if enableban
		then result:=(CQ_setGroupWholeBan(AuthCode,groupid,1))
		else result:=(CQ_setGroupWholeBan(AuthCode,groupid,0));
End;

//置群成员名片 Auth=126 //setGroupCard
function CQ_i_setGroupCard(group,qq:int64;nick:ansistring):longint;overload;
Begin
	result:=(CQ_setGroupCard(authcode,
						group,
						qq,
						StoP(nick)))
End;
function CQ_i_setGroupCard(group,qq:int64;nick:widestring):longint;overload;
Begin
	result:=(CQ_setGroupCard(authcode,
						group,
						qq,
						StoP(CoolQ_Tools_WideToAnsi(nick))));
End;

//置群员专属头衔 Auth=128 需群主权限 //setGroupSpecialTitle
Function CQ_i_setGroupSpecialTitle(Group,ID:int64;Title:ansistring;duration:int64):longint;overload;
Begin
	result:=(CQ_setGroupSpecialTitle(authcode,
								group,				//目标群
								id,					//目标QQ
								StoP(title),		//若要删除头衔，则留空
								duration));			//专属头衔有效期，单位为秒。如果永久有效，这里填写-1
End;
Function CQ_i_setGroupSpecialTitle(Group,ID:int64;Title:widestring;duration:int64):longint;overload;
Begin
	result:=(CQ_setGroupSpecialTitle(authcode,
								group,				//目标群
								id,					//目标QQ
								StoP(CoolQ_Tools_WideToAnsi(title)),		//若要删除头衔，则留空
								duration))			//专属头衔有效期，单位为秒。如果永久有效，这里填写-1
End;


{
	置群管理员 Auth=122 //setGroupAdmin
	operation true设置成管理员 false取消管理员
}
Function CQ_i_setGroupAdmin(group,qq:int64;operation:boolean):longint;
Begin
	if operation
		then result:=(CQ_SetGroupAdmin(authcode,group,qq,1))
		else result:=(CQ_SetGroupAdmin(authcode,group,qq,0));
End;

{
	置群匿名设置 Auth=125 //setGroupAnonymous
	operation true开启匿名 false关闭匿名
}
Function CQ_i_setGroupAnonymous(group:int64;operation:boolean):longint;
Begin
	if operation
		then result:=(CQ_setGroupAnonymous(AuthCode,group,1))
		else result:=(CQ_setGroupAnonymous(AuthCode,group,0))
End;


//置群添加请求 Auth=151 //setGroupAddRequest
Function CQ_i_setGroupAddRequest(responseflag:ansistring;	//请求事件收到的“responseflag”参数
								subtype		:longint;	//根据请求事件的子类型区分 #请求_群添加 或 #请求_群邀请
								responseoperation:longint;	//#请求_通过 或 #请求_拒绝
								reason		:ansistring 	//操作理由，仅 #请求_群添加 且 #请求_拒绝 时可用
								):longint;overload;
Begin
	result:=(
		CQ_setGroupAddRequestV2(
			AuthCode,
			StoP(responseflag),
			subtype,
			responseoperation,
			StoP(reason)
		)
	);
End;
Function CQ_i_setGroupAddRequest(responseflag:ansistring;	//请求事件收到的“responseflag”参数
								subtype		:longint;	//根据请求事件的子类型区分 #请求_群添加 或 #请求_群邀请
								responseoperation:longint;	//#请求_通过 或 #请求_拒绝
								reason		:widestring 	//操作理由，仅 #请求_群添加 且 #请求_拒绝 时可用
								):longint;overload;
Begin
	result:=(
		CQ_setGroupAddRequestV2(
			AuthCode,
			StoP(responseflag),
			subtype,
			responseoperation,
			StoP(CoolQ_Tools_WideToAnsi(reason))
		)
	)
End;

{
置群退出 Auth=127 慎用,此接口需要严格授权 //setGroupLeave
Disband true解散本群[群主] false退出本群[群管/群员]
}
Function CQ_i_setGroupLeave(group:int64;isdisband:boolean):longint;
Begin
	if isdisband
		then result:=(CQ_setGroupLeave(Authcode,Group,1))
		else result:=(CQ_setGroupLeave(Authcode,Group,0));
End;

//置群员禁言 Auth=121 //setGroupBan
function CQ_i_setGroupMute(groupid,QQID,duration:int64):longint;
Begin
	result:=(CQ_setGroupBan(AuthCode,groupid,QQID,duration));
End;

//置群员移除 Auth=120 //setGroupKick
function CQ_i_setGroupKick(groupid,QQID:int64;rejectaddrequest:boolean):longint;
Begin
	if rejectaddrequest
		then result:=(CQ_setGroupKick(AuthCode,Groupid,QQID,1))
		else result:=(CQ_setGroupKick(AuthCode,Groupid,QQID,0));
End;

//置讨论组退出 Auth=140 //setDiscussLeave
function CQ_i_setDiscussLeave(DiscussID:int64):longint;
Begin
	result:=(CQ_setDiscussLeave(authcode,DiscussID));
End;

//置致命错误提示 //setFatal
function CQ_i_setFatal(msg:ansistring):longint;overload;
Begin
	result:=(CQ_setFatal(authcode,StoP(msg)));
End;
function CQ_i_setFatal(msg:widestring):longint;overload;
Begin
	result:=(CQ_setFatal(authcode,StoP(CoolQ_Tools_WideToAnsi(msg))));
End;

//取群成员列表 Auth=160 //getGroupMemberList
function CQ_i_getGroupMemberList(GroupID:int64;Var GroupMemberList:CQ_Type_GroupMember_List):longint;
Var
	return	:	ansistring;
Begin
	return:=PtoS(CQ_getGroupMemberList(AuthCode,GroupID));
	if return='' then begin
		result:=-1000;
		exit;
	end
	else
	if CQ_Tools_TextToGroupMemberList(return,GroupMemberList)=false then begin
		result:=-1000;
		exit;
	end;
	result:=0;
End;

//取群列表 Auth=161  //getGroupList
function CQ_i_getGroupList(Var GroupList:CQ_Type_GroupList):longint;
Var
	return	:	ansistring;
Begin
	return:=PtoS(CQ_getGroupList(AuthCode));
	if return='' then begin
		result:=-1000;
		exit;
	end
	else
	if CQ_Tools_TextToGroupListInfo(return,GroupList)=false then begin
		result:=-1000;
		exit;
	end;
	result:=0;
End;

//撤回消息 Auth=180 //deleteMsg
function CQ_i_deleteMsg(msgID:int64):longint;
Begin
	result:=(CQ_deleteMsg(AuthCode,msgID));
End;

//取好友列表 Auth=162  //getFriendList
function CQ_i_getFriendList(Var friendList:CQ_Type_FriendsList):longint;
Var
	return	:	ansistring;
Begin
	return:=PtoS(CQ_getFriendList(AuthCode,0));
	if return='' then begin
		result:=-1000;
		exit;
	end
	else
	if CQ_Tools_TextToFriendsListInfo(return,friendList)=false then begin
		result:=-1000;
		exit;
	end;
	result:=0;
End;

//是否支持发送图片，返回大于 0 为支持，等于 0 为不支持
function CQ_i_canSendImage():longint;
Begin
	result:=CQ_canSendImage(AuthCode);
End;

//是否支持发送语音，返回大于 0 为支持，等于 0 为不支持
function CQ_i_canSendRecord(AuthCode:longint):longint;
Begin
	result:=CQ_canSendRecord(AuthCode);
End;

initialization
	InitBase64;
end.
