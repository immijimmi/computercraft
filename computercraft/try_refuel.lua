function try_refuel(offset_amount)
    -- TODO: Add logic for refueling

    if turtle.getFuelLevel() < offset_amount * 2 then  -- Expecting at least 50% efficiency
        return False
    else
        return True
    end
end


return try_refuel
