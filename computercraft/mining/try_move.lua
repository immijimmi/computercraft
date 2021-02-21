local try_clean_inventory = require("mining.try_clean_inventory")
local constants = require("mining.constants")


function try_move(move, is_reverse_order)
    --[[
    A managed function for movement that will attempt to remove obstacles if necessary.
    Lazy inventory cleaning is implemented before each time an obstacle is removed.

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

    function try_move_command()
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
                if not try_clean_inventory() then
                    return false
                end
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
