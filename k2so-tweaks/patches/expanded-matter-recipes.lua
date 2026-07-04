
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("mod-expanded-matter-recipes")
patch:add_required_startup_setting_equal("nulls-k2so-expanded-matter-recipes", true)

--- @class nk2soExpandedMatterGroup.technology
--- @field name string
--- @field icon nk2soExpandedMatterGroup.technology.icon
--- @field additional_ingredients string[]?
--- @field additional_requirements string[]?
--- @field alternative_requirements string[][]?

--- @class nk2soExpandedMatterGroup.technology.icon
--- @field type string
--- @field name string

--- @class nk2soExpandedMatterGroup.recipe
--- @field type string
--- @field name string
--- @field amount number
--- @field matter number
--- @field direction "conversion"|"deconversion"?
--- @field surfaces string[]?
--- @field technology string?

--- @class nk2soExpandedMatterGroup.existingRecipe
--- @field name string
--- @field surfaces string[]?

--- @class nk2soExpandedMatterGroup
--- @field technology nk2soExpandedMatterGroup.technology?
--- @field recipes nk2soExpandedMatterGroup.recipe[]?
--- @field existing_recipes nk2soExpandedMatterGroup.existingRecipe[]?

--- @type nk2soExpandedMatterGroup[]
local matter_groups = {
	{
		technology = {
			name = "k2sotweak-matter-gas-processing",
			icon = { type = "fluid", name = "kr-nitrogen" },
		},
		recipes = {
			{ type = "fluid", name = "kr-oxygen", direction = "deconversion", amount = 100, matter = 10 },
			{ type = "fluid", name = "kr-hydrogen", direction = "deconversion", amount = 100, matter = 10 },
			{ type = "fluid", name = "kr-nitrogen", direction = "deconversion", amount = 100, matter = 10 },
		},
	},
	{
		technology = {
			name = "k2sotweak-matter-gold-ore-processing",
			icon = { type = "item", name = "gold-ore" },
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "planet-discovery-lignumis" },
		},
		recipes = {
			{ type = "item", name = "gold-ore", amount = 10, matter = 20, surfaces = { "lignumis", "arig" } },
		},
	},
	{
		technology = {
			name = "k2sotweak-matter-peat-processing",
			icon = { type = "item", name = "peat" },
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "planet-discovery-lignumis" },
		},
		recipes = {
			{ type = "item", name = "peat", amount = 10, matter = 1, surfaces = { "lignumis" } },
		},
	},
	{
		technology = {
			name = "k2sotweak-matter-alumina-processing",
			icon = { type = "item", name = "alumina" },
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "interstellar-science-pack" },
		},
		recipes = {
			{ type = "item", name = "alumina", amount = 10, matter = 20, surfaces = { "muluna" } },
		},
	},
	{
		technology = {
			name = "k2sotweak-matter-neodymium-processing",
			icon = { type = "item", name = "neodymium" },
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "planet-discovery-moshine" },
		},
		recipes = {
			{ type = "item", name = "neodymium", amount = 10, matter = 30, surfaces = { "moshine" } },
		},
	},
	{
		technology = {
			name = "k2sotweak-matter-bones-processing",
			icon = { type = "item", name = "bones" },
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "planet-discovery-apia-carnova" },
		},
		recipes = {
			{ type = "item", name = "bones", amount = 10, matter = 2, surfaces = { "carnova" } },
		},
	},
	{
		technology = {
			name = "k2sotweak-matter-lymph-processing",
			icon = { type = "fluid", name = "lymph" },
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "planet-discovery-apia-carnova" },
		},
		recipes = {
			{ type = "fluid", name = "lymph", amount = 100, matter = 5, surfaces = { "carnova" } },
		},
	},
	{
		technology = {
			name = "k2sotweak-matter-sphalerite-processing",
			icon = { type = "item", name = "sphalerite" },
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "planet-discovery-paracelsin" },
		},
		recipes = {
			{ type = "item", name = "sphalerite", direction = "conversion", amount = 10, matter = 1, surfaces = { "paracelsin" } },
		},
	},
	{
		technology = {
			name = "k2sotweak-matter-tetrahedrite-processing",
			icon = { type = "item", name = "tetrahedrite" },
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "planet-discovery-paracelsin" },
		},
		recipes = {
			{ type = "item", name = "tetrahedrite", direction = "conversion", amount = 10, matter = 3, surfaces = { "paracelsin" } },
		},
	},
	{
		technology = {
			name = "k2sotweak-matter-vaterite-processing",
			icon = { type = "item", name = "vaterite" },
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "planet-discovery-paracelsin" },
		},
		recipes = {
			{ type = "item", name = "vaterite", amount = 10, matter = 20, surfaces = { "paracelsin" } },
		},
	},
	{
		technology = {
			name = "k2sotweak-matter-chalcopyrite-ore-processing",
			icon = { type = "item", name = "chalcopyrite-ore" },
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "planet-discovery-corrundum" },
		},
		recipes = {
			{ type = "item", name = "chalcopyrite-ore", amount = 10, matter = 2, surfaces = { "corrundum" } },
		},
	},
	{
		technology = {
			name = "k2sotweak-matter-platinum-ore-processing",
			icon = { type = "item", name = "platinum-ore" },
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "planet-discovery-corrundum" },
		},
		recipes = {
			{ type = "item", name = "platinum-ore", amount = 10, matter = 30, surfaces = { "corrundum" } },
		},
	},
	{
		technology = {
			name = "k2sotweak-matter-rubia-ferric-scrap-processing",
			icon = { type = "item", name = "rubia-ferric-scrap" },
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "planet-discovery-rubia" },
		},
		recipes = {
			{ type = "item", name = "rubia-ferric-scrap", amount = 10, matter = 1, surfaces = { "rubia" } },
		},
	},
	{
		technology = {
			name = "k2sotweak-matter-rubia-cupric-scrap-processing",
			icon = { type = "item", name = "rubia-cupric-scrap" },
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "planet-discovery-rubia" },
		},
		recipes = {
			{ type = "item", name = "rubia-cupric-scrap", amount = 10, matter = 1, surfaces = { "rubia" } },
		},
	},
	{
		technology = {
			name = "k2sotweak-matter-rubia-bacterial-sludge-processing",
			icon = { type = "fluid", name = "rubia-bacterial-sludge" },
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "planet-discovery-rubia" },
		},
		recipes = {
			{ type = "fluid", name = "rubia-bacterial-sludge", amount = 100, matter = 2, surfaces = { "rubia" } },
		},
	},
	{
		technology = {
			name = "k2sotweak-matter-spaceship-scrap-processing",
			icon = { type = "item", name = "spaceship-scrap" },
			additional_ingredients = { "interstellar-science-pack" },
			alternative_requirements = {
				{ "planet-discovery-frozeta", "planet-discovery-secretas" },
			},
		},
		recipes = {
			{ type = "item", name = "spaceship-scrap", direction = "conversion", amount = 10, matter = 1, surfaces = { "frozeta" } },
		},
	},
	{
		technology = {
			name = "k2sotweak-matter-methane-ice-processing",
			icon = { type = "item", name = "methane-ice" },
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "moon-discovery-cerys" },
		},
		recipes = {
			{ type = "item", name = "methane-ice", amount = 10, matter = 3, surfaces = { "cerys" } },
		},
	},
	{
		technology = {
			name = "k2sotweak-matter-cerys-nuclear-scrap-processing",
			icon = { type = "item", name = "cerys-nuclear-scrap" },
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "moon-discovery-cerys" },
		},
		recipes = {
			{ type = "item", name = "cerys-nuclear-scrap", direction = "conversion", amount = 10, matter = 1, surfaces = { "cerys" } },
		},
	},
	{
		technology = {
			name = "k2sotweak-matter-cerys-nitrogen-rich-minerals-processing",
			icon = { type = "item", name = "cerys-nitrogen-rich-minerals" },
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "moon-discovery-cerys" },
		},
		recipes = {
			{ type = "item", name = "cerys-nitrogen-rich-minerals", amount = 10, matter = 10, surfaces = { "cerys" } },
		},
	},
	{
		technology = {
			name = "k2sotweak-matter-hyarion-gemstone-processing",
			icon = { type = "item", name = "planetaris-raw-emerald" },
			additional_ingredients = { "interstellar-science-pack" },
			additional_requirements = { "planet-discovery-hyarion" },
		},
		recipes = {
			{ type = "item", name = "planetaris-raw-emerald", amount = 10, matter = 20, surfaces = { "hyarion" } },
			{ type = "item", name = "planetaris-raw-ruby", amount = 10, matter = 20, surfaces = { "hyarion" } },
			{ type = "item", name = "planetaris-raw-sapphire", amount = 10, matter = 20, surfaces = { "hyarion" } },
		},
	},
	{
		recipes = {
			{ type = "item", name = "kr-quartz", direction = "deconversion", amount = 10, matter = 0.64, technology = "kr-matter-stone-processing", surfaces = { "hyarion" } },
		},
		existing_recipes = {
			{ name = "kr-matter-to-calcite", surfaces = { "vulcanus", "corrundum" } },
			{ name = "kr-matter-to-lithium-brine", surfaces = { "aquilo", "cerys" } },
		},
	},
}

--- @param surfaces string[]?
--- @return string[]
local function get_existing_surfaces(surfaces)
	local existing_surfaces = {}
	for _, surface_id in ipairs(surfaces or {}) do
		if ((data.raw["planet"] and data.raw["planet"][surface_id]) or (data.raw["surface"] and data.raw["surface"][surface_id])) then
			table.insert(existing_surfaces, surface_id)
		end
	end

	return existing_surfaces
end

--- @param group nk2soExpandedMatterGroup
local function make_group_technology(group)
	local technology = group.technology
	if (technology == nil) then
		return
	end

	local icon_source = technology.icon
	if (data.raw[icon_source.type] == nil or data.raw[icon_source.type][icon_source.name] == nil) then
		return
	end

	local additional_requirements = {}
	for _, requirement in ipairs(technology.additional_requirements or {}) do
		table.insert(additional_requirements, requirement)
	end

	for _, alternatives in ipairs(technology.alternative_requirements or {}) do
		for _, requirement in ipairs(alternatives) do
			if (data.raw["technology"][requirement]) then
				table.insert(additional_requirements, requirement)
				break
			end
		end
	end

	util.matter.make_technology({
		name = technology.name,
		base_icon_path = util.graphics.get_icon(icon_source.type, icon_source.name),
		additional_ingredients = technology.additional_ingredients,
		additional_requirements = additional_requirements,
	})
end

--- @param group nk2soExpandedMatterGroup
--- @param recipe nk2soExpandedMatterGroup.recipe
local function make_group_recipe(group, recipe)
	local surfaces = get_existing_surfaces(recipe.surfaces)
	if (recipe.surfaces ~= nil and #surfaces == 0) then
		return
	end

	local technology_name = recipe.technology or (group.technology and group.technology.name)
	if (technology_name == nil) then
		return
	end

	if (data.raw[recipe.type] == nil or data.raw[recipe.type][recipe.name] == nil) then
		return
	end

	--- @type string[]
	local recipe_names = {}
	if (recipe.direction == "deconversion") then
		local recipe_name = "kr-matter-to-" .. recipe.name
		if (data.raw["recipe"][recipe_name] == nil) then
			util.matter.make_deconversion_recipe(technology_name, recipe.type, recipe.name, recipe.amount, recipe.matter)
		end
		table.insert(recipe_names, recipe_name)
	elseif (recipe.direction == "conversion") then
		local recipe_name = "kr-" .. recipe.name .. "-to-matter"
		if (data.raw["recipe"][recipe_name] == nil) then
			util.matter.make_conversion_recipe(technology_name, recipe.type, recipe.name, recipe.amount, recipe.matter)
		end
		table.insert(recipe_names, recipe_name)
	else
		util.matter.make_recipes(technology_name, recipe.type, recipe.name, recipe.amount, recipe.matter)
		table.insert(recipe_names, "kr-" .. recipe.name .. "-to-matter")
		table.insert(recipe_names, "kr-matter-to-" .. recipe.name)
	end

	for _, recipe_name in ipairs(recipe_names) do
		if (#surfaces > 0 and data.raw["recipe"][recipe_name] ~= nil) then
			util.surface.restrict_to_surfaces(data.raw["recipe"][recipe_name], surfaces)
		end
	end
end

--- @param existing_recipe nk2soExpandedMatterGroup.existingRecipe
local function make_existing_recipe(existing_recipe)
	local surfaces = get_existing_surfaces(existing_recipe.surfaces)
	if (existing_recipe.surfaces ~= nil and #surfaces == 0) then
		return
	end

	local recipe = data.raw["recipe"][existing_recipe.name]
	if (#surfaces > 0 and recipe ~= nil) then
		util.surface.restrict_to_surfaces(recipe, surfaces)
	end
end

local function make_matter_technologies()
	for _, group in ipairs(matter_groups) do
		make_group_technology(group)
	end
end

local function make_matter_recipes()
	for _, group in ipairs(matter_groups) do
		for _, recipe in ipairs(group.recipes or {}) do
			make_group_recipe(group, recipe)
		end
		for _, existing_recipe in ipairs(group.existing_recipes or {}) do
			make_existing_recipe(existing_recipe)
		end
	end
end

function patch.on_data()
	make_matter_technologies()
end

function patch.on_data_updates()
	make_matter_recipes()
end

return patch