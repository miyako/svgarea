//%attributes = {"invisible":true}
#DECLARE($moveX : Integer; $moveY : Integer; $snapToGrid : Boolean)

var $type : Text
var $x1; $y1; $x2; $y2 : Real
var $cx; $cy; $rx; $ry; $x; $y; $width; $height : Real
var $r : Real  //for future extension
var $sx : Real  //for future extension
var $sy : Real  //for future extension
var $i : Integer

$r:=0
$sx:=1
$sy:=1

var $grid : Real
$grid:=Form:C1466.area.grid

var $offsetX; $offsetY : Integer
$offsetX:=Num:C11(String:C10((Cos:C18(($r)*Degree:K30:2)*$moveX)+(Sin:C17(($r)*Degree:K30:2)*$moveY)))*$sx
$offsetY:=Num:C11(String:C10((Cos:C18(($r)*Degree:K30:2)*$moveY)+(-Sin:C17(($r)*Degree:K30:2)*$moveX)))*$sy

var $handles : Collection
$handles:=["handle_tl"; "handle_tm"; "handle_tr"; "handle_ml"; "handle_mr"; "handle_bl"; "handle_bm"; "handle_br"]

var $handle; $item; $dom : Text
var $fraction : Real
var $_cx; $_cy; $posX; $posY : Real

For each ($item; Form:C1466.selection.values)
	
	If ($snapToGrid) && ($offsetY#0)
		$handle:="handle_bm_"+$item
		SVG GET ATTRIBUTE:C1056(*; "area"; $handle; "editor:cy"; $cy)
		$_cy:=$cy+$offsetY
		$fraction:=$_cy\$grid
		Case of 
			: (($_cy%$grid)=0) && ($offsetY<0)
				$posY:=$grid*($fraction-1)
			: ($offsetY<0)
				$posY:=$grid*$fraction
			Else 
				$posY:=$grid*($fraction+1)
		End case 
		$offsetY:=$posY-$cy
	End if 
	
	If ($snapToGrid) && ($offsetX#0)
		$handle:="handle_mr_"+$item
		SVG GET ATTRIBUTE:C1056(*; "area"; $handle; "editor:cx"; $cx)
		$_cx:=$cx+$offsetX
		$fraction:=$_cx\$grid
		Case of 
			: (($_cx%$grid)=0) && ($offsetX<0)
				$posX:=$grid*($fraction-1)
			: ($offsetX<0)
				$posX:=$grid*$fraction
			Else 
				$posX:=$grid*($fraction+1)
		End case 
		$offsetX:=$posX-$cx
	End if 
	
	SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:type"; $type)
	
	Case of 
		: ($type="line")
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x1"; $x1)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y1"; $y1)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x2"; $x2)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y2"; $y2)
			
			$width:=$x2-$x1
			$height:=$y2-$y1
			
			Case of 
				: ($offsetX<0) && (($width+$offsetX)>0)
					$width+=$offsetX  //shrink
				: ($offsetX>0)  //grow
					$width+=$offsetX
			End case 
			
			Case of 
				: ($offsetY<0) && (($height+$offsetY)>0)
					$height+=$offsetY  //shrink
				: ($offsetY>0)  //grow
					$height+=$offsetY
			End case 
			
			$x:=$x1
			$y:=$y1
			$x2:=$x1+$width
			$y2:=$y1+$height
			
			$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
			DOM SET XML ATTRIBUTE:C866($dom; \
				"x1"; $x1; \
				"y1"; $y1; \
				"x2"; $x2; \
				"y2"; $y2; \
				"editor:x1"; $x1; \
				"editor:y1"; $y1; \
				"editor:x2"; $x2; \
				"editor:y2"; $y2)
		: ($type="rect") || ($type="text") || ($type="image")
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x"; $x)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y"; $y)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:width"; $width)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:height"; $height)
			
			Case of 
				: ($offsetX<0) && (($width+$offsetX)>0)
					$width+=$offsetX  //shrink
				: ($offsetX>0)  //grow
					$width+=$offsetX
			End case 
			
			Case of 
				: ($offsetY<0) && (($height+$offsetY)>0)
					$height+=$offsetY  //shrink
				: ($offsetY>0)  //grow
					$height+=$offsetY
			End case 
			
			$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
			
			DOM SET XML ATTRIBUTE:C866($dom; \
				"x"; $x; \
				"editor:x"; $x; \
				"width"; $width; \
				"editor:width"; $width; \
				"y"; $y; \
				"editor:y"; $y; \
				"height"; $height; \
				"editor:height"; $height)
			
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
				: ($offsetX<0) && (($width+$offsetX)>0)
					$width+=$offsetX  //shrink
				: ($offsetX>0)  //grow
					$width+=$offsetX
			End case 
			
			Case of 
				: ($offsetY<0) && (($height+$offsetY)>0)
					$height+=$offsetY  //shrink
				: ($offsetY>0)  //grow
					$height+=$offsetY
			End case 
			
			$rx:=$width/2
			$ry:=$height/2
			$cx:=$x+$rx
			$cy:=$y+$ry
			
			$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
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
		$i+=1
		$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
		Case of 
			: ($i=1)
				DOM SET XML ATTRIBUTE:C866($dom; "cx"; $x; "cy"; $y; "editor:cx"; $x; "editor:cy"; $y)
			: ($i=2)
				DOM SET XML ATTRIBUTE:C866($dom; "cx"; $x+($width/2); "cy"; $y; "editor:cx"; $x+($width/2); "editor:cy"; $y)
			: ($i=3)
				DOM SET XML ATTRIBUTE:C866($dom; "cx"; $x+$width; "cy"; $y; "editor:cx"; $x+$width; "editor:cy"; $y)
			: ($i=4)
				DOM SET XML ATTRIBUTE:C866($dom; "cx"; $x; "cy"; $y+($height/2); "editor:cx"; $x; "editor:cy"; $y+($height/2))
			: ($i=5)
				DOM SET XML ATTRIBUTE:C866($dom; "cx"; $x+$width; "cy"; $y+($height/2); "editor:cx"; $x+$width; "editor:cy"; $y+($height/2))
			: ($i=6)
				DOM SET XML ATTRIBUTE:C866($dom; "cx"; $x; "cy"; $y+$height; "editor:cx"; $x; "editor:cy"; $y+$height)
			: ($i=7)
				DOM SET XML ATTRIBUTE:C866($dom; "cx"; $x+($width/2); "cy"; $y+$height; "editor:cx"; $x+($width/2); "editor:cy"; $y+$height)
			: ($i=8)
				DOM SET XML ATTRIBUTE:C866($dom; "cx"; $x+$width; "cy"; $y+$height; "editor:cx"; $x+$width; "editor:cy"; $y+$height)
		End case 
	End for each 
	
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

Form:C1466.palette.update(Form:C1466.event; Form:C1466.objects; Form:C1466.area; True:C214)

Form:C1466.area.showTools(True:C214)  //deferred