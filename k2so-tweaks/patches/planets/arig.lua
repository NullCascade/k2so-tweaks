
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("planet-arig")
patch:add_required_mod("planetaris-arig")

--[[
	Water harvester values:
		maraxsis	500
		gleba		500
		tellus		500
		apia		450
		carnova		350
		nauvis		300
		paracelsin	200
		frozeta		200
		fulgora		150
		hyarion		150
		lignumis	150
		pelagos		150
		aquilo		100
		arig		100
		vesta		100
		moshine		75
		rubia		75
		secretas	75
		vulcanus	50
		corrundum	25
]]

local water_harvesting_surfaces = {
	{ name = "apia", order = "a-f[modded]-a[apia]", amount = 450, conditions = { "pressure", "gravity", "magnetic-field" } },
	{ name = "carnova", order = "a-f[modded]-b[carnova]", amount = 350, conditions = { "pressure", "gravity", "magnetic-field" } },
	{ name = "maraxsis", order = "a-f[modded]-c[maraxsis]", amount = 500, conditions = { "pressure", "gravity", "magnetic-field" } },
	{ name = "moshine", order = "a-f[modded]-d[moshine]", amount = 75, conditions = { "pressure", "gravity", "magnetic-field" } },
	{ name = "paracelsin", order = "a-f[modded]-e[paracelsin]", amount = 200, conditions = { "pressure", "gravity", "magnetic-field" } },
	{ name = "vesta", order = "a-f[modded]-f[vesta]", amount = 100, conditions = { "pressure", "gravity", "magnetic-field" } },
	{ name = "secretas", order = "a-f[modded]-g[secretas]", amount = 75, conditions = { "pressure", "magnetic-field" } },
	{ name = "corrundum", order = "a-f[modded]-h[corrundum]", amount = 25, conditions = { "pressure", "gravity", "magnetic-field" } },
	{ name = "rubia", order = "a-f[modded]-i[rubia]", amount = 75, conditions = { "pressure", "gravity", "magnetic-field" } },
	{ name = "frozeta", order = "a-f[modded]-j[frozeta]", amount = 200, conditions = { "pressure", "gravity", "magnetic-field" } },
}

--- @param water_settings table
--- @return data.SurfaceCondition[]
local function create_water_harvesting_surface_conditions(water_settings)
	local planet = data.raw["planet"][water_settings.name]
	if (planet == nil) then
		return {}
	end

	local surface_conditions = {}
	for _, condition_property in ipairs(water_settings.conditions) do
		local surface_condition = util.surface.create_exact_surface_condition(planet, condition_property)
		if (surface_condition ~= nil) then
			table.insert(surface_conditions, surface_condition)
		end
	end

	return surface_conditions
end

--- @param water_settings table
local function add_water_harvesting_recipe(water_settings)
	local planet = data.raw["planet"][water_settings.name]
	if (planet == nil) then
		return
	end

	local recipe_name = "planetaris-" .. water_settings.name .. "-water-harvesting"
	if (data.raw["recipe"][recipe_name] == nil) then
		data:extend({
			{
				type = "recipe",
				name = recipe_name,
				localised_name = {"", {"space-location-name." .. water_settings.name}, " ", {"recipe-name.planetaris-water-harvesting"}},
				categories = { "water-production" },
				subgroup = "water-harvesting",
				order = water_settings.order,
				icons = {
					{ icon = planet.icon, draw_background = true },
					{ icon = "__base__/graphics/icons/fluid/water.png", shift = { 8, 12 }, scale = 0.5 },
				},
				surface_conditions = create_water_harvesting_surface_conditions(water_settings),
				energy_required = 10,
				enabled = false,
				ingredients = nil,
				results = {
					{ type = "fluid", name = "water", amount = water_settings.amount }
				},
				allow_productivity = true,
			},
		})
	end

	util.technology.add_recipe_unlock("planetaris-water-harvesting", recipe_name)
end

--- @return nil
local function add_modded_water_harvesting_recipes()
	for _, water_settings in ipairs(water_harvesting_surfaces) do
		add_water_harvesting_recipe(water_settings)
	end
end

function patch.on_data()
	data:extend({
		-- Allow direct smelting pure sand into glass.
		{
			type = "recipe",
			name = "k2sotweak-arig-glass-panel-direct",
			icons = util.graphics.create_dual_icon("item", "glass", "fluid", "planetaris-pure-sand"),
			categories = { "metallurgy" },
			energy_required = 3,
			ingredients = {
				{ type = "fluid", name = "planetaris-pure-sand", amount = 100 },
			},
			results = {
				{ type = "item", name = "planetaris-glass-panel", amount = 5 },
			},
			enabled = false,
			allow_productivity = true,
			auto_recycle = false,
		},
		-- Allow converting Arig sand into K2 sand via sifting.
		{
			name = "k2sotweak-sand-item-sifting",
			type = "recipe",
			icons = util.graphics.create_dual_icon("item", "kr-sand", "fluid", "planetaris-sand"),
			categories = { "sifting" },
			energy_required = 0.5,
			ingredients = {
				{ type = "fluid", name = "planetaris-sand", amount = 200 },
			},
			results = {
				{ type = "item", name = "kr-sand", amount = 1 },
			},
			allow_productivity = false,
			crafting_machine_tint = {
				primary = { 0.871, 0.788, 0.627, 1 },
				secondary = { 0.871, 0.788, 0.627, 1 },
				tertiary = { 0.871, 0.788, 0.627, 1 },
				quaternary = { 0.871, 0.788, 0.627, 1 },
			},
			enabled = false,
			auto_recycle = false,
		},
	})

	-- Add unlocks for above recipes.
	util.technology.add_recipe_unlock("planetaris-glass", "k2sotweak-arig-glass-panel-direct")
	util.technology.add_recipe_unlock("planetaris-sand-sifting", "k2sotweak-sand-item-sifting")

	-- Allow silicon to be made in the press.
	util.recipe.add_additional_category("kr-silicon", "compressing")

	-- Allow Arig's quartz productivity research to affect K2's quartz production.
	util.technology.copy_effect("planetaris-raw-quartz-productivity", "recipe", "planetaris-raw-quartz", "kr-quartz", "change")

	-- Add water harvesting support for additional planet surfaces.
	add_modded_water_harvesting_recipes()

	-- Update the Arig roboport to match changes in K2.
	local arig_roboport = data.raw["roboport"]["planetaris-arig-roboport"]
	if (arig_roboport) then
		arig_roboport.charging_energy = "1100kW" 				-- Vanilla: 500kW;	K2: 1000kW;	Arig: 550kW
		arig_roboport.energy_source.input_flow_limit = "4MW"	-- Vanilla: 5MW;	K2: 5MW;	Arig: 4MW
		arig_roboport.material_slots_count = 3					-- Vanilla: 7;		K2: 3;		Arig: 7
		arig_roboport.robot_slots_count = 3						-- Vanilla: 7;		K2: 3;		Arig: 7
	end
end

function patch.on_data_final_fixes()
	-- Standardize some icons.
	util.graphics.set_standardized_dual_icon("recipe", "planetaris-glass-panel", "item", "kr-glass", "item", "planetaris-pure-sand-barrel")
	util.graphics.set_standardized_dual_icon("recipe", "planetaris-raw-quartz", "item", "kr-quartz", "item", "planetaris-sandstone-brick")
end
