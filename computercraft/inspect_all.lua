function inspect_all()
    local result = {}

    result["front"] = turtle.inspect()
    result["up"] = turtle.inspectUp()
    result["down"] = turtle.inspectDown()

    turtle.turnLeft()
    result["left"] = turtle.inspect()
    turtle.turnLeft()
    result["back"] = turtle.inspect()
    turtle.turnLeft()
    result["right"] = turtle.inspect()
    turtle.turnLeft()

    return result
end


return inspect_all