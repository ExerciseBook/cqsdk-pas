{$IFDEF FPC}
	{$CODEPAGE UTF-8}
{$ENDIF}

unit Plugin_events;

interface

uses CoolQSDK;
Function code_eventStartup:longint;
Function code_eventExit:longint;
Function code_eventEnable:longint;
Function code_eventDisable:longint;
Function code_eventPrivateMsg(subType,MsgID:longint;fromQQ:int64;const msg:widestring;font:longint):longint;
Function code_eventGroupMsg(subType,MsgID:longint;fromgroup,fromQQ:int64;const fromAnonymous:ansistring;const msg:widestring;font:longint):longint;
Function code_eventDiscussMsg(subType,MsgID:longint;fromDiscuss,fromQQ:int64;msg:widestring;font:longint):longint;
Function code_eventGroupUpload(subType,sendTime:longint;fromGroup,fromQQ:int64;Pfileinfo:ansistring):longint;
Function code_eventSystem_GroupAdmin(subType,sendTime:longint;fromGroup,beingOperateQQ:int64):longint;
Function code_eventSystem_GroupMemberDecrease(subType,sendTime:longint;fromGroup,fromQQ,beingOperateQQ:int64):longint;
Function code_eventSystem_GroupMemberIncrease(subType,sendTime:longint;fromGroup,fromQQ,beingOperateQQ:int64):longint;
Function code_eventSystem_GroupBan(subType,sendTime:longint;fromGroup,fromAccount,beingOperateAccount,duration:int64):longint;
Function code_eventFriend_Add(subType,sendTime:longint;fromQQ:int64):longint;
Function code_eventRequest_AddFriend(subType,sendTime:longint;fromQQ:int64;const msg:widestring;const responseFlag:ansistring):longint;
Function code_eventRequest_AddGroup(subType,sendTime:longint;fromGroup,fromQQ:int64;const msg:widestring;const responseFlag:ansistring):longint;

implementation
uses plugin_test;
//测试库 如果你清楚酷Q其实是怎么处理消息的话你可以看一下这个库里的代码是怎么写的

{
* Type=1001 酷Q启动
* 无论本应用是否被启用，本函数都会在酷Q启动后执行一次，请在这里执行应用初始化代码。
* 如非必要，不建议在这里加载窗口。（可以添加菜单，让用户手动打开窗口）
}
Function code_eventStartup:longint;
Begin
{$IFDEF FPC}
	exit(0);
{$ELSE}
	result:=0;
{$ENDIF}
End;

{
* Type=1002 酷Q退出
* 无论本应用是否被启用，本函数都会在酷Q退出前执行一次，请在这里执行插件关闭代码。
* 本函数调用完毕后，酷Q将很快关闭，请不要再通过线程等方式执行其他代码。
}
Function code_eventExit:longint;
Begin
{$IFDEF FPC}
	exit(0);
{$ELSE}
	result:=0;
{$ENDIF}
End;

{
* Type=1003 应用已被启用
* 当应用被启用后，将收到此事件。
* 如果酷Q载入时应用已被启用，则在_eventStartup(Type=1001,酷Q启动)被调用后，本函数也将被调用一次。
* 如非必要，不建议在这里加载窗口。（可以添加菜单，让用户手动打开窗口）
}
Function code_eventEnable:longint;
Begin
{$IFDEF FPC}
	exit(0)
{$ELSE}
	result:=0;
{$ENDIF}
End;

{
* Type=1004 应用将被停用
* 当应用被停用前，将收到此事件。
* 如果酷Q载入时应用已被停用，则本函数*不会*被调用。
* 无论本应用是否被启用，酷Q关闭前本函数都*不会*被调用。
}
Function code_eventDisable:longint;
Begin
{$IFDEF FPC}
	exit(0);
{$ELSE}
	result:=0;
{$ENDIF}
End;

{
* Type=21 私聊消息
* subType 子类型，11/来自好友 1/来自在线状态 2/来自群 3/来自讨论组
}
Function code_eventPrivateMsg(
			subType,MsgID			:longint;
			fromQQ					:int64;
			const msg				:widestring;
			font					:longint):longint;
Begin
	plugin_test.code_eventPrivateMsg(subType,MsgID,fromQQ,msg,font);

{$IFDEF FPC}
	exit(EVENT_IGNORE);
		//如果要回复消息，请调用酷Q方法发送，并且这里 exit(EVENT_BLOCK) - 截断本条消息，不再继续处理  注意：应用优先级设置为"最高"(10000)时，不得使用本返回值
		//如果不回复消息，交由之后的应用/过滤器处理，这里 exit(return EVENT_IGNORE) - 忽略本条消息
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
End;

{
* Type=2 群消息
}
Function code_eventGroupMsg(
			subType,MsgID			:longint;
			fromgroup,fromQQ		:int64;
			const fromAnonymous		:ansistring;
			const msg				:widestring;
			font					:longint):longint;
Var
	AnonymousMes	:	CQ_Type_GroupAnonymous;
Begin

	if (fromQQ=80000000) and (fromAnonymous<>'') then begin
		CQ_Tools_TextToAnonymous(fromAnonymous,AnonymousMes);
		//将匿名用户信息存到 AnonymousMes
	end;
	
	/////
	plugin_test.code_eventGroupMsg(subType,MsgID,fromgroup,fromQQ,fromAnonymous,msg,font);
	//调用测试库里的函数

{$IFDEF FPC}
	exit(EVENT_IGNORE);
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
	//关于返回值说明, 见“code_eventPrivateMsg”函数
End;

{
* Type=4 讨论组消息
}
Function code_eventDiscussMsg(
			subType,MsgID			:longint;
			fromDiscuss,fromQQ		:int64;
			msg						:widestring;
			font					:longint):longint;
Begin
{$IFDEF FPC}
	exit(EVENT_IGNORE);
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
	//关于返回值说明, 见“code_eventPrivateMsg”函数
End;

{
*Type=11 群文件上传事件
}
Function code_eventGroupUpload(
			subType,sendTime	:longint;
			fromGroup,fromQQ	:int64;
			Pfileinfo			:ansistring):longint;
Begin
	
	plugin_test.code_eventGroupUpload(subType,sendTime,fromGroup,fromQQ,PFileinfo);

{$IFDEF FPC}
	exit(EVENT_IGNORE);
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
	//关于返回值说明, 见“code_eventPrivateMsg”函数
End;


{
* Type=101 群事件-管理员变动
* subType 子类型，1/被取消管理员 2/被设置管理员
}
Function code_eventSystem_GroupAdmin(
			subType,sendTime		:longint;
			fromGroup,
			beingOperateQQ			:int64):longint;
Begin
{$IFDEF FPC}
	exit(EVENT_IGNORE); 
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
	//关于返回值说明, 见“code_eventPrivateMsg”函数
End;

{
* Type=102 群事件-群成员减少
* subType 子类型，1/群员离开 2/群员被踢 3/自己(即登录号)被踢
* fromQQ 操作者QQ(仅subType为2、3时存在)
* beingOperateQQ 被操作QQ
}
Function code_eventSystem_GroupMemberDecrease(
			subType,sendTime		:longint;
			fromGroup,fromQQ,
			beingOperateQQ			:int64):longint;
Begin
{$IFDEF FPC}
	exit(EVENT_IGNORE); 
{$ELSE}
	result:=EVENT_IGNORE
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
	
	plugin_test.code_eventSystem_GroupMemberIncrease(subType,sendTime,fromGroup,fromQQ,beingOperateQQ);

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

	plugin_test.code_eventSystem_GroupBan(subType,sendTime,fromGroup,fromAccount,beingOperateAccount,duration);

{$IFDEF FPC}
	exit(EVENT_IGNORE); 
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
	//关于返回值说明, 见“code_eventPrivateMsg”函数
End;

{
* Type=201 好友事件-好友已添加
}
Function code_eventFriend_Add(
			subType,sendTime		:longint;
			fromQQ					:int64):longint;
Begin
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
			const msg					:widestring;
			const responseFlag			:ansistring):longint;
Begin
	
	plugin_test.code_eventRequest_AddFriend(subType,sendTime,fromQQ,msg,responseFlag);
	
{$IFDEF FPC}
	exit(EVENT_IGNORE); 
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
	//关于返回值说明, 见“code_eventPrivateMsg”函数
End;

{
* Type=302 请求-群添加
* subType 子类型，1/他人申请入群 2/自己(即登录号)受邀入群
* msg 附言
* responseFlag 反馈标识(处理请求用)
}
Function code_eventRequest_AddGroup(
			subType,sendTime			:longint;
			fromGroup,fromQQ			:int64;
			const msg					:widestring;
			const responseFlag			:ansistring):longint;
Begin	
{$IFDEF FPC}
	exit(EVENT_IGNORE); 
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
	//关于返回值说明, 见“code_eventPrivateMsg”函数
End;

end.