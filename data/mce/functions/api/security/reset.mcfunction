# PUBLIC API — mce:api/security/reset
# Restores MCE security defaults. Does not clear existing queue/schedule data.

data modify storage mce:config mce.security.enabled set value 1b
data modify storage mce:config mce.security.strict set value 0b
data modify storage mce:config mce.security.denylist set value 1b
data modify storage mce:config mce.security.max_queue_size set value 128
data modify storage mce:config mce.security.max_batch_size set value 128
data modify storage mce:config mce.security.max_schedule_jobs set value 128
data modify storage mce:config mce.security.max_schedule_delay set value 72000
data modify storage mce:config mce.security.max_executors set value 64
data modify storage mce:config mce.security.max_coord_abs set value 30000000
data modify storage mce:config mce.security.min_y set value -64
data modify storage mce:config mce.security.max_y set value 320
data remove storage mce:auth approved
data modify storage mce:security state set value {allowed:1b,code:"OK",reason:""}
tellraw @s ["",{"text":"[MCE/security] ","color":"gold"},{"text":"Defaults restored.","color":"green"}]
