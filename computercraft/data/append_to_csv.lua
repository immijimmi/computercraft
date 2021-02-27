function append_to_csv(str, filename)
    -- A basic csv file handler that expects only comma delimiters for contained values

    local file = fs.open(filename, "r")

    local file_exists
    if file == nil then
        file_exists = false
    else
        file_exists = true
    end
    file.close()

    if file_exists then
        file = fs.open(filename, "a")
        file.write(","..str)
    else
        file = fs.open(filename, "w")
        file.write(str)
    end
    file.close()
end


return append_to_csv
