//%attributes = {"invisible":true,"shared":true}
C_TEXT:C284($0)
C_TEXT:C284($Txt_Version)

If (False:C215)
	C_TEXT:C284(area_Get_version; $0)
End if 

<>svgArea_Num_Version:=12.2
<>svgArea_Lon_Beta:=0
<>svgArea_Lon_hotFix:=0

$Txt_Version:=String:C10(Int:C8(<>svgArea_Num_Version); "#0")+"."+String:C10(Dec:C9(<>svgArea_Num_Version)*10; "0")

If (<>svgArea_Lon_hotFix#0)
	
	$Txt_Version:=$Txt_Version+" hotfix "+String:C10(<>svgArea_Lon_hotFix)
	
End if 

If (<>svgArea_Lon_Beta#0)
	
	$Txt_Version:=$Txt_Version+String:C10(<>svgArea_Lon_Beta; " B#0; MC#0;")
	
End if 

$0:=$Txt_Version