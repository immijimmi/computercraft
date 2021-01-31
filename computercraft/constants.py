class Mock:
    class Turtle:
        def up(self):
            pass

        def down(self):
            pass

        def forward(self):
            pass

        def back(self):
            pass

        def turnLeft(self):
            pass

        def turnRight(self):
            pass

        def dig(self):
            pass

        def digUp(self):
            pass

        def digDown(self):
            pass

        def select(self, index):
            pass

        def getItemDetail(self):
            pass

        def drop(self):
            pass

        def getSelectedSlot(self):
            pass

        def getFuelLimit(self):
            pass

        def getFuelLevel(self):
            pass

        def inspect(self):
            pass

        def inspectUp(self):
            pass

        def inspectDown(self):
            pass


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
