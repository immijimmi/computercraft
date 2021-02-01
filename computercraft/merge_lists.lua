function merge_lists(a, b)
    for index, value in ipairs(b) do
        a[#a+1] = value
        b[index] = nil
    end

    return a
end


return concat_lists
