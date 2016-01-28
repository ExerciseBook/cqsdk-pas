{
	Char* 转换到 字符串
}
Function PtoS(a:pchar):ansistring;
Begin
	PtoS:=strPas(a)
End;

{
	字符串 转换到 Char*
}
Function StoP(a:ansistring):Pchar;
Var
	s:array [0..65535] of char;
Begin
	s:=a;
	StoP:=pchar(@s);
End;

{***********************************************************}

{
	数字 转换到 字符串
}
Function NumToChar(a:longint):string;
Begin
	str(a,NumToChar);
End;


{
	字符串 转换到 数字
}
Function CharToNum(a:string):longint;
Begin
	val(a,CharToNum);
End;

{***********************************************************}

Function String_Choose(expression:boolean;a,b:ansistring):ansistring;
Begin
	if expression then exit(a) else exit(b)
End;