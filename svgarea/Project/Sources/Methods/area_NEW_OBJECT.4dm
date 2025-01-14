//%attributes = {"invisible":true}
#DECLARE($tool : Text; $Lon_event : Integer)

C_BOOLEAN:C305($Boo_dasharray; $Boo_fill; $Boo_stroke)
C_LONGINT:C283($height; $width)
C_REAL:C285($cx; $cy; $rx; $ry)
C_TEXT:C284($Txt_toolID)

C_LONGINT:C283($ClickX; $ClickY)
C_LONGINT:C283($MouseX; $MouseY)

var $scrollX; $scrollY : Integer
OBJECT GET SCROLL POSITION:C1114(*; "area"; $scrollY; $scrollX)

var $constraints : Boolean
$constraints:=Shift down:C543

Case of 
	: ($tool="select")
		$Txt_toolID:="tool_99"
	: ($tool="line")
		$Txt_toolID:="tool_2"
	: ($tool="rect")
		$Txt_toolID:="tool_3"
	: ($tool="round")
		$Txt_toolID:="tool_4"
	: ($tool="ellipse")
		$Txt_toolID:="tool_5"
	: ($tool="text")
		$Txt_toolID:="tool_6"
	: ($tool="image")
		$Txt_toolID:="tool_7"
End case 

If (Form:C1466.MouseX>=0) && (Form:C1466.MouseY>=0)
	
	Case of 
		: (Form:C1466.MouseX>=0) && ((Form:C1466.MouseX>=Form:C1466.ClickX) || ($tool="line"))
			
			$ClickX:=Form:C1466.ClickX
			$MouseX:=Form:C1466.MouseX
			
		: (Form:C1466.MouseX>=0) && (Form:C1466.MouseX<Form:C1466.ClickX)
			
			$ClickX:=Form:C1466.MouseX
			$MouseX:=Form:C1466.ClickX
			
	End case 
	
	Case of 
		: (Form:C1466.MouseY>=0) && ((Form:C1466.MouseY>=Form:C1466.ClickY) || ($tool="line"))
			
			$ClickY:=Form:C1466.ClickY
			$MouseY:=Form:C1466.MouseY
			
		: (Form:C1466.MouseY>=0) && (Form:C1466.MouseY<Form:C1466.ClickY)
			
			$ClickY:=Form:C1466.MouseY
			$MouseY:=Form:C1466.ClickY
			
	End case 
	
	If ($Lon_event=On Clicked:K2:4)  // CREATE OBJECT
		
		$MouseX:=$ClickX
		$MouseY:=$ClickY
		
		Case of 
			: ($tool="line")
				
				SVG SET ATTRIBUTE:C1055(*; "area"; \
					$Txt_toolID; \
					"x1"; $ClickX+$scrollX; \
					"x2"; $MouseX+$scrollX; \
					"y1"; $ClickY+$scrollY; \
					"y2"; $MouseY+$scrollY)
				
				$Boo_fill:=False:C215
				$Boo_stroke:=True:C214
				$Boo_dasharray:=True:C214
				
			: ($tool="rect")
				
				SVG SET ATTRIBUTE:C1055(*; "area"; \
					$Txt_toolID; \
					"x"; $ClickX+$scrollX; \
					"y"; $ClickY+$scrollY)
				
				$Boo_fill:=True:C214
				$Boo_stroke:=True:C214
				$Boo_dasharray:=True:C214
				
			: ($tool="round")
				
				SVG SET ATTRIBUTE:C1055(*; "area"; \
					$Txt_toolID; \
					"x"; $ClickX+$scrollX; \
					"y"; $ClickY+$scrollY; \
					"rx"; Lon_round; \
					"ry"; Lon_round)
				$Boo_fill:=True:C214
				$Boo_stroke:=True:C214
				$Boo_dasharray:=True:C214
				
			: ($tool="ellipse")
				
				SVG SET ATTRIBUTE:C1055(*; "area"; \
					$Txt_toolID; \
					"cx"; $ClickX+$scrollX; \
					"cy"; $ClickY+$scrollY)
				
				$Boo_fill:=True:C214
				$Boo_stroke:=True:C214
				$Boo_dasharray:=True:C214
				
			: ($tool="text")
				
				SVG SET ATTRIBUTE:C1055(*; "area"; \
					$Txt_toolID; \
					"x"; $ClickX+$scrollX; \
					"y"; $ClickY+$scrollY; \
					"4D-text"; "Sample text"; \
					"fill"; <>Txt_strokeColor; \
					"fill-opacity"; 1)
				
				//Rect {
				SVG SET ATTRIBUTE:C1055(*; "area"; \
					"text_rect"; \
					"x"; $ClickX+$scrollX; \
					"y"; $ClickY+$scrollY)
				//}
				
				$Boo_fill:=False:C215
				$Boo_stroke:=False:C215
				
			: ($tool="image")
				
				SVG SET ATTRIBUTE:C1055(*; "area"; \
					$Txt_toolID; \
					"x"; $ClickX+$scrollX; \
					"y"; $ClickY+$scrollY)
				
				//Rect {
				SVG SET ATTRIBUTE:C1055(*; "area"; \
					"image_rect"; \
					"x"; $ClickX+$scrollX; \
					"y"; $ClickY+$scrollY)
				//}
				
				$Boo_fill:=False:C215
				$Boo_stroke:=False:C215
				
			: ($tool="select")
				
				SVG SET ATTRIBUTE:C1055(*; "area"; \
					$Txt_toolID; \
					"x"; $ClickX+$scrollX; \
					"y"; $ClickY+$scrollY)
				
			Else 
				
				TRACE:C157
				
		End case 
		
		If ($Boo_stroke)
			
			SVG SET ATTRIBUTE:C1055(*; "area"; \
				$Txt_toolID; \
				"stroke"; <>Txt_strokeColor; \
				"stroke-width"; <>Lon_strokeWidth)
			
		End if 
		
		If ($Boo_fill)
			
			SVG SET ATTRIBUTE:C1055(*; "area"; \
				$Txt_toolID; \
				"fill"; <>Txt_fillColor; \
				"fill-opacity"; 1)
			
		End if 
		
		If ($Boo_dasharray)
			
			SVG SET ATTRIBUTE:C1055(*; "area"; \
				$Txt_toolID; \
				"stroke-dasharray"; "")
			
		End if 
		
		SVG SET ATTRIBUTE:C1055(*; "area"; \
			"svgAreaTools"; \
			"4D-bringToFront"; "true"; \
			"visibility"; "visible")
		
		SVG SET ATTRIBUTE:C1055(*; "area"; \
			"templateHandle"; \
			"visibility"; "hidden")
		
	Else   //draw object 
		
		$width:=Abs:C99($MouseX-$ClickX)
		$height:=Abs:C99($MouseY-$ClickY)
		
		If ($constraints)
			
			Case of 
				: ($tool="line")
					
					If ($width>$height)
						$MouseY:=$ClickY
					Else 
						$MouseX:=$ClickX
					End if 
					
				Else 
					
					If ($width>$height)
						If (Form:C1466.MouseX>=Form:C1466.ClickX)
							$width:=$height
						Else 
							$ClickX:=$ClickX+($width-$height)
							$width:=$height
						End if 
					End if 
					
					If ($height>$width)
						If (Form:C1466.MouseY>=Form:C1466.ClickY)
							$height:=$width
						Else 
							$ClickY:=$ClickY+($height-$width)
							$height:=$width
						End if 
					End if 
					
			End case 
			
		End if 
		
		Case of 
			: ($tool="line")
				
				SVG SET ATTRIBUTE:C1055(*; "area"; \
					$Txt_toolID; \
					"x1"; $ClickX+$scrollX; \
					"x2"; $MouseX+$scrollX; \
					"y1"; $ClickY+$scrollY; \
					"y2"; $MouseY+$scrollY)
				
			: ($tool="rect") || ($tool="round")
				
				SVG SET ATTRIBUTE:C1055(*; "area"; \
					$Txt_toolID; \
					"x"; $ClickX+$scrollX; \
					"y"; $ClickY+$scrollY; \
					"width"; $width; \
					"height"; $height)
				
			: ($tool="ellipse")
				
				$rx:=$width/2
				$ry:=$height/2
				$cx:=$ClickX+$rx
				$cy:=$ClickY+$ry
				
				SVG SET ATTRIBUTE:C1055(*; "area"; \
					$Txt_toolID; \
					"cx"; $cx+$scrollX; \
					"cy"; $cy+$scrollY; \
					"rx"; $rx; \
					"ry"; $ry)
				
			: ($tool="text")
				
				SVG SET ATTRIBUTE:C1055(*; "area"; \
					$Txt_toolID; \
					"x"; $ClickX+$scrollX; \
					"y"; $ClickY+$scrollY; \
					"width"; $width; \
					"height"; $height)
				
				SVG SET ATTRIBUTE:C1055(*; "area"; \
					"text_rect"; \
					"x"; $ClickX+$scrollX; \
					"y"; $ClickY+$scrollY; \
					"width"; $width; \
					"height"; $height)
				
			: ($tool="image")
				
				SVG SET ATTRIBUTE:C1055(*; "area"; \
					$Txt_toolID; \
					"x"; $ClickX+$scrollX; \
					"y"; $ClickY+$scrollY; \
					"width"; $width; \
					"height"; $height)
				
				SVG SET ATTRIBUTE:C1055(*; "area"; \
					"image_rect"; \
					"x"; $ClickX+$scrollX; \
					"y"; $ClickY+$scrollY; \
					"width"; $width; \
					"height"; $height)
				
			: ($tool="select")
				
				SVG SET ATTRIBUTE:C1055(*; "area"; \
					$Txt_toolID; \
					"x"; $ClickX+$scrollX; \
					"y"; $ClickY+$scrollY; \
					"width"; $width; \
					"height"; $height)
				
			Else 
				
				TRACE:C157
				
		End case 
		
	End if 
	
End if 
