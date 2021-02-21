local turn_to = require("turtle.turn_to")


function inspect_direction(direction)
    local result
    local inspect_command

    if direction == "up" then
        inspect_command = turtle.inspectUp
    elseif direction == "down" then
        inspect_command = turtle.inspectDown
    else
        inspect_command = turtle.inspect
    end

    turn_to(direction)

    local success, value = inspect_command()
    if success then
        result = value
    end

    turn_to(direction, true)

    return result
end


return inspect_direction
