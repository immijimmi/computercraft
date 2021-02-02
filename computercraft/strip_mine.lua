local excavate = require("excavate")
local constants = require("constants")

local input = {...}
local curr_depth = tonumber(input[1])
local resource = input[2]
local x_distance = math.abs(tonumber(input[3]))  -- No negatives allowed for x distance
local y_distance = constants.resource_depths[resource] - curr_depth


function strip_mine(x_distance, y_distance)
    moves = {}

    local y_direction = "up"
    if y_distance < 0 then
        y_direction = "down"
        y_distance = math.abs(y_distance)
    end

    for i=1,y_distance do
        moves[#moves+1] = y_direction
    end

    for i=1,x_distance do
        moves[#moves+1] = "forward"
    end

    excavate(moves)
end


strip_mine(x_distance, y_distance)
