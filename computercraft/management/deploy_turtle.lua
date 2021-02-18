local try_excavate = require("mining.try_excavate")
local execute_moves = require("mining.execute_moves")
local execute_reversed_moves = require("mining.execute_reversed_moves")
local try_refuel = require("mining.try_refuel")
local fuel_required = require("mining.fuel_required")
local find_item = require("building.find_item")


function deploy_turtle(prior_moves)
    -- Default values
    if prior_moves == nil then
        prior_moves = {}
    end

    if not try_excavate({[1]="forward"}, prior_moves) then
        error("unable to clear space to place the turtle")
    end
    if not try_excavate({[1]="left", [2]="right"}, prior_moves) then
        error("unable to clear space to place the disk drive")
    end

    local fuel_spent = fuel_required(prior_moves)
    local fuel_moves_remaining = 4  -- Hardcoded value for how many moves are to be carried out below
    local remaining_fuel_required = fuel_spent + fuel_moves_remaining

    if turtle.getFuelLevel() < remaining_fuel_required then  -- If fuel limit is reached
        execute_reversed_moves(prior_moves)
        if not try_refuel(remaining_fuel_required + fuel_spent, false) then
            error("insufficient fuel")
        end
        execute_moves(prior_moves)
    end

    local current_slot_index = turtle.getSelectedSlot()

    turtle.select(find_item("computercraft:turtle_normal"))
    turtle.place()

    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()

    turtle.select(find_item("computercraft:disk_drive"))
    turtle.place()
    turtle.select(find_item("computercraft:disk"))
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

    turtle.select(current_slot_index)
end


return deploy_turtle
