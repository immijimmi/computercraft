local try_move = require("mining.try_move")
local execute_moves = require("mining.execute_moves")
local execute_reversed_moves = require("mining.execute_reversed_moves")
local try_refuel = require("mining.try_refuel")
local inspect_all = require("turtle.inspect_all")
local inspect_direction = require("turtle.inspect_direction")
local constants = require("mining.constants")
local cc_constants = require("constants")
local concat_lists = require("data.concat_lists")
local concat_tables = require("data.concat_tables")
local fuel_required = require("mining.fuel_required")
local error_if_not = require("data.error_if_not")


function try_excavate(moves, prior_moves, do_backtrack)
    --[[
    This function carries out a sequence of moves using try_move(), checking for ores around itself after each step.
    Any ores that are discovered will trigger recursion in order to mine the full ore node out before continuing.
    Fuel usage is also managed and refueling is attempted as necessary via try_refuel()
    --]]

    -- Default values
    if prior_moves == nil then
        prior_moves = {}
    end
    if do_backtrack == nil then
        do_backtrack = true
    end

    local result = true

    local executed_moves = {}
    local full_moves = concat_lists(prior_moves, executed_moves)

    for move_index, move in ipairs(moves) do
        local fuel_spent = fuel_required(full_moves)

        -- Check that will be more than enough fuel to return to the starting position, after the next move
        if fuel_spent >= turtle.getFuelLevel()-1 then
            execute_reversed_moves(full_moves)
            error_if_not(
                try_refuel(fuel_spent),
                "unable to refuel"
            )
            execute_moves(full_moves)
        end

        if not try_move(move) then
            result = false
            break
        end

        executed_moves[#executed_moves+1] = move
        full_moves[#full_moves+1] = move

        if constants.non_fuel_moves[move] == nil then  -- If the executed move required fuel
            fuel_spent = fuel_spent+1

            -- Inspecting the new surroundings for valuable ores
            local inspect_directions = concat_tables({}, cc_constants.valid_directions)

            local next_move = moves[move_index+1]
            if next_move then
                inspect_directions[next_move] = nil  -- If a move is already next, it does not need inspecting
            end

            for direction, _ in pairs(inspect_directions) do
                local block = inspect_direction(direction)

                if block and constants.valuables[block["name"]] then
                    local excavate_result = try_excavate({direction}, full_moves)
                    if not excavate_result then
                        result = false
                        return result
                    end
                end
            end
        end
    end

    -- If either backtracking is enabled or the turtle could not complete the move list
    if do_backtrack or not result then
        execute_reversed_moves(executed_moves)  -- Backtrack only this particular call's moves
    end

    return result
end


return try_excavate
