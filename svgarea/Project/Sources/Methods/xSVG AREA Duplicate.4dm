//%attributes = {"invisible":true}
var $offset : Integer
$offset:=0

var $selection : Collection
$selection:=Form:C1466.selection.values

//need to reselect at the dom level before export

var $handle : Text
For each ($item; Form:C1466.objects.values)
	$handle:="hdl_"+$item
	$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
	DOM SET XML ATTRIBUTE:C866($dom; "visibility"; "hidden")
End for each 

Form:C1466.selection.clear()

var $item; $dom; $newDom; $objectType; $id; $Txt_UID : Text
For each ($item; $selection)
	
	$offset+=10
	
	$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
	DOM GET XML ELEMENT NAME:C730($dom; $objectType)
	DOM GET XML ATTRIBUTE BY NAME:C728($dom; "id"; $id)
	
	var $x; $y; $width; $height : Real
	var $x1; $y1; $x2; $y2 : Real
	var $cx; $cy; $rx; $ry : Real
	
	Case of 
		: ($objectType="line")
			
			DOM GET XML ATTRIBUTE BY NAME:C728($dom; "x1"; $x1)
			DOM GET XML ATTRIBUTE BY NAME:C728($dom; "y1"; $y1)
			DOM GET XML ATTRIBUTE BY NAME:C728($dom; "x2"; $x2)
			DOM GET XML ATTRIBUTE BY NAME:C728($dom; "y2"; $y2)
			
			$x1+=$offset
			$x2+=$offset
			$y1+=$offset
			$y2+=$offset
			
			DOM REMOVE XML ATTRIBUTE:C1084($dom; "id")
			$newDom:=DOM Append XML element:C1082(Form:C1466.area.DOM; $dom)
			DOM SET XML ATTRIBUTE:C866($dom; "id"; $id)
			
			$Txt_UID:=area_NewUID($newDom)
			DOM SET XML ATTRIBUTE:C866($newDom; "id"; $Txt_UID; \
				"x1"; $x1; "y1"; $y1; "x2"; $x2; "y2"; $y2; \
				"editor:x1"; $x1; "editor:y1"; $y1; "editor:x2"; $x2; "editor:y2"; $y2)
			area_NEW_HANDLES($Txt_UID)
			
			Form:C1466.objects.add($Txt_UID)
			Form:C1466.selection.add($Txt_UID)
			
		: ($objectType="rect") || ($objectType="round") || ($objectType="textArea") || ($objectType="image")
			
			DOM GET XML ATTRIBUTE BY NAME:C728($dom; "x"; $x)
			DOM GET XML ATTRIBUTE BY NAME:C728($dom; "y"; $y)
			DOM GET XML ATTRIBUTE BY NAME:C728($dom; "width"; $width)
			DOM GET XML ATTRIBUTE BY NAME:C728($dom; "height"; $height)
			
			$x+=$offset
			$y+=$offset
			
			DOM REMOVE XML ATTRIBUTE:C1084($dom; "id")
			$newDom:=DOM Append XML element:C1082(Form:C1466.area.DOM; $dom)
			DOM SET XML ATTRIBUTE:C866($dom; "id"; $id)
			
			$Txt_UID:=area_NewUID($newDom)
			DOM SET XML ATTRIBUTE:C866($newDom; "id"; $Txt_UID; \
				"x"; $x; "y"; $y; \
				"editor:x"; $x; "editor:y"; $y)
			area_NEW_HANDLES($Txt_UID)
			
			Form:C1466.objects.add($Txt_UID)
			Form:C1466.selection.add($Txt_UID)
			
		: ($objectType="ellipse")
			
			DOM GET XML ATTRIBUTE BY NAME:C728($dom; "cx"; $cx)
			DOM GET XML ATTRIBUTE BY NAME:C728($dom; "cy"; $cy)
			DOM GET XML ATTRIBUTE BY NAME:C728($dom; "rx"; $rx)
			DOM GET XML ATTRIBUTE BY NAME:C728($dom; "ry"; $ry)
			
			$cx+=$offset
			$cy+=$offset
			
			DOM REMOVE XML ATTRIBUTE:C1084($dom; "id")
			$newDom:=DOM Append XML element:C1082(Form:C1466.area.DOM; $dom)
			DOM SET XML ATTRIBUTE:C866($dom; "id"; $id)
			
			$Txt_UID:=area_NewUID($newDom)
			DOM SET XML ATTRIBUTE:C866($newDom; "id"; $Txt_UID; \
				"cx"; $cx; "cy"; $cy; \
				"editor:cx"; $cx; "editor:cy"; $cy)
			area_NEW_HANDLES($Txt_UID)
			
			Form:C1466.objects.add($Txt_UID)
			Form:C1466.selection.add($Txt_UID)
			
	End case 
	
End for each 

Form:C1466.event.unselect().setCurrentTool("select").notifyContainer()
Form:C1466.palette.update(Form:C1466.event; Form:C1466.objects; Form:C1466.area; True:C214)

area_SET_PICTURE  //SVG SET ATTRIBUTE will not work until the picture is rendered on screen

Form:C1466.area.showTools(True:C214)  //deferred