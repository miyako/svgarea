//%attributes = {"invisible":true}
#DECLARE($prefix : Text) : Text

var $menu : Text
$menu:=Create menu:C408

APPEND MENU ITEM:C411($menu; Get localized string:C991($prefix)+Get localized string:C991("Left"))
SET MENU ITEM PARAMETER:C1004($menu; -1; "align.left")
SET MENU ITEM ICON:C984($menu; -1; "#images/menus/alignLeft.png")

APPEND MENU ITEM:C411($menu; Get localized string:C991($prefix)+Get localized string:C991("Right"))
SET MENU ITEM PARAMETER:C1004($menu; -1; "align.right")
SET MENU ITEM ICON:C984($menu; -1; "#images/menus/alignRight.png")

APPEND MENU ITEM:C411($menu; Get localized string:C991($prefix)+Get localized string:C991("Top"))
SET MENU ITEM PARAMETER:C1004($menu; -1; "align.top")
SET MENU ITEM ICON:C984($menu; -1; "#images/menus/alignTop.png")

APPEND MENU ITEM:C411($menu; Get localized string:C991($prefix)+Get localized string:C991("Bottom"))
SET MENU ITEM PARAMETER:C1004($menu; -1; "align.bottom")
SET MENU ITEM ICON:C984($menu; -1; "#images/menus/alignBottom.png")

return $menu