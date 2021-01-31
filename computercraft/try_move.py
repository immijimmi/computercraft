from .clean_inventory import clean_inventory
from .constants import Mock

turtle = Mock.Turtle()


def try_move(move_str, reverse_order=False):
    """
    reverse_order only affects whether turns are executed before movement. Any reversal of direction
    should be carried out externally with the resulting direction being used in this function
    """

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

    def set_commands():
        if move_str == "up":
            _move_command = turtle.up
            _dig_command = turtle.digUp
        elif move_str == "down":
            _move_command = turtle.down
            _dig_command = turtle.digDown
        else:
            _move_command = turtle.forward
            _dig_command = turtle.dig

        return _move_command, _dig_command

    def try_move_command():
        for attempt in range(100):  # and i would try 100 times and i would try 100 more
            if move_command():
                return

            if attempt == 99:
                return False

            if clean_inventory() is False:
                return False

            dig_command()

    if move_str not in {"up", "down", "left", "right", "forward", "back"}:
        raise ValueError(move_str)

    move_command, dig_command = set_commands()

    if not reverse_order:
        apply_turns()
        if try_move_command() is False:
            apply_turns(reverse=True)
            return False

    else:
        if try_move_command() is False:
            return False
        apply_turns()
