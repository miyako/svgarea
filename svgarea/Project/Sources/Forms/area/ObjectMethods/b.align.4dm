If (FORM Event:C1606.code=On Clicked:K2:4) || (FORM Event:C1606.code=On Alternative Click:K2:36)
	C_TEXT:C284($menu)
	$menu:=mnu_loadAlignMenu("align")
	area_ALIGN_OBJECTS(Dynamic pop up menu:C1006($menu))
	RELEASE MENU:C978($menu)
End if 