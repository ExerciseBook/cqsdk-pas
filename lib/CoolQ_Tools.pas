Function Base64_Encryption(s:ansistring):ansistring;
Var
        st:ansistring;
        i :longint;
		TheBase64Alphabet : string;
Begin
		TheBase64Alphabet:='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
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
		TheBase64Alphabet : string;
Begin
		TheBase64Alphabet:='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
        Base64_Decryption:='';
        st:='';
        len:=length(s);
        i:=1;
        while i<=len do begin
				if (s[i]=CR) or (s[i]=LF) then begin
					inc(i);
				end
				else
				begin
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
	解包
}
Function CoolQ_Tools_Unpack_GetStr(Var i:longint;
								len:longint;
								Var s:ansistring):ansistring;
Begin
	if len<=0 then exit('');
	CoolQ_Tools_Unpack_GetStr:=copy(s,i,len);
	i:=i+len;
End;

Function CoolQ_Tools_Unpack_GetNum(Var i:longint;
								len:longint;
								Var s:ansistring):int64;
Begin
	CoolQ_Tools_Unpack_GetNum:=BinToNum(copy(S,i,len));
	i:=i+len;
End;

Function CoolQ_Tools_Unpack_GetStr(Var i:longint;
								Var s:ansistring):ansistring;
Var
	len:longint;
Begin
	len:=CoolQ_Tools_Unpack_GetNum(i,2,s);
	exit(CoolQ_Tools_Unpack_GetStr(i,len,s));
End;

Function CoolQ_Tools_Unpack_GetLenRemain(Var i:longint;
								Var s:ansistring):longint;
Begin
	exit(length(s)-i+1);
End;