//%attributes = {"invisible":true}
C_TEXT:C284($1)  //dom reference (That contains objects "rect", "ellipse", "textArea", "line", "image")

C_TEXT:C284($txt_DomRef)
C_TEXT:C284($Txt_Name)
C_TEXT:C284($Txt_RefChild)
C_TEXT:C284($Txt_UID)

C_BOOLEAN:C305($Boo_AddHandles)

$txt_DomRef:=$1

$Txt_RefChild:=DOM Get first child XML element:C723($txt_DomRef)

While (ok=1)
	
	DOM GET XML ELEMENT NAME:C730($Txt_RefChild; $Txt_Name)
	
	$Boo_AddHandles:=True:C214
	Case of 
		: ($Txt_Name="rect@")
		: ($Txt_Name="ellipse@")
		: ($Txt_Name="textArea@")
		: ($Txt_Name="line@")
		: ($Txt_Name="image@")
		Else 
			$Boo_AddHandles:=False:C215
	End case 
	
	If ($Boo_AddHandles)
		
		DOM GET XML ATTRIBUTE BY NAME:C728($Txt_RefChild; "id"; $Txt_UID)
		
		area_NEW_HANDLES($Txt_UID)
		
	End if 
	
	$Txt_RefChild:=DOM Get next sibling XML element:C724($Txt_RefChild)
	
End while 