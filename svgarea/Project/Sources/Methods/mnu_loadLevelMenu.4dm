//%attributes = {"invisible":true}
#DECLARE() : Text

var $menu : Text
$menu:=Create menu:C408

APPEND MENU ITEM:C411($menu; Get localized string:C991("MenusmoveToFront"))
SET MENU ITEM PARAMETER:C1004($menu; -1; "level.front")
SET MENU ITEM ICON:C984($menu; -1; "#images/menus/moveFront.png")

APPEND MENU ITEM:C411($menu; Get localized string:C991("MenusmoveToBack"))
SET MENU ITEM PARAMETER:C1004($menu; -1; "level.back")
SET MENU ITEM ICON:C984($menu; -1; "#images/menus/moveBack.png")

APPEND MENU ITEM:C411($menu; Get localized string:C991("MenusmoveUp"))
SET MENU ITEM PARAMETER:C1004($menu; -1; "level.up")
SET MENU ITEM ICON:C984($menu; -1; "#images/menus/moveDown.png")

APPEND MENU ITEM:C411($menu; Get localized string:C991("MenusmoveDown"))
SET MENU ITEM PARAMETER:C1004($menu; -1; "level.down")
SET MENU ITEM ICON:C984($menu; -1; "#images/menus/moveUp.png")

return $menu
