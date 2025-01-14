//%attributes = {"invisible":true}
C_TEXT:C284($1)

C_LONGINT:C283($Lon_i)
C_TEXT:C284($Txt_buffer)
C_TEXT:C284($Txt_Dom_group)
C_TEXT:C284($Txt_Dom_object)
C_TEXT:C284($Txt_Dom_def)
C_TEXT:C284($Txt_Dom_root)

var $fontSize : Real
$fontSize:=Form:C1466.defaults.fontSize

var $fill; $stroke; $fontFamily : Text
$fill:=Form:C1466.defaults.fill
$stroke:=Form:C1466.defaults.stroke
$fontFamily:=Form:C1466.defaults.fontFamily

$Txt_Dom_root:=$1

$Txt_Dom_def:=DOM Find XML element by ID:C1010($Txt_Dom_root; "svgAreaTools")

If (OK=0)
	
	$Txt_Dom_group:=DOM Create XML element:C865($Txt_Dom_root; \
		"g"; \
		"visibility"; "visible"; \
		"id"; "svgAreaTools")
	
	//*** LINE *** {
	$Txt_Dom_object:=DOM Create XML element:C865($Txt_Dom_group; \
		"line"; \
		"x1"; 0; \
		"y1"; 0; \
		"x2"; 0; \
		"y2"; 0; \
		"stroke"; "rgb(255,0,0)"; \
		"fill"; "rgb(255,0,0)"; \
		"fill-opacity"; 1; \
		"stroke-width"; 3; \
		"stroke-opacity"; 1; \
		"stroke-dasharray"; ""; \
		"stroke-linecap"; "butt"; \
		"stroke-linejoin"; "miter"; \
		"stroke-miterlimit"; 4; \
		"transform"; ""; \
		"stroke-dasharray"; ""; \
		"id"; "tool_2")
	//}
	
	// *** RECT ***{
	$Txt_Dom_object:=DOM Create XML element:C865($Txt_Dom_group; \
		"rect"; \
		"x"; 0; \
		"y"; 0; \
		"width"; 0; \
		"height"; 0; \
		"stroke"; "black"; \
		"stroke-width"; 1; \
		"stroke-opacity"; 1; \
		"stroke-dasharray"; ""; \
		"stroke-linecap"; "butt"; \
		"stroke-linejoin"; "miter"; \
		"stroke-miterlimit"; 4; \
		"fill"; "none"; \
		"fill-opacity"; 1; \
		"transform"; ""; \
		"stroke-dasharray"; ""; \
		"id"; "tool_3")
	//}
	
	// *** ROUNDED RECT *** {
	$Txt_Dom_object:=DOM Create XML element:C865($Txt_Dom_group; \
		"rect"; \
		"x"; 0; \
		"y"; 0; \
		"rx"; 20; \
		"ry"; 20; \
		"width"; 0; \
		"height"; 0; \
		"stroke"; "black"; \
		"stroke-width"; 1; \
		"stroke-opacity"; 1; \
		"stroke-dasharray"; ""; \
		"stroke-linecap"; "butt"; \
		"stroke-linejoin"; "miter"; \
		"stroke-miterlimit"; 4; \
		"fill"; "none"; \
		"fill-opacity"; 1; \
		"transform"; ""; \
		"stroke-dasharray"; ""; \
		"id"; "tool_4")
	//}
	
	$Txt_Dom_object:=DOM Create XML element:C865($Txt_Dom_group; \
		"ellipse"; \
		"cx"; 0; \
		"cy"; 0; \
		"rx"; 0; \
		"ry"; 0; \
		"stroke"; "black"; \
		"stroke-width"; 1; \
		"stroke-opacity"; 1; \
		"stroke-dasharray"; ""; \
		"stroke-linecap"; "butt"; \
		"stroke-linejoin"; "miter"; \
		"stroke-miterlimit"; 4; \
		"fill"; "none"; \
		"fill-opacity"; 1; \
		"transform"; ""; \
		"stroke-dasharray"; ""; \
		"id"; "tool_5")
	
	$Txt_Dom_object:=DOM Create XML element:C865($Txt_Dom_group; \
		"textArea"; \
		"x"; 0; \
		"y"; 0; \
		"width"; 0; \
		"height"; 0; \
		"font-family"; $fontFamily; \
		"font-size"; $fontSize; \
		"fill"; $fill; \
		"fill-opacity"; 1; \
		"stroke"; $stroke; \
		"stroke-width"; 1; \
		"stroke-opacity"; 1; \
		"display-align"; "auto"; \
		"text-decoration"; "none"; \
		"font-style"; "normal"; \
		"font-weight"; "normal"; \
		"text-align"; "start"; \
		"transform"; ""; \
		"id"; "tool_6")
	
	DOM SET XML ELEMENT VALUE:C868($Txt_Dom_object; "")
	
	$Txt_Dom_object:=DOM Create XML element:C865($Txt_Dom_group; \
		"rect"; \
		"x"; 0; \
		"y"; 0; \
		"width"; 0; \
		"height"; 0; \
		"stroke"; $stroke; \
		"stroke-width"; 1; \
		"stroke-opacity"; 0.7; \
		"stroke-dasharray"; "1,1"; \
		"fill"; "none"; \
		"transform"; ""; \
		"id"; "text_rect")
	//}
	
	var $file : 4D:C1709.File
	$file:=File:C1566("/RESOURCES/images/your image here.jpg")
	var $jpg : 4D:C1709.Blob
	$jpg:=$file.getContent()
	var $encodedJpg : Text
	BASE64 ENCODE:C895($jpg; $encodedJpg)
	$Txt_buffer:="data:image/jpeg;base64,"+$encodedJpg
	
	$Txt_Dom_object:=DOM Create XML element:C865($Txt_Dom_group; \
		"image"; \
		"x"; 0; \
		"y"; 0; \
		"width"; 0; \
		"height"; 0; \
		"xlink:href"; $Txt_buffer; \
		"preserveAspectRatio"; "none"; \
		"transform"; ""; \
		"id"; "tool_7")
	
	$Txt_Dom_object:=DOM Create XML element:C865($Txt_Dom_group; \
		"rect"; \
		"x"; 0; \
		"y"; 0; \
		"width"; 0; \
		"height"; 0; \
		"stroke"; $stroke; \
		"stroke-width"; 1; \
		"stroke-opacity"; 0.7; \
		"stroke-dasharray"; "1,1"; \
		"fill"; "rgb(255,0,0)"; \
		"fill-opacity"; 0.1; \
		"transform"; ""; \
		"id"; "image_rect")
	//}
	
	$Txt_Dom_object:=DOM Create XML element:C865($Txt_Dom_group; \
		"rect"; \
		"x"; 0; \
		"y"; 0; \
		"width"; 0; \
		"height"; 0; \
		"fill"; "black"; \
		"fill-opacity"; 0.2; \
		"id"; "tool_99")
	
	$Txt_Dom_group:=DOM Create XML element:C865($Txt_Dom_group; \
		"g"; \
		"visibility"; "hidden"; \
		"id"; "templateHandle")
	
	ARRAY TEXT:C222($tTxt_handleNames; 8)
	$tTxt_handleNames{1}:="handle_tl"
	$tTxt_handleNames{2}:="handle_tm"
	$tTxt_handleNames{3}:="handle_tr"
	$tTxt_handleNames{4}:="handle_ml"
	$tTxt_handleNames{5}:="handle_mr"
	$tTxt_handleNames{6}:="handle_bl"
	$tTxt_handleNames{7}:="handle_bm"
	$tTxt_handleNames{8}:="handle_br"
	
	For ($Lon_i; 1; 8)
		
		$Txt_Dom_object:=DOM Create XML element:C865($Txt_Dom_group; \
			"circle"; \
			"cx"; 0; \
			"cy"; 0; \
			"r"; 3.5; \
			"stroke"; $stroke; \
			"fill"; $fill; \
			"fill-opacity"; 1; \
			"id"; $tTxt_handleNames{$Lon_i})
		
	End for 
	
	$Txt_Dom_group:=DOM Create XML element:C865($Txt_Dom_root; \
		"g"; \
		"id"; "Handles")
	
End if 