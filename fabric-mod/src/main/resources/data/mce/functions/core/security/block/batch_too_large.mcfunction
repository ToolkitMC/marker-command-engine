data modify storage mce:security state.allowed set value 0b
data modify storage mce:security state.code set value "ERR_SECURITY_BATCH_TOO_LARGE"
data modify storage mce:security state.reason set value "MCE security blocked batch/multi command list because it exceeds the configured batch size limit"
