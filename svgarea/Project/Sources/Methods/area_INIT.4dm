//%attributes = {"invisible":true}
<>Txt_fillColor:="rgb(255,255,255)"
<>Txt_strokeColor:="rgb(255,0,0)"
<>Lon_strokeWidth:=3

<>Txt_DefaultOnErrorMethod:="noError"  //this should be "" but in a beta version lets use "noError" :-)
ON ERR CALL:C155(<>Txt_DefaultOnErrorMethod)

Lon_round:=20
Txt_fontName:=default_font_name
Lon_fontSize:=24