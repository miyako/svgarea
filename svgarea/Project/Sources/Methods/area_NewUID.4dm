//%attributes = {"invisible":true}
C_TEXT:C284($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_count; $Lon_index; $Lon_x)
C_TEXT:C284($Txt_name)

DOM GET XML ELEMENT NAME:C730($1; $Txt_name)

$Lon_count:=Form:C1466.objects.values.countValues($Txt_name+"_@")

var $Lon_counter_UID : Integer
$Lon_counter_UID:=Form:C1466.area.counter

If ($Lon_count>0)
	$Lon_index:=$Lon_counter_UID+1
	Repeat 
		$Lon_x:=Form:C1466.objects.values.indexOf($Txt_name+"_"+String:C10($Lon_index))
		If ($Lon_x>0)
			$Lon_index+=1
		End if 
	Until ($Lon_x=-1)
Else 
	$Lon_index:=$Lon_counter_UID+1
End if 

Form:C1466.area.setCounter($Lon_index)

$0:=$Txt_name+"_"+String:C10($Lon_index)