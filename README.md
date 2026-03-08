A new and optimized version of _Powered Floor Extended_!  
Adds conductive floor tiles that transmit power to adjacent tiles (including diagonals) and any structure on top of them, just place a power source or electric pole on top and enjoy the extra space!

> **Note:** Placing a large number of tiles (+5K) quickly may cause brief UPS spikes while the grid recalculates.

---

### How It Works

Electric Tiles form an **invisible power grid** beneath your base. Tiles connect to each other (including diagonals), and any entity placed on top — machines, poles, roboports, accumulators — is powered automatically, no wiring needed.

Grids recalculate dynamically whenever tiles are placed or removed. Processing is distributed across game ticks and handled per chunk, so the impact on performance is kept minimal even in large bases.

### Features

- **Blueprint-compatible** — works seamlessly with blueprints and blueprint books.
- **Works in new and existing saves** — no need to start a fresh game.
- **Compatible with Space Age** — includes support for Aquilo's frozen tiles.
- **Hazard tile variants** — electric versions of hazard concretes are included out of the box.
- **Upgrade recipes** — tiles can be upgraded to the next tiers just like their base variants.

### Modding Support

Since **v1.2.2**, Electric Tiles supports adding electric variants of tiles from other mods. The data-stage interface allows modders to register custom tiles and have them processed internally by the mod.

Refer to the [GitHub repository](https://github.com/J0ss077/ElectricTilesFactorioMod) for full documentation on variant creation and available remote interfaces.

### Known Issues

- Mods that rewire electric poles may conflict with the invisible electric grids. If you experience unexpected behavior with a specific mod, feel free to report it in the discussion section.

---

This is my **first official mod**, so any suggestions, feedback, or improvement ideas are more than welcome. Feel free to reach out!
