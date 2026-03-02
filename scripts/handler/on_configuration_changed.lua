local game_storage = require("scripts.var.game-storage")

script.on_configuration_changed(function(configurationChangedData)
    --
    game_storage.check_storage_integrity()
    --
end)
