//%attributes = {"invisible":true,"preemptive":"incapable"}
#DECLARE($function : 4D:C1709.Function)

If (OBJECT Get type:C1300(*; "area")=Object type picture input:K79:5)
	$function.call()
Else 
	ARRAY TEXT:C222($objectNames; 0)
	FORM GET OBJECTS:C898($objectNames)
	var $objectName : Text
	var $objectType : Integer
	var $i : Integer
	For ($i; 1; Size of array:C274($objectNames))
		$objectName:=$objectNames{$i}
		$objectType:=OBJECT Get type:C1300(*; $objectName)
		If ($objectType=Object type subform:K79:40)
			EXECUTE METHOD IN SUBFORM:C1085($objectName; Current method name:C684; *; $function)
			break
		End if 
	End for 
End if 