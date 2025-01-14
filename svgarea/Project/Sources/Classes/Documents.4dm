property DPI : Integer
property currentTemplate : Object
property templates : Object

Function findTemplate($width : Integer; $height : Integer) : Text
	
	$width:=$width/This:C1470.DPI
	$height:=$height/This:C1470.DPI
	var $templateName : Text
	var $templates : Object
	$templates:=This:C1470.templates
	var $template : Object
	For each ($templateName; $templates)
		$template:=$templates[$templateName]
		If ($template.width=$width) && ($template.height=$height)
			return $templateName
			break
		End if 
	End for each 
	
	return Get localized string:C991("personnal")
	
Function selectTemplate($template : Text)
	
	This:C1470._currentTemplateName:=$template
	
Function get currentTemplate() : Object
	
	return This:C1470._templates[This:C1470._currentTemplateName]
	
Function get DPI() : Integer
	
	return 72
	
Function get templates : Object
	
	return This:C1470._templates
	
Class constructor
	
	var $lang : Text
	$lang:=Get database localization:C1009(User system localization:K5:23)
	
	Case of 
		: ($lang="fr@") || ($lang="ja@")
			This:C1470._currentTemplateName:="A4"
		Else 
			This:C1470._currentTemplateName:="Letter"
	End case 
	
	This:C1470._loadTemplates()
	
Function _createPopupDataSource() : Object
	
	var $var : Object
	$var:={values: []; index: -1; currentValue: Null:C1517}
	
	$var.values:=OB Keys:C1719(This:C1470.templates)
	$var.currentValue:=This:C1470._currentTemplateName
	
	return $var
	
Function _loadTemplates()
	
	This:C1470._templates:={}
	
	var $documentsFile : 4D:C1709.File
	$documentsFile:=File:C1566("/RESOURCES/Properties/Documents.xml")
	
	If ($documentsFile.exists)
		
		var $xml : Text
		$xml:=$documentsFile.getText()
		
		var $dom : Text
		$dom:=DOM Parse XML variable:C720($xml)
		
		If (OK=1)
			
			var $tDom_element : Text
			ARRAY TEXT:C222($tDom_elements; 0)
			$tDom_element:=DOM Find XML element:C864($dom; "/document/template"; $tDom_elements)
			
			var $Lon_i; $Lon_width; $Lon_height : Integer
			var $Txt_id; $Txt_Dom__buffer : Text
			var $document : Object
			For ($Lon_i; 1; Size of array:C274($tDom_elements))
				DOM GET XML ATTRIBUTE BY NAME:C728($tDom_elements{$Lon_i}; "id"; $Txt_id)
				$Txt_Dom__buffer:=DOM Get XML element:C725($tDom_elements{$Lon_i}; "width"; 1; $Lon_width)
				$Txt_Dom__buffer:=DOM Get XML element:C725($tDom_elements{$Lon_i}; "height"; 1; $Lon_height)
				$document:={}
				This:C1470._templates[$Txt_id]:=$document
				$document.width:=$Lon_width
				$document.height:=$Lon_height
			End for 
			
			$document:={}
			This:C1470._templates[Get localized string:C991("personnal")]:=$document
			$document.width:=1
			$document.height:=1
			
			DOM CLOSE XML:C722($dom)
		End if 
		
	End if 
	