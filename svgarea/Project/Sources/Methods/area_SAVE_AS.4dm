//%attributes = {"invisible":true}
#DECLARE() : Boolean

var $directory; $name : Text
$directory:=System folder:C487(Desktop:K41:16)+"image.svg"
$name:=Select document:C905($directory; ".svg;.xml;.txt"; Get localized string:C991("SaveEllipse"); File name entry:K24:17)

If (OK=1)
	var $dom : Text
	$dom:=Form:C1466.area.export()
	XML SET OPTIONS:C1090($dom; XML indentation:K45:34; XML no indentation:K45:36)
	DOM EXPORT TO FILE:C862($dom; DOCUMENT)
	WRAP_DOM_CLOSE_XML($dom)
	
	return True:C214
End if 