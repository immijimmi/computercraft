def excavate(move_sequence, offset_existing=()):
    """
    If any refuel fails the turtle will have been repositioned back at the starting point
    at the top of the stack, so when the refuel function returns False this should be propagated
    and handled by any callers of this method accordingly
    """

    offset_additional = []
    offset_limit = int(turtle.getFuelLimit()/2)

    for move in move_sequence:
        if len(offset_existing)+len(offset_additional) >= offset_limit:
            backtrack(offset_additional)
            return

        if len(offset_existing)+len(offset_additional) >= turtle.getFuelLevel()-1:
            if try_refuel(list(offset_existing)+offset_additional) is False:
                return False  ##### Needs to be handled
