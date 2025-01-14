![version](https://img.shields.io/badge/version-20%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/svgarea)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/svgarea/total)

# svgarea
replica of [4D v12 SVG Area widget component](https://github.com/vdelachaux/SVG)

## dependencies.json

 ```json
{
    "dependencies": {
        "svgarea": {
            "github": "miyako/svgarea",
            "version": "*"
        }
    }
}
```

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
