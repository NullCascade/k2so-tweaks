
-- Generic patches.
require("k2so-tweaks.patches.expanded-alternate-recipes")
require("k2so-tweaks.patches.expanded-matter-recipes")

-- Mod-specific patches.
require("k2so-tweaks.patches.mods.more-asteroids")

local util = require("k2so-tweaks.util")
util.patch.do_data_updates()
