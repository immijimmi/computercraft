function split_string(str, delimiter)
    assert(
        #delimiter == 1,
        "delimiter must be a single character"
    )

    local result = {}

    local word = ""
    for char_index=1,#str do
        local char = str:sub(char_index, char_index)

        if char == delimiter then
            result[#result+1] = word
            word = ""
        else
            word = word..char
        end
    end
    result[#result+1] = word

    return result
end


return split_string
