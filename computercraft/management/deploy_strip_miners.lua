local handle_deployment = require("management.handle_deployment")


function deploy_strip_miners(amount, curr_depth, resource, distance, keep_non_valuables)
    -- Default values
    if keep_non_valuables == nil then
        keep_non_valuables = false
    end

    local file_contents = [[
shell.run("delete startup.lua")

local orient = require("turtle.orient")
local try_strip_mine = require("mining.try_strip_mine")

orient()
try_strip_mine(%d, "%s", %d, %s)
]]
    file_contents = string.format(file_contents, curr_depth, resource, distance, keep_non_valuables)

    local moves_between = {"right", "forward", "forward", "turnLeft"}

    handle_deployment(
    file_contents, "up",
    amount, moves_between, 0, "right_side", nil
    )
end


return deploy_strip_miners
