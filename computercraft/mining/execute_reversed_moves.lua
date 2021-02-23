local execute_moves = require("mining.execute_moves")
local cc_constants = require("constants")


function execute_reversed_moves(moves, keep_non_valuables)
    --[[
    This function turns the turtle 180 degrees before and after executing the reversed move sequence,
    and therefore does not reverse forward and back moves. This approach is in the interest of time efficiency
    --]]

    -- Default values
    if keep_non_valuables == nil then
        keep_non_valuables = false
    end

    local reversed_moves = {}
    for index, move in ipairs(moves) do
        reverse_index = #moves - (index-1)

        reversed_moves[reverse_index] = cc_constants.moves_lookup[move]
    end

    turtle.turnRight()
    turtle.turnRight()

    execute_moves(reversed_moves, true, keep_non_valuables)

    turtle.turnRight()
    turtle.turnRight()
end


return execute_reversed_moves
