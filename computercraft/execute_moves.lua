local try_move = require("try_move.lua")


function execute_moves(moves)
    --[[
    Basic batch function for try_move() - does not complete any additional work between moves nor
    make fuel checks/refuel
    --]]

    for _, move in ipairs(moves) do
        if not try_move(move) then
            error("Unable to complete move sequence.")
        end
    end
end


return execute_moves
