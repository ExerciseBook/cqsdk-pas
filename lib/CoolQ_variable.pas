Type
	CQ_Type_QQ=
		record
			QQID			: int64;
			sex,age			: longint;
			nick			: string;
		end;
	CQ_Type_GroupMember=
		record
			GroupID,QQID	: longint;
			username,nick	: string;
			sex,						// 0/�� 1/Ů
			age				: longint;
			aera			: text;
			jointime,
			lastsent		: longint;
			level_name		: string;
			permission		: longint;	// 0/��Ա 2/����Ա 3/Ⱥ��
			title			: string;
			titleExpiretime : longint;
			unfriendly,
			nickcanchange	: boolean;
		end;
	CQ_Type_GroupAnonymous=
		record
			AID				: int64;
			name			: string;
			Token			: string;
		end;
	CQ_Type_GroupFile=
		record
			filename		: string;
			fileid			: string;
			busid			: longint;
			size			: int64;
		end;
	CQ_Type_MegType=
		record
			key,msg			: ansistring;
		end;
	CQ_Type_SuspensionWindow=
		record
			data,entity		: longint;
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
	REQUEST_DENY=2;        //����_�ܾ�

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