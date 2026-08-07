data modify storage mce:security state.allowed set value 0b
data modify storage mce:security state.code set value "ERR_SECURITY_DELAY_TOO_LARGE"
data modify storage mce:security state.reason set value "MCE security blocked scheduled command because the delay exceeds the configured maximum"
