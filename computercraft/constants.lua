local config = require("config")

local ids_version_lookup = {
    ["1.12.2"] = {
        turtle = "computercraft:turtle_expanded",
        disk_drive = "computercraft:peripheral",
        floppy_disk = "computercraft:disk_expanded"
    },
    ["1.16.4"] = {
        turtle = "computercraft:turtle_normal",
        disk_drive = "computercraft:disk_drive",
        floppy_disk = "computercraft:disk"
    }
}

local constants = {
    moves_save_file = "moves.csv",

    valid_directions = {
        forward=true,
        back=true,
        up=true,
        down=true,
        left=true,
        right=true
    },

    moves_lookup = {  -- Doubles as both a set and a lookup for reversed moves
        left = "right",
        right = "left",
        up = "down",
        down = "up",
        forward = "forward",
        back = "back",
        turnLeft = "turnRight",
        turnRight = "turnLeft"
    },

    ids = ids_version_lookup[config.version]
}

return constants
