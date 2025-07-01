
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("mod-krastorio2-spaced-out")

function patch.on_data_final_fixes()
	-- Revert back to just one pumpjack. Back when there were only two minable fluids this made more sense.
	-- As it is, K2SO ends up just using mineral water pumping for everything that isn't oil.
	-- An alternative would be to make a new pumpjack for every type of fluid, which seems silly.
	if (data.raw["item"]["kr-mineral-water-pumpjack"]) then
		-- Get rid of the K2 pumpjack.
		data.raw["item"]["kr-mineral-water-pumpjack"].hidden = true
		data.raw["recipe"]["kr-mineral-water-pumpjack"].hidden = true
		util.technology.remove("kr-mineral-water-gathering", "kr-fluids-chemistry")

		-- Restore defaults.
		data.raw["item"]["pumpjack"].localised_name = { "entity-name.pumpjack" }
		data.raw["item"]["pumpjack"].icons = nil
		data.raw["item"]["pumpjack"].icon = "__base__/graphics/icons/pumpjack.png"
		data.raw["mining-drill"]["pumpjack"].localised_name = { "entity-name.pumpjack" }
		data.raw["mining-drill"]["pumpjack"].resource_categories = { "basic-fluid" }
		data.raw["resource"]["crude-oil"].category = "basic-fluid"
	end
end

return patch