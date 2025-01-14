//%attributes = {"invisible":true}
C_TEXT:C284($Mnu_align; $Mnu_choice; $Mnu_level; $Mnu_main)
C_BOOLEAN:C305($Boo_insertSeparator)

$Mnu_main:=Create menu:C408

APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("CommonMenuNew"))
SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "new")
SET MENU ITEM SHORTCUT:C423($Mnu_main; -1; "N"; Command key mask:K16:1 | Shift key mask:K16:3)

APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("CommonMenuOpen"))
SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "open")
SET MENU ITEM SHORTCUT:C423($Mnu_main; -1; "O"; Command key mask:K16:1 | Shift key mask:K16:3)

APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("CommonMenuSaveAs"))
SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "save")
SET MENU ITEM SHORTCUT:C423($Mnu_main; -1; "S"; Command key mask:K16:1 | Shift key mask:K16:3)

APPEND MENU ITEM:C411($Mnu_main; "-")

APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("propertyListWindowTitle"))
SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "property_list")
SET MENU ITEM SHORTCUT:C423($Mnu_main; -1; "L"; Command key mask:K16:1 | Shift key mask:K16:3)

If (Not:C34(Is compiled mode:C492))
	APPEND MENU ITEM:C411($Mnu_main; "SVG Viewer")
	SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "svg_viewer")
	SET MENU ITEM SHORTCUT:C423($Mnu_main; -1; "W"; Command key mask:K16:1 | Shift key mask:K16:3)
End if 

APPEND MENU ITEM:C411($Mnu_main; "-")

$Boo_insertSeparator:=False:C215
Case of 
	: (Form:C1466.selection.values.length=1) && (Form:C1466.selection.values[0]="textArea_@")
		
		APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("CommonMenuEdit"))
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "edit")
		$Boo_insertSeparator:=True:C214
		
	: (Form:C1466.selection.values.length=1) && (Form:C1466.selection.values[0]="image_@")
		
		APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("CommonImportEllipse"))
		SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "place")
		$Boo_insertSeparator:=True:C214
		
End case 

If ($Boo_insertSeparator)
	APPEND MENU ITEM:C411($Mnu_main; "-")
End if 

APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("CommonMenuItemCut"))
SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "cut")
If (Form:C1466.selection.values.length=0)
	DISABLE MENU ITEM:C150($Mnu_main; -1)
End if 

APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("CommonMenuItemCopy"))
SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "copy")
If (Form:C1466.selection.values.length=0)
	DISABLE MENU ITEM:C150($Mnu_main; -1)
End if 

APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("CommonMenuItemPaste"))
SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "past")

If (tool_pasteboard_date_size<=0)
	DISABLE MENU ITEM:C150($Mnu_main; -1)
End if 

APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("CommonMenuItemClear"))
SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "del")
If (Form:C1466.selection.values.length=0)
	DISABLE MENU ITEM:C150($Mnu_main; -1)
End if 

APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("CommonMenuDuplicate"))
SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "duplicate")
If (Form:C1466.selection.values.length=0)
	DISABLE MENU ITEM:C150($Mnu_main; -1)
End if 

APPEND MENU ITEM:C411($Mnu_main; "-")

APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("selectAll"))
SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "selectAll")
SET MENU ITEM SHORTCUT:C423($Mnu_main; -1; "A"; Command key mask:K16:1)

If (Form:C1466.objects.values.length=0)
	DISABLE MENU ITEM:C150($Mnu_main; -1)
End if 

APPEND MENU ITEM:C411($Mnu_main; "-")

$Mnu_level:=mnu_loadLevelMenu
APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("Menuslevel"); $Mnu_level)
If (Form:C1466.selection.values.length=0)
	DISABLE MENU ITEM:C150($Mnu_main; -1)
End if 

APPEND MENU ITEM:C411($Mnu_main; "-")

$Mnu_align:=mnu_loadAlignMenu
APPEND MENU ITEM:C411($Mnu_main; Get localized string:C991("align"); $Mnu_align)
If (Form:C1466.selection.values.length<2)
	DISABLE MENU ITEM:C150($Mnu_main; -1)
End if 

$Mnu_choice:=Dynamic pop up menu:C1006($Mnu_main)

RELEASE MENU:C978($Mnu_level)
RELEASE MENU:C978($Mnu_align)
RELEASE MENU:C978($Mnu_main)

Case of 
	: (Length:C16($Mnu_choice)=0)
		
	: ($Mnu_choice="new")
		
		area_NEW_DOCUMENT
		
	: ($Mnu_choice="open")
		
		area_OPEN_DOCUMENT
		
	: ($Mnu_choice="save")
		
		area_SAVE_AS
		
	: ($Mnu_choice="svg_viewer")
		
		var $dom : Text
		$dom:=Form:C1466.area.export()
		SVGTool_SHOW_IN_VIEWER($dom)
		WRAP_DOM_CLOSE_XML($dom)
		
	: ($Mnu_choice="property_list")
		
		Form:C1466.palette.toggle(Form:C1466.event; Form:C1466.objects; Form:C1466.area)
		
	: ($Mnu_choice="place")
		
		If (area_Import_image(Form:C1466.selection.values[0]))
			area_SET_PICTURE  //SVG SET ATTRIBUTE will not work until the picture is rendered on screen
			Form:C1466.area.showTools(True:C214)  //deferred
			Form:C1466.event.notifyContainer()
		End if 
		
	: ($Mnu_choice="edit")
		
		If (area_Text_edit(Form:C1466.selection.values[0]))
			area_SET_PICTURE
			Form:C1466.event.notifyContainer()
		End if 
		
	: ($Mnu_choice="cut")
		
		xSVG AREA Copy
		
	: ($Mnu_choice="copy")
		
		xSVG AREA Copy
		
	: ($Mnu_choice="past")
		
		xSVG AREA Paste
		
	: ($Mnu_choice="del")
		
		area_DELETE_OBJECTS
		
	: ($Mnu_choice="duplicate")
		
		xSVG AREA Duplicate
		
	: ($Mnu_choice="selectAll")
		
		area_SELECT_ALL
		
	: ($Mnu_choice="level.@")
		
		area_SET_LEVEL($Mnu_choice)
		
	: ($Mnu_choice="align.@")
		
		area_ALIGN_OBJECTS($Mnu_choice)
		
	Else 
		
		TRACE:C157
		
End case 
