
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("mod-expanded-matter-recipes")
patch:add_required_startup_setting_equal("nulls-k2so-expanded-matter-recipes", true)

local function make_matter_technologies()
	-- K2SO: Basic Gases
	util.matter.make_technology({
		name = "k2sotweak-matter-gas-processing",
		base_icon_path = util.graphics.get_icon("fluid", "kr-nitrogen"),
	})

	-- Muluna: Alumina
	if (data.raw["item"]["alumina"]) then
		util.matter.make_technology({
			name = "k2sotweak-matter-alumina-processing",
			base_icon_path = util.graphics.get_icon("item", "alumina"),
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "interstellar-science-pack" },
		})
	end

	-- Moshine: Neodymium
	if (data.raw["item"]["neodymium"]) then
		util.matter.make_technology({
			name = "k2sotweak-matter-neodymium-processing",
			base_icon_path = util.graphics.get_icon("item", "neodymium"),
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "planet-discovery-moshine" },
		})
	end
end

local function make_matter_recipes()
	-- K2SO: Basic Gases
	util.matter.make_deconversion_recipe("k2sotweak-matter-gas-processing", "fluid", "kr-oxygen", 100, 10)
	util.matter.make_deconversion_recipe("k2sotweak-matter-gas-processing", "fluid", "kr-hydrogen", 100, 10)
	util.matter.make_deconversion_recipe("k2sotweak-matter-gas-processing", "fluid", "kr-nitrogen", 100, 10)

	-- Muluna: Alumina
	if (data.raw["item"]["alumina"]) then
		util.matter.make_recipes("k2sotweak-matter-alumina-processing", "item", "alumina", 10, 20)
		util.surface.enforce_condition("recipe", "kr-matter-to-alumina", "pressure", 50, 50)
	end

	-- Moshine: Neodymium
	if (data.raw["item"]["neodymium"]) then
		util.matter.make_recipes("k2sotweak-matter-neodymium-processing", "item", "neodymium", 10, 30)
		util.surface.enforce_condition("recipe", "kr-matter-to-neodymium", "pressure", 701, 701)
	end
end

function patch.on_data()
	make_matter_technologies()
end

function patch.on_data_updates()
	make_matter_recipes()
end

return patch