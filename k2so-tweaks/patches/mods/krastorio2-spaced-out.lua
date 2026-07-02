local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("mod-krastorio2-spaced-out")
local is_k2so2_or_lower = helpers.compare_versions(mods["Krastorio2-spaced-out"], "2.0.0") <= 0
local backport_k2so2_features = is_k2so2_or_lower and not util.setting_equal("nulls-k2so-backport-K2SO-features", false)

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

local function backport_k2so2_features_on_data()
	if (not backport_k2so2_features) then
		return
	end

	data:extend({
		-- v2.0.2: Added recipe to craft steam from lava on Vulcanus
		{
			type = "recipe",
			name = "kr-geothermal",
			subgroup = "fluid-recipes",
			order = "d[other-chemistry]-c[geothermal]",
			enabled = false,
			category = "chemistry",
			energy_required = 1,
			ingredients = {
				{ type = "fluid", name = "water", amount = 100 },
				{ type = "fluid", name = "lava", amount = 50 },
			},
			results = {
				{ type = "fluid", name = "steam", amount = 1000, temperature = 1515, ignored_by_productivity = 1000 },
				{ type = "item", name = "stone", amount = 1 },
			},
			always_show_made_in = true,
			allow_productivity = false,
			crafting_machine_tint = {
				primary = { r = 0.800, g = 0.0, b = 0.0, a = 0.000 },
				secondary = { r = 0.700, g = 0.5, b = 0.0, a = 0.350 },
				tertiary = { r = 0.930, g = 0.8, b = 0.93, a = 0.750 },
				quaternary = { r = 0.950, g = 0.9, b = 0.92, a = 0.900 },
			},
			icons = {
				{ icon = "__space-age__/graphics/icons/fluid/lava.png", scale = 0.5, shift = { 0, -10 } },
				{ icon = "__base__/graphics/icons/fluid/steam.png", scale = 0.7, shift = { 0, 12 } },
			},
		},
		{
			type = "technology",
			name = "kr-geothermal",
			icon_size = 256,
			icons = {
				{ icon = "__space-age__/graphics/icons/fluid/lava.png", scale = 0.5, shift = { 0, -10 } },
				{ icon = "__base__/graphics/icons/fluid/steam.png", scale = 0.7, shift = { 0, 12 } },
			},
			unit = {
				time = 30,
				count = 3000,
				ingredients = {
					{ "production-science-pack", 1 },
					{ "utility-science-pack", 1 },
					{ "space-science-pack", 1 },
					{ "kr-advanced-tech-card", 1 },
					{ "metallurgic-science-pack", 1 },
				},
			},
			prerequisites = { "kr-advanced-tech-card", "metallurgic-science-pack" },
			effects = {
				{ type = "unlock-recipe", recipe = "kr-geothermal" },
				{ type = "unlock-recipe", recipe = "kr-advanced-steam-turbine" },
			},
		},
		-- v2.0.2: Added imersite productivity research
		{
			type = "technology",
			name = "kr-imersite-productivity",
			icons = util.factorio.technology_icon_constant_recipe_productivity("__Krastorio2Assets__/technologies/imersite-processing.png"),
			icon_size = 256,
			effects = {
				{
					type = "change-recipe-productivity",
					recipe = "kr-imersium-plate",
					change = 0.1,
				},
				{
					type = "change-recipe-productivity",
					recipe = "kr-imersite-crystal",
					change = 0.1,
				},
				{
					type = "change-recipe-productivity",
					recipe = "kr-easy-imersium-beam",
					change = 0.1,
				},
				{
					type = "change-recipe-productivity",
					recipe = "kr-easy-imersium-gear-wheel",
					change = 0.1,
				},
				{
					type = "change-recipe-productivity",
					recipe = "kr-casting-imersium-plate",
					change = 0.1,
				},
				{
					type = "change-recipe-productivity",
					recipe = "kr-casting-imersium-gear-wheel",
					change = 0.1,
				},
				{
					type = "change-recipe-productivity",
					recipe = "kr-casting-imersium-beam",
					change = 0.1,
				},
			},
			prerequisites = { "kr-singularity-tech-card" },
			unit = {
				count_formula = "1.5^L*2000",
				ingredients = {
					{ "production-science-pack", 1 },
					{ "space-science-pack", 1 },
					{ "electromagnetic-science-pack", 1 },
					{ "kr-matter-tech-card", 1 },
					{ "kr-advanced-tech-card", 1 },
					{ "kr-singularity-tech-card", 1 },
				},
				time = 60,
			},
			max_level = "infinite",
			upgrade = true,
		},
	})
end

function patch.on_data()
	ensure_common_resources()
	backport_k2so2_features_on_data()
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

	-- v2.0.5: Restore the recipe unlocks for "Welcome to the jungle".
	local tree_recipes = { "tree-01", "tree-02", "tree-02-red", "tree-03", "tree-04", "tree-05", "tree-06", "tree-06-brown", "tree-07", "tree-08", "tree-08-brown", "tree-08-red", "tree-09", "tree-09-brown", "tree-09-red", "dry-tree", "dead-tree-desert", "dead-grey-trunk", "dead-dry-hairy-tree", "dry-hairy-tree", "ashland-lichen-tree", "ashland-lichen-tree-flaming", "cuttlepop", "slipstack", "funneltrunk", "hairyclubnub", "teflilly", "lickmaw", "stingfrond", "boompuff", "sunnycomb", "water-cane", "honey-mushroom", "gold-stromatolite", "huge-rock", "big-rock", "big-sand-rock", "huge-volcanic-rock", "huge-volcanic-rock-hot", "big-volcanic-rock", "big-volcanic-rock-hot", "big-fulgora-rock", "huge-corrundum-rock", "vesta_rock_huge", "big-metallic-rock", "moshine-huge-volcanic-rock", "moshine-big-fulgora-rock", "lunar-rock", "lunar-huge-rock" }
	for _, recipe in ipairs(tree_recipes) do
		util.technology.add_recipe_unlock("kr-decorations", recipe)
	end

	-- v2.0.6: Tier 3 modules once again require vanilla spece age ingredients
	util.recipe.add_ingredient("speed-module-3", "tungsten-carbide", 1, "item")
	util.recipe.replace_ingredient_amount("speed-module-3", "speed-module-2", 4, "item")
	util.recipe.add_ingredient("productivity-module-3", "biter-egg", 1, "item")
	util.recipe.replace_ingredient_amount("productivity-module-3", "productivity-module-2", 4, "item")
	util.recipe.add_ingredient("efficiency-module-3", "spoilage", 5, "item")
	util.recipe.replace_ingredient_amount("efficiency-module-3", "efficiency-module-2", 4, "item")
	util.recipe.add_ingredient("quality-module-3", "superconductor", 1, "item")
	util.recipe.replace_ingredient_amount("quality-module-3", "quality-module-2", 4, "item")

	-- v2.0.6: Fixed that express underground belts produced lubricant instead of requiring it
	util.recipe.remove_result("express-underground-belt", "fluid", "lubricant")
	util.recipe.add_ingredient("express-underground-belt", "lubricant", 40, "fluid")

	-- v2.0.9: Radar technology no longer requires chemical tech card
	util.technology.remove_prerequisite("radar", "chemical-science-pack")
	util.technology.remove_unit("radar", "chemical-science-pack")
end

--- Backport K2SO v2.0.2-v2.0.9 non-graphical prototype updates for K2SO 2.0.0 and lower.
local function backport_k2so2_updates_on_data_updates()
	if (not backport_k2so2_features) then
		return
	end

	-- v2.0.3: Age of Production quantum assembler now can craft tech cards
	util.assembler.add_crafting_category("aop-quantum-assembler", "kr-tech-cards")

	-- v2.0.4: Changed imersite, rare metals, and mineral water order in map gen resources tab
	for id, order in pairs({
		["kr-imersite"] = "a-f1[imersite]",
		["kr-rare-metal-ore"] = "a-f2[kr-rare-metals]",
		["kr-mineral-water"] = "a-f3[mineral-water]",
	}) do
		util.autoplace.set_order(id, order)
	end

	-- v2.0.5: Fixed that assembler could craft biochamber recipes
	util.assembler.remove_crafting_category("assembling-machine-1", "organic")

	-- v2.0.5: Fixed AAI loader/industry compatibility
	if (mods["aai-loaders"] and settings.startup["aai-loaders-mode"] and settings.startup["aai-loaders-mode"].value ~= "graphics-only") then
		util.loader.set_hidden("aai-kr-advanced-loader", true)
		util.loader.set_next_upgrade("aai-kr-advanced-loader", nil)
		util.loader.set_next_upgrade("aai-express-loader", "aai-turbo-loader")
		util.loader.set_next_upgrade("aai-turbo-loader", "aai-kr-superior-loader")
		util.item.set_hidden("aai-kr-advanced-loader", true)
		util.recipe.set_hidden("aai-kr-advanced-loader", true)
		util.technology.set_hidden("aai-kr-advanced-loader", true)
		util.technology.clear_prerequisites("aai-kr-advanced-loader")

		util.technology.add_prerequisite("aai-kr-superior-loader", "aai-turbo-loader")
		util.recipe.remove_ingredient("aai-kr-superior-loader", "aai-kr-advanced-loader", "item")
		util.recipe.add_ingredient("aai-kr-superior-loader", "aai-turbo-loader", 1, "item")
	end

	if (mods["aai-industry"]) then
		util.technology.add_unit("gun-turret", "automation-science-pack")
		util.technology.add_prerequisite("basic-logistics", "burner-mechanics")
		util.technology.add_prerequisite("kr-automation-core", "burner-mechanics")
		util.item.set_hidden("kr-laboratory", true)
		util.recipe.set_hidden("kr-laboratory", true)
		util.technology.set_hidden("kr-laboratory", true)
		util.technology.set_craft_item_trigger("automation-science-pack", "burner-lab", 1)
		util.recipe.set_category("automation-science-pack", "crafting")
		util.recipe.set_category("kr-blank-tech-card", "crafting")
	end

	-- v2.0.8: Removed infinite loops and advanced chemical plant surplus water
	util.recipe.set_hidden("kr-water", true)
	util.recipe.set_hidden("kr-crush-kr-imersite-crystal", true)
	for _, recipe_name in ipairs({
		"kr-filter-iron-ore-from-dirty-water",
		"kr-filter-copper-ore-from-dirty-water",
		"kr-filter-rare-metal-ore-from-dirty-water",
	}) do
		util.recipe.add_or_replace_result(recipe_name, "water", { type = "fluid", name = "water", amount = 100, ignored_by_productivity = 100 })
	end

	-- v2.0.8: Buffed energy storage throughput from 5 MW to 20 MW
	util.accumulator.set_flow_limits("kr-energy-storage", "20MW", "20MW")
end

function patch.on_data_updates()
	if (is_k2so2_or_lower) then
		fix_k2so2()
	end

	backport_k2so2_updates_on_data_updates()
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

--- Backport K2SO final-fixes changes that must happen after other mods populate labs and tree recipes.
local function backport_k2so2_fixes_on_data_final_fixes()
	if (not is_k2so2_or_lower) then
		return
	end

	-- v2.0.4: Fixed that crash landing lab couldn't research with automation tech cards
	util.lab.set_inputs("kr-spaceship-research-computer", { "automation-science-pack" })

	-- v2.0.5: Restore the trigger for "Welcome to the jungle" after K2SO final-fixes.
	util.technology.set_craft_item_trigger("kr-decorations", "kr-greenhouse", 1)
end

local function backport_k2so2_features_on_data_final_fixes()
	if (not backport_k2so2_features) then
		return
	end

	-- v2.0.2: Muluna tree unification
	if (util.recipe.exists("tree-01") and util.item.exists("muluna-sapling")) then
		util.recipe.add_or_replace_result("tree-01", "tree-01", { type = "item", name = "muluna-sapling", amount = 1 })
		util.recipe.set_hidden_in_factoriopedia("tree-01", true)
		util.recipe.set_subgroup_order("tree-01", "trees", "a[tree-01]")
		util.recipe.set_localised_name("tree-01", { "entity-name.tree" })
	end
end

function patch.on_data_final_fixes()
	backport_k2so2_fixes_on_data_final_fixes()
	backport_k2so2_features_on_data_final_fixes()
	replace_common_resources()
	enforce_burn_limits()
	add_new_recipes()
	unrestrict_teleporter()
	standardize_asteroid_resistances()
end

return patch