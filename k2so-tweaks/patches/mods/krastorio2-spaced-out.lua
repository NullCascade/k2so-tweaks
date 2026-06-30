local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("mod-krastorio2-spaced-out")

local function ensure_common_item(old_id, new_id)
	local item = data.raw["item"][new_id]
	if (item) then
		return
	end

	item = table.deepcopy(data.raw["item"][old_id])
	item.name = new_id
	item.localised_name = {"item-name." .. old_id}
	item.localised_description = {"item-description." .. old_id}
	data:extend({ item })
end

local function replace_item(old_id, new_id)
	util.item.replace_all(old_id, new_id)

	local k2_recipe = data.raw["recipe"][old_id]
	if (k2_recipe) then
		k2_recipe.localised_name = { "item-name." .. new_id }
	end
end

local function ensure_common_fluid(old_id, new_id)
	local fluid = data.raw["fluid"][new_id]
	if (fluid) then
		return
	end

	fluid = table.deepcopy(data.raw["fluid"][old_id])
	fluid.name = new_id
	fluid.localised_name = {"fluid-name." .. old_id}
	fluid.localised_description = {"fluid-description." .. old_id}
	data:extend({ fluid })
end

local function replace_fluid(old_id, new_id)
	util.fluid.replace_all(old_id, new_id)

	local k2_recipe = data.raw["recipe"][old_id]
	if (k2_recipe) then
		k2_recipe.localised_name = { "fluid-name." .. new_id }
	end
end

--- Enforce burn limits to 100 fluid/2 seconds.
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

--- This patch must be done before any of these items are used.
local function ensure_common_resources()
	ensure_common_item("sand", "kr-sand")
	ensure_common_item("glass", "kr-glass")
	ensure_common_fluid("oxygen", "kr-oxygen")
	ensure_common_fluid("hydrogen", "kr-hydrogen")
	ensure_common_fluid("nitrogen", "kr-nitrogen")
	ensure_common_fluid("nitric-acid", "kr-nitric-acid")
end

function patch.on_data()
	ensure_common_resources()
end

--- Standardize items/fluids.
local function replace_common_resources()
	replace_item("sand", "kr-sand")
	replace_item("glass", "kr-glass")
	replace_item("silicon", "kr-silicon")
	replace_item("planetaris-glass-panel", "kr-glass")
	replace_item("planetaris-raw-quartz", "kr-quartz")
	replace_fluid("oxygen", "kr-oxygen")
	replace_fluid("hydrogen", "kr-hydrogen")
	replace_fluid("nitrogen", "kr-nitrogen")
	replace_fluid("nitric-acid", "kr-nitric-acid")
end

local function add_new_recipes()
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
end

-- Some mods (Cerys, Moshine) indiscriminately changes all accumulators to not work on the surface.
-- The teleporter is technically an accumulator. This reverts that restriction.
local function unrestrict_teleporter()
	local teleporter = data.raw["accumulator"]["kr-planetary-teleporter"]
	if (teleporter and teleporter.surface_conditions) then
		util.table.remove_with_keyvalues(teleporter.surface_conditions, { property = "cerys-ambient-radiation" })
		util.table.remove_with_keyvalues(teleporter.surface_conditions, { property = "harenic-energy-signatures" })
		util.table.remove_with_keyvalues(teleporter.surface_conditions, { property = "temperature-celcius" })
	end
end

-- Various mods add new asteroids, which may be missing (or have incorrectly defined) resistances. Copy over data from existing values.
-- This also lets railguns not be quite so overpowered with their full damage against many asteroid types.
local function standardize_asteroid_resistances()
	for _, prototype in pairs(data.raw["asteroid"]) do
		-- Radioactive we can use physical damage for now. Maybe this should bypass damage resistance or something.
		copy_resistance_type(prototype, "physical", "kr-radioactive")
	end
end

function patch.on_data_final_fixes()
	replace_common_resources()
	enforce_burn_limits()
	add_new_recipes()
	unrestrict_teleporter()
	standardize_asteroid_resistances()
end

return patch