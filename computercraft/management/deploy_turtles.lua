local deploy_turtle = require("management.deploy_turtle")
local concat_lists = require("data.concat_lists")
local try_excavate = require("mining.try_excavate")
local error_if_not = require("data.error_if_not")
local execute_reversed_moves = require("mining.execute_reversed_moves")


function deploy_turtles(amount, moves_between, delay_between, drive_position, give_items)
    --[[
    Note that this function is not designed to necessarily always conclude at the starting position,
    as it is not expected to venture far enough away for this to be an issue
    --]]

    -- Default values
    if moves_between == nil then
        moves_between = {}
    end
    if delay_between == nil then
        delay_between = 0
    end
    if drive_position == nil then
        drive_position = "top_side"
    end
    if give_items == nil then
        give_items = {}
    end

    local is_static = #moves_between == 0
    local executed_moves = {}

    -- For the first deployment, do_check_space should always be true
    deploy_turtle(executed_moves, true, drive_position, give_items)

    for turtle_number=2,amount do
        if delay_between > 0 then
            os.sleep(delay_between)
        end

        if not is_static then
            if not try_excavate(moves_between, executed_moves, false) then
                execute_reversed_moves(executed_moves)
                error("unable to clear the required space")
            end
            executed_moves = concat_lists(executed_moves, moves_between)
        end

        deploy_turtle(executed_moves, not is_static, drive_position, give_items)
    end

    execute_reversed_moves(executed_moves)
end


return deploy_turtles
