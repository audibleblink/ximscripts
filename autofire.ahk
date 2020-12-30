#Include %A_AppData%\XIM Link\ScriptAdditionals\AHK_ADDITIONALS.ahk
#Include %A_MyDocuments%\XIM Link\Scripts\util.ahk

#NoEnv

bullets_per_burst := 3

; Bindings
is_enabled := true
WheelUp::is_enabled := ! is_enabled
WheelDown::Suspend
~LButton::fireHandler(func("autofire"), bullets_per_burst, burst_sleep)

#Include %A_MyDocuments%\XIM Link\Scripts\misc.ahk
