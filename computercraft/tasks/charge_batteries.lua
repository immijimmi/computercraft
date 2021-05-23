local is_redstone_on = require("turtle.is_redstone_on")


function charge_batteries()
    --[[
    A highly specialised stateless routine for emptying power out of an energy storage block into batteries.

    Expected use case is with the IC2 and Ender Storage mods, using one ender chest which holds empty IC2 batteries and another one with a different combination
    for full batteries. Paired with discharge_batteries to unload power where necessary, this makes it possible to teleport power between locations
    and dimensions.

    The chest to take empty batteries from should be positioned above the turtle, and the other chest should be in front to drop batteries after processing.
    The energy storage block should be below.
    --]]

    local idle_time = 5

    -- Aliases for readability
    local suck_unprocessed_chest = turtle.suckUp
    local suck_processed_chest = turtle.suck
    local suck_energy_storage_block = turtle.suckDown

    local drop_unprocessed_chest = turtle.dropUp
    local drop_processed_chest = turtle.drop
    local drop_energy_storage_block = turtle.dropDown

    turtle.select(1)
    while true do
        local held_item = turtle.getItemDetail()

        if held_item == nil then
            suck_energy_storage_block(1)
            held_item = turtle.getItemDetail()

            if held_item == nil then
                if is_redstone_on({"back", "left", "right"}) then
                    os.sleep(idle_time)
                else
                    suck_unprocessed_chest(1)
                    held_item = turtle.getItemDetail()

                    if held_item == nil then
                        os.sleep(idle_time)
                    end
                end
            end

        elseif held_item.damage == 0 then  -- Battery is fully charged
            local drop_success = drop_processed_chest()

            if drop_success == false then
                os.sleep(idle_time)
            end

        else
            drop_energy_storage_block()
            os.sleep(idle_time)
        end
    end
end


return charge_batteries
