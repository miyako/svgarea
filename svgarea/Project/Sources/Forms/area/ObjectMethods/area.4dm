var $e : Object

$e:=FORM Event:C1606

Case of 
	: ($e.code=On Clicked:K2:4) && (Contextual click:C713)
		
		Form:C1466.timer.update()
		Form:C1466.MouseX:=Form:C1466.timer.MouseX
		Form:C1466.MouseY:=Form:C1466.timer.MouseY
		Form:C1466.ClickX:=Form:C1466.MouseX
		Form:C1466.ClickY:=Form:C1466.MouseY
		Form:C1466.event.update()
		
		area_CONTEXTUAL_MENU
		
	: ($e.code=On Clicked:K2:4)
		
		Form:C1466.timer.start().update()
		Form:C1466.MouseX:=Form:C1466.timer.MouseX
		Form:C1466.MouseY:=Form:C1466.timer.MouseY
		Form:C1466.ClickX:=Form:C1466.MouseX
		Form:C1466.ClickY:=Form:C1466.MouseY
		Form:C1466.event.update()
		
		If (area_CALLBACK(On Clicked:K2:4; Form:C1466.event.clickedObjectId)<0)
			return 
		End if 
		
		area_SET_CURSOR(Form:C1466.event.clickedObjectId)
		
		Case of 
			: (Form:C1466.event.getCurrentTool()="select")
				
				Case of 
					: (Form:C1466.event.isResizing)
						//object are already selected
						area_START_RESIZING_OBJECTS
					: (Form:C1466.event.isDrawing)
						TRACE:C157  //shoud not happen
					: (Form:C1466.event.isMoving)
						If (Not:C34(Shift down:C543))
							area_RELEASE_OBJECTS
						End if 
						area_SELECT_OBJECT
						area_START_MOVING_OBJECTS
					: (Form:C1466.event.isSelecting)
						area_RELEASE_OBJECTS
						area_NEW_OBJECT("select"; On Clicked:K2:4)
				End case 
				
			Else 
				
				Case of 
					: (Form:C1466.event.isResizing)
						TRACE:C157  //shoud not happen
					: (Form:C1466.event.isDrawing)
						area_RELEASE_OBJECTS
						area_NEW_OBJECT(Form:C1466.event.getCurrentTool(); On Clicked:K2:4)
					: (Form:C1466.event.isMoving)
						TRACE:C157  //shoud not happen
					: (Form:C1466.event.isSelecting)
						TRACE:C157  //shoud not happen
				End case 
				
		End case 
		
	: ($e.code=On Double Clicked:K2:5)
		
		If (area_CALLBACK(On Double Clicked:K2:5; Form:C1466.event.clickedObjectId)<0)
			return 
		End if 
		
		Form:C1466.palette.activate(Form:C1466.event; Form:C1466.objects; Form:C1466.area)
		
	: ($e.code=On Drag Over:K2:13)
		
		Form:C1466.event.updateForDragOver()
		
		If (Form:C1466.event.hoveredObjectId="image_@")
			return 0
		Else 
			return -1
		End if 
		
	: ($e.code=On Drop:K2:12)
		
		If (area_CALLBACK(On Double Clicked:K2:5; Form:C1466.event.hoveredObjectId)<0)
			return 
		End if 
		
		If (area_ON_DROP(Form:C1466.event.hoveredObjectId))
			
			area_RELEASE_OBJECTS
			Form:C1466.event.select(Form:C1466.event.hoveredObjectId)
			area_SELECT_OBJECT
			
			area_SET_PICTURE  //SVG SET ATTRIBUTE will not work until the picture is rendered on screen
			Form:C1466.area.showTools(True:C214)  //deferred
			
			Form:C1466.event.setCurrentTool("select")
			Form:C1466.event.notifyContainer()
		End if 
		
End case 
