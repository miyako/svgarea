//%attributes = {"invisible":true}
#DECLARE($dom : Text)

var $shadowDom; $grid; $dom; $dashArray; $line : Text

$dashArray:="1,"+String:C10(Form:C1466.area.grid-1)

$grid:=DOM Find XML element by ID:C1010($dom; "grid")

If (OK=0) && (Form:C1466.area.isGridVisible)
	
	$shadowDom:=DOM Create XML element:C865($dom; "g")
	$grid:=DOM Insert XML element:C1083($dom; $shadowDom; 1)
	DOM SET XML ATTRIBUTE:C866($grid; "id"; "grid")
	DOM REMOVE XML ELEMENT:C869($shadowDom)
	
	DOM SET XML ATTRIBUTE:C866($grid; "visibility"; "visible")  //to avoid flickering
	
	$line:=DOM Create XML element:C865($grid; "line"; \
		"id"; "verticalLine"; \
		"x1"; 0; \
		"y1"; 0; \
		"x2"; 0; \
		"y2"; Form:C1466.area.height; \
		"stroke"; "grey"; \
		"stroke-width"; Form:C1466.area.width*2; \
		"stroke-opacity"; "0.3"; \
		"stroke-dasharray"; $dashArray)
	
	$line:=DOM Create XML element:C865($grid; "line"; \
		"id"; "horizontalLine"; \
		"x1"; 0; \
		"y1"; 0; \
		"x2"; Form:C1466.area.width; \
		"y2"; 0; \
		"stroke"; "grey"; \
		"stroke-width"; Form:C1466.area.height*2; \
		"stroke-opacity"; "0.3"; \
		"stroke-dasharray"; $dashArray)
	
	area_SET_PICTURE  //SVG SET ATTRIBUTE will not work until the picture is rendered on screen
	Form:C1466.area.showTools(True:C214)  //deferred
	
Else 
	
	SVG SET ATTRIBUTE:C1055(*; "area"; "verticalLine"; "y2"; Form:C1466.area.height)
	SVG SET ATTRIBUTE:C1055(*; "area"; "verticalLine"; "stroke-width"; Form:C1466.area.width*2)
	SVG SET ATTRIBUTE:C1055(*; "area"; "verticalLine"; "stroke-dasharray"; $dashArray)
	
	SVG SET ATTRIBUTE:C1055(*; "area"; "horizontalLine"; "x2"; Form:C1466.area.width)
	SVG SET ATTRIBUTE:C1055(*; "area"; "horizontalLine"; "stroke-width"; Form:C1466.area.height*2)
	SVG SET ATTRIBUTE:C1055(*; "area"; "horizontalLine"; "stroke-dasharray"; $dashArray)
	
	If (Form:C1466.area.isGridVisible)
		Form:C1466.area.showGrid()
	Else 
		Form:C1466.area.hideGrid()
	End if 
	
End if 