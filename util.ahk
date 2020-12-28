#Include %A_AppData%\XIM Link\ScriptAdditionals\AHK_ADDITIONALS.ahk
class Weapon{

    __New(weapon_config, health) {
        this.Name := weapon_config.name
        this.Damage := weapon_config.damage
        this.RPM := weapon_config.rpm
        this.Degrees := weapon_config.degrees
        this.Speed := weapon_config.speed

        this.STK := this.ShotsToKill(health)
        this.TTK := this.TimeToKill()
        this.ShotDuration := this.TTK / this.STK * 1000
    }

    ShotsToKill(health) {
        return health / this.Damage + 1
    }

    TimeToKill() {
        return this.STK / (this.RPM / 60)
    }

}

burstAR(weapon) {
    Click, down
    XIMInputData("RightStickDirectional", weapon.Degrees, weapon.Speed)
    Sleep % weapon.TTK * 1000 * 1.5
    XIMInputData("RightStickDirectional", -1)
    Click, up
}

burst(weapon) {
    Click, down
    Loop % weapon.STK {
        Sleep % weapon.ShotDuration
    }
    Click, up
}

autofire(times) {
    Loop %times% {
        if GetKeyState("LButton", "P") {
            Click, down
            Sleep 61
            Click, up
            Sleep 58
        }
    }
}

build_config(gun_id) {
    INIRead, name, %A_MyDocuments%\XIM Link\Scripts\weapons.ini, %gun_id%, name
    INIRead, damage, %A_MyDocuments%\XIM Link\Scripts\weapons.ini, %gun_id%, damage
    INIRead, rpm, %A_MyDocuments%\XIM Link\Scripts\weapons.ini, %gun_id%, rpm
    INIRead, degrees, %A_MyDocuments%\XIM Link\Scripts\weapons.ini, %gun_id%, degrees
    INIRead, speed, %A_MyDocuments%\XIM Link\Scripts\weapons.ini, %gun_id%, speed

    config := {}
    config.name := name
    config.damage := damage
    config.rpm := rpm
    config.degrees := degrees
    config.speed := speed
    return config
}

; Functions
fire(weapon, burst_sleep) {
    global is_enabled
    if %is_enabled% {
        while GetKeyState("LButton", "P") {
            burstAR(weapon)
            Sleep burst_sleep
        }
    }
}

global burst_sleep, health
INIRead, burst_sleep, %A_MyDocuments%\XIM Link\Scripts\weapons.ini, constants, burst_sleep
INIRead, health, %A_MyDocuments%\XIM Link\Scripts\weapons.ini, constants, health