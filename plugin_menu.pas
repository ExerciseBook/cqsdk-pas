{$IFDEF FPC}
	{$CODEPAGE UTF-8}
{$ENDIF}

unit plugin_menu;

interface
uses CoolQSDK,iconv,windows,sysutils,dateutils;
Function _menuA():longint;stdcall;
Function _menuB():longint;stdcall;

implementation

{
* 菜单，可在 .json 文件中设置菜单数目、函数名
* 如果不使用菜单，请在 .json 及此处删除无用菜单
}
Function _menuA():longint;
stdcall;
Begin
	MessageBox(0,StoP('AuthCode : '+NumToChar(AuthCode)),'Example _ AuthCode',36);
{$IFDEF FPC}
	exit(0);
{$ELSE}
	result:=0;
{$ENDIF}
End;

Function _menuB():longint;
stdcall;
Begin
	MessageBox(0,StoP('Now : '+DateTimeToStr(now)),'Example _ Now',36);
{$IFDEF FPC}
	exit(0);
{$ELSE}
	result:=0;
{$ENDIF}
End;

end.