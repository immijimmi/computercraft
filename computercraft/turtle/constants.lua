local cc_constants = require("constants")

local constants = {
    non_solid_blocks = {
        [cc_constants.ids.water]=true,
        [cc_constants.ids.lava]=true,
        [cc_constants.ids.flowing_water]=true,
        [cc_constants.ids.flowing_lava]=true
    }
}

return constants
