--[[
A highly specialised stateless routine which expects a container of chargeable batteries above,
an energy storage block able to receive and charge a single battery in front, and a container with space to receive
fully charged batteries below.

Expected use case is with the IC2 and Ender Storage mods, using an ender chest which holds empty batteries above and a different one
for full batteries below. Paired with a reverse of this routine to unload power where necessary, this makes it possible to teleport power between locations
and dimensions.
--]]
function charge_batteries()
    local idle_time = 5

    turtle.select(1)
    while true do
        local held_item = turtle.getItemDetail()

        if held_item == nil then
            turtle.suck(1)
            held_item = turtle.getItemDetail()

            if held_item == nil then
                turtle.suckUp(1)
                held_item = turtle.getItemDetail()

                if held_item == nil then
                    os.sleep(idle_time)
                end
            end

        elseif held_item.damage == 0 then
            local drop_success = turtle.dropDown()

            if drop_success == false then
                os.sleep(idle_time)
            end

        else
            turtle.drop()
            os.sleep(idle_time)
        end
    end
end


return charge_batteries
