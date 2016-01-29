{
	CoolQ SDK for Pascal
	API�汾	��	9.6
	������	��	FPC 2.0.4
===================================================
	ò�ƴ���ҪANSI��ʽ�Ų������ַ�������
	
	�����ļ����ݲ�Ҫ����Ķ���SDK�ĸ��»ᱻ����
	
	��ǰ�ļ�
		library 	�����ݲ�Ҫ�޸�
		uses		�����ݸ�����Ҫ�����޸�
		$include	�����ݸ�����Ҫ�����޸�
		Var			�����ݲ�Ҫ�޸�
					��Ҫ��������뵽 code\main.pas ��
		exports		�����ݸ�����Ҫ�����޸�
		�¼�����	������Ժ����code\main.pas�Ǳ����һЩ���õġ����Է���ʳ�á�
					���ݵ�code\main.pas�Ǳߵ������һ��pchar��ת����string��ʳ�á�
					
	lib\CoolQ_variable.pas
		������APPID��Ҫ���ġ�����Ĳ���Ҫ
		����ļ����������
		
	lib\CoolQ_Function.pas
		����ļ����Ӳ��ø��ˡ�
		������CoolQ��API
}

library
	testdll;
	//DLL ����

Uses
	dateutils,sysutils;
	//�����
	
Var
	AuthCode:longint;
	//AuthCode CoolQ����ʶ�����Ƿ��ǺϷ����õ������

//ϵͳ��ʾ����
Function MessageBox(hWnd:LONGINT;lpText:PCHAR;lpCaption:PCHAR;uType:DWORD):LONGINT;
	stdcall; external 'user32.dll' name 'MessageBoxA';
	
//������������
{$INCLUDE lib\Tools.pas}
		//һЩ��������
{$INCLUDE lib\CoolQ_variable.pas}
{$INCLUDE lib\CoolQ_Function.pas}
		//CoolQ Api
		
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

{
* Type=1001 ��Q����
* ���۱�Ӧ���Ƿ����ã������������ڿ�Q������ִ��һ�Σ���������ִ��Ӧ�ó�ʼ�����롣
* ��Ǳ�Ҫ����������������ش��ڡ���������Ӳ˵������û��ֶ��򿪴��ڣ�
}
Function _eventStartup:longint;
stdcall;
Begin
	exit(0);
End;

{
* Type=1002 ��Q�˳�
* ���۱�Ӧ���Ƿ����ã������������ڿ�Q�˳�ǰִ��һ�Σ���������ִ�в���رմ��롣
* ������������Ϻ󣬿�Q���ܿ�رգ��벻Ҫ��ͨ���̵߳ȷ�ʽִ���������롣
}
Function _eventExit:longint;
stdcall;
Begin
	exit(0);
End;

{
* Type=1003 Ӧ���ѱ�����
* ��Ӧ�ñ����ú󣬽��յ����¼���
* �����Q����ʱӦ���ѱ����ã�����_eventStartup(Type=1001,��Q����)�����ú󣬱�����Ҳ��������һ�Ρ�
* ��Ǳ�Ҫ����������������ش��ڡ���������Ӳ˵������û��ֶ��򿪴��ڣ�
}
Function _eventEnable:longint;
stdcall;
Begin
	exit(0);
End;

{
* Type=1004 Ӧ�ý���ͣ��
* ��Ӧ�ñ�ͣ��ǰ�����յ����¼���
* �����Q����ʱӦ���ѱ�ͣ�ã��򱾺���*����*�����á�
* ���۱�Ӧ���Ƿ����ã���Q�ر�ǰ��������*����*�����á�
}
Function _eventDisable:longint;
stdcall;
Begin
	exit(0);
End;

{
* Type=21 ˽����Ϣ
* subType �����ͣ�11/���Ժ��� 1/��������״̬ 2/����Ⱥ 3/����������
}
Function _eventPrivateMsg(
			subType,sendTime		:longint;
			fromQQ					:int64;
			const msg				:Pchar;
			font					:longint):longint;
stdcall;
Begin	
	//CQ_sendPrivateMsg(AuthCode,fromQQ,msg);
		//˽�ĸ�����
		
	exit(EVENT_IGNORE);
		//���Ҫ�ظ���Ϣ������ÿ�Q�������ͣ��������� exit(EVENT_BLOCK) - �ضϱ�����Ϣ�����ټ�������  ע�⣺Ӧ�����ȼ�����Ϊ"���"(10000)ʱ������ʹ�ñ�����ֵ
		//������ظ���Ϣ������֮���Ӧ��/�������������� exit(return EVENT_IGNORE) - ���Ա�����Ϣ
End;

{
* Type=2 Ⱥ��Ϣ
}
Function _eventGroupMsg(
			subType,sendTime		:longint;
			fromgroup,fromQQ		:int64;
			const fromAnonymous,msg	:Pchar;
			font					:longint):longint;
stdcall;
Begin
	if msg='ǩ��' then CQ_sendGroupMsg(AuthCode,fromgroup,
		sTop(CQ_Group_At(fromQQ)+' : ǩ����û�гɹ�[CQ:image,file=funnyface.png]')
		);
	//if fromgroup=311954860 then CQ_sendGroupMsg(AuthCode,fromgroup,StoP(PtoS(msg)));
		//������	
	exit(EVENT_IGNORE);	//���ڷ���ֵ˵��, ����_eventPrivateMsg������
End;

{
* Type=4 ��������Ϣ
}
Function _eventDiscussMsg(
			subType,sendTime		:longint;
			fromDiscuss,fromQQ		:int64;
			msg						:Pchar;
			font					:longint):longint;
stdcall;
Begin
	exit(EVENT_IGNORE) //���ڷ���ֵ˵��, ����_eventPrivateMsg������
End;

{
* Type=101 Ⱥ�¼�-����Ա�䶯
* subType �����ͣ�1/��ȡ������Ա 2/�����ù���Ա
}
Function _eventSystem_GroupAdmin(
			subType,sendTime		:longint;
			fromGroup,
			beingOperateQQ			:int64):longint;
stdcall;
Begin
	exit(EVENT_IGNORE); //���ڷ���ֵ˵��, ����_eventPrivateMsg������
End;

{
* Type=102 Ⱥ�¼�-Ⱥ��Ա����
* subType �����ͣ�1/ȺԱ�뿪 2/ȺԱ���� 3/�Լ�(����¼��)����
* fromQQ ������QQ(��subTypeΪ2��3ʱ����)
* beingOperateQQ ������QQ
}
Function _eventSystem_GroupMemberDecrease(
			subType,sendTime		:longint;
			fromGroup,fromQQ,
			beingOperateQQ			:int64):longint;
stdcall;
Begin
	exit(EVENT_IGNORE); //���ڷ���ֵ˵��, ����_eventPrivateMsg������
End;

{
* Type=103 Ⱥ�¼�-Ⱥ��Ա����
* subType �����ͣ�1/����Ա��ͬ�� 2/����Ա����
* fromQQ ������QQ(������ԱQQ)
* beingOperateQQ ������QQ(����Ⱥ��QQ)
}
Function _eventSystem_GroupMemberIncrease(
			subType,sendTime		:longint;
			fromGroup,fromQQ,
			beingOperateQQ			:int64):longint;
stdcall;
Begin
	CQ_sendGroupMsg(AuthCode,fromgroup,StoP('��ӭ���� [CQ:at,qq='+NumToChar(beingOperateQQ)+'] ���뱾Ⱥ'));
	exit(EVENT_IGNORE); //���ڷ���ֵ˵��, ����_eventPrivateMsg������
End;



{
* Type=201 �����¼�-���������
}
Function _eventFriend_Add(
			subType,sendTime		:longint;
			fromQQ					:int64):longint;
stdcall;
Begin
	exit(EVENT_IGNORE); //���ڷ���ֵ˵��, ����_eventPrivateMsg������
End;

{
* Type=301 ����-�������
* msg ����
* responseFlag ������ʶ(����������)
}
Function _eventRequest_AddFriend(
			subType,sendTime			:longint;
			fromQQ						:int64;
			const msg,responseFlag		:Pchar):longint;
stdcall;
Begin
	CQ_setFriendAddRequest(AuthCode, responseFlag, REQUEST_DENY,'');
	exit(EVENT_IGNORE); //���ڷ���ֵ˵��, ����_eventPrivateMsg������
End;

{
* Type=302 ����-Ⱥ���
* subType �����ͣ�1/����������Ⱥ 2/�Լ�(����¼��)������Ⱥ
* msg ����
* responseFlag ������ʶ(����������)
}
Function _eventRequest_AddGroup(
			subType,sendTime			:longint;
			fromGroup,fromQQ			:int64;
			msg,responseFlag			:Pchar):longint;
stdcall;
Begin

	if fromGroup<>311954860 then CQ_setGroupAddRequestV2(AuthCode,responseflag,subType,REQUEST_ALLOW,'');
	
	exit(EVENT_IGNORE); //���ڷ���ֵ˵��, ����_eventPrivateMsg������
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