local handle_deployment = require("management.handle_deployment")


function deploy_strip_miners(amount, curr_depth, resource, distance, keep_non_valuables)
    -- Default values
    if keep_non_valuables == nil then
        keep_non_valuables = false
    end

    local custom_file_contents = [[
local try_strip_mine = require("mining.try_strip_mine")

try_strip_mine(%d, "%s", %d, %s)
]]
    custom_file_contents = string.format(custom_file_contents, curr_depth, resource, distance, keep_non_valuables)

    local moves_between = {"right", "forward", "forward", "turnLeft"}

    handle_deployment(
        custom_file_contents, "up",
        amount, moves_between, 0, "right_side", nil
    )
end


return deploy_strip_miners
