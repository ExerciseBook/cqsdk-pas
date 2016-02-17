{
	CoolQ SDK for Pascal
	API�汾	��	9.6
	������	��	FPC 2.0.4
}

library
	testdll;
	//DLL ����

Uses
	math,dateutils,sysutils,mysql4;
	//�����

Var
	AuthCode:longint;
	//AuthCode CoolQ����ʶ�����Ƿ��ǺϷ����õ������

//ϵͳ��ʾ����
Function MessageBox(hWnd:LONGINT;lpText:PCHAR;lpCaption:PCHAR;uType:DWORD):LONGINT;
	stdcall; external 'user32.dll' name 'MessageBoxA';

Const
	CQAPPID='com.binkic.cqdemo';
		//���޸�APPIDΪ���APPID
	
//������������
{$INCLUDE lib\CoolQ_variable.pas}
{$INCLUDE lib\CoolQ_DllFunction.pas}
{$INCLUDE lib\Tools.pas}
{$INCLUDE lib\CoolQ_Tools.pas}
{$INCLUDE lib\CoolQ_CQapplication.pas}
		
{******************************************************}
{$INCLUDE code\main.pas}
		//��Ĵ���ʹ�����ļ���ʼд��
{******************************************************}



{ 
* ����Ӧ�õ�ApiVer��Appid������󽫲������
}
Function AppInfo:pChar;
stdcall;
Begin
	exit(StoP(CQAPPINFO));
End;

{
* ����Ӧ��AuthCode����Q��ȡӦ����Ϣ��������ܸ�Ӧ�ã���������������������AuthCode��
* ��Ҫ�ڱ��������������κδ��룬���ⷢ���쳣���������ִ�г�ʼ����������Startup�¼���ִ�У�Type=1001����
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
	//�����������ⲿ���õĺ����б�
	//index ������ŵ�����ֻ��ǿ��֢����˳���õġ�_�� ò��û��ʲôʵ����;
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
	//���ﲻҪ�Ӷ�����_��
	//������Dll��ʼ�����ݣ��Ҹо��Ӷ����ᱬը��������û�Թ�
End.