{
    $Id: gplunit.pt,v 1.2 2002/09/07 15:40:47 peter Exp 2017/06/16 21:06:26 peter Exp $
    This file is part of CoolQSDK
    Copyright (c) 2017 by Eric_Lian



    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}
{$IFDEF FPC}
	{$MODE DELPHI}
{$ENDIF}

{$I-}
{$h+}

unit CoolQSDK;

interface
Type
	CQ_Type_QQ=
		record
			QQID			: int64;	//QQ��
			nick			: string;	//�ǳ�
			sex,						//�Ա�
			age				: longint;	//����
		end;
	CQ_Type_GroupMember=
		record
			GroupID,					// Ⱥ��
			QQID			: int64;	// QQ��
			nick,						// QQ�ǳ�
			card			: string;	// Ⱥ��Ƭ
			sex,						// �Ա� 0/�� 1/Ů
			age				: longint;	// ����
			aera			: string;	// ����
			jointime,					// ��Ⱥʱ��
			lastsent		: longint;	// �ϴη���ʱ��
			level_name		: string;	// ͷ������
			permission		: longint;	// Ȩ�޵ȼ� 1/��Ա 2/����Ա 3/Ⱥ��
			unfriendly		: boolean;	// ������Ա��¼
			title			: string;	// �Զ���ͷ��
			titleExpiretime : longint;	// ͷ�ι���ʱ��
			nickcanchange	: boolean;	// ����Ա�Ƿ���Э������
		end;
	CQ_Type_GroupMember_List=
		record
			l : longint; 						//���鳤��
			s :	Array Of CQ_Type_GroupMember;	//Ⱥ��Ա�б�
			//�����������������̬���飬�������Ǵӵ�0λ����l-1λ��һ����lλ��
		end;
	CQ_Type_GroupAnonymous=
		record
			AID				: int64;
			name			: string;
			Token			: string;
		end;
	CQ_Type_GroupFile=
		record
			fileid			: string;	//�ļ�ID
			filename		: string;	//�ļ���
			size			: int64;	//�ļ���С
			busid			: longint;	//busid
		end;
	CQ_Type_GroupInfo=
		record
			GroupID			: int64;
			name			: ansistring;
		end;
	CQ_Type_GroupList=
		record
			l : longint;					//���鳤��
			s : Array Of CQ_Type_GroupInfo;	//Ⱥ�б�
		end;
	{CQ_Type_MsgType=
		record
			key,msg			: ansistring;
		end;
	CQ_Type_SuspensionWindow=
		record
			data,entity		: longint;
		end;}
	
Const
	CR = #$0d;
	LF = #$0a;
	CRLF = CR + LF;
	// ���з�
	
	CQAPIVER=9;
	CQAPIVERTEXT='9';
	// CoolQ API�汾
	
	EVENT_IGNORE=0;        //�¼�_����
	EVENT_BLOCK=1;         //�¼�_����

	REQUEST_ALLOW=1;       //����_ͨ��
	REQUEST_ACCEPT=1;       //����_ͨ��
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
	
	// ����ĺ�����ȷ�к��������lib�ļ����µ��ļ���
	// lib\Tools.pas
	Function PtoS(a:pchar):ansistring;
	Function StoP(a:ansistring):Pchar;
	Function NumToChar(a:int64):string;
	Function CharToNum(a:string):int64;
	Function RealToChar(a:real):string;
	Function CharToReal(a:string):real;
	Function RealToDisplay(a:real;b:longint):string;
	Function String_Choose(expression:boolean;a,b:ansistring):ansistring;
	Procedure Message_Replace(var a:ansistring;b,c:ansistring);
	Function UrlEncode(s:ansistring):ansistring;
	Function UrlDecode(s:ansistring):ansistring;
	// lib\CoolQ_Tools.pas
	Function Base64_Encryption(s:ansistring):ansistring;
	Function Base64_Decryption(s:ansistring):ansistring;
	// lib\CoolQ_CQapplication.pas
		// ��Q��ת��
	Function CQ_CharEncode(str:ansistring;Comma:boolean):ansistring;
	Function CQ_CharDecode(str:ansistring):ansistring;
		// ��Q���װ
	function CQCode_Group_At(QQID:int64):ansistring;
	function CQCode_emoji(ID:int64):ansistring;
	function CQCode_face(ID:int64):ansistring;
	function CQCode_Shake:ansistring;
	function CQCode_anonymous(Force:boolean):ansistring;	
	function CQCode_image(url:ansistring):ansistring;
	function CQCode_Music(source:string;musicid:int64;isnew:boolean):ansistring;
	function CQCode_Music_Custom(url,audio,title,content,image:ansistring):ansistring;
	function CQCode_Location(latitude,longitude:real;Zoom:longint;Name,Address:ansistring):ansistring;
	function CQCode_bface(ID:int64):ansistring;
	function CQCode_record(url:ansistring;magic:boolean):ansistring;
	function CQCode_rps(ID:int64):ansistring;
	function CQCode_dice(ID:int64):ansistring;
	function CQCode_share(url,title,Content,image:ansistring):ansistring;
	function CQCode_contact(t:ansistring;id:int64):ansistring;
		// ��QAPI
	function CQ_i_sendPrivateMsg(QQID:int64;msg:ansistring):longint;		
	function CQ_i_sendGroupMsg(groupid:int64;const msg:ansistring):longint;	
	function CQ_i_sendDiscussMsg(DiscussID:int64;msg:ansistring):longint;	
	function CQ_i_sendLike(QQID:int64):longint;overload;								
	function CQ_i_sendLike(QQID:int64;times:longint):longint;overload;						//���ϵ�һ������
	function CQ_i_sendLikeV2(QQID:int64;times:longint):longint;				
	function CQ_i_getRecord(filename,format:ansistring):ansistring;			
	function CQ_Tools_TextToAnonymous(source:ansistring;Var Anonymous:CQ_Type_GroupAnonymous):boolean;
	Function CQ_Tools_TextToFile(source:string;Var info:CQ_Type_GroupFile):boolean;
	Function CQ_i_GetCookies():ansistring;
	Function CQ_i_getCsrfToken():longint;
	Function CQ_i_GetLoginQQ():int64;
	Function CQ_i_getLoginNick():string;
	Function CQ_i_GetStrangerInfo(QQ:int64;Var info:CQ_Type_QQ;nocache:boolean):longint;
	function CQ_i_getGroupMemberInfo(groupid,qqid:int64;Var info:CQ_Type_GroupMember;nocache:boolean):longint;
	function CQ_i_getAppDirectory:ansistring;
	function CQ_i_addLog(priority:longint;const category,content:ansistring):longint;
	function CQ_i_setFriendAddRequest(const responseflag:pchar;responseoperation:longint;const remark:string):longint;
	function CQ_i_setGroupAnonymousMute(group:int64;fromAnonymous:string;duration:int64):longint;
	function CQ_i_setGroupWholeMute(groupid:int64;enableban:boolean):longint;
	function CQ_i_setGroupCard(group,qq:int64;nick:string):longint;
	Function CQ_i_setGroupSpecialTitle(Group,ID:int64;Title:string;duration:int64):longint;
	Function CQ_i_setGroupAdmin(group,qq:int64;operation:boolean):longint;
	Function CQ_i_setGroupAnonymous(group:int64;operation:boolean):longint;
	Function CQ_i_setGroupAddRequest(responseflag:string;subtype:longint;responseoperation:longint;reason:string):longint;
	Function CQ_i_setGroupLeave(group:int64;isdisband:boolean):longint;
	function CQ_i_setGroupMute(groupid,QQID,duration:int64):longint;
	function CQ_i_setGroupKick(groupid,QQID:int64;rejectaddrequest:boolean):longint;
	function CQ_i_setDiscussLeave(DiscussID:int64):longint;
	function CQ_i_setFatal(msg:ansistring):longint;
	function CQ_i_getGroupMemberList(GroupID:int64;Var GroupMemberList:CQ_Type_GroupMember_List):longint;
	function CQ_i_getGroupList(Var GroupList:CQ_Type_GroupList):longint;
	function CQ_i_deleteMsg(msgID:int64):longint;
		// ����ת��
	Function CoolQ_Tools_UTF8ToAnsi(Sstr:ansistring):ansistring;
	Function CoolQ_Tools_AnsiToUTF8(Sstr:ansistring):ansistring;
Var
	AuthCode:longint;
	//AuthCode CoolQ����ʶ�����Ƿ��ǺϷ�\���õ������
	CQAPPID		:string='com.binkic.cqdemo';
	CQAPPINFO	:string;
	
	GlobalUTF8Mode	:boolean;
	//����Ӧ�����������޸�APPIDΪ���APPID

implementation

uses math,sysutils,iconv; 

const
	Base64Chars='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
	Base64Table:array[0..63] of ansichar='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
var
	Base64DecoderTable:array[ansichar] of byte;

{
	Char* ת���� �ַ���
}
Function PtoS(a:pchar):ansistring;
Begin
	result:=strPas(a)
End;

{
	�ַ��� ת���� Char*
}
Function StoP(a:ansistring):Pchar;
Begin
	result:=pchar(@a[1]);
End;

{***********************************************************}

{
	���� ת���� �ַ���
}
Function NumToChar(a:int64):string;
Begin
	str(a,result);
End;


{
	�ַ��� ת���� ����
}
Function CharToNum(a:string):int64;
Begin
	//val(a,result);
	result:=StrToInt64Def(a,0);
End;


{
	˫������ ת���� �ַ���
}
Function RealToChar(a:real):string;
Begin
	str(a,result)
End;

{
	�ַ��� ת���� ˫������
}
Function CharToReal(a:string):real;
Begin
	//val(a,result);
	result:=StrToFloatDef(a,0);
End;

{
	˫������ ת���� �ܿ����ַ���
}

Function RealToDisplay(a:real;b:longint):string;
Var
	display:string;
	i:longint;
Begin
	if a>=0 
		then display:=''
		else
		begin
			display:='-';
			a:=-a;
		end;
	
	display:=display+NumToChar(trunc(a));
	a:=(a-trunc(a))*10;
	
	if b<0 then b:=16;
	b:=min(b,16);
	if b<>0 then display:=display+'.';
	
	for i:=1 to b do begin
		display:=display+NumToChar(trunc(a));
		a:=(a-trunc(a))*10;
	end;
	
	result:=display;
	exit;
End;


{***********************************************************}

Function String_Choose(expression:boolean;a,b:ansistring):ansistring;
Begin
	if expression then result:=a else result:=b;
End;


Procedure Message_Replace(var a:ansistring;
							  b,c:ansistring);
Var
	i:longint;
	lenb:longint;
Begin
	i:=0;
	lenb:=length(b);
	
	repeat
		inc(i);
		if copy(a,i,lenb) = b then begin
			a:=copy(a,1,i-1)+c+copy(a,i+lenb,length(a));
			i:=i+length(c)-1;
		end;
	until i>=length(a);
End;

Function PowerInt(bas: Int64;expo: Int64) : Int64;
Var
	i:longint;
Begin
	if expo<0 then begin
		result:=0;
		exit;
	end;
	result:=1;
	for i:=1 to expo do
		result:=result*bas;
End;

{***********************************************************}
Function SDECtoHEX(a:integer):char;
Begin
	case a of
		0 : result:=('0');
		1 : result:=('1');
		2 : result:=('2');
		3 : result:=('3');
		4 : result:=('4');
		5 : result:=('5');
		6 : result:=('6');
		7 : result:=('7');
		8 : result:=('8');
		9 : result:=('9');
		10 : result:=('A');
		11 : result:=('B');
		12 : result:=('C');
		13 : result:=('D');
		14 : result:=('E');
		15 : result:=('F');
		else result:='-';
	end;
End;

Function SHEXtoDec(a:char):integer;
Begin
	case upcase(a) of
		'0' : result:=(0);
		'1' : result:=(1);
		'2' : result:=(2);
		'3' : result:=(3);
		'4' : result:=(4);
		'5' : result:=(5);
		'6' : result:=(6);
		'7' : result:=(7);
		'8' : result:=(8);
		'9' : result:=(9);
		'A' : result:=(10);
		'B' : result:=(11);
		'C' : result:=(12);
		'D' : result:=(13);
		'E' : result:=(14);
		'F' : result:=(15);
		else result:=(-1);
	end;
End;

{
	ʮ����ת������
}
Function Hex_Conversion_10to2(s:longint):string;
Begin
        result:='';
        while s>0 do begin
			result:=numtochar(s mod 2)+result;
			s:=s div 2;
        end;
        while length(result)<8 do result:='0'+result;
End;
{
	������תʮ����
}
Function Hex_Conversion_2to10(s:string):longint;
Var
        i:longint;
Begin
        result:=0;
        for i:=length(s) downto 1 do begin
                if s[i]='1' then
                result:=result+PowerInt( 2 , (length(s)-i) );
        end;
End;

Function UrlEncode(s:ansistring):ansistring;
//����
Var
	a:ansistring;
	i:longint;
Begin
	a:='';

	for i:=1 to length(s) do
		if (integer(s[i])>32) and (integer(s[i])<128)
			and (s[i]<>'"') and (s[i]<>'''')
			and (s[i]<>'/') and (s[i]<>'\')
			and (s[i]<>':') and (s[i]<>'%')
			and (s[i]<>'[') and (s[i]<>']')
			and (s[i]<>',') then a:=a+s[i]
		else a:=a+'%'+SDECtoHEX(integer(s[i])div 16)+SDECtoHEX(integer(s[i])mod 16);

	result:=(a);
End;

Function GB2312ASCtoChar(a,b:char):char;
Begin
	result:=(char(SHEXtoDec(a)*16+SHEXtoDec(b)));
End;

Function UrlDecode(s:ansistring):ansistring;
//����
Var
	i:longint;
	outs:ansistring;
Begin
	outs:='';
	i:=1;
	while i<=length(s) do begin
		if s[i]='%' then begin
			//Ҳ����Ҫת��
			if (SHEXtoDec(s[i+1])<>-1) and (SHEXtoDec(s[i+2])<>-1) then begin
				//��Ҫת��
				outs:=outs+GB2312ASCtoChar(s[i+1],s[i+2]);
				i:=i+3;
			end
			else
			begin
				//��Ȼ����Ҫת��
				outs:=outs+s[i];
				i:=i+1;
			end;
		end
		else
		begin
			//����Ҫת��
			outs:=outs+s[i];
			i:=i+1;
		end;
	end;
        result:=(outs);
End;

function CQ_sendPrivateMsg(AuthCode:longint;QQID:int64;const msg:Pchar):longint;
	stdcall; external 'CQP.dll' name 'CQ_sendPrivateMsg';
function CQ_sendGroupMsg(AuthCode:longint;groupid:int64;const msg:Pchar):longint;
	stdcall; external 'CQP.dll' name 'CQ_sendGroupMsg';
function CQ_sendDiscussMsg(AuthCode:longint;discussid:int64;const msg:Pchar):longint;
	stdcall; external 'CQP.dll' name 'CQ_sendDiscussMsg';
function CQ_sendLike(AuthCode:longint;QQID:int64):longint;
	stdcall; external 'CQP.dll' name 'CQ_sendLike';
function CQ_sendLikeV2(AuthCode:longint;QQID:int64;times:longint):longint;
	stdcall; external 'CQP.dll' name 'CQ_sendLikeV2';
function CQ_setGroupAdmin(AuthCode:longint;groupid,QQID:int64;state:boolean):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupAdmin';	
function CQ_setGroupKick(AuthCode:longint;groupid,QQID:int64;rejectaddrequest:boolean):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupKick';
function CQ_setGroupBan(AuthCode:longint;groupid,QQID,duration:int64):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupBan';
function CQ_setGroupWholeBan(AuthCode:longint;groupid:int64;enableban:boolean):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupWholeBan';
function CQ_setGroupAnonymousBan(AuthCode:longint;groupid:int64;const anomymous:Pchar;duration:int64):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupAnonymousBan';
function CQ_setGroupAnonymous(AuthCode:longint;groupid:int64;enableanomymous:boolean):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupAnonymous';
function CQ_setGroupCard(AuthCode:longint;groupid,QQID:int64;newcard:Pchar):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupCard';
function CQ_setGroupLeave(AuthCode:longint;groupid:int64;isdismiss:boolean):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupLeave';
function CQ_setGroupSpecialTitle(AuthCode:longint;groupid,QQID:int64;newspecialtitle:Pchar;duration:int64):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupSpecialTitle';
function CQ_setDiscussLeave(AuthCode:longint;discussid:int64):longint;
	stdcall; external 'CQP.dll' name 'CQ_setDiscussLeave';
function CQ_setFriendAddRequest(AuthCode:longint;const responseflag:pchar;responseoperation:longint;const remark:Pchar):longint;
	stdcall; external 'CQP.dll' name 'CQ_setFriendAddRequest';
function CQ_setGroupAddRequestV2(AuthCode:longint;const responseflag:Pchar;requesttype,responseoperation:longint;const reason:Pchar):longint;
	stdcall; external 'CQP.dll' name 'CQ_setGroupAddRequestV2';
function CQ_getGroupMemberInfoV2(AuthCode:longint;groupid,QQID:int64;nocache:boolean):Pchar;
	stdcall; external 'CQP.dll' name 'CQ_getGroupMemberInfoV2';	
function CQ_getStrangerInfo(AuthCode:longint;QQID:int64;nocache:boolean):Pchar;
	stdcall; external 'CQP.dll' name 'CQ_getStrangerInfo';	
function CQ_addLog(AuthCode,priority:longint;const category,content:Pchar):longint;
	stdcall; external 'CQP.dll' name 'CQ_addLog';
function CQ_getRecord(AuthCode:longint;filename,format:Pchar):Pchar;
	stdcall; external 'CQP.dll' name 'CQ_getRecord';
function CQ_getCookies(AuthCode:longint):Pchar;
	stdcall; external 'CQP.dll' name 'CQ_getCookies';
function CQ_getCsrfToken(AuthCode:longint):longint;
	stdcall; external 'CQP.dll' name 'CQ_getCsrfToken';
function CQ_getLoginQQ(AuthCode:longint):int64;
	stdcall; external 'CQP.dll' name 'CQ_getLoginQQ';
function CQ_getLoginNick(AuthCode:longint):Pchar;
	stdcall; external 'CQP.dll' name 'CQ_getLoginNick';
function CQ_getAppDirectory(AuthCode:longint):Pchar;
	stdcall; external 'CQP.dll' name 'CQ_getAppDirectory';
function CQ_setFatal(AuthCode:longint;const errorinfo:Pchar):longint;
	stdcall; external 'CQP.dll' name 'CQ_setFatal';
function CQ_getGroupMemberList(AuthCode:longint;GroupID:int64):Pchar;
	stdcall; external 'CQP.dll' name 'CQ_getGroupMemberList';
function CQ_getGroupList(AuthCode:longint):Pchar;
	stdcall; external 'CQP.dll' name 'CQ_getGroupList';
function CQ_deleteMsg(AuthCode:longint;MsgId:int64):longint;
	stdcall; external 'CQP.dll' name 'CQ_deleteMsg';

	
procedure InitBase64;
var i:longint;
begin
 for i:=0 to 63 do begin
  Base64DecoderTable[Base64Table[i]]:=i;
 end;
end;

//function DecodeBase64(s:ansistring):ansistring;
Function Base64_Decryption(s:ansistring):ansistring;
var i,j,l:longint;
    c:longword;
begin
 setlength(result,((length(s)*3) shr 2)+3);
{while (length(s) and 3)<>0 do begin
  s:=s+'=';
 end;}
 l:=0;
 i:=1;
 while i<=length(s) do begin
  c:=0;
  for j:=1 to 4 do begin
   if i<=length(s) then begin
    case s[i] of
     'A'..'Z','a'..'z','0'..'9','+','/':begin
      c:=c or (Base64DecoderTable[s[i]] shl (24-((j shl 2)+(j shl 1))));
     end;
     '=':begin
      c:=(c and $00ffffff) or (((c shr 24)+1) shl 24);
     end;
     else begin
      c:=c or $f0000000;
      break;
     end;
    end;
   end else begin
    c:=(c and $00ffffff) or (((c shr 24)+1) shl 24);
   end;
   inc(i);
  end;
  if (c shr 24)<3 then begin
   inc(l);
   result[l]:=chr((c shr 16) and $ff);
   if (c shr 24)<2 then begin
    inc(l);
    result[l]:=chr((c shr 8) and $ff);
    if (c shr 24)<1 then begin
     inc(l);
     result[l]:=chr(c and $ff);
    end;
   end;
  end else begin
   break;
  end;
 end;
 setlength(result,l);
end;

//function EncodeBase64(s:ansistring):ansistring;
Function Base64_Encryption(s:ansistring):ansistring;
var i,l:longint;
    c:longword;
begin
 if length(s)=0 then begin
  result:='';
 end else begin
  setlength(result,((length(s)*4) div 3)+4);
  l:=1;
  i:=1;
  while (i+2)<=length(s) do begin
   c:=(byte(s[i]) shl 16) or (byte(s[i+1]) shl 8) or byte(s[i+2]);
   result[l]:=Base64Table[(c shr 18) and $3f];
   result[l+1]:=Base64Table[(c shr 12) and $3f];
   result[l+2]:=Base64Table[(c shr 6) and $3f];
   result[l+3]:=Base64Table[c and $3f];
   inc(i,3);
   inc(l,4);
  end;
  if (i+1)<=length(s) then begin
   c:=(byte(s[i]) shl 16) or (byte(s[i+1]) shl 8);
   result[l]:=Base64Table[(c shr 18) and $3f];
   result[l+1]:=Base64Table[(c shr 12) and $3f];
   result[l+2]:=Base64Table[(c shr 6) and $3f];
   result[l+3]:='=';
   inc(l,4);
  end else if i<=length(s) then begin
   c:=byte(s[i]) shl 16;
   result[l]:=Base64Table[(c shr 18) and $3f];
   result[l+1]:=Base64Table[(c shr 12) and $3f];
   result[l+2]:='=';
   result[l+3]:='=';
   inc(l,4);
  end;
  if l>1 then begin
   setlength(result,l-1);
  end else begin
   result:=trim(result);
  end;
 end;
end;

{
	��ת�ַ���
}
Function CoolQ_Tools_Flip(s:ansistring):ansistring;
Var
	i:longint;
Begin
	result:='';
	for i:=length(s) downto 1 do 
		result:=result+s[i];
End;

Function BinToNum(bin:ansistring):int64;
Var
	i:longint;
Begin
	result:=0;
	bin:=CoolQ_Tools_Flip(bin);
	for i:=1 to length(bin) do begin
		result:=result+PowerInt(256,(i-1))*integer(bin[i]);
	end;
End;

{ //ò��������
Function NumToBin(num:int64;len:longint):ansistring;
Begin
	result:='';
	while num>0 do begin
		result:=NumToChar(num mod 256)+result;
		num:=num div 256;
	end;
	while length(result)<len*3 do result:='00'+result; //��һ��
End;
}

Function BinToHex(bin:ansistring):ansistring;
Var
	i:longint;
Begin
	result:='';
	for i:=1 to length(bin) do begin
		result:=result+SDECtoHEX(integer(bin[i])div 16)+SDECtoHEX(integer(bin[i])mod 16)+' ';
	end;
End;

{
	���
}
Function CoolQ_Tools_Unpack_GetStr_GivenLength(Var i:longint;
								len:longint;
								Var s:ansistring):ansistring;
Begin
	if len<=0 then begin
		result:='';
		exit;
	end;
	result:=copy(s,i,len);
	i:=i+len;
End;

Function CoolQ_Tools_Unpack_GetNum(Var i:longint;
								len:longint;
								Var s:ansistring):int64;
Begin
	result:=BinToNum(copy(S,i,len));
	i:=i+len;
End;

Function CoolQ_Tools_Unpack_GetStr(Var i:longint;
								Var s:ansistring):ansistring;
Var
	len:longint;
Begin
	len:=CoolQ_Tools_Unpack_GetNum(i,2,s);
	result:=CoolQ_Tools_Unpack_GetStr_GivenLength(i,len,s);
End;

Function CoolQ_Tools_Unpack_GetLenRemain(Var i:longint;
								Var s:ansistring):longint;
Begin
	result:=length(s)-i+1;
End;


Function iconvConvert(fromCode,toCode:PChar;srcBuf:Pchar;srcLen:longint;destBuf:Pchar;destLen:longint):longint;
Var
	cd	:	iconv_t;
	srcLen1,destLen1,status	:	longint;
Begin
	cd := libiconv_open(toCode,fromCode);
	srcLen1:=srcLen;
	destLen1:=destLen;
	status:=libiconv(cd,@srcBuf,@srcLen1,@destBuf,@destLen1);
	libiconv_close(cd);
	result:=status;
End;

Function CoolQ_Tools_UTF8ToAnsi(Sstr:ansistring):ansistring;
Var
	str:PChar;
	sResult:Array [0..262143] of char;
Begin
	str:=StoP(Sstr);
	fillchar(sResult,sizeof(sResult),0);
	if iconvConvert('UTF-8//TRANSLIT//IGNORE','GB18030',Str,StrLen(Str),@sResult,StrLen(Str)*4)<>0
		then result:=''
		else result:=sResult;
End;

Function CoolQ_Tools_AnsiToUTF8(Sstr:ansistring):ansistring;
Var
	str:PChar;
	sResult:Array [0..262143] of char;
Begin
	str:=StoP(Sstr);
	fillchar(sResult,sizeof(sResult),0);
	if iconvConvert('GB18030//IGNORE','UTF-8',Str,StrLen(Str),@sResult,StrLen(Str)*4)<>0
		then result:=''
		else result:=sResult;
End;


Function CQ_CharEncode(str:ansistring;Comma:boolean):ansistring;
Begin
	Message_Replace(str,'&','&amp;');
	Message_Replace(str,'[','&#91;');
	Message_Replace(str,']','&#93;');
	if Comma then begin
		Message_Replace(str,',','&#44;');
	end;
	result:=(Str);
End;
Function CQ_CharDecode(str:ansistring):ansistring;
Begin
	Message_Replace(str,'&#93;',']');
	Message_Replace(str,'&#91;','[');
	Message_Replace(str,'&#44;',',');
	Message_Replace(str,'&amp;','&');
	result:=(str);
End;

{
QQIDΪ��@��Ⱥ��ԱQQ���ò���Ϊ-1����@ȫ���Ա���������þ���Ȩ�޲������ת��Ϊ�ı���
������[CQ:at,qq=123456]
}
function CQCode_Group_At(QQID:int64):ansistring;
Begin
	result:=('[CQ:at,qq='+String_Choose(QQID=-1,'all',NumToChar(QQID))+']');
End;

{
IDΪemoji�ַ���unicode���
������[CQ:emoji,id=128513]������һ����Ц��emoji���飩
}
function CQCode_emoji(ID:int64):ansistring;
Begin
	result:=('[CQ:emoji,id='+NumToChar(ID)+']');
End;

{
IDΪ0-170������
������[CQ:face,id=14]������һ��΢Ц��QQ���飩
}
function CQCode_face(ID:int64):ansistring;
Begin
	result:=('[CQ:at,face='+NumToChar(ID)+']');
End;

//���ڶ�������֧�ֺ�����Ϣʹ�ã�
function CQCode_Shake:ansistring;
Begin
	result:=('[CQ:shake]');
End;

{
��CQ���������Ϣ�Ŀ�ͷ��
�� Force Ϊfalseʱ������ǿ��ʹ���������������ʧ�ܽ�תΪ��ͨ��Ϣ���͡�
�� Force Ϊtrueʱ������ǿ��ʹ���������������ʧ�ܽ�ȡ������Ϣ�ķ��͡�
������
}
function CQCode_anonymous(Force:boolean):ansistring;	
Begin
	result:=('[CQ:anonymous'+String_Choose(Force,'',',ignore=true')+']');
End;

{
urlΪͼƬ�ļ����ƣ�ͼƬ����ڿ�QĿ¼��data\image\��
������[CQ:image,file=1.jpg]������data\image\1.jpg��
}
function CQCode_image(url:ansistring):ansistring;
Begin
	result:=('[CQ:image,file='+CQ_CharEncode(url,true)+']')
End;

{
sourceΪ����ƽ̨���ͣ�Ŀǰ֧��qq��163��xiami
musicidΪ��Ӧ����ƽ̨����������id
ע�⣺����ֻ����Ϊ������һ����Ϣ����
������
[CQ:music,type=qq,id=422594]������һ��QQ���ֵġ�Time after time��������Ⱥ�ڣ�
[CQ:music,type=163,id=28406557]������һ�����������ֵġ��@�D����������Ⱥ�ڣ�
}
function CQCode_Music(source:string;musicid:int64;isnew:boolean):ansistring;
Begin
	result:=('[CQ:music,type='+source+',id='+NumToChar(musicid)+String_Choose(isnew,',style=1','')+']')
	{���� (��[CQ:music,id=�� �� ���ı� (����ID) �� ��]��)}
End;

{
���������Զ������(music)
url ����������������ҳ�棨���������ҳ��
audio ���ֵ���Ƶ���ӣ���mp3���ӣ�
title ���ֵı��⣬����12������
content ���ֵļ�飬����30������
image ���ֵķ���ͼƬ���ӣ�������ΪĬ��ͼƬ
}
function CQCode_Music_Custom(url,audio,title,content,image:ansistring):ansistring;
Begin
	result:='[CQ:music,type=custom,url='+CQ_CharEncode(url,true)
						+',audio='+CQ_CharEncode(audio,true)
						+String_Choose(title='','',',title='+CQ_CharEncode(title,true))
						+String_Choose(content='','',',content='+CQ_CharEncode(content,true))
						+String_Choose(image='','',',image='+CQ_CharEncode(image,true))
						+']';
End;

{
����λ�÷���(location)

}
function CQCode_Location(latitude,longitude:real;Zoom:longint;Name,Address:ansistring):ansistring;
Begin
	result:='[CQ:location,lat='+RealToDisplay(latitude,6)+',lon='+RealToDisplay(longitude,6);
	if zoom>0 then result:=result+',zoom='+NumToChar(zoom);
	result:=result+',title='+CQ_CharEncode(Name,true)+',content'+CQ_CharEncode(Address,true)+']';
ENd;

{
idΪ��ԭ�������ID������ڿ�QĿ¼��data\bface\��
}
function CQCode_bface(ID:int64):ansistring;
Begin
	result:=('[CQ:bface,id='+NumToChar(ID)+']');
End;

{
1Ϊ��Ƶ�ļ����ƣ���Ƶ����ڿ�QĿ¼��data\record\��
2Ϊ�Ƿ�Ϊ���������ò���Ϊtrue����ʾ������ǡ��ò����ɱ����ԡ�
������[CQ:record,file=1.silk��magic=true]������data\record\1.silk�������Ϊ������
}
function CQCode_record(url:ansistring;magic:boolean):ansistring;
Begin
	result:=('[CQ:record,file='+CQ_CharEncode(url,true)+String_Choose(magic,',magic=true','')+']');
End;

{
idΪ��ȭ��������ͣ��ݲ�֧�ַ���ʱ�Զ��塣�ò����ɱ����ԡ�
1 - ��ȭ���Ϊʯͷ
2 - ��ȭ���Ϊ����
3 - ��ȭ���Ϊ��
}
function CQCode_rps(ID:int64):ansistring;
Begin
	result:=('[CQ:rps,id='+NumToChar(ID)+']');
End;

{
id��Ӧ�����ĵ������ݲ�֧�ַ���ʱ�Զ��塣�ò����ɱ����ԡ�
}
function CQCode_dice(ID:int64):ansistring;
Begin
	result:=('[CQ:dice,id='+NumToChar(ID)+']');
End;

{
[CQ:share,url=�� �� CQ��_ת�� (url��ַ, ��) �� ��,title=�� �� CQ��_ת�� (��Ƭ����, ��) �� ��,content=�� �� CQ��_ת�� (��Ƭ����, ��) �� ��,image=�� �� CQ��_ת�� (��ƬͼƬurl, ��) �� ��]
}
function CQCode_share(url,title,Content,image:ansistring):ansistring;
Begin
	result:=('[CQ:share,url='+CQ_CharEncode(url,true)+',title='+CQ_CharEncode(title,true)+',content='+CQ_CharEncode(content,true)+',image='+CQ_CharEncode(image,true)+']');
End;

{
[CQ:contact,type=qq/group,id=Q��/Ⱥ��]
}
function CQCode_contact(t:ansistring;id:int64):ansistring;
Begin
	result:=('[CQ:contact,type='+t+',id='+NumToChar(id)+']');
End;


{API}
//����˽�� Auth=106 //sendPrivateMsg
function CQ_i_sendPrivateMsg(QQID:int64;msg:ansistring):longint;		//Auth=106 //sendPrivateMsg
Begin
	if GlobalUTF8Mode
		then result:=(CQ_sendPrivateMsg(AuthCode,QQID,StoP(CoolQ_Tools_UTF8ToANSI(msg))))
		else result:=(CQ_sendPrivateMsg(AuthCode,QQID,StoP(msg)));
End;
//����Ⱥ�� Auth=101 //sendGroupMsg
function CQ_i_sendGroupMsg(groupid:int64;const msg:ansistring):longint;	//Auth=101 //sendGroupMsg
Begin
	if GlobalUTF8Mode
		then result:=(CQ_sendGroupMsg(AuthCode,groupid,StoP(CoolQ_Tools_UTF8ToANSI(msg))))
		else result:=(CQ_sendGroupMsg(AuthCode,groupid,StoP(msg)));
End;
//���������� Auth=103 //sendDiscussMsg
function CQ_i_sendDiscussMsg(DiscussID:int64;msg:ansistring):longint;	//Auth=103 //sendDiscussMsg
Begin
	if GlobalUTF8Mode
		then result:=(CQ_sendDiscussMsg(AuthCode,DiscussID,StoP(CoolQ_Tools_UTF8ToANSI(msg))))
		else result:=(CQ_sendDiscussMsg(AuthCode,DiscussID,StoP(msg)));
End;
//������ Auth=110 //sendLike
function CQ_i_sendLike(QQID:int64):longint;overload;								//Auth=110 //sendLike
Begin
	result:=(CQ_sendLike(AuthCode,QQID));
End;
function CQ_i_sendLike(QQID:int64;times:longint):longint;overload;								//Auth=110 //sendLike
Begin
	result:=(CQ_sendLikeV2(AuthCode,QQID,min(times,10)));
End;
function CQ_i_sendLikeV2(QQID:int64;times:longint):longint;								//Auth=110 //sendLike
Begin
	result:=(CQ_sendLikeV2(AuthCode,QQID,min(times,10)));
End;

//�������� Auth=30 ������Ϣ�е�����(record),���ر����� \data\record\ Ŀ¼�µ��ļ��� //getRecord
function CQ_i_getRecord(filename,format:ansistring):ansistring;			//Auth=30 ������Ϣ�е�����(record),���ر����� \data\record\ Ŀ¼�µ��ļ��� //getRecord
{
filename �յ���Ϣ�е������ļ���(file)
format Ӧ������������ļ���ʽ��Ŀǰ֧�� mp3,amr,wma,m4a,spx,ogg,wav,flac
}
Begin
	result:=(
		PtoS(
			CQ_getRecord(AuthCode,StoP(CoolQ_Tools_UTF8ToANSI(filename)),StoP(format))
		)
	)
End;

//�ı�������
function CQ_Tools_TextToAnonymous(source:ansistring;
									Var Anonymous:CQ_Type_GroupAnonymous):boolean;
Var
	data:ansistring;
	i	:longint;
Begin
	if source='' then begin
		result:=false;
		exit;
	end;
	data:=Base64_Decryption(source);
	if length(data)<12 then begin
		result:=false;
		exit;
	end;
	i:=1;
	Anonymous.AID:=CoolQ_Tools_Unpack_GetNum(i,8,data);
	Anonymous.name:=CoolQ_Tools_Unpack_GetStr(i,data);
	Anonymous.Token:=CoolQ_Tools_Unpack_GetStr(i,data);
	
	if GlobalUTF8Mode then begin
		Anonymous.name:=CoolQ_Tools_AnsiToUTF8(Anonymous.name);
		Anonymous.Token:=CoolQ_Tools_AnsiToUTF8(Anonymous.Token);
	end;
	
	result:=true;
End;

//�ı���ȺԱ -- ���ݵ�data��������Base64����������
function CQ_Tools_TextToGroupMember_Main(data:ansistring;
									Var info:CQ_Type_GroupMember):boolean;
Var
	i:longint;
Begin
	if length(data)<40 then begin
		result:=false;
		exit;
	end;
	i:=1;
	info.groupid:=CoolQ_Tools_Unpack_GetNum(i,8,data);
	info.QQID:=CoolQ_Tools_Unpack_GetNum(i,8,data);
	info.nick:=CoolQ_Tools_Unpack_GetStr(i,data);
	info.card:=CoolQ_Tools_Unpack_GetStr(i,data);
	info.sex:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.age:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.aera:=CoolQ_Tools_Unpack_GetStr(i,data);
	info.jointime:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.lastsent:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.level_name:=CoolQ_Tools_Unpack_GetStr(i,data);
	info.permission:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.unfriendly:=CoolQ_Tools_Unpack_GetNum(i,4,data)=1;
	info.title:=CoolQ_Tools_Unpack_GetStr(i,data);
	info.titleExpiretime:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.nickcanchange:=CoolQ_Tools_Unpack_GetNum(i,4,data)=1;
	
	if GlobalUTF8Mode then begin
		info.nick:=CoolQ_Tools_AnsiToUTF8(info.nick);
		info.card:=CoolQ_Tools_AnsiToUTF8(info.card);
		info.aera:=CoolQ_Tools_AnsiToUTF8(info.aera);
		info.level_name:=CoolQ_Tools_AnsiToUTF8(info.level_name);
		info.title:=CoolQ_Tools_AnsiToUTF8(info.title);
	end;
	
	result:=(true);
End;

//�ı���Ⱥ��Ա -- ���ݵ�scource������δBase64����������
function CQ_Tools_TextToGroupMember(source:ansistring;
									Var info:CQ_Type_GroupMember):boolean;
Var
	data:ansistring;
Begin
	if source='' then begin
		result:=false;
		exit;
	end;
	data:=Base64_Decryption(source);
	result:=(CQ_Tools_TextToGroupMember_Main(data,info));
End;


//�ı���Ⱥ��Ա�б�
function CQ_Tools_TextToGroupMemberList(source:ansistring;Var GroupMemberList:CQ_Type_GroupMember_List):boolean;
Var
	data	:	ansistring;
	i,j		:	longint;
Begin
	if source='' then begin
		result:=false;
		exit;
	end;
	data:=Base64_Decryption(source);
	if length(data)<10 then begin
		result:=false;
		exit;
	end;
	i:=1;
	GroupMemberList.l:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	SetLength(GroupMemberList.s,GroupMemberList.l);
	for j:=0 to GroupMemberList.l-1 do begin
		if CoolQ_Tools_Unpack_GetLenRemain(i,data)<=0
			then
			begin
				result:=false;
				exit;
			end
			else
			begin
				if CQ_Tools_TextToGroupMember_Main(CoolQ_Tools_Unpack_GetStr(i,data),GroupMemberList.s[j])=false then begin
					result:=false;
					exit;
				end;
			end;
	end;
	result:=true;
End;

//�ı���Ⱥ�ļ�
Function CQ_Tools_TextToFile(source:string;Var info:CQ_Type_GroupFile):boolean;
Var
	data:ansistring;
	i:longint;
Begin
	if source='' then begin
		result:=false;
		exit;
	end;
	data:=Base64_Decryption(source);
	if length(data)<20 then begin
		result:=false;
		exit;
	end;
	i:=1;
	info.FileID:=CoolQ_Tools_Unpack_GetStr(i,data);
	info.FileName:=CoolQ_Tools_Unpack_GetStr(i,data);
	info.Size:=CoolQ_Tools_Unpack_GetNum(i,8,data);
	info.busid:=CoolQ_Tools_Unpack_GetNum(i,8,data);
	
	if GlobalUTF8Mode then begin
		info.FileID:=CoolQ_Tools_AnsiToUTF8(info.FileID);
		info.FileName:=CoolQ_Tools_AnsiToUTF8(info.FileName)
	end;
	
	result:=true;
End;

//����_ת��_ansihex��Ⱥ��Ϣ
Function CQ_Tools_TextToGroupInfo(source:ansistring;Var GroupInfo:CQ_Type_GroupInfo):boolean;
Var
	i:longint;
Begin
	if length(source)<10 then begin
		result:=false;
		exit;
	end;
	i:=1;
	GroupInfo.GroupID:=CoolQ_Tools_Unpack_GetNum(i,8,source);
	GroupInfo.name:=CoolQ_Tools_Unpack_GetStr(i,source);
	
	if GlobalUTF8Mode then begin
		GroupInfo.name:=CoolQ_Tools_AnsiToUTF8(GroupInfo.name);
	end;
	
	result:=true;
End;

//����_ת��_�ı���Ⱥ�б���Ϣa
Function CQ_Tools_TextToGroupListInfo(source:ansistring;Var GroupList:CQ_Type_GroupList):boolean;
Var
	data:ansistring;
	i,j:longint;
Begin
	if source='' then begin
		result:=false;
		exit;
	end;
	data:=Base64_Decryption(source);
	if length(data)<4 then begin
		result:=false;
		exit;
	end;
	i:=1;
	GroupList.l:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	SetLength(GroupList.s,GroupList.l);
	for j:=0 to GroupList.l-1 do begin
		if CoolQ_Tools_Unpack_GetLenRemain(i,data)<=0
			then
			begin
				result:=false;
				exit;
			end
			else
			begin
				if CQ_Tools_TextToGroupInfo(CoolQ_Tools_Unpack_GetStr(i,data),GroupList.s[j])=false then begin
					result:=false;
					exit;
				end;
			end;
	end;
	result:=true;
End;

//��ȡCookies Auth=20 ����,�˽ӿ���Ҫ�ϸ���Ȩ //getCookies
Function CQ_i_GetCookies():ansistring;
Begin
	result:=(CQ_GetCookies(AuthCode));
End;

//��ȡCsrfToken Auth=20 ��QQ��ҳ�õ���bkn/g_tk�� ����,�˽ӿ���Ҫ�ϸ���Ȩ //getCsrfToken
Function CQ_i_getCsrfToken():longint;
Begin
	result:=(CQ_GetCsrfToken(AuthCode));
End;

//ȡ��½QQ getLoginQQ
Function CQ_i_GetLoginQQ():int64;
Begin
	result:=(CQ_GetLoginQQ(authcode));
End;

//ȡ��½QQ�ǳơ�getLoginNick
Function CQ_i_getLoginNick():string;
Begin
	if GlobalUTF8Mode
		then result:=CoolQ_Tools_AnsiToUTF8(CQ_GetLoginNick(AuthCode))
		else result:=(CQ_GetLoginNick(AuthCode));
End;

//ȡİ������Ϣ Auth=131 //CQ_getStrangerInfo
Function CQ_i_GetStrangerInfo(QQ:int64;Var info:CQ_Type_QQ;nocache:boolean):longint;
Var
	data:ansistring;
	i:longint;
Begin
	data:=CQ_GetStrangerInfo(AuthCode,QQ,Nocache);
	data:=Base64_Decryption(data);
	if length(data)<16 then begin
		result:=-1000;
		exit;
	end;
	i:=1;
	info.QQID:=CoolQ_Tools_Unpack_GetNum(i,8,data);
	info.nick:=CoolQ_Tools_Unpack_GetStr(i,data);
	info.sex:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	info.age:=CoolQ_Tools_Unpack_GetNum(i,4,data);
	
	if GlobalUTF8Mode then begin
		info.nick:=CoolQ_Tools_AnsiToUTF8(info.nick);
	end;
	
	result:=0;
End;

//ȡȺ��Ա��Ϣ Auth=130 //getGroupMemberInfoV2
function CQ_i_getGroupMemberInfo(groupid,qqid:int64;
								Var info:CQ_Type_GroupMember;
								nocache:boolean):longint;
Var
	return:ansistring;
Begin
	return:=CQ_getGroupMemberInfoV2(AuthCode,groupid,QQID,nocache);
	if return='' then begin
		result:=-1000;
		exit;
	end;
	if CQ_Tools_TextToGroupMember(return,info)=false then begin
		result:=-1000;
		exit;
	end;
	result:=0;
End;

//���ص�·��ĩβ��"\" //getAppDirectory
function CQ_i_getAppDirectory:ansistring;
Begin
	result:=(PtoS(CQ_getAppDirectory(AuthCode)));
End;

{�ɹ�������־ID //addlog
	priority ��ֵ�뿴�����б� CQLOG_*
	category ������
	content ����־����
}
function CQ_i_addLog(priority:longint;const category,content:ansistring):longint;
Begin
	if GlobalUTF8Mode
		then result:=(CQ_addLog(AuthCode,priority,StoP(CoolQ_Tools_UTF8ToANSI(category)),StoP(CoolQ_Tools_UTF8ToANSI(content))))
		else result:=(CQ_addLog(AuthCode,priority,StoP(category),StoP(content)));
End;

//��Ӻ�������ظ� Auth=150 //setFriendAddRequest
function CQ_i_setFriendAddRequest(const responseflag:pchar;responseoperation:longint;const remark:string):longint;
Begin
	if GlobalUTF8Mode
		then
			result:=(CQ_setFriendAddRequest(authcode,
										responseflag,			//ͨ���¼��������ݻ��
										responseoperation,		//ͨ����������
										StoP(CoolQ_Tools_UTF8ToANSI(remark))))			//��Ӻ���ѱ�ע
		else
			result:=(CQ_setFriendAddRequest(authcode,
										responseflag,			//ͨ���¼��������ݻ��
										responseoperation,		//ͨ����������
										StoP(remark)))			//��Ӻ���ѱ�ע

End;

//������ȺԱ���� Auth=124 //setGroupAnonymousBan
function CQ_i_setGroupAnonymousMute(group:int64;fromAnonymous:string;duration:int64):longint;
Begin
	result:=(CQ_setGroupAnonymousBan(authcode,
								group,
								StoP(fromAnonymous),		//ͨ���¼��������ݻ��
								duration));					//����ʱ�� ��λ�� ��֧�ֽ��
End;

//��ȫȺ���� Auth=123 //setGroupWholeBan
function CQ_i_setGroupWholeMute(groupid:int64;enableban:boolean):longint;
Begin
	result:=(CQ_setGroupWholeBan(AuthCode,groupid,enableban));
End;

//��Ⱥ��Ա��Ƭ Auth=126 //setGroupCard
function CQ_i_setGroupCard(group,qq:int64;nick:string):longint;
Begin
	if GlobalUTF8Mode
		then
			result:=(CQ_setGroupCard(authcode,
								group,
								qq,
								StoP(CoolQ_Tools_UTF8ToANSI(nick))))
		else
			result:=(CQ_setGroupCard(authcode,
								group,
								qq,
								StoP(nick)))
End;

//��ȺԱר��ͷ�� Auth=128 ��Ⱥ��Ȩ�� //setGroupSpecialTitle
Function CQ_i_setGroupSpecialTitle(Group,ID:int64;Title:string;duration:int64):longint;
Begin
	if GlobalUTF8Mode
		then
			result:=(CQ_setGroupSpecialTitle(authcode,
										group,				//Ŀ��Ⱥ
										id,					//Ŀ��QQ
										StoP(CoolQ_Tools_UTF8ToANSI(title)),		//��Ҫɾ��ͷ�Σ�������
										duration))			//ר��ͷ����Ч�ڣ���λΪ�롣���������Ч��������д-1
		else
			result:=(CQ_setGroupSpecialTitle(authcode,
										group,				//Ŀ��Ⱥ
										id,					//Ŀ��QQ
										StoP(title),		//��Ҫɾ��ͷ�Σ�������
										duration));			//ר��ͷ����Ч�ڣ���λΪ�롣���������Ч��������д-1
End;


{
	��Ⱥ����Ա Auth=122 //setGroupAdmin
	operation true���óɹ���Ա falseȡ������Ա
}
Function CQ_i_setGroupAdmin(group,qq:int64;operation:boolean):longint;
Begin
	result:=(CQ_SetGroupAdmin(authcode,group,qq,operation));
End;

{
	��Ⱥ�������� Auth=125 //setGroupAnonymous
	operation true�������� false�ر�����
}
Function CQ_i_setGroupAnonymous(group:int64;operation:boolean):longint;
Begin
	result:=(CQ_setGroupAnonymous(AuthCode,group,operation));
End;


//��Ⱥ������� Auth=151 //setGroupAddRequest
Function CQ_i_setGroupAddRequest(responseflag:string;	//�����¼��յ��ġ�responseflag������
								subtype		:longint;	//���������¼������������� #����_Ⱥ��� �� #����_Ⱥ����
								responseoperation:longint;	//#����_ͨ�� �� #����_�ܾ�
								reason		:string 	//�������ɣ��� #����_Ⱥ��� �� #����_�ܾ� ʱ����
								):longint;
Begin
	if GlobalUTF8Mode
	then
		result:=(
			CQ_setGroupAddRequestV2(
				AuthCode,
				StoP(responseflag),
				subtype,
				responseoperation,
				StoP(CoolQ_Tools_UTF8ToANSI(reason))
			)
		)
	else
		result:=(
			CQ_setGroupAddRequestV2(
				AuthCode,
				StoP(responseflag),
				subtype,
				responseoperation,
				StoP(reason)
			)
		);
End;

{
��Ⱥ�˳� Auth=127 ����,�˽ӿ���Ҫ�ϸ���Ȩ //setGroupLeave
Disband true��ɢ��Ⱥ[Ⱥ��] false�˳���Ⱥ[Ⱥ��/ȺԱ]
}
Function CQ_i_setGroupLeave(group:int64;isdisband:boolean):longint;
Begin
	result:=(CQ_setGroupLeave(Authcode,Group,IsDisband));
End;

//��ȺԱ���� Auth=121 //setGroupBan
function CQ_i_setGroupMute(groupid,QQID,duration:int64):longint;
Begin
	result:=(CQ_setGroupBan(AuthCode,groupid,QQID,duration));
End;

//��ȺԱ�Ƴ� Auth=120 //setGroupKick
function CQ_i_setGroupKick(groupid,QQID:int64;rejectaddrequest:boolean):longint;
Begin
	result:=(CQ_setGroupKick(AuthCode,Groupid,QQID,rejectaddrequest));
End;

//���������˳� Auth=140 //setDiscussLeave
function CQ_i_setDiscussLeave(DiscussID:int64):longint;
Begin
	result:=(CQ_setDiscussLeave(authcode,DiscussID));
End;

//������������ʾ //setFatal
function CQ_i_setFatal(msg:ansistring):longint;
Begin
	if GlobalUTF8Mode
		then result:=(CQ_setFatal(authcode,StoP(CoolQ_Tools_UTF8ToANSI(msg))))
		else result:=(CQ_setFatal(authcode,StoP(msg)));
End;

//ȡȺ��Ա�б� Auth=160 //getGroupMemberList
function CQ_i_getGroupMemberList(GroupID:int64;Var GroupMemberList:CQ_Type_GroupMember_List):longint;
Var
	return	:	ansistring;
Begin
	return:=PtoS(CQ_getGroupMemberList(AuthCode,GroupID));
	if return='' then begin
		result:=-1000;
		exit;
	end
	else
	if CQ_Tools_TextToGroupMemberList(return,GroupMemberList)=false then begin
		result:=-1000;
		exit;
	end;
	result:=0;
End;



//ȡȺ�б� Auth=161  //getGroupList
function CQ_i_getGroupList(Var GroupList:CQ_Type_GroupList):longint;
Var
	return	:	ansistring;
Begin
	return:=PtoS(CQ_getGroupList(AuthCode));
	if return='' then begin
		result:=-1000;
		exit;
	end
	else
	if CQ_Tools_TextToGroupListInfo(return,GroupList)=false then begin
		result:=-1000;
		exit;
	end;
	result:=0;
End;


//������Ϣ Auth=180 //deleteMsg
function CQ_i_deleteMsg(msgID:int64):longint;
Begin
	result:=(CQ_deleteMsg(AuthCode,msgID));
End;

initialization
	InitBase64;
	GlobalUTF8Mode:=false;
end.
