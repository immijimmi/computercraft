local try_clean_inventory = require("mining.try_clean_inventory")
local constants = require("mining.constants")
local turn_to = require("turtle.turn_to")
local cc_constants = require("constants")
local append_to_csv = require("data.append_to_csv")
local csv_to_list = require("data.csv_to_list")
local list_to_csv = require("data.list_to_csv")


function try_move(move, is_reverse_order, keep_non_valuables)
    --[[
    A managed function for movement that will attempt to remove obstacles if necessary.
    Lazy inventory cleaning is implemented before each time an obstacle is removed.

    Reverse order only affects whether turns are executed before movement.
    Any actual reversal of direction should be carried out externally with the resulting direction being used in this function
    --]]

    -- Default values
    if is_reverse_order == nil then
        is_reverse_order = false
    end
    if keep_non_valuables == nil then
        keep_non_valuables = false
    end

    assert(
        cc_constants.moves_lookup[move],
        move
    )

    local function get_commands()
        if move == "up" then
            return {turtle.up, turtle.digUp, turtle.inspectUp}
        elseif move == "down" then
            return {turtle.down, turtle.digDown, turtle.inspectDown}
        elseif move == "turnLeft" or move == "turnRight" then
            return {constants.empty_function}
        else
            return {turtle.forward, turtle.dig, turtle.inspect}
        end
    end

    -- Hoisted this logic so that locals are available in try_move_command
    local commands = get_commands()
    local move_command = commands[1]
    local dig_command = commands[2]
    local inspect_command = commands[3]

    local function try_move_command()
        for attempt=1,100 do
            if move_command() then
                return true
            elseif attempt == 100 then
                return false
            end

            local inspect_success, block = inspect_command()
            if (not inspect_success) or (inspect_success and string.find(block["name"], "computercraft:") == 1) then
                os.sleep(constants.move_attempt_wait_time)
            else
                if not try_clean_inventory(constants.non_valuables, constants.empty_slots_required, not keep_non_valuables) then
                    return false
                end
                dig_command()
            end
        end
    end

    if not is_reverse_order then
        turn_to(move)
        if try_move_command() then
            return true
        else
            turn_to(move, true)
            return false
        end

    else
        if try_move_command() then
            turn_to(move)
            return true
        else
            return false
        end
    end
end


return try_move
