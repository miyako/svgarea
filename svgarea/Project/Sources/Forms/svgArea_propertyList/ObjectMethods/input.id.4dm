If (FORM Event:C1606.code=On Data Change:K2:15)
	
	Case of 
		: (FORM Get current page:C276=6)
			DOM SET XML ATTRIBUTE:C866(Form:C1466.area.DOM; "title"; Form:C1466.id)  //no need to update SVG or host
		: (Form:C1466.objects.currentValue="")
			TRACE:C157  //should not happen
		: (Form:C1466.id="")
			//ignore
		Else 
			
/*
it seems awfully dangerous to change the id!
*/
			
			If (False:C215)
				var $dom : Text
				$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; Form:C1466.id)
				If (OK=0)
					var $object; $handle; $h : Text
					$object:=Form:C1466.objects.currentValue
					$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $object)
					Form:C1466.objects.values[Form:C1466.objects.index]:=Form:C1466.id
					DOM SET XML ATTRIBUTE:C866($dom; "id"; Form:C1466.id)
					$handle:="hdl_"+$object
					$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $handle)
					DOM SET XML ATTRIBUTE:C866($dom; "id"; "hdl_"+Form:C1466.id)
					var $handles : Collection
					$handles:=["handle_tl"; "handle_tm"; "handle_tr"; "handle_ml"; "handle_mr"; "handle_bl"; "handle_bm"; "handle_br"]
					For each ($handle; $handles)
						$h:=$handle+"_"+$object
						$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $h)
						DOM SET XML ATTRIBUTE:C866($dom; "id"; $handle+"_"+Form:C1466.id)
					End for each 
					TRACE:C157
					CALL FORM:C1391(Form:C1466.window; Form:C1466.properties.renameSelectedObject; $object; Form:C1466.id)
				End if 
			End if 
			
	End case 
	
End if 