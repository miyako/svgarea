//%attributes = {"invisible":true}
#DECLARE($dom : Text)

Case of 
	: ($dom="")  //do nothing
	: ($dom=Form:C1466.area.DOM)  // do nothing either (the DOM reference has not changed
		
	Else 
		var $root : Text
		$root:=DOM Get root XML element:C1053($dom)
		If (OK=1)
			var $element : Text
			$element:=DOM Find XML element:C864($dom; "/svg")
			If (OK=1)
				Form:C1466.SVG:=Form:C1466.area.replaceDOM($dom)
				Form:C1466.objects.clear()
				Form:C1466.selection.clear()
				Form:C1466.event.unselect().setCurrentTool("select").notifyContainer()
				Form:C1466.area.setCounter(0).scanObjects(True:C214)  //deferred
			End if 
		End if 
		
End case 