//%attributes = {"invisible":true}
#DECLARE() : Object

var $patternsFolder : 4D:C1709.Folder
$patternsFolder:=Folder:C1567("/RESOURCES/patterns/")

var $file : 4D:C1709.File
var $cols; $rows; $i : Integer
$cols:=5
$rows:=0
var $image; $line; $lines : Picture

For each ($file; $patternsFolder.files(fk ignore invisible:K87:22).orderBy("name"))
	READ PICTURE FILE:C678($file.platformPath; $image)
	$i+=1
	$line+=$image
	If ($i%$cols=0)
		$lines/=$line
		$rows+=1
		$line*=0
	End if 
End for each 

If (Picture size:C356($line)#0)
	$lines/=$line
	$rows+=1
End if 

var $format : Text
$format:=[$cols; $rows].join(";")

return {format: $format; picture: $lines}