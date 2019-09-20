unit iconv;
interface

Type
  size_t = NativeInt;
  Psize_t  = ^size_t;
  iconv_t = pointer;

function libiconv_open(tocode:PAnsiChar; fromcode:PAnsiChar):iconv_t;cdecl;
	external 'libiconv.dll' name 'libiconv_open';
function libiconv(cd:iconv_t; inbuf:PPansichar; inbytesleft:Psize_t; outbuf:PPansichar; outbytesleft:Psize_t):size_t;cdecl;
	external 'libiconv.dll' name 'libiconv';
function libiconv_close(cd:iconv_t):longint;cdecl;
	external 'libiconv.dll' name 'libiconv_close';

implementation


end.
