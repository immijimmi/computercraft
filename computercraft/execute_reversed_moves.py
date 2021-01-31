from typing import Sequence, List

from .execute_moves import execute_moves
from .constants import Constants, Mock

turtle = Mock.Turtle()


def execute_reversed_moves(moves: Sequence[str]) -> None:
    """
    This function turns the turtle 180 degrees before and after exevuting the reversed move sequence,
    and therefore does not reverse forward and back moves. This approach is in the interest of time efficiency
    """

    turtle.turnRight()
    turtle.turnRight()

    execute_moves([Constants.reversed_moves[move] for move in reversed(moves)])

    turtle.turnRight()
    turtle.turnRight()
