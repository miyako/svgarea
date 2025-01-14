//%attributes = {"invisible":true}
var $saved : Boolean

CONFIRM:C162(Get localized string:C991("DoYouWantToSave"); Get localized string:C991("SaveEllipse"); Get localized string:C991("DontSave"))

If (OK=1)
	$saved:=area_SAVE_AS
Else 
	$saved:=True:C214
End if 

If ($saved)
	
	SVG AREA New
	
End if 