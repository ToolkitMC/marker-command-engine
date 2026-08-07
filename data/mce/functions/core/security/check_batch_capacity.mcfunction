# Private: blocks mce:batch submissions that are too large or would overflow the queue.

data modify storage mce:security state set value {allowed:1b,code:"OK",reason:""}
execute if data storage mce:config {mce:{security:{enabled:1b}}} run scoreboard players set #batch.size mce.sec 0
execute if data storage mce:config {mce:{security:{enabled:1b}}} run scoreboard players set #queue.size mce.sec 0
execute if data storage mce:config {mce:{security:{enabled:1b}}} if data storage mce:batch commands run execute store result score #batch.size mce.sec run data get storage mce:batch commands
execute if data storage mce:config {mce:{security:{enabled:1b}}} if data storage mce:queue commands run execute store result score #queue.size mce.sec run data get storage mce:queue commands
execute if data storage mce:config {mce:{security:{enabled:1b}}} run execute store result score #batch.max mce.sec run data get storage mce:config mce.security.max_batch_size
execute if data storage mce:config {mce:{security:{enabled:1b}}} run execute store result score #queue.max mce.sec run data get storage mce:config mce.security.max_queue_size
execute if data storage mce:config {mce:{security:{enabled:1b}}} if score #batch.size mce.sec > #batch.max mce.sec run function mce:core/security/block/batch_too_large
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b}}} run scoreboard players operation #queue.projected mce.sec = #queue.size mce.sec
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b}}} run scoreboard players operation #queue.projected mce.sec += #batch.size mce.sec
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b}}} if score #queue.projected mce.sec > #queue.max mce.sec run function mce:core/security/block/queue_full
execute if data storage mce:security {state:{allowed:0b}} run function mce:core/security/report_block
