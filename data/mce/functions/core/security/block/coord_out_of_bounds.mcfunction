data modify storage mce:security state.allowed set value 0b
data modify storage mce:security state.code set value "ERR_SECURITY_COORD_OUT_OF_BOUNDS"
data modify storage mce:security state.reason set value "MCE security blocked run/at because coordinates are outside configured bounds"
