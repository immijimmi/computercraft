local try_move = require("mining.try_move")


function execute_moves(moves, is_reverse_order)
    --[[
    Basic batch function for try_move() - does not complete any additional work between moves nor
    make fuel checks/refuel
    --]]

    for _, move in ipairs(moves) do
        if not try_move(move, is_reverse_order) then
            error("Unable to complete move sequence.")
        end
    end
end


return execute_moves
