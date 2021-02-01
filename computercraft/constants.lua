local constants = {
    non_valuables = {  -- Used to filter items out of the inventory
        -- Overworld
        -- ["minecraft:sand"] = true,
        ["minecraft:gravel"] = true,
        ["minecraft:granite"] = true,
        ["minecraft:diorite"] = true,
        ["minecraft:andesite"] = true,
        ["minecraft:dirt"] = true,
        ["minecraft:cobblestone"] = true,

        -- Nether
        ["minecraft:netherrack"] = true,
        ["minecraft:magma_block"] = true,
        ["minecraft:blackstone"] = true,
        ["minecraft:soul_sand"] = true
    }

    valuables = {  -- Used to pick blocks to mine
        -- Overworld
        ["minecraft:diamond_ore"] = true,
        ["minecraft:redstone_ore"] = true,
        ["minecraft:iron_ore"] = true,
        ["minecraft:gold_ore"] = true,
        ["minecraft:coal_ore"] = true,
        ["minecraft:emerald_ore"] = true,
        ["minecraft:lapis_lazuli_ore"] = true,
        ["minecraft:obsidian"] = true,

        -- Nether
        ["minecraft:ancient_debris"] = true,
        ["minecraft:nether_gold_ore"] = true,
        ["minecraft:glowstone"] = true,
        ["minecraft:nether_quartz_ore"] = true
    }

    empty_slots_required = 2

    reversed_moves = {
        left = "right",
        right = "left",
        up = "down",
        down = "up",
        forward = "forward",
        back = "back"
    }
}

return constants
