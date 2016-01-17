Type
	CQ_Type_GroupMember=
		record
			GroupID,QQID	: longint;
			username,nick	: Pchar;
			sex,						// 0/�� 1/Ů
			age				: longint;
			aera			: text;
			jointime,
			lastsent		: longint;
			level_name		: Pchar;
			permission		: longint;	// 0/��Ա 2/����Ա 3/Ⱥ��
			title			: Pchar;
			titleExpiretime : longint;
			unfriendly,
			nickcanchange	: boolean;
		end;

Const
	CR = #$0d;
	LF = #$0a;
	CRLF = CR + LF;
	// ���з�
	
	CQAPIVER=9;
	CQAPIVERTEXT='9';
	// CoolQ API�汾
	
	CQAPPID='club.paracraft.demo';
		//���޸�APPIDΪ���APPID
	CQAPPINFO=CQAPIVERTEXT+','+CQAPPID;
	
	EVENT_IGNORE=0;        //�¼�_����
	EVENT_BLOCK=1;         //�¼�_����

	REQUEST_ALLOW=1;       //����_ͨ��
	REQUEST_DENY=0;        //����_�ܾ�

	REQUEST_GROUPADD=1;    //����_Ⱥ���
	REQUEST_GROUPINVITE=2; //����_Ⱥ����

	CQLOG_DEBUG=0;           //���� ��ɫ
	CQLOG_INFO=10;           //��Ϣ ��ɫ
	CQLOG_INFOSUCCESS=11;    //��Ϣ(�ɹ�) ��ɫ
	CQLOG_INFORECV=12;       //��Ϣ(����) ��ɫ
	CQLOG_INFOSEND=13;       //��Ϣ(����) ��ɫ
	CQLOG_WARNING=20;        //���� ��ɫ
	CQLOG_ERROR=30;          //���� ��ɫ
	CQLOG_FATAL=40;          //�������� ���

	//��������ɫ
	CQSuspensionWindow_Green=1;
	CQSuspensionWindow_Orange=2;
	CQSuspensionWindow_Red=3;
	CQSuspensionWindow_DarkRed=4;
	CQSuspensionWindow_Black=5;
	CQSuspensionWindow_grey=6;