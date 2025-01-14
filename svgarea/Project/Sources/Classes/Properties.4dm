Class constructor
	
Function restoreImage($proportional : Boolean)
	
	var $dom : Text
	$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; Form:C1466.objects.currentValue)
	var $href : Text
	DOM GET XML ATTRIBUTE BY NAME:C728($dom; "xlink:href"; $href)
	var $currentWidth; $currentHeight : Integer
	DOM GET XML ATTRIBUTE BY NAME:C728($dom; "width"; $currentWidth)
	DOM GET XML ATTRIBUTE BY NAME:C728($dom; "height"; $currentHeight)
	
	ARRAY LONGINT:C221($pos; 0)
	ARRAY LONGINT:C221($len; 0)
	
	var $MIME; $base64 : Text
	var $data : Blob
	var $picture : Picture
	var $x1; $y1; $x2; $y2; $x; $y; $width; $height; $cx; $cy; $rx; $ry : Real
	var $handle; $dom; $handleDom : Text
	
	If (Match regex:C1019("(?:data:)([^;]*);base64,(?s)(.*)"; $href; 1; $pos; $len))
		$MIME:=Substring:C12($href; $pos{1}; $len{1})
		$base64:=Substring:C12($href; $pos{2}; $len{2})
		BASE64 DECODE:C896($base64; $data)
		BLOB TO PICTURE:C682($data; $picture)
		PICTURE PROPERTIES:C457($picture; $width; $height)
	End if 
	
	If ($proportional)
		//not implemented
	Else 
		DOM SET XML ATTRIBUTE:C866($dom; "width"; $width)
		SVG SET ATTRIBUTE:C1055(*; "area"; Form:C1466.objects.currentValue; "width"; $width; "editor:width"; $width)
		DOM SET XML ATTRIBUTE:C866($dom; "height"; $height)
		SVG SET ATTRIBUTE:C1055(*; "area"; Form:C1466.objects.currentValue; "height"; $height; "editor:height"; $height)
	End if 
	
	DOM GET XML ATTRIBUTE BY NAME:C728($dom; "x"; $x)
	DOM GET XML ATTRIBUTE BY NAME:C728($dom; "y"; $y)
	//DOM GET XML ATTRIBUTE BY NAME($dom; "width"; $width)
	//DOM GET XML ATTRIBUTE BY NAME($dom; "height"; $height)
	
	$handle:="handle_tl_"+Form:C1466.objects.currentValue
	$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
	
	DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x; "cy"; $y; "editor:cx"; $x; "editor:cy"; $y)
	SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x; "cy"; $y; "editor:cx"; $x; "editor:cy"; $y)
	
	$handle:="handle_tm_"+Form:C1466.objects.currentValue
	$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
	
	DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x+($width/2); "cy"; $y; "editor:cx"; $x+($width/2); "editor:cy"; $y)
	SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+($width/2); "cy"; $y; "editor:cx"; $x+($width/2); "editor:cy"; $y)
	
	$handle:="handle_tr_"+Form:C1466.objects.currentValue
	$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
	
	DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x+$width; "cy"; $y; "editor:cx"; $x+$width; "editor:cy"; $y)
	SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+$width; "cy"; $y; "editor:cx"; $x+$width; "editor:cy"; $y)
	
	$handle:="handle_ml_"+Form:C1466.objects.currentValue
	$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
	
	DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x; "cy"; $y+($height/2); "editor:cx"; $x; "editor:cy"; $y+($height/2))
	SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x; "cy"; $y+($height/2); "editor:cx"; $x; "editor:cy"; $y+($height/2))
	
	$handle:="handle_mr_"+Form:C1466.objects.currentValue
	$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
	
	DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x+$width; "cy"; $y+($height/2); "editor:cx"; $x+$width; "editor:cy"; $y+($height/2))
	SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+$width; "cy"; $y+($height/2); "editor:cx"; $x+$width; "editor:cy"; $y+($height/2))
	
	$handle:="handle_bl_"+Form:C1466.objects.currentValue
	$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
	
	DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x; "cy"; $y+$height; "editor:cx"; $x; "editor:cy"; $y+$height)
	SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x; "cy"; $y+$height; "editor:cx"; $x; "editor:cy"; $y+$height)
	
	$handle:="handle_bm_"+Form:C1466.objects.currentValue
	$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
	
	DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x+($width/2); "cy"; $y+$height; "editor:cx"; $x+($width/2); "editor:cy"; $y+$height)
	SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+($width/2); "cy"; $y+$height; "editor:cx"; $x+($width/2); "editor:cy"; $y+$height)
	
	$handle:="handle_br_"+Form:C1466.objects.currentValue
	$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
	
	DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x+$width; "cy"; $y+$height; "editor:cx"; $x+$width; "editor:cy"; $y+$height)
	SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+$width; "cy"; $y+$height; "editor:cx"; $x+$width; "editor:cy"; $y+$height)
	
	Form:C1466.event.notifyContainer()
	Form:C1466.palette.update(Form:C1466.event; Form:C1466.objects; Form:C1466.area)
	
Function setGrid($grid : Integer)
	
	Form:C1466.area.setGrid($grid)
	
	area_SET_GRID
	area_HIDE_HANDLES
	area_DRAW_GRID(Form:C1466.area.DOM)
	
Function setDocumentSize($width : Integer; $height : Integer)
	
	Form:C1466.area.setSize($width; $height)
	
	area_SET_SIZE
	area_HIDE_HANDLES
	area_SET_PICTURE
	
	Form:C1466.event.notifyContainer()
	
Function setDocumentProperty($propertyName : Text; $propertyValue : Variant)
	
	DOM SET XML ATTRIBUTE:C866(Form:C1466.area.DOM; $propertyName; $propertyValue)
	
	Case of 
		: ($propertyName="width")
			Form:C1466.area.width:=$propertyValue
			area_SET_SIZE
		: ($propertyName="height")
			Form:C1466.area.height:=$propertyValue
			area_SET_SIZE
	End case 
	
	area_HIDE_HANDLES
	area_SET_PICTURE
	
	Form:C1466.event.notifyContainer()
	
Function setProperty($propertyName : Text; $propertyValue : Variant; $moveHandles : Boolean)
	
	var $positionProperties : Collection
	$positionProperties:=["x"; "y"; "width"; "height"; "cx"; "cy"; "rx"; "ry"; "x1"; "x2"; "y1"; "y2"]
	
	var $dom : Text
	$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; Form:C1466.objects.currentValue)
	DOM SET XML ATTRIBUTE:C866($dom; $propertyName; $propertyValue)
	SVG SET ATTRIBUTE:C1055(*; "area"; Form:C1466.objects.currentValue; $propertyName; $propertyValue)
	
	var $fontProperties : Collection
	$fontProperties:=["font-size"; "font-weight"; "font-style"; "text-decoration"]
	
	If ($positionProperties.indexOf($propertyName)#-1)
		DOM SET XML ATTRIBUTE:C866($dom; "editor:"+$propertyName; $propertyValue)
		SVG SET ATTRIBUTE:C1055(*; "area"; Form:C1466.objects.currentValue; "editor:"+$propertyName; $propertyValue)
	End if 
	
	If ($moveHandles)
		
		var $objectType : Text
		DOM GET XML ELEMENT NAME:C730($dom; $objectType)
		
		var $x1; $y1; $x2; $y2; $x; $y; $width; $height; $cx; $cy; $rx; $ry : Real
		var $handle; $dom; $handleDom : Text
		
		Case of 
			: ($objectType="line")
				DOM GET XML ATTRIBUTE BY NAME:C728($dom; "x1"; $x1)
				DOM GET XML ATTRIBUTE BY NAME:C728($dom; "x2"; $x2)
				DOM GET XML ATTRIBUTE BY NAME:C728($dom; "y1"; $y1)
				DOM GET XML ATTRIBUTE BY NAME:C728($dom; "y2"; $y2)
				
				$width:=$x2-$x1
				$height:=$y2-$y1
				
				$handle:="handle_tl_"+Form:C1466.objects.currentValue
				$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				
				Case of 
					: ($width<0) && ($height<0)
						DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x2; "cy"; $y2; "editor:cx"; $x2; "editor:cy"; $y2)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x2; "cy"; $y2; "editor:cx"; $x2; "editor:cy"; $y2)
					: ($width<0)
						DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x2; "cy"; $y2; "editor:cx"; $x2; "editor:cy"; $y2)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x2; "cy"; $y2; "editor:cx"; $x2; "editor:cy"; $y2)
					: ($height<0)
						DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x1; "cy"; $y1; "editor:cx"; $x1; "editor:cy"; $y1)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x1; "cy"; $y1; "editor:cx"; $x1; "editor:cy"; $y1)
					Else 
						DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x1; "cy"; $y1; "editor:cx"; $x1; "editor:cy"; $y1)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x1; "cy"; $y1; "editor:cx"; $x1; "editor:cy"; $y1)
				End case 
				
				$handle:="handle_br_"+Form:C1466.objects.currentValue
				$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				
				Case of 
					: ($width<0) && ($height<0)
						DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x1; "cy"; $y1; "editor:cx"; $x1; "editor:cy"; $y1)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x1; "cy"; $y1; "editor:cx"; $x1; "editor:cy"; $y1)
					: ($width<0)
						DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x1; "cy"; $y1; "editor:cx"; $x1; "editor:cy"; $y1)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x1; "cy"; $y1; "editor:cx"; $x1; "editor:cy"; $y1)
					: ($height<0)
						DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x2; "cy"; $y2; "editor:cx"; $x2; "editor:cy"; $y2)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x2; "cy"; $y2; "editor:cx"; $x2; "editor:cy"; $y2)
					Else 
						DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x2; "cy"; $y2; "editor:cx"; $x2; "editor:cy"; $y2)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x2; "cy"; $y2; "editor:cx"; $x2; "editor:cy"; $y2)
				End case 
				
			: ($objectType="rect") || ($objectType="round") || ($objectType="textArea") || ($objectType="image")
				DOM GET XML ATTRIBUTE BY NAME:C728($dom; "x"; $x)
				DOM GET XML ATTRIBUTE BY NAME:C728($dom; "y"; $y)
				DOM GET XML ATTRIBUTE BY NAME:C728($dom; "width"; $width)
				DOM GET XML ATTRIBUTE BY NAME:C728($dom; "height"; $height)
				
				$handle:="handle_tl_"+Form:C1466.objects.currentValue
				$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				
				DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x; "cy"; $y; "editor:cx"; $x; "editor:cy"; $y)
				SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x; "cy"; $y; "editor:cx"; $x; "editor:cy"; $y)
				
				$handle:="handle_tm_"+Form:C1466.objects.currentValue
				$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				
				DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x+($width/2); "cy"; $y; "editor:cx"; $x+($width/2); "editor:cy"; $y)
				SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+($width/2); "cy"; $y; "editor:cx"; $x+($width/2); "editor:cy"; $y)
				
				$handle:="handle_tr_"+Form:C1466.objects.currentValue
				$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				
				DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x+$width; "cy"; $y; "editor:cx"; $x+$width; "editor:cy"; $y)
				SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+$width; "cy"; $y; "editor:cx"; $x+$width; "editor:cy"; $y)
				
				$handle:="handle_ml_"+Form:C1466.objects.currentValue
				$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				
				DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x; "cy"; $y+($height/2); "editor:cx"; $x; "editor:cy"; $y+($height/2))
				SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x; "cy"; $y+($height/2); "editor:cx"; $x; "editor:cy"; $y+($height/2))
				
				$handle:="handle_mr_"+Form:C1466.objects.currentValue
				$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				
				DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x+$width; "cy"; $y+($height/2); "editor:cx"; $x+$width; "editor:cy"; $y+($height/2))
				SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+$width; "cy"; $y+($height/2); "editor:cx"; $x+$width; "editor:cy"; $y+($height/2))
				
				$handle:="handle_bl_"+Form:C1466.objects.currentValue
				$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				
				DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x; "cy"; $y+$height; "editor:cx"; $x; "editor:cy"; $y+$height)
				SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x; "cy"; $y+$height; "editor:cx"; $x; "editor:cy"; $y+$height)
				
				$handle:="handle_bm_"+Form:C1466.objects.currentValue
				$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				
				DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x+($width/2); "cy"; $y+$height; "editor:cx"; $x+($width/2); "editor:cy"; $y+$height)
				SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+($width/2); "cy"; $y+$height; "editor:cx"; $x+($width/2); "editor:cy"; $y+$height)
				
				$handle:="handle_br_"+Form:C1466.objects.currentValue
				$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				
				DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x+$width; "cy"; $y+$height; "editor:cx"; $x+$width; "editor:cy"; $y+$height)
				SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+$width; "cy"; $y+$height; "editor:cx"; $x+$width; "editor:cy"; $y+$height)
				
			: ($objectType="ellipse")
				
				DOM GET XML ATTRIBUTE BY NAME:C728($dom; "cx"; $cx)
				DOM GET XML ATTRIBUTE BY NAME:C728($dom; "cy"; $cy)
				DOM GET XML ATTRIBUTE BY NAME:C728($dom; "rx"; $rx)
				DOM GET XML ATTRIBUTE BY NAME:C728($dom; "ry"; $ry)
				
				$width:=$rx*2
				$height:=$ry*2
				$x:=$cx-$rx
				$y:=$cy-$ry
				
				$handle:="handle_tl_"+Form:C1466.objects.currentValue
				$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				
				DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x; "cy"; $y; "editor:cx"; $x; "editor:cy"; $y)
				SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x; "cy"; $y; "editor:cx"; $x; "editor:cy"; $y)
				
				$handle:="handle_tm_"+Form:C1466.objects.currentValue
				$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				
				DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x+($width/2); "cy"; $y; "editor:cx"; $x+($width/2); "editor:cy"; $y)
				SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+($width/2); "cy"; $y; "editor:cx"; $x+($width/2); "editor:cy"; $y)
				
				$handle:="handle_tr_"+Form:C1466.objects.currentValue
				$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				
				DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x+$width; "cy"; $y; "editor:cx"; $x+$width; "editor:cy"; $y)
				SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+$width; "cy"; $y; "editor:cx"; $x+$width; "editor:cy"; $y)
				
				$handle:="handle_ml_"+Form:C1466.objects.currentValue
				$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				
				DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x; "cy"; $y+($height/2); "editor:cx"; $x; "editor:cy"; $y+($height/2))
				SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x; "cy"; $y+($height/2); "editor:cx"; $x; "editor:cy"; $y+($height/2))
				
				$handle:="handle_mr_"+Form:C1466.objects.currentValue
				$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				
				DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x+$width; "cy"; $y+($height/2); "editor:cx"; $x+$width; "editor:cy"; $y+($height/2))
				SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+$width; "cy"; $y+($height/2); "editor:cx"; $x+$width; "editor:cy"; $y+($height/2))
				
				$handle:="handle_bl_"+Form:C1466.objects.currentValue
				$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				
				DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x; "cy"; $y+$height; "editor:cx"; $x; "editor:cy"; $y+$height)
				SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x; "cy"; $y+$height; "editor:cx"; $x; "editor:cy"; $y+$height)
				
				$handle:="handle_bm_"+Form:C1466.objects.currentValue
				$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				
				DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x+($width/2); "cy"; $y+$height; "editor:cx"; $x+($width/2); "editor:cy"; $y+$height)
				SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+($width/2); "cy"; $y+$height; "editor:cx"; $x+($width/2); "editor:cy"; $y+$height)
				
				$handle:="handle_br_"+Form:C1466.objects.currentValue
				$handleDom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				
				DOM SET XML ATTRIBUTE:C866($handleDom; "cx"; $x+$width; "cy"; $y+$height; "editor:cx"; $x+$width; "editor:cy"; $y+$height)
				SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+$width; "cy"; $y+$height; "editor:cx"; $x+$width; "editor:cy"; $y+$height)
				
		End case 
		
	End if 
	
	If ($fontProperties.indexOf($propertyName)#-1)
		area_SET_PICTURE
	End if 
	
	Form:C1466.event.notifyContainer()
	
Function select($object : Text)
	
	area_RELEASE_OBJECTS
	Form:C1466.event.select($object)
	area_SELECT_OBJECT
	
	Form:C1466.area.showTools(True:C214)  //deferred
	
	Form:C1466.event.setCurrentTool("select")
	
Function _o_createLinecapsList() : Integer
	
	var $list : Integer
	$list:=New list:C375
	
	var $butt; $round; $square : Picture
	READ PICTURE FILE:C678(File:C1566("/RESOURCES/images/butt.png").platformPath; $butt)
	READ PICTURE FILE:C678(File:C1566("/RESOURCES/images/round.png").platformPath; $round)
	READ PICTURE FILE:C678(File:C1566("/RESOURCES/images/square.png").platformPath; $square)
	
	APPEND TO LIST:C376($list; "butt"; 1)
	SET LIST ITEM ICON:C950($list; 0; $butt)
	
	APPEND TO LIST:C376($list; "round"; 2)
	SET LIST ITEM ICON:C950($list; 0; $round)
	
	APPEND TO LIST:C376($list; "square"; 3)
	SET LIST ITEM ICON:C950($list; 0; $square)
	
	return $list
	
Function createLinecapsList() : Object
	
	return {index: -1; values: ["butt"; "round"; "square"]; currentValue: Null:C1517}
	
Function createAlignsList() : Object
	
	return {index: -1; values: ["start"; "center"; "end"]; currentValue: Null:C1517}
	
Function createStylesList() : Object
	
	return {index: -1; values: ["normal"; "italic"; "oblique"]; currentValue: Null:C1517}
	
Function createWeightsList() : Object
	
	return {index: -1; values: ["normal"; "bold"]; currentValue: Null:C1517}
	
Function createDecorationsList() : Object
	
	return {index: -1; values: ["none"; "underline"; "line-through"]; currentValue: Null:C1517}
	
Function createDisplayAlignsList() : Object
	
	return {index: -1; values: ["auto"; "before"; "center"; "after"]; currentValue: Null:C1517}
	
Function createPreserveAspectRatiosList() : Object
	
	return {index: -1; \
		values: ["none"; \
		"xMinYMin"; "xMidYMin"; "xMaxYMin"; \
		"xMinYMid"; "xMidYMid"; "xMaxYMid"; \
		"xMinYMax"; "xMidYMax"; "xMaxYMax"]; currentValue: Null:C1517}
	
Function createFontsList() : Object
	
	ARRAY TEXT:C222($names; 0)
	FONT LIST:C460($names)
	
	var $values : Collection
	$values:=[]
	ARRAY TO COLLECTION:C1563($values; $names)
	
	var $default : Text
	$default:=default_font_name
	
	If ($values.indexOf($default)=-1)
		$values.push($default)
	End if 
	
	return {index: -1; values: $values.orderBy(); currentValue: Null:C1517}