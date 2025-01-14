//%attributes = {"invisible":true}
var $item : Text
$item:=Form:C1466.event.clickedObjectId
If ($item#"")
	Form:C1466.selection.add($item)
	var $item; $handles : Text
	For each ($item; Form:C1466.selection.values)
		$handles:="hdl_"+$item
		SVG SET ATTRIBUTE:C1055(*; "area"; $handles; "visibility"; "visible")
	End for each 
	Case of 
		: (Form:C1466.selection.values.length=1)
			Form:C1466.objects.currentValue:=Form:C1466.selection.currentValue
		Else 
			Form:C1466.objects.index:=-1
	End case 
	Form:C1466.area.showTools()
End if 

Form:C1466.palette.update(Form:C1466.event; Form:C1466.objects; Form:C1466.area)