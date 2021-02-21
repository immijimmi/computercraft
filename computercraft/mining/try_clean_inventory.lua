local constants = require("mining.constants")
local has_free_slots = require("turtle.has_free_slots")


function try_clean_inventory(empty_slots_required, is_eager)
    --[[
    If the inventory does not have enough empty slots after cleaning,
    this function returns False
    --]]

    -- Default values
    if is_eager == nil then
        is_eager = false
    end

    local current_slot_index = turtle.getSelectedSlot()

    local empty_slots = 0
    local non_valuables_indexes = {}

    for slot_index=1,16 do
        turtle.select(slot_index)
        local item_detail = turtle.getItemDetail()

        if item_detail == nil then
            empty_slots = empty_slots+1
        elseif constants.non_valuables[item_detail["name"]] then
            non_valuables_indexes[#non_valuables_indexes] = slot_index
        end
    end

    for _, non_valuable_index in ipairs(non_valuables_indexes) do
        if is_eager or (empty_slots < empty_slots_required) then
            turtle.select(non_valuable_index)
            turtle.drop()
            empty_slots = empty_slots+1
        end
    end

    turtle.select(current_slot_index)

    return empty_slots >= empty_slots_required
end


return try_clean_inventory
