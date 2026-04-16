
-- Generic patches.
require("k2so-tweaks.patches.mods.crushing-industry-ratios")
require("k2so-tweaks.patches.expanded-matter-recipes")

-- Planet-specific compatibility patches.
require("k2so-tweaks.patches.planets.arig")
require("k2so-tweaks.patches.planets.maraxsis")
require("k2so-tweaks.patches.planets.pelagos")

local util = require("k2so-tweaks.util")
util.patch.do_data()
