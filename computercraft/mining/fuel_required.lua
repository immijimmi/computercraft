local constants = require("mining.constants")
local cc_constants = require("constants")


function fuel_required(moves)
    local result = 0
    for move in ipairs(moves) do
        if cc_constants.moves_lookup[move] and not constants.non_fuel_moves[move] then
            result = result+1
        end
    end

    return result
end


return fuel_required
