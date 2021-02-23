local concat_tables = require("data.concat_tables")


function try_clean_inventory(items_to_remove, empty_slots_required, is_eager)
    --[[
    If the inventory does not have enough empty slots after cleaning,
    this function returns False
    --]]

    -- Default values
    if is_eager == nil then
        is_eager = false
    end

    for name, count in pairs(items_to_remove) do
        assert(
            count == true or
                (type(count) == "number" and count > 0),
            "items to be removed must be provided as a table of the item's string ID to the >0 amount to be removed (or true if all should be removed)"
        )
    end
    items_to_remove = concat_tables({}, items_to_remove)  -- Making a working copy

    local current_slot_index = turtle.getSelectedSlot()

    local empty_slots = 0
    local removable_indexes = {}

    for slot_index=1,16 do
        turtle.select(slot_index)
        local item_detail = turtle.getItemDetail()

        if item_detail == nil then
            empty_slots = empty_slots+1
        elseif items_to_remove[item_detail["name"]] ~= nil then
            removable_indexes[#removable_indexes+1] = slot_index
        end
    end

    for _, removable_index in ipairs(removable_indexes) do
        if is_eager or (empty_slots < empty_slots_required) then
            turtle.select(removable_index)
            local item_detail = turtle.getItemDetail()
            local item_name = item_detail["name"]
            local item_count = item_detail["count"]

            local remove_value = items_to_remove[item_name]

            if remove_value == true then
                turtle.drop()
                empty_slots = empty_slots+1
            elseif remove_value > item_count then
                turtle.drop()
                empty_slots = empty_slots+1
                items_to_remove[item_name] = remove_value - item_count
            elseif remove_value == item_count then
                turtle.drop()
                empty_slots = empty_slots+1
                items_to_remove[item_name] = nil
            else
                turtle.drop(remove_value)
                items_to_remove[item_name] = nil
            end
        end
    end

    turtle.select(current_slot_index)

    return empty_slots >= empty_slots_required
end


return try_clean_inventory
