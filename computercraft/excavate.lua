local try_move = require("try_move.lua")
local execute_moves = require("execute_moves.lua")
local execute_reversed_moves = require("execute_reversed_moves.lua")
local try_refuel = require("try_refuel.lua")
local inspect_all = require("inspect_all.lua")
local constants = require("constants.lua")
local concat_lists = require("concat_lists.lua")


function excavate(moves, prior_offset)
    if prior_offset == nil then
        prior_offset = {}
    end

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
                return false
            end
            execute_moves(full_offset)
        end

        if not try_move(move) then
            break
        end

        local surrounding_blocks = inspect_all()
        surrounding_blocks[moves[move_index+1]] = nil  -- If a move is already next, it does not need excavating

        for key, block in pairs(surrounding_blocks) do
            if constants.valuables[block["name"]] then
                local full_offset = concat_lists(prior_offset, offset)

                local excavate_result = excavate({[1]=key}, full_offset)
                if excavate_result == false then
                    return false
                end
            end
        end
    end

    execute_reversed_moves(offset)  -- Backtrack only this particular call's offset
    return true
end


return excavate
