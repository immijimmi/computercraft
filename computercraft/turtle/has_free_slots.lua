function has_free_slots(count)
    local current_slot_index = turtle.getSelectedSlot()

    local free_slots = 0
    for slot_index=1,16 do
        turtle.select(slot_index)
        if turtle.getItemDetail() == nil then
            free_slots = free_slots+1
        end
    end

    turtle.select(current_slot_index)

    return free_slots >= count
end


return has_free_slots
