Type
	CQ_Type_QQ=
		record
			QQID			: int64;
			sex,age			: longint;
			nick			: string;
		end;
	CQ_Type_GroupMember=
		record
			GroupID,					// 群号
			QQID			: int64;	// QQ号
			username,					// QQ昵称
			nick			: string;	// 群名片
			sex,						// 性别 0/男 1/女
			age				: longint;	// 年龄
			aera			: string;	// 地区
			jointime,					// 入群时间
			lastsent		: longint;	// 上次发言时间
			level_name		: string;	// 头衔名字
			permission		: longint;	// 权限等级 1/成员 2/管理员 3/群主
			unfriendly		: boolean;	// 不良成员记录
			title			: string;	// 自定义头衔
			titleExpiretime : longint;	// 头衔过期时间
			nickcanchange	: boolean;	// 管理员是否能协助改名
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
	REQUEST_DENY=2;        //请求_拒绝

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