def move_turtle(move):
    if move not in {"up", "down", "left", "right", "forward", "back"}:
        raise ValueError(move)

    if move == "left":
        turtle.turnLeft()
    elif move == "right":
        turtle.turnRight()
    elif move == "back":
        turtle.turnRight()
        turtle.turnRight()

    if move == "up":
        move_command = turtle.up
        dig_command = turtle.digUp
    elif move == "down":
        move_command = turtle.down
        dig_command = turtle.digDown
    else:
        move_command = turtle.forward
        dig_command = turtle.dig

    for i in range(100):  # and i would try 100 times and i would try 100 more
            if move_command():
                break

            if i == 99:
                if move == "left":
                    turtle.turnRight()
                elif move == "right":
                    turtle.turnLeft()
                elif move == "back":
                    turtle.turnLeft()
                    turtle.turnLeft()
                return False

            dig_command()
            clean_inventory()
