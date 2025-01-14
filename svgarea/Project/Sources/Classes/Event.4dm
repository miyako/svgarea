property isResizing : Boolean
property isDrawing : Boolean
property isSelecting : Boolean
property isMoving : Boolean
property hoveredObjectId : Text
property clickedObjectId : Text
property touched : Boolean  //Boo_ModifiedBySubform

Class constructor
	
	This:C1470._isResizing:=False:C215
	This:C1470._isDrawing:=False:C215
	This:C1470._clickedObjectId:=""
	This:C1470._hoveredObjectId:=""
	This:C1470._touched:=False:C215
	
Function get touched() : Boolean
	
	return This:C1470._touched
	
Function untouch() : cs:C1710.Event
	
	This:C1470._touched:=False:C215
	
	return This:C1470
	
Function get isResizing() : Boolean
	
	return This:C1470._isResizing
	
Function get isDrawing() : Boolean
	
	return This:C1470._isDrawing
	
Function get isSelecting() : Boolean
	
	return (This:C1470.isResizing=False:C215) && (This:C1470.isDrawing=False:C215) && (This:C1470.clickedObjectId="")
	
Function get isMoving() : Boolean
	
	return (This:C1470.isResizing=False:C215) && (This:C1470.isDrawing=False:C215) && (This:C1470.clickedObjectId#"")
	
Function get clickedObjectId() : Text
	
	return This:C1470._clickedObjectId
	
Function get hoveredObjectId() : Text
	
	return This:C1470._hoveredObjectId
	
Function notifyContainer() : cs:C1710.Event
	
	var $container : Variant
	$container:=OBJECT Get subform container value:C1785
	var $type : Integer
	$type:=Value type:C1509($container)
	
	Case of 
		: ($type=Is picture:K8:10)
			
			This:C1470._touched:=True:C214  //to avoid infinite loops
			
			OBJECT SET SUBFORM CONTAINER VALUE:C1784(Form:C1466.area.exportPicture())
			
		: ($type=Is text:K8:3)
			
			This:C1470._touched:=True:C214  //to avoid infinite loops
			
			OBJECT SET SUBFORM CONTAINER VALUE:C1784(Form:C1466.area.DOM)
			
	End case 
	
	return This:C1470
	
Function updateForDragOver() : cs:C1710.Event
	
	var $mouseX; $mouseY; $mouseB : Integer
	GET MOUSE:C468($mouseX; $mouseY; $mouseB; *)
	CONVERT COORDINATES:C1365($mouseX; $mouseY; XY Screen:K27:7; XY Current form:K27:5)
	
	var $x; $y; $right; $bottom : Integer
	OBJECT GET COORDINATES:C663(*; "area"; $x; $y; $right; $bottom)
	
	$mouseX-=$x
	$mouseY-=$y
	
	This:C1470._hoveredObjectId:=SVG Find element ID by coordinates:C1054(*; "area"; $mouseX; $mouseY)
	
	return This:C1470
	
Function update() : cs:C1710.Event
	
	var $scrollX; $scrollY : Integer
	OBJECT GET SCROLL POSITION:C1114(*; "area"; $scrollY; $scrollX)
	
	var $clickedObjectId : Text
	$clickedObjectId:=SVG Find element ID by coordinates:C1054(*; "area"; Form:C1466.MouseX+$scrollX; Form:C1466.MouseY+$scrollY)
	
	Case of 
		: ($clickedObjectId="tool_@")
			This:C1470._clickedObjectId:=""
		: ($clickedObjectId="horizontalLine")
			This:C1470._clickedObjectId:=""
		: ($clickedObjectId="verticalLine")
			This:C1470._clickedObjectId:=""
			
		Else 
			This:C1470._clickedObjectId:=$clickedObjectId
	End case 
	
	return This:C1470
	
Function select($object : Text) : cs:C1710.Event
	
	This:C1470._clickedObjectId:=$object
	
	return This:C1470
	
Function unselect() : cs:C1710.Event
	
	This:C1470._clickedObjectId:=""
	This:C1470._hoveredObjectId:=""
	
	return This:C1470
	
Function setCurrentTool($tool : Text) : cs:C1710.Event
	
	var $tools : Collection
	$tools:=["Tool_1"; "Tool_2"; "Tool_3"; "Tool_4"; "Tool_5"; "Tool_6"; "Tool_7"; "Tool_8"]
	var $_tool : Text
	For each ($_tool; $tools)
		Form:C1466[$_tool]:=False:C215
	End for each 
	
	Case of 
		: ($tool="select")
			Form:C1466.Tool_1:=True:C214
		: ($tool="line")
			Form:C1466.Tool_2:=True:C214
		: ($tool="rect")
			Form:C1466.Tool_3:=True:C214
		: ($tool="round")
			Form:C1466.Tool_4:=True:C214
		: ($tool="ellipse")
			Form:C1466.Tool_5:=True:C214
		: ($tool="text")
			Form:C1466.Tool_6:=True:C214
		: ($tool="image")
			Form:C1466.Tool_7:=True:C214
	End case 
	
	return This:C1470
	
Function getCurrentTool() : Text
	
	Case of 
		: (Form:C1466.Tool_1)
			
			This:C1470._isDrawing:=False:C215
			This:C1470._isResizing:=(This:C1470.clickedObjectId="handle_@")
			
			return "select"
			
		: (Form:C1466.Tool_2)
			
			This:C1470._isDrawing:=True:C214
			This:C1470._isResizing:=False:C215
			
			return "line"
			
		: (Form:C1466.Tool_3)
			
			This:C1470._isDrawing:=True:C214
			This:C1470._isResizing:=False:C215
			
			return "rect"
			
		: (Form:C1466.Tool_4)
			
			This:C1470._isDrawing:=True:C214
			This:C1470._isResizing:=False:C215
			
			return "round"
			
		: (Form:C1466.Tool_5)
			
			This:C1470._isDrawing:=True:C214
			This:C1470._isResizing:=False:C215
			
			return "ellipse"
			
		: (Form:C1466.Tool_6)
			
			This:C1470._isDrawing:=True:C214
			This:C1470._isResizing:=False:C215
			
			return "text"
			
		: (Form:C1466.Tool_7)
			
			This:C1470._isDrawing:=True:C214
			This:C1470._isResizing:=False:C215
			
			return "image"
			
	End case 