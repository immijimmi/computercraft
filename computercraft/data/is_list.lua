function is_list(table)
    local count = 0
    local max = 0

    for key, value in pairs(table) do
        if type(key) ~= "number" or key < 1 then
            return false
        end

        count = count+1
        if key > max then
            max = key
        end
    end

    return max == count
end


return is_list
