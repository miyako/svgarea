//%attributes = {"invisible":true}
#DECLARE($color : Integer) : Text

var $r; $g; $b : Integer
$r:=$color & 0x00FF0000 >> 16
$g:=$color & 0xFF00 >> 8
$b:=$color & 0x00FF

return "rgb("+String:C10($r)+","+String:C10($g)+","+String:C10($b)+")"