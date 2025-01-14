//%attributes = {"invisible":true}
#DECLARE($object : Text) : Boolean

var $image : cs:C1710.Image
$image:=cs:C1710.Image.new()

var $extensions : Text
$extensions:=$image.extensions

var $directory : Text
$directory:=System folder:C487(Desktop:K41:16)

var $fileName : Text
$fileName:=Select document:C905($directory; $extensions; Get localized string:C991("CommonImportEllipse"); Use sheet window:K24:11)

If (OK=1)
	
	var $picture : Picture
	READ PICTURE FILE:C678(DOCUMENT; $picture)
	
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