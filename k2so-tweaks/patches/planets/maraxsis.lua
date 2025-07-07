
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("planet-maraxsis")
patch:add_required_mod("maraxsis")

function patch.on_data_final_fixes()
	-- Atmosphere is obtained using atmosphere condensation
	-- TODO: The atmosphere condensation machine can't be placed in a way that is compatible with this. Figure it out later.
	util.recipe.add_additional_category("maraxsis-atmosphere", "kr-atmosphere-condensation")

	-- Electrolysis is done in the electrolysis plant
	data.raw["recipe"]["salt"].category = "kr-electrolysis"
end

return patch