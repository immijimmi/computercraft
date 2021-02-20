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

    local give_items = {["minecraft:bucket"]=1}
    deploy_turtles(amount, {[1]="right",[2]="turnLeft"}, 2, give_items)

    turtle.turnLeft()
    turtle.turnLeft()
    set_startup_replace()
    turtle.turnLeft()
    turtle.turnLeft()
end


return deploy_lava_pool_refuels
