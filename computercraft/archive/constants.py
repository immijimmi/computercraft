def empty(self):
    pass


def empty_2(self, arg):
    pass


class Mock:
    class Turtle:
        up = empty
        down = empty
        forward = empty
        back = empty
        turnLeft = empty
        turnRight = empty
        dig = empty
        digUp = empty
        digDown = empty
        getItemDetail = empty
        drop = empty
        getSelectedSlot = empty
        getFuelLimit = empty
        getFuelLevel = empty
        inspect = empty
        inspectUp = empty
        inspectDown = empty

        select = empty_2


class Constants:
    non_valuables = {  # Used to filter items out of the inventory
        # Overworld
        # "minecraft:sand",
        "minecraft:gravel",
        "minecraft:granite",
        "minecraft:diorite",
        "minecraft:andesite",
        "minecraft:dirt",
        "minecraft:cobblestone",

        # Nether
        "minecraft:netherrack",
        "minecraft:magma_block",
        "minecraft:blackstone",
        "minecraft:soul_sand"
    }

    valuables = {  # Used to pick blocks to mine
        # Overworld
        "minecraft:diamond_ore",
        "minecraft:redstone_ore",
        "minecraft:iron_ore",
        "minecraft:gold_ore",
        "minecraft:coal_ore",
        "minecraft:emerald_ore",
        "minecraft:lapis_lazuli_ore",
        "minecraft:obsidian",

        # Nether
        "minecraft:ancient_debris",
        "minecraft:nether_gold_ore",
        "minecraft:glowstone",
        "minecraft:nether_quartz_ore"
    }

    empty_slots_required = 2

    reversed_moves = {
        "left": "right",
        "right": "left",
        "up": "down",
        "down": "up",
        "forward": "forward",
        "back": "back"
    }
