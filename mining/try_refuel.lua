function try_refuel(offset_amount)
    -- TODO: Add logic for refueling

    --[[
    Below calc assumes that you want to return to where you were before backtracking to refuel,
    and be able to make at least 1 more move before needing to backtrack once again
    --]]
    if turtle.getFuelLevel() < (offset_amount * 2) + 2 then
        return False
    else
        return True
    end
end


return try_refuel
