; 显示中文必须使用UTF-8-BOM编码本文件
;thttps://ahkcn.github.io/docs/misc/Clipboard.htm
#Persistent
#InstallKeybdHook
#SingleInstance force
SetTitleMatchMode 2
SendMode Input
Menu, Tray, Icon , Shell32.dll, 25, 1
TrayTip, AutoHotKey, Started, 1
SoundBeep , 300, 150 
RCtrl & Tab::
	Tooltip, reload %A_ScriptFullPath%
	sleep, 321
	Tooltip
	Reload
pycharm := "C:\Program Files\JetBrains\PyCharm 2024.1.4\bin\pycharm64.exe"
webstorm := "C:\Program Files\JetBrains\WebStorm 2024.1.5\bin\webstorm64.exe"


Activate(t)
{
  IfWinActive,%t%
  {
    WinMinimize
    return
  }
  SetTitleMatchMode 2    
  DetectHiddenWindows,on
  IfWinExist,%t%
  {
    WinShow
    WinActivate           
    return 1
  }
  return 0
}

ActivateAndOpen(t,p)
{
  if Activate(t)==0
  {
    Run %p%
    WinActivate
    return
  }
}
RCtrl & ESC:: return
RCtrl & 1::
	ActivateAndOpen("WPS Office","C:\Users\xujiazhe\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\WPS Office")
	return
RCtrl & 2:: 
	ActivateAndOpen("Sourcetree","C:\Users\xujiazhe\AppData\Local\SourceTree\SourceTree.exe")
	return
RCtrl & 3::
	;WinShow, "ahk_exe Ueli.exe"  ^Y不行
	
	KeyWait, 3
    If (A_TimeSinceThisHotkey < 300) {
		ActivateAndOpen("ahk_exe pycharm64.exe", pycharm)
	}
	else
	{
		ActivateAndOpen("ahk_exe webstorm64.exe", webstorm)
	}
	;ActivateAndOpen("WebStorm", "C:\Program Files\JetBrains\WebStorm 2024.1.5\bin\webstorm64.exe")
	return
;https://superuser.com/questions/1265330/autohotkey-to-cycle-through-active-program-windows
RCtrl & 4::
	IfWinNotExist, ahk_class CabinetWClass
		Run, explorer.exe
	GroupAdd, kjexplorers, ahk_class CabinetWClass ;You have to make a new group for each application, don't use the same one for all of them!
	if WinActive("ahk_exe explorer.exe")
		GroupActivate, kjexplorers, r
	else
		WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
	Return


RAlt & 1::
	IfWinNotExist ahk_class CalcFrame
	{
	  Run calc.exe
	  WinActivate
	}
	Else IfWinNotActive ahk_class CalcFrame
	{
	  WinActivate
	}
	Else
	{
	  WinMinimize
	}
	Return
; reload script https://stackoverflow.com/questions/15706534/hotkey-to-restart-autohotkey-script


~RCtrl up::
	;ToolTip, %A_PriorKey%
	If (A_PriorKey = "RControl" ) {
		Send {Enter}
	}
	return

RCtrl & r:: 
	if WinActive("ahk_exe wps.exe") { 
		Send, ^{Tab}
	}
	else if WinActive("ahk_exe webstorm64.exe") or WinActive("ahk_exe pycharm64.exe")
	{
		send, !{Right}
	}
	else
		Send, ^{PgDn}
	return
RCtrl & w:: 
	if WinActive("ahk_exe wps.exe") {
		Send, ^+{Tab}
	}
	else if WinActive("ahk_exe webstorm64.exe") or WinActive("ahk_exe pycharm64.exe")
	{
		send, !{Left}
	}
	else
		Send, ^{PgUp}
	return
RCtrl & q:: Send, !{Esc}
RCtrl & e:: Send, !+{Esc} 

;RCtrl & v:: !#^+v
;TODO M595只有滚轮右侧出出发下一行 而
;WheelRight::return ;ToolTip, WheelRight 可用
;WheelLeft::	ToolTip, WheelLeft 可用
 

;先把space基础功能调好
; reload script https://stackoverflow.com/questions/15706534/hotkey-to-restart-autohotkey-script

;space as modifier key
;抄袭 https://www.reddit.com/r/AutoHotkey/comments/oq23r4/is_there_a_way_to_use_space_as_a_modifier/
;好东西  https://github.com/almogtavor/static-hands

Space::·
	If SpacePressed ; AutoRepeat defense
		Return
	SpacePressed:=true
	SpaceTimeout := false
	SetTimer ModActivate, % SpaceTimeoutLimit
	Return

Space Up::
	SpacePressed:=false
	SetTimer ModActivate, Off
	If ((A_PriorKey = "Space") AND !SpaceTimeout){
		Send {Blind}{Space}
	}
	Return
ModActivate:
	SpaceTimeout := true
	Return

Space & e::Up
Space & s::Left
Space & d::Down
Space & f::Right

Space & w::PgUp
Space & r::PgDn
Space & a::Home
Space & g::End

Space & j::BackSpace
Space & c::AltTabMenu
Space & x::Delete
Space & z::ESC
;Space & RCtrl::Enter
Space & Tab::
	KeyWait, Tab
    If (A_TimeSinceThisHotkey < 300) {
		Send, {BackSpace}
	}
	else {
		Send, {Delete}
	}
	return
Space & h::Delete
;CapLock & Space::Enter
#If (GetKeyState("Space", "P"))
	*1::Send {Blind}{F12}
	*2::Send {Blind}{F11}
	*3::Send {Blind}{F10}
	*4::Send {Blind}{F9}
	*5::Send {Blind}{F8}
	*6::Send {Blind}{F7}
	*7::Send {Blind}{F6}
	*8::Send {Blind}{F5}
	*9::Send {Blind}{F4}
	*0::Send {Blind}{F3 }
#If


;https://ahkcn.github.io/docs/misc/Clipboard.htm
~LCtrl up::
	If (A_PriorKey = "LControl") {
		Send {Esc}
	}
	return

#F::
    KeyWait, F
    If (A_TimeSinceThisHotkey < 300) {
        ; 按下小于300ms，打开Downloads文件夹
        Run "D:\ahk_script\CL3" , Max
    } Else {
        ; 按下超过300ms，打开docs文件夹
        Run "D:\"
    }
Return


#If PName := BrowserActive()
    F4::SoundBeep, PName = "ApplicationFrameHost.exe" ? 523 : 300
#If
BrowserActive()
{
	WinGet, pName, ProcessName, A
	;Msgbox % pName
	if pName in msedge.exe,chrome.exe,firefox.exe,iexplore,ApplicationFrameHost.exe,notepad++.exe
		return pName
	return 0
}

RCtrl & 6::
	Gui,Add,ListBox,vWinList w200 r10,Wait..
	Gui,Show
	GoTo WinList

	WinList:
	WinGet,WinList,List,,,Program Manager
	List=
	loop,%WinList%{
		Current:=WinList%A_Index%
		WinGetTitle,WinTitle,ahk_id %Current%
		If WinTitle AND !InStr(List,WinTitle)
		List.="`n" "--- " WinTitle
	}
	GuiControl,+HScroll,WinList
	Gui +Delimiter`n
	GuiControl,,WinList,%List%
	Return

	GuiClose:
	return
	;ExitApp


RCtrl & 5:: 
	;TrayTip,,"helo word"
	WinGet windows, List
	r :=
	Loop %windows%
	{
		id := windows%A_Index%
		WinGetTitle wt, ahk_id %id%
		if wt {
		r .= wt . "`n" 
		}
	}
	MsgBox %r%
	return


;RCtrl & f::	;FileAppend, 测试wps, w测试%A_Now%.txt,UTF-8-RAW
;	return
RCtrl & 7::Tooltip 你好世界! , A_ScreenWidth, A_ScreenHeight
RCtrl & z::
	MsgBox, %A_PriorKey% | %A_PriorHotKey%
	MsgBox, %A_PriorKey% | %A_PriorHotKey%
	return
RCtrl & z up::
	Tooltip, 2 %A_PriorKey% | %A_PriorHotKey%
	return   ; hotkey可以重复

	
RCtrl & F2::
	;Tooltip 写入%Clipboard%! , A_ScreenWidth, A_ScreenHeight 
	;FileAppend, Text, *
	FileAppend, %Clipboard%, g写入%A_Now%.txt,UTF-8-RAW
	Tooltip,%ErrorLevel%
	return
;TODO 向特别进程发送事件

;TODO 说起来语言成分鉴定
voice := ComObjCreate("SAPI.SpVoice")	; or use TTS_CreateVoice()
RCtrl & x::
	; SpVoice = ???   Seems like it would just be a short piece here directing to specified voice...
	;voice.Speak("说中文才是关键啊.")	; or use TTS()
	voice.Speak(clipboard)
	;voice := ""
	Return
#z::
    names := ""
    ;voice := ComObjCreate("SAPI.SpVoice")

    Loop, % voice.GetVoices.Count
    {
        names .= voice.GetVoices.Item(A_Index-1).GetAttribute("Name") . "`n"    ; 0 based
    }
	
    ;msgbox % names
	Try {
	  voice.Voice := voice.GetVoices.item(1)
	  ;for SpObjectToken in ComObjCreate("SAPI.SpVoice").GetVoices()
		MsgBox % names
	}
	;TODO clipboard = */
    Send,{CTRL Down}c{CTRL Up}
    Sleep, 100  
	
	voice.Speak(clipboard)
    ;voice.Voice := voice.GetVoices("Name=Microsoft Zira Desktop").Item(0) ; set voice to param1
    return

;常用快捷命令
:://cmd::	;打开命令行
Run cmd
return

:://t::		;打开任务管理器
Run taskmgr
return

:://sys::	;打开系统属性
Run control sysdm.cpl
return

;程序切换
RCtrl & space::AltTab
RCtrl & lshift::
keywait space
send {ShiftAltTab}
return


Numpad9::AltTab
;^+3:#+s



;capslock键映射
>^'::
	if GetKeyState("Capslock", "T")
		SetCapsLockState,off	
	else
		SetCapsLockState,on
return

>^;::
	Send {Enter}
	return

; https://gist.github.com/babyking/5057457Z