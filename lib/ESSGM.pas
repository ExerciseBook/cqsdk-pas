unit ESSGM;
{$UNITPATH ..\}

interface
//function GM_Initialize(AuthCode:longint):longint;
function GM_GetPermissionStatus(Group,QQ:int64;Permission:Ansistring):longint;
function GM_GetPermissionValue(Group,QQ:int64;Permission:Ansistring):Ansistring;

implementation

uses CoolQSDK;
{$INCLUDE ESSGM_DllFunction.pas}
end.
