function try_refuel(fuel_required, is_offset)
    -- Default values
    if is_offset == nil then
        is_offset = true
    end

    -- TODO: Add logic for refueling

    --[[
    Below calc assumes that you want to return to where you were before backtracking to refuel,
    and be able to make at least 1 more move before needing to backtrack once again
    --]]
    if is_offset then
        fuel_required = (fuel_required * 2) + 2
    end

    if turtle.getFuelLevel() < fuel_required then
        return False
    else
        return True
    end
end


return try_refuel
