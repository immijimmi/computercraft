local constants = require("mining.constants")


function fuel_required(moves)
    local non_fuel_moves = {turnLeft=true, turnRight=true}

    local result = 0
    for move in ipairs(moves) do
        if constants.moves_lookup[move] and not non_fuel_moves[move] then
            result = result+1
        end
    end

    return result
end


return fuel_required
