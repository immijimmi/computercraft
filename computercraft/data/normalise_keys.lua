function normalise_keys(table_a, table_b)
    for key, value in pairs(table_a) do
        if table_b[key] == nil then
            table_b[key] = false
        end
    end
    for key, value in pairs(table_b) do
        if table_a[key] == nil then
            table_a[key] = false
        end
    end
end


return normalise_keys
