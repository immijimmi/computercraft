from typing import Iterable

from .try_move import try_move


def execute_moves(moves: Iterable[str]) -> None:
    """
    Basic batch function for try_move() - does not complete any additional work between moves nor
    make fuel checks/refuel
    """

    for move in moves:
        if not try_move(move):
            raise RuntimeError("Unable to complete move sequence.")
