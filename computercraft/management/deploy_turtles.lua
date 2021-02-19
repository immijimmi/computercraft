local deploy_turtle = require("management.deploy_turtle")
local concat_lists = require("data.concat_lists")
local try_excavate = require("mining.try_excavate")
local error_if_not = require("data.error_if_not")
local execute_reversed_moves = require("mining.execute_reversed_moves")


function deploy_turtles(amount, moves_between, delay_between)
    -- Default values
    if moves_between == nil then
        moves_between = {}
    end
    if delay_between == nil then
        delay_between = 1
    end

    local is_static = #moves_between == 0
    local moves = {}

    deploy_turtle(moves)  -- do_check_space should always be true for the first deployment
    amount = amount - 1

    for i=1,amount do
        if delay_between > 0 then
            os.sleep(delay_between)
        end

        if not is_static then
            if not try_excavate(moves_between, moves, false) then
                execute_reversed_moves(moves),
                error("unable to clear the required space")
            end
            moves = concat_lists(moves, moves_between)
        end

        deploy_turtle(moves, not is_static)
    end

    execute_reversed_moves(moves)
end


return deploy_turtles
