local remotes = require("scripts.remote.console.index")

for i0, command in ipairs(remotes) do
    --
    commands.add_command(command.name, command.description, command.action)
    --
end
