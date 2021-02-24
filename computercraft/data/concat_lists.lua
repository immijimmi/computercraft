function concat_lists(...)
    local result = {}

    for _, lst in ipairs({...}) do
        for _, value in ipairs(lst) do
            result[#result+1] = value
        end
    end

    return result
end


return concat_lists
