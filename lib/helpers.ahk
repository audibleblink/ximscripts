#Include %A_AppData%\XIM Link\ScriptAdditionals\AHK_ADDITIONALS.ahk

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global Vars
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

global burst_sleep, health
INIRead, burst_sleep, %A_MyDocuments%\XIM Link\Scripts\weapons.ini, constants, burst_sleep
INIRead, health, %A_MyDocuments%\XIM Link\Scripts\weapons.ini, constants, health
is_enabled := true

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Classes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; build the gun configuration necessary to pass the the weapon class
;; values are read from weapons.ini in the same directory
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

;; Creates a weapon instance for storing and calculating stats
;; needed to perform anti-recoil and other functions
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Utility Classes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; fire is the callback function for assigning to 
;; the left mouse button
fireHandler(callback, weapon, sleep_time) {
   global is_enabled, last_reload_start

   ;; reload cancel logic
   fired := A_NowUTC
   EnvSub, fired, %last_reload_start%, seconds
   if (fired < 1.5) {
      reloadCancel()
   }

   if %is_enabled% {
      while GetKeyState("LButton", "P") {
         %callback%(weapon)
         Sleep sleep_time
      }
   }
}


;; bursts a weapon and performs anti-recoil for the duration
;; of the weapon's ttk (times any multipliers)
antiRecoilBurst(weapon) {
   mult := 1.2
   Click, down
   XIMInputData("RightStickDirectional", weapon.Degrees, weapon.Speed)
   Sleep % weapon.TTK * 1000 * mult
   XIMInputData("RightStickDirectional", -1)
   Click, up
}


;; bursts a weapon without AR
onlyBurst(weapon) {
   Click, down
   Sleep % weapon.TTK
   Click, up
   Sleep 1
}


;; perform only anti-recoil logic, no bursting
onlyAntiRecoil(weapon) {
   Click, down
   XIMInputData("RightStickDirectional", weapon.Degrees, weapon.Speed)
   KeyWait, LButton
   XIMInputData("RightStickDirectional", -1)
   Click, up
}


;; autofire a semi-auto weapon n times
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


;; repeatedly fires akimbo weapons
dualAuto(times) {
   Loop %times% {
      if GetKeyState("LButton", "P") {
         Click, down
         Sleep 40
         Click, down, right
         Sleep 100
         Click, up, right
         Sleep 10
         Click, up
         Sleep 10
      }
   }
}


;; quickscope on unique, only left-mouse-btn presses
;; operate as normal fire if held together with right-mouse-btn
quickscope(ads) {
   global is_enabled
   if GetKeyState("RButton", "P") {
      Click, down
      Sleep 1
      Click, up
      Sleep 1
      return
   }

   if %is_enabled% {
      Click, down, right
      Sleep 1
      Sleep %ads%
      if GetKeyState("LButton", "P") {
         Click, down
         Sleep 1
         Click, up
         Sleep 1
      }
      Click, up, right
   }
}


;; doubletaps the weapon-swap button to cancel reloading
reloadCancel() {
   Loop 2 {
      XIMInputData("Button3", 1)
      Sleep 50
      XIMInputData("Button3", 0)
      Sleep 50
   }
}
