#Requires AutoHotkey v2.0
; 沉淀常用函数。
; clickIfImageInWindow "image.png", "ahk_exe WeChat.exe"
clickIfImageInWindow(imagePath, windowUniqueFlag) {
    lastCoordMode := CoordMode("Pixel", "Client")
    WinGetClientPos &X, &Y, &W, &H, windowUniqueFlag
    found := ImageSearch(&imageX, &imageY, X, Y, W, H, imagePath)
    CoordMode("Pixel", lastCoordMode)
    if found {
        Click imageX, imageY
        return true
    }
    return false
}

cmd(cmdStr) {
    Run A_ComSpec ' /c' cmdStr, , 'Hide'
}