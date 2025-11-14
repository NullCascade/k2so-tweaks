local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("Moshine")
patch:add_required_mod("Moshine")

local function make_matter_icon(icon_path)
	return {
		{ icon = "__Krastorio2Assets__/icons/fluids/matter.png" },
		{ icon = icon_path, scale = 0.85 },
	}
end

local function make_matter_technologies()
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

local function make_matter_recipes()
	local matter_lib = require("__Krastorio2-spaced-out__.prototypes.libraries.matter")

	-- Neodymium
	matter_lib.make_recipes({
		material = { type = "item", name = "neodymium", amount = 10 },
		matter_count = 30,
		energy_required = 2,
		unlocked_by = "k2sotweak-matter-neodymium-processing",
	})
	data.raw.recipe["kr-matter-to-neodymium"].surface_conditions = { { property = "pressure", min = 701, max = 701 } }
end

function patch.on_data()
	make_matter_technologies()
end

function patch.on_data_updates()
	make_matter_recipes()
end

return patch