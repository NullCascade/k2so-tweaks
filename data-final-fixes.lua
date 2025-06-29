
-- Ensure that each patch that makes use of on_data_final_fixes is instantiated.
require("k2so-tweaks.patches.standardize-stack-sizes")
require("k2so-tweaks.patches.crushing-industry")
require("k2so-tweaks.patches.crushing-industry-ratios")
require("k2so-tweaks.patches.sand-glass")
require("k2so-tweaks.patches.muluna-surface-conditions")
require("k2so-tweaks.patches.lighted-poles")

local util = require("k2so-tweaks.util")
util.patch.do_data_final_fixes()
