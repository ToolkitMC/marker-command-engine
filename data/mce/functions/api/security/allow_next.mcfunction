# PUBLIC API — mce:api/security/allow_next
# Grants one command execution while strict mode is enabled. Consumed automatically.

data modify storage mce:auth approved set value 1b
tellraw @s ["",{"text":"[MCE/security] ","color":"gold"},{"text":"One-shot command approval granted.","color":"green"}]
