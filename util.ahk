class Weapon{

    __New(weapon_config, health) {
        this.Name := weapon_config.name
        this.Damage := weapon_config.damage
        this.RPM := weapon_config.rpm

        this.STK := this.ShotsToKill(health)
        this.TTK := this.TimeToKill(this.STK)
        this.ShotDuration := this.TTK / this.STK * 1000
    }

    ShotsToKill(health) {
        return health / this.Damage + 1
    }

    TimeToKill(stk) {
        return this.STK / (this.RPM / 60)
    }

}

burstAR(weapon, x, y) {
    Click, down
    Loop % weapon.STK {
        Sleep % weapon.ShotDuration
        mouseXY(x, y)
    }
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

mouseXY(x,y) {
    DllCall("mouse_event",uint,1,int,x,int,y,uint,0,int,0)
    Sleep 1
}

build_config(gun_id) {
    INIRead, name, %A_MyDocuments%\XIM Link\Scripts\weapons.ini, %gun_id%, name
    INIRead, damage, %A_MyDocuments%\XIM Link\Scripts\weapons.ini, %gun_id%, damage
    INIRead, rpm, %A_MyDocuments%\XIM Link\Scripts\weapons.ini, %gun_id%, rpm

    config := {}
    config.name := name
    config.damage := damage
    config.rpm := rpm
    return config
}