local game_storage = require("scripts.var.game-storage")

script.on_load(function()
    --
    game_storage.load()
    --
end)
