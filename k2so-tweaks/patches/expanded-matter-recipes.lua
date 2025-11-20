
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("mod-expanded-matter-recipes")
patch:add_required_startup_setting_equal("nulls-k2so-expanded-matter-recipes", true)

local function make_matter_icon(icon_path)
	return {
		{ icon = "__Krastorio2Assets__/icons/fluids/matter.png" },
		{ icon = icon_path, scale = 0.85 },
	}
end

local function make_matter_technology(params)
	local ingredients = {
		{ "production-science-pack", 1 },
		{ "utility-science-pack", 1 },
		{ "space-science-pack", 1 },
		{ "kr-matter-tech-card", 1 },
	}
	for _, ingredient in ipairs(params.additional_ingredients or {}) do
		if (data.raw["item"][ingredient]) then
			table.insert(ingredients, ingredient)
		end
	end
	local prerequisites = { "kr-matter-processing" }
	for _, requirement in ipairs(params.additional_requirements or {}) do
		if (data.raw["technology"][requirement]) then
			table.insert(prerequisites, requirement)
		end
	end
	return {
		type = "technology",
		name = assert(params.name),
		icons = make_matter_icon(assert(params.base_icon_path)),
		icon_size = 256,
		order = "g-e-e",
		unit = {
			time = 45,
			count = 1000,
			ingredients = ingredients,
		},
		prerequisites = prerequisites,
		effects = {},
	}
end

local function make_matter_technologies()
	-- K2SO: Basic Gases
	data:extend({
		make_matter_technology({
			name = "k2sotweak-matter-gas-processing",
			base_icon_path = "__Krastorio2Assets__/icons/fluids/nitrogen.png",
		}),
	})

	-- Muluna: Alumina
	if (data.raw["item"]["alumina"]) then
		data:extend({
			make_matter_technology({
				name = "k2sotweak-matter-alumina-processing",
				base_icon_path = "__muluna-graphics__/graphics/icons/crushed-alumina.png",
				additional_ingredients = { "interstellar-science-pack" },
				additional_requirements = { "interstellar-science-pack" },
			}),
		})
	end

	-- Moshine: Neodymium
	if (data.raw["item"]["neodymium"]) then
		data:extend({
			make_matter_technology({
				name = "k2sotweak-matter-neodymium-processing",
				base_icon_path = "__Moshine__/graphics/icons/neodymium.png",
				additional_requirements = { "planet-discovery-moshine" },
			}),
		})
	end
end

local function make_matter_recipes()
	local matter_lib = require("__Krastorio2-spaced-out__.prototypes.libraries.matter")

	-- K2SO: Basic Gases
	matter_lib.make_deconversion_recipe({
		material = { type = "fluid", name = "kr-oxygen", amount = 100 },
		matter_count = 10,
		energy_required = 2,
		unlocked_by = "k2sotweak-matter-gas-processing",
	})
	matter_lib.make_deconversion_recipe({
		material = { type = "fluid", name = "kr-hydrogen", amount = 100 },
		matter_count = 10,
		energy_required = 2,
		unlocked_by = "k2sotweak-matter-gas-processing",
	})
	matter_lib.make_deconversion_recipe({
		material = { type = "fluid", name = "kr-nitrogen", amount = 100 },
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