data modify storage mce:security state.allowed set value 0b
data modify storage mce:security state.code set value "ERR_SECURITY_QUEUE_FULL"
data modify storage mce:security state.reason set value "MCE security blocked command because the queue size limit would be exceeded"
