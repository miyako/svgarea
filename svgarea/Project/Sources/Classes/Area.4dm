property counter : Integer  //Lon_counter_UID
property DOM : Text  //Txt_DomAreaPicture
property grid : Integer  //Lon_gridOffset
property isGridVisible : Boolean  //<>bgrid
property height : Integer  //area_Num_height
property width : Integer  //area_Num_width

Class constructor
	
	This:C1470._counter:=0
	This:C1470._DOM:=""
	This:C1470._grid:=20
	This:C1470.isGridVisible:=False:C215
	
Function get counter() : Integer
	
	return This:C1470._counter
	
Function get DOM() : Text
	
	return This:C1470._DOM
	
Function get grid() : Integer
	
	return This:C1470._grid
	
Function setCounter($counter : Integer) : cs:C1710.Area
	
	This:C1470._counter:=$counter
	
	return This:C1470
	
Function replaceDOM($DOM : Text) : Picture
	
	WRAP_DOM_CLOSE_XML(This:C1470.DOM)  //close current
	This:C1470.setDOM($dom)
	
	var $width; $height : Integer
	DOM GET XML ATTRIBUTE BY NAME:C728($dom; "width"; $width)
	DOM GET XML ATTRIBUTE BY NAME:C728($dom; "height"; $height)
	Form:C1466.area.width:=$width
	Form:C1466.area.height:=$height
	
	area_DRAW_GRID($dom)
	
	area_INIT_OBJECTS_TOOLS($dom)
	area_CREATE_ALL_HANDLES($dom)
	
	var $SVG : Picture
	SVG EXPORT TO PICTURE:C1017(This:C1470.DOM; $SVG; Get XML data source:K45:16)  //the source is useless in the component
	
	return $SVG
	
Function setDOM($DOM : Text) : cs:C1710.Area
	
	This:C1470._DOM:=$DOM
	
	return This:C1470
	
Function setGrid($grid : Integer) : cs:C1710.Area
	
	This:C1470._grid:=$grid
	
	return This:C1470
	
Function setSize($width : Integer; $height : Integer) : cs:C1710.Area
	
	This:C1470.width:=$width
	This:C1470.height:=$height
	
	return This:C1470
	
Function _scanObjects()
	
	C_LONGINT:C283($width)
	C_LONGINT:C283($height)
	ARRAY TEXT:C222($objects; 0)
	PICTURE PROPERTIES:C457(Form:C1466.SVG; $width; $height)
	
	If (SVG Find element IDs by rect:C1109(*; "area"; 0; 0; $width; $height; $objects))
		var $i : Integer
		var $object; $handles : Text
		For ($i; 1; Size of array:C274($objects))
			$object:=$objects{$i}
			Form:C1466.objects.add($object)
			$handles:="hdl_"+$object
			SVG SET ATTRIBUTE:C1055(*; "area"; $handles; "visibility"; "hidden")
		End for 
	End if 
	
	Form:C1466.objects.index:=-1
	Form:C1466.palette.update(Form:C1466.event; Form:C1466.objects; Form:C1466.area)
	
Function scanObjects($deferred : Boolean)
	
	If ($deferred)
		CALL FORM:C1391(Current form window:C827; Formula:C1597(call_subform); This:C1470._scanObjects)
	Else 
		This:C1470._scanObjects()
	End if 
	
Function _hideTools()
	
	SVG SET ATTRIBUTE:C1055(*; "area"; "svgAreaTools"; "4D-bringToFront"; "true"; "visibility"; "hidden")
	SVG SET ATTRIBUTE:C1055(*; "area"; "Handles"; "4D-bringToFront"; "true"; "visibility"; "hidden")
	
	Form:C1466.area._updateGrid()
	
Function hideTools($deferred : Boolean)
	
	If ($deferred)
		CALL FORM:C1391(Current form window:C827; Formula:C1597(call_subform); This:C1470._hideTools)
	Else 
		This:C1470._hideTools()
	End if 
	
Function _hideGrid()
	
	SVG SET ATTRIBUTE:C1055(*; "area"; "grid"; "visibility"; "hidden")
	
Function hideGrid($deferred : Boolean)
	
	If ($deferred)
		CALL FORM:C1391(Current form window:C827; Formula:C1597(call_subform); This:C1470._hideGrid)
	Else 
		This:C1470._hideGrid()
	End if 
	
Function _showGrid()
	
	SVG SET ATTRIBUTE:C1055(*; "area"; "grid"; "visibility"; "visible")
	
Function showGrid($deferred : Boolean)
	
	If ($deferred)
		CALL FORM:C1391(Current form window:C827; Formula:C1597(call_subform); This:C1470._showGrid)
	Else 
		This:C1470._showGrid()
	End if 
	
Function _updateGrid()
	
	If (Form:C1466.area.isGridVisible)
		Form:C1466.area.showGrid()
	Else 
		Form:C1466.area.hideGrid()
	End if 
	
Function _showTools()
	
	SVG SET ATTRIBUTE:C1055(*; "area"; "svgAreaTools"; "4D-bringToFront"; "true"; "visibility"; "visible")
	SVG SET ATTRIBUTE:C1055(*; "area"; "Handles"; "4D-bringToFront"; "true"; "visibility"; "visible")
	
	Form:C1466.area._updateGrid()
	
Function showTools($deferred : Boolean)
	
	If ($deferred)
		CALL FORM:C1391(Current form window:C827; Formula:C1597(call_subform); This:C1470._showTools)
	Else 
		This:C1470._showTools()
	End if 
	
Function onActivate() : cs:C1710.Area
	
	OBJECT SET ENABLED:C1123(*; "b.@"; True:C214)
	
	Form:C1466.selection.updateButtons()
	
	return This:C1470
	
Function onDeactivate() : cs:C1710.Area
	
	OBJECT SET ENABLED:C1123(*; "b.@"; False:C215)
	
	return This:C1470
	
Function exportPicture() : Picture
	
	var $dom : Text
	$dom:=This:C1470.export()
	
	var $SVG : Picture
	SVG EXPORT TO PICTURE:C1017($dom; $SVG; Own XML data source:K45:18)
	
	return $SVG
	
Function export() : Text
	
	var $xml; $element; $dom : Text
	DOM EXPORT TO VAR:C863(This:C1470.DOM; $xml)
	
	$dom:=DOM Parse XML variable:C720($xml)
	
	If (OK=1)
		$element:=DOM Find XML element by ID:C1010($dom; "svgAreaTools")
		If (OK=1)
			DOM REMOVE XML ELEMENT:C869($element)
		End if 
		$element:=DOM Find XML element by ID:C1010($dom; "grid")
		If (OK=1)
			DOM REMOVE XML ELEMENT:C869($element)
		End if 
		$element:=DOM Find XML element by ID:C1010($dom; "Handles")
		If (OK=1)
			DOM REMOVE XML ELEMENT:C869($element)
		End if 
	End if 
	
	return $dom
	
Function toObject() : Object
	
	return {DOM: This:C1470.DOM; grid: This:C1470.grid}