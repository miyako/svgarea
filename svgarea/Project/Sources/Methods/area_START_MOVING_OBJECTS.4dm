//%attributes = {"invisible":true}
var $type; $item : Text
var $x1; $y1; $x2; $y2 : Real
var $cx; $cy; $x; $y : Real

For each ($item; Form:C1466.selection.values)
	
	SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:type"; $type)
	
	Case of 
		: ($type="line")
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "x1"; $x1)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "y1"; $y1)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "x2"; $x2)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "y2"; $y2)
			SVG SET ATTRIBUTE:C1055(*; "area"; $item; "editor:x1"; $x1)
			SVG SET ATTRIBUTE:C1055(*; "area"; $item; "editor:y1"; $y1)
			SVG SET ATTRIBUTE:C1055(*; "area"; $item; "editor:x2"; $x2)
			SVG SET ATTRIBUTE:C1055(*; "area"; $item; "editor:y2"; $y2)
		: ($type="rect") || ($type="text") || ($type="image")
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "x"; $x)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "y"; $y)
			SVG SET ATTRIBUTE:C1055(*; "area"; $item; "editor:x"; $x)
			SVG SET ATTRIBUTE:C1055(*; "area"; $item; "editor:y"; $y)
		: ($type="ellipse")
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "cx"; $cx)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "cy"; $cy)
			SVG SET ATTRIBUTE:C1055(*; "area"; $item; "cx"; $cx)
			SVG SET ATTRIBUTE:C1055(*; "area"; $item; "cy"; $cy)
	End case 
	
End for each 