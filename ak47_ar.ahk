#Include %A_AppData%\XIM Link\ScriptAdditionals\AHK_ADDITIONALS.ahk
#Include %A_MyDocuments%\XIM Link\Scripts\lib\helpers.ahk

#NoEnv

;; Configuration Variables
gun_id := "ak47"

config := build_config(gun_id)
gun := new Weapon(config, health)

; Bindings
is_enabled := true
PgUp::is_enabled := ! is_enabled
PgDn::Suspend
~LButton::fireHandler(func("antiRecoilBurst"), gun, burst_sleep)

#Include %A_MyDocuments%\XIM Link\Scripts\lib\bindings.ahk
