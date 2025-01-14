//%attributes = {"invisible":true}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	var $process : Integer
	$process:=New process:C317(Current method name:C684; 0; "SVG Area"; {}; *)
	SHOW PROCESS:C325($process)
	BRING TO FRONT:C326($process)
	
Else 
	
	Compiler_area
	
	var $window : Integer
	$window:=Open form window:C675("area"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4; *)
	DIALOG:C40("area")
	CLOSE WINDOW:C154($window)
	
End if 