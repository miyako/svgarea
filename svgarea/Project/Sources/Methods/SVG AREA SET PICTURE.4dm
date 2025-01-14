//%attributes = {"invisible":true,"shared":true}
#DECLARE($picture : Picture)

C_TEXT:C284($dom)
C_BLOB:C604($blob)

var $OK1; $OK2 : Integer
PICTURE TO BLOB:C692($picture; $blob; ".svg")
$OK1:=OK
$dom:=DOM Parse XML variable:C720($blob)
$OK2:=OK

If ($OK1=1) && ($OK2=1)
	
	Area_SwapDomTree($dom)
	
Else 
	//DO NOTHING !!!
End if 