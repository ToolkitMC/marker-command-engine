data modify storage mce:security state.allowed set value 0b
data modify storage mce:security state.code set value "ERR_SECURITY_TOO_MANY_EXECUTORS"
data modify storage mce:security state.reason set value "MCE security blocked run/as because too many entities are tagged mce.executor"
