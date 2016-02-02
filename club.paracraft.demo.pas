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
	dateutils,sysutils,mysql4,math;
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

Function _eventStartup:longint;
stdcall;
Begin
	randomize;
	exit(code_eventStartup);
End;

Function _eventExit:longint;
stdcall;
Begin
	exit(code_eventExit);
End;

Function _eventEnable:longint;
stdcall;
Begin
	randomize;
	exit(code_eventEnable);
End;

Function _eventDisable:longint;
stdcall;
Begin
	exit(code_eventDisable);
End;

Function _eventPrivateMsg(
			subType,sendTime		:longint;
			fromQQ					:int64;
			const msg				:Pchar;
			font					:longint):longint;
stdcall;
Begin	
	exit(code_eventPrivateMsg(
			subType,sendTime,
			fromQQ,
			PtoS(msg),
			font
		)
	);
End;

Function _eventGroupMsg(
			subType,sendTime		:longint;
			fromgroup,fromQQ		:int64;
			const fromAnonymous,msg	:Pchar;
			font					:longint):longint;
stdcall;
Begin
	
	exit(code_eventGroupMsg(
			subType,sendTime,
			fromgroup,fromQQ,
			PtoS(fromAnonymous),
			PtoS(msg),
			font
		)
	);	
End;

Function _eventDiscussMsg(
			subType,sendTime		:longint;
			fromDiscuss,fromQQ		:int64;
			msg						:Pchar;
			font					:longint):longint;
stdcall;
Begin
	exit(code_eventDiscussMsg(
		subType,sendTime,
		fromDiscuss,fromQQ,
		PtoS(msg),
		font
		)
	);
End;

Function _eventSystem_GroupAdmin(
			subType,sendTime		:longint;
			fromGroup,
			beingOperateQQ			:int64):longint;
stdcall;
Begin
	exit(code_eventSystem_GroupAdmin(
		subType,sendTime,
		fromGroup,
		beingOperateQQ
		)
	); 
End;

Function _eventSystem_GroupMemberDecrease(
			subType,sendTime		:longint;
			fromGroup,fromQQ,
			beingOperateQQ			:int64):longint;
stdcall;
Begin
	exit(code_eventSystem_GroupMemberDecrease(
			subType,sendTime,
			fromGroup,fromQQ,
			beingOperateQQ
		)
	);
End;

Function _eventSystem_GroupMemberIncrease(
			subType,sendTime		:longint;
			fromGroup,fromQQ,
			beingOperateQQ			:int64):longint;
stdcall;
Begin
	exit(code_eventSystem_GroupMemberIncrease(
			subType,sendTime,
			fromGroup,fromQQ,
			beingOperateQQ	
		)
	); 
End;

Function _eventFriend_Add(
			subType,sendTime		:longint;
			fromQQ					:int64):longint;
stdcall;
Begin
	exit(code_eventFriend_Add(
			subType,sendTime,fromQQ
		)
	);
End;

Function _eventRequest_AddFriend(
			subType,sendTime			:longint;
			fromQQ						:int64;
			const msg,responseFlag		:Pchar):longint;
stdcall;
Begin
	exit(code_eventRequest_AddFriend(
			subType,sendTime,
			fromQQ,
			PtoS(msg),
			responseFlag
		)
	);
End;

Function _eventRequest_AddGroup(
			subType,sendTime			:longint;
			fromGroup,fromQQ			:int64;
			msg,responseFlag			:Pchar):longint;
stdcall;
Begin

	exit(code_eventRequest_AddGroup(
			subType,sendTime,
			fromGroup,fromQQ,
			PtoS(msg),
			responseFlag
		)
	); 
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