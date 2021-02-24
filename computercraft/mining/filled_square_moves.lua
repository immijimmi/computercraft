local concat_lists = require("data.concat_lists")


function filled_square_moves(size)
    local is_odd = math.fmod(size, 2) == 1
    local moves = {}

    if is_odd then
        for i=1,(size-1)/2 do
            moves = concat_lists(moves, {"right", "left", "left", "right"})
        end
    else
        for i=1,size-1 do
            moves[#moves+1] = "forward"
        end
    end

    moves[#moves+1] = "right"
    for i=1,size-2 do
        moves[#moves+1] = "forward"
    end
    moves[#moves+1] = "right"
    for i=1,size-2 do
        moves[#moves+1] = "forward"
    end

    for i=1,((size-is_odd)/2)-1 do
        moves = concat_lists(moves, {"right", "right"})
        for i=1,size-3 do
            moves[#moves+1] = "forward"
        end
        moves = concat_lists(moves, {"left", "left"})
        for i=1,size-3 do
            moves[#moves+1] = "forward"
        end
    end

    moves[#moves+1] = "right"
    if is_odd then
        moves[#moves+1] = "forward"
    end

    moves[#moves+1] = "turnRight"

    return moves
end


return filled_square_moves
