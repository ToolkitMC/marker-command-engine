data modify storage mce:security state.allowed set value 0b
data modify storage mce:security state.code set value "ERR_SECURITY_SCHEDULE_FULL"
data modify storage mce:security state.reason set value "MCE security blocked scheduled command because the schedule job limit has been reached"
