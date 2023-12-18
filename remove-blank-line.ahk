#Requires AutoHotkey v2.0
#SingleInstance Force
KeyHistory 0
SendMode "Input"

global debug := False ;debug 输出开关

getTextSelected() {
    A_Clipboard := ""
    Sleep 10

    Send "^c"
    Sleep 10
    if !ClipWait(2)    ; 最多等待 x s
    {
        MsgBox "剪切板操作失败。确保您选中了文本"
        return
    }

    global debug
    if debug {
        MsgBox A_Clipboard
    }

    return  A_Clipboard
}


paste(text) {
    A_Clipboard := text

    Sleep 10
    Send "^v"
}

trimOneBlankLine(text) {
    text := StrReplace(text, "`r`n`r`n", "`r`n")
    text := StrReplace(text, "`r`n", "`r`n")
    text := StrReplace(text, "`n`n", "`r`n")
    text := StrReplace(text, "`r", "")

    return text
}


trimAllBlankLine(text) {
    text := StrReplace(text, "`r`n`r`n", "`r`n")
    text := StrReplace(text, "`r`n", "`r`n")
    newContent := ""
    Loop parse, text, "`n", "`r"
    {
        line := A_LoopField
        lineTrim := Trim(line)
        if (lineTrim != "")
            newContent .= A_LoopField "`r`n"
    }
    return newContent
}


#HotIf WinActive("ahk_exe winword.exe") or WinActive("ahk_exe wps.exe")

^+s:: {
    Send "^a"          ; 全自动。
    text := getTextSelected()
    text := trimAllBlankLine(text)
    paste(text)
}

F4:: {
    text := getTextSelected()
    text := trimOneBlankLine(text)
    paste(text)
}

#HotIf