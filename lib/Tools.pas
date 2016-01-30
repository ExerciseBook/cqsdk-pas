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
Function NumToChar(a:int64):string;
Begin
	str(a,NumToChar);
End;


{
	字符串 转换到 数字
}
Function CharToNum(a:string):int64;
Begin
	val(a,CharToNum);
End;


{
	双精浮点 转换到 字符串
}
Function RealToChar(a:real):string;
Begin
	str(a,RealToChar)
End;

{
	字符串 转换到 双精浮点
}
Function CharToReal(a:string):real;
Begin
	val(a,CharToReal);
End;

{***********************************************************}

Function String_Choose(expression:boolean;a,b:ansistring):ansistring;
Begin
	if expression then exit(a) else exit(b)
End;