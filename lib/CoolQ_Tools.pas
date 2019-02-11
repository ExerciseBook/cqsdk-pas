procedure InitBase64;
var i:longint;
begin
 for i:=0 to 63 do begin
  Base64DecoderTable[Base64Table[i]]:=i;
 end;
end;

//function DecodeBase64(s:ansistring):ansistring;
Function Base64_Decryption(s:ansistring):ansistring;
var i,j,l:longint;
    c:longword;
begin
 setlength(result,((length(s)*3) shr 2)+3);
{while (length(s) and 3)<>0 do begin
  s:=s+'=';
 end;}
 l:=0;
 i:=1;
 while i<=length(s) do begin
  c:=0;
  for j:=1 to 4 do begin
   if i<=length(s) then begin
    case s[i] of
     'A'..'Z','a'..'z','0'..'9','+','/':begin
      c:=c or (Base64DecoderTable[s[i]] shl (24-((j shl 2)+(j shl 1))));
     end;
     '=':begin
      c:=(c and $00ffffff) or (((c shr 24)+1) shl 24);
     end;
     else begin
      c:=c or $f0000000;
      break;
     end;
    end;
   end else begin
    c:=(c and $00ffffff) or (((c shr 24)+1) shl 24);
   end;
   inc(i);
  end;
  if (c shr 24)<3 then begin
   inc(l);
   result[l]:=chr((c shr 16) and $ff);
   if (c shr 24)<2 then begin
    inc(l);
    result[l]:=chr((c shr 8) and $ff);
    if (c shr 24)<1 then begin
     inc(l);
     result[l]:=chr(c and $ff);
    end;
   end;
  end else begin
   break;
  end;
 end;
 setlength(result,l);
end;

//function EncodeBase64(s:ansistring):ansistring;
Function Base64_Encryption(s:ansistring):ansistring;
var i,l:longint;
    c:longword;
begin
 if length(s)=0 then begin
  result:='';
 end else begin
  setlength(result,((length(s)*4) div 3)+4);
  l:=1;
  i:=1;
  while (i+2)<=length(s) do begin
   c:=(byte(s[i]) shl 16) or (byte(s[i+1]) shl 8) or byte(s[i+2]);
   result[l]:=Base64Table[(c shr 18) and $3f];
   result[l+1]:=Base64Table[(c shr 12) and $3f];
   result[l+2]:=Base64Table[(c shr 6) and $3f];
   result[l+3]:=Base64Table[c and $3f];
   inc(i,3);
   inc(l,4);
  end;
  if (i+1)<=length(s) then begin
   c:=(byte(s[i]) shl 16) or (byte(s[i+1]) shl 8);
   result[l]:=Base64Table[(c shr 18) and $3f];
   result[l+1]:=Base64Table[(c shr 12) and $3f];
   result[l+2]:=Base64Table[(c shr 6) and $3f];
   result[l+3]:='=';
   inc(l,4);
  end else if i<=length(s) then begin
   c:=byte(s[i]) shl 16;
   result[l]:=Base64Table[(c shr 18) and $3f];
   result[l+1]:=Base64Table[(c shr 12) and $3f];
   result[l+2]:='=';
   result[l+3]:='=';
   inc(l,4);
  end;
  if l>1 then begin
   setlength(result,l-1);
  end else begin
   result:=trim(result);
  end;
 end;
end;

{
	反转字符串
}
Function CoolQ_Tools_Flip(s:ansistring):ansistring;
Var
	i:longint;
Begin
	result:='';
	for i:=length(s) downto 1 do 
		result:=result+s[i];
End;

Function BinToNum(bin:ansistring):int64;
Var
	i:longint;
Begin
	result:=0;
	bin:=CoolQ_Tools_Flip(bin);
	for i:=1 to length(bin) do begin
		result:=result+PowerInt(256,(i-1))*integer(bin[i]);
	end;
End;

{ //貌似有问题
Function NumToBin(num:int64;len:longint):ansistring;
Begin
	result:='';
	while num>0 do begin
		result:=NumToChar(num mod 256)+result;
		num:=num div 256;
	end;
	while length(result)<len*3 do result:='00'+result; //这一行
End;
}

Function BinToHex(bin:ansistring):ansistring;
Var
	i:longint;
Begin
	result:='';
	for i:=1 to length(bin) do begin
		result:=result+SDECtoHEX(integer(bin[i])div 16)+SDECtoHEX(integer(bin[i])mod 16)+' ';
	end;
End;

{
	解包
}
Function CoolQ_Tools_Unpack_GetStr_GivenLength(Var i:longint;
								len:longint;
								Var s:ansistring):ansistring;
Begin
	if len<=0 then begin
		result:='';
		exit;
	end;
	result:=copy(s,i,len);
	i:=i+len;
End;

Function CoolQ_Tools_Unpack_GetNum(Var i:longint;
								len:longint;
								Var s:ansistring):int64;
Begin
	result:=BinToNum(copy(S,i,len));
	i:=i+len;
End;

Function CoolQ_Tools_Unpack_GetStr(Var i:longint;
								Var s:ansistring):ansistring;
Var
	len:longint;
Begin
	len:=CoolQ_Tools_Unpack_GetNum(i,2,s);
	result:=CoolQ_Tools_Unpack_GetStr_GivenLength(i,len,s);
End;

Function CoolQ_Tools_Unpack_GetLenRemain(Var i:longint;
								Var s:ansistring):longint;
Begin
	result:=length(s)-i+1;
End;


Function iconvConvert(fromCode,toCode:PChar;srcBuf:Pchar;srcLen:longint;destBuf:Pchar;destLen:longint):longint;
Var
	cd	:	iconv_t;
	srcLen1,destLen1,status	:	longint;
Begin
	cd := libiconv_open(toCode,fromCode);
	srcLen1:=srcLen;
	destLen1:=destLen;
	status:=libiconv(cd,@srcBuf,@srcLen1,@destBuf,@destLen1);
	libiconv_close(cd);
	result:=status;
End;

Function CoolQ_Tools_UTF8ToAnsi(Sstr:ansistring):ansistring;
Var
	str:PChar;
	sResult:Array [0..262143] of char;
Begin
	str:=StoP(Sstr);
	fillchar(sResult,sizeof(sResult),0);
	if iconvConvert('UTF-8//TRANSLIT//IGNORE','GB18030',Str,StrLen(Str),@sResult,StrLen(Str)*4)<>0
		then result:=''
		else result:=sResult;
End;

Function CoolQ_Tools_AnsiToUTF8(Sstr:ansistring):ansistring;
Var
	str:PChar;
	sResult:Array [0..262143] of char;
Begin
	str:=StoP(Sstr);
	fillchar(sResult,sizeof(sResult),0);
	if iconvConvert('GB18030//IGNORE','UTF-8',Str,StrLen(Str),@sResult,StrLen(Str)*4)<>0
		then result:=''
		else result:=sResult;
End;

