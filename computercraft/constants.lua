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
    }
}

return constants
