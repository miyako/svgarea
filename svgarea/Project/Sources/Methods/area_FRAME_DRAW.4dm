//%attributes = {"invisible":true}
C_LONGINT:C283($x)
C_LONGINT:C283($y)
C_LONGINT:C283($width)
C_LONGINT:C283($height)
ARRAY TEXT:C222($objects; 0)

area_RELEASE_OBJECTS

SVG GET ATTRIBUTE:C1056(*; "area"; "tool_99"; "x"; $x)
SVG GET ATTRIBUTE:C1056(*; "area"; "tool_99"; "y"; $y)
SVG GET ATTRIBUTE:C1056(*; "area"; "tool_99"; "width"; $width)
SVG GET ATTRIBUTE:C1056(*; "area"; "tool_99"; "height"; $height)

If (SVG Find element IDs by rect:C1109(*; "area"; $x; $y; $width; $height; $objects))
	
	var $i : Integer
	var $object; $handles : Text
	For ($i; 1; Size of array:C274($objects))
		$object:=$objects{$i}
		Form:C1466.selection.add($object)
		$handles:="hdl_"+$object
		SVG SET ATTRIBUTE:C1055(*; "area"; $handles; "visibility"; "visible")
	End for 
	
	Case of 
		: (Form:C1466.selection.values.length>1)
			Form:C1466.objects.index:=-1
			Form:C1466.selection.index:=-1
		: (Form:C1466.selection.values.length=1)
			Form:C1466.objects.currentValue:=Form:C1466.selection.currentValue
	End case 
	
End if 

Form:C1466.palette.update(Form:C1466.event; Form:C1466.objects; Form:C1466.area)