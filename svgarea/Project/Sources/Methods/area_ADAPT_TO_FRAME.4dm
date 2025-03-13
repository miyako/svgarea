//%attributes = {"invisible":true}
var $width; $height : Integer
OBJECT GET SUBFORM CONTAINER SIZE:C1148($width; $height)

var $left; $top; $right; $bottom : Integer
OBJECT GET COORDINATES:C663(*; "area"; $left; $top; $right; $bottom)

var $formWidth; $formHeight : Integer
FORM GET PROPERTIES:C674(Current form name:C1298; $formWidth; $formHeight)
var $rightMargin; $bottomMargin : Integer
$rightMargin:=$formWidth-$right
$bottomMargin:=$formHeight-$bottom

var $moveH; $moveV : Integer
$moveH:=$width-$formWidth
$moveV:=$height-$formHeight

If ($moveH>0) || ($moveV>0)
	OBJECT SET COORDINATES:C1248(*; "area"; $left; $top; $width-$rightMargin; $height-$bottomMargin)
End if 

var $objects : Collection
var $object : Text

If ($moveV>0)
	$objects:=[\
		"MouseX"; \
		"MouseY"; \
		"isTimerRunning"; \
		"isResizing"; \
		"isDrawing"; \
		"isSelecting"; \
		"ClickX"; \
		"ClickY"; \
		"hoveredObjectId"]
	For each ($object; $objects)
		OBJECT MOVE:C664(*; $object; 0; $moveV)
	End for each 
End if 

If ($moveH>0)
	$objects:=[\
		"b.arrowRight"; \
		"b.arrowRightShift"; \
		"b.arrowLeft"; \
		"b.arrowLeftShift"; \
		"b.arrowUp"; \
		"b.arrowUpShift"; \
		"b.arrowDown"; \
		"b.arrowDownShift"; \
		"b.viewer"; \
		"b.save"; \
		"b.all"; \
		"b.arrowUpCommandShift"; \
		"b.arrowUpCommand"; \
		"b.arrowDownCommandShift"; \
		"b.arrowDownCommand"; \
		"b.arrowLeftCommandShift"; \
		"b.arrowLeftCommand"; \
		"b.arrowRightCommandShift"; \
		"b.arrowRightCommand"; \
		"b.backspace"; \
		"b.supr"; \
		"b.open"; \
		"b.palette"; \
		"b.new"; \
		"b.enter"; \
		"b.return"; \
		"b.copy"; \
		"b.paste"; \
		"b.cut"; \
		"b.duplicate"]
	For each ($object; $objects)
		OBJECT MOVE:C664(*; $object; $moveH; 0)
	End for each 
End if 
