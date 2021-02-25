local try_excavate = require("mining.try_excavate")
local filled_square_moves = require("mining.filled_square_moves")
local execute_reversed_moves = require("mining.execute_reversed_moves")


function quarry(size)
    local executed_moves = {}

    while try_excavate(filled_square_moves(size), executed_moves, "fail", true, false) do
        if try_excavate({"down"}, executed_moves, false, true, false) then
            executed_moves[#executed_moves+1] = "down"
        else
            break
        end
    end

    execute_reversed_moves(executed_moves, true)
end


return quarry
