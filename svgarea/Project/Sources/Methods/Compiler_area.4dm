//%attributes = {"invisible":true}
<>Txt_DefaultOnErrorMethod:="noError"  //this should be "" but in a beta version lets use "noError" :-)
ON ERR CALL:C155(<>Txt_DefaultOnErrorMethod)

If (Component_init)
	
	C_REAL:C285(<>svgArea_Num_Version)
	C_REAL:C285(<>svgArea_Lon_Beta)
	C_REAL:C285(<>svgArea_Lon_hotFix)
	C_TEXT:C284(<>Txt_DefaultOnErrorMethod)
	
End if 

C_TEXT:C284(<>Txt_callbackMethod)
C_LONGINT:C283(<>Lon_MemoLastEvent)
C_TEXT:C284(<>Txt_MemoLastID)