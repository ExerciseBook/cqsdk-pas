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
{
	Base64解码
}
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
{
	Base64编码
}
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

