{
	CoolQ SDK for Pascal
	Api Version 9.6
	Code By Eric_Lian(505311335@qq.com)
	Thanke For Coxxs(i@coxxs.com)
}

library
	testdll;

Uses
	dateutils,sysutils;
	
Var
	AuthCode:longint;
	
//载入一些其他内容
{$INCLUDE lib\cqh.pas}
		//CoolQApi
{$INCLUDE lib\sp.pas}
		//一些基本工具

//系统提示框函数
Function MessageBox(hWnd:LONGINT;lpText:PCHAR;lpCaption:PCHAR;uType:DWORD):LONGINT;
	stdcall; external 'user32.dll' name 'MessageBoxA';

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
Begin
	exit(0);
End;

{
* Type=1002 酷Q退出
* 无论本应用是否被启用，本函数都会在酷Q退出前执行一次，请在这里执行插件关闭代码。
* 本函数调用完毕后，酷Q将很快关闭，请不要再通过线程等方式执行其他代码。
}
Function _eventExit:longint;
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
Begin	
	CQ_sendPrivateMsg(AuthCode,fromQQ,msg);
		//私聊复读机
		
	exit(EVENT_IGNORE);
		//如果要回复消息，请调用酷Q方法发送，并且这里 return EVENT_BLOCK - 截断本条消息，不再继续处理  注意：应用优先级设置为"最高"(10000)时，不得使用本返回值
		//如果不回复消息，交由之后的应用/过滤器处理，这里 return EVENT_IGNORE - 忽略本条消息
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
	if fromgroup=311954860 then CQ_sendGroupMsg(AuthCode,fromgroup,msg);
		//复读机	
	exit(EVENT_IGNORE);	//关于返回值说明, 见“_eventPrivateMsg”函数
End;

{
* Type=4 讨论组消息
}
Function _eventDiscussMsg(
			subType,sendTime		:longint;
			fromDiscuss,fromQQ		:longint;
			msg						:Pchar;
			font					:longint;):longint;
Begin
	exit(EVENT_IGNORE) //关于返回值说明, 见“_eventPrivateMsg”函数
End;

{
* 菜单，可在 .json 文件中设置菜单数目、函数名
* 如果不使用菜单，请在 .json 及此处删除无用菜单
}
Function _menuA():longint;
stdcall;
Begin
	MessageBox(0,StoP('本插件的AuthCode为 : '+NumToChar(AuthCode)),'样例 _ AuthCode查询',36);
	exit(0);
End;
Function _menuB():longint;
stdcall;
Begin
	MessageBox(0,StoP('当前时间 : '+DateTimeToStr(now)),'样例 _ 当前时间',36);
	exit(0);
End;

exports
	//这里是允许外部调用的函数列表
	//index 后面跟着的数字只是强迫症调整顺序用的←_← 貌似没有什么实际用途
	AppInfo index 1,
	Initialize index 2,
	_eventGroupMsg index 3,
	_menuA index 4,
	_menuB index 5
	;

Begin
	//这里不要加东西←_←
	//这里是Dll初始化内容，我感觉加东西会爆炸。反正我没试过
End.