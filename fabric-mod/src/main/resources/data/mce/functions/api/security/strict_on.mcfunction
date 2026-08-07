# PUBLIC API — mce:api/security/strict_on
# Enables strict one-shot approval mode.

data modify storage mce:config mce.security.enabled set value 1b
data modify storage mce:config mce.security.strict set value 1b
data modify storage mce:config mce.security.denylist set value 1b
tellraw @s ["",{"text":"[MCE/security] ","color":"gold"},{"text":"Strict mode ON. Call mce:api/security/allow_next before each command execution.","color":"yellow"}]
