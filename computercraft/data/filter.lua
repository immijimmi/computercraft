function filter(list, func)
    result = {}

    for _, item in ipairs(list) do
        if func(item) then
            result[#result+1] = item
        end
    end

    return result
end


return filter
