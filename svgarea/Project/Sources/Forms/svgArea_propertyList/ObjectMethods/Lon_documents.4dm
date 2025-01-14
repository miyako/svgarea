var $e : Object
$e:=FORM Event:C1606

Case of 
	: ($e.code=On Clicked:K2:4)
		
		Form:C1466.documents.selectTemplate(Form:C1466.templates.currentValue)
		
		Form:C1466.width:=Form:C1466.documents.currentTemplate.width*Form:C1466.documents.DPI
		Form:C1466.height:=Form:C1466.documents.currentTemplate.height*Form:C1466.documents.DPI
		
		CALL FORM:C1391(Form:C1466.window; Form:C1466.properties.setDocumentSize; Form:C1466.width; Form:C1466.height)
		
End case 