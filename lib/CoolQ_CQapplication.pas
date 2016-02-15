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

{
QQID为被@的群成员QQ。该参数为all，则@全体成员，若次数用尽或权限不足则会转换为文本。
举例：[CQ:at,qq=123456]
}
function CQCode_Group_At(QQID:int64):ansistring;
Begin
	exit('[CQ:at,qq='+String_Choose(QQID=-1,'all',NumToChar(QQID))+']');
End;

{
ID为emoji字符的unicode编号
举例：[CQ:emoji,id=128513]（发送一个大笑的emoji表情）
}
function CQCode_emoji(ID:int64):ansistring;
Begin
	exit('[CQ:at,emoji='+NumToChar(ID)+']');
End;

{
ID为0-170的数字
举例：[CQ:face,id=14]（发送一个微笑的QQ表情）
}
function CQCode_face(ID:int64):ansistring;
Begin
	exit('[CQ:at,face='+NumToChar(ID)+']');
End;

//窗口抖动（仅支持好友消息使用）
function CQCode_Shake:ansistring;
Begin
	exit('[CQ:shake]');
End;

{
本CQ码需加在消息的开头。
当 Force 为false时，代表不强制使用匿名，如果匿名失败将转为普通消息发送。
当 Force 为true时，代表强制使用匿名，如果匿名失败将取消该消息的发送。
举例：
}
function CQCode_anonymous(Force:boolean):ansistring;	
Begin
	exit('[CQ:anonymous'+String_Choose(Force,'',',ignore=true')+']');
End;

{
url为图片文件名称，图片存放在酷Q目录的data\image\下
举例：[CQ:image,file=1.jpg]（发送data\image\1.jpg）
}
function CQCode_image(url:ansistring):ansistring;
Begin
	exit('[CQ:image,file='+CQ_CharEncode(url,true)+']')
End;

{
source为音乐平台类型，目前支持qq、163、xiami
musicid为对应音乐平台的数字音乐id
注意：音乐只能作为单独的一条消息发送
举例：
[CQ:music,type=qq,id=422594]（发送一首QQ音乐的“Time after time”歌曲到群内）
[CQ:music,type=163,id=28406557]（发送一首网易云音乐的“桜咲く”歌曲到群内）
}
function CQCode_Music(source:string;musicid:int64):ansistring;
Begin
	exit('[CQ:music,type='+source+',id='+NumToChar(musicid)+']')
	{返回 (“[CQ:music,id=” ＋ 到文本 (歌曲ID) ＋ “]”)}
End;

{
id为该原创表情的ID，存放在酷Q目录的data\bface\下
}
function CQCode_bface(ID:int64):ansistring;
Begin
	exit('[CQ:bface,id='+NumToChar(ID)+']');
End;

{
1为音频文件名称，音频存放在酷Q目录的data\record\下
2为是否为变声，若该参数为true则显示变声标记。该参数可被忽略。
举例：[CQ:record,file=1.silk，magic=true]（发送data\record\1.silk，并标记为变声）
}
function CQCode_image(url:ansistring;magic:boolean):ansistring;
Begin
	exit('[CQ:record,file='+CQ_CharEncode(url,true)+String_Choose(magic,',magic=true','')+']');
End;

{
id为猜拳结果的类型，暂不支持发送时自定义。该参数可被忽略。
1 - 猜拳结果为石头
2 - 猜拳结果为剪刀
3 - 猜拳结果为布
}
function CQCode_rps(ID:int64):ansistring;
Begin
	exit('[CQ:rps,id='+NumToChar(ID)+']');
End;

{
id对应掷出的点数，暂不支持发送时自定义。该参数可被忽略。
}
function CQCode_dice(ID:int64):ansistring;
Begin
	exit('[CQ:dice,id='+NumToChar(ID)+']');
End;

{
[CQ:share,url=” ＋ CQ码_转义 (url地址, 真) ＋ “,title=” ＋ CQ码_转义 (卡片标题, 真) ＋ “,content=” ＋ CQ码_转义 (卡片内容, 真) ＋ “,image=” ＋ CQ码_转义 (卡片图片url, 真) ＋ “]

}
function CQCode_share(url,title,Content,image:ansistring):ansistring;
Begin
	exit('[CQ:share,url='+CQ_CharEncode(url,true)+',title='+CQ_CharEncode(title,true)+',content='+CQ_CharEncode(content,true)+',image='+CQ_CharEncode(image,true)+']');
End;

{API}
function CQ_i_sendPrivateMsg(QQID:int64;msg:ansistring):longint;		//Auth=106 //sendPrivateMsg
Begin
	exit(CQ_sendPrivateMsg(AuthCode,QQID,StoP(msg)));
End;

function CQ_i_sendGroupMsg(groupid:int64;const msg:ansistring):longint;	//Auth=101 //sendGroupMsg
Begin
	exit(CQ_sendGroupMsg(AuthCode,groupid,StoP(msg)));
End;

function CQ_i_sendDiscussMsg(DiscussID:int64;msg:ansistring):longint;	//Auth=103 //sendDiscussMsg
Begin
	exit(CQ_sendDiscussMsg(AuthCode,DiscussID,StoP(msg)));
End;

function CQ_i_sendLike(QQID:int64):longint;								//Auth=110 //sendLike
Begin
	exit(CQ_sendLike(AuthCode,QQID));
End;

function CQ_i_getRecord(filename,format:ansistring):ansistring;			//Auth=30 接收消息中的语音(record),返回保存在 \data\record\ 目录下的文件名 //getRecord
{
filename 收到消息中的语音文件名(file)
format 应用所需的语音文件格式，目前支持 mp3,amr,wma,m4a,spx,ogg,wav,flac
}
Begin
	exit(
		PtoS(
			CQ_getRecord(AuthCode,StoP(filename),StoP(format))
		)
	)
End;


function CQ_Tools_TextToAnonymous(source:ansistring;
									Var Anonymous:CQ_Type_GroupAnonymous):boolean;
Var
	data:ansistring;
	i	:longint;
Begin
	if source='' then exit(false);	
	data:=Base64_Decryption(source);
	if length(data)<12 then exit(false);
	i:=1;
	Anonymous.AID:=CoolQ_Tools_GetNum(i,8,data);
	Anonymous.name:=CoolQ_Tools_GetStr(i,data);
	Anonymous.Token:=CoolQ_Tools_GetStr(i,data);
	
	exit(true);
End;

function CQ_Tools_TextToGroupMember(source:ansistring;
									Var info:CQ_Type_GroupMember):boolean;
Var
	data:ansistring;
	i:longint;
Begin
	if source='' then exit(false);
	data:=Base64_Decryption(source);
	if length(data)<60 then exit(false);
	i:=1;
	info.groupid:=CoolQ_Tools_GetNum(i,8,data);
	info.QQID:=CoolQ_Tools_GetNum(i,8,data);
	info.username:=CoolQ_Tools_GetStr(i,data);
	info.nick:=CoolQ_Tools_GetStr(i,data);
	info.sex:=CoolQ_Tools_GetNum(i,4,data);
	info.age:=CoolQ_Tools_GetNum(i,4,data);
	info.aera:=CoolQ_Tools_GetStr(i,data);
	info.jointime:=CoolQ_Tools_GetNum(i,4,data);
	info.lastsent:=CoolQ_Tools_GetNum(i,4,data);
	info.level_name:=CoolQ_Tools_GetStr(i,data);
	info.permission:=CoolQ_Tools_GetNum(i,4,data);
	info.unfriendly:=CoolQ_Tools_GetNum(i,4,data)=1;
	info.title:=CoolQ_Tools_GetStr(i,data);
	info.titleExpiretime:=CoolQ_Tools_GetNum(i,4,data);
	info.nickcanchange:=CoolQ_Tools_GetNum(i,4,data)=1;
	exit(true);
End;

function CQ_i_getGroupMemberInfo(groupid,qqid:int64;
								Var info:CQ_Type_GroupMember;
								nocache:boolean):longint;
Var
	return:ansistring;
Begin
	return:=CQ_getGroupMemberInfoV2(AuthCode,groupid,QQID,nocache);
	if return='' then exit(-1000);
	if CQ_Tools_TextToGroupMember(return,info)=false then exit(-1000);
	exit(0);
End;


function CQ_i_addLog(priority:longint;const category,content:ansistring):longint;
Begin
	exit(CQ_addLog(AuthCode,priority,StoP(category),StoP(content)));
End;

function CQ_i_getAppDirectory:ansistring;
Begin
	exit(PtoS(CQ_getAppDirectory(AuthCode)));
End;

function CQ_i_setGroupMute(groupid,QQID,duration:int64):longint;
Begin
	exit(CQ_setGroupBan(AuthCode,groupid,QQID,duration));
End;

function CQ_i_setGroupWholeMute(groupid:int64;enableban:boolean):longint;
Begin
	exit(CQ_setGroupWholeBan(AuthCode,groupid,enableban));
End;

function CQ_i_setGroupKick(groupid,QQID:int64;rejectaddrequest:boolean):longint;
Begin
	exit(CQ_setGroupKick(AuthCode,Groupid,QQID,rejectaddrequest));
End;