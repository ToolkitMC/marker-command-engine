# Private: not part of MCE public API — subject to change without notice
data modify block 0 -64 0 Command set value ""
data modify block 0 -64 0 auto set value 0b
setblock 0 -64 0 minecraft:air replace
kill @e[type=minecraft:marker,tag=mce.cmd]
data remove storage mce:cmd Command
data remove storage mce:cmd Delay
data remove storage mce:cmd AtX
data remove storage mce:cmd AtY
data remove storage mce:cmd AtZ
data remove storage mce:auth approved
schedule clear mce:core/run/reset
