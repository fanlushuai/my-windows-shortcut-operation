;=====================CapsLock 系列.主要用于操作桌面和窗口.CapsLock具备得天独厚的单手操作=============

; CapsLock 重新映射，防止误触发，导致输入法的切换，直接禁用。并增加难度触发实际输入法大小切换。
; https://www.autohotkey.com/board/topic/51215-completely-disable-capslock/
SetCapsLockState , alwaysoff

; 切换桌面  && 切换当前窗口到另外一个虚拟桌面
; 编写在一起原因，无法3个组合按键，只能采用检测状态的方式
; CapsLock & s::
;   if GetKeyState("Alt", "P"){
; 		MoveCurrentWindowToDesktop(1)
;   }else{
; 	  	switchDesktopByNumber(1)
;   }
;   return

; ; ^#t::Test()

; CapsLock & d::
;   if GetKeyState("Alt", "P"){
; 		MoveCurrentWindowToDesktop(2)
;   }else{
; 	  	switchDesktopByNumber(2)
;   }
;   return

; CapsLock & f::
;   if GetKeyState("Alt", "P"){
; 		MoveCurrentWindowToDesktop(3)
;   }else{
; 	  	switchDesktopByNumber(3)
;   }
;   return

; CapsLock & e::
;   if GetKeyState("Alt", "P"){
; 		MoveCurrentWindowToDesktop(4)
;   }else{
; 	  	switchDesktopByNumber(4)
;   }
;   return

; 切换到上一个桌面。当使用两个虚拟桌面的时候，只需要循环按住就可以了。
; 因为lastopen不能保证在初始化的时候，进行loop。所以，需要next的方式。
CapsLock & f::
if GetKeyState("Alt", "F"){
  ; MoveCurrentWindowToLastOpened()
  MoveCurrentWindowToNext()
}else{
  ; switchDesktopToLastOpened()
  switchDesktopToNext()
}
return

; 切换当前窗口到另外一个显示器
CapsLock & v:: +#Left 

; 锁定应用，或者锁定窗口
; pin app on top, app ,window
capslock & t::OnTogglePinOnTopPress()
; capslock & a::OnTogglePinAppPress()
; capslock & w::OnTogglePinWindowPress()

; 增加一组快捷键，绕过capslock。使得strokesPlus手势来发送按键，进而支持动作
!#j::MoveCurrentWindowToDesktop(1)
!#k::MoveCurrentWindowToDesktop(2)

;//todo 使用fn按键，来切换数字键的状态。数字键，或者是fn数字键。

; ================  ctrl win 系列
; Vim-like key config . If use this, suggest config DesktopMiniCount=4, DesktopInitSwitchTarget as well
^#j::switchDesktopByNumber(1)  ;上 桌面
^#k::switchDesktopByNumber(2)  ;下 桌面
^#l::switchDesktopByNumber(3)
^#i::switchDesktopByNumber(4)

^#d::Volume_Down
^#u::Volume_Up
^#e::Volume_Up

; wt.exe
; "wt.exe --tabColor #2EC462 `; sp -H -p `"CMD`"" 这种转义符的方式不可用，不知道为何。使用空格拼接字符串的方式才行。https://segmentfault.com/a/1190000005069285
; 遇到了一个奇葩问题。新安装的nvm，无法在这种方式的cmd中打开。貌似不归属一个进程。环境变量好像是不能传递。可能需要重启电脑。或者还是使用最原始的，win+r，cmd方式。
; 通过增加pwsh的profile，可以解决这个而问题（这是wt的bug）。启动的时候，重新加载环境变量。https://stackoverflow.com/questions/17794507/reload-the-path-in-powershell
^#r::callSoft("ahk_exe WindowsTerminal.exe","WindowsTerminal.exe","wt --tabColor #2EC462 `; sp -H -p " "PowerShell" "; mf up")
capslock & u::callSoft("ahk_exe WindowsTerminal.exe","WindowsTerminal.exe","wt --tabColor #2EC462")
capslock & s::callSoft("ahk_exe sublime_text.exe","sublime_text.exe","D:\sublime3-portable-auh\sublime_text.exe")

capslock & j::^+j

; ================  ctrl alt 系列

; prekey ctrl+alt w,e,r,f,v  wechat,vscode,notion,websearch(//todo ),music .
; special handling: websearch use two step active and send words for control
; Attention: Before using , please replace user path exe for run correctlly！！！！！

^!w::callSoft("ahk_class WeChatMainWndForPC","WeChat.exe","C:\Program Files (x86)\Tencent\WeChat\WeChat.exe")
;^!q::callSoft("ahk_class Chrome_WidgetWin_1","uTools.exe","C:\Users\A\AppData\Local\Programs\utools\uTools.exe")
^!e::callSoft("ahk_exe Code.exe","Code.exe","D:\Microsoft VS Code\Code.exe")
^!r::callSoft("ahk_exe Notion.exe","Notion.exe","C:\Users\A\AppData\Local\Programs\Notion\Notion.exe")
^!f::callSoft("ahk_exe Fluent Reader.exe","Fluent Reader.exe","D:\Fluent Reader\Fluent Reader.exe")
;^!f::keyfunc_listary()
^!v::callSoft("ahk_exe cloudmusic.exe","cloudmusic.exe","D:\ksoft\Netease\CloudMusic\cloudmusic.exe")

; ================== ctrl+ num 系列
^1::
Run, https://simpread.pro/@fanlushuai
return