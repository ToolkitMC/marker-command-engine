# Private: blocks queue additions that exceed configured capacity.

data modify storage mce:security state set value {allowed:1b,code:"OK",reason:""}
execute if data storage mce:config {mce:{security:{enabled:1b}}} run scoreboard players set #queue.size mce.sec 0
execute if data storage mce:config {mce:{security:{enabled:1b}}} if data storage mce:queue commands run execute store result score #queue.size mce.sec run data get storage mce:queue commands
execute if data storage mce:config {mce:{security:{enabled:1b}}} run execute store result score #queue.max mce.sec run data get storage mce:config mce.security.max_queue_size
execute if data storage mce:config {mce:{security:{enabled:1b}}} if score #queue.size mce.sec >= #queue.max mce.sec run function mce:core/security/block/queue_full
execute if data storage mce:security {state:{allowed:0b}} run function mce:core/security/report_block
