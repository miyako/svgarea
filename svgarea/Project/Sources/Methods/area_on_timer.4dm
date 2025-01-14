//%attributes = {"invisible":true}
Form:C1466.timer.update()

If (Form:C1466.timer._isMouseDown)
	
	Form:C1466.MouseX:=Form:C1466.timer.MouseX
	Form:C1466.MouseY:=Form:C1466.timer.MouseY
	
	Case of 
		: (Form:C1466.event.getCurrentTool()="select")
			
/*
transitional SVG; 
using SVG SET ATTRIBUTE, do not alter DOM
*/
			
			Case of 
				: (Form:C1466.event.isResizing)
					area_KEEP_RESIZING_OBJECTS(Form:C1466.ClickX; Form:C1466.ClickY; Form:C1466.MouseX; Form:C1466.MouseY)
				: (Form:C1466.event.isDrawing)
					TRACE:C157  //shoud not happen
				: (Form:C1466.event.isMoving)
					area_KEEP_MOVING_OBJECTS(Form:C1466.ClickX; Form:C1466.ClickY; Form:C1466.MouseX; Form:C1466.MouseY)
				: (Form:C1466.event.isSelecting)
					area_NEW_OBJECT("select"; On Mouse Move:K2:35)
					area_FRAME_DRAW
			End case 
			
		Else 
			
			Case of 
				: (Form:C1466.event.isResizing)
					TRACE:C157  //shoud not happen
				: (Form:C1466.event.isDrawing)
					area_NEW_OBJECT(Form:C1466.event.getCurrentTool(); On Mouse Move:K2:35)
				: (Form:C1466.event.isMoving)
					TRACE:C157  //shoud not happen
				: (Form:C1466.event.isSelecting)
					TRACE:C157  //shoud not happen
			End case 
			
	End case 
	
	If (Form:C1466.ClickX#Form:C1466.MouseX) && (Form:C1466.ClickY#Form:C1466.MouseY)
		Form:C1466.palette.update(Form:C1466.event; Form:C1466.objects; Form:C1466.area; False:C215)
	End if 
	
Else 
	
	Form:C1466.timer.stop().update()
	Form:C1466.MouseX:=Form:C1466.timer.MouseX
	Form:C1466.MouseY:=Form:C1466.timer.MouseY
	
	Case of 
		: (Form:C1466.event.getCurrentTool()="select")
			
			Case of 
				: (Form:C1466.event.isResizing)
					area_END_RESIZING_OBJECTS(Form:C1466.ClickX; Form:C1466.ClickY; Form:C1466.MouseX; Form:C1466.MouseY)
					area_SET_CURSOR
				: (Form:C1466.event.isDrawing)
					TRACE:C157  //shoud not happen
				: (Form:C1466.event.isMoving)
					area_END_MOVING_OBJECTS(Form:C1466.ClickX; Form:C1466.ClickY; Form:C1466.MouseX; Form:C1466.MouseY)
					area_SET_CURSOR
				: (Form:C1466.event.isSelecting)
					area_FRAME_DRAW
					area_FRAME_CLEAR
			End case 
			
		Else 
			
			Case of 
				: (Form:C1466.event.isResizing)
					TRACE:C157  //shoud not happen
				: (Form:C1466.event.isDrawing)
					area_NEW_OBJECT(Form:C1466.event.getCurrentTool(); On Mouse Move:K2:35)
					Form:C1466.event.select(area_ADD_TO_SVG(Form:C1466.event.getCurrentTool()))
				: (Form:C1466.event.isMoving)
					TRACE:C157  //shoud not happen
				: (Form:C1466.event.isSelecting)
					TRACE:C157  //shoud not happen
			End case 
			
	End case 
	
	Form:C1466.event.setCurrentTool("select")
	
	If (Form:C1466.ClickX#Form:C1466.MouseX) && (Form:C1466.ClickY#Form:C1466.MouseY)
		Form:C1466.event.notifyContainer()  //mouse move&mouse up
		Form:C1466.palette.update(Form:C1466.event; Form:C1466.objects; Form:C1466.area; True:C214)
	End if 
	
End if 