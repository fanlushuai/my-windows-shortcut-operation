
; 在vscode中使用vim键位，通过esc切换到normal模式的时候，希望输入法切换到英文。
#IfWinActive ahk_exe Code.exe
~Esc::
    Send, ^{F8}
    Send, {Shift}
Return

; 切换翻译窗口。在utool上快捷键设置的为ctrl+alt+q，然后其没有提供最小化的功能
#IfWinActive ahk_exe uTools.exe
^!q::
    SendInput, !{Esc} 
Return
