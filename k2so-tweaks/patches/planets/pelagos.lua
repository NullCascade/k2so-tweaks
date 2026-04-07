--[[
Features: 
	- Coconuts in greenhouses
Todo:
	- Diesel greenhouse
	- Biomass or fertilizer from local resources
--]]


local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("planet-pelagos")
patch:add_required_mod("pelagos")


function patch.on_data()
	local greenhouse_batch_mult = 6

	-- Core extensions.
	data:extend({
		-- Add a recipe to grow coconuts with fertilizer.
		{
			type = "recipe",
			name = "k2sotweak-coconut-greenhouse",
			icons = {
				{ icon = "__pelagos__/graphics/coconut.png" },
				{ icon = "__Krastorio2Assets__/icons/entities/greenhouse.png", scale = 0.22, shift = { -8, 8 }, },
			},
			subgroup = "raw-resource",
			order = "a[coconut-with-fertilizer]",
			enabled = false,
			category = "kr-growing",
			energy_required = 60,
			ingredients = {
				{ type = "fluid", name = "water", amount = 600 * greenhouse_batch_mult },
				{ type = "item", name = "kr-fertilizer", amount = 1 * greenhouse_batch_mult },
				{ type = "item", name = "coconut-seed", amount = 1 * greenhouse_batch_mult },
			},
			results = {
				{ type = "item", name = "coconut", amount = 10 * greenhouse_batch_mult },
				{ type = "item", name = "wood", amount = 5 * greenhouse_batch_mult },
			},
			auto_recycle = false,
			main_product = "coconut",
			surface_conditions = {
				{ property = "pressure", min = 1809, max = 1809 },
			},
		},
		-- Add the technology to unlock the above recipe.
		{
			type = "technology",
			name = "k2sotweak-pelagos-greenhouse",
			icons = {
				{ icon = "__Krastorio2Assets__/technologies/greenhouse.png", icon_size = 256 },
				{ icon = "__pelagos__/graphics/palm/palm-tree-1.png", scale = 1/8, shift = { -32, 16 }, icon_size = 1024, floating = true, },
			},
			unit = {
				time = 45,
				count = 1000,
				ingredients = {
					{ "production-science-pack", 1 },
					{ "utility-science-pack", 1 },
					{ "space-science-pack", 1 },
					{ "kr-advanced-tech-card", 1 },
					{ "agricultural-science-pack", 1 },
					{ "pelagos-science-pack", 1 },
				},
			},
			prerequisites = { "pelagos-science-pack", "kr-advanced-tech-card" },
			effects = {
				{ type = "unlock-recipe", recipe = "k2sotweak-coconut-greenhouse" },
			},
		},
	})
end
