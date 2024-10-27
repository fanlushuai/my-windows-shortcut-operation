#Requires AutoHotkey v2.0

Log(msg) {
    OutputDebug msg '`n'
}

; 沉淀常用函数。
clickIfImageInWindow(imagePath, windowUniqueFlag) {
    Log imagePath
    Log windowUniqueFlag
    lastCoordMode := CoordMode("Pixel", "Client")
    WinGetClientPos &X, &Y, &W, &H, windowUniqueFlag
    Log X '-' Y '-' W '-' H
    found := ImageSearch(&imageX, &imageY, X, Y, W, H, imagePath)
    CoordMode("Pixel", lastCoordMode)
    Log found
    Log imageX '-' imageY
    if found {
        Click imageX, imageY
        return true
    }
    return false
}

a:: clickIfImageInWindow "image.png", "ahk_exe WeChat.exe"

cmd(cmdStr) {
    Run A_ComSpec ' /c' cmdStr, , 'Hide'
}