from typing import Callable, Tuple

from .try_clean_inventory import try_clean_inventory
from .constants import Mock

turtle = Mock.Turtle()


def try_move(move: str, is_reverse_order: bool = False) -> bool:
    """
    Reverse order only affects whether turns are executed before movement. Any reversal of direction
    should be carried out externally with the resulting direction being used in this function
    """

    def apply_turns(is_reverse: bool = False) -> None:
        if not is_reverse:
            if move == "left":
                turtle.turnLeft()
            elif move == "right":
                turtle.turnRight()
            elif move == "back":
                turtle.turnRight()
                turtle.turnRight()

        else:
            if move == "left":
                turtle.turnRight()
            elif move == "right":
                turtle.turnLeft()
            elif move == "back":
                turtle.turnLeft()
                turtle.turnLeft()

    def get_commands() -> Tuple[Callable, Callable]:
        if move == "up":
            return turtle.up, turtle.digUp
        elif move == "down":
            return turtle.down, turtle.digDown
        else:
            return turtle.forward, turtle.dig

    def try_move_command() -> bool:
        for attempt in range(100):  # and i would try 100 times and i would try 100 more
            if move_command():
                return True
            if attempt == 99:
                return False

            if not try_clean_inventory():
                return False
            dig_command()

    if move not in {"up", "down", "left", "right", "forward", "back"}:
        raise ValueError(move)

    move_command, dig_command = get_commands()

    if not is_reverse_order:
        apply_turns()
        if try_move_command():
            return True
        else:
            apply_turns(is_reverse=True)
            return False

    else:
        if try_move_command():
            apply_turns()
            return True
        else:
            return False
