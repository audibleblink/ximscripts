#Include %A_AppData%\XIM Link\ScriptAdditionals\AHK_ADDITIONALS.ahk
#Include %A_MyDocuments%\XIM Link\Scripts\lib\helpers.ahk

#NoEnv

;; Dummy generic weapon
weapon := new Weapon()
weapon.TTK := 550 ;; milliseconds to hold burst

~LButton::fireHandler(func("onlyBurst"), weapon, burst_sleep)

#Include %A_MyDocuments%\XIM Link\Scripts\lib\bindings.ahk
