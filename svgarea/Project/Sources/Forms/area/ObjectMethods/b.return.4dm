If (FORM Event:C1606.code=On Clicked:K2:4)
	
	Case of 
		: (Form:C1466.selection.values.length=1) && (Form:C1466.selection.values[0]="image_@")
			If (area_Import_image(Form:C1466.selection.values[0]))
				area_SET_PICTURE  //SVG SET ATTRIBUTE will not work until the picture is rendered on screen
				Form:C1466.area.showTools(True:C214)  //deferred
				Form:C1466.event.notifyContainer()
			End if 
			
		: (Form:C1466.selection.values.length=1) && (Form:C1466.selection.values[0]="textArea_@")
			If (area_Text_edit(Form:C1466.selection.values[0]))
				area_SET_PICTURE
				Form:C1466.event.notifyContainer()
			End if 
			
	End case 
	
End if 