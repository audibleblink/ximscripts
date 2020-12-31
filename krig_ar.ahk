#Include %A_AppData%\XIM Link\ScriptAdditionals\AHK_ADDITIONALS.ahk
#Include %A_MyDocuments%\XIM Link\Scripts\util.ahk

#NoEnv

;; Configuration Variables
gun_id := "krig"

config := build_config(gun_id)
gun := new Weapon(config, health)

; Bindings
is_enabled := true
PgUp::is_enabled := ! is_enabled
PgDn::Suspend
~LButton::fireHandler(func("antiRecoilBurst"), weapon, burst_sleep)

#Include %A_MyDocuments%\XIM Link\Scripts\misc.ahk
