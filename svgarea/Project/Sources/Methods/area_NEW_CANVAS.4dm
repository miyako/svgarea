//%attributes = {"invisible":true}
C_TEXT:C284($0)

var $dom; $defs; $root; $comment : Text

$root:=DOM Create XML Ref:C861("svg"; \
"http://www.w3.org/2000/svg"; \
"xmlns:editor"; "http://www.4d.com/2024/editor")

XML SET OPTIONS:C1090($root; XML indentation:K45:34; XML no indentation:K45:36)

var $documents : cs:C1710.Documents
$documents:=cs:C1710.Documents.new()
Form:C1466.area.width:=$documents.currentTemplate.width*$documents.DPI
Form:C1466.area.height:=$documents.currentTemplate.height*$documents.DPI

DOM SET XML ATTRIBUTE:C866($root; \
"xmlns:xlink"; "http://www.w3.org/1999/xlink"; \
"width"; Form:C1466.area.width; \
"height"; Form:C1466.area.height; \
"viewBox"; "0 0 "+String:C10(Form:C1466.area.width)+" "+String:C10(Form:C1466.area.height); \
"title"; "SVG Area"; \
"viewport-fill"; "rgb(255,255,255)"; \
"viewport-fill-opacity"; 1; "shape-rendering"; "crispEdges")

var $currentDateISO : Text
$currentDateISO:=String:C10(Current date:C33; ISO date:K1:8)
$comment:="\r4D SVG Area version "+area_Get_version+" ©️ 2009 4D SAS."
$comment+="\rgeneration: "+Delete string:C232($currentDateISO; 11; 8)+Delete string:C232($currentDateISO; 1; 10)
$comment+="\r"
$dom:=DOM Append XML child node:C1080($root; XML comment:K45:8; $comment)
$defs:=DOM Create XML element:C865($root; "/svg/defs"; "id"; "4D")

area_DRAW_GRID($dom)

area_INIT_OBJECTS_TOOLS($root)
area_CREATE_ALL_HANDLES($root)

$0:=$root