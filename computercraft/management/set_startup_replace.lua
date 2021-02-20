local find_item = require("turtle.find_item")
local try_excavate = require("mining.try_excavate")


function set_startup_replace(file_contents, do_check_space, prior_moves)
    -- Default values
    if do_check_space == nil then
        do_check_space = true
    end
    if prior_moves == nil then
        do_check_space = {}
    end

    if do_check_space then
        local check_moves = {[1]="forward", [2]="back", [3]="turnLeft", [4]="turnLeft"}
        error_if_not(
            try_excavate(check_moves, prior_moves, false),
            "unable to clear the required space"
        )
    end

    local current_slot_index = turtle.getSelectedSlot()

    turtle.select(find_item("computercraft:disk_drive"))
    if not turtle.place() then
        turtle.select(current_slot_index)
        error("unable to place the disk drive")
    end

    turtle.select(find_item("computercraft:disk"))
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
