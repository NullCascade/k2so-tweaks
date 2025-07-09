
--[[
	- Switches K2 to use common glass/sand.
	- Switches K2 to use common oxygen/hydrogen/nitrogen.
	- Removes the K2 mineral pumpjack and makes the normal pumpjack usable for basic fluids.
--]]

local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("mod-krastorio2-spaced-out")

local function replace_k2_item(k2_id, common_id)
	local item = data.raw["item"][common_id]
	if (item == nil) then
		item = table.deepcopy(data.raw["item"][k2_id])
		item.name = common_id
		item.localised_name = {"item-name." .. k2_id}
		item.localised_description = {"item-description." .. k2_id}
		data:extend({ item })
	end
	util.item.replace_all(k2_id, common_id)
end

local function replace_k2_fluid(k2_id, common_id)
	local fluid = data.raw["fluid"][common_id]
	if (fluid == nil) then
		fluid = table.deepcopy(data.raw["fluid"][k2_id])
		fluid.name = common_id
		fluid.localised_name = {"fluid-name." .. k2_id}
		fluid.localised_description = {"fluid-description." .. k2_id}
		data:extend({ fluid })
	end
	util.fluid.replace_all(k2_id, common_id)
end

local function enforce_burn_limits()
	for _, recipe in pairs(data.raw["recipe"]) do
		if (util.string.starts_with(recipe.name, "kr-burn-")) then
			for _, ingredient in ipairs(recipe.ingredients or {}) do
				ingredient.amount = 100
			end
		end
	end
end

function patch.on_data_final_fixes()
	-- Standardize items/fluids.
	replace_k2_item("kr-sand", "sand")
	replace_k2_item("kr-glass", "glass")
	replace_k2_fluid("kr-oxygen", "oxygen")
	replace_k2_fluid("kr-hydrogen", "hydrogen")
	replace_k2_fluid("kr-nitrogen", "nitrogen")

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

	-- Enforce burn limits to 100 fluid/2 seconds.
	enforce_burn_limits()
end

return patch