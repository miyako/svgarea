//%attributes = {"invisible":true}
If (Pasteboard data size:C400("com.4d.private.svg.object")>0)
	
	//need to reselect at the dom level before export
	
	var $handle; $item : Text
	For each ($item; Form:C1466.objects.values)
		$handle:="hdl_"+$item
		$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
		DOM SET XML ATTRIBUTE:C866($dom; "visibility"; "hidden")
	End for each 
	
	Form:C1466.selection.clear()
	
	var $data : Blob
	GET PASTEBOARD DATA:C401("com.4d.private.svg.object"; $data)
	
	var $objects : Collection
	BLOB TO VARIABLE:C533($data; $objects)
	
	var $xml; $dom; $newDom; $Txt_UID : Text
	For each ($xml; $objects)
		
		$dom:=DOM Parse XML variable:C720($xml)
		
		DOM REMOVE XML ATTRIBUTE:C1084($dom; "id")
		$newDom:=DOM Append XML element:C1082(Form:C1466.area.DOM; $dom)
		$Txt_UID:=area_NewUID($newDom)
		DOM SET XML ATTRIBUTE:C866($newDom; "id"; $Txt_UID)
		area_NEW_HANDLES($Txt_UID)
		
		Form:C1466.objects.add($Txt_UID)
		Form:C1466.selection.add($Txt_UID)
		
	End for each 
	
	Form:C1466.event.unselect().setCurrentTool("select").notifyContainer()
	Form:C1466.palette.update(Form:C1466.event; Form:C1466.objects; Form:C1466.area; True:C214)
	
	area_SET_PICTURE  //SVG SET ATTRIBUTE will not work until the picture is rendered on screen
	
	Form:C1466.area.showTools(True:C214)  //deferred
	
End if 