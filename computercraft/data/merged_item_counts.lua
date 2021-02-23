function merged_item_counts(...)
    local result = {}

    for _, item_count_table in ipairs(...) do
        for item_name, item_count in pairs(item_count_table) do
            if result[item_name] == nil then
                result[item_name] = item_count
            else
                result[item_name] = result[item_name] + item_count
            end
        end
    end

    return result
end


return merged_item_counts
