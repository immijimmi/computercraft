local config = require("config")

local ids_version_lookup = {
    ["1.12.2"] = {
        -- Minecraft
        turtle = "computercraft:turtle_expanded",
        disk_drive = "computercraft:peripheral",
        floppy_disk = "computercraft:disk_expanded",
        sand = "minecraft:sand",
        gravel = "minecraft:gravel",
        granite = "minecraft:stone",
        diorite = "minecraft:stone",
        andesite = "minecraft:stone",
        dirt = "minecraft:dirt",
        cobblestone = "minecraft:cobblestone",
        oak_planks = "minecraft:planks",
        netherrack = "minecraft:netherrack",
        magma_block = "minecraft:magma",
        blackstone = false,  -- Not in 1.12.2
        soul_sand = "minecraft:soul_sand",
        diamond_ore = "minecraft:diamond_ore",
        redstone_ore = "minecraft:redstone_ore",
        iron_ore = "minecraft:iron_ore",
        gold_ore = "minecraft:gold_ore",
        coal_ore = "minecraft:coal_ore",
        emerald_ore = "minecraft:emerald_ore",
        lapis_ore = "minecraft:lapis_ore",
        obsidian = "minecraft:obsidian",
        crying_obsidian = false,  -- Not in 1.12.2
        ancient_debris = false,  -- Not in 1.12.2
        nether_gold_ore = false,  -- Not in 1.12.2
        glowstone = "minecraft:glowstone",
        nether_quartz_ore = "minecraft:quartz_ore",
        bucket = "minecraft:bucket",
        lava_bucket = "minecraft:lava_bucket",
        lava = "minecraft:lava",
        flowing_lava = "minecraft:flowing_lava",
        water = "minecraft:water",
        flowing_water = "minecraft:flowing_water",
        coal = "minecraft:coal",
        diamond = "minecraft:diamond",
        redstone = "minecraft:redstone",
        emerald = "minecraft:emerald",
        lapis_lazuli = "minecraft:dye",
        clay = "minecraft:clay_ball",
        slimeball = "minecraft:slime_ball",

        -- Applied Energistics 2
        certus_quartz_ore = "appliedenergistics2:quartz_ore",
        charged_certus_quartz_ore = "appliedenergistics2:charged_quartz_ore",

        -- Aroma1997's Dimensional World
        sticky_ore = "aroma1997sdimension:miningore",
        clay_ore = "aroma1997sdimension:miningore",

        -- Better Nether
        cincinnasite_ore = "betternether:cincinnasite_ore",
        cincinnasite = "betternether:cincinnasite"
    },
    ["1.16.4"] = {
        -- Minecraft
        turtle = "computercraft:turtle_normal",
        disk_drive = "computercraft:disk_drive",
        floppy_disk = "computercraft:disk",
        sand = "minecraft:sand",
        gravel = "minecraft:gravel",
        granite = "minecraft:granite",
        diorite = "minecraft:diorite",
        andesite = "minecraft:andesite",
        dirt = "minecraft:dirt",
        cobblestone = "minecraft:cobblestone",
        oak_planks = "minecraft:oak_planks",
        netherrack = "minecraft:netherrack",
        magma_block = "minecraft:magma_block",
        blackstone = "minecraft:blackstone",
        soul_sand = "minecraft:soul_sand",
        diamond_ore = "minecraft:diamond_ore",
        redstone_ore = "minecraft:redstone_ore",
        iron_ore = "minecraft:iron_ore",
        gold_ore = "minecraft:gold_ore",
        coal_ore = "minecraft:coal_ore",
        emerald_ore = "minecraft:emerald_ore",
        lapis_ore = "minecraft:lapis_ore",
        obsidian = "minecraft:obsidian",
        crying_obsidian = "minecraft:crying_obsidian",
        ancient_debris = "minecraft:ancient_debris",
        nether_gold_ore = "minecraft:nether_gold_ore",
        glowstone = "minecraft:glowstone",
        nether_quartz_ore = "minecraft:nether_quartz_ore",
        bucket = "minecraft:bucket",
        lava_bucket = "minecraft:lava_bucket",
        lava = "minecraft:lava",
        flowing_lava = "minecraft:lava",  -- TODO: Check this ID is correct for this version
        water = "minecraft:water",
        flowing_water = "minecraft:water",  -- TODO: Check this ID is correct for this version
        coal = "minecraft:coal",  -- TODO: Check this ID is correct for this version
        diamond = "minecraft:diamond",  -- TODO: Check this ID is correct for this version
        redstone = "minecraft:redstone",  -- TODO: Check this ID is correct for this version
        emerald = "minecraft:emerald",  -- TODO: Check this ID is correct for this version
        lapis_lazuli = "minecraft:dye",  -- TODO: Check this ID is correct for this version
        clay = false,  -- Unchecked
        slimeball = false,  -- Unchecked

        -- Applied Energistics 2
        certus_quartz_ore = "appliedenergistics2:quartz_ore",
        charged_certus_quartz_ore = "appliedenergistics2:charged_quartz_ore",

        -- Aroma1997's Dimensional World
        sticky_ore = false,  -- Unchecked
        clay_ore = false,  -- Unchecked

        -- Better Nether
        cincinnasite_ore = false,  -- Unchecked
        cincinnasite = false  -- Unchecked
    }
}

local constants = {
    moves_save_file = "moves.csv",

    valid_directions = {
        forward=true,
        back=true,
        up=true,
        down=true,
        left=true,
        right=true
    },

    moves_lookup = {  -- Doubles as both a set and a lookup for reversed moves
        left = "right",
        right = "left",
        up = "down",
        down = "up",
        forward = "forward",
        back = "back",
        turnLeft = "turnRight",
        turnRight = "turnLeft"
    },

    ids = ids_version_lookup[config.version]
}

return constants
