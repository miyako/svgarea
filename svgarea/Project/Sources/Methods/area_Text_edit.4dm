//%attributes = {"invisible":true}
#DECLARE($object : Text) : Boolean

var $text : Text
SVG GET ATTRIBUTE:C1056(*; "area"; $object; "4D-text"; $text)
//tbreak is \n not \r

var $fontFamily; $fontStyle; $fontWeight : Text
var $fontSize : Integer
SVG GET ATTRIBUTE:C1056(*; "area"; $object; "font-family"; $fontFamily)
SVG GET ATTRIBUTE:C1056(*; "area"; $object; "font-size"; $fontSize)
SVG GET ATTRIBUTE:C1056(*; "area"; $object; "font-style"; $fontStyle)
SVG GET ATTRIBUTE:C1056(*; "area"; $object; "font-weight"; $fontWeight)

var $stroke; $fill : Text
SVG GET ATTRIBUTE:C1056(*; "area"; $object; "fill"; $fill)
//SVG GET ATTRIBUTE(*; "area"; $object; "fill-opacity"; $fillOpacity)
SVG GET ATTRIBUTE:C1056(*; "area"; $object; "stroke"; $stroke)
//SVG GET ATTRIBUTE(*; "area"; $object; "stroke-width"; $strokeWidth)
//SVG GET ATTRIBUTE(*; "area"; $object; "stroke-opacity"; $strokeOpacity)

var $textAlign; $textDecoration : Text
SVG GET ATTRIBUTE:C1056(*; "area"; $object; "text-decoration"; $textDecoration)
SVG GET ATTRIBUTE:C1056(*; "area"; $object; "text-align"; $textAlign)

var $x; $y; $width; $height : Real
SVG GET ATTRIBUTE:C1056(*; "area"; $object; "editor:x"; $x)
SVG GET ATTRIBUTE:C1056(*; "area"; $object; "editor:y"; $y)
SVG GET ATTRIBUTE:C1056(*; "area"; $object; "editor:width"; $width)
SVG GET ATTRIBUTE:C1056(*; "area"; $object; "editor:height"; $height)

var $left; $top; $right; $bottom : Integer
OBJECT GET COORDINATES:C663(*; "area"; $left; $top; $right; $bottom)

$x+=$left
$y+=$top

var $scrollX; $scrollY : Integer
OBJECT GET SCROLL POSITION:C1114(*; "area"; $scrollY; $scrollX)

$x-=$scrollX
$y-=$scrollY

var $form : Object

$form:={\
text: Replace string:C233($text; "\n"; "\r"; *); \
fontFamily: $fontFamily; \
fontSize: $fontSize; \
fontWeight: $fontWeight; \
textDecoration: $textDecoration; \
fill: $fill}

CONVERT COORDINATES:C1365($x; $y; XY Current form:K27:5; XY Screen:K27:7)

$x-=1
$y-=1
$width+=1
$height+=1

SVG SET ATTRIBUTE:C1055(*; "area"; $object; "4D-text"; "")

var $window : Integer
$window:=Open window:C153($x; $y; $x+$width; $y+$height; Pop up window:K34:14)

DIALOG:C40("textEdit"; $form)
CLOSE WINDOW:C154($window)  //can't use OK because clicking outside of pop up window is cancel

var $dom : Text
$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $object)

var $tbreak : Text
ARRAY TEXT:C222($tbreaks; 0)
$tbreak:=DOM Find XML element:C864($dom; "textArea/tbreak"; $tbreaks)

var $i : Integer
For ($i; 1; Size of array:C274($tbreaks))
	$tbreak:=$tbreaks{$i}
	DOM REMOVE XML ELEMENT:C869($tbreak)
End for 

DOM SET XML ELEMENT VALUE:C868($dom; "")

var $lines : Collection
$lines:=Split string:C1554(Replace string:C233($form.text; "\n"; "\r"; *); "\r")

var $line; $node : Text
$i:=0
For each ($line; $lines)
	$node:=DOM Append XML child node:C1080($dom; XML DATA:K45:12; $line)
	$i+=1
	If ($i<$lines.length)
		$node:=DOM Append XML child node:C1080($dom; XML ELEMENT:K45:20; "tbreak")
	End if 
End for each 

return True:C214