//%attributes = {"invisible":true}
#DECLARE($object : Text) : Boolean

var $picture : Picture
GET PICTURE FROM PASTEBOARD:C522($picture)

If (Picture size:C356($picture)#0)
	
	var $image : cs:C1710.Image
	$image:=cs:C1710.Image.new()
	
	var $href : Text
	$href:=$image.toDataUri($picture)
	
	If ($href#"")
		var $dom : Text
		$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $object)
		DOM SET XML ATTRIBUTE:C866($dom; "xlink:href"; $href)
		return True:C214
	End if 
End if 

return False:C215