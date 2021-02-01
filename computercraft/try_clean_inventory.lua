local constants = require("constants.lua")


function try_clean_inventory()
    --[[
    If the inventory does not have enough empty slots after cleaning,
    this function should return False
    --]]

    local current_slot_index = turtle.getSelectedSlot()
    local empty_slots = 0

    for slot_index=1,16 do
        turtle.select(slot_index)
        local item_detail = turtle.getItemDetail()

        if item_detail == nil then
            empty_slots = empty_slots + 1
        elseif constants.non_valuables[item_detail["name"]] then
            turtle.drop()
            empty_slots = empty_slots + 1
        end
    end

    turtle.select(current_slot_index)

    return empty_slots >= constants.empty_slots_required
end


return try_clean_inventory