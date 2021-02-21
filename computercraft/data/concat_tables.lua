function concat_tables(a, b)
    local result = {}

    for key, value in pairs(a) do
        result[key] = value
    end

    for key, value in pairs(b) do
        result[key] = value
    end

    return result
end


return concat_lists
