//%attributes = {"invisible":true}
#DECLARE($ClickX : Integer; $ClickY : Integer; $MouseX : Integer; $MouseY : Integer)

var $type : Text
var $x1; $y1; $x2; $y2 : Real
var $cx; $cy; $x; $y; $rx; $ry; $width; $height : Real
var $r : Real  //for future extension
var $sx : Real  //for future extension
var $sy : Real  //for future extension
var $i : Integer

$r:=0
$sx:=1
$sy:=1

var $moveX; $moveY : Integer
$moveX:=$MouseX-$ClickX
$moveY:=$MouseY-$ClickY

var $offsetX; $offsetY : Integer
$offsetX:=Num:C11(String:C10((Cos:C18(($r)*Degree:K30:2)*$moveX)+(Sin:C17(($r)*Degree:K30:2)*$moveY)))*$sx
$offsetY:=Num:C11(String:C10((Cos:C18(($r)*Degree:K30:2)*$moveY)+(-Sin:C17(($r)*Degree:K30:2)*$moveX)))*$sy

var $resizingHandle : Text
$resizingHandle:=Form:C1466.event.clickedObjectId

var $constraints : Boolean
$constraints:=Shift down:C543

var $handles : Collection
$handles:=["handle_tl"; "handle_tm"; "handle_tr"; "handle_ml"; "handle_mr"; "handle_bl"; "handle_bm"; "handle_br"]
var $handle; $item; $dom : Text

For each ($item; Form:C1466.selection.values)
	
	SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:type"; $type)
	
	Case of 
		: ($type="line")
			
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x1"; $x1)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y1"; $y1)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x2"; $x2)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y2"; $y2)
			$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
			
			$width:=$x2-$x1
			$height:=$y2-$y1
			$x:=$x1
			$y:=$y1
			
			Case of 
				: ($resizingHandle="handle_tl_@")
					
					$x+=$offsetX
					$width-=$offsetX
					
					$y+=$offsetY
					$height-=$offsetY
					
					Case of 
						: ($width<0) && ($height<0)
							$x1:=$x+$width
							$x2:=$x
							$y1:=$y+$height
							$y2:=$y
						: ($width<0)
							$x1:=$x+$width
							$y1:=$y+$height
							$x2:=$x
							$y2:=$y
						: ($height<0)
							$x1:=$x+$width
							$y1:=$y+$height
							$x2:=$x
							$y2:=$y
						Else 
							$x1:=$x
							$y1:=$y
							$x2:=$x+$width
							$y2:=$y+$height
					End case 
					
					If ($constraints)
						If (Abs:C99($width)>Abs:C99($height))
							//horizontal line
							If ($height>0)
								If ($y2<$y1)
									$y2:=$y1  //to bottom
								Else 
									$y1:=$y2  //to bottom
								End if 
							Else 
								If ($y2>$y1)
									$y2:=$y1  //to top
								Else 
									$y1:=$y2  //to top
								End if 
							End if 
						Else 
							//vertical line
							If ($width>0)
								If ($x2<$x1)
									$x2:=$x1  //to right
								Else 
									$x1:=$x2  //to right
								End if 
							Else 
								If ($x2>$x1)
									$x2:=$x1  //to left
								Else 
									$x1:=$x2  //to left
								End if 
							End if 
						End if 
					End if 
					
					DOM SET XML ATTRIBUTE:C866($dom; \
						"x1"; $x1; \
						"x2"; $x2; \
						"y1"; $y1; \
						"y2"; $y2; \
						"editor:x1"; $x1; \
						"editor:x2"; $x2; \
						"editor:y1"; $y1; \
						"editor:y2"; $y2)
					
				: ($resizingHandle="handle_br_@")
					
					$width+=$offsetX
					$height+=$offsetY
					
					Case of 
						: ($width<0) && ($height<0)
							$x1:=$x+$width
							$x2:=$x
							$y1:=$y+$height
							$y2:=$y
						: ($width<0)
							$x1:=$x+$width
							$y1:=$y+$height
							$x2:=$x
							$y2:=$y
						: ($height<0)
							$x1:=$x+$width
							$y1:=$y+$height
							$x2:=$x
							$y2:=$y
						Else 
							$x1:=$x
							$y1:=$y
							$x2:=$x+$width
							$y2:=$y+$height
					End case 
					
					If ($constraints)
						If (Abs:C99($width)>Abs:C99($height))
							//horizontal line
							If ($height>0)
								If ($y2<$y1)
									$y1:=$y2  //to top
								Else 
									$y2:=$y1  //to top
								End if 
							Else 
								If ($y2>$y1)
									$y1:=$y2  //to bottom
								Else 
									$y2:=$y1  //to bottom
								End if 
							End if 
						Else 
							//vertical line
							If ($width>0)
								If ($x2<$x1)
									$x1:=$x2  //to left
								Else 
									$x2:=$x1  //to left
								End if 
							Else 
								If ($x2>$x1)
									$x1:=$x2  //to right
								Else 
									$x2:=$x1  //to right
								End if 
							End if 
						End if 
					End if 
					
					DOM SET XML ATTRIBUTE:C866($dom; \
						"x1"; $x1; \
						"x2"; $x2; \
						"y1"; $y1; \
						"y2"; $y2; \
						"editor:x1"; $x1; \
						"editor:x2"; $x2; \
						"editor:y1"; $y1; \
						"editor:y2"; $y2)
					
			End case 
			
			$i:=0
			For each ($handle; $handles)
				$handle:=$handle+"_"+$item
				$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				$i+=1
				Case of 
					: ($i=1)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; $x1; \
							"cy"; $y1; \
							"editor:cx"; $x1; \
							"editor:cy"; $y1)
					: ($i=2)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; 0; \
							"cy"; 0; \
							"editor:cx"; 0; \
							"editor:cy"; 0)
					: ($i=3)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; 0; \
							"cy"; 0; \
							"editor:cx"; 0; \
							"editor:cy"; 0)
					: ($i=4)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; 0; \
							"cy"; 0; \
							"editor:cx"; 0; \
							"editor:cy"; 0)
					: ($i=5)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; 0; \
							"cy"; 0; \
							"editor:cx"; 0; \
							"editor:cy"; 0)
					: ($i=6)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; 0; \
							"cy"; 0; \
							"editor:cx"; 0; \
							"editor:cy"; 0)
					: ($i=7)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; 0; \
							"cy"; 0; \
							"editor:cx"; 0; \
							"editor:cy"; 0)
					: ($i=8)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; $x2; \
							"cy"; $y2; \
							"editor:cx"; $x2; \
							"editor:cy"; $y2)
				End case 
			End for each 
			
		: ($type="rect") || ($type="image") || ($type="text")
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x"; $x)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y"; $y)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:width"; $width)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:height"; $height)
			$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
			Case of 
				: ($resizingHandle="handle_tl_@")
					
					If ($offsetX>$width)
						$x+=$width  //flip
						$width:=$offsetX-$width
					Else 
						$x+=$offsetX
						$width-=$offsetX
					End if 
					
					If ($offsetY>$height)
						$y+=$height  //flip
						$height:=$offsetY-$height
					Else 
						$y+=$offsetY
						$height-=$offsetY
					End if 
					
					If ($constraints)
						Case of 
							: ($offsetX>$width) && ($offsetY>$height)
								If ($width>$height)
									$width:=$height
								Else 
									$height:=$width
								End if 
							: ($offsetX>$width)
								If ($width>$height)
									$width:=$height
								Else 
									$y+=$height-$width
									$height:=$width
								End if 
							: ($offsetY>$height)
								If ($width>$height)
									$x+=$width-$height
									$width:=$height
								Else 
									$height:=$width
								End if 
							Else 
								If ($width>$height)
									$x+=$width-$height
									$width:=$height
								Else 
									$y+=$height-$width
									$height:=$width
								End if 
						End case 
					End if 
					
					DOM SET XML ATTRIBUTE:C866($dom; \
						"x"; $x; \
						"editor:x"; $x; \
						"width"; $width; \
						"editor:width"; $width; \
						"y"; $y; \
						"editor:y"; $y; \
						"height"; $height; \
						"editor:height"; $height)
					
				: ($resizingHandle="handle_tm_@")
					
					If ($offsetY>$height)
						$y+=$height  //flip
						$height:=$offsetY-$height
					Else 
						$y+=$offsetY
						$height-=$offsetY
					End if 
					
					DOM SET XML ATTRIBUTE:C866($dom; \
						"y"; $y; \
						"editor:y"; $y; \
						"height"; $height; \
						"editor:height"; $height)
					
				: ($resizingHandle="handle_tr_@")
					
					If ($offsetX>(-$width))
						$width+=$offsetX
					Else 
						$x+=($width+$offsetX)
						$width:=-($width+$offsetX)
					End if 
					
					If ($offsetY>$height)
						$y+=$height  //flip
						$height:=$offsetY-$height
					Else 
						$y+=$offsetY
						$height-=$offsetY
					End if 
					
					If ($constraints)
						Case of 
							: ($offsetX>(-$width)) && ($offsetY>$height)
								If ($width>$height)
									$width:=$height
								Else 
									$height:=$width
								End if 
							: ($offsetX>(-$width))
								If ($width>$height)
									$width:=$height
								Else 
									$y+=$height-$width
									$height:=$width
								End if 
							: ($offsetY>$height)
								If ($width>$height)
									$x+=$width-$height
									$width:=$height
								Else 
									$height:=$width
								End if 
							Else 
								If ($width>$height)
									$x+=$width-$height
									$width:=$height
								Else 
									$y+=$height-$width
									$height:=$width
								End if 
						End case 
					End if 
					
					DOM SET XML ATTRIBUTE:C866($dom; \
						"x"; $x; \
						"editor:x"; $x; \
						"width"; $width; \
						"editor:width"; $width; \
						"y"; $y; \
						"editor:y"; $y; \
						"height"; $height; \
						"editor:height"; $height)
					
				: ($resizingHandle="handle_ml_@")
					
					If ($offsetX>$width)
						$x+=$width  //flip
						$width:=$offsetX-$width
					Else 
						$x+=$offsetX
						$width-=$offsetX
					End if 
					
					DOM SET XML ATTRIBUTE:C866($dom; \
						"x"; $x; \
						"editor:x"; $x; \
						"width"; $width; \
						"editor:width"; $width)
					
				: ($resizingHandle="handle_mr_@")
					
					If ($offsetX>(-$width))
						$width+=$offsetX
					Else 
						$x+=($width+$offsetX)
						$width:=-($width+$offsetX)
					End if 
					
					DOM SET XML ATTRIBUTE:C866($dom; \
						"x"; $x; \
						"editor:x"; $x; \
						"width"; $width; \
						"editor:width"; $width)
					
				: ($resizingHandle="handle_bl_@")
					
					If ($offsetX>$width)
						$x+=$width  //flip
						$width:=$offsetX-$width
					Else 
						$x+=$offsetX
						$width-=$offsetX
					End if 
					
					If ($offsetY<(-$height))
						$y+=($height+$offsetY)  //flip
						$height:=-($height+$offsetY)
					Else 
						//$y+=$offsetY
						$height+=$offsetY
					End if 
					
					If ($constraints)
						Case of 
							: ($offsetX>$width) && ($offsetY<(-$height))
								If ($width>$height)
									$width:=$height
								Else 
									$y+=$height-$width
									$height:=$width
								End if 
							: ($offsetX>$width)
								If ($width>$height)
									$width:=$height
								Else 
									$height:=$width
								End if 
							: ($offsetY<(-$height))
								If ($width>$height)
									$x+=$width-$height
									$width:=$height
								Else 
									$y+=$height-$width
									$height:=$width
								End if 
							Else 
								If ($width>$height)
									$x+=$width-$height
									$width:=$height
								Else 
									$height:=$width
								End if 
						End case 
					End if 
					
					DOM SET XML ATTRIBUTE:C866($dom; \
						"x"; $x; \
						"editor:x"; $x; \
						"width"; $width; \
						"editor:width"; $width; \
						"y"; $y; \
						"editor:y"; $y; \
						"height"; $height; \
						"editor:height"; $height)
					
				: ($resizingHandle="handle_bm_@")
					
					If ($offsetY<(-$height))
						$y+=($height+$offsetY)  //flip
						$height:=-($height+$offsetY)
					Else 
						//$y+=$offsetY
						$height+=$offsetY
					End if 
					
					DOM SET XML ATTRIBUTE:C866($dom; \
						"y"; $y; \
						"editor:y"; $y; \
						"height"; $height; \
						"editor:height"; $height)
					
				: ($resizingHandle="handle_br_@")
					
					If ($offsetX>(-$width))
						$width+=$offsetX
					Else 
						$x+=($width+$offsetX)
						$width:=-($width+$offsetX)
					End if 
					
					If ($offsetY<(-$height))
						$y+=($height+$offsetY)  //flip
						$height:=-($height+$offsetY)
					Else 
						//$y+=$offsetY
						$height+=$offsetY
					End if 
					
					If ($constraints)
						Case of 
							: ($offsetX>(-$width)) && ($offsetY<(-$height))
								If ($width>$height)
									$width:=$height
								Else 
									$y+=$height-$width
									$height:=$width
								End if 
							: ($offsetX>(-$width))
								If ($width>$height)
									$width:=$height
								Else 
									$height:=$width
								End if 
							: ($offsetY<(-$height))
								If ($width>$height)
									$x+=$width-$height
									$width:=$height
								Else 
									$y+=$height-$width
									$height:=$width
								End if 
							Else 
								If ($width>$height)
									$x+=$width-$height
									$width:=$height
								Else 
									$height:=$width
								End if 
						End case 
					End if 
					
					DOM SET XML ATTRIBUTE:C866($dom; \
						"x"; $x; \
						"editor:x"; $x; \
						"width"; $width; \
						"editor:width"; $width; \
						"y"; $y; \
						"editor:y"; $y; \
						"height"; $height; \
						"editor:height"; $height)
					
			End case 
			
			$i:=0
			For each ($handle; $handles)
				$handle:=$handle+"_"+$item
				$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				$i+=1
				Case of 
					: ($i=1)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; $x; \
							"cy"; $y; \
							"editor:cx"; $x; \
							"editor:cy"; $y)
					: ($i=2)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; $x+($width/2); \
							"cy"; $y; \
							"editor:cx"; $x+($width/2); \
							"editor:cy"; $y)
					: ($i=3)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; $x+$width; \
							"cy"; $y; \
							"editor:cx"; $x+$width; \
							"editor:cy"; $y)
					: ($i=4)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; $x; \
							"cy"; $y+($height/2); \
							"editor:cx"; $x; \
							"editor:cy"; $y+($height/2))
					: ($i=5)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; $x+$width; \
							"cy"; $y+($height/2); \
							"editor:cx"; $x+$width; \
							"editor:cy"; $y+($height/2))
					: ($i=6)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; $x; \
							"cy"; $y+$height; \
							"editor:cx"; $x; \
							"editor:cy"; $y+$height)
					: ($i=7)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; $x+($width/2); \
							"cy"; $y+$height; \
							"editor:cx"; $x+($width/2); \
							"editor:cy"; $y+$height)
					: ($i=8)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; $x+$width; \
							"cy"; $y+$height; \
							"editor:cx"; $x+$width; \
							"editor:cy"; $y+$height)
				End case 
			End for each 
			
		: ($type="ellipse")
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:cx"; $cx)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:cy"; $cy)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:rx"; $rx)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:ry"; $ry)
			$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
			
			$width:=$rx*2
			$height:=$ry*2
			$x:=$cx-$rx
			$y:=$cy-$ry
			
			Case of 
				: ($resizingHandle="handle_tl_@")
					
					If ($offsetX>$width)
						$x+=$width  //flip
						$width:=$offsetX-$width
					Else 
						$x+=$offsetX
						$width-=$offsetX
					End if 
					
					If ($offsetY>$height)
						$y+=$height  //flip
						$height:=$offsetY-$height
					Else 
						$y+=$offsetY
						$height-=$offsetY
					End if 
					
					If ($constraints)
						Case of 
							: ($offsetX>$width) && ($offsetY>$height)
								If ($width>$height)
									$width:=$height
								Else 
									$height:=$width
								End if 
							: ($offsetX>$width)
								If ($width>$height)
									$width:=$height
								Else 
									$y+=$height-$width
									$height:=$width
								End if 
							: ($offsetY>$height)
								If ($width>$height)
									$x+=$width-$height
									$width:=$height
								Else 
									$height:=$width
								End if 
							Else 
								If ($width>$height)
									$x+=$width-$height
									$width:=$height
								Else 
									$y+=$height-$width
									$height:=$width
								End if 
						End case 
					End if 
					
					$rx:=$width/2
					$ry:=$height/2
					$cx:=$x+$rx
					$cy:=$y+$ry
					
					DOM SET XML ATTRIBUTE:C866($dom; \
						"cx"; $cx; \
						"cy"; $cy; \
						"rx"; $rx; \
						"ry"; $ry; \
						"editor:cx"; $cx; \
						"editor:cy"; $cy; \
						"editor:rx"; $rx; \
						"editor:ry"; $ry)
					
				: ($resizingHandle="handle_tm_@")
					
					If ($offsetY>$height)
						$y+=$height  //flip
						$height:=$offsetY-$height
					Else 
						$y+=$offsetY
						$height-=$offsetY
					End if 
					
					//$rx:=$width/2
					$ry:=$height/2
					//$cx:=$x+$rx
					$cy:=$y+$ry
					
					DOM SET XML ATTRIBUTE:C866($dom; \
						"cy"; $cy; \
						"ry"; $ry; \
						"editor:cy"; $cy; \
						"editor:ry"; $ry)
					
				: ($resizingHandle="handle_tr_@")
					
					If ($offsetX>(-$width))
						$width+=$offsetX
					Else 
						$x+=($width+$offsetX)
						$width:=-($width+$offsetX)
					End if 
					
					If ($offsetY>$height)
						$y+=$height  //flip
						$height:=$offsetY-$height
					Else 
						$y+=$offsetY
						$height-=$offsetY
					End if 
					
					If ($constraints)
						Case of 
							: ($offsetX>(-$width)) && ($offsetY>$height)
								If ($width>$height)
									$width:=$height
								Else 
									$height:=$width
								End if 
							: ($offsetX>(-$width))
								If ($width>$height)
									$width:=$height
								Else 
									$y+=$height-$width
									$height:=$width
								End if 
							: ($offsetY>$height)
								If ($width>$height)
									$x+=$width-$height
									$width:=$height
								Else 
									$height:=$width
								End if 
							Else 
								If ($width>$height)
									$x+=$width-$height
									$width:=$height
								Else 
									$y+=$height-$width
									$height:=$width
								End if 
						End case 
					End if 
					
					$rx:=$width/2
					$ry:=$height/2
					$cx:=$x+$rx
					$cy:=$y+$ry
					
					DOM SET XML ATTRIBUTE:C866($dom; \
						"cx"; $cx; \
						"cy"; $cy; \
						"rx"; $rx; \
						"ry"; $ry; \
						"editor:cx"; $cx; \
						"editor:cy"; $cy; \
						"editor:rx"; $rx; \
						"editor:ry"; $ry)
					
				: ($resizingHandle="handle_ml_@")
					
					If ($offsetX>$width)
						$x+=$width  //flip
						$width:=$offsetX-$width
					Else 
						$x+=$offsetX
						$width-=$offsetX
					End if 
					
					$rx:=$width/2
					//$ry:=$height/2
					$cx:=$x+$rx
					//$cy:=$y+$ry
					
					DOM SET XML ATTRIBUTE:C866($dom; \
						"cx"; $cx; \
						"rx"; $rx; \
						"editor:cx"; $cx; \
						"editor:rx"; $rx)
					
				: ($resizingHandle="handle_mr_@")
					
					If ($offsetX>(-$width))
						$width+=$offsetX
					Else 
						$x+=($width+$offsetX)
						$width:=-($width+$offsetX)
					End if 
					
					$rx:=$width/2
					//$ry:=$height/2
					$cx:=$x+$rx
					//$cy:=$y+$ry
					
					DOM SET XML ATTRIBUTE:C866($dom; \
						"cx"; $cx; \
						"rx"; $rx; \
						"editor:cx"; $cx; \
						"editor:rx"; $rx)
					
				: ($resizingHandle="handle_bl_@")
					
					If ($offsetX>$width)
						$x+=$width  //flip
						$width:=$offsetX-$width
					Else 
						$x+=$offsetX
						$width-=$offsetX
					End if 
					
					If ($offsetY<(-$height))
						$y+=($height+$offsetY)  //flip
						$height:=-($height+$offsetY)
					Else 
						//$y+=$offsetY
						$height+=$offsetY
					End if 
					
					If ($constraints)
						Case of 
							: ($offsetX>$width) && ($offsetY<(-$height))
								If ($width>$height)
									$width:=$height
								Else 
									$y+=$height-$width
									$height:=$width
								End if 
							: ($offsetX>$width)
								If ($width>$height)
									$width:=$height
								Else 
									$height:=$width
								End if 
							: ($offsetY<(-$height))
								If ($width>$height)
									$x+=$width-$height
									$width:=$height
								Else 
									$y+=$height-$width
									$height:=$width
								End if 
							Else 
								If ($width>$height)
									$x+=$width-$height
									$width:=$height
								Else 
									$height:=$width
								End if 
						End case 
					End if 
					
					$rx:=$width/2
					$ry:=$height/2
					$cx:=$x+$rx
					$cy:=$y+$ry
					
					DOM SET XML ATTRIBUTE:C866($dom; \
						"cx"; $cx; \
						"cy"; $cy; \
						"rx"; $rx; \
						"ry"; $ry; \
						"editor:cx"; $cx; \
						"editor:cy"; $cy; \
						"editor:rx"; $rx; \
						"editor:ry"; $ry)
					
				: ($resizingHandle="handle_bm_@")
					
					If ($offsetY<(-$height))
						$y+=($height+$offsetY)  //flip
						$height:=-($height+$offsetY)
					Else 
						//$y+=$offsetY
						$height+=$offsetY
					End if 
					
					$rx:=$width/2
					$ry:=$height/2
					$cx:=$x+$rx
					$cy:=$y+$ry
					
					DOM SET XML ATTRIBUTE:C866($dom; \
						"cy"; $cy; \
						"ry"; $ry; \
						"editor:cy"; $cy; \
						"editor:ry"; $ry)
					
				: ($resizingHandle="handle_br_@")
					
					If ($offsetX>(-$width))
						$width+=$offsetX
					Else 
						$x+=($width+$offsetX)
						$width:=-($width+$offsetX)
					End if 
					
					If ($offsetY<(-$height))
						$y+=($height+$offsetY)  //flip
						$height:=-($height+$offsetY)
					Else 
						//$y+=$offsetY
						$height+=$offsetY
					End if 
					
					If ($constraints)
						Case of 
							: ($offsetX>(-$width)) && ($offsetY<(-$height))
								If ($width>$height)
									$width:=$height
								Else 
									$y+=$height-$width
									$height:=$width
								End if 
							: ($offsetX>(-$width))
								If ($width>$height)
									$width:=$height
								Else 
									$height:=$width
								End if 
							: ($offsetY<(-$height))
								If ($width>$height)
									$x+=$width-$height
									$width:=$height
								Else 
									$y+=$height-$width
									$height:=$width
								End if 
							Else 
								If ($width>$height)
									$x+=$width-$height
									$width:=$height
								Else 
									$height:=$width
								End if 
						End case 
					End if 
					
					$rx:=$width/2
					$ry:=$height/2
					$cx:=$x+$rx
					$cy:=$y+$ry
					
					DOM SET XML ATTRIBUTE:C866($dom; \
						"cx"; $cx; \
						"cy"; $cy; \
						"rx"; $rx; \
						"ry"; $ry; \
						"editor:cx"; $cx; \
						"editor:cy"; $cy; \
						"editor:rx"; $rx; \
						"editor:ry"; $ry)
					
			End case 
			
			$i:=0
			For each ($handle; $handles)
				$handle:=$handle+"_"+$item
				$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
				$i+=1
				Case of 
					: ($i=1)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; $x; \
							"cy"; $y; \
							"editor:cx"; $x; \
							"editor:cy"; $y)
					: ($i=2)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; $x+($width/2); \
							"cy"; $y; \
							"editor:cx"; $x+($width/2); \
							"editor:cy"; $y)
					: ($i=3)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; $x+$width; \
							"cy"; $y; \
							"editor:cx"; $x+$width; \
							"editor:cy"; $y)
					: ($i=4)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; $x; \
							"cy"; $y+($height/2); \
							"editor:cx"; $x; \
							"editor:cy"; $y+($height/2))
					: ($i=5)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; $x+$width; \
							"cy"; $y+($height/2); \
							"editor:cx"; $x+$width; \
							"editor:cy"; $y+($height/2))
					: ($i=6)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; $x; \
							"cy"; $y+$height; \
							"editor:cx"; $x; \
							"editor:cy"; $y+$height)
					: ($i=7)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; $x+($width/2); \
							"cy"; $y+$height; \
							"editor:cx"; $x+($width/2); \
							"editor:cy"; $y+$height)
					: ($i=8)
						DOM SET XML ATTRIBUTE:C866($dom; \
							"cx"; $x+$width; \
							"cy"; $y+$height; \
							"editor:cx"; $x+$width; \
							"editor:cy"; $y+$height)
				End case 
			End for each 
	End case 
	
End for each 

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