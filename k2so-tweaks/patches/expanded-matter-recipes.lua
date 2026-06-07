
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("mod-expanded-matter-recipes")
patch:add_required_startup_setting_equal("nulls-k2so-expanded-matter-recipes", true)

local function make_matter_technologies()
	-- K2SO: Basic Gases
	util.matter.make_technology({
		name = "k2sotweak-matter-gas-processing",
		base_icon_path = util.graphics.get_icon("fluid", "kr-nitrogen"),
	})

	-- Lignumis: Gold
	if (data.raw["item"]["gold-ore"]) then
		util.matter.make_technology({
			name = "k2sotweak-matter-gold-ore-processing",
			base_icon_path = util.graphics.get_icon("item", "gold-ore"),
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "planet-discovery-lignumis" },
		})
	end

	-- Lignumis: Peat
	if (data.raw["item"]["peat"]) then
		util.matter.make_technology({
			name = "k2sotweak-matter-peat-processing",
			base_icon_path = util.graphics.get_icon("item", "peat"),
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "planet-discovery-lignumis" },
		})
	end

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

	-- Lignumis: Gold Ore
	local lignumis_pollutant_type = util.surface.get_pollutant_type("lignumis")
	util.log("lignumis_pollution_type = %s (%s)", lignumis_pollutant_type, type(lignumis_pollutant_type))
	if (data.raw["item"]["gold-ore"]) then
		util.matter.make_recipes("k2sotweak-matter-gold-ore-processing", "item", "gold-ore", 10, 20)
		util.surface.enforce_condition("recipe", "kr-matter-to-gold-ore", "pressure", 900, 900)
		if (lignumis_pollutant_type) then
			util.surface.enforce_condition("recipe", "kr-matter-to-gold-ore", "pollutant-type", lignumis_pollutant_type, lignumis_pollutant_type)
		end
	end

	-- Lignumis: Peat
	if (data.raw["item"]["peat"]) then
		util.matter.make_recipes("k2sotweak-matter-peat-processing", "item", "peat", 10, 1)
		util.surface.enforce_condition("recipe", "kr-matter-to-peat", "pressure", 900, 900)
		if (lignumis_pollutant_type) then
			util.surface.enforce_condition("recipe", "kr-matter-to-peat", "pollutant-type", lignumis_pollutant_type, lignumis_pollutant_type)
		end
	end

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