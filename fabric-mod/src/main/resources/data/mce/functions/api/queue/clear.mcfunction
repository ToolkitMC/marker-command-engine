# PUBLIC API — mce:api/queue/clear
# MCE version: 1.1.0
#
# Clear all pending commands from the queue without executing them.
# Usage: function mce:api/queue/clear

data modify storage mce:queue commands set value []
schedule clear mce:core/queue/tick
