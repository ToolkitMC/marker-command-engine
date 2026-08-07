# Private: blocks scheduled jobs with excessive delay or when the schedule is full.

data modify storage mce:security state set value {allowed:1b,code:"OK",reason:""}
execute if data storage mce:config {mce:{security:{enabled:1b}}} run scoreboard players set #sched.jobs mce.sec 0
execute if data storage mce:config {mce:{security:{enabled:1b}}} run execute store result score #sched.delay mce.sec run data get storage mce:cmd Delay
execute if data storage mce:config {mce:{security:{enabled:1b}}} run execute store result score #sched.max_delay mce.sec run data get storage mce:config mce.security.max_schedule_delay
execute if data storage mce:config {mce:{security:{enabled:1b}}} if score #sched.delay mce.sec > #sched.max_delay mce.sec run function mce:core/security/block/delay_too_large
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b}}} if data storage mce:schedule jobs run execute store result score #sched.jobs mce.sec run data get storage mce:schedule jobs
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b}}} run execute store result score #sched.max_jobs mce.sec run data get storage mce:config mce.security.max_schedule_jobs
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b}}} if score #sched.jobs mce.sec >= #sched.max_jobs mce.sec run function mce:core/security/block/schedule_full
execute if data storage mce:security {state:{allowed:0b}} run function mce:core/security/report_block
