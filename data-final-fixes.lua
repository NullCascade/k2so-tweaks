-- Generic patches.
require("k2so-tweaks.patches.common-k2-resources")
require("k2so-tweaks.patches.standardize-stack-sizes")

-- Other mod-specific patches.
require("k2so-tweaks.patches.mods.lighted-poles-plus")
require("k2so-tweaks.patches.mods.crushing-industry")
require("k2so-tweaks.patches.mods.crushing-industry-ratios")

-- Planet-specific compatibility patches.
require("k2so-tweaks.patches.planets.maraxsis")
require("k2so-tweaks.patches.planets.muluna")

local util = require("k2so-tweaks.util")
util.patch.do_data_final_fixes()
