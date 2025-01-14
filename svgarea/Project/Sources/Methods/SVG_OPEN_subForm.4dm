//%attributes = {"invisible":true}
C_TEXT:C284($1)

C_LONGINT:C283($Lon_process; $Lon_w)
C_TEXT:C284($Txt_method; $Txt_process)

$Txt_method:=Current method name:C684
$Txt_process:="SVG Area"

If (Count parameters:C259=0)
	
	$Lon_process:=New process:C317(Current method name:C684; 0; $Txt_process; "*"; *)
	SHOW PROCESS:C325($Lon_process)
	BRING TO FRONT:C326($Lon_process)
	
Else 
	
	Compiler_area
	
	$Lon_w:=Open form window:C675("area"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4; *)
	DIALOG:C40("area")
	CLOSE WINDOW:C154
	
End if 