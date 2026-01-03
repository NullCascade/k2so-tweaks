-- Generic patches.
require("k2so-tweaks.patches.standardize-stack-sizes")

-- Other mod-specific patches.
require("k2so-tweaks.patches.mods.aai-industry")
require("k2so-tweaks.patches.mods.age-of-production")
require("k2so-tweaks.patches.mods.crushing-industry")
require("k2so-tweaks.patches.mods.crushing-industry-ratios")
require("k2so-tweaks.patches.mods.krastorio2-spaced-out")
require("k2so-tweaks.patches.mods.lighted-poles-plus")

-- Planet-specific compatibility patches.
require("k2so-tweaks.patches.planets.maraxsis")
require("k2so-tweaks.patches.planets.maraxsis-quantum-revert")
require("k2so-tweaks.patches.planets.muluna")

-- Other compatibility patches.
require("k2so-tweaks.patches.modify-recycling-results")

local util = require("k2so-tweaks.util")
util.patch.do_data_final_fixes()
