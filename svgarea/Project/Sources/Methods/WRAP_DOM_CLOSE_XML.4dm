//%attributes = {"invisible":true}
C_TEXT:C284($1)

ON ERR CALL:C155("noError")
DOM CLOSE XML:C722($1)
ON ERR CALL:C155(<>Txt_DefaultOnErrorMethod)