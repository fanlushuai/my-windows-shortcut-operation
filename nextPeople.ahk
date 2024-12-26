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
    found := ImageSearch(&imageX, &imageY, 0, 0, W, H, imagePath)
    CoordMode("Pixel", lastCoordMode)
    Log found
    Log imageX '-' imageY
    if found {
        Log 'd'
        Click imageX, imageY
        return true
    }
    return false
}


ClickNextPeople(imagePath, W, H) {
    lastCoordMode := CoordMode("Pixel", "Client")
    Log W '-' H
    found := ImageSearch(&imageX, &imageY, 0, 0, W, H, imagePath)
    CoordMode("Pixel", lastCoordMode)
    if (found) {
        Log imageX
        Log imageY
        if (imageY + 140 > H) {
            Log '达到底部边缘，滚动'
            MouseMove imageX + 150, imageY - 200
            Sleep 300
            Send "{WheelDown 5}"
            Sleep 1200
            return ClickNextPeople(imagePath, W, H)
        }
        ; 微信联系人的，宽度为70左右。截图位置大概在50左右。所以向下移动50，正好，在下一个联系人的30位置。
        Click imageX + 50, imageY + 70
        return true
    }
    return false
}


nextPeople() {
    step1Ok := clickIfImageInWindow(A_ScriptDir '\images_source\1.png', "ahk_exe WeChat.exe")
    if (step1Ok) {
        OutputDebug '1ok'
        Sleep 300
        WinGetClientPos &X, &Y, &W, &H, "ahk_exe WeChat.exe"
        step2Ok := ClickNextPeople('*20 ' A_ScriptDir '\images_source\2.png', 300, H)

        if (step2Ok == false) {
            ; 有时候到达底部，2图像找不到。使用22图像再找一次
            step2Ok := ClickNextPeople('*20 ' A_ScriptDir '\images_source\22.png', 300, H)
        }

        if (step2Ok) {
            OutputDebug '2ok'
            Sleep 300
            step3Ok := clickIfImageInWindow(A_ScriptDir '\images_source\3.png', "ahk_exe WeChat.exe")
            if (step3Ok) {
                OutputDebug '3ok'
            }
        }
    }
}


; 1:: clickIfImageInWindow(A_ScriptDir '\images_source\1.png', "ahk_exe WeChat.exe")
; 2:: {
;     WinGetClientPos &X, &Y, &W, &H, "ahk_exe WeChat.exe"

;     ClickNextPeople('*20 ' A_ScriptDir '\images_source\2.png', 300, H)
; }
; 3:: clickIfImageInWindow(A_ScriptDir '\images_source\3.png', "ahk_exe WeChat.exe")

4:: nextPeople


; 5:: {
;     Send "{WheelDown 5}"
; }