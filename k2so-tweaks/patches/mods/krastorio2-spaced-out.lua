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

	local k2_recipe = data.raw["recipe"][k2_id]
	if (k2_recipe) then
		k2_recipe.localised_name = { "item-name." .. common_id }
	end
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

	local k2_recipe = data.raw["recipe"][k2_id]
	if (k2_recipe) then
		k2_recipe.localised_name = { "fluid-name." .. common_id }
	end
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
	replace_k2_fluid("kr-nitric-acid", "nitric-acid")

	-- Enforce burn limits to 100 fluid/2 seconds.
	enforce_burn_limits()

	-- Make a holmium-catalyzed lithium recipe.
	local lithium_recipe = data.raw["recipe"]["lithium"]
	if (lithium_recipe ) then
		local existing_holmium = util.recipe.find_ingredient("lithium", "holmium-plate", "item")
		if (not existing_holmium) then
			util.data.clone("recipe", "lithium", "lithium-from-holmium")
			util.recipe.add_ingredient("lithium-from-holmium", "holmium-plate", 1, "item")
			util.technology.add_recipe_unlock("kr-lithium-processing", "lithium-from-holmium")
			local lithium_result = util.recipe.find_result("lithium-from-holmium", "kr-lithium", "item")
			if (lithium_result) then
				lithium_result.amount = math.floor(lithium_result.amount * 1.2)
			end
		end
	end
end

return patch