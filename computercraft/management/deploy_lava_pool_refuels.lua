local handle_deployment = require("management.handle_deployment")


function deploy_lava_pool_refuels(amount)
    local file_contents = [[
shell.run("delete startup.lua")

local orient = require("turtle.orient")
local lava_pool_refuel = require("mining.lava_pool_refuel")

orient()
lava_pool_refuel()
]]

    local moves_between = {"right", "turnLeft"}
    local give_items = {["minecraft:bucket"]=1}

    handle_deployment(
    file_contents, "up",
    amount, moves_between, 0, "right_side", give_items
    )
end


return deploy_lava_pool_refuels
