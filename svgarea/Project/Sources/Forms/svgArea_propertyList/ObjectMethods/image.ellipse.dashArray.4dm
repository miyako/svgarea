If (FORM Event:C1606.code=On Clicked:K2:4)
	
	var $select : Object
	$select:=area_Choose_dasharray(Form:C1466.dashArray; Form:C1466.dasharray.values)
	
	If ($select#Null:C1517)
		Form:C1466.dashArray:=$select.dashArray
		OBJECT SET VALUE:C1742("image.ellipse.dashArray"; Form:C1466.dasharray.getPicture(Form:C1466.dashArray))
		CALL FORM:C1391(Form:C1466.window; Form:C1466.properties.setProperty; "stroke-dasharray"; Form:C1466.dashArray)
	End if 
	
End if 