# Private: blocks run/at coordinates outside configured world bounds.

execute if data storage mce:config {mce:{security:{enabled:1b}}} run execute store result score #coord.x mce.sec run data get storage mce:cmd AtX
execute if data storage mce:config {mce:{security:{enabled:1b}}} run execute store result score #coord.y mce.sec run data get storage mce:cmd AtY
execute if data storage mce:config {mce:{security:{enabled:1b}}} run execute store result score #coord.z mce.sec run data get storage mce:cmd AtZ
execute if data storage mce:config {mce:{security:{enabled:1b}}} run execute store result score #coord.max_abs mce.sec run data get storage mce:config mce.security.max_coord_abs
execute if data storage mce:config {mce:{security:{enabled:1b}}} run scoreboard players operation #coord.min_abs mce.sec = #coord.max_abs mce.sec
execute if data storage mce:config {mce:{security:{enabled:1b}}} run scoreboard players operation #coord.min_abs mce.sec *= #neg.one mce.sec
execute if data storage mce:config {mce:{security:{enabled:1b}}} run execute store result score #coord.min_y mce.sec run data get storage mce:config mce.security.min_y
execute if data storage mce:config {mce:{security:{enabled:1b}}} run execute store result score #coord.max_y mce.sec run data get storage mce:config mce.security.max_y
execute if data storage mce:config {mce:{security:{enabled:1b}}} if score #coord.x mce.sec > #coord.max_abs mce.sec run function mce:core/security/block/coord_out_of_bounds
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b}}} if score #coord.x mce.sec < #coord.min_abs mce.sec run function mce:core/security/block/coord_out_of_bounds
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b}}} if score #coord.z mce.sec > #coord.max_abs mce.sec run function mce:core/security/block/coord_out_of_bounds
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b}}} if score #coord.z mce.sec < #coord.min_abs mce.sec run function mce:core/security/block/coord_out_of_bounds
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b}}} if score #coord.y mce.sec < #coord.min_y mce.sec run function mce:core/security/block/coord_out_of_bounds
execute if data storage mce:security {state:{allowed:1b}} if data storage mce:config {mce:{security:{enabled:1b}}} if score #coord.y mce.sec > #coord.max_y mce.sec run function mce:core/security/block/coord_out_of_bounds
execute if data storage mce:security {state:{allowed:0b}} run function mce:core/security/report_block
