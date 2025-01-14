If (FORM Event:C1606.code=On Clicked:K2:4)
	
	var $preserveAspectRatio : Text
	$preserveAspectRatio:=Form:C1466.preserveAspectRatio.currentValue
	
	Case of 
		: (Form:C1466.meet)
			$preserveAspectRatio+=" meet"
		: (Form:C1466.slice)
			$preserveAspectRatio+=" slice"
	End case 
	
	CALL FORM:C1391(Form:C1466.window; Form:C1466.properties.setProperty; "preserveAspectRatio"; $preserveAspectRatio)
	
End if 