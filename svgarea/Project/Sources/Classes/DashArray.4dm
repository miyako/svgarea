property values : Collection

Class constructor
	
	This:C1470._values:=This:C1470._load()
	
Function get values() : Collection
	
	return This:C1470._values
	
Function getPicture($dashArray : Text) : Picture
	
	var $find : Collection
	$find:=This:C1470.values.query("dashArray == :1"; $dashArray)
	
	return $find.length=0 ? This:C1470.values[0].picture : $find[0].picture
	
Function _load() : Collection
	
	var $dasharrays : Collection
	$dasharrays:=[]
	
	var $dashArrayFolder : 4D:C1709.Folder
	$dashArrayFolder:=Folder:C1567("/RESOURCES/dasharray/")
	
	var $image : Picture
	var $file : 4D:C1709.File
	var $dom; $template; $dashArray : Text
	For each ($file; $dashArrayFolder.files(fk ignore invisible:K87:22).orderBy("name"))
		$dom:=DOM Parse XML source:C719($file.platformPath)
		$template:=DOM Find XML element by ID:C1010($dom; "template")
		DOM GET XML ATTRIBUTE BY NAME:C728($template; "stroke-dasharray"; $dashArray)
		DOM CLOSE XML:C722($dom)
		READ PICTURE FILE:C678($file.platformPath; $image)
		$dasharrays.push({path: $file.path; picture: $image; dashArray: $dashArray})
	End for each 
	
	return $dasharrays