Function CQ_CharEncode(str:ansistring;Comma:boolean):ansistring;
Begin
	Message_Replace(str,'&','&amp;');
	Message_Replace(str,'[','&#91;');
	Message_Replace(str,']','&#93;');
	if Comma then begin
		Message_Replace(str,',','&#44;');
	end;
	result:=(Str);
End;
Function CQ_CharDecode(str:ansistring):ansistring;
Begin
	Message_Replace(str,'&#93;',']');
	Message_Replace(str,'&#91;','[');
	Message_Replace(str,'&#44;',',');
	Message_Replace(str,'&amp;','&');
	result:=(str);
End;

{
QQIDΪ��@��Ⱥ��ԱQQ���ò���Ϊ-1����@ȫ���Ա���������þ���Ȩ�޲������ת��Ϊ�ı���
������[CQ:at,qq=123456]
}
function CQCode_Group_At(QQID:int64):ansistring;
Begin
	result:=('[CQ:at,qq='+String_Choose(QQID=-1,'all',NumToChar(QQID))+']');
End;

{
IDΪemoji�ַ���unicode���
������[CQ:emoji,id=128513]������һ����Ц��emoji���飩
}
function CQCode_emoji(ID:int64):ansistring;
Begin
	result:=('[CQ:emoji,id='+NumToChar(ID)+']');
End;

{
IDΪ0-170������
������[CQ:face,id=14]������һ��΢Ц��QQ���飩
}
function CQCode_face(ID:int64):ansistring;
Begin
	result:=('[CQ:at,face='+NumToChar(ID)+']');
End;

//���ڶ�������֧�ֺ�����Ϣʹ�ã�
function CQCode_Shake:ansistring;
Begin
	result:=('[CQ:shake]');
End;

{
��CQ���������Ϣ�Ŀ�ͷ��
�� Force Ϊfalseʱ������ǿ��ʹ���������������ʧ�ܽ�תΪ��ͨ��Ϣ���͡�
�� Force Ϊtrueʱ������ǿ��ʹ���������������ʧ�ܽ�ȡ������Ϣ�ķ��͡�
������
}
function CQCode_anonymous(Force:boolean):ansistring;	
Begin
	result:=('[CQ:anonymous'+String_Choose(Force,'',',ignore=true')+']');
End;

{
urlΪͼƬ�ļ����ƣ�ͼƬ����ڿ�QĿ¼��data\image\��
������[CQ:image,file=1.jpg]������data\image\1.jpg��
}
function CQCode_image(url:ansistring):ansistring;
Begin
	result:=('[CQ:image,file='+CQ_CharEncode(url,true)+']')
End;

{
sourceΪ����ƽ̨���ͣ�Ŀǰ֧��qq��163��xiami
musicidΪ��Ӧ����ƽ̨����������id
ע�⣺����ֻ����Ϊ������һ����Ϣ����
������
[CQ:music,type=qq,id=422594]������һ��QQ���ֵġ�Time after time��������Ⱥ�ڣ�
[CQ:music,type=163,id=28406557]������һ�����������ֵġ��@�D����������Ⱥ�ڣ�
}
function CQCode_Music(source:string;musicid:int64;isnew:boolean):ansistring;
Begin
	result:=('[CQ:music,type='+source+',id='+NumToChar(musicid)+String_Choose(isnew,',style=1','')+']')
	{���� (��[CQ:music,id=�� �� ���ı� (����ID) �� ��]��)}
End;

{
���������Զ������(music)
url ����������������ҳ�棨���������ҳ��
audio ���ֵ���Ƶ���ӣ���mp3���ӣ�
title ���ֵı��⣬����12������
content ���ֵļ�飬����30������
image ���ֵķ���ͼƬ���ӣ�������ΪĬ��ͼƬ
}
function CQCode_Music_Custom(url,audio,title,content,image:ansistring):ansistring;
Begin
	result:='[CQ:music,type=custom,url='+CQ_CharEncode(url,true)
						+',audio='+CQ_CharEncode(audio,true)
						+String_Choose(title='','',',title='+CQ_CharEncode(title,true))
						+String_Choose(content='','',',content='+CQ_CharEncode(content,true))
						+String_Choose(image='','',',image='+CQ_CharEncode(image,true))
						+']';
End;

{
����λ�÷���(location)

}
function CQCode_Location(latitude,longitude:real;Zoom:longint;Name,Address:ansistring):ansistring;
Begin
	result:='[CQ:location,lat='+RealToDisplay(latitude,6)+',lon='+RealToDisplay(longitude,6);
	if zoom>0 then result:=result+',zoom='+NumToChar(zoom);
	result:=result+',title='+CQ_CharEncode(Name,true)+',content'+CQ_CharEncode(Address,true)+']';
ENd;

{
idΪ��ԭ�������ID������ڿ�QĿ¼��data\bface\��
}
function CQCode_bface(ID:int64):ansistring;
Begin
	result:=('[CQ:bface,id='+NumToChar(ID)+']');
End;

{
1Ϊ��Ƶ�ļ����ƣ���Ƶ����ڿ�QĿ¼��data\record\��
2Ϊ�Ƿ�Ϊ���������ò���Ϊtrue����ʾ������ǡ��ò����ɱ����ԡ�
������[CQ:record,file=1.silk��magic=true]������data\record\1.silk�������Ϊ������
}
function CQCode_record(url:ansistring;magic:boolean):ansistring;
Begin
	result:=('[CQ:record,file='+CQ_CharEncode(url,true)+String_Choose(magic,',magic=true','')+']');
End;

{
idΪ��ȭ��������ͣ��ݲ�֧�ַ���ʱ�Զ��塣�ò����ɱ����ԡ�
1 - ��ȭ���Ϊʯͷ
2 - ��ȭ���Ϊ����
3 - ��ȭ���Ϊ��
}
function CQCode_rps(ID:int64):ansistring;
Begin
	result:=('[CQ:rps,id='+NumToChar(ID)+']');
End;

{
id��Ӧ�����ĵ������ݲ�֧�ַ���ʱ�Զ��塣�ò����ɱ����ԡ�
}
function CQCode_dice(ID:int64):ansistring;
Begin
	result:=('[CQ:dice,id='+NumToChar(ID)+']');
End;

{
[CQ:share,url=�� �� CQ��_ת�� (url��ַ, ��) �� ��,title=�� �� CQ��_ת�� (��Ƭ����, ��) �� ��,content=�� �� CQ��_ת�� (��Ƭ����, ��) �� ��,image=�� �� CQ��_ת�� (��ƬͼƬurl, ��) �� ��]
}
function CQCode_share(url,title,Content,image:ansistring):ansistring;
Begin
	result:=('[CQ:share,url='+CQ_CharEncode(url,true)+',title='+CQ_CharEncode(title,true)+',content='+CQ_CharEncode(content,true)+',image='+CQ_CharEncode(image,true)+']');
End;

{
[CQ:contact,type=qq/group,id=Q��/Ⱥ��]
}
function CQCode_contact(t:ansistring;id:int64):ansistring;
Begin
	result:=('[CQ:contact,type='+t+',id='+NumToChar(id)+']');
End;


{API}
//����˽�� Auth=106 //sendPrivateMsg
function CQ_i_sendPrivateMsg(QQID:int64;msg:ansistring):longint;		//Auth=106 //sendPrivateMsg
Begin
	result:=(CQ_sendPrivateMsg(AuthCode,QQID,StoP(msg)));
End;
//����Ⱥ�� Auth=101 //sendGroupMsg
function CQ_i_sendGroupMsg(groupid:int64;const msg:ansistring):longint;	//Auth=101 //sendGroupMsg
Begin
	result:=(CQ_sendGroupMsg(AuthCode,groupid,StoP(msg)));
End;
//���������� Auth=103 //sendDiscussMsg
function CQ_i_sendDiscussMsg(DiscussID:int64;msg:ansistring):longint;	//Auth=103 //sendDiscussMsg
Begin
	result:=(CQ_sendDiscussMsg(AuthCode,DiscussID,StoP(msg)));
End;
//������ Auth=110 //sendLike
function CQ_i_sendLike(QQID:int64):longint;								//Auth=110 //sendLike
Begin
	result:=(CQ_sendLike(AuthCode,QQID));
End;
function CQ_i_sendLikeV2(QQID:int64;times:longint):longint;								//Auth=110 //sendLike
Begin
	result:=(CQ_sendLikeV2(AuthCode,QQID,min(times,10)));
End;

//�������� Auth=30 ������Ϣ�е�����(record),���ر����� \data\record\ Ŀ¼�µ��ļ��� //getRecord
function CQ_i_getRecord(filename,format:ansistring):ansistring;			//Auth=30 ������Ϣ�е�����(record),���ر����� \data\record\ Ŀ¼�µ��ļ��� //getRecord
{
filename �յ���Ϣ�е������ļ���(file)
format Ӧ������������ļ���ʽ��Ŀǰ֧�� mp3,amr,wma,m4a,spx,ogg,wav,flac
}
Begin
	result:=(
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
	if source='' then begin
		result:=false;
		exit();
	end;
	data:=Base64_Decryption(source);
	if length(data)<12 then begin
		result:=false;
		exit();
	end;
	i:=1;
	Anonymous.AID:=CoolQ_Tools_Unpack_GetNum(i,8,data);
	Anonymous.name:=CoolQ_Tools_Unpack_GetStr(i,data);
	Anonymous.Token:=CoolQ_Tools_Unpack_GetStr(i,data);
	
	result:=true;
End;

//�ı���ȺԱ -- ���ݵ�data��������Base64����������
function CQ_Tools_TextToGroupMember_Main(data:ansistring;
									Var info:CQ_Type_GroupMember):boolean;
Var
	i:longint;
Begin
	if length(data)<40 then begin
		result:=false;
		exit();
	end;
	i:=1;
	info.groupid:=CoolQ_Tools_Unpack_GetNum(i,8,data);
	info.QQID:=CoolQ_Tools_Unpack_GetNum(i,8,data);
	info.nick:=CoolQ_Tools_Unpack_GetStr(i,data);
	info.card:=CoolQ_Tools_Unpack_GetStr(i,data);
	info.sex:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.age:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.aera:=CoolQ_Tools_Unpack_GetStr(i,data);
	info.jointime:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.lastsent:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.level_name:=CoolQ_Tools_Unpack_GetStr(i,data);
	info.permission:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.unfriendly:=CoolQ_Tools_Unpack_GetNum(i,4,data)=1;
	info.title:=CoolQ_Tools_Unpack_GetStr(i,data);
	info.titleExpiretime:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.nickcanchange:=CoolQ_Tools_Unpack_GetNum(i,4,data)=1;
	result:=(true);
End;

//�ı���Ⱥ��Ա -- ���ݵ�scource������δBase64����������
function CQ_Tools_TextToGroupMember(source:ansistring;
									Var info:CQ_Type_GroupMember):boolean;
Var
	data:ansistring;
Begin
	if source='' then begin
		result:=false;
		exit();
	end;
	data:=Base64_Decryption(source);
	result:=(CQ_Tools_TextToGroupMember_Main(data,info));
End;


//�ı���Ⱥ��Ա�б�
function CQ_Tools_TextToGroupMemberList(source:ansistring;Var GroupMemberList:CQ_Type_GroupMember_List):boolean;
Var
	data	:	ansistring;
	i,j		:	longint;
Begin
	if source='' then begin
		result:=false;
		exit();
	end;
	data:=Base64_Decryption(source);
	if length(data)<10 then begin
		result:=false;
		exit();
	end;
	i:=1;
	GroupMemberList.l:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	SetLength(GroupMemberList.s,GroupMemberList.l);
	for j:=0 to GroupMemberList.l-1 do begin
		if CoolQ_Tools_Unpack_GetLenRemain(i,data)<=0
			then
			begin
				result:=false;
				exit();
			end
			else
			begin
				if CQ_Tools_TextToGroupMember_Main(CoolQ_Tools_Unpack_GetStr(i,data),GroupMemberList.s[j])=false then begin
					result:=false;
					exit();
				end;
			end;
	end;
	result:=true;
End;

//�ı���Ⱥ�ļ�
Function CQ_Tools_TextToFile(source:string;Var info:CQ_Type_GroupFile):boolean;
Var
	data:ansistring;
	i:longint;
Begin
	if source='' then begin
		result:=false;
		exit();
	end;
	data:=Base64_Decryption(source);
	if length(data)<20 then begin
		result:=false;
		exit();
	end;
	i:=1;
	info.FileID:=CoolQ_Tools_Unpack_GetStr(i,data);
	info.FileName:=CoolQ_Tools_Unpack_GetStr(i,data);
	info.Size:=CoolQ_Tools_Unpack_GetNum(i,8,data);
	info.busid:=CoolQ_Tools_Unpack_GetNum(i,8,data);
	result:=true;
End;

//����_ת��_ansihex��Ⱥ��Ϣ
Function CQ_Tools_TextToGroupInfo(source:ansistring;Var GroupInfo:CQ_Type_GroupInfo):boolean;
Var
	i:longint;
Begin
	if length(source)<10 then begin
		result:=false;
		exit();
	end;
	i:=1;
	GroupInfo.GroupID:=CoolQ_Tools_Unpack_GetNum(i,8,source);
	GroupInfo.name:=CoolQ_Tools_Unpack_GetStr(i,source);
	result:=true;
End;

//����_ת��_�ı���Ⱥ�б���Ϣa
Function CQ_Tools_TextToGroupListInfo(source:ansistring;Var GroupList:CQ_Type_GroupList):boolean;
Var
	data:ansistring;
	i,j:longint;
Begin
	if source='' then begin
		result:=false;
		exit();
	end;
	data:=Base64_Decryption(source);
	if length(data)<4 then begin
		result:=false;
		exit();
	end;
	i:=1;
	GroupList.l:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	SetLength(GroupList.s,GroupList.l);
	for j:=0 to GroupList.l-1 do begin
		if CoolQ_Tools_Unpack_GetLenRemain(i,data)<=0
			then
			begin
				result:=false;
				exit();
			end
			else
			begin
				if CQ_Tools_TextToGroupInfo(CoolQ_Tools_Unpack_GetStr(i,data),GroupList.s[j])=false then begin
					result:=false;
					exit();
				end;
			end;
	end;
	result:=true;
End;

//��ȡCookies Auth=20 ����,�˽ӿ���Ҫ�ϸ���Ȩ //getCookies
Function CQ_i_GetCookies():ansistring;
Begin
	result:=(CQ_GetCookies(AuthCode));
End;

//��ȡCsrfToken Auth=20 ��QQ��ҳ�õ���bkn/g_tk�� ����,�˽ӿ���Ҫ�ϸ���Ȩ //getCsrfToken
Function CQ_i_getCsrfToken():longint;
Begin
	result:=(CQ_GetCsrfToken(AuthCode));
End;

//ȡ��½QQ getLoginQQ
Function CQ_i_GetLoginQQ():int64;
Begin
	result:=(CQ_GetLoginQQ(authcode));
End;

//ȡ��½QQ�ǳơ�getLoginNick
Function CQ_i_getLoginNick():string;
Begin
	result:=(CQ_GetLoginNick(AuthCode));
End;

//ȡİ������Ϣ Auth=131 //CQ_getStrangerInfo
Function CQ_i_GetStrangerInfo(QQ:int64;Var info:CQ_Type_QQ;nocache:boolean):longint;
Var
	data:ansistring;
	i:longint;
Begin
	data:=CQ_GetStrangerInfo(AuthCode,QQ,Nocache);
	data:=Base64_Decryption(data);
	if length(data)<16 then begin
		result:=-1000;
		exit();
	end;
	i:=1;
	info.QQID:=CoolQ_Tools_Unpack_GetNum(i,8,data);
	info.nick:=CoolQ_Tools_Unpack_GetStr(i,data);
	info.sex:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.age:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	result:=0;
End;

//ȡȺ��Ա��Ϣ Auth=130 //getGroupMemberInfoV2
function CQ_i_getGroupMemberInfo(groupid,qqid:int64;
								Var info:CQ_Type_GroupMember;
								nocache:boolean):longint;
Var
	return:ansistring;
Begin
	return:=CQ_getGroupMemberInfoV2(AuthCode,groupid,QQID,nocache);
	if return='' then begin
		result:=-1000;
		exit();
	end;
	if CQ_Tools_TextToGroupMember(return,info)=false then begin
		result:=-1000;
		exit();
	end;
	result:=0;
End;

//���ص�·��ĩβ��"\" //getAppDirectory
function CQ_i_getAppDirectory:ansistring;
Begin
	result:=(PtoS(CQ_getAppDirectory(AuthCode)));
End;

{�ɹ�������־ID //addlog
	priority ��ֵ�뿴�����б� CQLOG_*
	category ������
	content ����־����
}
function CQ_i_addLog(priority:longint;const category,content:ansistring):longint;
Begin
	result:=(CQ_addLog(AuthCode,priority,StoP(category),StoP(content)));
End;

//��Ӻ�������ظ� Auth=150 //setFriendAddRequest
function CQ_i_setFriendAddRequest(const responseflag:pchar;responseoperation:longint;const remark:string):longint;
Begin
	result:=(CQ_setFriendAddRequest(authcode,
								responseflag,			//ͨ���¼��������ݻ��
								responseoperation,		//ͨ����������
								StoP(remark)));			//��Ӻ���ѱ�ע
End;

//������ȺԱ���� Auth=124 //setGroupAnonymousBan
function CQ_i_setGroupAnonymousMute(group:int64;fromAnonymous:string;duration:int64):longint;
Begin
	result:=(CQ_setGroupAnonymousBan(authcode,
								group,
								StoP(fromAnonymous),		//ͨ���¼��������ݻ��
								duration));					//����ʱ�� ��λ�� ��֧�ֽ��
End;

//��ȫȺ���� Auth=123 //setGroupWholeBan
function CQ_i_setGroupWholeMute(groupid:int64;enableban:boolean):longint;
Begin
	result:=(CQ_setGroupWholeBan(AuthCode,groupid,enableban));
End;

//��Ⱥ��Ա��Ƭ Auth=126 //setGroupCard
function CQ_i_setGroupCard(group,qq:int64;nick:string):longint;
Begin
	result:=(CQ_setGroupCard(authcode,
						group,
						qq,
						StoP(nick)))
End;

//��ȺԱר��ͷ�� Auth=128 ��Ⱥ��Ȩ�� //setGroupSpecialTitle
Function CQ_i_setGroupSpecialTitle(Group,ID:int64;Title:string;duration:int64):longint;
Begin
	result:=(CQ_setGroupSpecialTitle(authcode,
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
	result:=(CQ_SetGroupAdmin(authcode,group,qq,operation));
End;

{
	��Ⱥ�������� Auth=125 //setGroupAnonymous
	operation true�������� false�ر�����
}
Function CQ_i_setGroupAnonymous(group:int64;operation:boolean):longint;
Begin
	result:=(CQ_setGroupAnonymous(AuthCode,group,operation));
End;


//��Ⱥ������� Auth=151 //setGroupAddRequest
Function CQ_i_setGroupAddRequest(responseflag:string;	//�����¼��յ��ġ�responseflag������
								subtype		:longint;	//���������¼������������� #����_Ⱥ��� �� #����_Ⱥ����
								responseoperation:longint;	//#����_ͨ�� �� #����_�ܾ�
								reason		:string 	//�������ɣ��� #����_Ⱥ��� �� #����_�ܾ� ʱ����
								):longint;
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

{
��Ⱥ�˳� Auth=127 ����,�˽ӿ���Ҫ�ϸ���Ȩ //setGroupLeave
Disband true��ɢ��Ⱥ[Ⱥ��] false�˳���Ⱥ[Ⱥ��/ȺԱ]
}
Function CQ_i_setGroupLeave(group:int64;isdisband:boolean):longint;
Begin
	result:=(CQ_setGroupLeave(Authcode,Group,IsDisband));
End;

//��ȺԱ���� Auth=121 //setGroupBan
function CQ_i_setGroupMute(groupid,QQID,duration:int64):longint;
Begin
	result:=(CQ_setGroupBan(AuthCode,groupid,QQID,duration));
End;

//��ȺԱ�Ƴ� Auth=120 //setGroupKick
function CQ_i_setGroupKick(groupid,QQID:int64;rejectaddrequest:boolean):longint;
Begin
	result:=(CQ_setGroupKick(AuthCode,Groupid,QQID,rejectaddrequest));
End;

//���������˳� Auth=140 //setDiscussLeave
function CQ_i_setDiscussLeave(DiscussID:int64):longint;
Begin
	result:=(CQ_setDiscussLeave(authcode,DiscussID));
End;

//������������ʾ //setFatal
function CQ_i_setFatal(msg:ansistring):longint;
Begin
	result:=(CQ_setFatal(authcode,StoP(msg)));
End;

//ȡȺ��Ա�б� Auth=160 //getGroupMemberList
function CQ_i_getGroupMemberList(GroupID:int64;Var GroupMemberList:CQ_Type_GroupMember_List):longint;
Var
	return	:	ansistring;
Begin
	return:=PtoS(CQ_getGroupMemberList(AuthCode,GroupID));
	if return='' then begin
		result:=-1000;
		exit();
	end
	else
	if CQ_Tools_TextToGroupMemberList(return,GroupMemberList)=false then begin
		result:=-1000;
		exit();
	end;
	result:=0;
End;



//ȡȺ�б� Auth=161  //getGroupList
function CQ_i_getGroupList(Var GroupList:CQ_Type_GroupList):longint;
Var
	return	:	ansistring;
Begin
	return:=PtoS(CQ_getGroupList(AuthCode));
	if return='' then begin
		result:=-1000;
		exit();
	end
	else
	if CQ_Tools_TextToGroupListInfo(return,GroupList)=false then begin
		result:=-1000;
		exit();
	end;
	result:=0;
End;


//������Ϣ Auth=180 //deleteMsg
function CQ_i_deleteMsg(msgID:int64):longint;
Begin
	result:=(CQ_deleteMsg(AuthCode,msgID));
End;