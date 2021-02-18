local try_move = require("mining.try_move")
local execute_moves = require("mining.execute_moves")
local execute_reversed_moves = require("mining.execute_reversed_moves")
local try_refuel = require("mining.try_refuel")
local inspect_all = require("mining.inspect_all")
local constants = require("mining.constants")
local concat_lists = require("mining.concat_lists")


function excavate(moves, prior_offset, do_backtrack)
    if prior_offset == nil then
        prior_offset = {}
    end

    local result = true

    local offset = {}
    local offset_limit = math.floor(turtle.getFuelLimit()/2)

    for move_index, move in ipairs(moves) do
        if #prior_offset + #offset >= offset_limit then  -- If offset limit is reached
            break
        end

        if #prior_offset + #offset >= turtle.getFuelLevel()-1 then  -- If fuel limit is reached
            local full_offset = concat_lists(prior_offset, offset)

            execute_reversed_moves(full_offset)
            if not try_refuel(#full_offset) then
                result = false
                return result
            end
            execute_moves(full_offset)
        end

        if not try_move(move) then
            result = false
            break
        end
        offset[#offset+1] = move

        local surrounding_blocks = inspect_all()

        local next_move = moves[move_index+1]
        if next_move then
            surrounding_blocks[next_move] = nil  -- If a move is already next, it does not need excavating
        end

        for key, block in pairs(surrounding_blocks) do
            if constants.valuables[block["name"]] then
                local full_offset = concat_lists(prior_offset, offset)

                local excavate_result = excavate({[1]=key}, full_offset, true)
                if excavate_result == false then
                    result = false
                    return result
                end
            end
        end
    end

    if do_backtrack then
        execute_reversed_moves(offset)  -- Backtrack only this particular call's offset
    end

    return result
end


return excavate
