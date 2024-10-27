#Requires AutoHotkey v2.0

GetColor(x, y)
{
    CoordMode 'Pixel', 'Client'
    colorRGB := PixelGetColor(x, y)
    colorStr := SubStr(colorRGB, -6)
    return colorStr
}


global lastColorStr := ""
global lastColorStr1 := ""
global stoped := false
global logFileName := "colorLog_1_1"
global logFileName1 := "colorLog_1_11"

logUniqueColor() {
    global lastColorStr
    global lastColorStr1
    global logFileName
    global logFileName1
    while (1 && !stoped) {
        colorStr := GetColor(1, 1)
        colorStr1 := GetColor(1, 11)

        if (lastColorStr != colorStr) {
            OutputDebug "#" colorStr '`n'
            FileAppend "#" colorStr '`n', logFileName, "UTF-8"
            lastColorStr := colorStr
        }

        if (lastColorStr1 != colorStr1) {
            OutputDebug "#" colorStr1 '`n'
            FileAppend "#" colorStr1 '`n', logFileName1, "UTF-8"
            lastColorStr1 := colorStr1
        }
    }
}

4:: {
    stoped := false
    logUniqueColor()
}

5:: {
    global stoped
    stoped := true
}

0:: {
    ExitApp
}