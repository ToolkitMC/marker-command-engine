# Private: not part of MCE public API — subject to change without notice
# Security wrapper for coordinate-based command execution.

function mce:core/security/validate_command
execute if data storage mce:security {state:{allowed:1b}} run function mce:core/security/check_coords
execute if data storage mce:security {state:{allowed:1b}} run function mce:core/run/at_build_exec
execute if data storage mce:security {state:{allowed:0b}} run data remove storage mce:cmd AtX
execute if data storage mce:security {state:{allowed:0b}} run data remove storage mce:cmd AtY
execute if data storage mce:security {state:{allowed:0b}} run data remove storage mce:cmd AtZ
