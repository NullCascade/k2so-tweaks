
-- Ensure that each patch that makes use of do_data_updates is instantiated.
-- require("k2so-tweaks.patches.kr-loader-recipes")

local util = require("k2so-tweaks.util")
util.patch.do_data_updates()
