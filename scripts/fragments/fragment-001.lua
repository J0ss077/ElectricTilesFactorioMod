return function(_data_)
    --
    local names = { "stone-path", "concrete", "refined-concrete" }
    --
    remote.call("ElectricTilesControlInterface", "registerTilePrototype", names)
    --
end
