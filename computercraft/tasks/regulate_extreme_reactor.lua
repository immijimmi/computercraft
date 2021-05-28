local constants = require("tasks.constants")
local is_redstone_on = require("turtle.is_redstone_on")


function regulate_extreme_reactor(control_rod_level, peripheral_side)
    --[[
    Stateless routine for managing an extreme reactor.

    Note: Extreme reactors continue working even when the chunk is not loaded, whereas computers do not.
    This leaves them unregulated when the chunk is not loaded.
    A solution to this would be to keep the chunk loaded using a loader that works even when the player is offline.
    --]]

    -- Defaults
    if peripheral_side == nil then
        peripheral_side = "back"
    end

    local energy_buffer_min = 0.2
    local energy_buffer_max = 0.8

    local reactor = peripheral.wrap(peripheral_side)

    -- Custom control rod logic may be worth adding later, for now sets rods to a static level
    -- Use a big reactor simulator to find out what the optimal control rod level is for your reactor
    reactor.setAllControlRodLevels(control_rod_level)  -- Control rod level should be an int between 0 and 100 representing percentage

    local energy_capacity = reactor.getEnergyCapacity()
    local is_reactor_active = reactor.getActive()
    while true do
        local energy_stored = reactor.getEnergyStored()
        local buffer_fill_percentage = energy_stored/energy_capacity
        local is_switched_off = is_redstone_on()

        if is_switched_off then
            if is_reactor_active then
                reactor.setActive(false)
                is_reactor_active = false
            end

        else
            if buffer_fill_percentage >= energy_buffer_max then
                if is_reactor_active then
                    reactor.setActive(false)
                    is_reactor_active = false
                end
            elseif buffer_fill_percentage < energy_buffer_min then
                if not is_reactor_active then
                    reactor.setActive(true)
                    is_reactor_active = true
                end
            end
        end

        os.sleep(constants.idle_time.short)
    end
end


return regulate_extreme_reactor
