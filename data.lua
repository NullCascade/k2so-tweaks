
require("k2so-tweaks.patches.mods.crushing-industry-ratios")

-- Planet-specific compatibility patches.
require("k2so-tweaks.patches.planets.maraxsis")
require("k2so-tweaks.patches.planets.moshine")
require("k2so-tweaks.patches.planets.muluna")

local util = require("k2so-tweaks.util")
util.patch.do_data()
