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

        def select(self, index: int):
            pass

        def getItemDetail(self):
            pass

        def drop(self):
            pass

        def getSelectedSlot(self):
            pass


class Constants:
    non_valuables = {
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

    empty_slots_required = 2
