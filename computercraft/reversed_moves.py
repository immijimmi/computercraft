from typing import Sequence, List

from .constants import Constants


def reversed_moves(moves: Sequence[str]) -> List[str]:
    """
    This function presumes that the turtle will be turned 180 degrees both before and
    after the reversed move sequence is carried out (for the sake of time efficiency when backtracking)
    """

    return [Constants.reversed_moves[move] for move in reversed(moves)]
