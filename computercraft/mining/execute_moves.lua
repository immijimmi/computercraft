local try_move = require("mining.try_move")


function execute_moves(moves, is_reverse_order, keep_non_valuables)
    --[[
    Basic batch function for try_move() - does not complete any additional work between moves nor
    make fuel checks/refuel.

    Reverse order only affects whether turns are executed before movement. Any reversal of direction
    should be carried out externally with the resulting direction being used in this function
    --]]

    -- Default values
    if is_reverse_order == nil then
        is_reverse_order = false
    end
    if keep_non_valuables == nil then
        keep_non_valuables = false
    end

    for _, move in ipairs(moves) do
        assert(
            try_move(move, is_reverse_order, keep_non_valuables),
            "unable to complete move sequence"
        )
    end
end


return execute_moves
