local new_commands = {
    {
        name = "F077ET-recalculateAllSurfaces",
        description = "Recalculates all surfaces in the game",
        action = require("remotes.console.proxy-recalculateAllSurfaces")
    }
}

for __, command in ipairs(new_commands) do
    --
    commands.add_command(command.name, command.description, command.action)
    --
end
