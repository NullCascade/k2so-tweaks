
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("planet-outer-rim")
patch:add_required_mod("outer-rim")

function patch.on_data_final_fixes()
	-- Undo some of the nitrogen patching that Outer Rim does to keep things standard.
	util.recipe.set_hidden("nitrogen-nitric-acid", false)
	util.recipe.set_hidden("nitric-acid-barrel", false)
	util.recipe.set_hidden("nitrogen-barrel", false)
	local nitric_acid_handling = data.raw.technology["nitric-acid-handling"]
	if (nitric_acid_handling and nitric_acid_handling.effects) then
		if (not util.table.find_keyvalues(nitric_acid_handling.effects, { recipe = "nitrogen-nitric-acid" })) then
			table.insert(nitric_acid_handling.effects, { type = "unlock-recipe", recipe = "nitrogen-nitric-acid" })
		end
	end
end

return patch
