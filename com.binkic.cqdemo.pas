{
	CoolQ SDK for Pascal
	API�汾	��	9.9
	������	��	FPC 2.0.4
	
	ע�� Free Pascal
		���ʱ������Ե�ǰϵͳʱ��� 1970-1-1 00:00:00 ��ΪUnixʱ������
		Ȼ����Ѷ���ݵ���Ϣ���� ��׼ʱ���1970-1-1 00:00:00 ��Ϊʱ������
}
library
	testdll;
	//DLL ����
{$APPTYPE GUI}
{$I-}
{$h+}
{$UNITPATH lib\}

Uses
	iconv,CoolQSDK,		//��QSDK��Ԫ
	math,dateutils,sysutils,Classes;
	//�����

//ϵͳ��ʾ����
Function MessageBox(hWnd:LONGINT;lpText:PCHAR;lpCaption:PCHAR;uType:DWORD):LONGINT;
	stdcall; external 'user32.dll' name 'MessageBoxA';

	
//������������

//{$INCLUDE lib\ESSGM_DllFunction.pas} //Ȩ�޲��֧�� https://cqp.cc/t/25690 �� ��Ԫ��ʽ��֧����� lib\ESSGM_pas		
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
	CQAPPID:='com.binkic.cqdemo';
	//���޸�APPIDΪ���APPID
	
	
	//GlobalUTF8Mode:=true; //�Ƿ���ȫ��UTF8ģʽ
	{
		��Q������api����ʹ�õ���gb18030��Ϊunicode֧�֡�
		����������ܺ����ڵ�����api���������sdk���õĹ����Զ���gb18030��utf8��ת��
	}
	
	//�������в����޸� //ûë������ȷ�����С� #����
	CQAPPINFO:=CQAPIVERTEXT+','+CQAPPID;
{$IFDEF FPC}
	exit(StoP(CQAPPINFO));
{$ELSE}
	Result:=(StoP(CQAPPINFO));
{$ENDIF}
End;

{
* ����Ӧ��AuthCode����Q��ȡӦ����Ϣ��������ܸ�Ӧ�ã���������������������AuthCode��
* ��Ҫ�ڱ��������������κδ��룬���ⷢ���쳣���������ִ�г�ʼ����������Startup�¼���ִ�У�Type=1001����
}
Function Initialize(ac:longint):longint;
stdcall;
Begin
	AuthCode:=ac;
{$IFDEF FPC}
	exit(0);
{$ELSE}
	Result:=0;
{$ENDIF}
End;

Function _eventStartup:longint;
stdcall;
Begin
	randomize;
{$IFDEF FPC}
	exit(code_eventStartup);
{$ELSE}
	result:=code_eventStartup;
{$ENDIF}
End;

Function _eventExit:longint;
stdcall;
Begin
{$IFDEF FPC}
	exit(code_eventExit);
{$ELSE}
	result:=code_eventExit;
{$ENDIF}
End;

Function _eventEnable:longint;
stdcall;
Begin
	randomize;
{$IFDEF FPC}
	exit(code_eventEnable);
{$ELSE}
	result:=code_eventEnable;
{$ENDIF}
End;

Function _eventDisable:longint;
stdcall;
Begin
{$IFDEF FPC}
	exit(code_eventDisable);
{$ELSE}
	result:=code_eventDisable;
{$ENDIF}
End;

Function _eventPrivateMsg(
			subType,MsgID		:longint;
			fromQQ					:int64;
			const msg				:Pchar;
			font					:longint):longint;
stdcall;
Begin
{$IFDEF FPC}
	if GlobalUTF8Mode
	then
		exit(code_eventPrivateMsg(
				subType,MsgID,
				fromQQ,
				CoolQ_Tools_AnsiToUTF8(PtoS(msg)),
				font
			)
		)
	else
		exit(code_eventPrivateMsg(
				subType,MsgID,
				fromQQ,
				PtoS(msg),
				font
			)
		);
{$ELSE}
	if GlobalUTF8Mode
	then
		result:=code_eventPrivateMsg(
				subType,MsgID,
				fromQQ,
				CoolQ_Tools_AnsiToUTF8(PtoS(msg)),
				font
			)
	else
		result:=code_eventPrivateMsg(
				subType,MsgID,
				fromQQ,
				PtoS(msg),
				font
			);
{$ENDIF}
End;

Function _eventGroupMsg(
			subType,MsgID		:longint;
			fromgroup,fromQQ		:int64;
			const fromAnonymous,msg	:Pchar;
			font					:longint):longint;
stdcall;
Begin
{$IFDEF FPC}
	if GlobalUTF8Mode
	then
		exit(code_eventGroupMsg(
				subType,MsgID,
				fromgroup,fromQQ,
				PtoS(fromAnonymous),
				CoolQ_Tools_AnsiToUTF8(PtoS(msg)),
				font
			)
		)
	else
		exit(code_eventGroupMsg(
				subType,MsgID,
				fromgroup,fromQQ,
				PtoS(fromAnonymous),
				PtoS(msg),
				font
			)
		);
{$ELSE}
	if GlobalUTF8Mode
	then
		result:=code_eventGroupMsg(
				subType,MsgID,
				fromgroup,fromQQ,
				PtoS(fromAnonymous),
				CoolQ_Tools_AnsiToUTF8(PtoS(msg)),
				font
			)
	else
		result:=code_eventGroupMsg(
				subType,MsgID,
				fromgroup,fromQQ,
				PtoS(fromAnonymous),
				PtoS(msg),
				font
			);
{$ENDIF}
End;

Function _eventDiscussMsg(
			subType,MsgID		:longint;
			fromDiscuss,fromQQ		:int64;
			msg						:Pchar;
			font					:longint):longint;
stdcall;
Begin
{$IFDEF FPC}
	if GlobalUTF8Mode
	then
		exit(code_eventDiscussMsg(
			subType,MsgID,
			fromDiscuss,fromQQ,
			CoolQ_Tools_AnsiToUTF8(PtoS(msg)),
			font
			)
		)
	else
		exit(code_eventDiscussMsg(
			subType,MsgID,
			fromDiscuss,fromQQ,
			PtoS(msg),
			font
			)
		)
{$ELSE}
	if GlobalUTF8Mode
	then
		result:=(code_eventDiscussMsg(
			subType,MsgID,
			fromDiscuss,fromQQ,
			CoolQ_Tools_AnsiToUTF8(PtoS(msg)),
			font
			)
	else
		result:=(code_eventDiscussMsg(
			subType,MsgID,
			fromDiscuss,fromQQ,
			PtoS(msg),
			font
			)
{$ENDIF}
End;

Function _eventGroupUpload(
			subType,sendTime	:longint;
			fromGroup,fromQQ	:int64;
			fileinfo			:Pchar):longint;
stdcall;
Begin
{$IFDEF FPC}
	exit(code_eventGroupUpload(
			subType,sendTime,
			fromGroup,fromQQ,
			PtoS(fileinfo)));
{$ELSE}
	result:=code_eventGroupUpload(
			subType,sendTime,
			fromGroup,fromQQ,
			PtoS(fileinfo));
{$ENDIF}
End;

Function _eventSystem_GroupAdmin(
			subType,sendTime		:longint;
			fromGroup,
			beingOperateQQ			:int64):longint;
stdcall;
Begin
{$IFDEF FPC}
	exit(code_eventSystem_GroupAdmin(
		subType,sendTime,
		fromGroup,
		beingOperateQQ
		)
	); 
{$ELSE}
	result:=(code_eventSystem_GroupAdmin(
		subType,sendTime,
		fromGroup,
		beingOperateQQ
		);
{$ENDIF}
End;

Function _eventSystem_GroupMemberDecrease(
			subType,sendTime		:longint;
			fromGroup,fromQQ,
			beingOperateQQ			:int64):longint;
stdcall;
Begin
{$IFDEF FPC}
	exit(code_eventSystem_GroupMemberDecrease(
			subType,sendTime,
			fromGroup,fromQQ,
			beingOperateQQ
		)
	);
{$ELSE}
	result:=code_eventSystem_GroupMemberDecrease(
			subType,sendTime,
			fromGroup,fromQQ,
			beingOperateQQ
		);
{$ENDIF}
End;

Function _eventSystem_GroupMemberIncrease(
			subType,sendTime		:longint;
			fromGroup,fromQQ,
			beingOperateQQ			:int64):longint;
stdcall;
Begin
{$IFDEF FPC}
	exit(code_eventSystem_GroupMemberIncrease(
			subType,sendTime,
			fromGroup,fromQQ,
			beingOperateQQ	
		)
	); 
{$ELSE}
	result:=code_eventSystem_GroupMemberIncrease(
			subType,sendTime,
			fromGroup,fromQQ,
			beingOperateQQ	
		);
{$ENDIF}
End;

Function _eventFriend_Add(
			subType,sendTime		:longint;
			fromQQ					:int64):longint;
stdcall;
Begin
{$IFDEF FPC}
	exit(code_eventFriend_Add(
			subType,sendTime,fromQQ
		)
	);
{$ELSE}
	result:=code_eventFriend_Add(
			subType,sendTime,fromQQ
		);
{$ENDIF}
End;

Function _eventRequest_AddFriend(
			subType,sendTime			:longint;
			fromQQ						:int64;
			const msg,responseFlag		:Pchar):longint;
stdcall;
Begin
{$IFDEF FPC}
	if GlobalUTF8Mode
	then
		exit(code_eventRequest_AddFriend(
				subType,sendTime,
				fromQQ,
				CoolQ_Tools_AnsiToUTF8(PtoS(msg)),
				responseFlag
			)
		)
	else
		exit(code_eventRequest_AddFriend(
				subType,sendTime,
				fromQQ,
				PtoS(msg),
				responseFlag
			)
		);
{$ELSE}
	if GlobalUTF8Mode
	then
		result:=code_eventRequest_AddFriend(
				subType,sendTime,
				fromQQ,
				CoolQ_Tools_AnsiToUTF8(PtoS(msg)),
				responseFlag
			)
	else
		result:=code_eventRequest_AddFriend(
				subType,sendTime,
				fromQQ,
				PtoS(msg),
				responseFlag
			);
{$ENDIF}
End;

Function _eventRequest_AddGroup(
			subType,sendTime			:longint;
			fromGroup,fromQQ			:int64;
			msg,responseFlag			:Pchar):longint;
stdcall;
Begin
{$IFDEF FPC}
	if GlobalUTF8Mode
	then
		exit(code_eventRequest_AddGroup(
				subType,sendTime,
				fromGroup,fromQQ,
				CoolQ_Tools_AnsiToUTF8(PtoS(msg)),
				responseFlag
			)
		)
	else
		exit(code_eventRequest_AddGroup(
				subType,sendTime,
				fromGroup,fromQQ,
				PtoS(msg),
				responseFlag
			)
		);
{$ELSE}
	if GlobalUTF8Mode
	then
		result:=code_eventRequest_AddGroup(
				subType,sendTime,
				fromGroup,fromQQ,
				CoolQ_Tools_AnsiToUTF8(PtoS(msg)),
				responseFlag
			)
	else
		result:=code_eventRequest_AddGroup(
				subType,sendTime,
				fromGroup,fromQQ,
				PtoS(msg),
				responseFlag
			);
{$ENDIF}
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
	_eventGroupUpload index 10,
	_eventSystem_GroupAdmin index 11,
	_eventSystem_GroupMemberDecrease index 12,
	_eventSystem_GroupMemberIncrease index 13,
	_eventFriend_Add index 14,
	_eventRequest_AddFriend index 15,
	_eventRequest_AddGroup index 16,
	
	
	_menuA index 17,
	_menuB index 18;
	
Begin
End.