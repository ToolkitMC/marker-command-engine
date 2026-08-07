# Private: validates mce:cmd Command before it is written into a command block.
# Notes:
# - This is a cooperative safety layer for MCE callers, not a server permission system.
# - The denylist is exact-match only; use strict mode for a stronger opt-in gate.

data modify storage mce:security state set value {allowed:1b,code:"OK",reason:""}

# Strict mode requires one-shot approval from mce:api/security/allow_next.
execute if data storage mce:config {mce:{security:{enabled:1b,strict:1b}}} unless data storage mce:auth {approved:1b} run function mce:core/security/block/approval_required
execute if data storage mce:config {mce:{security:{enabled:1b,strict:1b}}} if data storage mce:auth {approved:1b} run data remove storage mce:auth approved

# Exact-match denylist for common destructive/administrative commands.
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"stop"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"/stop"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"reload"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"/reload"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"save-off"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"/save-off"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"save-all"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"/save-all"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"whitelist off"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"/whitelist off"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"op @a"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"/op @a"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"deop @a"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"/deop @a"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"ban @a"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"/ban @a"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"ban-ip @a"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"/ban-ip @a"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"kick @a"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"/kick @a"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"kill @a"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"/kill @a"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"kill @e"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"/kill @e"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"clear @a"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"/clear @a"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"forceload remove all"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"/forceload remove all"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"gamerule commandBlockOutput false"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"/gamerule commandBlockOutput false"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"gamerule sendCommandFeedback false"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"/gamerule sendCommandFeedback false"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"gamerule logAdminCommands false"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"/gamerule logAdminCommands false"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"data modify storage mce:config mce.security.enabled set value 0b"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"data modify storage mce:config mce.security.strict set value 0b"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"data remove storage mce:config mce.security"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"function mce:core/run/cmd_exec"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"function mce:core/run/as_exec_inner"} run function mce:core/security/block/denylisted_command
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b,denylist:1b}}} if data storage mce:cmd {Command:"function mce:core/run/at_build_exec"} run function mce:core/security/block/denylisted_command

execute if data storage mce:security {state:{allowed:0b}} run function mce:core/security/report_block
