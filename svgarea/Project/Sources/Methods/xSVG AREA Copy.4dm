//%attributes = {"invisible":true}
var $item; $dom; $xml : Text
var $objects : Collection
$objects:=[]
For each ($item; Form:C1466.selection.values)
	$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $item)
	DOM EXPORT TO VAR:C863($dom; $xml)
	$objects.push($xml)
End for each 

var $data : Blob
VARIABLE TO BLOB:C532($objects; $data)
APPEND DATA TO PASTEBOARD:C403("com.4d.private.svg.object"; $data)