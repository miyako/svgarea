//%attributes = {"invisible":true}
#DECLARE() : Boolean

If (Not:C34(File:C1566("/RESOURCES/Properties/Documents.xml").exists))
	ALERT:C41(Get localized string:C991("propertiesFolder"))
End if 

If (Not:C34(Folder:C1567("/RESOURCES/patterns").exists))
	ALERT:C41(Get localized string:C991("patternsFolder"))
End if 

If (Not:C34(Folder:C1567("/RESOURCES/images").exists))
	ALERT:C41(Get localized string:C991("imagesFolder"))
End if 

return True:C214