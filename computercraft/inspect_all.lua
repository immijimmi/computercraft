function inspect_all()
    local result = {}

    result["front"] = turtle.inspect() or nil
    result["up"] = turtle.inspectUp() or nil
    result["down"] = turtle.inspectDown() or nil

    turtle.turnLeft()
    result["left"] = turtle.inspect() or nil
    turtle.turnLeft()
    result["back"] = turtle.inspect() or nil
    turtle.turnLeft()
    result["right"] = turtle.inspect() or nil
    turtle.turnLeft()

    return result
end


return inspect_all
