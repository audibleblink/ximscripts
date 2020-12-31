#Include %A_AppData%\XIM Link\ScriptAdditionals\AHK_ADDITIONALS.ahk
#Include %A_MyDocuments%\XIM Link\Scripts\lib\helpers.ahk

#NoEnv

bullets_per_burst := 3

; Bindings
is_enabled := true
PgUp::is_enabled := ! is_enabled
PgDn::Suspend
~LButton::fireHandler(func("autofire"), bullets_per_burst, burst_sleep)

#Include %A_MyDocuments%\XIM Link\Scripts\lib\bindings.ahk
