local try_excavate = require("mining.try_excavate")
local execute_moves = require("mining.execute_moves")
local execute_reversed_moves = require("mining.execute_reversed_moves")
local try_refuel = require("mining.try_refuel")
local fuel_required = require("mining.fuel_required")
local has_items = require("turtle.has_items")
local error_if_not = require("data.error_if_not")
local find_item = require("turtle.find_item")
local merged_item_counts = require("data.merged_item_counts")
local constants = require("management.constants")
local concat_lists = require("data.concat_lists")


function deploy_turtle(prior_moves, do_check_space, drive_position, give_items)
    --[[
    Note that this function is not designed to necessarily always conclude at the starting position,
    as it is not expected to venture far enough away for this to be an issue
    --]]

    -- Default values
    if prior_moves == nil then
        prior_moves = {}
    end
    if do_check_space == nil then
        do_check_space = true
    end
    if drive_position == nil then
        drive_position = "top_side"
    end
    if give_items == nil then
        give_items = {}
    end

    error_if_not(
        has_items(merged_item_counts(constants.deploy_items, give_items)),
        "required items are not in inventory"
    )

    -- Clearing space is hoisted rather than inline so that cleaning up placed items is not necessary when it fails
    local drive_moves = constants.drive_moves[drive_position]
    if do_check_space then
        error_if_not(
            try_excavate({"forward"}, prior_moves, true),
            "unable to clear the required space"
        )

        local drive_check_moves = concat_lists(drive_moves, {"forward"})
        error_if_not(
            try_excavate(drive_check_moves, prior_moves, true),
            "unable to clear the required space"
        )
    end

    -- As some movement further down is not fuel-safe, fuel checking is hoisted to here
    local fuel_spent = fuel_required(prior_moves)
    local fuel_moves_remaining = fuel_required(drive_moves) * 4
    local remaining_fuel_required = fuel_spent + fuel_moves_remaining

    if turtle.getFuelLevel() < remaining_fuel_required then
        execute_reversed_moves(prior_moves)
        error_if_not(
            try_refuel(remaining_fuel_required + fuel_spent, false),
            "insufficient fuel"
        )
        execute_moves(prior_moves)
    end

    local current_slot_index = turtle.getSelectedSlot()

    turtle.select(find_item("computercraft:turtle_normal"))
    turtle.place()
    peripheral.call("front", "turnOn")

    execute_moves(drive_moves)

    turtle.select(find_item("computercraft:disk_drive"))
    turtle.place()
    turtle.select(find_item("computercraft:disk"))
    turtle.drop()

    execute_reversed_moves(drive_moves)

    for item_name, item_count in pairs(give_items) do
        for count=1,item_count do
            turtle.select(find_item(item_name))
            turtle.drop(1)
        end
    end
    peripheral.call("front", "reboot")

    execute_moves(drive_moves)

    turtle.suck()
    turtle.dig()

    execute_reversed_moves(drive_moves)

    peripheral.call("front", "reboot")

    turtle.select(current_slot_index)
end


return deploy_turtle
