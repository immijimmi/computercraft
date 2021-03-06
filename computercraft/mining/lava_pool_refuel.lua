local has_items = require("turtle.has_items")
local find_item = require("turtle.find_item")
local has_free_slots = require("turtle.has_free_slots")
local constants = require("mining.constants")
local cc_constants = require("constants")
local execute_reversed_moves = require("mining.execute_reversed_moves")


function lava_pool_refuel()
    --[[
    Because this is itself a refueling method, it is not fuel-safe.
    Assumptions are made that the turtle is directly above lava and facing towards a lava pool, and that it will not run out of fuel mid-refueling
    --]]

    local function try_lava_refuel_down()
        turtle.select(find_item(cc_constants.ids.bucket))
        turtle.placeDown()

        local lava_bucket_index = find_item(cc_constants.ids.lava_bucket)
        if not (lava_bucket_index == nil) then
            turtle.select(lava_bucket_index)
            turtle.refuel()
            return true
        end

        return false
    end

    local function can_lava_refuel()
        return turtle.getFuelLevel() + constants.fuel_amounts[cc_constants.ids.lava_bucket] < turtle.getFuelLimit()
    end

    assert(
        has_items({[cc_constants.ids.bucket]=1}) and has_free_slots(1),
        "turtle needs an empty bucket to refuel using lava, "..
        "and one free slot to hold the lava bucket incase the empty bucket is in a stack of more than 1"
    )

    local current_slot_index = turtle.getSelectedSlot()

    local row_moves = {}
    while can_lava_refuel() do
        try_lava_refuel_down()

        local column_moves = {}
        while can_lava_refuel() do
            local move_success = turtle.down()
            if not move_success then
                break
            end
            column_moves[#column_moves+1] = "down"

            try_lava_refuel_down()
        end
        execute_reversed_moves(column_moves, true)  -- Lava refueling should not eject items unnecessarily, so keep_non_valuables is true here

        if can_lava_refuel() then
            local move_success = turtle.forward()
            if not move_success then
                break
            end
            row_moves[#row_moves+1] = "forward"
        end
    end
    execute_reversed_moves(row_moves, true)

    turtle.select(current_slot_index)
end


return lava_pool_refuel
