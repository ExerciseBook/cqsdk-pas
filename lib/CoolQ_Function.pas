{
* CoolQ 函数
}

{CoolQ API Char* 调用}
function CQ_sendPrivateMsg(AuthCode:longint;QQID:int64;const msg:Pchar):longint;
	stdcall; external 'CQP.dll' name 'CQ_sendPrivateMsg';
function CQ_sendGroupMsg(AuthCode:longint;groupid:int64;const msg:Pchar):longint;
	stdcall; external 'CQP.dll' name 'CQ_sendGroupMsg';
function CQ_sendDiscussMsg(AuthCode:longint;discussid:int64;const msg:Pchar):longint;
	stdcall; external 'CQP.dll' name 'CQ_sendDiscussMsg';
function CQ_sendLike(AuthCode:longint;QQID:int64):longint;
	stdcall; external 'CQP.dll' name 'CQ_sendLike';
function CQ_setGroupAdmin(AuthCode:longint;groupid,QQID:int64;state:boolean):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupAdmin';	
function CQ_setGroupKick(AuthCode:longint;groupid,QQID:int64;rejectaddrequest:boolean):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupKick';
function CQ_setGroupBan(AuthCode:longint;groupid,QQID,duration:int64):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupBan';
function CQ_setGroupWholeBan(AuthCode:longint;groupid:int64;enableban:boolean):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupWholeBan';
function CQ_setGroupAnonymousBan(AuthCode:longint;groupid:int64;const anomymous:Pchar;duration:int64):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupAnonymousBan';
function CQ_setGroupAnonymous(AuthCode:longint;groupid:int64;enableanomymous:boolean):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupAnonymous';
function CQ_setGroupCard(AuthCode:longint;groupid,QQID:int64;newcard:Pchar):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupCard';
function CQ_setGroupLeave(AuthCode:longint;groupid:int64;isdismiss:boolean):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupLeave';
function CQ_setGroupSpecialTitle(AuthCode:longint;groupid,QQID:int64;newspecialtitle:Pchar;duration:int64):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupSpecialTitle';
function CQ_setDiscussLeave(AuthCode:longint;discussid:int64):longint;
	stdcall; external 'CQP.dll' name 'CQ_setDiscussLeave';
function CQ_setFriendAddRequest(AuthCode:longint;const responseflag:pchar;responseoperation:longint;const remark:Pchar):longint;
	stdcall; external 'CQP.dll' name 'CQ_setFriendAddRequest';
function CQ_setGroupAddRequestV2(AuthCode:longint;const responseflag:Pchar;requesttype,responseoperation:longint;const reason:Pchar):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupAddRequestV2';
function CQ_getGroupMemberInfoV2(AuthCode:longint;groupid,QQID:int64;nocache:boolean):Pchar;
	stdcall; external 'CQP.dll' name 'CQ_getGroupMemberInfoV2';	
function CQ_getStrangerInfo(AuthCode:longint;QQID:int64;nocache:boolean):Pchar;
	stdcall; external 'CQP.dll' name 'CQ_getStrangerInfo';	
function CQ_addLog(AuthCode,priority:longint;const category,content:Pchar):longint;
	stdcall; external 'CQP.dll' name 'CQ_addLog';
function CQ_getRecord(AuthCode:longint;filename,format:Pchar):Pchar;
	stdcall; external 'CQP.dll' name 'CQ_getRecord';
function CQ_getCookies(AuthCode:longint):Pchar;
	stdcall; external 'CQP.dll' name 'CQ_getCookies';
function CQ_getCsrfToken(AuthCode:longint):longint;
	stdcall; external 'CQP.dll' name 'CQ_getCsrfToken';
function CQ_getLoginQQ(AuthCode:longint):int64;
	stdcall; external 'CQP.dll' name 'CQ_getLoginQQ';
function CQ_getLoginNick(AuthCode:longint):Pchar;
	stdcall; external 'CQP.dll' name 'CQ_getLoginNick';
function CQ_getAppDirectory(AuthCode:longint):Pchar;
	stdcall; external 'CQP.dll' name 'CQ_getAppDirectory';
function CQ_setFatal(AuthCode:longint;const errorinfo:Pchar):longint;
	stdcall; external 'CQP.dll' name 'CQ_setFatal';
	
{调用简化}
Function CQ_CharEncode(str:ansistring;Comma:boolean):ansistring;
Begin
	Message_Replace(str,'&','&amp;');
	Message_Replace(str,'[','&#91;');
	Message_Replace(str,']','&#93;');
	if Comma then begin
		Message_Replace(str,',','&#44;');
	end;
	exit(Str);
End;
Function CQ_CharDecode(str:ansistring):ansistring;
Begin
	Message_Replace(str,'&amp;','&');
	Message_Replace(str,'&#91;','[');
	Message_Replace(str,'&#93;',']');
	Message_Replace(str,'&#44;',',');
	exit(str);
End;

function CQ_Group_At(QQID:int64):ansistring; //若QQ号为-1 则为At全体成员
Begin
	exit('[CQ:at,qq='+String_Choose(QQID=-1,'all',NumToChar(QQID))+']');
End;
function CQ_emoji(ID:int64):ansistring;
Begin
	exit('[CQ:at,emoji='+NumToChar(ID)+']');
End;
function CQ_face(ID:int64):ansistring;
Begin
	exit('[CQ:at,face='+NumToChar(ID)+']');
End;
function CQ_Shake:ansistring;
Begin
	exit('[CQ:shake]');
End;
function CQ_anonymous(Force:boolean):ansistring;	
{	如果 Force 为 false 的话就会出现 如果匿名无法成功发送则转换为普通发送	}
Begin
	exit('[CQ:anonymous'+String_Choose(Force,'',',ignore=true')+']');
End;
function CQ_image(url:ansistring):ansistring;
Begin
	exit('[CQ:image,file='+CQ_CharEncode(url,true)+']')
End;
function CQ_Music(musicid:int64):ansistring;
Begin
	exit('[CQ:music,id='+NumToChar(musicid)+']')
	{返回 (“[CQ:music,id=” ＋ 到文本 (歌曲ID) ＋ “]”)}
End;


{API}
function CQ_i_sendPrivateMsg(QQID:int64;msg:ansistring):longint;
Begin
	exit(CQ_sendPrivateMsg(AuthCode,QQID,StoP(msg)));
End;

function CQ_i_sendGroupMsg(groupid:int64;const msg:ansistring):longint;
Begin
	exit(CQ_sendGroupMsg(AuthCode,groupid,StoP(msg)));
End;

function CQ_i_addLog(priority:longint;const category,content:ansistring):longint;
Begin
	exit(CQ_addLog(AuthCode,priority,StoP(category),StoP(content)));
End;

function CQ_i_getAppDirectory:ansistring;
Begin
	exit(PtoS(CQ_getAppDirectory(AuthCode)));
End;