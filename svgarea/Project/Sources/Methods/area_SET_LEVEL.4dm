//%attributes = {"invisible":true}
#DECLARE($command : Text)

var $didChange : Boolean
$didChange:=False:C215

var $child; $elementName; $object : Text
var $objects : Collection
$objects:=[]
$child:=DOM Get first child XML element:C723(Form:C1466.area.DOM)
While (OK=1)
	DOM GET XML ELEMENT NAME:C730($child; $elementName)
	DOM GET XML ATTRIBUTE BY NAME:C728($child; "id"; $object)
	$objects.push($object)
	$child:=DOM Get next sibling XML element:C724($child)
End while 

var $front; $back; $level : Integer
var $newDom : Text
$front:=$objects.length-1
$back:=0
$back+=($objects.indexOf("4D")#-1) ? 1 : 0
$back+=($objects.indexOf("grid")#-1) ? 1 : 0
$back+=($objects.indexOf("svgAreaTools")#-1) ? 1 : 0
$back+=($objects.indexOf("Handles")#-1) ? 1 : 0

var $handle; $item; $dom : Text

Case of 
	: ($command="level.front")
		For each ($item; Form:C1466.selection.values)
			$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
			$level:=$objects.indexOf($item)
			Case of 
				: ($level=$front)
					//already frontmost
				Else 
					$didChange:=True:C214
					DOM REMOVE XML ATTRIBUTE:C1084($dom; "id")
					$newDom:=DOM Append XML element:C1082(Form:C1466.area.DOM; $dom)
					DOM REMOVE XML ELEMENT:C869($dom)
					DOM SET XML ATTRIBUTE:C866($newDom; "id"; $item)
			End case 
		End for each 
		
	: ($command="level.back")
		For each ($item; Form:C1466.selection.values)
			$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
			$level:=$objects.indexOf($item)
			Case of 
				: ($level=$back)
					//already backmost
				Else 
					$didChange:=True:C214
					DOM REMOVE XML ATTRIBUTE:C1084($dom; "id")
					$newDom:=DOM Insert XML element:C1083(Form:C1466.area.DOM; $dom; $back+1)
					DOM REMOVE XML ELEMENT:C869($dom)
					DOM SET XML ATTRIBUTE:C866($newDom; "id"; $item)
			End case 
		End for each 
		
	: ($command="level.up")
		For each ($item; Form:C1466.selection.values)
			$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
			$level:=$objects.indexOf($item)
			Case of 
				: ($level=$front)
					//already frontmost
				: ($level=($front-1))  //can't insert in front so append
					$didChange:=True:C214
					DOM REMOVE XML ATTRIBUTE:C1084($dom; "id")
					$newDom:=DOM Append XML element:C1082(Form:C1466.area.DOM; $dom)
					DOM REMOVE XML ELEMENT:C869($dom)
					DOM SET XML ATTRIBUTE:C866($newDom; "id"; $item)
				Else 
					$didChange:=True:C214
					DOM REMOVE XML ATTRIBUTE:C1084($dom; "id")
					$newDom:=DOM Insert XML element:C1083(Form:C1466.area.DOM; $dom; $level+3)
					//+1 because of 1-based index, 
					//+1 because of moving up level,
					//+1 because the element is inserted before target
					DOM REMOVE XML ELEMENT:C869($dom)
					DOM SET XML ATTRIBUTE:C866($newDom; "id"; $item)
			End case 
		End for each 
		
	: ($command="level.down")
		For each ($item; Form:C1466.selection.values)
			$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
			$level:=$objects.indexOf($item)
			Case of 
				: ($level=$back)
					//already backmost
				Else 
					$didChange:=True:C214
					DOM REMOVE XML ATTRIBUTE:C1084($dom; "id")
					$newDom:=DOM Insert XML element:C1083(Form:C1466.area.DOM; $dom; $level)
					DOM REMOVE XML ELEMENT:C869($dom)
					DOM SET XML ATTRIBUTE:C866($newDom; "id"; $item)
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