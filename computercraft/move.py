from .clean_inventory import clean_inventory
from .constants import Mock

turtle = Mock.Turtle()


def move(move_str):
    def apply_turns(reverse=False):
        if not reverse:
            if move_str == "left":
                turtle.turnLeft()
            elif move_str == "right":
                turtle.turnRight()
            elif move_str == "back":
                turtle.turnRight()
                turtle.turnRight()

        else:
            if move_str == "left":
                turtle.turnRight()
            elif move_str == "right":
                turtle.turnLeft()
            elif move_str == "back":
                turtle.turnLeft()
                turtle.turnLeft()

    if move_str not in {"up", "down", "left", "right", "forward", "back"}:
        raise ValueError(move_str)

    apply_turns()

    if move_str == "up":
        move_command = turtle.up
        dig_command = turtle.digUp
    elif move_str == "down":
        move_command = turtle.down
        dig_command = turtle.digDown
    else:
        move_command = turtle.forward
        dig_command = turtle.dig

    for i in range(100):  # and i would try 100 times and i would try 100 more
        if move_command():
            return

        if i == 99:
            apply_turns(reverse=True)
            return False

        if clean_inventory() is False:
            apply_turns(reverse=True)
            return False

        dig_command()
