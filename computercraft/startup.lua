--[[
Designed with the assumption that this repo will be placed on a floppy disk.
When a turtle is booted next to a disk drive with this floppy in it,
this code will be run by the turtle to copy the repo across.
startup_replace.lua can optionally be dynamically written to the floppy,
in order to inject its code as a startup file for any turtles booted from this floppy
--]]

shell.run("delete *")
shell.run("copy disk/* .")
shell.run("delete startup.lua")

for _, name in ipairs(fs.list("")) do
    if name == "startup_replace.lua" then
        shell.run("copy startup_replace.lua startup.lua")
        shell.run("delete startup_replace.lua")
        break
    end
end
