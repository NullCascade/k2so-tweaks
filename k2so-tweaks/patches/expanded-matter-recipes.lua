
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("mod-expanded-matter-recipes")
patch:add_required_startup_setting_equal("nulls-k2so-expanded-matter-recipes", true)

local function make_matter_icon(icon_path)
	return {
		{ icon = "__Krastorio2Assets__/icons/fluids/matter.png" },
		{ icon = icon_path, scale = 0.85 },
	}
end

local function make_matter_technologies()
	-- K2SO: Basic Gases
	data:extend({
		{
			type = "technology",
			name = "k2sotweak-matter-gas-processing",
			icons = make_matter_icon("__Krastorio2Assets__/icons/fluids/nitrogen.png"),
			icon_size = 256,
			order = "g-e-e",
			unit = {
				time = 45,
				count = 1000,
				ingredients = {
					{ "production-science-pack", 1 },
					{ "utility-science-pack", 1 },
					{ "space-science-pack", 1 },
					{ "kr-matter-tech-card", 1 },
					{ "interstellar-science-pack", 1 },
				},
			},
			prerequisites = { "kr-matter-processing" },
			effects = {},
		},
	})

	-- Muluna: Alumina
	if (data.raw["item"]["alumina"]) then
		data:extend({
			{
				type = "technology",
				name = "k2sotweak-matter-alumina-processing",
				icons = make_matter_icon("__muluna-graphics__/graphics/icons/crushed-alumina.png"),
				icon_size = 256,
				order = "g-e-e",
				unit = {
					time = 45,
					count = 1000,
					ingredients = {
						{ "production-science-pack", 1 },
						{ "utility-science-pack", 1 },
						{ "space-science-pack", 1 },
						{ "kr-matter-tech-card", 1 },
						{ "interstellar-science-pack", 1 },
					},
				},
				prerequisites = { "kr-matter-processing", "interstellar-science-pack" },
				effects = {},
			},
		})
	end

	-- Moshine: Neodymium
	if (data.raw["item"]["neodymium"]) then
		data:extend({
			{
				type = "technology",
				name = "k2sotweak-matter-neodymium-processing",
				icons = make_matter_icon("__Moshine__/graphics/icons/neodymium.png"),
				icon_size = 256,
				order = "g-e-e",
				unit = {
					time = 45,
					count = 1000,
					ingredients = {
						{ "production-science-pack", 1 },
						{ "utility-science-pack", 1 },
						{ "space-science-pack", 1 },
						{ "kr-matter-tech-card", 1 },
					},
				},
				prerequisites = { "kr-matter-processing", "planet-discovery-moshine" },
				effects = {},
			},
		})
	end
end

local function make_matter_recipes()
	local matter_lib = require("__Krastorio2-spaced-out__.prototypes.libraries.matter")

	-- K2SO: Basic Gases
	matter_lib.make_deconversion_recipe({
		material = { type = "fluid", name = "oxygen", amount = 100 },
		matter_count = 10,
		energy_required = 2,
		unlocked_by = "k2sotweak-matter-gas-processing",
	})
	matter_lib.make_deconversion_recipe({
		material = { type = "fluid", name = "hydrogen", amount = 100 },
		matter_count = 10,
		energy_required = 2,
		unlocked_by = "k2sotweak-matter-gas-processing",
	})
	matter_lib.make_deconversion_recipe({
		material = { type = "fluid", name = "nitrogen", amount = 100 },
		matter_count = 10,
		energy_required = 2,
		unlocked_by = "k2sotweak-matter-gas-processing",
	})

	-- Moshine: Neodymium
	if (data.raw["item"]["neodymium"]) then
		matter_lib.make_recipes({
			material = { type = "item", name = "neodymium", amount = 10 },
			matter_count = 30,
			energy_required = 2,
			unlocked_by = "k2sotweak-matter-neodymium-processing",
		})
		data.raw.recipe["kr-matter-to-neodymium"].surface_conditions = { { property = "pressure", min = 701, max = 701 } }
	end

	-- Muluna: Alumina
	if (data.raw["item"]["alumina"]) then
		matter_lib.make_recipes({
			material = { type = "item", name = "alumina", amount = 10 },
			matter_count = 20,
			energy_required = 2,
			unlocked_by = "k2sotweak-matter-alumina-processing",
		})
		data.raw.recipe["kr-matter-to-alumina"].surface_conditions = { { property = "pressure", min = 50, max = 50 } }
	end
end

function patch.on_data()
	make_matter_technologies()
end

function patch.on_data_updates()
	make_matter_recipes()
end

return patch