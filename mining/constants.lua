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
    },

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
    },

    empty_slots_required = 2,

    move_attempt_wait_time = 0.5,

    reversed_moves = {
        left = "right",
        right = "left",
        up = "down",
        down = "up",
        forward = "forward",
        back = "back"
    },

    resource_depths = {  -- Values should be the approximate centre of the most common y values for the resource
        diamond = {[1]=5, [2]=12},
        ancient_debris = {[1]=13, [2]=17},
    }
}

return constants