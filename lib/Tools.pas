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
			i:=i+length(c)-1;
		end;
	until i>=length(a);
End;

{***********************************************************}
Function SDECtoHEX(a:integer):char;
Begin
	case a of
		0 : exit('0');
		1 : exit('1');
		2 : exit('2');
		3 : exit('3');
		4 : exit('4');
		5 : exit('5');
		6 : exit('6');
		7 : exit('7');
		8 : exit('8');
		9 : exit('9');
		10 : exit('A');
		11 : exit('B');
		12 : exit('C');
		13 : exit('D');
		14 : exit('E');
		15 : exit('F');
	end;
End;

Function SHEXtoDec(a:char):integer;
Begin
	case upcase(a) of
		'0' : exit(0);
		'1' : exit(1);
		'2' : exit(2);
		'3' : exit(3);
		'4' : exit(4);
		'5' : exit(5);
		'6' : exit(6);
		'7' : exit(7);
		'8' : exit(8);
		'9' : exit(9);
		'A' : exit(10);
		'B' : exit(11);
		'C' : exit(12);
		'D' : exit(13);
		'E' : exit(14);
		'F' : exit(15);
	end;
End;

{
	十进制转二进制
}
Function Hex_Conversion_10to2(s:longint):string;
Begin
        Hex_Conversion_10to2:='';
        while s>0 do begin
                Hex_Conversion_10to2:=numtochar(s mod 2)+
                                      Hex_Conversion_10to2;
                s:=s div 2;
        end;
        while length(Hex_Conversion_10to2)<8 do
                Hex_Conversion_10to2:='0'+Hex_Conversion_10to2;
End;
{
	二进制转十进制
}
Function Hex_Conversion_2to10(s:string):longint;
Var
        i:longint;
Begin
        Hex_Conversion_2to10:=0;
        for i:=length(s) downto 1 do begin
                if s[i]='1' then
                Hex_Conversion_2to10:=Hex_Conversion_2to10+
                                      2 **
                                      int64((length(s)-i))
        end;
End;

Function GB2312ASCtoChar(a,b:char):char;
Begin
	exit(char(SHEXtoDec(a)*16+SHEXtoDec(b)));
End;

Function UrlEncode(s:ansistring):ansistring;
//编码
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

	exit(a);
End;

Function UrlDecode(s:ansistring):ansistring;
//解码
Var
	i:longint;
	outs:ansistring;
Begin
	outs:='';
	i:=1;
	while i<=length(s) do begin
		if s[i]='%' then begin
			//需要转义
			outs:=outs+GB2312ASCtoChar(s[i+1],s[i+2]);
			i:=i+3;
		end
		else
		begin
			//不需要转义
			outs:=outs+s[i];
			i:=i+1;
		end;
	end;
        exit(outs);
End;