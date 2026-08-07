data modify storage mce:security state.allowed set value 0b
data modify storage mce:security state.code set value "ERR_SECURITY_APPROVAL"
data modify storage mce:security state.reason set value "MCE security strict mode requires one-shot approval; call mce:api/security/allow_next before executing this command"
