# Private: not part of MCE public API — subject to change without notice
# Security wrapper for running mce:cmd Command as tagged executors.

function mce:core/security/validate_command
execute if data storage mce:security {state:{allowed:1b}} run function mce:core/security/check_executors
execute if data storage mce:security {state:{allowed:1b}} run function mce:core/run/as_exec_inner
execute if data storage mce:security {state:{allowed:0b}} run tag @e remove mce.executor
