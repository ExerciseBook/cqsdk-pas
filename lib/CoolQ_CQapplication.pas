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
QQID为被@的群成员QQ。该参数为-1，则@全体成员，若次数用尽或权限不足则会转换为文本。
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
function CQCode_record(url:ansistring;magic:boolean):ansistring;
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
//发送私聊 Auth=106 //sendPrivateMsg
function CQ_i_sendPrivateMsg(QQID:int64;msg:ansistring):longint;		//Auth=106 //sendPrivateMsg
Begin
	exit(CQ_sendPrivateMsg(AuthCode,QQID,StoP(msg)));
End;
//发送群聊 Auth=101 //sendGroupMsg
function CQ_i_sendGroupMsg(groupid:int64;const msg:ansistring):longint;	//Auth=101 //sendGroupMsg
Begin
	exit(CQ_sendGroupMsg(AuthCode,groupid,StoP(msg)));
End;
//发送讨论组 Auth=103 //sendDiscussMsg
function CQ_i_sendDiscussMsg(DiscussID:int64;msg:ansistring):longint;	//Auth=103 //sendDiscussMsg
Begin
	exit(CQ_sendDiscussMsg(AuthCode,DiscussID,StoP(msg)));
End;
//发送赞 Auth=110 //sendLike
function CQ_i_sendLike(QQID:int64):longint;								//Auth=110 //sendLike
Begin
	exit(CQ_sendLike(AuthCode,QQID));
End;
//接受语音 Auth=30 接收消息中的语音(record),返回保存在 \data\record\ 目录下的文件名 //getRecord
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
//文本到匿名
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
//文本到群员
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
//文本到群文件
Function CQ_Tools_TextToFile(source:string;info:CQ_Type_GroupFile):boolean;
Var
	data:ansistring;
	i:longint;
Begin
	if source='' then exit(false);
	data:=Base64_Decryption(source);
	if length(data)<20 then exit(false);
	i:=1;
	info.FileID:=CoolQ_Tools_GetStr(i,data);
	info.FileName:=CoolQ_Tools_GetStr(i,data);
	info.Size:=CoolQ_Tools_GetNum(i,8,data);
	info.busid:=CoolQ_Tools_GetNum(i,8,data);
	exit(true);
End;

//获取Cookies Auth=20 慎用,此接口需要严格授权 //getCookies
Function CQ_i_GetCookies():ansistring;
Begin
	exit(CQ_GetCookies(AuthCode));
End;

//获取CQ_i_getCsrfToken Auth=20 即QQ网页用到的bkn/g_tk等 慎用,此接口需要严格授权 //getCsrfToken
Function CQ_i_getCsrfToken():longint;
Begin
	exit(CQ_GetCsrfToken(AuthCode));
End;

//取登陆QQ getLoginQQ
Function CQ_i_GetLoginQQ():int64;
Begin
	exit(CQ_GetLoginQQ(authcode));
End;

//取登陆QQ昵称　getLoginNick
Function CQ_i_getLoginNick():string;
Begin
	exit(CQ_GetLoginNick(AuthCode));
End;

//取陌生人信息 Auth=131 //CQ_getStrangerInfo
Function CQ_i_GetStrangerInfo(QQ:int64;Var info:CQ_Type_QQ;nocache:boolean):longint;
Var
	data:string;
	i:longint;
Begin
	data:=CQ_GetStrangerInfo(AuthCode,QQ,Nocache);
	if data='' then exit(-1000);
	i:=1;
	info.QQID:=CoolQ_Tools_GetNum(i,8,data);
	info.nick:=CoolQ_Tools_GetStr(i,data);
	info.sex:=CoolQ_Tools_GetNum(i,4,data);
	info.age:=CoolQ_Tools_GetNum(i,4,data);
End;

//取群成员信息 Auth=130 //getGroupMemberInfoV2
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

//返回的路径末尾带"\" //getAppDirectory
function CQ_i_getAppDirectory:ansistring;
Begin
	exit(PtoS(CQ_getAppDirectory(AuthCode)));
End;

{成功返回日志ID //addlog
	priority 数值请看常量列表 CQLOG_*
	category是类型
	content是日志内容
}
function CQ_i_addLog(priority:longint;const category,content:ansistring):longint;
Begin
	exit(CQ_addLog(AuthCode,priority,StoP(category),StoP(content)));
End;

//添加好友请求回复 Auth=150 //setFriendAddRequest
function CQ_i_setFriendAddRequest(const responseflag:pchar;responseoperation:longint;const remark:string):longint;
Begin
	exit(CQ_setFriendAddRequest(authcode,
								responseflag,			//通过事件函数传递获得
								responseoperation,		//通过常量表获得
								StoP(remark)));			//添加后好友备注
End;

//置匿名群员禁言 Auth=124 //setGroupAnonymousBan
function CQ_i_setGroupAnonymousMute(group:int64;fromAnonymous:string;duration:int64):longint;
Begin
	exit(CQ_setGroupAnonymousBan(authcode,
								group,
								StoP(fromAnonymous),		//通过事件函数传递获得
								duration));					//禁言时长 单位秒 不支持解禁
End;

//置全群禁言 Auth=123 //setGroupWholeBan
function CQ_i_setGroupWholeMute(groupid:int64;enableban:boolean):longint;
Begin
	exit(CQ_setGroupWholeBan(AuthCode,groupid,enableban));
End;

//置群成员名片 Auth=126 //setGroupCard
function CQ_i_setGroupCard(group,qq:int64;nick:string):longint;
Begin
	exit(CQ_setGroupCard(authcode,
						group,
						qq,
						StoP(nick)))
End;

//置群员专属头衔 Auth=128 需群主权限 //setGroupSpecialTitle
Function CQ_i_setGroupSpecialTitle(Group,ID:int64;Title:string;duration:int64):longint;
Begin
	exit(CQ_setGroupSpecialTitle(authcode,
								group,				//目标群
								id,					//目标QQ
								StoP(title),		//若要删除头衔，则留空
								duration));			//专属头衔有效期，单位为秒。如果永久有效，这里填写-1
End;


{
	置群管理员 Auth=122 //setGroupAdmin
	operation true设置成管理员 false取消管理员
}
Function CQ_i_setGroupAdmin(group,qq:int64;operation:boolean):longint;
Begin
	exit(CQ_SetGroupAdmin(authcode,group,qq,operation));
End;

{
	置群匿名设置 Auth=125 //setGroupAnonymous
	operation true开启匿名 false关闭匿名
}
Function CQ_i_setGroupAnonymous(group:int64;operation:boolean):longint;
Begin
	exit(CQ_setGroupAnonymous(AuthCode,group,operation));
End;


//置群添加请求 Auth=151 //setGroupAddRequest
Function CQ_i_setGroupAddRequest(responseflag:string;	//请求事件收到的“responseflag”参数
								subtype		:longint;	//根据请求事件的子类型区分 #请求_群添加 或 #请求_群邀请
								responseoperation:longint;	//#请求_通过 或 #请求_拒绝
								reason		:string 	//操作理由，仅 #请求_群添加 且 #请求_拒绝 时可用
								):longint;
Begin
	exit(
		CQ_setGroupAddRequestV2(
			AuthCode,
			StoP(responseflag),
			subtype,
			responseoperation,
			StoP(reason)
		)
	);
End;

{
置群退出 Auth=127 慎用,此接口需要严格授权 //setGroupLeave
Disband true解散本群[群主] false退出本群[群管/群员]
}
Function CQ_i_setGroupLeave(group:int64;isdisband:boolean):longint;
Begin
	exit(CQ_setGroupLeave(Authcode,Group,IsDisband));
End;

//置群员禁言 Auth=121 //setGroupBan
function CQ_i_setGroupMute(groupid,QQID,duration:int64):longint;
Begin
	exit(CQ_setGroupBan(AuthCode,groupid,QQID,duration));
End;

//置群员移除 Auth=120 //setGroupKick
function CQ_i_setGroupKick(groupid,QQID:int64;rejectaddrequest:boolean):longint;
Begin
	exit(CQ_setGroupKick(AuthCode,Groupid,QQID,rejectaddrequest));
End;

//置讨论组退出 Auth=140 //setDiscussLeave
function CQ_i_setDiscussLeave(DiscussID:int64):longint;
Begin
	exit(CQ_setDiscussLeave(authcode,DiscussID));
End;

//置致命错误提示 //setFatal
function CQ_i_setFatal(msg:ansistring):longint;
Begin
	exit(CQ_setFatal(authcode,StoP(msg)));
End;