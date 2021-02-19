function merged_item_counts(a, b)
    local result = {}

    for item_name, item_count in pairs(a) do
        result[item_name] = item_count
    end

    for item_name, item_count in pairs(b) do
        if result[item_name] == nil then
            result[item_name] = item_count
        else
            result[item_name] = result[item_name] + item_count
        end
    end

    return result
end


return merged_item_counts
