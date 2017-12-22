function GM_Initialize(AuthCode:longint):longint;
	stdcall; external 'ESSGM.dll' name 'Initialize';
	
function GM_GetPermissionStatus_(Group,QQ:int64;Permission:Pchar):longint;
	stdcall; external 'ESSGM.dll' name 'GM_GetPermissionStatus';
function GM_GetPermissionValue_(Group,QQ:int64;Permission:Pchar):Pchar;
	stdcall; external 'ESSGM.dll' name 'GM_GetPermissionValue';
	
function GM_GetPermissionStatus(Group,QQ:int64;Permission:Ansistring):longint;
Begin
	result:=(GM_GetPermissionStatus_(Group,QQ,StoP(Permission)));
End;
function GM_GetPermissionValue(Group,QQ:int64;Permission:Ansistring):Ansistring;
Begin
	result:=(PtoS(GM_GetPermissionValue_(Group,QQ,StoP(Permission))));
End;
