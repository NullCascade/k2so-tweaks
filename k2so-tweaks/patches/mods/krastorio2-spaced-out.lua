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

--- Krastorio Spaced Out 2.0 introduced a ton of bugs that won't likely be fixed, making the project unviable on an up to date Factorio 2.0.
--- This backports the changes so 2.0 can remain stable.
local function fix_k2so2()
	-- v2.0.2: Fixed that biofuel couldn't be used in vehicles
	local fuels = { "kr-biofuel" }
	for _, fuel in ipairs(fuels) do
		local item = data.raw["item"][fuel]
		if (item and item.fuel_category == "chemical") then
			item.fuel_category = "kr-vehicle-fuel"
		end
	end

	-- v2.0.3: Fixed that superior inserters couldn't stack items
	util.inserter.set_max_belt_stack_size("kr-superior-inserter", 4)
	util.inserter.set_max_belt_stack_size("kr-superior-long-inserter", 4)

	-- v2.0.4: Fixed that crash landing lab couldn't research with automation tech cards 
	local spaceship_research_computer = data.raw.lab["kr-spaceship-research-computer"]
	if (spaceship_research_computer) then
		util.table.insert_unique(spaceship_research_computer.inputs, "automation-science-pack")
	end

	-- v2.0.5: Fixed that "Welcome to the jungle" research didn't unlock any recipes
	local decorations_tech = data.raw["technology"]["kr-decorations"]
	if (decorations_tech) then
		decorations_tech.unit = nil
		decorations_tech.research_trigger = {
			type = "craft-item",
			item = "kr-greenhouse",
			count = 1,
		}
		local tree_recipes = { "tree-01", "tree-02", "tree-02-red", "tree-03", "tree-04", "tree-05", "tree-06", "tree-06-brown", "tree-07", "tree-08", "tree-08-brown", "tree-08-red", "tree-09", "tree-09-brown", "tree-09-red", "dry-tree", "dead-tree-desert", "dead-grey-trunk", "dead-dry-hairy-tree", "dry-hairy-tree", "ashland-lichen-tree", "ashland-lichen-tree-flaming", "cuttlepop", "slipstack", "funneltrunk", "hairyclubnub", "teflilly", "lickmaw", "stingfrond", "boompuff", "sunnycomb", "water-cane", "honey-mushroom", "gold-stromatolite", "huge-rock", "big-rock", "big-sand-rock", "huge-volcanic-rock", "huge-volcanic-rock-hot", "big-volcanic-rock", "big-volcanic-rock-hot", "big-fulgora-rock", "huge-corrundum-rock", "vesta_rock_huge", "big-metallic-rock", "moshine-huge-volcanic-rock", "moshine-big-fulgora-rock", "lunar-rock", "lunar-huge-rock" }
		for _, recipe in ipairs(tree_recipes) do
			util.technology.add_recipe_unlock("kr-decorations", recipe)
		end
	end

	-- v2.0.6: Tier 3 modules once again require vanilla spece age ingredients
	util.recipe.add_ingredient("speed-module-3", "tungsten-carbide", 1, "item")
	util.recipe.replace_ingredient_amount("speed-module-3", "speed-module-2", 4, "item")
	util.recipe.add_ingredient("productivity-module-3", "biter-egg", 1, "item")
	util.recipe.replace_ingredient_amount("productivity-module-3", "productivity-module-2", 4, "item")
	util.recipe.add_ingredient("efficiency-module-3", "spoilage", 1, "item")
	util.recipe.replace_ingredient_amount("efficiency-module-3", "efficiency-module-2", 4, "item")
	util.recipe.add_ingredient("quality-module-3", "superconductor", 1, "item")
	util.recipe.replace_ingredient_amount("quality-module-3", "quality-module-2", 4, "item")

	-- v2.0.6: Fixed that express underground belts produced lubricant instead of requiring it
	util.recipe.remove_result("express-underground-belt", "fluid", "lubricant")
	util.recipe.add_ingredient("express-underground-belt", "lubricant", 40, "fluid")
end

function patch.on_data_updates()
	-- We only do this for K2SO v2.0.0 explicitly. 2.0.1 is another unrelated breaking change whose branch gets updates.
	if (mods["Krastorio2-spaced-out"] == "2.0.0") then
		fix_k2so2()
	end
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