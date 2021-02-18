local try_excavate = require("mining.try_excavate")


function deploy_turtle()
    if not try_excavate({[1]="forward"}) then
        error("unable to clear space to place the turtle")
    end
    if not try_excavate({[1]="left", [2]="right"}) then
        error("unable to clear space to place the disk drive")
    end

    local remaining_fuel_required = 2  -- ##### WIP
    if turtle.getFuelLevel() < remaining_fuel_required then
        error("insufficient fuel remaining")
    end

    local current_slot_index = turtle.getSelectedSlot()

    turtle.select(find_item("computercraft:turtle_normal"))
    turtle.place()

    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()

    turtle.select(find_item("computercraft:disk_drive"))
    turtle.place()
    turtle.select(find_item("computercraft:disk")
    turtle.drop()

    turtle.turnRight()
    turtle.forward()
    turtle.turnLeft()

    peripheral.call("front", "reboot")

    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()

    turtle.suck()
    turtle.dig()

    turtle.turnRight()
    turtle.forward()
    turtle.turnLeft()

    peripheral.call("front", "reboot")
end


return deploy_turtle
