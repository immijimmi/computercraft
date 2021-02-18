function concat_lists(a, b)
    local result = {}

    for _, value in ipairs(a) do
        result[#result+1] = value
    end

    for _, value in ipairs(b) do
        result[#result+1] = value
    end

    return result
end


return concat_lists
