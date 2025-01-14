//%attributes = {"invisible":true}
#DECLARE($command : Text)

var $x1; $y1; $x2; $y2 : Real
var $x; $y; $cx; $cy; $rx; $ry; $width; $height : Real
var $item; $type; $dom : Text
var $left; $top; $right; $bottom : Real
var $didChange : Boolean
$didChange:=False:C215
var $offsetX; $offsetY : Integer

$left:=MAXLONG:K35:2
$top:=MAXLONG:K35:2
$right:=0
$bottom:=0

var $handles : Collection
$handles:=["handle_tl"; "handle_tm"; "handle_tr"; "handle_ml"; "handle_mr"; "handle_bl"; "handle_bm"; "handle_br"]
var $handle : Text

For each ($item; Form:C1466.selection.values)
	
	SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:type"; $type)
	
	Case of 
		: ($type="line")
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x1"; $x1)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y1"; $y1)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x2"; $x2)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y2"; $y2)
			$width:=$x2-$x1
			$height:=$y2-$y1
			$x:=$x1
			$y:=$y1
		: ($type="rect") || ($type="text") || ($type="image")
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x"; $x)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y"; $y)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:width"; $width)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:height"; $height)
		: ($type="ellipse")
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:cx"; $cx)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:cy"; $cy)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:rx"; $rx)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:ry"; $ry)
			$width:=$rx*2
			$height:=$ry*2
			$x:=$cx-$rx
			$y:=$cy-$ry
	End case 
	
	$left:=$left>$x ? $x : $left
	$top:=$top>$y ? $y : $top
	$right:=$right<($x+$width) ? ($x+$width) : $right
	$bottom:=$bottom<($y+$height) ? ($y+$height) : $bottom
	
End for each 

Case of 
	: ($command="align.left")
		
		For each ($item; Form:C1466.selection.values)
			
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:type"; $type)
			
			Case of 
				: ($type="line")
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x1"; $x1)
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x2"; $x2)
					$offsetX:=$left-$x1
					If ($offsetX#0)
						$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"x1"; $x1+$offsetX; \
							"x2"; $x2+$offsetX; \
							"editor:x1"; $x1+$offsetX; \
							"editor:x2"; $x2+$offsetX)
						
						For each ($handle; $handles)
							$handle:=$handle+"_"+$item
							SVG GET ATTRIBUTE:C1056(*; "area"; $handle; "editor:cx"; $cx)
							$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
							DOM SET XML ATTRIBUTE:C866($dom; \
								"cx"; $cx+$offsetX; \
								"editor:cx"; $cx+$offsetX)
						End for each 
						
						$didChange:=True:C214
					End if 
					
				: ($type="rect") || ($type="text") || ($type="image")
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x"; $x)
					$offsetX:=$left-$x
					If ($offsetX#0)
						$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"x"; $x+$offsetX; \
							"editor:x"; $x+$offsetX)
						
						For each ($handle; $handles)
							$handle:=$handle+"_"+$item
							SVG GET ATTRIBUTE:C1056(*; "area"; $handle; "editor:cx"; $cx)
							$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
							DOM SET XML ATTRIBUTE:C866($dom; \
								"cx"; $cx+$offsetX; \
								"editor:cx"; $cx+$offsetX)
						End for each 
						
						$didChange:=True:C214
					End if 
				: ($type="ellipse")
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:cx"; $cx)
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:cy"; $cy)
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:rx"; $rx)
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:ry"; $ry)
					$offsetX:=$left-($cx-$rx)
					If ($offsetX#0)
						$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; $cx+$offsetX; \
							"editor:cx"; $cx+$offsetX)
						
						For each ($handle; $handles)
							$handle:=$handle+"_"+$item
							SVG GET ATTRIBUTE:C1056(*; "area"; $handle; "editor:cx"; $cx)
							$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
							DOM SET XML ATTRIBUTE:C866($dom; \
								"cx"; $cx+$offsetX; \
								"editor:cx"; $cx+$offsetX)
						End for each 
						
						$didChange:=True:C214
					End if 
					
			End case 
			
		End for each 
		
	: ($command="align.right")
		
		For each ($item; Form:C1466.selection.values)
			
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:type"; $type)
			
			Case of 
				: ($type="line")
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x1"; $x1)
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x2"; $x2)
					$offsetX:=$right-$x2
					If ($offsetX#0)
						$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"x1"; $x1+$offsetX; \
							"x2"; $x2+$offsetX; \
							"editor:x1"; $x1+$offsetX; \
							"editor:x2"; $x2+$offsetX)
						
						For each ($handle; $handles)
							$handle:=$handle+"_"+$item
							SVG GET ATTRIBUTE:C1056(*; "area"; $handle; "editor:cx"; $cx)
							$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
							DOM SET XML ATTRIBUTE:C866($dom; \
								"cx"; $cx+$offsetX; \
								"editor:cx"; $cx+$offsetX)
						End for each 
						
						$didChange:=True:C214
					End if 
					
				: ($type="rect") || ($type="text") || ($type="image")
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x"; $x)
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:width"; $width)
					$offsetX:=$right-($x+$width)
					If ($offsetX#0)
						$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"x"; $x+$offsetX; \
							"editor:x"; $x+$offsetX)
						
						For each ($handle; $handles)
							$handle:=$handle+"_"+$item
							SVG GET ATTRIBUTE:C1056(*; "area"; $handle; "editor:cx"; $cx)
							$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
							DOM SET XML ATTRIBUTE:C866($dom; \
								"cx"; $cx+$offsetX; \
								"editor:cx"; $cx+$offsetX)
						End for each 
						
						$didChange:=True:C214
					End if 
				: ($type="ellipse")
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:cx"; $cx)
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:cy"; $cy)
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:rx"; $rx)
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:ry"; $ry)
					$offsetX:=$right-($cx+$rx)
					If ($offsetX#0)
						$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; $cx+$offsetX; \
							"editor:cx"; $cx+$offsetX)
						
						For each ($handle; $handles)
							$handle:=$handle+"_"+$item
							SVG GET ATTRIBUTE:C1056(*; "area"; $handle; "editor:cx"; $cx)
							$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
							DOM SET XML ATTRIBUTE:C866($dom; \
								"cx"; $cx+$offsetX; \
								"editor:cx"; $cx+$offsetX)
						End for each 
						
						$didChange:=True:C214
					End if 
					
			End case 
			
		End for each 
		
	: ($command="align.top")
		
		For each ($item; Form:C1466.selection.values)
			
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:type"; $type)
			
			Case of 
				: ($type="line")
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y1"; $y1)
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y2"; $y2)
					$offsetY:=$top-$y1
					If ($offsetY#0)
						$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"y1"; $y1+$offsetY; \
							"y2"; $y2+$offsetY; \
							"editor:y1"; $y1+$offsetY; \
							"editor:y2"; $y2+$offsetY)
						
						For each ($handle; $handles)
							$handle:=$handle+"_"+$item
							SVG GET ATTRIBUTE:C1056(*; "area"; $handle; "editor:cy"; $cy)
							$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
							DOM SET XML ATTRIBUTE:C866($dom; \
								"cy"; $cy+$offsetY; \
								"editor:cy"; $cy+$offsetY)
						End for each 
						
						$didChange:=True:C214
					End if 
					
				: ($type="rect") || ($type="text") || ($type="image")
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y"; $y)
					$offsetY:=$top-$y
					If ($offsetY#0)
						$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"y"; $y+$offsetY; \
							"editor:y"; $y+$offsetY)
						
						For each ($handle; $handles)
							$handle:=$handle+"_"+$item
							SVG GET ATTRIBUTE:C1056(*; "area"; $handle; "editor:cy"; $cy)
							$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
							DOM SET XML ATTRIBUTE:C866($dom; \
								"cy"; $cy+$offsetY; \
								"editor:cy"; $cy+$offsetY)
						End for each 
						
						$didChange:=True:C214
					End if 
				: ($type="ellipse")
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:cx"; $cx)
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:cy"; $cy)
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:rx"; $rx)
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:ry"; $ry)
					$offsetY:=$top-($cy-$ry)
					If ($offsetY#0)
						$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cy"; $cy+$offsetY; \
							"editor:cy"; $cy+$offsetY)
						
						For each ($handle; $handles)
							$handle:=$handle+"_"+$item
							SVG GET ATTRIBUTE:C1056(*; "area"; $handle; "editor:cy"; $cy)
							$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
							DOM SET XML ATTRIBUTE:C866($dom; \
								"cy"; $cy+$offsetY; \
								"editor:cy"; $cy+$offsetY)
						End for each 
						
						$didChange:=True:C214
					End if 
					
			End case 
			
		End for each 
		
	: ($command="align.bottom")
		
		For each ($item; Form:C1466.selection.values)
			
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:type"; $type)
			
			Case of 
				: ($type="line")
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y1"; $y1)
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y2"; $y2)
					$offsetY:=$bottom-$y2
					If ($offsetY#0)
						$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"y1"; $y1+$offsetY; \
							"y2"; $y2+$offsetY; \
							"editor:y1"; $y1+$offsetY; \
							"editor:y2"; $y2+$offsetY)
						
						For each ($handle; $handles)
							$handle:=$handle+"_"+$item
							SVG GET ATTRIBUTE:C1056(*; "area"; $handle; "editor:cy"; $cy)
							$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
							DOM SET XML ATTRIBUTE:C866($dom; \
								"cy"; $cy+$offsetY; \
								"editor:cy"; $cy+$offsetY)
						End for each 
						
						$didChange:=True:C214
					End if 
					
				: ($type="rect") || ($type="text") || ($type="image")
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y"; $y)
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:height"; $height)
					$offsetY:=$bottom-($y+$height)
					If ($offsetY#0)
						$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"y"; $y+$offsetY; \
							"editor:y"; $y+$offsetY)
						
						For each ($handle; $handles)
							$handle:=$handle+"_"+$item
							SVG GET ATTRIBUTE:C1056(*; "area"; $handle; "editor:cy"; $cy)
							$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
							DOM SET XML ATTRIBUTE:C866($dom; \
								"cy"; $cy+$offsetY; \
								"editor:cy"; $cy+$offsetY)
						End for each 
						
						$didChange:=True:C214
					End if 
				: ($type="ellipse")
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:cx"; $cx)
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:cy"; $cy)
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:rx"; $rx)
					SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:ry"; $ry)
					$offsetY:=$bottom-($cy+$ry)
					If ($offsetY#0)
						$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cy"; $cy+$offsetY; \
							"editor:cy"; $cy+$offsetY)
						
						For each ($handle; $handles)
							$handle:=$handle+"_"+$item
							SVG GET ATTRIBUTE:C1056(*; "area"; $handle; "editor:cy"; $cy)
							$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
							DOM SET XML ATTRIBUTE:C866($dom; \
								"cy"; $cy+$offsetY; \
								"editor:cy"; $cy+$offsetY)
						End for each 
						
						$didChange:=True:C214
					End if 
					
			End case 
			
		End for each 
		
End case 

If ($didChange)
	
	//need to reselect at the dom level before export
	
	For each ($item; Form:C1466.objects.values)
		$handle:="hdl_"+$item
		$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
		If (Form:C1466.selection.values.indexOf($item)=-1)
			DOM SET XML ATTRIBUTE:C866($dom; "visibility"; "hidden")
		Else 
			DOM SET XML ATTRIBUTE:C866($dom; "visibility"; "visible")
		End if 
	End for each 
	
	area_SET_PICTURE  //SVG SET ATTRIBUTE will not work until the picture is rendered on screen
	Form:C1466.area.showTools(True:C214)  //deferred
	Form:C1466.event.notifyContainer()
	
End if 