
-- Generic patches.
require("k2so-tweaks.patches.expanded-alternate-recipes")

-- Planet-specific compatibility patches.
require("k2so-tweaks.patches.planets.muluna")

local util = require("k2so-tweaks.util")
util.patch.do_data_updates()
