var $event : Integer
$event:=Form event code:C388

Case of 
	: ($event=On Load:K2:1)
		
		Form:C1466.updateCount:=0
		
		Form:C1466.documents:=cs:C1710.Documents.new()
		Form:C1466.templates:=Form:C1466.documents._createPopupDataSource()
		Form:C1466.properties:=cs:C1710.Properties.new()
		Form:C1466.linecap:=Form:C1466.properties.createLinecapsList()
		Form:C1466.dasharray:=cs:C1710.DashArray.new()
		
		If (False:C215)
			var $list : Integer
			$list:=Form:C1466.properties._o_createLinecapsList()
			OBJECT SET LIST BY REFERENCE:C1266(*; "stroke.linecap"; Choice list:K42:19; $list)
			CLEAR LIST:C377($list)
		End if 
		
		Form:C1466.preserveAspectRatio:=Form:C1466.properties.createPreserveAspectRatiosList()
		
		Form:C1466.fontStyle:=Form:C1466.properties.createStylesList()
		Form:C1466.fontWeight:=Form:C1466.properties.createWeightsList()
		Form:C1466.fontFamily:=Form:C1466.properties.createFontsList()
		Form:C1466.textAlign:=Form:C1466.properties.createAlignsList()
		Form:C1466.textDecoration:=Form:C1466.properties.createDecorationsList()
		Form:C1466.displayAlign:=Form:C1466.properties.createDisplayAlignsList()
		
		cs:C1710.Palette.new()._activateWindow(Form:C1466)
		
	: ($event=On Close Box:K2:21)
		
		CANCEL:C270
		
	: ($event=On Unload:K2:2)
		
	Else 
		
		TRACE:C157
		
End case 