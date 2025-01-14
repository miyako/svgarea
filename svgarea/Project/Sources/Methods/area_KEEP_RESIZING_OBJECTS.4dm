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

var $offsetX; $offsetY : Real
$offsetX:=Num:C11(String:C10((Cos:C18(($r)*Degree:K30:2)*$moveX)+(Sin:C17(($r)*Degree:K30:2)*$moveY)))*$sx
$offsetY:=Num:C11(String:C10((Cos:C18(($r)*Degree:K30:2)*$moveY)+(-Sin:C17(($r)*Degree:K30:2)*$moveX)))*$sy

var $resizingHandle : Text
$resizingHandle:=Form:C1466.event.clickedObjectId

var $constraints : Boolean
$constraints:=Shift down:C543

var $handles : Collection
$handles:=["handle_tl"; "handle_tm"; "handle_tr"; "handle_ml"; "handle_mr"; "handle_bl"; "handle_bm"; "handle_br"]
var $handle; $item : Text

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
			
			Case of 
				: ($resizingHandle="handle_tl_@")
					
					$x+=$offsetX
					$width-=$offsetX
					
					$y+=$offsetY
					$height-=$offsetY
					
					$x1:=$x
					$x2:=$x+$width
					
					$y1:=$y
					$y2:=$y+$height
					
					If ($constraints)
						If (Abs:C99($width)>Abs:C99($height))
							$y1:=$y2
						Else 
							$x1:=$x2
						End if 
					End if 
					
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "x1"; $x1)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "x2"; $x2)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "y1"; $y1)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "y2"; $y2)
					
				: ($resizingHandle="handle_br_@")
					
					$width+=$offsetX
					$height+=$offsetY
					
					$x1:=$x
					$x2:=$x+$width
					
					$y1:=$y
					$y2:=$y+$height
					
					If ($constraints)
						If (Abs:C99($width)>Abs:C99($height))
							$y2:=$y1
						Else 
							$x2:=$x1
						End if 
					End if 
					
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "x1"; $x1)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "x2"; $x2)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "y1"; $y1)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "y2"; $y2)
					
			End case 
			
			$i:=0
			For each ($handle; $handles)
				$handle:=$handle+"_"+$item
				$i+=1
				Case of 
					: ($i=1)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x1; "cy"; $y1)
					: ($i=2)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; 0; "cy"; 0)
					: ($i=3)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; 0; "cy"; 0)
					: ($i=4)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; 0; "cy"; 0)
					: ($i=5)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; 0; "cy"; 0)
					: ($i=6)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; 0; "cy"; 0)
					: ($i=7)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; 0; "cy"; 0)
					: ($i=8)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x2; "cy"; $y2)
				End case 
			End for each 
			
		: ($type="rect") || ($type="image") || ($type="text")
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x"; $x)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y"; $y)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:width"; $width)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:height"; $height)
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
					
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "x"; $x)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "width"; $width)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "y"; $y)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "height"; $height)
					
				: ($resizingHandle="handle_tm_@")
					
					If ($offsetY>$height)
						$y+=$height  //flip
						$height:=$offsetY-$height
					Else 
						$y+=$offsetY
						$height-=$offsetY
					End if 
					
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "y"; $y)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "height"; $height)
					
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
					
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "x"; $x)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "width"; $width)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "y"; $y)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "height"; $height)
					
				: ($resizingHandle="handle_ml_@")
					
					If ($offsetX>$width)
						$x+=$width  //flip
						$width:=$offsetX-$width
					Else 
						$x+=$offsetX
						$width-=$offsetX
					End if 
					
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "x"; $x)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "width"; $width)
					
				: ($resizingHandle="handle_mr_@")
					
					If ($offsetX>(-$width))
						$width+=$offsetX
					Else 
						$x+=($width+$offsetX)
						$width:=-($width+$offsetX)
					End if 
					
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "x"; $x)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "width"; $width)
					
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
					
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "x"; $x)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "width"; $width)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "y"; $y)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "height"; $height)
					
				: ($resizingHandle="handle_bm_@")
					
					If ($offsetY<(-$height))
						$y+=($height+$offsetY)  //flip
						$height:=-($height+$offsetY)
					Else 
						//$y+=$offsetY
						$height+=$offsetY
					End if 
					
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "y"; $y)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "height"; $height)
					
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
					
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "x"; $x)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "width"; $width)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "y"; $y)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "height"; $height)
					
			End case 
			
			$i:=0
			For each ($handle; $handles)
				$handle:=$handle+"_"+$item
				$i+=1
				Case of 
					: ($i=1)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x; "cy"; $y)
					: ($i=2)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+($width/2); "cy"; $y)
					: ($i=3)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+$width; "cy"; $y)
					: ($i=4)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x; "cy"; $y+($height/2))
					: ($i=5)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+$width; "cy"; $y+($height/2))
					: ($i=6)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x; "cy"; $y+$height)
					: ($i=7)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+($width/2); "cy"; $y+$height)
					: ($i=8)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+$width; "cy"; $y+$height)
				End case 
			End for each 
			
		: ($type="ellipse")
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:cx"; $cx)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:cy"; $cy)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:rx"; $rx)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:ry"; $ry)
			
			$width:=$rx*2
			$height:=$ry*2
			$x:=$cx-$rx
			$y:=$cy-$ry
			
			Case of 
				: ($resizingHandle="handle_tl_@")
					
					If ($offsetX>$width)  //flipX
						$x+=$width
						$width:=$offsetX-$width
					Else 
						$x+=$offsetX
						$width-=$offsetX
					End if 
					
					If ($offsetY>$height)
						$y+=$height  //flipY
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
					
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "cx"; $cx)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "cy"; $cy)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "rx"; $rx)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "ry"; $ry)
					
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
					
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "cy"; $cy)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "ry"; $ry)
					
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
					
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "cx"; $cx)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "cy"; $cy)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "rx"; $rx)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "ry"; $ry)
					
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
					
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "cx"; $cx)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "rx"; $rx)
					
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
					
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "cx"; $cx)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "rx"; $rx)
					
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
					
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "cx"; $cx)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "cy"; $cy)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "rx"; $rx)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "ry"; $ry)
					
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
					
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "cy"; $cy)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "ry"; $ry)
					
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
					
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "cx"; $cx)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "cy"; $cy)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "rx"; $rx)
					SVG SET ATTRIBUTE:C1055(*; "area"; $item; "ry"; $ry)
					
			End case 
			
			$i:=0
			For each ($handle; $handles)
				$handle:=$handle+"_"+$item
				$i+=1
				Case of 
					: ($i=1)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x; "cy"; $y)
					: ($i=2)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+($width/2); "cy"; $y)
					: ($i=3)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+$width; "cy"; $y)
					: ($i=4)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x; "cy"; $y+($height/2))
					: ($i=5)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+$width; "cy"; $y+($height/2))
					: ($i=6)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x; "cy"; $y+$height)
					: ($i=7)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+($width/2); "cy"; $y+$height)
					: ($i=8)
						SVG SET ATTRIBUTE:C1055(*; "area"; $handle; "cx"; $x+$width; "cy"; $y+$height)
				End case 
			End for each 
			
	End case 
	
End for each 

