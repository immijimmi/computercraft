local try_excavate = require("mining.try_excavate")
local execute_moves = require("mining.execute_moves")
local execute_reversed_moves = require("mining.execute_reversed_moves")
local try_refuel = require("mining.try_refuel")
local fuel_required = require("mining.fuel_required")
local has_items = require("building.has_items")
local error_if_not = require("data.error_if_not")
local find_item = require("building.find_item")


function deploy_turtle(prior_moves, do_check_space)
    -- Default values
    if prior_moves == nil then
        prior_moves = {}
    end
    if do_check_space == nil then
        do_check_space = true
    end

    error_if_not(
        has_items({["computercraft:turtle_normal"=1, ["computercraft:disk_drive"]=1, ["computercraft:disk"]=1}),
        "required items are not in inventory"
    )

    if do_check_space then
        local check_moves = {[1]="forward", [2]="left", [3]="left", [4]="left", [5]="turnLeft"}
        if not try_excavate(check_moves, prior_moves, false) then
            error("unable to clear the required space")
        end
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
    peripheral.call("front", "turnOn")

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
