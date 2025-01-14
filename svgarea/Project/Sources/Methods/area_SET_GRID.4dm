//%attributes = {"invisible":true}
var $grid : Text
$grid:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; "grid")

If (OK=1)
	
	var $dashArray : Text
	$dashArray:="1,"+String:C10(Form:C1466.area.grid-1)
	
	var $dom : Text
	$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; "verticalLine")
	DOM SET XML ATTRIBUTE:C866($dom; "stroke-dasharray"; $dashArray)
	
	$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; "horizontalLine")
	DOM SET XML ATTRIBUTE:C866($dom; "stroke-dasharray"; $dashArray)
	
	
End if 