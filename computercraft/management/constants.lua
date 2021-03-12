local cc_constants = require("constants")

local constants = {
    drive_positions = {  -- Lookup table for where to move deployer turtle before placing disk drive in front of itself
        left_side={"left", "turnRight"},
        top_side={"up"},
        right_side={"right", "turnLeft"}
    },

    -- Generic items a deployer requires, excluding any deployable turtles and the items they in turn require for whatever task
    deploy_items = {
        [cc_constants.ids.disk_drive]=1,
        [cc_constants.ids.floppy_disk]=1
    }
}

return constants
