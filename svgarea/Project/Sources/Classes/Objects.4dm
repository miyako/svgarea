property values : Collection
property currentValue : Text
property index : Integer

Class constructor
	
	This:C1470.clear()
	
Function get values() : Collection
	
	return This:C1470._values
	
Function get currentValue() : Text
	
	return This:C1470._values.length=0 ? "" : This:C1470._values[This:C1470._index]
	
Function set currentValue($object : Text) : cs:C1710.Objects
	
	This:C1470._index:=This:C1470._values.indexOf($object)
	
	return This:C1470
	
Function get index() : Integer
	
	return This:C1470._index
	
Function set index($index : Integer) : cs:C1710.Objects
	
	If ($index<This:C1470._values.length)
		This:C1470._index:=$index
	End if 
	
	return This:C1470
	
Function remove($object : Text) : cs:C1710.Objects
	
	If ($object#"")\
		 && ($object#"grid@")\
		 && ($object#"hdl_@")\
		 && ($object#"handle_@")\
		 && ($object#"tool_@")\
		 && ($object#"text_rect")\
		 && ($object#"image_rect")\
		 && ($object#"Handles")\
		 && ($object#"templateHandle")\
		 && ($object#"svgAreaTools")\
		 && ($object#"4D")\
		 && ($object#"horizontalLine")\
		 && ($object#"verticalLine")
		var $index : Integer
		$index:=This:C1470._values.indexOf($object)
		If ($index#-1)
			This:C1470._values.remove($index)
			This:C1470._index:=-1
		End if 
	End if 
	
	return This:C1470
	
Function clear() : cs:C1710.Objects
	
	This:C1470._values:=[]
	This:C1470._index:=-1
	
	return This:C1470
	
Function add($object : Text) : cs:C1710.Objects
	
	If ($object#"")\
		 && ($object#"grid@")\
		 && ($object#"hdl_@")\
		 && ($object#"handle_@")\
		 && ($object#"tool_@")\
		 && ($object#"text_rect")\
		 && ($object#"image_rect")\
		 && ($object#"Handles")\
		 && ($object#"templateHandle")\
		 && ($object#"svgAreaTools")\
		 && ($object#"4D")\
		 && ($object#"horizontalLine")\
		 && ($object#"verticalLine")
		var $index : Integer
		$index:=This:C1470._values.indexOf($object)
		If ($index=-1)
			This:C1470._values.push($object)
			This:C1470._index:=This:C1470._values.length-1
		Else 
			This:C1470._index:=$index
		End if 
	End if 
	
	return This:C1470
	
Function _createObjectPropertiesSnapshot($fromDom : Boolean) : Object
	
	var $object; $objectType : Text
	$object:=This:C1470.currentValue
	
	If ($object#"")
		$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $object)
		DOM GET XML ELEMENT NAME:C730($dom; $objectType)
		
		var $dom : Text
		var $x; $y; $rx; $ry; $cx; $cy; $width; $height : Real
		var $fill : Text
		var $fillOpacity : Real
		var $stroke : Text
		var $strokeWidth; $strokeOpacity : Real
		var $dashArray : Text
		var $id : Text
		var $title : Text
		var $viewportFill : Text
		var $viewportFillOpacity : Real
		var $x1; $y1; $x2; $y2 : Real
		var $strokeLinecap : Text
		var $preserveAspectRatio : Text
		
		Case of 
			: ($objectType="textArea")
				
				var $fontFamily; $fontWeight; $fontStyle; $textAlign; $textDecoration; $displayAlign : Text
				var $fontSize : Real
				
				If ($fromDom)
					$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $object)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "x"; $x)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "y"; $y)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "width"; $width)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "height"; $height)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "fill"; $fill)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "fill-opacity"; $fillOpacity)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "font-family"; $fontFamily)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "font-size"; $fontSize)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "font-weight"; $fontWeight)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "font-style"; $fontStyle)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "text-align"; $textAlign)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "text-decoration"; $textDecoration)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "display-align"; $displayAlign)
				Else 
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "x"; $x)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "y"; $y)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "width"; $width)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "height"; $height)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "fill"; $fill)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "fill-opacity"; $fillOpacity)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "font-family"; $fontFamily)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "font-size"; $fontSize)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "font-weight"; $fontWeight)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "font-style"; $fontStyle)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "text-align"; $textAlign)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "text-decoration"; $textDecoration)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "display-align"; $displayAlign)
				End if 
				
				return {\
					x: $x; \
					y: $y; \
					width: $width; \
					height: $height; \
					fill: $fill; \
					fillOpacity: $fillOpacity; \
					fontFamily: $fontFamily; \
					fontSize: $fontSize; \
					fontWeight: $fontWeight; \
					fontStyle: $fontStyle; \
					textAlign: $textAlign; \
					textDecoration: $textDecoration; \
					displayAlign: $displayAlign\
					}
				
			: ($objectType="image")
				
				If ($fromDom)
					$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $object)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "x"; $x)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "y"; $y)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "width"; $width)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "height"; $height)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "preserveAspectRatio"; $preserveAspectRatio)
				Else 
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "x"; $x)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "y"; $y)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "width"; $width)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "height"; $height)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "preserveAspectRatio"; $preserveAspectRatio)
				End if 
				
				return {\
					x: $x; \
					y: $y; \
					width: $width; \
					height: $height; \
					preserveAspectRatio: $preserveAspectRatio\
					}
				
			: ($objectType="ellipse")
				
				If ($fromDom)
					$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $object)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "rx"; $rx)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "ry"; $ry)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "cx"; $cx)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "cy"; $cy)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "fill"; $fill)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "fill-opacity"; $fillOpacity)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "stroke"; $stroke)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "stroke-width"; $strokeWidth)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "stroke-opacity"; $strokeOpacity)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "dash-array"; $dashArray)
				Else 
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "cx"; $cx)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "cy"; $cy)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "rx"; $rx)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "ry"; $ry)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "fill"; $fill)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "fill-opacity"; $fillOpacity)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "stroke"; $stroke)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "stroke-width"; $strokeWidth)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "stroke-opacity"; $strokeOpacity)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "dash-array"; $dashArray)
				End if 
				
				return {\
					cx: $cx; \
					cy: $cy; \
					rx: $rx; \
					ry: $ry; \
					fill: $fill; \
					fillOpacity: $fillOpacity; \
					stroke: $stroke; \
					strokeWidth: $strokeWidth; \
					strokeOpacity: $strokeOpacity; \
					dashArray: $dashArray\
					}
				
			: ($objectType="line")
				
				If ($fromDom)
					$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $object)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "x1"; $x1)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "y1"; $y1)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "x2"; $x2)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "y2"; $y2)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "stroke"; $stroke)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "stroke-width"; $strokeWidth)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "stroke-opacity"; $strokeOpacity)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "dash-array"; $dashArray)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "stroke-linecap"; $strokeLinecap)
				Else 
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "x1"; $x1)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "y1"; $y1)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "x2"; $x2)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "y2"; $y2)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "stroke"; $stroke)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "stroke-width"; $strokeWidth)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "stroke-opacity"; $strokeOpacity)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "dash-array"; $dashArray)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "stroke-linecap"; $strokeLinecap)
				End if 
				
				return {\
					x1: $x1; \
					y1: $y1; \
					x2: $x2; \
					y2: $y2; \
					stroke: $stroke; \
					strokeWidth: $strokeWidth; \
					strokeOpacity: $strokeOpacity; \
					dashArray: $dashArray; \
					strokeLinecap: $strokeLinecap\
					}
				
			: ($objectType="rect")
				
				If ($fromDom)
					$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $object)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "x"; $x)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "y"; $y)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "width"; $width)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "height"; $height)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "rx"; $rx)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "ry"; $ry)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "fill"; $fill)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "fill-opacity"; $fillOpacity)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "stroke"; $stroke)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "stroke-width"; $strokeWidth)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "stroke-opacity"; $strokeOpacity)
					DOM GET XML ATTRIBUTE BY NAME:C728($dom; "dash-array"; $dashArray)
				Else 
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "x"; $x)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "y"; $y)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "width"; $width)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "height"; $height)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "rx"; $rx)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "ry"; $ry)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "fill"; $fill)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "fill-opacity"; $fillOpacity)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "stroke"; $stroke)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "stroke-width"; $strokeWidth)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "stroke-opacity"; $strokeOpacity)
					SVG GET ATTRIBUTE:C1056(*; "area"; $object; "dash-array"; $dashArray)
				End if 
				
				return {\
					x: $x; \
					y: $y; \
					width: $width; \
					height: $height; \
					rx: $rx; \
					ry: $ry; \
					fill: $fill; \
					fillOpacity: $fillOpacity; \
					stroke: $stroke; \
					strokeWidth: $strokeWidth; \
					strokeOpacity: $strokeOpacity; \
					dashArray: $dashArray\
					}
				
		End case 
		
	End if 
	
	return 
	
Function _createPopupDataSource() : Object
	
	return {values: This:C1470.values; index: This:C1470.index; currentValue: This:C1470.currentValue}