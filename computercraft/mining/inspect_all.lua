function inspect_all()
    local result = {}

    local success, value = turtle.inspectUp()
    if success then
        result["up"] = value
    end

    local success, value = turtle.inspectDown()
    if success then
        result["down"] = value
    end

    for _, direction in ipairs({"forward", "left", "back", "right"}) do
        local success, value = turtle.inspect()
        if success then
            result[direction] = value
        end
        turtle.turnLeft()
    end

    return result
end


return inspect_all
