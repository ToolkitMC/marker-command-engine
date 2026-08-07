# Private: blocks run/as fan-out when too many entities carry mce.executor.

execute if data storage mce:config {mce:{security:{enabled:1b}}} run scoreboard players set #exec.count mce.sec 0
execute if data storage mce:config {mce:{security:{enabled:1b}}} as @e[tag=mce.executor] run scoreboard players add #exec.count mce.sec 1
execute if data storage mce:config {mce:{security:{enabled:1b}}} run execute store result score #exec.max mce.sec run data get storage mce:config mce.security.max_executors
execute if data storage mce:config {mce:{security:{enabled:1b}}} if score #exec.count mce.sec > #exec.max mce.sec run function mce:core/security/block/too_many_executors
execute if data storage mce:security {state:{allowed:0b}} run function mce:core/security/report_block
