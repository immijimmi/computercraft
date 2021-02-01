local try_clean_inventory = require("try_clean_inventory.lua")


function try_move(move, is_reverse_order)
    --[[
    Reverse order only affects whether turns are executed before movement. Any reversal of direction
    should be carried out externally with the resulting direction being used in this function
    --]]

    function apply_turns(is_reverse)
        if not is_reverse then
            if move == "left" then
                turtle.turnLeft()
            elseif move == "right" then
                turtle.turnRight()
            elseif move == "back" then
                turtle.turnRight()
                turtle.turnRight()
            end

        else
            if move == "left" then
                turtle.turnRight()
            elseif move == "right" then
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
        else
            return {[1] = turtle.forward, [2] = turtle.dig}
        end
    end

    function try_move_command()
        for attempt=1,100 do
            if move_command() then
                return true
            elseif attempt == 100 then
                return false
            elseif not try_clean_inventory() then
                return false
            end

            dig_command()
        end
    end

    local valid_moves = {up=true, down=true, left=true, right=true, forward=true, back=true}
    if valid_moves[move] == nil then
        error(move)
    end

    local commands = get_commands()
    local move_command = commands[1]
    local dig_command = commands[2]

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
