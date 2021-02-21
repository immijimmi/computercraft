local error_if_not = require("data.error_if_not")
local cc_constants = require("constants")


function turn_to(move_or_direction, is_reverse)
    error_if_not(
        constants.moves_lookup[move_or_direction],
        move_or_direction
    )

    if not is_reverse then
        if move_or_direction == "left" or move_or_direction == "turnLeft" then
            turtle.turnLeft()
        elseif move_or_direction == "right" or move_or_direction == "turnRight" then
            turtle.turnRight()
        end

    else
        if move_or_direction == "left" or move_or_direction == "turnLeft" then
            turtle.turnRight()
        elseif move_or_direction == "right" or move_or_direction == "turnRight" then
            turtle.turnLeft()
    end

    if move_or_direction == "back" then
        turtle.turnRight()
        turtle.turnRight()
    end
end


return turn_to
