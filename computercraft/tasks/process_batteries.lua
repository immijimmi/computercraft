local is_redstone_on = require("turtle.is_redstone_on")
local constants = require("tasks.constants")


function process_batteries(is_charging, redstone_sides)
    --[[
    A highly specialised stateless routine for transferring power between an energy storage block and batteries.

    Expected use case is with the IC2 and Ender Storage mods, using one ender chest which holds unprocessed IC2 batteries and
    another one with a different combination for processed batteries.

    This makes it possible to teleport power between locations and dimensions.

    The chest to take unprocessed batteries from should be positioned above the turtle if batteries are being charged or below if they are being discharged,
    and the other chest should be in front to drop batteries after processing.
    The energy storage block should be in the opposite space to the unprocessed battery chest
    --]]

    -- Defaults
    if is_charging == nil then
        is_charging = false
    end

    local processed_battery_damage

    local suck_unprocessed_chest
    local suck_energy_storage_block

    local drop_unprocessed_chest
    local drop_energy_storage_block

    if is_charging then
        processed_battery_damage = 0

        suck_unprocessed_chest = turtle.suckUp
        suck_energy_storage_block = turtle.suckDown

        drop_unprocessed_chest = turtle.dropUp
        drop_energy_storage_block = turtle.dropDown
    else
        processed_battery_damage = 26  -- Assumes all empty IC2 batteries have a damage value of 26

        suck_unprocessed_chest = turtle.suckDown
        suck_energy_storage_block = turtle.suckUp

        drop_unprocessed_chest = turtle.dropDown
        drop_energy_storage_block = turtle.dropUp
    end

    local suck_processed_chest = turtle.suck
    local drop_processed_chest = turtle.drop

    turtle.select(1)
    while true do
        local held_item = turtle.getItemDetail()

        if held_item == nil then
            suck_energy_storage_block(1)
            held_item = turtle.getItemDetail()

            if held_item == nil then
                if is_redstone_on(redstone_sides) then
                    os.sleep(constants.idle_time.short)
                else
                    suck_unprocessed_chest(1)
                    held_item = turtle.getItemDetail()

                    if held_item == nil then
                        os.sleep(constants.idle_time.short)
                    end
                end
            end

        elseif held_item.damage == processed_battery_damage then
            local drop_success = drop_processed_chest()

            if drop_success == false then
                os.sleep(constants.idle_time.short)
            end

        else
            drop_energy_storage_block()
            os.sleep(constants.idle_time.long)
        end
    end
end


return process_batteries
