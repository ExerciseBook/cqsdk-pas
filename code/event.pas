{
* Type=1001 酷Q启动
* 无论本应用是否被启用，本函数都会在酷Q启动后执行一次，请在这里执行应用初始化代码。
* 如非必要，不建议在这里加载窗口。（可以添加菜单，让用户手动打开窗口）
}
Function code_eventStartup:longint;
Begin
	exit(0)
End;

{
* Type=1002 酷Q退出
* 无论本应用是否被启用，本函数都会在酷Q退出前执行一次，请在这里执行插件关闭代码。
* 本函数调用完毕后，酷Q将很快关闭，请不要再通过线程等方式执行其他代码。
}
Function code_eventExit:longint;
Begin
	exit(0);
End;

{
* Type=1003 应用已被启用
* 当应用被启用后，将收到此事件。
* 如果酷Q载入时应用已被启用，则在_eventStartup(Type=1001,酷Q启动)被调用后，本函数也将被调用一次。
* 如非必要，不建议在这里加载窗口。（可以添加菜单，让用户手动打开窗口）
}
Function code_eventEnable:longint;
Begin
	exit(0)
End;

{
* Type=1004 应用将被停用
* 当应用被停用前，将收到此事件。
* 如果酷Q载入时应用已被停用，则本函数*不会*被调用。
* 无论本应用是否被启用，酷Q关闭前本函数都*不会*被调用。
}
Function code_eventDisable:longint;
Begin
	exit(0);
End;

{
* Type=21 私聊消息
* subType 子类型，11/来自好友 1/来自在线状态 2/来自群 3/来自讨论组
}
Function code_eventPrivateMsg(
			subType,sendTime		:longint;
			fromQQ					:int64;
			const msg				:ansistring;
			font					:longint):longint;
Begin
	exit(EVENT_IGNORE);
		//如果要回复消息，请调用酷Q方法发送，并且这里 exit(EVENT_BLOCK) - 截断本条消息，不再继续处理  注意：应用优先级设置为"最高"(10000)时，不得使用本返回值
		//如果不回复消息，交由之后的应用/过滤器处理，这里 exit(return EVENT_IGNORE) - 忽略本条消息
End;

{
* Type=2 群消息
}
Function code_eventGroupMsg(
			subType,sendTime		:longint;
			fromgroup,fromQQ		:int64;
			const fromAnonymous,msg	:ansistring;
			font					:longint):longint;
Var
	AnonymousMes	:	CQ_Type_GroupAnonymous;
Begin

	if (fromQQ=80000000) and (fromAnonymous<>'') then begin
		CQ_Tools_TextToAnonymous(fromAnonymous,AnonymousMes);
		//将匿名用户信息存到 AnonymousMes
	end;

	if msg='签到' then CQ_sendGroupMsg(AuthCode,fromgroup,
		sTop(CQCode_Group_At(fromQQ)+' : 签到并没有成功[CQ:image,file=funnyface.png]')
		);
		
	exit(EVENT_IGNORE);
	//关于返回值说明, 见“code_eventPrivateMsg”函数
End;

{
* Type=4 讨论组消息
}
Function code_eventDiscussMsg(
			subType,sendTime		:longint;
			fromDiscuss,fromQQ		:int64;
			msg						:ansistring;
			font					:longint):longint;
Begin
	exit(EVENT_IGNORE);
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
	exit(EVENT_IGNORE); 
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
stdcall;
Begin
	exit(EVENT_IGNORE); 
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
stdcall;
Begin
	CQ_sendGroupMsg(AuthCode,fromgroup,StoP('欢迎新人 [CQ:at,qq='+NumToChar(beingOperateQQ)+'] 加入本群'));
	exit(EVENT_IGNORE); 
	//关于返回值说明, 见“code_eventPrivateMsg”函数
End;


{
* Type=201 好友事件-好友已添加
}
Function code_eventFriend_Add(
			subType,sendTime		:longint;
			fromQQ					:int64):longint;
stdcall;
Begin
	exit(EVENT_IGNORE); 
	//关于返回值说明, 见“code_eventPrivateMsg”函数
End;


{
* Type=301 请求-好友添加
* msg 附言
* responseFlag
		反馈标识(处理请求用)
		这个我就不帮你转换成string了，反正你拿来也没什么用
}
Function code_eventRequest_AddFriend(
			subType,sendTime			:longint;
			fromQQ						:int64;
			const msg					:ansistring;
			responseFlag				:Pchar):longint;
stdcall;
Begin
	CQ_setFriendAddRequest(AuthCode, responseFlag, REQUEST_DENY,'');
	
	exit(EVENT_IGNORE); 
	//关于返回值说明, 见“code_eventPrivateMsg”函数
End;

{
* Type=302 请求-群添加
* subType 子类型，1/他人申请入群 2/自己(即登录号)受邀入群
* msg 附言
* responseFlag
		反馈标识(处理请求用)
		这个我也不帮你转换了
}
Function code_eventRequest_AddGroup(
			subType,sendTime			:longint;
			fromGroup,fromQQ			:int64;
			msg							:ansistring;
			responseFlag				:Pchar):longint;
stdcall;
Begin

	if fromGroup<>311954860 then CQ_setGroupAddRequestV2(AuthCode,responseflag,subType,REQUEST_ALLOW,'');
	
	exit(EVENT_IGNORE); 
	//关于返回值说明, 见“code_eventPrivateMsg”函数
End;