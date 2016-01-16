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
	
//����һЩ��������
{$INCLUDE lib\cqh.pas}
		//CoolQApi
{$INCLUDE lib\sp.pas}
		//һЩ��������

//ϵͳ��ʾ����
Function MessageBox(hWnd:LONGINT;lpText:PCHAR;lpCaption:PCHAR;uType:DWORD):LONGINT;
	stdcall; external 'user32.dll' name 'MessageBoxA';

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
Begin
	exit(0);
End;

{
* Type=1002 ��Q�˳�
* ���۱�Ӧ���Ƿ����ã������������ڿ�Q�˳�ǰִ��һ�Σ���������ִ�в���رմ��롣
* ������������Ϻ󣬿�Q���ܿ�رգ��벻Ҫ��ͨ���̵߳ȷ�ʽִ���������롣
}
Function _eventExit:longint;
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
Begin	
	CQ_sendPrivateMsg(AuthCode,fromQQ,msg);
		//˽�ĸ�����
		
	exit(EVENT_IGNORE);
		//���Ҫ�ظ���Ϣ������ÿ�Q�������ͣ��������� return EVENT_BLOCK - �ضϱ�����Ϣ�����ټ�������  ע�⣺Ӧ�����ȼ�����Ϊ"���"(10000)ʱ������ʹ�ñ�����ֵ
		//������ظ���Ϣ������֮���Ӧ��/�������������� return EVENT_IGNORE - ���Ա�����Ϣ
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
	if fromgroup=311954860 then CQ_sendGroupMsg(AuthCode,fromgroup,msg);
		//������	
	exit(EVENT_IGNORE);	//���ڷ���ֵ˵��, ����_eventPrivateMsg������
End;

{
* Type=4 ��������Ϣ
}
Function _eventDiscussMsg(
			subType,sendTime		:longint;
			fromDiscuss,fromQQ		:longint;
			msg						:Pchar;
			font					:longint;):longint;
Begin
	exit(EVENT_IGNORE) //���ڷ���ֵ˵��, ����_eventPrivateMsg������
End;

{
* �˵������� .json �ļ������ò˵���Ŀ��������
* �����ʹ�ò˵������� .json ���˴�ɾ�����ò˵�
}
Function _menuA():longint;
stdcall;
Begin
	MessageBox(0,StoP('�������AuthCodeΪ : '+NumToChar(AuthCode)),'���� _ AuthCode��ѯ',36);
	exit(0);
End;
Function _menuB():longint;
stdcall;
Begin
	MessageBox(0,StoP('��ǰʱ�� : '+DateTimeToStr(now)),'���� _ ��ǰʱ��',36);
	exit(0);
End;

exports
	//�����������ⲿ���õĺ����б�
	//index ������ŵ�����ֻ��ǿ��֢����˳���õġ�_�� ò��û��ʲôʵ����;
	AppInfo index 1,
	Initialize index 2,
	_eventGroupMsg index 3,
	_menuA index 4,
	_menuB index 5
	;

Begin
	//���ﲻҪ�Ӷ�����_��
	//������Dll��ʼ�����ݣ��Ҹо��Ӷ����ᱬը��������û�Թ�
End.