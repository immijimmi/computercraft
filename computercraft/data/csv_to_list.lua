local split_string = require("data.split_string")


function csv_to_list(filename)
    -- A basic csv file handler that expects only comma delimiters for contained values

    local file = fs.open(filename, "r")
    local result = split_string(file.readAll(), ",")

    file.close()
    return result
end


return csv_to_list
