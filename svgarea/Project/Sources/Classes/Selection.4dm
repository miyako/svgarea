Class extends Objects

Class constructor
	
	Super:C1705()
	
	This:C1470.updateButtons()
	
Function add($object : Text) : cs:C1710.Selection
	
	Super:C1706.add($object)
	This:C1470.updateButtons()
	
	return This:C1470
	
Function clear() : cs:C1710.Selection
	
	Super:C1706.clear()
	This:C1470.updateButtons()
	
	return This:C1470
	
Function updateButtons() : cs:C1710.Area
	
	Case of 
		: (This:C1470.values.length>1)
			OBJECT SET ENABLED:C1123(*; "b.align"; True:C214)
		: (This:C1470.values.length=1)
			OBJECT SET ENABLED:C1123(*; "b.align"; False:C215)
		: (This:C1470.values.length=0)
			OBJECT SET ENABLED:C1123(*; "b.align"; False:C215)
	End case 
	
	Case of 
		: (This:C1470.values.length#0) && (Form:C1466.objects.values.length>1)
			OBJECT SET ENABLED:C1123(*; "b.level"; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(*; "b.level"; False:C215)
	End case 
	
	return This:C1470