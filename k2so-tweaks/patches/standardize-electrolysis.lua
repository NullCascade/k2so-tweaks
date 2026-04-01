
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("standardize-electrolysis")

function patch.on_data_final_fixes()
	local set_or_add_category = util.recipe.add_additional_category
	if (util.setting_equal("nulls-k2so-standardize-electrolysis", true)) then
		set_or_add_category = util.recipe.set_category
	end

	set_or_add_category("salt", "kr-electrolysis")
end

return patch