If (FORM Event:C1606.code=On Data Change:K2:15) || (FORM Event:C1606.code=On Clicked:K2:4)
	
	CALL FORM:C1391(Form:C1466.window; Form:C1466.properties.setDocumentProperty; "viewport-fill-opacity"; Form:C1466.viewportFillOpacity/100)
	
End if 