//%attributes = {"invisible":true,"shared":true}
#DECLARE() : Picture

var $dom : Text
$dom:=Form:C1466.area.export()

var $SVG : Picture
SVG EXPORT TO PICTURE:C1017($dom; $SVG; Own XML data source:K45:18)

return $SVG