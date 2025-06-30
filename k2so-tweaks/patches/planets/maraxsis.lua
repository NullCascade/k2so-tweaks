
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("planet-maraxsis")
patch:add_required_mod("maraxsis")

function patch.on_data_final_fixes()
	-- Atmosphere is obtained using atmosphere condensation
	data.raw["recipe"]["maraxsis-atmosphere"].category = "kr-atmosphere-condensation"

	-- Electrolysis is done in the electrolysis plant
	data.raw["recipe"]["salt"].category = "kr-electrolysis"
end

return patch