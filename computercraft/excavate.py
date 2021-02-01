from typing import Sequence

from .try_move import try_move
from .execute_moves import execute_moves
from .execute_reversed_moves import execute_reversed_moves
from .try_refuel import try_refuel
from .inspect_all import inspect_all
from .constants import Constants, Mock

turtle = Mock.Turtle()


def excavate(moves: Sequence[str], prior_offset: Sequence[str] = ()) -> bool:
    offset = []
    offset_limit = int(turtle.getFuelLimit()/2)

    for move_index, move in enumerate(moves):
        if len(prior_offset)+len(offset) >= offset_limit:  # If offset limit is reached
            break

        if len(prior_offset)+len(offset) >= turtle.getFuelLevel()-1:  # If fuel limit is reached
            full_offset = list(prior_offset)+offset

            execute_reversed_moves(full_offset)
            if not try_refuel(len(full_offset)):
                return False
            execute_moves(full_offset)

        if not try_move(move):
            break

        surrounding_blocks = inspect_all()
        if len(moves) > move_index + 1:
            surrounding_blocks[moves[move_index+1]] = None  # If a move is already next, it does not need excavating

        for key in surrounding_blocks:
            block = surrounding_blocks[key]
            if block and block["name"] in Constants.valuables:
                full_offset = list(prior_offset) + offset

                excavate_result = excavate([key], prior_offset=full_offset)
                if excavate_result is False:
                    return False

    execute_reversed_moves(offset)  # Backtrack only this particular call's offset
    return True
