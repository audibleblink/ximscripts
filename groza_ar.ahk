#Include %A_AppData%\XIM Link\ScriptAdditionals\AHK_ADDITIONALS.ahk
#Include %A_MyDocuments%\XIM Link\Scripts\util.ahk

#NoEnv

;; Configuration Variables
gun_id := "groza"

config := build_config(gun_id)
gun := new Weapon(config, health)

; Bindings
is_enabled := true
WheelUp::is_enabled := ! is_enabled
WheelDown::Suspend
~LButton::fire(gun, burst_sleep)
