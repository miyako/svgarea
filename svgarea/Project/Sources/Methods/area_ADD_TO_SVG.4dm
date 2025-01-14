//%attributes = {"invisible":true}
#DECLARE($tool : Text) : Text

C_BOOLEAN:C305($Boo_fillable; $Boo_stroke)
C_LONGINT:C283($Lon_height; $Lon_width)
C_REAL:C285($Num_cx; $Num_cy; $Num_rx; $Num_ry)
C_TEXT:C284($Txt_Dom_object; $Txt_Dom_template; $Txt_toolID)
C_TEXT:C284($Txt_UID)

var $scrollX; $scrollY : Integer
OBJECT GET SCROLL POSITION:C1114(*; "area"; $scrollY; $scrollX)

Case of 
	: ($tool="select")
		$Txt_toolID:="tool_99"
	: ($tool="line")
		$Txt_toolID:="tool_2"
	: ($tool="rect")
		$Txt_toolID:="tool_3"
	: ($tool="round")
		$Txt_toolID:="tool_4"
	: ($tool="ellipse")
		$Txt_toolID:="tool_5"
	: ($tool="text")
		$Txt_toolID:="tool_6"
	: ($tool="image")
		$Txt_toolID:="tool_7"
End case 

$Txt_Dom_template:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $Txt_toolID)
$Txt_Dom_object:=DOM Append XML element:C1082(Form:C1466.area.DOM; $Txt_Dom_template)

var $x; $y; $right; $bottom : Integer

If ($tool#"line")
	$x:=Form:C1466.ClickX<Form:C1466.MouseX ? Form:C1466.ClickX : Form:C1466.MouseX
	$right:=Form:C1466.MouseX>Form:C1466.ClickX ? Form:C1466.MouseX : Form:C1466.ClickX
	$y:=Form:C1466.ClickY<Form:C1466.MouseY ? Form:C1466.ClickY : Form:C1466.MouseY
	$bottom:=Form:C1466.MouseY>Form:C1466.ClickY ? Form:C1466.MouseY : Form:C1466.ClickY
Else 
	$x:=Form:C1466.ClickX
	$right:=Form:C1466.MouseX
	$y:=Form:C1466.ClickY
	$bottom:=Form:C1466.MouseY
End if 

Case of 
	: ($tool="line")
		
		DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; \
			"x1"; $x+$scrollX; \
			"y1"; $y+$scrollY; \
			"x2"; $right+$scrollX; \
			"y2"; $bottom+$scrollY; \
			"editor:x1"; $x+$scrollX; \
			"editor:y1"; $y+$scrollY; \
			"editor:x2"; $right+$scrollX; \
			"editor:y2"; $bottom+$scrollY; \
			"editor:type"; "line")
		
		$Boo_fillable:=False:C215
		$Boo_stroke:=True:C214
		
	: ($tool="rect")
		
		$Lon_width:=$right-$x
		$Lon_height:=$bottom-$y
		
		If (Shift down:C543)
			If ($Lon_height>$Lon_width)
				$Lon_width:=$Lon_height
			Else 
				$Lon_height:=$Lon_width
			End if 
		End if 
		
		DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; \
			"x"; $x+$scrollX; \
			"y"; $y+$scrollY; \
			"width"; $Lon_width; \
			"height"; $Lon_height; \
			"editor:x"; $x+$scrollX; \
			"editor:y"; $y+$scrollY; \
			"editor:width"; $Lon_width; \
			"editor:height"; $Lon_height; \
			"editor:rx"; 0; \
			"editor:ry"; 0; \
			"editor:type"; "rect")
		
		$Boo_fillable:=True:C214
		$Boo_stroke:=True:C214
		
	: ($tool="round")
		
		$Lon_width:=$right-$x
		$Lon_height:=$bottom-$y
		
		If (Shift down:C543)
			If ($Lon_height>$Lon_width)
				$Lon_width:=$Lon_height
			Else 
				$Lon_height:=$Lon_width
			End if 
		End if 
		
		DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; \
			"x"; $x+$scrollX; \
			"y"; $y+$scrollY; \
			"width"; $Lon_width; \
			"height"; $Lon_height; \
			"rx"; Lon_round; \
			"ry"; Lon_round; \
			"editor:x"; $x+$scrollX; \
			"editor:y"; $y+$scrollY; \
			"editor:width"; $Lon_width; \
			"editor:height"; $Lon_height; \
			"editor:rx"; Lon_round; \
			"editor:ry"; Lon_round; \
			"editor:type"; "rect")
		
		$Boo_fillable:=True:C214
		$Boo_stroke:=True:C214
		
	: ($tool="ellipse")
		
		$Lon_width:=$right-$x
		$Lon_height:=$bottom-$y
		
		If (Shift down:C543)
			If ($Lon_height>$Lon_width)
				$Lon_width:=$Lon_height
			Else 
				$Lon_height:=$Lon_width
			End if 
		End if 
		
		$Num_rx:=$Lon_width/2
		$Num_ry:=$Lon_height/2
		$Num_cx:=$x+$Num_rx
		$Num_cy:=$y+$Num_ry
		
		DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; \
			"cx"; $Num_cx+$scrollX; \
			"cy"; $Num_cy+$scrollY; \
			"rx"; $Num_rx; \
			"ry"; $Num_ry; \
			"editor:cx"; $Num_cx+$scrollX; \
			"editor:cy"; $Num_cy+$scrollY; \
			"editor:rx"; $Num_rx; \
			"editor:ry"; $Num_ry; \
			"editor:type"; "ellipse")
		
		$Boo_fillable:=True:C214
		$Boo_stroke:=True:C214
		
	: ($tool="text")
		
		$Lon_width:=$right-$x
		$Lon_height:=$bottom-$y
		
		If ($Lon_width=0)
			$Lon_width:=100
		End if 
		If ($Lon_height=0)
			$Lon_height:=30
		End if 
		
		DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; \
			"x"; $x+$scrollX; \
			"y"; $y+$scrollY; \
			"width"; $Lon_width; \
			"height"; $Lon_height; \
			"font-family"; Txt_fontName; \
			"font-size"; Lon_fontSize; \
			"editor:x"; $x+$scrollX; \
			"editor:y"; $y+$scrollY; \
			"editor:width"; $Lon_width; \
			"editor:height"; $Lon_height; \
			"editor:font-family"; Txt_fontName; \
			"editor:font-size"; Lon_fontSize; \
			"editor:type"; "text")
		
		DOM SET XML ELEMENT VALUE:C868($Txt_Dom_object; "Sample text")
		
		$Boo_fillable:=False:C215
		$Boo_stroke:=False:C215
		
	: ($tool="image")
		
		$Lon_width:=$right-$x
		$Lon_height:=$bottom-$y
		
		DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; \
			"x"; $x+$scrollX; \
			"y"; $y+$scrollY; \
			"width"; $Lon_width; \
			"height"; $Lon_height; \
			"editor:x"; $x+$scrollX; \
			"editor:y"; $y+$scrollY; \
			"editor:width"; $Lon_width; \
			"editor:height"; $Lon_height; \
			"editor:type"; "image")
		
		$Boo_fillable:=False:C215
		$Boo_stroke:=False:C215
		
	: ($tool="select")
		
		$Lon_width:=$right-$x
		$Lon_height:=$bottom-$y
		
		If (Shift down:C543)
			If ($Lon_height>$Lon_width)
				$Lon_width:=$Lon_height
			Else 
				$Lon_height:=$Lon_width
			End if 
		End if 
		
		DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "x"; $x; "y"; $y; "width"; $Lon_width; "height"; $Lon_height; \
			"editor:x"; $x; "editor:y"; $y; "editor:width"; $Lon_width; "editor:height"; $Lon_height; \
			"editor:type"; "select")
		
		$Boo_fillable:=True:C214
		$Boo_stroke:=True:C214
		
End case 

If ($Boo_stroke)
	DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "stroke"; <>Txt_strokeColor; "stroke-width"; <>Lon_strokeWidth; \
		"editor:stroke"; <>Txt_strokeColor; "editor:stroke-width"; <>Lon_strokeWidth)
End if 

If ($Boo_fillable)
	
	If ($tool="text")  //but text is not fillable
		
		DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "fill"; <>Txt_strokeColor; "fill-opacity"; 1; \
			"editor:fill"; <>Txt_strokeColor; "editor:fill-opacity"; 1)
		
	Else 
		
		DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "fill"; <>Txt_fillColor; "fill-opacity"; 1; \
			"editor:fill"; <>Txt_fillColor; "editor:fill-opacity"; 1)
		
	End if 
	
End if 

//unselect all other objects in source
var $item; $dom; $handles : Text

For each ($item; Form:C1466.objects.values)
	$handles:="hdl_"+$item
	$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handles)
	DOM SET XML ATTRIBUTE:C866($dom; "visibility"; "hidden")
End for each 

//new object is selected by default
$Txt_UID:=area_NewUID($Txt_Dom_object)
DOM SET XML ATTRIBUTE:C866($Txt_Dom_object; "id"; $Txt_UID)
area_NEW_HANDLES($Txt_UID)

Form:C1466.objects.add($Txt_UID)
Form:C1466.selection.clear().add($Txt_UID)

area_SET_PICTURE  //SVG SET ATTRIBUTE will not work until the picture is rendered on screen

Form:C1466.area.showTools(True:C214)  //deferred

return $Txt_UID