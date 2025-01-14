//%attributes = {"invisible":true}
#DECLARE($moveX : Integer; $moveY : Integer; $snapToGrid : Boolean)

var $type : Text
var $x1; $y1; $x2; $y2 : Real
var $cx; $cy; $x; $y : Real
var $r : Real  //for future extension
var $sx : Real  //for future extension
var $sy : Real  //for future extension

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
var $adjusted : Boolean
var $_cx; $_cy; $posX; $posY : Real

For each ($item; Form:C1466.selection.values)
	
	$adjusted:=False:C215
	
	For each ($handle; $handles)
		$handle:=$handle+"_"+$item
		SVG GET ATTRIBUTE:C1056(*; "area"; $handle; "editor:cx"; $cx)
		SVG GET ATTRIBUTE:C1056(*; "area"; $handle; "editor:cy"; $cy)
		
		If ($snapToGrid) && ($offsetX#0) && (Not:C34($adjusted))
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
			$adjusted:=True:C214
		End if 
		
		$cx:=$cx+$offsetX
		
		If ($snapToGrid) && ($offsetY#0) && (Not:C34($adjusted))
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
			$adjusted:=True:C214
		End if 
		
		$cy:=$cy+$offsetY
		
		$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
		DOM SET XML ATTRIBUTE:C866($dom; \
			"cx"; $cx; \
			"cy"; $cy; \
			"editor:cx"; $cx; \
			"editor:cy"; $cy)
	End for each 
	
	SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:type"; $type)
	
	Case of 
		: ($type="line")
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x1"; $x1)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y1"; $y1)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x2"; $x2)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y2"; $y2)
			$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
			DOM SET XML ATTRIBUTE:C866($dom; \
				"x1"; $x1+$offsetX; \
				"y1"; $y1+$offsetY; \
				"x2"; $x2+$offsetX; \
				"y2"; $y2+$offsetY; \
				"editor:x1"; $x1+$offsetX; \
				"editor:y1"; $y1+$offsetY; \
				"editor:x2"; $x2+$offsetX; \
				"editor:y2"; $y2+$offsetY)
		: ($type="rect") || ($type="text") || ($type="image")
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:x"; $x)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:y"; $y)
			$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
			DOM SET XML ATTRIBUTE:C866($dom; \
				"x"; $x+$offsetX; \
				"y"; $y+$offsetY; \
				"editor:x"; $x+$offsetX; \
				"editor:y"; $y+$offsetY)
		: ($type="ellipse")
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:cx"; $cx)
			SVG GET ATTRIBUTE:C1056(*; "area"; $item; "editor:cy"; $cy)
			$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
			DOM SET XML ATTRIBUTE:C866($dom; \
				"cx"; $cx+$offsetX; \
				"cy"; $cy+$offsetY; \
				"editor:cx"; $cx+$offsetX; \
				"editor:cy"; $cy+$offsetY)
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

Form:C1466.palette.update(Form:C1466.event; Form:C1466.objects; Form:C1466.area; True:C214)

Form:C1466.area.showTools(True:C214)  //deferred