# Private: records a blocked security event and exposes it through mce:error.

scoreboard players add #security.blocked mce.sec 1
execute store result storage mce:security BlockedCount int 1 run scoreboard players get #security.blocked mce.sec

data modify storage mce:security LastBlocked set value {}
data modify storage mce:security LastBlocked.code set from storage mce:security state.code
data modify storage mce:security LastBlocked.reason set from storage mce:security state.reason
execute if data storage mce:cmd Command run data modify storage mce:security LastBlocked.command set from storage mce:cmd Command
execute unless data storage mce:cmd Command run data remove storage mce:security LastBlocked.command

data modify storage mce:error Last set from storage mce:security state.reason
data modify storage mce:error Code set from storage mce:security state.code
function mce:core/error/raise

data remove storage mce:cmd Command
data remove storage mce:cmd Delay
data remove storage mce:cmd AtX
data remove storage mce:cmd AtY
data remove storage mce:cmd AtZ
data remove storage mce:auth approved
