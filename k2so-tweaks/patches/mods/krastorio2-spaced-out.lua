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

local function copy_resistance_type(prototype, from_type, to_type)
	if (not data.raw["damage-type"][to_type]) then
		return
	end

	local resistance_from = util.table.find_keyvalues(prototype.resistances, { type = from_type })
	if (not resistance_from) then
		-- No existing? Remove the 'to' entry instead.
		util.table.remove_with_keyvalues(prototype.resistances, { type = to_type })
		return
	end

	local resistance_to = util.table.find_keyvalues(prototype.resistances, { type = to_type })
	if (not resistance_to) then
		local copied = table.deepcopy(resistance_from)
		copied.type = to_type
		table.insert(prototype.resistances, copied)
		return
	end

	resistance_to.percent = resistance_from.percent
	resistance_to.decrease = resistance_from.decrease
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
	if (lithium_recipe) then
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

	-- Some mods (Cerys, Moshine) indiscriminately changes all accumulators to not work on the surface.
	-- The teleporter is technically an accumulator. This reverts that restriction.
	local teleporter = data.raw["accumulator"]["kr-planetary-teleporter"]
	if (teleporter and teleporter.surface_conditions) then
		util.table.remove_with_keyvalues(teleporter.surface_conditions, { property = "cerys-ambient-radiation" })
		util.table.remove_with_keyvalues(teleporter.surface_conditions, { property = "harenic-energy-signatures" })
		util.table.remove_with_keyvalues(teleporter.surface_conditions, { property = "temperature-celcius" })
	end

	-- Various mods add new asteroids, which may be missing (or have incorrectly defined) resistances. Copy over data from existing values.
	-- This also lets railguns not be quite so overpowered with their full damage against many asteroid types.
	for _, prototype in pairs(data.raw["asteroid"]) do
		-- Use default explosion resistance for K2 explosion resistance.
		copy_resistance_type(prototype, "explosion", "kr-explosion")

		-- Radioactive we can use physical damage for now. Maybe this should bypass damage resistance or something.
		copy_resistance_type(prototype, "physical", "kr-radioactive")
	end
end

return patch