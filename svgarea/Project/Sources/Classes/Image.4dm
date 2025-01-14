property extensions : Text

Class constructor
	
	This:C1470._codecs:=[\
		{extension: ".png"; MIME: "image/png"}; \
		{extension: ".jpg"; MIME: "image/jpeg"}; \
		{extension: ".svg"; MIME: "image/svg+xml"}; \
		{extension: ".tif"; MIME: "image/tiff"}; \
		{extension: ".bmp"; MIME: "image/bmp"}; \
		{extension: ".gif"; MIME: "image/gif"}; \
		{extension: ".webp"; MIME: "image/webp"}]
	
Function get codecs() : Collection
	
	return This:C1470._codecs
	
Function get extensions() : Text
	
	return This:C1470._codecs.extract("extension").join(";")
	
Function toDataUri($picture : Picture) : Text
	
	ARRAY TEXT:C222($formats; 0)
	GET PICTURE FORMATS:C1406($picture; $formats)
	
	var $MIME : Text
	var $codec : Object
	For each ($codec; This:C1470.codecs)
		If (Find in array:C230($formats; $codec.extension)#-1)
			$MIME:=$codec.MIME
			break
		End if 
	End for each 
	
	If ($MIME#"")
		var $data : Blob
		PICTURE TO BLOB:C692($picture; $data; $MIME)
		var $encodedPicture : Text
		BASE64 ENCODE:C895($data; $encodedPicture)
		return "data:"+$MIME+";base64,"+$encodedPicture
	End if 