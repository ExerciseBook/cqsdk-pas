{$CODEPAGE UTF-8}
{$IFDEF FPC}
	{$MODE DELPHI}
{$ENDIF}

unit plugin_test;

interface
uses CoolQSDK;
Function code_eventGroupMsg(subType,MsgID:longint;fromgroup,fromQQ:int64;fromAnonymous:ansistring;msg:widestring;font:longint):longint;

implementation

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

    CQ_i_sendGroupMsg(fromgroup,widestring(CQCode_Group_At(fromQQ))+' 你发送了('+widestring(NumToChar(length(msg)))+') : '+msg);

		
{$IFDEF FPC}
	exit(EVENT_IGNORE);
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
	//关于返回值说明, 见“code_eventPrivateMsg”函数
end;

end.