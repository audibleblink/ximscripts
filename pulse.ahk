#Include %A_AppData%\XIM Link\ScriptAdditionals\AHK_ADDITIONALS.ahk
#Include %A_MyDocuments%\XIM Link\Scripts\util.ahk

#NoEnv

;; Dummy generic weapon
weapon := new Weapon()
weapon.TTK := 600 ;; milliseconds to fold burst

; Bindings
isEnabled := true
WheelUp::isEnabled := ! isEnabled
WheelDown::Suspend
~LButton::fireHandler(func("onlyBurst"), weapon, burst_sleep)

#Include %A_MyDocuments%\XIM Link\Scripts\misc.ahk
