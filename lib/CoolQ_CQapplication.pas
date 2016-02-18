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
QQIDΪ��@��Ⱥ��ԱQQ���ò���Ϊ-1����@ȫ���Ա���������þ���Ȩ�޲������ת��Ϊ�ı���
������[CQ:at,qq=123456]
}
function CQCode_Group_At(QQID:int64):ansistring;
Begin
	exit('[CQ:at,qq='+String_Choose(QQID=-1,'all',NumToChar(QQID))+']');
End;

{
IDΪemoji�ַ���unicode���
������[CQ:emoji,id=128513]������һ����Ц��emoji���飩
}
function CQCode_emoji(ID:int64):ansistring;
Begin
	exit('[CQ:at,emoji='+NumToChar(ID)+']');
End;

{
IDΪ0-170������
������[CQ:face,id=14]������һ��΢Ц��QQ���飩
}
function CQCode_face(ID:int64):ansistring;
Begin
	exit('[CQ:at,face='+NumToChar(ID)+']');
End;

//���ڶ�������֧�ֺ�����Ϣʹ�ã�
function CQCode_Shake:ansistring;
Begin
	exit('[CQ:shake]');
End;

{
��CQ���������Ϣ�Ŀ�ͷ��
�� Force Ϊfalseʱ������ǿ��ʹ���������������ʧ�ܽ�תΪ��ͨ��Ϣ���͡�
�� Force Ϊtrueʱ������ǿ��ʹ���������������ʧ�ܽ�ȡ������Ϣ�ķ��͡�
������
}
function CQCode_anonymous(Force:boolean):ansistring;	
Begin
	exit('[CQ:anonymous'+String_Choose(Force,'',',ignore=true')+']');
End;

{
urlΪͼƬ�ļ����ƣ�ͼƬ����ڿ�QĿ¼��data\image\��
������[CQ:image,file=1.jpg]������data\image\1.jpg��
}
function CQCode_image(url:ansistring):ansistring;
Begin
	exit('[CQ:image,file='+CQ_CharEncode(url,true)+']')
End;

{
sourceΪ����ƽ̨���ͣ�Ŀǰ֧��qq��163��xiami
musicidΪ��Ӧ����ƽ̨����������id
ע�⣺����ֻ����Ϊ������һ����Ϣ����
������
[CQ:music,type=qq,id=422594]������һ��QQ���ֵġ�Time after time��������Ⱥ�ڣ�
[CQ:music,type=163,id=28406557]������һ�����������ֵġ��@�D����������Ⱥ�ڣ�
}
function CQCode_Music(source:string;musicid:int64):ansistring;
Begin
	exit('[CQ:music,type='+source+',id='+NumToChar(musicid)+']')
	{���� (��[CQ:music,id=�� �� ���ı� (����ID) �� ��]��)}
End;

{
idΪ��ԭ�������ID������ڿ�QĿ¼��data\bface\��
}
function CQCode_bface(ID:int64):ansistring;
Begin
	exit('[CQ:bface,id='+NumToChar(ID)+']');
End;

{
1Ϊ��Ƶ�ļ����ƣ���Ƶ����ڿ�QĿ¼��data\record\��
2Ϊ�Ƿ�Ϊ���������ò���Ϊtrue����ʾ������ǡ��ò����ɱ����ԡ�
������[CQ:record,file=1.silk��magic=true]������data\record\1.silk�������Ϊ������
}
function CQCode_record(url:ansistring;magic:boolean):ansistring;
Begin
	exit('[CQ:record,file='+CQ_CharEncode(url,true)+String_Choose(magic,',magic=true','')+']');
End;

{
idΪ��ȭ��������ͣ��ݲ�֧�ַ���ʱ�Զ��塣�ò����ɱ����ԡ�
1 - ��ȭ���Ϊʯͷ
2 - ��ȭ���Ϊ����
3 - ��ȭ���Ϊ��
}
function CQCode_rps(ID:int64):ansistring;
Begin
	exit('[CQ:rps,id='+NumToChar(ID)+']');
End;

{
id��Ӧ�����ĵ������ݲ�֧�ַ���ʱ�Զ��塣�ò����ɱ����ԡ�
}
function CQCode_dice(ID:int64):ansistring;
Begin
	exit('[CQ:dice,id='+NumToChar(ID)+']');
End;

{
[CQ:share,url=�� �� CQ��_ת�� (url��ַ, ��) �� ��,title=�� �� CQ��_ת�� (��Ƭ����, ��) �� ��,content=�� �� CQ��_ת�� (��Ƭ����, ��) �� ��,image=�� �� CQ��_ת�� (��ƬͼƬurl, ��) �� ��]

}
function CQCode_share(url,title,Content,image:ansistring):ansistring;
Begin
	exit('[CQ:share,url='+CQ_CharEncode(url,true)+',title='+CQ_CharEncode(title,true)+',content='+CQ_CharEncode(content,true)+',image='+CQ_CharEncode(image,true)+']');
End;

{API}
//����˽�� Auth=106 //sendPrivateMsg
function CQ_i_sendPrivateMsg(QQID:int64;msg:ansistring):longint;		//Auth=106 //sendPrivateMsg
Begin
	exit(CQ_sendPrivateMsg(AuthCode,QQID,StoP(msg)));
End;
//����Ⱥ�� Auth=101 //sendGroupMsg
function CQ_i_sendGroupMsg(groupid:int64;const msg:ansistring):longint;	//Auth=101 //sendGroupMsg
Begin
	exit(CQ_sendGroupMsg(AuthCode,groupid,StoP(msg)));
End;
//���������� Auth=103 //sendDiscussMsg
function CQ_i_sendDiscussMsg(DiscussID:int64;msg:ansistring):longint;	//Auth=103 //sendDiscussMsg
Begin
	exit(CQ_sendDiscussMsg(AuthCode,DiscussID,StoP(msg)));
End;
//������ Auth=110 //sendLike
function CQ_i_sendLike(QQID:int64):longint;								//Auth=110 //sendLike
Begin
	exit(CQ_sendLike(AuthCode,QQID));
End;
//�������� Auth=30 ������Ϣ�е�����(record),���ر����� \data\record\ Ŀ¼�µ��ļ��� //getRecord
function CQ_i_getRecord(filename,format:ansistring):ansistring;			//Auth=30 ������Ϣ�е�����(record),���ر����� \data\record\ Ŀ¼�µ��ļ��� //getRecord
{
filename �յ���Ϣ�е������ļ���(file)
format Ӧ������������ļ���ʽ��Ŀǰ֧�� mp3,amr,wma,m4a,spx,ogg,wav,flac
}
Begin
	exit(
		PtoS(
			CQ_getRecord(AuthCode,StoP(filename),StoP(format))
		)
	)
End;
//�ı�������
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
//�ı���ȺԱ
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
//�ı���Ⱥ�ļ�
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

//��ȡCookies Auth=20 ����,�˽ӿ���Ҫ�ϸ���Ȩ //getCookies
Function CQ_i_GetCookies():ansistring;
Begin
	exit(CQ_GetCookies(AuthCode));
End;

//��ȡCQ_i_getCsrfToken Auth=20 ��QQ��ҳ�õ���bkn/g_tk�� ����,�˽ӿ���Ҫ�ϸ���Ȩ //getCsrfToken
Function CQ_i_getCsrfToken():longint;
Begin
	exit(CQ_GetCsrfToken(AuthCode));
End;

//ȡ��½QQ getLoginQQ
Function CQ_i_GetLoginQQ():int64;
Begin
	exit(CQ_GetLoginQQ(authcode));
End;

//ȡ��½QQ�ǳơ�getLoginNick
Function CQ_i_getLoginNick():string;
Begin
	exit(CQ_GetLoginNick(AuthCode));
End;

//ȡİ������Ϣ Auth=131 //CQ_getStrangerInfo
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

//ȡȺ��Ա��Ϣ Auth=130 //getGroupMemberInfoV2
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

//���ص�·��ĩβ��"\" //getAppDirectory
function CQ_i_getAppDirectory:ansistring;
Begin
	exit(PtoS(CQ_getAppDirectory(AuthCode)));
End;

{�ɹ�������־ID //addlog
	priority ��ֵ�뿴�����б� CQLOG_*
	category������
	content����־����
}
function CQ_i_addLog(priority:longint;const category,content:ansistring):longint;
Begin
	exit(CQ_addLog(AuthCode,priority,StoP(category),StoP(content)));
End;

//��Ӻ�������ظ� Auth=150 //setFriendAddRequest
function CQ_i_setFriendAddRequest(const responseflag:pchar;responseoperation:longint;const remark:string):longint;
Begin
	exit(CQ_setFriendAddRequest(authcode,
								responseflag,			//ͨ���¼��������ݻ��
								responseoperation,		//ͨ����������
								StoP(remark)));			//��Ӻ���ѱ�ע
End;

//������ȺԱ���� Auth=124 //setGroupAnonymousBan
function CQ_i_setGroupAnonymousMute(group:int64;fromAnonymous:string;duration:int64):longint;
Begin
	exit(CQ_setGroupAnonymousBan(authcode,
								group,
								StoP(fromAnonymous),		//ͨ���¼��������ݻ��
								duration));					//����ʱ�� ��λ�� ��֧�ֽ��
End;

//��ȫȺ���� Auth=123 //setGroupWholeBan
function CQ_i_setGroupWholeMute(groupid:int64;enableban:boolean):longint;
Begin
	exit(CQ_setGroupWholeBan(AuthCode,groupid,enableban));
End;

//��Ⱥ��Ա��Ƭ Auth=126 //setGroupCard
function CQ_i_setGroupCard(group,qq:int64;nick:string):longint;
Begin
	exit(CQ_setGroupCard(authcode,
						group,
						qq,
						StoP(nick)))
End;

//��ȺԱר��ͷ�� Auth=128 ��Ⱥ��Ȩ�� //setGroupSpecialTitle
Function CQ_i_setGroupSpecialTitle(Group,ID:int64;Title:string;duration:int64):longint;
Begin
	exit(CQ_setGroupSpecialTitle(authcode,
								group,				//Ŀ��Ⱥ
								id,					//Ŀ��QQ
								StoP(title),		//��Ҫɾ��ͷ�Σ�������
								duration));			//ר��ͷ����Ч�ڣ���λΪ�롣���������Ч��������д-1
End;


{
	��Ⱥ����Ա Auth=122 //setGroupAdmin
	operation true���óɹ���Ա falseȡ������Ա
}
Function CQ_i_setGroupAdmin(group,qq:int64;operation:boolean):longint;
Begin
	exit(CQ_SetGroupAdmin(authcode,group,qq,operation));
End;

{
	��Ⱥ�������� Auth=125 //setGroupAnonymous
	operation true�������� false�ر�����
}
Function CQ_i_setGroupAnonymous(group:int64;operation:boolean):longint;
Begin
	exit(CQ_setGroupAnonymous(AuthCode,group,operation));
End;


//��Ⱥ������� Auth=151 //setGroupAddRequest
Function CQ_i_setGroupAddRequest(responseflag:string;	//�����¼��յ��ġ�responseflag������
								subtype		:longint;	//���������¼������������� #����_Ⱥ��� �� #����_Ⱥ����
								responseoperation:longint;	//#����_ͨ�� �� #����_�ܾ�
								reason		:string 	//�������ɣ��� #����_Ⱥ��� �� #����_�ܾ� ʱ����
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
��Ⱥ�˳� Auth=127 ����,�˽ӿ���Ҫ�ϸ���Ȩ //setGroupLeave
Disband true��ɢ��Ⱥ[Ⱥ��] false�˳���Ⱥ[Ⱥ��/ȺԱ]
}
Function CQ_i_setGroupLeave(group:int64;isdisband:boolean):longint;
Begin
	exit(CQ_setGroupLeave(Authcode,Group,IsDisband));
End;

//��ȺԱ���� Auth=121 //setGroupBan
function CQ_i_setGroupMute(groupid,QQID,duration:int64):longint;
Begin
	exit(CQ_setGroupBan(AuthCode,groupid,QQID,duration));
End;

//��ȺԱ�Ƴ� Auth=120 //setGroupKick
function CQ_i_setGroupKick(groupid,QQID:int64;rejectaddrequest:boolean):longint;
Begin
	exit(CQ_setGroupKick(AuthCode,Groupid,QQID,rejectaddrequest));
End;

//���������˳� Auth=140 //setDiscussLeave
function CQ_i_setDiscussLeave(DiscussID:int64):longint;
Begin
	exit(CQ_setDiscussLeave(authcode,DiscussID));
End;

//������������ʾ //setFatal
function CQ_i_setFatal(msg:ansistring):longint;
Begin
	exit(CQ_setFatal(authcode,StoP(msg)));
End;