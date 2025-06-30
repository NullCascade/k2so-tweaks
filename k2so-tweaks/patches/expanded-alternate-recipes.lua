
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("mod-expanded-alternate-recipes")
patch:add_required_startup_setting_equal("nulls-k2so-expanded-alternate-recipes", true)

function patch.on_data_updates()
	-- Allow processing units on Muluna by substituting aluminum for rare metals
	if (data.raw["item"]["aluminum-plate"]) then
		util.recipe.clone("processing-unit", "processing-unit-via-aluminum")
		util.recipe.replace_ingredient_in_place("processing-unit-via-aluminum", "kr-rare-metals", "aluminum-plate", "item")
		util.recipe.set_standardized_dual_icon("processing-unit-via-aluminum", "processing-unit", "aluminum-plate")
		util.technology.add_recipe_unlock("muluna-aluminum-processing", "processing-unit-via-aluminum")
	end

	-- Allow processing units on Muluna and Moshine by substituting a silicon cell
	if (data.raw["item"]["silicon-cell"]) then
		util.recipe.clone("processing-unit", "processing-unit-via-silicon-cell")
		util.recipe.replace_ingredient("processing-unit-via-silicon-cell", "kr-rare-metals", "silicon-cell", 1, "item")
		util.recipe.set_standardized_dual_icon("processing-unit-via-silicon-cell", "processing-unit", "silicon-cell")
		util.technology.add_recipe_unlock("muluna-silicon-processing", "processing-unit-via-silicon-cell")
		util.technology.add_recipe_unlock("moshine-tech-silicon-cell", "processing-unit-via-silicon-cell")
	end
end

return patch