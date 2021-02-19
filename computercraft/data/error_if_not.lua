function error_if_not(bool_value, message)
    if not bool_value then
        error(message)
    end
end


return error_if_not
