local excavate = require("excavate")
local constants = require("constants")


function strip_mine(curr_depth, resource, distance)
    local moves = {}
    local offset_counts = {["forward"]=0, ["up"]=0}

    local min_depth = constants.resource_depths[resource][1]
    local max_depth = constants.resource_depths[resource][2]

    -- Reach starting depth from current depth
    while curr_depth > max_depth-1 do  -- 1 below the top of the resource spawn range
        moves[#moves+1] = "down"
        curr_depth = curr_depth-1
        offset_counts["up"] = offset_counts["up"]-1
    end
    while curr_depth < max_depth-1 do
        moves[#moves+1] = "up"
        curr_depth = curr_depth+1
        offset_counts["up"] = offset_counts["up"]+1
    end

    -- First strip
    for i=1,distance do
        moves[#moves+1] = "forward"
        offset_counts["forward"] = offset_counts["forward"]+1
    end

    -- Repeating strips
    local forward = false
    while curr_depth-3 >= min_depth+1 do
        -- Tunnel down by 3 to start a new strip
        for i=1,3 do
            moves[#moves+1] = "down"
            curr_depth = curr_depth-1
            offset_counts["up"] = offset_counts["up"]-1
        end

        -- Strip
        for i=1,distance do
            if i==1 then
                moves[#moves+1] = "back"
            else
                moves[#moves+1] = "forward"
            end

            if not forward then
                offset_counts["forward"] = offset_counts["forward"]-1
            else
                offset_counts["forward"] = offset_counts["forward"]+1
            end
        end

        -- Keep track of direction faced
        forward = not forward
    end

    -- Backtrack along the forward axis
    if (offset_counts["forward"] >= 0) == forward then
        for i=1,offset_counts["forward"] do
            moves[#moves+1] = "forward"
        end
    else
        moves[#moves+1] = "back"
        forward = not forward  -- Still keeping track of direction faced

        for i=1,math.abs(offset_counts["forward"])-1 do
            moves[#moves+1] = "forward"
        end
    end

    -- Backtrack along the up axis
    if offset_counts["up"] >= 0 then
        for i=1,offset_counts["up"] do
            moves[#moves+1] = "down"
        end
    else
        for i=1,math.abs(offset_counts["up"]) do
            moves[#moves+1] = "up"
        end
    end

    if excavate(moves, nil, false) == false then
        return false
    end

    if forward then
        turtle.turnLeft()
        turtle.turnLeft()
    end
end


return strip_mine
