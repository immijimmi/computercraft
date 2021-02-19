function find_item(name)
    local result
    local current_slot_index = turtle.getSelectedSlot()

    for slot_index=1,16 do
        turtle.select(slot_index)

        local details = turtle.getItemDetail()
        if details and details["name"] == name then
            result = slot_index
            break
        end
    end

    turtle.select(current_slot_index)
    return result
end


return find_item
