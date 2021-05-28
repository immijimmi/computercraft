function is_redstone_on(sides, min_value)
    -- Default values
    if min_value == nil then
        min_value = 1  -- Any redstone power value at all will count by default
    end
    if sides == nil then
        sides = {"front", "back", "left", "right", "top", "bottom"}
    end

    for _, side in pairs(sides) do
        if rs.getAnalogInput(side) >= min_value then
            return true
        end
    end

    return false
end


return is_redstone_on
