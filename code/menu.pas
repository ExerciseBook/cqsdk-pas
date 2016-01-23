{
* 菜单，可在 .json 文件中设置菜单数目、函数名
* 如果不使用菜单，请在 .json 及此处删除无用菜单
}
Function _menuA():longint;
stdcall;
Begin
	MessageBox(0,StoP('本插件的AuthCode为 : '+NumToChar(AuthCode)),'样例 _ AuthCode查询',36);
	exit(0);
End;
Function _menuB():longint;
stdcall;
Begin
	MessageBox(0,StoP('当前时间 : '+DateTimeToStr(now)),'样例 _ 当前时间',36);
	exit(0);
End;