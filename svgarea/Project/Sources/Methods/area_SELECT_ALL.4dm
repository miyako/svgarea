//%attributes = {"invisible":true}
area_RELEASE_OBJECTS

If (Form:C1466.objects.length#0)
	
	var $object; $handles : Text
	For each ($object; Form:C1466.objects.values)
		Form:C1466.selection.add($object)
		$handles:="hdl_"+$object
		SVG SET ATTRIBUTE:C1055(*; "area"; $handles; "visibility"; "visible")
	End for each 
	
	Case of 
		: (Form:C1466.selection.values.length>1)
			Form:C1466.objects.index:=-1
			Form:C1466.selection.index:=-1
		: (Form:C1466.selection.values.length=1)
			Form:C1466.objects.currentValue:=Form:C1466.selection.currentValue
	End case 
	
	Form:C1466.palette.update(Form:C1466.event; Form:C1466.objects; Form:C1466.area)
	
End if 

Form:C1466.area.showTools()
Form:C1466.event.setCurrentTool("select")
//no need to notify host here