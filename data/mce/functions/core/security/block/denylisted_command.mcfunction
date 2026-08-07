data modify storage mce:security state.allowed set value 0b
data modify storage mce:security state.code set value "ERR_SECURITY_DENYLIST"
data modify storage mce:security state.reason set value "MCE security blocked command because it matches the exact denylist"
