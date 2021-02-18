local try_excavate = require("mining.try_excavate")
local execute_moves = require("mining.execute_moves")
local execute_reversed_moves = require("mining.execute_reversed_moves")
local try_refuel = require("mining.try_refuel")


function deploy_turtle(prior_offset)
    if prior_offset == nil then
        prior_offset = {}
    end

    if not try_excavate({[1]="forward"}, prior_offset) then
        error("unable to clear space to place the turtle")
    end
    if not try_excavate({[1]="left", [2]="right"}, prior_offset) then
        error("unable to clear space to place the disk drive")
    end

    local remaining_fuel_required = #prior_offset + 4
    if turtle.getFuelLevel() < remaining_fuel_required then  -- If fuel limit is reached
        execute_reversed_moves(prior_offset)
        if not try_refuel(remaining_fuel_required) then
            error("insufficient fuel")
        end
        execute_moves(prior_offset)
    end

    local current_slot_index = turtle.getSelectedSlot()

    turtle.select(find_item("computercraft:turtle_normal"))
    turtle.place()

    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()

    turtle.select(find_item("computercraft:disk_drive"))
    turtle.place()
    turtle.select(find_item("computercraft:disk")
    turtle.drop()

    turtle.turnRight()
    turtle.forward()
    turtle.turnLeft()

    peripheral.call("front", "reboot")

    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()

    turtle.suck()
    turtle.dig()

    turtle.turnRight()
    turtle.forward()
    turtle.turnLeft()

    peripheral.call("front", "reboot")
end


return deploy_turtle
