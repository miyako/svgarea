If (FORM Event:C1606.code=On Clicked:K2:4)
	
	$RGB:=tool_colorToLong(Form:C1466.viewportFill)
	
	var $RGB : Integer
	$RGB:=Select RGB color:C956($RGB)
	
	If (OK=1)
		OBJECT SET RGB COLORS:C628(*; "rect.document.viewportFill"; $RGB; $RGB)
		Form:C1466.viewportFill:=tool_longToColor($RGB)
		CALL FORM:C1391(Form:C1466.window; Form:C1466.properties.setDocumentProperty; "viewport-fill"; Form:C1466.viewportFill)
	End if 
	
End if 