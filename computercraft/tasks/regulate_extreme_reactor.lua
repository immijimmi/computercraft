local constants = require("tasks.constants")


function regulate_extreme_reactor(control_rod_level, energy_buffer_threshold, peripheral_side)
    -- Defaults
    if peripheral_side == nil then
        peripheral_side = "back"
    end
    if energy_buffer_threshold == nil then
        energy_buffer_threshold = 0.8
    end

    local reactor = peripheral.wrap(peripheral_side)

    -- Custom control rod logic may be worth adding later, for now sets rods to a static level
    -- Use a big reactor simulator to find out what the optimal control rod level is for your reactor
    reactor.setAllControlRodLevels(control_rod_level)  -- Control rod level should be an int between 0 and 100 representing percentage

    local energy_capacity = reactor.getEnergyCapacity()
    local is_reactor_active = reactor.getActive()
    while true do
        local energy_stored = reactor.getEnergyStored()
        local buffer_fill_percentage = energy_stored/energy_capacity

        if buffer_fill_percentage >= energy_buffer_threshold then
            if is_reactor_active then
                reactor.setActive(false)
                is_reactor_active = false
            end
        else
            if not is_reactor_active then
                reactor.setActive(true)
                is_reactor_active = true
            end
        end

        os.sleep(constants.idle_time.short)
    end
end


return regulate_extreme_reactor
