from .constants import Constants


def clean_inventory():
    """
    If the inventory does not have at least 2 empty slots after cleaning,
    this function should return False
    """

    current_slot_index = turtle.getSelectedSlot()

    for slot_index in range(1, 17):
        turtle.select(slot_index)
        item_detail = turtle.getItemDetail()

        if item_detail is None or item_detail["name"] in Constants.non_valuables:
            turtle.drop()

    turtle.select(current_slot_index)
