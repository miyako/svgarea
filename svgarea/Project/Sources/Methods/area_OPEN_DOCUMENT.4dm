//%attributes = {"invisible":true}
C_TEXT:C284($fileName)
C_TEXT:C284($dom)

$fileName:=Select document:C905(""; ".svg"; Get localized string:C991("SelectAnSVGfile"); Single selection:K50:2)

If (OK=1)
	
	EXECUTE METHOD:C1007("SVG_Open_file"; $dom; DOCUMENT)
	//$dom:=SVG_Open_file(DOCUMENT)
	
	If ($dom#"")
		
		Area_SwapDomTree($dom)
		
	End if 
End if 