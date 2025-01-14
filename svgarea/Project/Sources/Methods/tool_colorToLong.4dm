//%attributes = {"invisible":true}
#DECLARE($color : Text) : Integer

ARRAY LONGINT:C221($pos; 0)
ARRAY LONGINT:C221($len; 0)

Case of 
	: (Match regex:C1019("rgb\\((\\d+),(\\d+),(\\d+)\\)"; $color; 1; $pos; $len))
		
		var $r; $g; $b : Integer
		$r:=Num:C11(Substring:C12($color; $pos{1}; $len{1}))
		$g:=Num:C11(Substring:C12($color; $pos{2}; $len{2}))
		$b:=Num:C11(Substring:C12($color; $pos{3}; $len{3}))
		
		return ($r << 16)+($g << 8)+$b
		
	: (Match regex:C1019("#([:hex_digit:]{6})"; $color; 1; $pos; $len))
		
		return Formula from string:C1601("0x"+Substring:C12($color; $pos{1}; $len{1})).call()
		
	: (Match regex:C1019("#([:hex_digit:]{3})"; $color; 1; $pos; $len))
		
		var $hex : Text
		$hex:=Substring:C12($color; $pos{1}; $len{1})
		
		return Formula from string:C1601("0x"+($hex[[1]]*2)+($hex[[2]]*2)+($hex[[3]]*2)).call()
		
	: ($color="white")  //for compatibility
		
		return 0x00FFFFFF
		
End case 

return 0