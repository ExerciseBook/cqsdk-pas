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
                                      (length(s)-i)
        end;
End;

Function Base64_Encryption(s:ansistring):ansistring;
Var
        st:ansistring;
        i :longint;
		TheBase64Alphabet : string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'+
                                     'abcdefghijklmnopqrstuvwxyz'+
                                     '0123456789' + '+/';
Begin
        Base64_Encryption:='';
        st:='';
        for i:=1 to length(s) do begin
                st:=st+Hex_Conversion_10to2( integer(s[i]) );
                while length(st)>=6 do begin
                        Base64_Encryption:=Base64_Encryption + TheBase64Alphabet[
                                           Hex_Conversion_2to10('00'+copy(st,1,6))
                                           +1];
                        delete(st,1,6);
                end;
        end;
        if length(st)=2 then begin
                Base64_Encryption:=Base64_Encryption + TheBase64Alphabet[
                                           Hex_Conversion_2to10('00'+st+'0000')
                                           +1]+'==';
        end;

        if length(st)=4 then begin
                Base64_Encryption:=Base64_Encryption + TheBase64Alphabet[
                                           Hex_Conversion_2to10('00'+st+'00')
                                           +1]+'=';
        end;
End;

Function Base64_Decryption(s:ansistring):ansistring;
Var
        st:ansistring;
        len:longint;
        i :longint;
		TheBase64Alphabet : string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'+
                                     'abcdefghijklmnopqrstuvwxyz'+
                                     '0123456789' + '+/';
Begin
        Base64_Decryption:='';
        st:='';
        len:=length(s);
        i:=1;
        while i<=len do begin
                if s[i]<>'=' then begin
                        st:=st+copy(
                             Hex_Conversion_10to2(
                                        pos(s[i],TheBase64Alphabet)-1
                            ),3,8);
                        while length(st)>=8 do begin
                                Base64_Decryption:=Base64_Decryption+
                                                   char(Hex_Conversion_2to10(
                                                   copy(st,1,8)));
                                delete(st,1,8);
                        end;

                end
                else
                begin
                        if i=len then begin
                                Base64_Decryption:=Base64_Decryption+
                                                   char(Hex_Conversion_2to10(
                                                   copy(st,1,6)));
                        end;
                        if i=len-1 then begin
                                Base64_Decryption:=Base64_Decryption+
                                                   char(Hex_Conversion_2to10(
                                                   copy(st,1,4)));
                                i:=i+1;
                        end;
                        if i<len-1 then begin
                                exit('FALSE');
                        end;
                end;
                inc(i);
        end;
End;

{
	反转字符串
}
Function CoolQ_Tools_Flip(s:ansistring):ansistring;
Var
	i:longint;
Begin
	CoolQ_Tools_Flip:='';
	for i:=length(s) downto 1 do 
		CoolQ_Tools_Flip:=CoolQ_Tools_Flip+s[i];
End;

Function BinToNum(bin:ansistring):int64;
Var
	i:longint;
Begin
	BinToNum:=0;
	bin:=CoolQ_Tools_Flip(bin);
	for i:=1 to length(bin) do begin
		BinToNum:=BinToNum+256**(i-1)*integer(bin[i]);
	end;
End;

Function NumToBin(num:int64;len:longint):ansistring;
Begin
	NumToBin:='';
	while num>0 do begin
		NumToBin:=NumToChar(num mod 256)+NumToBin;
		num:=num div 256;
	end;
	while length(NumToBin)<len*3 do NumToBin:='00 '+NumToBin;
End;

Function BinToHex(bin:ansistring):ansistring;
Var
	i:longint;
Begin
	BinToHex:='';
	for i:=1 to length(bin) do begin
		BinToHex:=BinToHex+SDECtoHEX(integer(bin[i])div 16)+SDECtoHEX(integer(bin[i])mod 16)+' ';
	end;
End;

{
	下面是神奇的东西
}
Function CoolQ_Tools_GetBin(Var i:longint;
								len:longint;
								s:ansistring):ansistring;
Begin
	if len<=0 then exit('');
	CoolQ_Tools_GetBin:=copy(s,i,len);
	i:=i+len;
End;

Function CoolQ_Tools_GetNum(Var i:longint;
								len:longint;
								s:ansistring):int64;
Begin
	CoolQ_Tools_GetNum:=BinToNum(copy(S,i,len));
	i:=i+len;
End;

Function CoolQ_Tools_GetStr(Var i:longint;
								s:ansistring):ansistring;
Var
	len:longint;
Begin
	len:=CoolQ_Tools_GetNum(i,2,s);
	exit(CoolQ_Tools_GetBin(i,len,s));
End;