//%attributes = {}
#DECLARE($dashArray : Text; $dashArrays : Collection) : Object

var $item : Object
var $menu; $dashArray : Text

$menu:=Create menu:C408
For each ($item; $dashArrays)
	APPEND MENU ITEM:C411($menu; Char:C90(0x200B))
	SET MENU ITEM ICON:C984($menu; -1; "path:"+$item.path)
	If ($dashArray=$item.dashArray)
		SET MENU ITEM MARK:C208($menu; -1; Char:C90(18))
	End if 
	$dashArray:=$item.dashArray="" ? "none" : $item.dashArray
	SET MENU ITEM PARAMETER:C1004($menu; -1; $dashArray)
End for each 

$dashArray:=Dynamic pop up menu:C1006($menu)
RELEASE MENU:C978($menu)

Case of 
	: ($dashArray="")
		return 
	: ($dashArray="none")
		return {dashArray: ""}
	Else 
		return {dashArray: $dashArray}
End case 