local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("planet-muluna")
patch:add_required_mod("planet-muluna")

function patch.on_data_final_fixes()
	-- Replace silicon to use K2 silicon.
	util.item.replace_all("silicon", "kr-silicon")
end

return patch