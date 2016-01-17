Type
	CQ_Type_GroupMember=
		record
			GroupID,QQID	: longint;
			username,nick	: Pchar;
			sex,						// 0/男 1/女
			age				: longint;
			aera			: text;
			jointime,
			lastsent		: longint;
			level_name		: Pchar;
			permission		: longint;	// 0/成员 2/管理员 3/群主
			title			: Pchar;
			titleExpiretime : longint;
			unfriendly,
			nickcanchange	: boolean;
		end;

Const
	CR = #$0d;
	LF = #$0a;
	CRLF = CR + LF;
	// 换行符
	
	CQAPIVER=9;
	CQAPIVERTEXT='9';
	// CoolQ API版本
	
	CQAPPID='club.paracraft.demo';
		//请修改APPID为你的APPID
	CQAPPINFO=CQAPIVERTEXT+','+CQAPPID;
	
	EVENT_IGNORE=0;        //事件_忽略
	EVENT_BLOCK=1;         //事件_拦截

	REQUEST_ALLOW=1;       //请求_通过
	REQUEST_DENY=0;        //请求_拒绝

	REQUEST_GROUPADD=1;    //请求_群添加
	REQUEST_GROUPINVITE=2; //请求_群邀请

	CQLOG_DEBUG=0;           //调试 灰色
	CQLOG_INFO=10;           //信息 黑色
	CQLOG_INFOSUCCESS=11;    //信息(成功) 紫色
	CQLOG_INFORECV=12;       //信息(接收) 蓝色
	CQLOG_INFOSEND=13;       //信息(发送) 绿色
	CQLOG_WARNING=20;        //警告 橙色
	CQLOG_ERROR=30;          //错误 红色
	CQLOG_FATAL=40;          //致命错误 深红

	//悬浮窗颜色
	CQSuspensionWindow_Green=1;
	CQSuspensionWindow_Orange=2;
	CQSuspensionWindow_Red=3;
	CQSuspensionWindow_DarkRed=4;
	CQSuspensionWindow_Black=5;
	CQSuspensionWindow_grey=6;