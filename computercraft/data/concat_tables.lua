function concat_tables(...)
    --[[
        Tables are processed one by one in the order they were provided.
        This means that if there are duplicate keys, the last table provided to contain that key
        will be the one that keeps its associated value
    --]]

    local result = {}

    for _, tab in ipairs({...}) do
        for key, value in pairs(tab) do
            result[key] = value
        end
    end

    return result
end


return concat_tables
