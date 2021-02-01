from .constants import Mock

turtle = Mock.Turtle()


def try_refuel(offset_amount: int) -> bool:
    pass  # TODO: Add logic for refueling

    if turtle.getFuelLevel() < offset_amount * 2:  # Expecting at least 50% efficiency
        return False
    else:
        return True
