# svgarea
replica of [4D v12 SVG Area widget component](https://github.com/vdelachaux/SVG)

## technical updates 

* use standard Xpath notation for XML
* use object notation
* use `Form`
* use `DIALOG` with `Form`
* use `CALL FORM` instead of `CALL PROCESS`
* use `CALL FORM` instead of `SET TIMER`
* use `CONVERT COORDINATES`
* use `OBJECT Get subform container value` instead of `OBJECT Get pointer(Object subform container)`
* use object data source for popup instead of `New list`

## removed features

* pattern tool (was not working anyway)
* original image size proportional (was not working anyway)
* embed image (always enabled)
* align tool in palette (hidden buttons; feature available in main editor)
