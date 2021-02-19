local set_startup_replace = require("management.set_startup_replace")
local deploy_turtles = require("management.deploy_turtles")


function deploy_lava_pool_refuels(amount)
    local file_contents = "shell.run('delete startup.lua')\n\n"
    file_contents = file_contents.."local lava_pool_refuel = require('mining.lava_pool_refuel')\n\n"
    file_contents = file_contents.."lava_pool_refuel()"

    set_startup_replace(file_contents)

    deploy_turtles(amount, {[1]="right",[2]="turnLeft"}, 0)

    set_startup_replace()
end


return deploy_lava_pool_refuels
