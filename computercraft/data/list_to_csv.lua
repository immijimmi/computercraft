function list_to_csv(list, filename, overwrite_existing)
    -- A basic csv file handler that expects only comma delimiters for contained values

    -- Default values
    if overwrite_existing == nil then
        overwrite_existing = false
    end

    if not overwrite_existing then
        local file = fs.open(filename, "r")
        local file_exists = not (file == nil)
        file.close()

        assert(
            not file_exists,
            "cannot write list to csv; a file already exists"
        )
    end

    local file_contents
    for index, value in list do
        if index == 1 then
            file_contents = value
        else
            file_contents = file_contents..","..value
        end
    end

    file = fs.open(filename, "w")
    file.write(file_contents)
    file.close()
end


return list_to_csv
