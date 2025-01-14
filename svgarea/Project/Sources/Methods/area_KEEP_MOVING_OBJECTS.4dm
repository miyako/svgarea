//%attributes = {"invisible":true}
#DECLARE($ClickX : Integer; $ClickY : Integer; $MouseX : Integer; $MouseY : Integer)

var $type : Text
var $x1; $y1; $x2; $y2 : Real
var $cx; $cy; $x; $y : Real
var $r : Real  //for future extension
var $sx : Real  //for future extension
var $sy : Real  //for future extension

$r:=0
$sx:=1
$sy:=1

var $moveX; $moveY : Integer
$moveX:=$MouseX-$ClickX
$moveY:=$MouseY-$ClickY

var $offsetX; $offsetY : Real
$offsetX:=Num:C11(String:C10((Cos:C18(($r)*Degree:K30:2)*$moveX)+(Sin:C17(($r)*Degree:K30:2)*$moveY)))*$sx
$offsetY:=Num:C11(String:C10((Cos:C18(($r)*Degree:K30:2)*$moveY)+(-Sin:C17(($r)*Degree:K30:2)*$moveX)))*$sy

var $handles : Collection
$handles:=["handle_tl"; "handle_tm"; "handle_tr"; "handle_ml"; "handle_mr"; "handle_bl"; "handle_bm"; "handle_br"]
var $handle : Text
var $item : Text

For each ($item; Form:C1466.selection.values)
	
	For each ($handle; $handles)
		$handle:=$handle+"_"+$item
		SVG GET ATTRIBUTE:C1056(*; "area"; $handle; "editor:cx"; $cx)
		SVG GET ATTRIBUTE:C1056(*; "area"; $handle; "editor:cy"; $cy)
		SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $cx+$offsetX)
		SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cy"; $cy+$offsetY)
	End for each 
	
	SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:type"; $type)
	
	Case of 
		: ($type="line")
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x1"; $x1)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y1"; $y1)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x2"; $x2)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y2"; $y2)
			SVG SET ATTRIBUTE:C1055(*; "area"; $item; "x1"; $x1+$offsetX)
			SVG SET ATTRIBUTE:C1055(*; "area"; $item; "y1"; $y1+$offsetY)
			SVG SET ATTRIBUTE:C1055(*; "area"; $item; "x2"; $x2+$offsetX)
			SVG SET ATTRIBUTE:C1055(*; "area"; $item; "y2"; $y2+$offsetY)
		: ($type="rect") || ($type="text") || ($type="image")
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x"; $x)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y"; $y)
			SVG SET ATTRIBUTE:C1055(*; "area"; $item; "x"; $x+$offsetX)
			SVG SET ATTRIBUTE:C1055(*; "area"; $item; "y"; $y+$offsetY)
		: ($type="ellipse")
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:cx"; $cx)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:cy"; $cy)
			SVG SET ATTRIBUTE:C1055(*; "area"; $item; "cx"; $cx+$offsetX)
			SVG SET ATTRIBUTE:C1055(*; "area"; $item; "cy"; $cy+$offsetY)
	End case 
	
End for each 