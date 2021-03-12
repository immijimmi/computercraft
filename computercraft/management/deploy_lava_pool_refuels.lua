local handle_deployment = require("management.handle_deployment")
local cc_constants = require("constants")


function deploy_lava_pool_refuels(amount)
    local custom_file_contents = [[
local lava_pool_refuel = require("mining.lava_pool_refuel")

lava_pool_refuel()
]]

    local moves_between = {"right", "turnLeft"}
    local give_items = {[cc_constants.ids.bucket]=1}

    handle_deployment(
        custom_file_contents, "up",
        amount, moves_between, 0, "right_side", give_items
    )
end


return deploy_lava_pool_refuels
