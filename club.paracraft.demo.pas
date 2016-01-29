{
	CoolQ SDK for Pascal
	API版本	：	9.6
	编译器	：	FPC 2.0.4
===================================================
	貌似代码要ANSI格式才不会让字符串鬼畜
	
	以下文件内容不要随意改动，SDK的更新会被覆盖
	
	当前文件
		library 	下内容不要修改
		uses		下内容根据需要自行修改
		$include	下内容根据需要自行修改
		Var			下内容不要修改
					需要定义变量请到 code\main.pas 下
		exports		下内容根据需要自行修改
		事件函数	这个我以后会在code\main.pas那边添加一些调用的。可以方便食用。
					传递到code\main.pas那边的内容我会把pchar给转换成string来食用。
					
	lib\CoolQ_variable.pas
		里面有APPID需要更改。其余的不需要
		这个文件会后续更新
		
	lib\CoolQ_Function.pas
		这个文件更加不用改了。
		里面是CoolQ的API
}

library
	testdll;
	//DLL 编译

Uses
	dateutils,sysutils;
	//载入库
	
Var
	AuthCode:longint;
	//AuthCode CoolQ用来识别你是否是合法调用的玩意儿

//系统提示框函数
Function MessageBox(hWnd:LONGINT;lpText:PCHAR;lpCaption:PCHAR;uType:DWORD):LONGINT;
	stdcall; external 'user32.dll' name 'MessageBoxA';
	
//载入其他内容
{$INCLUDE lib\Tools.pas}
		//一些基本工具
{$INCLUDE lib\CoolQ_variable.pas}
{$INCLUDE lib\CoolQ_Function.pas}
		//CoolQ Api
		
{******************************************************}
{$INCLUDE code\main.pas}
		//你的代码就从这个文件开始写吧
{******************************************************}



{ 
* 返回应用的ApiVer、Appid，打包后将不会调用
}
Function AppInfo:pChar;
stdcall;
Begin
	exit(StoP(CQAPPINFO));
End;

{
* 接收应用AuthCode，酷Q读取应用信息后，如果接受该应用，将会调用这个函数并传递AuthCode。
* 不要在本函数处理其他任何代码，以免发生异常情况。如需执行初始化代码请在Startup事件中执行（Type=1001）。
}
Function Initialize(ac:longint):longint;
stdcall;
Begin
	AuthCode:=ac;
	exit(0);
End;

{
* Type=1001 酷Q启动
* 无论本应用是否被启用，本函数都会在酷Q启动后执行一次，请在这里执行应用初始化代码。
* 如非必要，不建议在这里加载窗口。（可以添加菜单，让用户手动打开窗口）
}
Function _eventStartup:longint;
stdcall;
Begin
	exit(0);
End;

{
* Type=1002 酷Q退出
* 无论本应用是否被启用，本函数都会在酷Q退出前执行一次，请在这里执行插件关闭代码。
* 本函数调用完毕后，酷Q将很快关闭，请不要再通过线程等方式执行其他代码。
}
Function _eventExit:longint;
stdcall;
Begin
	exit(0);
End;

{
* Type=1003 应用已被启用
* 当应用被启用后，将收到此事件。
* 如果酷Q载入时应用已被启用，则在_eventStartup(Type=1001,酷Q启动)被调用后，本函数也将被调用一次。
* 如非必要，不建议在这里加载窗口。（可以添加菜单，让用户手动打开窗口）
}
Function _eventEnable:longint;
stdcall;
Begin
	exit(0);
End;

{
* Type=1004 应用将被停用
* 当应用被停用前，将收到此事件。
* 如果酷Q载入时应用已被停用，则本函数*不会*被调用。
* 无论本应用是否被启用，酷Q关闭前本函数都*不会*被调用。
}
Function _eventDisable:longint;
stdcall;
Begin
	exit(0);
End;

{
* Type=21 私聊消息
* subType 子类型，11/来自好友 1/来自在线状态 2/来自群 3/来自讨论组
}
Function _eventPrivateMsg(
			subType,sendTime		:longint;
			fromQQ					:int64;
			const msg				:Pchar;
			font					:longint):longint;
stdcall;
Begin	
	//CQ_sendPrivateMsg(AuthCode,fromQQ,msg);
		//私聊复读机
		
	exit(EVENT_IGNORE);
		//如果要回复消息，请调用酷Q方法发送，并且这里 exit(EVENT_BLOCK) - 截断本条消息，不再继续处理  注意：应用优先级设置为"最高"(10000)时，不得使用本返回值
		//如果不回复消息，交由之后的应用/过滤器处理，这里 exit(return EVENT_IGNORE) - 忽略本条消息
End;

{
* Type=2 群消息
}
Function _eventGroupMsg(
			subType,sendTime		:longint;
			fromgroup,fromQQ		:int64;
			const fromAnonymous,msg	:Pchar;
			font					:longint):longint;
stdcall;
Begin
	if msg='签到' then CQ_sendGroupMsg(AuthCode,fromgroup,
		sTop(CQ_Group_At(fromQQ)+' : 签到并没有成功[CQ:image,file=funnyface.png]')
		);
	//if fromgroup=311954860 then CQ_sendGroupMsg(AuthCode,fromgroup,StoP(PtoS(msg)));
		//复读机	
	exit(EVENT_IGNORE);	//关于返回值说明, 见“_eventPrivateMsg”函数
End;

{
* Type=4 讨论组消息
}
Function _eventDiscussMsg(
			subType,sendTime		:longint;
			fromDiscuss,fromQQ		:int64;
			msg						:Pchar;
			font					:longint):longint;
stdcall;
Begin
	exit(EVENT_IGNORE) //关于返回值说明, 见“_eventPrivateMsg”函数
End;

{
* Type=101 群事件-管理员变动
* subType 子类型，1/被取消管理员 2/被设置管理员
}
Function _eventSystem_GroupAdmin(
			subType,sendTime		:longint;
			fromGroup,
			beingOperateQQ			:int64):longint;
stdcall;
Begin
	exit(EVENT_IGNORE); //关于返回值说明, 见“_eventPrivateMsg”函数
End;

{
* Type=102 群事件-群成员减少
* subType 子类型，1/群员离开 2/群员被踢 3/自己(即登录号)被踢
* fromQQ 操作者QQ(仅subType为2、3时存在)
* beingOperateQQ 被操作QQ
}
Function _eventSystem_GroupMemberDecrease(
			subType,sendTime		:longint;
			fromGroup,fromQQ,
			beingOperateQQ			:int64):longint;
stdcall;
Begin
	exit(EVENT_IGNORE); //关于返回值说明, 见“_eventPrivateMsg”函数
End;

{
* Type=103 群事件-群成员增加
* subType 子类型，1/管理员已同意 2/管理员邀请
* fromQQ 操作者QQ(即管理员QQ)
* beingOperateQQ 被操作QQ(即加群的QQ)
}
Function _eventSystem_GroupMemberIncrease(
			subType,sendTime		:longint;
			fromGroup,fromQQ,
			beingOperateQQ			:int64):longint;
stdcall;
Begin
	CQ_sendGroupMsg(AuthCode,fromgroup,StoP('欢迎新人 [CQ:at,qq='+NumToChar(beingOperateQQ)+'] 加入本群'));
	exit(EVENT_IGNORE); //关于返回值说明, 见“_eventPrivateMsg”函数
End;



{
* Type=201 好友事件-好友已添加
}
Function _eventFriend_Add(
			subType,sendTime		:longint;
			fromQQ					:int64):longint;
stdcall;
Begin
	exit(EVENT_IGNORE); //关于返回值说明, 见“_eventPrivateMsg”函数
End;

{
* Type=301 请求-好友添加
* msg 附言
* responseFlag 反馈标识(处理请求用)
}
Function _eventRequest_AddFriend(
			subType,sendTime			:longint;
			fromQQ						:int64;
			const msg,responseFlag		:Pchar):longint;
stdcall;
Begin
	CQ_setFriendAddRequest(AuthCode, responseFlag, REQUEST_DENY,'');
	exit(EVENT_IGNORE); //关于返回值说明, 见“_eventPrivateMsg”函数
End;

{
* Type=302 请求-群添加
* subType 子类型，1/他人申请入群 2/自己(即登录号)受邀入群
* msg 附言
* responseFlag 反馈标识(处理请求用)
}
Function _eventRequest_AddGroup(
			subType,sendTime			:longint;
			fromGroup,fromQQ			:int64;
			msg,responseFlag			:Pchar):longint;
stdcall;
Begin

	if fromGroup<>311954860 then CQ_setGroupAddRequestV2(AuthCode,responseflag,subType,REQUEST_ALLOW,'');
	
	exit(EVENT_IGNORE); //关于返回值说明, 见“_eventPrivateMsg”函数
End;

exports
	//这里是允许外部调用的函数列表
	//index 后面跟着的数字只是强迫症调整顺序用的←_← 貌似没有什么实际用途
	AppInfo index 1,
	Initialize index 2,
	_eventStartup index 3,
	_eventExit index 4,
	_eventEnable index 5,
	_eventDisable index 6,
	_eventPrivateMsg index 7,
	_eventGroupMsg index 8,
	_eventDiscussMsg index 9,
	_eventSystem_GroupAdmin index 10,
	_eventSystem_GroupMemberDecrease index 11,
	_eventSystem_GroupMemberIncrease index 12,
	_eventFriend_Add index 13,
	_eventRequest_AddFriend index 14,
	_eventRequest_AddGroup index 15,
	
	
	_menuA index 16,
	_menuB index 17;

Begin
	//这里不要加东西←_←
	//这里是Dll初始化内容，我感觉加东西会爆炸。反正我没试过
End.