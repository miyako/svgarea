If (FORM Event:C1606.code=On Clicked:K2:4)
	
	If (Not:C34(Is compiled mode:C492))
		
		var $dom : Text
		$dom:=Form:C1466.area.export()
		SVGTool_SHOW_IN_VIEWER($dom)
		WRAP_DOM_CLOSE_XML($dom)
		
	End if 
	
End if 