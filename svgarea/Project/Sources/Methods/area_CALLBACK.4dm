//%attributes = {"invisible":true}
#DECLARE($event : Integer; $object : Text) : Integer

var $error : Integer

$error:=0  // Default value : 0 = go on !

If (<>Txt_callbackMethod#"")
	
	C_LONGINT:C283(<>Lon_MemoLastEvent)
	C_TEXT:C284(<>Txt_MemoLastID)
	
	If ($event#<>Lon_MemoLastEvent) | ($object#<>Txt_MemoLastID) | True:C214  //do NOT send the same event for the same object twice !!!
		
		<>Lon_MemoLastEvent:=$event
		<>Txt_MemoLastID:=$object
		
		EXECUTE METHOD:C1007(<>Txt_callbackMethod; $error; $event; $object)  //will return -1 if action is refused
		
		If (OK=0)
			$error:=0  // something wrong happended, let's NOT block the action
		End if 
		
	End if 
	
Else 
	$error:=0  // no callback method setup, let's go on
End if 

return $error