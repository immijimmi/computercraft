local find_item = require("building.find_item")


function set_startup_replace(file_contents)
    local current_slot_index = turtle.getSelectedSlot()

    turtle.select(find_item("computercraft:disk_drive"))
    if not turtle.place() then
        turtle.select(current_slot_index)
        error("unable to place the disk drive")
    end

    turtle.select(find_item("computercraft:disk")
    turtle.drop()

    if file_contents == nil then
        fs.delete("disk/startup_replace.lua")
    else
        file = fs.open("disk/startup_replace.lua", "w")
        file.write(file_contents)
        file.close()
    end

    turtle.suck()
    turtle.dig()

    turtle.select(current_slot_index)
end


return set_startup_replace
