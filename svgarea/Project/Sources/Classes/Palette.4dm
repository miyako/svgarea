property propertyListWindowTitle : Text

Class constructor
	
	This:C1470._propertyListWindowTitle:=Get localized string:C991("propertyListWindowTitle")
	
Function get propertyListWindowTitle() : Text
	
	return This:C1470._propertyListWindowTitle
	
Function _closeWindow()
	
	ACCEPT:C269
	
Function _activateWindow($form : Object)
	
	Form:C1466.updateCount+=1
	
	Form:C1466.area:=$form.area
	Form:C1466.window:=$form.window
	Form:C1466.event:=$form.event
	Form:C1466.objects:=$form.objects
	Form:C1466.area.grid:=$form.area.grid
	
	var $object; $objectType : Text
	$object:=Form:C1466.objects.currentValue
	var $properties : Object
	$properties:=$form.object
	
	var $i : Integer
	var $dom : Text
	var $x; $y; $rx; $ry; $width; $height : Real
	var $fill : Text
	var $fillOpacity : Real
	var $stroke : Text
	var $strokeWidth; $strokeOpacity : Real
	var $dashArray : Text
	var $id : Text
	var $title : Text
	var $viewportFill : Text
	var $viewportFillOpacity : Real
	var $x1; $y1; $x2; $y2 : Real
	var $strokeLinecap : Text
	var $RGB : Integer
	var $preserveAspectRatio : Text
	
	If ($object#"")
		$dom:=DOM Find XML element by ID:C1010(Form:C1466.area.DOM; $object)
		DOM GET XML ELEMENT NAME:C730($dom; $objectType)
		DOM GET XML ATTRIBUTE BY NAME:C728($dom; "id"; $id)
		Form:C1466.id:=$id
		OBJECT SET TITLE:C194(*; "id#0"; Get localized string:C991("id"))
		OBJECT SET ENTERABLE:C238(*; "input.id"; False:C215)
		OBJECT SET RGB COLORS:C628(*; "input.id"; Foreground color:K23:1; Background color none:K23:10)
	Else 
		DOM GET XML ATTRIBUTE BY NAME:C728(Form:C1466.area.DOM; "title"; $title)
		Form:C1466.id:=$title
		OBJECT SET TITLE:C194(*; "id#0"; Get localized string:C991("title"))
		OBJECT SET ENTERABLE:C238(*; "input.id"; True:C214)
		OBJECT SET RGB COLORS:C628(*; "input.id"; Foreground color:K23:1; Background color:K23:2)
	End if 
	
	GOTO OBJECT:C206(*; "")
	
	Case of 
		: ($object="")
			FORM GOTO PAGE:C247(6)
			
			DOM GET XML ATTRIBUTE BY NAME:C728(Form:C1466.area.DOM; "width"; $width)
			DOM GET XML ATTRIBUTE BY NAME:C728(Form:C1466.area.DOM; "height"; $height)
			DOM GET XML ATTRIBUTE BY NAME:C728(Form:C1466.area.DOM; "viewport-fill"; $viewportFill)
			DOM GET XML ATTRIBUTE BY NAME:C728(Form:C1466.area.DOM; "viewport-fill-opacity"; $viewportFillOpacity)
			Form:C1466.width:=$width
			Form:C1466.height:=$height
			Form:C1466.viewportFill:=$viewportFill
			Form:C1466.viewportFillOpacity:=$viewportFillOpacity*100
			
			var $templateName : Text
			$templateName:=Form:C1466.documents.findTemplate($width; $height)
			Form:C1466.documents.selectTemplate($templateName)
			Form:C1466.templates.index:=Form:C1466.templates.values.indexOf($templateName)
			
			$RGB:=tool_colorToLong(Form:C1466.viewportFill)
			OBJECT SET RGB COLORS:C628(*; "rect.document.viewportFill"; $RGB; $RGB)
			
		: ($objectType="image")
			
			FORM GOTO PAGE:C247(5)
			
			Form:C1466.x:=$properties.x
			Form:C1466.y:=$properties.y
			Form:C1466.width:=$properties.width
			Form:C1466.height:=$properties.height
			
			$preserveAspectRatio:=$properties.preserveAspectRatio
			
			ARRAY LONGINT:C221($pos; 0)
			ARRAY LONGINT:C221($len; 0)
			If (Match regex:C1019("(\\S+)\\s+(meet|slice)?"; $preserveAspectRatio; 1; $pos; $len))
				var $value; $option : Text
				$value:=Substring:C12($preserveAspectRatio; $pos{1}; $len{1})
				$option:=Substring:C12($preserveAspectRatio; $pos{2}; $len{2})
				
				Case of 
					: ($option="slice")
						Form:C1466.meet:=False:C215
						Form:C1466.slice:=True:C214
					Else 
						Form:C1466.meet:=True:C214
						Form:C1466.slice:=False:C215
				End case 
				
				Form:C1466.preserveAspectRatio.index:=Form:C1466.preserveAspectRatio.values.indexOf($value)
				
			End if 
			
		: ($objectType="textArea")
			
			FORM GOTO PAGE:C247(4)
			
			Form:C1466.x:=$properties.x
			Form:C1466.y:=$properties.y
			Form:C1466.width:=$properties.width
			Form:C1466.height:=$properties.height
			Form:C1466.fill:=$properties.fill
			Form:C1466.fillOpacity:=$properties.fillOpacity*100
			Form:C1466.fontSize:=$properties.fontSize
			
			Form:C1466.displayAlign.index:=Form:C1466.displayAlign.values.indexOf($properties.displayAlign)
			Form:C1466.fontFamily.index:=Form:C1466.fontFamily.values.indexOf($properties.fontFamily)
			Form:C1466.fontWeight.index:=Form:C1466.fontWeight.values.indexOf($properties.fontWeight)
			Form:C1466.fontStyle.index:=Form:C1466.fontStyle.values.indexOf($properties.fontStyle)
			Form:C1466.textAlign.index:=Form:C1466.textAlign.values.indexOf($properties.textAlign)
			Form:C1466.textDecoration.index:=Form:C1466.textDecoration.values.indexOf($properties.textDecoration)
			
			$RGB:=tool_colorToLong(Form:C1466.fill)
			OBJECT SET RGB COLORS:C628(*; "rect.textArea.fill"; $RGB; $RGB)
			
		: ($objectType="ellipse")
			
			FORM GOTO PAGE:C247(3)
			
			Form:C1466.cx:=$properties.cx
			Form:C1466.cy:=$properties.cy
			Form:C1466.rx:=$properties.rx
			Form:C1466.ry:=$properties.ry
			Form:C1466.fill:=$properties.fill
			Form:C1466.fillOpacity:=$properties.fillOpacity*100
			Form:C1466.stroke:=$properties.stroke
			Form:C1466.strokeWidth:=$properties.strokeWidth
			Form:C1466.strokeOpacity:=$properties.strokeOpacity*100
			Form:C1466.dashArray:=$properties.dashArray
			
			OBJECT SET VALUE:C1742("image.ellipse.dashArray"; Form:C1466.dasharray.getPicture(Form:C1466.dashArray))
			
			$RGB:=tool_colorToLong(Form:C1466.fill)
			OBJECT SET RGB COLORS:C628(*; "rect.ellipse.fill"; $RGB; $RGB)
			
			$RGB:=tool_colorToLong(Form:C1466.stroke)
			OBJECT SET RGB COLORS:C628(*; "rect.ellipse.stroke"; $RGB; $RGB)
			
		: ($objectType="line")
			
			FORM GOTO PAGE:C247(2)
			
			Form:C1466.x1:=$properties.x1
			Form:C1466.y1:=$properties.y1
			Form:C1466.x2:=$properties.x2
			Form:C1466.y2:=$properties.y2
			Form:C1466.stroke:=$properties.stroke
			Form:C1466.strokeWidth:=$properties.strokeWidth
			Form:C1466.strokeOpacity:=$properties.strokeOpacity*100
			Form:C1466.dashArray:=$properties.dashArray
			
			Form:C1466.linecap.index:=Form:C1466.linecap.values.indexOf($properties.strokeLinecap)
			
			OBJECT SET VALUE:C1742("image.line.dashArray"; Form:C1466.dasharray.getPicture(Form:C1466.dashArray))
			
			$RGB:=tool_colorToLong(Form:C1466.stroke)
			OBJECT SET RGB COLORS:C628(*; "rect.line.stroke"; $RGB; $RGB)
			
		: ($objectType="rect")
			
			FORM GOTO PAGE:C247(1)
			
			Form:C1466.x:=$properties.x
			Form:C1466.y:=$properties.y
			Form:C1466.width:=$properties.width
			Form:C1466.height:=$properties.height
			Form:C1466.rx:=$properties.rx
			Form:C1466.ry:=$properties.ry
			Form:C1466.fill:=$properties.fill
			Form:C1466.fillOpacity:=$properties.fillOpacity*100
			Form:C1466.stroke:=$properties.stroke
			Form:C1466.strokeWidth:=$properties.strokeWidth
			Form:C1466.strokeOpacity:=$properties.strokeOpacity*100
			Form:C1466.dashArray:=$properties.dashArray
			
			OBJECT SET VALUE:C1742("image.rect.dashArray"; Form:C1466.dasharray.getPicture(Form:C1466.dashArray))
			
			$RGB:=tool_colorToLong(Form:C1466.fill)
			OBJECT SET RGB COLORS:C628(*; "rect.rect.fill"; $RGB; $RGB)
			
			$RGB:=tool_colorToLong(Form:C1466.stroke)
			OBJECT SET RGB COLORS:C628(*; "rect.rect.stroke"; $RGB; $RGB)
			
	End case 
	
Function activate($event : cs:C1710.Event; $objects : cs:C1710.Objects; $area : cs:C1710.Area) : cs:C1710.Palette
	
	var $window : Integer
	$window:=This:C1470.getWindow()
	
	If ($window#0)
		CALL FORM:C1391($window; This:C1470._activateWindow; \
			{window: Current form window:C827; \
			event: $event; \
			object: $objects._createObjectPropertiesSnapshot(); \
			objects: $objects._createPopupDataSource(); \
			area: $area.toObject()})
	Else 
		This:C1470.open($event; \
			$objects._createObjectPropertiesSnapshot(); \
			$objects._createPopupDataSource(); \
			$area.toObject())
	End if 
	
	return This:C1470
	
Function getWindow() : Integer
	
	ARRAY LONGINT:C221($windows; 0)
	WINDOW LIST:C442($windows; *)
	
	var $i; $process; $window : Integer
	var $windowTitle; $propertyListWindowTitle : Text
	$propertyListWindowTitle:=This:C1470.propertyListWindowTitle
	
	For ($i; 1; Size of array:C274($windows))
		$window:=$windows{$i}
		$process:=Window process:C446($window)
		$windowTitle:=Get window title:C450($window)
		If ($process=Current process:C322) && ($windowTitle=$propertyListWindowTitle)
			return $window
		End if 
	End for 
	
	return 0
	
Function close() : cs:C1710.Palette
	
	var $window : Integer
	$window:=This:C1470.getWindow()
	
	If ($window#0)
		CALL FORM:C1391($window; This:C1470._closeWindow)
	End if 
	
	return This:C1470
	
Function open($event : cs:C1710.Event; $object : Object; $objects : Object; $area : Object) : cs:C1710.Palette
	
	C_LONGINT:C283($window)
	$window:=Open form window:C675("svgArea_propertyList"; Palette form window:K39:9; On the right:K39:3; At the top:K39:5)  //;*)
	DIALOG:C40("svgArea_propertyList"; \
		{window: Current form window:C827; \
		event: $event; \
		object: $object; \
		objects: $objects; \
		area: $area}; *)
	
	return This:C1470
	
Function toggle($event : cs:C1710.Event; $objects : cs:C1710.Objects; $area : cs:C1710.Area) : cs:C1710.Palette
	
	var $window : Integer
	$window:=This:C1470.getWindow()
	
	If ($window#0)
		CALL FORM:C1391($window; This:C1470._closeWindow)
	Else 
		This:C1470.open(\
			$event; \
			$objects._createObjectPropertiesSnapshot(); \
			$objects._createPopupDataSource(); \
			$area.toObject())
	End if 
	
	return This:C1470
	
Function update($event : cs:C1710.Event; $objects : cs:C1710.Objects; $area : cs:C1710.Area; $fromDom : Boolean) : cs:C1710.Palette
	
	var $window : Integer
	$window:=This:C1470.getWindow()
	
	If ($window#0)
		CALL FORM:C1391($window; This:C1470._activateWindow; \
			{window: Current form window:C827; \
			event: $event; \
			object: $objects._createObjectPropertiesSnapshot($fromDom); \
			objects: $objects._createPopupDataSource(); \
			area: $area.toObject()})
	End if 