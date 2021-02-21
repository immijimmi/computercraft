local constants = {
    drive_positions = {  -- Lookup table for where to move deployer turtle before placing disk drive in front of itself
        left_side={"left", "turnRight"},
        top_side={"up"},
        right_side={"right", "turnLeft"}
    },

    deploy_items = {  -- Generic required items a deployer requires to deploy one turtle
        ["computercraft:turtle_normal"]=1,
        ["computercraft:disk_drive"]=1,
        ["computercraft:disk"]=1
    }
}

return constants
