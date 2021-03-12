local cc_constants = require("constants")

local constants = {
    non_valuables = {  -- Used to filter items out of the inventory
        -- Overworld
        [cc_constants.ids.sand]=true,
        [cc_constants.ids.gravel]=true,
        [cc_constants.ids.granite]=true,
        [cc_constants.ids.diorite]=true,
        [cc_constants.ids.andesite]=true,
        [cc_constants.ids.dirt]=true,
        [cc_constants.ids.cobblestone]=true,
        [cc_constants.ids.oak_planks]=true,

        -- Nether
        [cc_constants.ids.netherrack]=true,
        [cc_constants.ids.magma_block]=true,
        [cc_constants.ids.blackstone]=true,
        [cc_constants.ids.soul_sand]=true
    },

    valuables = {  -- Used to pick blocks to mine
        -- Overworld
        [cc_constants.ids.diamond_ore]=true,
        [cc_constants.ids.redstone_ore]=true,
        [cc_constants.ids.iron_ore]=true,
        [cc_constants.ids.gold_ore]=true,
        [cc_constants.ids.coal_ore]=true,
        [cc_constants.ids.emerald_ore]=true,
        [cc_constants.ids.lapis_ore]=true,
        [cc_constants.ids.obsidian]=true,
        [cc_constants.ids.crying_obsidian]=true,
        [cc_constants.ids.coal]=true,
        [cc_constants.ids.diamond]=true,
        [cc_constants.ids.redstone]=true,
        [cc_constants.ids.emerald]=true,
        [cc_constants.ids.lapis_lazuli]=true,

        -- Nether
        [cc_constants.ids.ancient_debris]=true,
        [cc_constants.ids.nether_gold_ore]=true,
        [cc_constants.ids.glowstone]=true,
        [cc_constants.ids.nether_quartz_ore]=true,

        -- Applied Energistics 2
        [cc_constants.ids.certus_quartz_ore]=true,
        [cc_constants.ids.charged_certus_quartz_ore]=true
    },

    empty_slots_required = 2,

    move_attempt_wait_time = 0.5,

    non_fuel_moves = {
        turnLeft=true,
        turnRight=true
    },

    resource_depths = {  -- Values should be the approximate centre of the most common y values for the resource
        diamond = {5, 12},
        ancient_debris = {13, 17},
    },

    empty_function = function() return true end,

    fuel_amounts = {[cc_constants.ids.lava_bucket]=1000}
}

return constants
