
-- Ensure that each patch that makes use of do_data is instantiated.
-- require("k2so-tweaks.patches.restore-efficiency-module-use")

local util = require("k2so-tweaks.util")
util.patch.do_data()
