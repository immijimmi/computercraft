local execute_moves = require("execute_moves")
local constants = require("constants")


function execute_reversed_moves(moves)
    --[[
    This function turns the turtle 180 degrees before and after exevuting the reversed move sequence,
    and therefore does not reverse forward and back moves. This approach is in the interest of time efficiency
    --]]

    local reversed_moves = {}
    for index, move in ipairs(moves) do
        reverse_index = #moves - (index-1)

        reversed_moves[reverse_index] = constants.reversed_moves[move]
    end

    turtle.turnRight()
    turtle.turnRight()

    execute_moves(reversed_moves)

    turtle.turnRight()
    turtle.turnRight()
end


return execute_reversed_moves
