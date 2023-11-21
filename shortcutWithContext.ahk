#Requires AutoHotkey v2.0-a

; 在vscode中使用vim键位，通过esc切换到normal模式的时候，希望输入法切换到英文。
#HotIf WinActive("ahk_exe Code.exe")

!j::NumpadDown

!k::NumpadUp

~Esc:: ToEnglishWithSoug()

CapsLock:: {
    Send "{Esc}"
    ToEnglishWithSoug()
}

#HotIf WinActive("ahk_exe idea64.exe")

~Esc:: ToEnglishWithSoug()

CapsLock:: {
    Send "{Esc}"
    ToEnglishWithSoug()
}
#HotIf WinActive("ahk_exe uTools.exe")

;; 切换翻译窗口。在utool上快捷键设置的为ctrl+alt+q，然后其没有提供最小化的功能
;; 在google上，进行crtl+n/p， 切换
^!q::!Esc

^n:: Send "{Down}"

^p:: Send "{Up}"

Esc:: Send "{Esc 3}" ;
#HotIf WinActive("ahk_exe chrome.exe") ;配合地址栏，和搜索栏，以及surfingkeys。使用ctrl+n 和p 来切换下拉菜单


^n:: Send "{ Down }"

^p:: Send "{ Up }"

~Esc:: Send "{ Esc 2 }" ; 两次Esc，从地址栏回到页面选中

#HotIf
; #IfWinActive ahk_exe chrome.exe ; 配合地址栏，和搜索栏，以及surfingkeys。使用ctrl+n 和p 来切换下拉菜单

;     ^n::yyy()

;     ^p::Send , {Up}

;     ~Esc::Send, {Esc 2} ; 两次Esc，从地址栏回到页面选中
; #IfWinActive ; 关闭上下文敏感

; 完全不可行。controlgetfocus无法获取chrome内的东西。
; xxx(){
;     activeWindow := WinExist("A")
; ControlGetFocus, focusedControl, ahk_id %activeWindow%

; if(ErrorLevel) {
;     MsgBox, Couldn't get focusedControl
; } else {
;     ControlGetText, focusText, %focusedControl%

;     if(ErrorLevel) {
;         ControlGetText, focusText,, ahk_id %activeWindow%
;         Msgbox, Focused window text: %focusText%
;     } else {
;         Msgbox, Focused control text: %focusText%
;     }

; }
; return
; }

; 无障碍服务看似可行，实际上感觉。。。。不太行。
; #Include %A_ScriptDir%\Acc.ahk

; GetElementByName(AccObj, name) {
;     if (AccObj.accName(0) = name)
;        return AccObj

;     for k, v in Acc_Children(AccObj)
;        if IsObject(obj := GetElementByName(v, name))
;           return obj
;  }

;  GetElementByText(AccObj, text) {
; 	try
;    if (AccObj.accValue(0) = text)
;       return AccObj

;    for k, v in Acc_Children(AccObj)
;       if IsObject(obj := GetElementByText(v, text))
;          return obj
; }

; ;  https://www.autohotkey.com/board/topic/103178-how-to-get-the-current-url-in-google-chrome/#entry637687
; ; https://stackoverflow.com/questions/66246503/how-to-detect-whether-a-text-writeable-field-is-focused
; yyy(){
;     hwndChrome := WinExist("A")
; AccChrome := Acc_ObjectFromWindow(hwndChrome)
; AccAddressBar := GetElementByText(AccChrome, "地址和搜索栏")
; MsgBox % AccAddressBar.accValue(0)
; }
