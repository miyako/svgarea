//%attributes = {"invisible":true}
If (Form:C1466.selection.values.length#0)
	
	var $handles; $item; $dom : Text
	For each ($item; Form:C1466.selection.values)
		Form:C1466.objects.remove($item)
		$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
		DOM REMOVE XML ELEMENT:C869($dom)
		$handles:="hdl_"+$item
		$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handles)
		DOM REMOVE XML ELEMENT:C869($dom)
	End for each 
	
	Form:C1466.selection.clear()
	
	Form:C1466.event.unselect().setCurrentTool("select").notifyContainer()
	Form:C1466.palette.update(Form:C1466.event; Form:C1466.objects; Form:C1466.area)  //document unchanged, no need to use DOM
	
	area_SET_PICTURE  //SVG SET ATTRIBUTE will not work until the picture is rendered on screen
	
	Form:C1466.area.showTools(True:C214)  //deferred
	
End if 