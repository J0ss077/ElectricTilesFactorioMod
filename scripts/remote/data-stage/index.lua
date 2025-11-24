local remotes = {
    --
    getInterfaceVersion = require("scripts.remote.data-stage.__get-interface-version"),
    --
    modTilePrototypes = require("scripts.remote.data-stage.__mod-tile-prototypes"),
    --
    getItemPrefix = require("scripts.remote.data-stage.__get-item-prefix"),
    --
    getTilePrefix = require("scripts.remote.data-stage.__get-tile-prefix"),
}

return remotes
