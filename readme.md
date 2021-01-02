XimLink Scripts

A collection of scripts for Xim Link. Currently for BlackOps Cold War.

This is meant to be the contents of the folder located at: 

``` 
%USER%\My Documents\Xim Link\Scripts
```


## Configuration

Most configuration happens in the `weapons.ini` file.

An example entry:

```
[ak74u]
name=AK-74u
damage=27
rpm=697
degrees=200
speed=23 
```

**name** = Name of the gun. Meant to display on the as-yet non-existent GUI

**damage** = The _minimum_ amount of damage the gun does. The damage at its furthest effective range

**rpm** = Rounds per Minute

**degrees** = Up being 0, incrementing clockwise

**speed** = How much  to move the stick


## Anti Recoil

A weapon's `degree` and `speed` properties dictate how the recoil compensation behaves.


Speed is how far you would need to push the analog joystick on your controller in order to
compensate for the recoil. Values are from 21 - 100.

Degree is the compensation direction, from 0-360, starting at the top going clockwise

For a weapon whose recoil is straight up at a small rate, a setting of 
```
degrees=180
speed=30
```
might work.

## Bursting

Some weapons have changing recoil patterns. The FFAR and Groza assault rifles are a good example of
this, creating "S"-shaped recoil patterns throughout their firing. In most cases, the full amount
of bullets required to down a foe will leave the gun before the recoil pattern changes direction.

For this reason, giving a configuration entry the `damage` and `rpm` values will allow you to
"pulse" or "burst" a fully-automatic weapon. Since the first leg of the "S" pattern is predictable,
and all that is necessary to log a kill, we can also provide recoil compensation for it as well.

This formula demonstrates the calculation of the shortest amount of time to hold the trigger
necessary to kill a player

```
health = 150

# ak74u
damage=27 # at its furthest distance
rpm=697

shots to kill (STK) = health / damage + 1 = 6
time to kill (TTK) = STK / (RPM / 60) = 516ms
```

Thus holding the trigger for 516ms will provide enough TTK while incurring the least amount of
recoil in the most predictable pattern.

## Functions

The `helpers.ahk` file contains the definition of the functions that are called when squeezing the
trigger.

You have the following options:


```
;; bursts a weapon and performs anti-recoil for the duration
;; of the weapon's ttk (times any multipliers)
antiRecoilBurst(weapon)

;; bursts a weapon without AR
onlyBurst(weapon)

;; perform only anti-recoil logic, no bursting
onlyAntiRecoil(weapon)

;; autofire a semi-auto weapon n times
autofire(times)

;; quickscope on unique, only left-mouse-btn presses
;; operate as normal fire if held together with right-mouse-btn
quickscope(ads_time)

;; repeatedly fires akimbo weapons
dualAuto(times)
```

The following is a blank template for creating a new weapon profile.


```
#Include %A_AppData%\XIM Link\ScriptAdditionals\AHK_ADDITIONALS.ahk
#Include %A_MyDocuments%\XIM Link\Scripts\lib\helpers.ahk

#NoEnv

;; Configuration Variables
gun_id := "ak47"

config := build_config(gun_id)
gun := new Weapon(config, health)

~LButton::fireHandler(func("YOUR DESIRED FUNCTION HERE"), funcArg1, burst_sleep)

#Include %A_MyDocuments%\XIM Link\Scripts\lib\bindings.ahk
```
