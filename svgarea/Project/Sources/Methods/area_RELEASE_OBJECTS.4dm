//%attributes = {"invisible":true}
var $item; $Txt_currentsHandles : Text

For each ($item; Form:C1466.selection.values)
	$Txt_currentsHandles:="hdl_"+$item
	SVG SET ATTRIBUTE:C1055(*; "area"; $Txt_currentsHandles; "visibility"; "hidden")
End for each 

Form:C1466.selection.clear()
Form:C1466.objects.index:=-1