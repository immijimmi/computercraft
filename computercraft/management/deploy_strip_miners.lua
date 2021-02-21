local set_startup_replace = require("management.set_startup_replace")
local deploy_turtles = require("management.deploy_turtles")


function deploy_strip_miners(amount, curr_depth, resource, distance)
    local file_contents = "shell.run('delete startup.lua')\n\n"
    file_contents = file_contents.."local orient = require('turtle.orient')\n"
    file_contents = file_contents.."local try_strip_mine = require('mining.try_strip_mine')\n\n"
    file_contents = file_contents.."orient()\n"
    file_contents = file_contents.."try_strip_mine(%d, '%s', %d)\n"
    file_contents = string.format(file_contents, curr_depth, resource, distance)

    set_startup_replace(file_contents, "up", true)

    local deploy_success, deploy_data = pcall(
        function()
            deploy_turtles(amount, {"right", "forward", "forward", "turnLeft"}, 0, "right_side")
        end
    )

    local reset_startup_success, reset_startup_data = pcall(
        function()
            set_startup_replace(nil, "up", not deploy_success)
        end
    )
    if (not reset_startup_success) and (not deploy_success) then
        set_startup_replace(nil, "up", false)  -- Assumes that the last set_startup_replace failed due to lack of fuel
    end

    if not deploy_success then
        error(deploy_data)
    elseif not reset_startup_success then
        error(reset_startup_data)
    end
end


return deploy_strip_miners
