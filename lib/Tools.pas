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
Begin
	StoP:=pchar(@a[1]);
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

{
	双精浮点 转换到 能看的字符串
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
	
	exit(display);
End;


{***********************************************************}

Function String_Choose(expression:boolean;a,b:ansistring):ansistring;
Begin
	if expression then exit(a) else exit(b)
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
		end;
	until i>=length(a);
End;