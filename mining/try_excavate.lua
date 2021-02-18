local try_move = require("mining.try_move")
local execute_moves = require("mining.execute_moves")
local execute_reversed_moves = require("mining.execute_reversed_moves")
local try_refuel = require("mining.try_refuel")
local inspect_all = require("mining.inspect_all")
local constants = require("mining.constants")
local concat_lists = require("mining.concat_lists")
local fuel_required = require("mining.fuel_required")


function try_excavate(moves, prior_moves, do_backtrack)
    if prior_moves == nil then
        prior_moves = {}
    end

    local result = true

    local executed_moves = {}
    local full_moves = concat_lists(prior_moves, executed_moves)
    local offset_limit = math.floor(turtle.getFuelLimit()/2)

    for move_index, move in ipairs(moves) do
        local fuel_spent = fuel_required(full_moves)

        if fuel_spent >= offset_limit then  -- Offset limit reached
            break
        end

        -- Check that there is more than enough fuel to return to the starting position
        if fuel_spent >= turtle.getFuelLevel()-1 then
            execute_reversed_moves(full_moves)
            if not try_refuel(fuel_spent) then
                result = false
                return result
            end
            execute_moves(full_moves)
        end

        if not try_move(move) then
            result = false
            break
        end

        executed_moves[#executed_moves+1] = move
        full_moves[#full_moves+1] = move
        fuel_spent = fuel_required(full_moves)

        local surrounding_blocks = inspect_all()

        local next_move = moves[move_index+1]
        if next_move then
            surrounding_blocks[next_move] = nil  -- If a move is already next, it does not need excavating
        end

        for key, block in pairs(surrounding_blocks) do
            if constants.valuables[block["name"]] then
                local excavate_result = try_excavate({[1]=key}, full_moves, true)
                if excavate_result == false then
                    result = false
                    return result
                end
            end
        end
    end

    if do_backtrack or not result then  -- Either backtrack is enabled or the turtle could not complete the move list
        execute_reversed_moves(executed_moves)  -- Backtrack only this particular call's moves
    end

    return result
end


return try_excavate
