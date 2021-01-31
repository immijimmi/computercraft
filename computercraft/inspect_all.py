from typing import Dict, Any

from .constants import Mock

turtle = Mock.Turtle()


def inspect_all() -> Dict[str, Any]:
    result = {}

    result["front"] = turtle.inspect()
    result["up"] = turtle.inspectUp()
    result["down"] = turtle.inspectDown()

    turtle.turnLeft()
    result["left"] = turtle.inspect()
    turtle.turnLeft()
    result["back"] = turtle.inspect()
    turtle.turnLeft()
    result["right"] = turtle.inspect()
    turtle.turnLeft()

    return result
