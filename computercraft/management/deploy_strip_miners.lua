local set_startup_replace = require("management.set_startup_replace")
local deploy_turtles = require("management.deploy_turtles")


function deploy_strip_miners(amount, curr_depth, resource, distance)
    local file_contents = "shell.run('delete startup.lua')\n\n"
    file_contents = file_contents.."local orient = require('turtle.orient')\n"
    file_contents = file_contents.."local try_strip_mine = require('mining.try_strip_mine')\n\n"
    file_contents = file_contents.."orient()\n"
    file_contents = file_contents.."try_strip_mine(%d, '%s', %d)\n"
    file_contents = string.format(file_contents, curr_depth, resource, distance)

    turtle.turnLeft()
    turtle.turnLeft()
    set_startup_replace(file_contents, true)
    turtle.turnLeft()
    turtle.turnLeft()

    deploy_turtles(amount, {[1]="right",[2]="forward",[3]="forward",[4]="turnLeft"}, 0)

    turtle.turnLeft()
    turtle.turnLeft()
    set_startup_replace()
    turtle.turnLeft()
    turtle.turnLeft()
end


return deploy_strip_miners
