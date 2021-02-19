function has_items(item_amounts)
    local current_slot_index = turtle.getSelectedSlot()

    for slot_index=1,16 do
        turtle.select(slot_index)
        local detail = turtle.getItemDetail()

        if detail and item_amounts[detail["name"]] then
            local name = detail["name"]
            local count = detail["count"]

            item_amounts[name] = item_amounts[name] - count
        end
    end

    turtle.select(current_slot_index)

    for _, amount in pairs(item_amounts) do
        if amount > 0 then
            return false
        end
    end

    return true
end


return has_items
