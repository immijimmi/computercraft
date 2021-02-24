local find_item = require("turtle.find_item")
local try_excavate = require("mining.try_excavate")
local turn_to = require("turtle.turn_to")
local cc_constants = require("constants")


function set_startup_replace(file_contents, direction, do_check_space, prior_moves)
    -- Default values
    if direction == nil then
        direction = "up"
    end
    if do_check_space == nil then
        do_check_space = true
    end
    if prior_moves == nil then
        prior_moves = {}
    end

    assert(
        cc_constants.valid_directions[direction],
        direction
    )

    local function get_commands()
        if direction == "up" then
            return {turtle.placeUp, turtle.digUp, turtle.dropUp, turtle.suckUp}
        elseif direction == "down" then
            return {turtle.placeDown, turtle.digDown, turtle.dropDown, turtle.suckDown}
        else
            return {turtle.place, turtle.dig, turtle.drop, turtle.suck}
        end
    end

    if do_check_space then
        assert(
            try_excavate({direction}, prior_moves, true, false, false),
            "unable to clear the required space"
        )
    end

    local current_slot_index = turtle.getSelectedSlot()

    local commands = get_commands()
    local place_command = commands[1]
    local dig_command = commands[2]
    local drop_command = commands[3]
    local suck_command = commands[4]

    turtle.select(find_item("computercraft:disk_drive"))
    turn_to(direction)

    if not place_command() then
        turn_to(direction, true)
        turtle.select(current_slot_index)
        error("unable to place the disk drive")
    end

    turtle.select(find_item("computercraft:disk"))
    drop_command()

    if file_contents == nil then
        fs.delete("disk/startup_replace.lua")
    else
        file = fs.open("disk/startup_replace.lua", "w")
        file.write(file_contents)
        file.close()
    end

    suck_command()
    dig_command()

    turn_to(direction, true)
    turtle.select(current_slot_index)
end


return set_startup_replace
