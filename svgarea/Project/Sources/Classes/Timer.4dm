property isTimerRunning : Boolean
property MouseX : Integer
property MouseY : Integer
property isMouseDown : Boolean

Class constructor
	
	This:C1470._isTimerRunning:=False:C215
	
Function get isTimerRunning() : Boolean
	
	return This:C1470._isTimerRunning
	
Function start() : cs:C1710.Timer
	
	This:C1470._isTimerRunning:=True:C214
	SET TIMER:C645(-1)
	
	return This:C1470
	
Function stop() : cs:C1710.Timer
	
	This:C1470._isTimerRunning:=False:C215
	SET TIMER:C645(0)
	
	return This:C1470
	
Function get MouseX() : Integer
	
	return This:C1470._MouseX
	
Function get MouseY() : Integer
	
	return This:C1470._MouseY
	
Function get isMouseDown() : Boolean
	
	return This:C1470._isMouseDown
	
Function update() : cs:C1710.Timer
	
	var $mouseX; $mouseY; $mouseB : Integer
	GET MOUSE:C468($mouseX; $mouseY; $mouseB; *)
	CONVERT COORDINATES:C1365($mouseX; $mouseY; XY Screen:K27:7; XY Current form:K27:5)
	
	var $x; $y; $right; $bottom : Integer
	OBJECT GET COORDINATES:C663(*; "area"; $x; $y; $right; $bottom)
	
	$mouseX-=$x
	$mouseY-=$y
	$right-=$x
	$bottom-=$y
	
	Case of 
		: ($mouseX<0)
			$mouseX:=0
		: (Form:C1466.timer.MouseX>$right)
			$mouseX:=$right
	End case 
	
	Case of 
		: ($mouseY<0)
			$mouseY:=0
		: ($mouseY>$bottom)
			$mouseY:=$bottom
	End case 
	
	This:C1470._isMouseDown:=Bool:C1537($mouseB)
	This:C1470._MouseX:=$mouseX
	This:C1470._MouseY:=$mouseY
	
	return This:C1470