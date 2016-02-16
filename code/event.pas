{
* Type=1001 ��Q����
* ���۱�Ӧ���Ƿ����ã������������ڿ�Q������ִ��һ�Σ���������ִ��Ӧ�ó�ʼ�����롣
* ��Ǳ�Ҫ����������������ش��ڡ���������Ӳ˵������û��ֶ��򿪴��ڣ�
}
Function code_eventStartup:longint;
Begin
	exit(0)
End;

{
* Type=1002 ��Q�˳�
* ���۱�Ӧ���Ƿ����ã������������ڿ�Q�˳�ǰִ��һ�Σ���������ִ�в���رմ��롣
* ������������Ϻ󣬿�Q���ܿ�رգ��벻Ҫ��ͨ���̵߳ȷ�ʽִ���������롣
}
Function code_eventExit:longint;
Begin
	exit(0);
End;

{
* Type=1003 Ӧ���ѱ�����
* ��Ӧ�ñ����ú󣬽��յ����¼���
* �����Q����ʱӦ���ѱ����ã�����_eventStartup(Type=1001,��Q����)�����ú󣬱�����Ҳ��������һ�Ρ�
* ��Ǳ�Ҫ����������������ش��ڡ���������Ӳ˵������û��ֶ��򿪴��ڣ�
}
Function code_eventEnable:longint;
Begin
	exit(0)
End;

{
* Type=1004 Ӧ�ý���ͣ��
* ��Ӧ�ñ�ͣ��ǰ�����յ����¼���
* �����Q����ʱӦ���ѱ�ͣ�ã��򱾺���*����*�����á�
* ���۱�Ӧ���Ƿ����ã���Q�ر�ǰ��������*����*�����á�
}
Function code_eventDisable:longint;
Begin
	exit(0);
End;

{
* Type=21 ˽����Ϣ
* subType �����ͣ�11/���Ժ��� 1/��������״̬ 2/����Ⱥ 3/����������
}
Function code_eventPrivateMsg(
			subType,sendTime		:longint;
			fromQQ					:int64;
			const msg				:ansistring;
			font					:longint):longint;
Begin
	exit(EVENT_IGNORE);
		//���Ҫ�ظ���Ϣ������ÿ�Q�������ͣ��������� exit(EVENT_BLOCK) - �ضϱ�����Ϣ�����ټ�������  ע�⣺Ӧ�����ȼ�����Ϊ"���"(10000)ʱ������ʹ�ñ�����ֵ
		//������ظ���Ϣ������֮���Ӧ��/�������������� exit(return EVENT_IGNORE) - ���Ա�����Ϣ
End;

{
* Type=2 Ⱥ��Ϣ
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
		//�������û���Ϣ�浽 AnonymousMes
	end;

	if msg='ǩ��' then CQ_sendGroupMsg(AuthCode,fromgroup,
		sTop(CQCode_Group_At(fromQQ)+' : ǩ����û�гɹ�[CQ:image,file=funnyface.png]')
		);
		
	exit(EVENT_IGNORE);
	//���ڷ���ֵ˵��, ����code_eventPrivateMsg������
End;

{
* Type=4 ��������Ϣ
}
Function code_eventDiscussMsg(
			subType,sendTime		:longint;
			fromDiscuss,fromQQ		:int64;
			msg						:ansistring;
			font					:longint):longint;
Begin
	exit(EVENT_IGNORE);
	//���ڷ���ֵ˵��, ����code_eventPrivateMsg������
End;

{
* Type=101 Ⱥ�¼�-����Ա�䶯
* subType �����ͣ�1/��ȡ������Ա 2/�����ù���Ա
}
Function code_eventSystem_GroupAdmin(
			subType,sendTime		:longint;
			fromGroup,
			beingOperateQQ			:int64):longint;
Begin
	exit(EVENT_IGNORE); 
	//���ڷ���ֵ˵��, ����code_eventPrivateMsg������
End;

{
* Type=102 Ⱥ�¼�-Ⱥ��Ա����
* subType �����ͣ�1/ȺԱ�뿪 2/ȺԱ���� 3/�Լ�(����¼��)����
* fromQQ ������QQ(��subTypeΪ2��3ʱ����)
* beingOperateQQ ������QQ
}
Function code_eventSystem_GroupMemberDecrease(
			subType,sendTime		:longint;
			fromGroup,fromQQ,
			beingOperateQQ			:int64):longint;
stdcall;
Begin
	exit(EVENT_IGNORE); 
	//���ڷ���ֵ˵��, ����code_eventPrivateMsg������
End;

{
* Type=103 Ⱥ�¼�-Ⱥ��Ա����
* subType �����ͣ�1/����Ա��ͬ�� 2/����Ա����
* fromQQ ������QQ(������ԱQQ)
* beingOperateQQ ������QQ(����Ⱥ��QQ)
}
Function code_eventSystem_GroupMemberIncrease(
			subType,sendTime		:longint;
			fromGroup,fromQQ,
			beingOperateQQ			:int64):longint;
stdcall;
Begin
	CQ_sendGroupMsg(AuthCode,fromgroup,StoP('��ӭ���� [CQ:at,qq='+NumToChar(beingOperateQQ)+'] ���뱾Ⱥ'));
	exit(EVENT_IGNORE); 
	//���ڷ���ֵ˵��, ����code_eventPrivateMsg������
End;


{
* Type=201 �����¼�-���������
}
Function code_eventFriend_Add(
			subType,sendTime		:longint;
			fromQQ					:int64):longint;
stdcall;
Begin
	exit(EVENT_IGNORE); 
	//���ڷ���ֵ˵��, ����code_eventPrivateMsg������
End;


{
* Type=301 ����-�������
* msg ����
* responseFlag
		������ʶ(����������)
		����ҾͲ�����ת����string�ˣ�����������Ҳûʲô��
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
	//���ڷ���ֵ˵��, ����code_eventPrivateMsg������
End;

{
* Type=302 ����-Ⱥ���
* subType �����ͣ�1/����������Ⱥ 2/�Լ�(����¼��)������Ⱥ
* msg ����
* responseFlag
		������ʶ(����������)
		�����Ҳ������ת����
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
	//���ڷ���ֵ˵��, ����code_eventPrivateMsg������
End;