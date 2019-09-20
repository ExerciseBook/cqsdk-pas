unit Plugin_events;

interface

uses CoolQSDK,iconv;
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
Function code_eventFriend_Add(subType,sendTime:longint;fromQQ:int64):longint;
Function code_eventRequest_AddFriend(subType,sendTime:longint;fromQQ:int64;const msg:widestring;responseFlag:PAnsichar):longint;
Function code_eventRequest_AddGroup(subType,sendTime:longint;fromGroup,fromQQ:int64;msg:widestring;responseFlag:PAnsichar):longint;
			
implementation
{
* Type=1001 ��Q����
* ���۱�Ӧ���Ƿ����ã������������ڿ�Q������ִ��һ�Σ���������ִ��Ӧ�ó�ʼ�����롣
* ��Ǳ�Ҫ����������������ش��ڡ���������Ӳ˵������û��ֶ��򿪴��ڣ�
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
* Type=1002 ��Q�˳�
* ���۱�Ӧ���Ƿ����ã������������ڿ�Q�˳�ǰִ��һ�Σ���������ִ�в���رմ��롣
* ������������Ϻ󣬿�Q���ܿ�رգ��벻Ҫ��ͨ���̵߳ȷ�ʽִ���������롣
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
* Type=1003 Ӧ���ѱ�����
* ��Ӧ�ñ����ú󣬽��յ����¼���
* �����Q����ʱӦ���ѱ����ã�����_eventStartup(Type=1001,��Q����)�����ú󣬱�����Ҳ��������һ�Ρ�
* ��Ǳ�Ҫ����������������ش��ڡ���������Ӳ˵������û��ֶ��򿪴��ڣ�
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
* Type=1004 Ӧ�ý���ͣ��
* ��Ӧ�ñ�ͣ��ǰ�����յ����¼���
* �����Q����ʱӦ���ѱ�ͣ�ã��򱾺���*����*�����á�
* ���۱�Ӧ���Ƿ����ã���Q�ر�ǰ��������*����*�����á�
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
* Type=21 ˽����Ϣ
* subType �����ͣ�11/���Ժ��� 1/��������״̬ 2/����Ⱥ 3/����������
}
Function code_eventPrivateMsg(
			subType,MsgID			:longint;
			fromQQ					:int64;
			const msg				:widestring;
			font					:longint):longint;
Begin
{$IFDEF FPC}
	exit(EVENT_IGNORE);
		//���Ҫ�ظ���Ϣ������ÿ�Q�������ͣ��������� exit(EVENT_BLOCK) - �ضϱ�����Ϣ�����ټ�������  ע�⣺Ӧ�����ȼ�����Ϊ"���"(10000)ʱ������ʹ�ñ�����ֵ
		//������ظ���Ϣ������֮���Ӧ��/�������������� exit(return EVENT_IGNORE) - ���Ա�����Ϣ
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
End;

{
* Type=2 Ⱥ��Ϣ
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
		//�������û���Ϣ�浽 AnonymousMes
	end;

	if msg='ǩ��' then CQ_i_sendGroupMsg(fromgroup,CQCode_Group_At(fromQQ)+' : ǩ����û�гɹ�[CQ:image,file=funnyface.png]');
		
{$IFDEF FPC}
	exit(EVENT_IGNORE);
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
	//���ڷ���ֵ˵��, ����code_eventPrivateMsg������
End;

{
* Type=4 ��������Ϣ
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
	//���ڷ���ֵ˵��, ����code_eventPrivateMsg������
End;

{
*Type=11 Ⱥ�ļ��ϴ��¼�
}
Function code_eventGroupUpload(
			subType,sendTime	:longint;
			fromGroup,fromQQ	:int64;
			Pfileinfo			:ansistring):longint;
Var
	FileInfo	:CQ_Type_GroupFile;
	Back		:widestring;
Begin
	//�յ��ļ��ϴ���Ϣ �����Խ���
	if CQ_Tools_TextToFile(Pfileinfo,FileInfo) then begin
		//Ⱥ�ļ���Ϣ�����ɹ�
		
		Back:='[CQ:at,qq=%FROMQQ%] �ϴ���һ���ļ�����Ϣ���£�'+CRLF+
				'----------------'+CRLF+
				'�ļ���    : %FILENAME%'+CRLF+
				'�ļ���С  : %SIZE%'+CRLF+
				'----------------'+CRLF+
				'�ļ����  : %FILEID%'+CRLF+
				'busID   : %BUSID%';
		Message_Replace(Back,'%FROMQQ%',numtochar(fromQQ));
		Message_Replace(Back,'%FILEID%',FileInfo.fileID);
		Message_Replace(Back,'%FILENAME%',FileInfo.Filename);
		if FileInfo.Size<10240 then begin
			Message_Replace(Back,'%SIZE%',numtochar(FileInfo.Size)+'Byte(s)');
		end
		else
		begin
			if FileInfo.Size<10485760 then begin
				Message_Replace(Back,'%SIZE%',RealToDisplay(FileInfo.Size/1024,2)+'Kb');
			end
			else
			begin
				if FileInfo.Size<536870912 then begin
					Message_Replace(Back,'%SIZE%',RealToDisplay(FileInfo.Size/(1024*1024),2)+'Mb');
				end
				else
				begin
					Message_Replace(Back,'%SIZE%',RealToDisplay(FileInfo.Size/(1024*1024*1024),2)+'Gb');
				end;
			end;
		end;
		Message_Replace(Back,'%SIZE.B%',numtochar(FileInfo.Size)+'Byte(s)');
		Message_Replace(Back,'%SIZE.KB%',RealToDisplay(FileInfo.Size/1024,2)+'Kb');
		Message_Replace(Back,'%SIZE.MB%',RealToDisplay(FileInfo.Size/(1024*1024),2)+'Mb');
		Message_Replace(Back,'%SIZE.GB%',RealToDisplay(FileInfo.Size/(1024*1024*1024),2)+'Gb');
		Message_Replace(Back,'%BUSID%',NumToChar(FileInfo.busid));
		
		CQ_i_sendGroupMsg(fromGroup,Back);		
	end
	else
	begin
		CQ_i_addLog(CQLOG_DEBUG,'code_eventGroupUpload','����ʧ�� '+Pfileinfo);
		//Ⱥ�ļ���Ϣ����ʧ��
	end;
	
{$IFDEF FPC}
	exit(EVENT_IGNORE);
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
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
{$IFDEF FPC}
	exit(EVENT_IGNORE); 
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
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
Begin
{$IFDEF FPC}
	exit(EVENT_IGNORE); 
{$ELSE}
	result:=EVENT_IGNORE
{$ENDIF}
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
Begin
	CQ_i_sendGroupMsg(fromgroup,'��ӭ���� [CQ:at,qq='+NumToChar(beingOperateQQ)+'] ���뱾Ⱥ');
{$IFDEF FPC}
	exit(EVENT_IGNORE); 
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
	//���ڷ���ֵ˵��, ����code_eventPrivateMsg������
End;


{
* Type=201 �����¼�-���������
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
			const msg					:widestring;
			responseFlag				:PAnsichar):longint;
Begin
	CQ_i_setFriendAddRequest(responseFlag, REQUEST_DENY,''); //�ܾ������������
	
{$IFDEF FPC}
	exit(EVENT_IGNORE); 
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
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
			msg							:widestring;
			responseFlag				:PAnsichar):longint;
Begin	
{$IFDEF FPC}
	exit(EVENT_IGNORE); 
{$ELSE}
	result:=EVENT_IGNORE;
{$ENDIF}
	//���ڷ���ֵ˵��, ����code_eventPrivateMsg������
End;

end.