C_LONGINT:C283($event)
C_TEXT:C284($dom)
C_LONGINT:C283($type)
C_PICTURE:C286($picture)
C_BLOB:C604($blob)

$event:=Form event code:C388

Case of 
	: ($event=On Load:K2:1)
		
		If (Form:C1466=Null:C1517)
			ALERT:C41("the subform data source must NOT be set to 'object' in the form editor!")
		Else 
			
			Form:C1466.defaults:={\
				rx: 20; \
				ry: 20; \
				fontSize: 24; \
				fontFamily: default_font_name; \
				fill: "rgb(255,0,0)"; \
				stroke: "rgb(255,0,0)"; \
				strokeWidth: 3}
			
			Compiler_area
			area_INIT
			
			Form:C1466.objects:=cs:C1710.Objects.new()
			Form:C1466.selection:=cs:C1710.Selection.new()
			Form:C1466.area:=cs:C1710.Area.new()
			Form:C1466.event:=cs:C1710.Event.new()
			Form:C1466.palette:=cs:C1710.Palette.new()
			Form:C1466.timer:=cs:C1710.Timer.new()
			Form:C1466.area_Get_version:=area_Get_version
			Form:C1466.activated:=True:C214
			Form:C1466.area.setDOM(area_NEW_CANVAS)
			var $SVG : Picture
			SVG EXPORT TO PICTURE:C1017(Form:C1466.area.DOM; $SVG)
			Form:C1466.SVG:=$SVG
			
			Form:C1466.event.setCurrentTool("select").notifyContainer()
			
		End if 
		
	: ($event=On Timer:K2:25)
		
		area_on_timer
		
	: ($event=On Unload:K2:2)
		
		Form:C1466.objects.clear()
		Form:C1466.selection.clear()
		
		WRAP_DOM_CLOSE_XML(Form:C1466.area.DOM)
		
		Form:C1466.palette.close()
		
	: ($event=On Activate:K2:9)
		
		Form:C1466.area.onActivate()
		
	: ($event=On Deactivate:K2:10)
		
		Form:C1466.area.onDeactivate()
		
	: ($event=On Bound Variable Change:K2:52)
		
		If (Not:C34(Form:C1466.event.touched))  //to avoid infinite loops
			
			var $container : Variant
			$container:=OBJECT Get subform container value:C1785
			var $type : Integer
			$type:=Value type:C1509($container)
			
			Case of 
				: ($type=Is text:K8:3)
					
					Area_SwapDomTree($container)
					
				: ($type=Is picture:K8:10)
					
					$picture:=$container
					var $OK1; $OK2 : Integer
					PICTURE TO BLOB:C692($picture; $blob; ".svg")
					$OK1:=OK
					$dom:=DOM Parse XML variable:C720($blob)
					$OK2:=OK
					
					If ($OK1=1) && ($OK2=1)
						
						Area_SwapDomTree($dom)
						
					Else 
						//DO NOTHING !!!
					End if 
					
			End case 
			
			
		Else 
			Form:C1466.event.untouch()
		End if 
		
	Else 
		
		TRACE:C157
		
End case 