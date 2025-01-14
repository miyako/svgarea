var $event : Object
$event:=FORM Event:C1606

Case of 
	: ($event.code=On Load:K2:1)
		
		OBJECT SET FONT:C164(*; "text"; Form:C1466.fontFamily)
		OBJECT SET FONT SIZE:C165(*; "text"; Form:C1466.fontSize)
		
		var $style : Integer
		If (Form:C1466.fontStyle="italic") || (Form:C1466.fontStyle="oblique")
			$style+=Italic:K14:3
		End if 
		If (Form:C1466.fontWeight="bold@") || (Num:C11(Form:C1466.fontWeight)>400)
			$style+=Bold:K14:2
		End if 
		If (Form:C1466.textDecoration="underline")
			$style+=Underline:K14:4
		End if 
		
		OBJECT SET FONT STYLE:C166(*; "text"; $style)
		OBJECT SET RGB COLORS:C628(*; "text"; Form:C1466.fill)
		GOTO OBJECT:C206(*; "text")
		HIGHLIGHT TEXT:C210(*; "text"; 1; Length:C16(Form:C1466.text)+1)
		
	: ($event.code=On Losing Focus:K2:8)
		
		ACCEPT:C269
		
	: ($event.code=On Unload:K2:2)
		
		If (OBJECT Get name:C1087(Object with focus:K67:3)=OBJECT Get name:C1087(Object current:K67:2))
			Form:C1466.text:=Get edited text:C655
		End if 
		
End case 