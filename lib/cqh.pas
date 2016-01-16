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
	
	EVENT_IGNORE=0;        //事件_拦截
	EVENT_BLOCK=1;         //事件_忽略

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

	
{CoolQ API Char* 调用}
function CQ_sendPrivateMsg(AuthCode:longint;QQID:int64;const msg:Pchar):longint;
	stdcall; external 'CQP.dll' name 'CQ_sendPrivateMsg';
function CQ_sendGroupMsg(AuthCode:longint;groupid:int64;const msg:Pchar):longint;
	stdcall; external 'CQP.dll' name 'CQ_sendGroupMsg';
function CQ_sendDiscussMsg(AuthCode:longint;discussid:int64;const msg:Pchar):longint;
	stdcall; external 'CQP.dll' name 'CQ_sendDiscussMsg';
function CQ_sendLike(AuthCode:longint;QQID:int64):longint;
	stdcall; external 'CQP.dll' name 'CQ_sendLike';
function CQ_setGroupKick(AuthCode:longint;groupid,QQID:int64;rejectaddrequest:boolean):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupKick';
function CQ_setGroupBan(Authcode:longint;groupid,qqid,duration:int64):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupBan';
function CQ_setGroupWholeBan(Authcode:longint;groupid:int64;enableban:boolean):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupWholeBan';
{还有一堆在后面}
	
{CoolQ API String 调用}
	{我还没开始写}