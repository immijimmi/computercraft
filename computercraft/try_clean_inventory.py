from .constants import Constants, Mock

turtle = Mock.Turtle()


def try_clean_inventory():
    """
    If the inventory does not have enough empty slots after cleaning,
    this function should return False
    """

    current_slot_index = turtle.getSelectedSlot()
    empty_slots = 0

    for slot_index in range(1, 17):
        turtle.select(slot_index)
        item_detail = turtle.getItemDetail()

        if item_detail is None:
            empty_slots += 1
        elif item_detail["name"] in Constants.non_valuables:
            turtle.drop()
            empty_slots += 1

    turtle.select(current_slot_index)

    return empty_slots >= Constants.empty_slots_required
