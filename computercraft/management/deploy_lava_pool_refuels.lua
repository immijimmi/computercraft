local set_startup_replace = require("management.set_startup_replace")
local deploy_turtles = require("management.deploy_turtles")


function deploy_lava_pool_refuels(amount)
    local file_contents = "shell.run('delete startup.lua')\n\n"
    file_contents = file_contents.."local orient = require('turtle.orient')\n"
    file_contents = file_contents.."local lava_pool_refuel = require('mining.lava_pool_refuel')\n\n"
    file_contents = file_contents.."orient()\n"
    file_contents = file_contents.."lava_pool_refuel()\n"

    turtle.turnLeft()
    turtle.turnLeft()
    set_startup_replace(file_contents, true)
    turtle.turnLeft()
    turtle.turnLeft()

    local deploy_success, deploy_data = pcall(
        function()
            deploy_turtles(amount, {"right", "turnLeft"}, 0, "right_side", {["minecraft:bucket"]=1})
        end
    )

    turtle.turnLeft()
    turtle.turnLeft()

    local reset_startup_success, reset_startup_data = pcall(
        function()
            set_startup_replace(nil, not deploy_success)
        end
    )
    if (not reset_startup_success) and (not deploy_success) then
        set_startup_replace(nil, false)  -- Assumes that the last set_startup_replace failed due to lack of fuel
    end

    turtle.turnLeft()
    turtle.turnLeft()

    if not deploy_success then
        error(deploy_data)
    elseif not reset_startup_success then
        error(reset_startup_data)
    end
end


return deploy_lava_pool_refuels
