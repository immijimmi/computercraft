local try_clean_inventory = require("mining.try_clean_inventory")
local constants = require("mining.constants")


function try_move(move, is_reverse_order)
    --[[
    A managed function for movement that will attempt to remove obstacles if necessary.

    Reverse order only affects whether turns are executed before movement. Any reversal of direction
    should be carried out externally with the resulting direction being used in this function
    --]]

    -- Default values
    if is_reverse_order == nil then
        is_reverse_order = false
    end

    if constants.moves_lookup[move] == nil then
        error(move)
    end

    function apply_turns(is_reverse)
        if not is_reverse then
            if move == "left" or move == "turnLeft" then
                turtle.turnLeft()
            elseif move == "right" or move == "turnRight" then
                turtle.turnRight()
            elseif move == "back" then
                turtle.turnRight()
                turtle.turnRight()
            end

        else
            if move == "left" or move == "turnLeft" then
                turtle.turnRight()
            elseif move == "right" or move == "turnRight" then
                turtle.turnLeft()
            elseif move == "back" then
                turtle.turnLeft()
                turtle.turnLeft()
            end
        end
    end

    function get_commands()
        if move == "up" then
            return {[1] = turtle.up, [2] = turtle.digUp}
        elseif move == "down" then
            return {[1] = turtle.down, [2] = turtle.digDown}
        elseif move == "turnLeft" or move == "turnRight" then
            return {[1] = constants.empty_function, [2] = constants.empty_function}
        else
            return {[1] = turtle.forward, [2] = turtle.dig}
        end
    end

    -- Hoisted this logic so that locals are available in try_move_command
    local commands = get_commands()
    local move_command = commands[1]
    local dig_command = commands[2]

    function try_move_command()
        for attempt=1,100 do
            if move_command() then
                return true
            elseif attempt == 100 then
                return false
            elseif not try_clean_inventory() then
                return false
            end

            local inspect_success, block = turtle.inspect()

            if inspect_success and string.find(block["name"], "computercraft:") == 1 then
                os.sleep(constants.move_attempt_wait_time)
            else
                dig_command()
            end
        end
    end

    if not is_reverse_order then
        apply_turns()
        if try_move_command() then
            return true
        else
            apply_turns(true)
            return false
        end

    else
        if try_move_command() then
            apply_turns()
            return true
        else
            return false
        end
    end
end


return try_move
