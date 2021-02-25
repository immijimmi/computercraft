local set_startup_replace = require("management.set_startup_replace")
local deploy_turtles = require("management.deploy_turtles")


function handle_deployment(
    custom_file_contents, set_startup_replace_direction,
    amount, moves_between, delay_between, deploy_drive_position, give_items)

    local function generate_complete_file_contents()
        local standard_file_contents = [[
-- Boilerplate deployment code
shell.run("delete startup.lua")

local orient = require("turtle.orient")
orient()

-- Custom code
]]

        return standard_file_contents..custom_file_contents
    end

    set_startup_replace(generate_complete_file_contents(), set_startup_replace_direction, true)

    local deploy_success, deploy_data = pcall(
        function()
            deploy_turtles(amount, moves_between, delay_between, deploy_drive_position, give_items)
        end
    )

    local reset_startup_success, reset_startup_data = pcall(
        function()
            set_startup_replace(nil, set_startup_replace_direction, not deploy_success)
        end
    )
    if (not reset_startup_success) and (not deploy_success) then
        -- Assumes that the last set_startup_replace failed due to lack of fuel
        set_startup_replace(nil, set_startup_replace_direction, false)
    end

    if not deploy_success then
        error(deploy_data)
    elseif not reset_startup_success then
        error(reset_startup_data)
    end
end


return handle_deployment
