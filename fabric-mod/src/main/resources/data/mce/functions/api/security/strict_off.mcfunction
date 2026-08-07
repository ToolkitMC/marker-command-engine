# PUBLIC API — mce:api/security/strict_off
# Disables strict approval mode while keeping safety limits and denylist enabled.

data modify storage mce:config mce.security.enabled set value 1b
data modify storage mce:config mce.security.strict set value 0b
data modify storage mce:config mce.security.denylist set value 1b
data remove storage mce:auth approved
tellraw @s ["",{"text":"[MCE/security] ","color":"gold"},{"text":"Strict mode OFF. Denylist and limits remain enabled.","color":"gray"}]
