function has_matching_properties(target_dict, properties)
    for key, value in pairs(properties) do
        if value ~= target_dict[key] then
            return false
        end
    end

    return true
end


return has_matching_properties
