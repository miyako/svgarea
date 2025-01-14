//%attributes = {"invisible":true}
DOM SET XML ATTRIBUTE:C866(Form:C1466.area.DOM; "width"; Form:C1466.area.width)
DOM SET XML ATTRIBUTE:C866(Form:C1466.area.DOM; "height"; Form:C1466.area.height)
DOM SET XML ATTRIBUTE:C866(Form:C1466.area.DOM; "viewBox"; "0 0 "+String:C10(Form:C1466.area.width)+" "+String:C10(Form:C1466.area.height))

var $grid : Text
$grid:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; "grid")

If (OK=1)
	
	var $dom : Text
	$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; "verticalLine")
	DOM SET XML ATTRIBUTE:C866($dom; "y2"; Form:C1466.area.height)
	DOM SET XML ATTRIBUTE:C866($dom; "stroke-width"; Form:C1466.area.width*2)
	
	$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; "horizontalLine")
	DOM SET XML ATTRIBUTE:C866($dom; "x2"; Form:C1466.area.width)
	DOM SET XML ATTRIBUTE:C866($dom; "stroke-width"; Form:C1466.area.height*2)
	
End if 