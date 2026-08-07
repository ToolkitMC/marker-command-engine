# Private: not part of MCE public API — subject to change without notice
# Security wrapper for immediate command execution.

function mce:core/security/validate_command
execute if data storage mce:security {state:{allowed:1b}} run function mce:core/run/cmd_exec
