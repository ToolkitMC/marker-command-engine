# MCE internal load — do not call directly
# Private: mce:core/* functions are not part of the public API

forceload add 0 0

scoreboard objectives add mce.queue dummy
scoreboard objectives add mce.tick dummy
scoreboard objectives add mce.compat dummy
scoreboard objectives add mce.cd dummy
scoreboard objectives add mce.log dummy
scoreboard objectives add mce.sec dummy

scoreboard players set #tick mce.tick 0
scoreboard players set #queue.active mce.compat 0
scoreboard players set #sched.exists mce.compat 0
scoreboard players set #error.count mce.queue 0
scoreboard players set #log.n mce.log 0
scoreboard players set #log.size mce.log 0
scoreboard players set #security.blocked mce.sec 0
scoreboard players set #neg.one mce.sec -1
data remove storage mce:error Last
data remove storage mce:error Code
data modify storage mce:error Count set value 0
data modify storage mce:security BlockedCount set value 0
data modify storage mce:security state set value {allowed:1b,code:"OK",reason:""}
data remove storage mce:auth approved

# --- List-type storage init ---
# Prevents "data get" errors on fresh worlds where these paths have never
# been written to yet. Guarded so a /reload never wipes an in-flight queue,
# schedule, log, or batch.
execute unless data storage mce:queue commands run data modify storage mce:queue commands set value []
execute unless data storage mce:schedule jobs run data modify storage mce:schedule jobs set value []
execute unless data storage mce:log entries run data modify storage mce:log entries set value []
execute unless data storage mce:text_batch entries run data modify storage mce:text_batch entries set value []
execute unless data storage mce:batch commands run data modify storage mce:batch commands set value []

# --- MCE Config (mce.*) ---
# Internal MCE settings. Do not modify unless you know what you are doing.

# mce.debug: debug output toggle (0b = off, 1b = on)
execute unless data storage mce:config {mce:{debug:1b}} run data modify storage mce:config mce.debug set value 0b

# mce.version: human-readable version string (set on every load)
data modify storage mce:config mce.version set value "2.3.1-sec"

# mce.queue_interval: ticks between queue executions (read-only reference, hardcoded in core/queue/tick)
data modify storage mce:config mce.queue_interval set value 3

# mce.track_output: whether spawned command blocks set TrackOutput (1b = default/on,
# matches prior behavior; 0b = silent, skips the per-command output broadcast to ops
# when commandBlockOutput gamerule is on). Does not affect command execution itself.
execute unless data storage mce:config mce.track_output run data modify storage mce:config mce.track_output set value 1b


# mce.security.*: cooperative hardening layer for command execution.
# enabled=1b keeps limits/denylist active; strict=1b requires mce:api/security/allow_next
# before each command execution. The denylist is exact-match only.
execute unless data storage mce:config mce.security.enabled run data modify storage mce:config mce.security.enabled set value 1b
execute unless data storage mce:config mce.security.strict run data modify storage mce:config mce.security.strict set value 0b
execute unless data storage mce:config mce.security.denylist run data modify storage mce:config mce.security.denylist set value 1b
execute unless data storage mce:config mce.security.max_queue_size run data modify storage mce:config mce.security.max_queue_size set value 128
execute unless data storage mce:config mce.security.max_batch_size run data modify storage mce:config mce.security.max_batch_size set value 128
execute unless data storage mce:config mce.security.max_schedule_jobs run data modify storage mce:config mce.security.max_schedule_jobs set value 128
execute unless data storage mce:config mce.security.max_schedule_delay run data modify storage mce:config mce.security.max_schedule_delay set value 72000
execute unless data storage mce:config mce.security.max_executors run data modify storage mce:config mce.security.max_executors set value 64
execute unless data storage mce:config mce.security.max_coord_abs run data modify storage mce:config mce.security.max_coord_abs set value 30000000
execute unless data storage mce:config mce.security.min_y run data modify storage mce:config mce.security.min_y set value -64
execute unless data storage mce:config mce.security.max_y run data modify storage mce:config mce.security.max_y set value 320

# --- API Config (api.*) ---
# Settings exposed for other packs to read and optionally override.

# api.announce_default_preset: default timing preset used by mce:api/util/announce_times
# Valid values: "fast" (5/30/5), "normal" (10/70/20), "slow" (20/100/20), "instant" (0/40/0)
execute unless data storage mce:config api.announce_default_preset run data modify storage mce:config api.announce_default_preset set value "normal"

# --- LanternLoad: advertise MCE version ---
# v2.3.1-sec -> 2003001
scoreboard players set #mce load.status 2003001

tellraw @a ["",{"text":"[MCE] ","color":"aqua"},{"text":"Marker Command Engine v2.3.1-sec loaded!","color":"white"}]
