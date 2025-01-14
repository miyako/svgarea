If (FORM Event:C1606.code=On Clicked:K2:4) || (FORM Event:C1606.code=On Data Change:K2:15)
	
	Case of 
		: (Form:C1466.area.grid<10)
			Form:C1466.area.grid:=10
		: (Form:C1466.area.grid>100)
			Form:C1466.area.grid:=100
	End case 
	
	CALL FORM:C1391(Form:C1466.window; Form:C1466.properties.setGrid; Form:C1466.area.grid)
	
End if 
