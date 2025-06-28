
-- Ensure that each patch that makes use of on_data_final_fixes is instantiated.
require("k2so-tweaks.patches.lighted-poles")
require("k2so-tweaks.patches.muluna-surface-conditions")

local util = require("k2so-tweaks.util")
util.patch.do_data_final_fixes()
