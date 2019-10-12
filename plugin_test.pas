{$IFDEF FPC}
	{$MODE DELPHI}
	{$CODEPAGE UTF-8}
{$ENDIF}

unit plugin_test;

interface
uses CoolQSDK;
Function code_eventGroupMsg(subType,MsgID:longint;fromgroup,fromQQ:int64;fromAnonymous:ansistring;msg:widestring;font:longint):longint;
Function code_eventGroupUpload(subType,sendTime:longint;fromGroup,fromQQ:int64;Pfileinfo:ansistring):longint;
Function code_eventSystem_GroupMemberIncrease(subType,sendTime:longint;fromGroup,fromQQ,beingOperateQQ:int64):longint;
Function code_eventRequest_AddFriend(subType,sendTime:longint;fromQQ:int64;msg:widestring;responseFlag:ansistring):longint;
Function code_eventSystem_GroupBan(subType,sendTime:longint;fromGroup,fromAccount,beingOperateAccount,duration:int64):longint;

implementation
uses crt;

function Test_WhoAmI(fromGroup,fromQQ:int64):widestring;
label FriendListAPI;
Var
    ret : record
                grp : CQ_Type_GroupMember;
                QQ : CQ_Type_QQ;
                friendList : CQ_Type_FriendsList;
            end;
    i   : longint;
begin
    result:='';
    if (CQ_i_getGroupMemberInfo(fromGroup,fromQQ,ret.grp,false))=0 then begin
        result:=result+CRLF+ '群成员信息API: ';
        result:=result+CRLF+'    昵称: '+ret.grp.nick;
        if length(ret.grp.card)=0
            then result:=result+CRLF+'    群名片: 空'
            else result:=result+CRLF+'    群名片: '+ret.grp.card;
    end;

    if (CQ_i_getStrangerInfo(fromQQ,ret.QQ,false))=0 then begin
        result:=result+CRLF+ '陌生人信息API: ';
        result:=result+CRLF+'    昵称: '+ret.QQ.nick;
    end;

    if CQ_i_getFriendList(ret.friendList)=0 then begin
        result:=result+CRLF+ '好友列表API: ';
        for i:=0 to ret.friendList.l-1 do begin
            CQ_i_addLog(CQLOG_DEBUG,'',numtochar(ret.friendList.s[i].QQID));
            if (ret.friendList.s[i].QQID=fromQQ) then begin
                result:=result+CRLF+'    昵称: '+ret.friendList.s[i].nick;
                if length(ret.friendList.s[i].alias)=0
                    then result:=result+CRLF+'    备注: 空'
                    else result:=result+CRLF+'    备注: '+ret.friendList.s[i].alias;

                goto FriendListAPI;
            end;
        end;
        result:=result+CRLF+'    你不是机器人的好友';
    end;
    FriendListAPI:;
    
end;


{
* Type=2 群消息
}
Function code_eventGroupMsg(
			subType,MsgID			:longint;
			fromgroup,fromQQ		:int64;
			fromAnonymous		:ansistring;
			msg				:widestring;
			font					:longint):longint;
var
	AnonymousMes	:	CQ_Type_GroupAnonymous;
begin

	if (fromQQ=80000000) and (fromAnonymous<>'') then begin
		CQ_Tools_TextToAnonymous(fromAnonymous,AnonymousMes);
        {$IFDEF FPC}
            exit(EVENT_IGNORE);
        {$ELSE}
            result:=EVENT_IGNORE;
        {$ENDIF}
		//将匿名用户信息存到 AnonymousMes
	end;

	if msg='签到' then
        CQ_i_sendGroupMsg(fromgroup,widestring(CQCode_Group_At(fromQQ))+' : 签到并没有成功 [CQ:image,file=funnyface.png]');
        // 请先到控制台执行 ```curl https://tb2.bdstatic.com/tb/editor/images/face/i_f25.png -o data/image/funnyface.png```

    if msg='我是谁' then
        CQ_i_sendGroupMsg(fromgroup,widestring(CQCode_Group_At(fromQQ))+' 你是 : '+Test_WhoAmI(fromGroup,fromQQ));

    {
    if msg='口球' then
        if random(2)=0
            then CQ_i_setGroupMute(fromGroup,fromQQ,11*3600+4*60)
            else CQ_i_setGroupMute(fromGroup,fromQQ,11*86400+4*3600);
    }


    CQ_i_sendGroupMsg(fromgroup,widestring(CQCode_Group_At(fromQQ))+' 你发送了('+widestring(NumToChar(length(msg)))+') : '+msg);

		
{$IFDEF FPC}
	exit(EVENT_IGNORE);
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
	//关于返回值说明, 见“code_eventPrivateMsg”函数
end;


{
*Type=11 群文件上传事件
}
Function code_eventGroupUpload(
			subType,sendTime	:longint;
			fromGroup,fromQQ	:int64;
			Pfileinfo			:ansistring):longint;
Var
	FileInfo	:CQ_Type_GroupFile;
	Back		:widestring;
Begin
	//收到文件上传信息 并尝试解析
	if CQ_Tools_TextToFile(Pfileinfo,FileInfo) then begin
		//群文件信息解析成功
		
		Back:='[CQ:at,qq=%FROMQQ%] 上传了一个文件，信息如下：'+CRLF+
				'----------------'+CRLF+
				'文件名    : %FILENAME%'+CRLF+
				'文件大小  : %SIZE%'+CRLF+
				'----------------'+CRLF+
				'文件编号  : %FILEID%'+CRLF+
				'busID   : %BUSID%';
		Message_Replace(Back,'%FROMQQ%',widestring(numtochar(fromQQ)));
		Message_Replace(Back,'%FILEID%',widestring(FileInfo.fileID));
		Message_Replace(Back,'%FILENAME%',FileInfo.Filename);
		if FileInfo.Size<10240 then begin
			Message_Replace(Back,'%SIZE%',widestring(numtochar(FileInfo.Size))+'Byte(s)');
		end
		else
		begin
			if FileInfo.Size<10485760 then begin
				Message_Replace(Back,'%SIZE%',widestring(RealToDisplay(FileInfo.Size/1024,2))+'Kb');
			end
			else
			begin
				if FileInfo.Size<536870912 then begin
					Message_Replace(Back,'%SIZE%',widestring(RealToDisplay(FileInfo.Size/(1024*1024),2))+'Mb');
				end
				else
				begin
					Message_Replace(Back,'%SIZE%',widestring(RealToDisplay(FileInfo.Size/(1024*1024*1024),2))+'Gb');
				end;
			end;
		end;
		Message_Replace(Back,'%SIZE.B%',widestring(numtochar(FileInfo.Size)+'Byte(s)'));
		Message_Replace(Back,'%SIZE.KB%',widestring(RealToDisplay(FileInfo.Size/1024,2))+'Kb');
		Message_Replace(Back,'%SIZE.MB%',widestring(RealToDisplay(FileInfo.Size/(1024*1024),2))+'Mb');
		Message_Replace(Back,'%SIZE.GB%',widestring(RealToDisplay(FileInfo.Size/(1024*1024*1024),2))+'Gb');
		Message_Replace(Back,'%BUSID%',widestring(NumToChar(FileInfo.busid)));
		
		CQ_i_sendGroupMsg(fromGroup,Back);		
	end
	else
	begin
		CQ_i_addLog(CQLOG_DEBUG,widestring('code_eventGroupUpload'),'解析失败 '+widestring(Pfileinfo));
		//群文件信息解析失败
	end;
	
{$IFDEF FPC}
	exit(EVENT_IGNORE);
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
	//关于返回值说明, 见“code_eventPrivateMsg”函数
End;

{
* Type=103 群事件-群成员增加
* subType 子类型，1/管理员已同意 2/管理员邀请
* fromQQ 操作者QQ(即管理员QQ)
* beingOperateQQ 被操作QQ(即加群的QQ)
}
Function code_eventSystem_GroupMemberIncrease(
			subType,sendTime		:longint;
			fromGroup,fromQQ,
			beingOperateQQ			:int64):longint;
Begin
	CQ_i_sendGroupMsg(fromgroup,'欢迎新人 [CQ:at,qq='+widestring(NumToChar(beingOperateQQ))+'] 加入本群');
{$IFDEF FPC}
	exit(EVENT_IGNORE); 
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
	//关于返回值说明, 见“code_eventPrivateMsg”函数
End;

{
* Type=301 请求-好友添加
* msg 附言
* responseFlag 反馈标识(处理请求用)
}
Function code_eventRequest_AddFriend(
			subType,sendTime			:longint;
			fromQQ						:int64;
			msg					        :widestring;
			responseFlag				:ansistring):longint;
Begin
	CQ_i_setFriendAddRequest(responseFlag, REQUEST_DENY,''); //拒绝好友添加请求
	
{$IFDEF FPC}
	exit(EVENT_IGNORE); 
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
	//关于返回值说明, 见“code_eventPrivateMsg”函数
End;

{
* Type=104 群事件-群禁言
* subType 子类型，1/被解禁 2/被禁言
* sendTime 发送时间(时间戳)
* fromGroup 来源群号
* fromAccount 操作者帐号
* beingOperateAccount 被操作帐号(若为全群禁言/解禁，则本参数为 0)
* duration 禁言时长(单位 秒，仅子类型为2时可用)
}
Function code_eventSystem_GroupBan(
			subType,sendTime		:longint;
			fromGroup,fromAccount,
			beingOperateAccount,duration			:int64):longint;
Begin
    if subType=2 then begin
        delay(2000);
        case duration of
            11*3600+4*60 : CQ_i_setGroupMute(fromGroup,beingOperateAccount,5*3600+14*60); //114
            5*3600+14*60 : CQ_i_setGroupMute(fromGroup,beingOperateAccount,19*3600+19*60); //514
            19*3600+19*60 : CQ_i_setGroupMute(fromGroup,beingOperateAccount,8*3600+10*60);//1919
            8*3600+10*60 : CQ_i_setGroupMute(fromGroup,beingOperateAccount,0); //810

            11*86400+4*3600 : CQ_i_setGroupMute(fromGroup,beingOperateAccount,5*86400+14*3600); //114
            5*86400+14*3600 : CQ_i_setGroupMute(fromGroup,beingOperateAccount,19*86400+19*3600); //514
            19*86400+19*3600 : CQ_i_setGroupMute(fromGroup,beingOperateAccount,8*86400+10*3600);//1919
            8*86400+10*3600 : CQ_i_setGroupMute(fromGroup,beingOperateAccount,0); //810
        end;

    end;

{$IFDEF FPC}
	exit(EVENT_IGNORE); 
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
	//关于返回值说明, 见“code_eventPrivateMsg”函数
End;

end.