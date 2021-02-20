local constants = require("turtle.constants")


function orient()
    --[[
    Meant to be called in startup scripts for turtles that were placed by other turtles;
    If the turtle was placed above a non-solid block, it will be facing the opposite direction to normal
    --]]

    local success, floor = turtle.inspectDown()

    if floor == nil or constants.non_solid_blocks[floor["name"]] then
        turtle.turnLeft()
        turtle.turnLeft()
    end
end


return orient
