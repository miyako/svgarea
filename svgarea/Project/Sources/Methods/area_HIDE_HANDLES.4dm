//%attributes = {"invisible":true}
var $item; $dom; $handle : Text

/*
last created object has visible handles
see area_NEW_HANDLES
*/

For each ($item; Form:C1466.objects.values)
	$handle:="hdl_"+$item
	$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
	DOM SET XML ATTRIBUTE:C866($dom; "visibility"; "hidden")
End for each 