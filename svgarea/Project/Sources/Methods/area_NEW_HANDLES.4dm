//%attributes = {"invisible":true}
#DECLARE($Txt_ID : Text)

var $dom : Text
$dom:=Form:C1466.area.DOM

C_TEXT:C284($Txt_Dom_Current; $Txt_Dom_group; $Txt_Dom_object; $Txt_Dom_template; $Txt_currentsHandles)
C_TEXT:C284($Txt_handleID; $Txt_ID)

var $objectDom; $objectType : Text
$objectDom:=DOM Find XML element by ID:C1010($dom; $Txt_ID)
DOM GET XML ELEMENT NAME:C730($objectDom; $objectType)

var $x; $y; $width; $height : Real
var $x1; $y1; $x2; $y2 : Real
var $cx; $cy; $rx; $ry : Real

Case of 
	: ($objectType="line")
		
		DOM GET XML ATTRIBUTE BY NAME:C728($objectDom; "x1"; $x1)
		DOM GET XML ATTRIBUTE BY NAME:C728($objectDom; "y1"; $y1)
		DOM GET XML ATTRIBUTE BY NAME:C728($objectDom; "x2"; $x2)
		DOM GET XML ATTRIBUTE BY NAME:C728($objectDom; "y2"; $y2)
		
	: ($objectType="rect") || ($objectType="round") || ($objectType="textArea") || ($objectType="image")
		
		DOM GET XML ATTRIBUTE BY NAME:C728($objectDom; "x"; $x)
		DOM GET XML ATTRIBUTE BY NAME:C728($objectDom; "y"; $y)
		DOM GET XML ATTRIBUTE BY NAME:C728($objectDom; "width"; $width)
		DOM GET XML ATTRIBUTE BY NAME:C728($objectDom; "height"; $height)
		
	: ($objectType="ellipse")
		
		DOM GET XML ATTRIBUTE BY NAME:C728($objectDom; "cx"; $cx)
		DOM GET XML ATTRIBUTE BY NAME:C728($objectDom; "cy"; $cy)
		DOM GET XML ATTRIBUTE BY NAME:C728($objectDom; "rx"; $rx)
		DOM GET XML ATTRIBUTE BY NAME:C728($objectDom; "ry"; $ry)
		
		$x:=$cx-$rx
		$y:=$cy-$ry
		$width:=($rx*2)
		$height:=($ry*2)
		
End case 

ARRAY TEXT:C222($tTxt_handleNames; 8)
$tTxt_handleNames{1}:="handle_tl"
$tTxt_handleNames{2}:="handle_tm"
$tTxt_handleNames{3}:="handle_tr"
$tTxt_handleNames{4}:="handle_ml"
$tTxt_handleNames{5}:="handle_mr"
$tTxt_handleNames{6}:="handle_bl"
$tTxt_handleNames{7}:="handle_bm"
$tTxt_handleNames{8}:="handle_br"

$Txt_currentsHandles:="hdl_"+$Txt_ID

$Txt_Dom_group:=DOM Find XML element by ID:C1010($dom; "Handles")
$Txt_Dom_Current:=DOM Create XML element:C865($Txt_Dom_group; "g"; "id"; $Txt_currentsHandles)
DOM SET XML ATTRIBUTE:C866($Txt_Dom_Current; "visibility"; "visible")

var $i : Integer
For ($i; 1; 8)
	$Txt_Dom_template:=DOM Find XML element by ID:C1010($dom; $tTxt_handleNames{$i})
	$Txt_Dom_object:=DOM Append XML element:C1082($Txt_Dom_Current; $Txt_Dom_template)
	$Txt_handleID:=$tTxt_handleNames{$i}+"_"+$Txt_ID
	DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "id"; $Txt_handleID)
	
	Case of 
		: ($objectType="line")
			Case of 
				: ($i=1)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; $x1; "cy"; $y1; "editor:cx"; $x1; "editor:cy"; $y1)
				: ($i=2)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; 0; "cy"; 0; "editor:cx"; 0; "editor:cy"; 0; "visibility"; "hidden")
				: ($i=3)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; 0; "cy"; 0; "editor:cx"; 0; "editor:cy"; 0; "visibility"; "hidden")
				: ($i=4)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; 0; "cy"; 0; "editor:cx"; 0; "editor:cy"; 0; "visibility"; "hidden")
				: ($i=5)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; 0; "cy"; 0; "editor:cx"; 0; "editor:cy"; 0; "visibility"; "hidden")
				: ($i=6)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; 0; "cy"; 0; "editor:cx"; 0; "editor:cy"; 0; "visibility"; "hidden")
				: ($i=7)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; 0; "cy"; 0; "editor:cx"; 0; "editor:cy"; 0; "visibility"; "hidden")
				: ($i=8)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; $x2; "cy"; $y2; "editor:cx"; $x2; "editor:cy"; $y2)
			End case 
		: ($objectType="rect") || ($objectType="round") || ($objectType="textArea") || ($objectType="image")
			
			Case of 
				: ($i=1)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; $x; "cy"; $y; "editor:cx"; $x; "editor:cy"; $y)
				: ($i=2)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; $x+($width/2); "cy"; $y; "editor:cx"; $x+($width/2); "editor:cy"; $y)
				: ($i=3)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; $x+$width; "cy"; $y; "editor:cx"; $x+$width; "editor:cy"; $y)
				: ($i=4)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; $x; "cy"; $y+($height/2); "editor:cx"; $x; "editor:cy"; $y+($height/2))
				: ($i=5)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; $x+$width; "cy"; $y+($height/2); "editor:cx"; $x+$width; "editor:cy"; $y+($height/2))
				: ($i=6)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; $x; "cy"; $y+$height; "editor:cx"; $x; "editor:cy"; $y+$height)
				: ($i=7)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; $x+($width/2); "cy"; $y+$height; "editor:cx"; $x+($width/2); "editor:cy"; $y+$height)
				: ($i=8)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; $x+$width; "cy"; $y+$height; "editor:cx"; $x+$width; "editor:cy"; $y+$height)
			End case 
		: ($objectType="ellipse")
			Case of 
				: ($i=1)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; $x; "cy"; $y; "editor:cx"; $x; "editor:cy"; $y)
				: ($i=2)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; $x+($width/2); "cy"; $y; "editor:cx"; $x+($width/2); "editor:cy"; $y)
				: ($i=3)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; $x+$width; "cy"; $y; "editor:cx"; $x+$width; "editor:cy"; $y)
				: ($i=4)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; $x; "cy"; $y+($height/2); "editor:cx"; $x; "editor:cy"; $y+($height/2))
				: ($i=5)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; $x+$width; "cy"; $y+($height/2); "editor:cx"; $x+$width; "editor:cy"; $y+($height/2))
				: ($i=6)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; $x; "cy"; $y+$height; "editor:cx"; $x; "editor:cy"; $y+$height)
				: ($i=7)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; $x+($width/2); "cy"; $y+$height; "editor:cx"; $x+($width/2); "editor:cy"; $y+$height)
				: ($i=8)
					DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "cx"; $x+$width; "cy"; $y+$height; "editor:cx"; $x+$width; "editor:cy"; $y+$height)
			End case 
	End case 
	
End for 