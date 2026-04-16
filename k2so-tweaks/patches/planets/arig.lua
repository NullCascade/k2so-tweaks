
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("planet-arig")
patch:add_required_mod("planetaris-arig")

function patch.on_data()
	data:extend({
		-- Allow direct smelting pure sand into glass.
		{
			type = "recipe",
			name = "k2sotweak-arig-glass-panel-direct",
			icons = util.graphics.create_dual_icon("item", "glass", "fluid", "planetaris-pure-sand"),
			category = "metallurgy",
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
			category = "sifting",
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
	-- No need for Arig to have its own glass or quartz.
	util.item.replace_all("planetaris-glass-panel", "glass")
	util.item.replace_all("planetaris-raw-quartz", "kr-quartz")

	-- Standardize some icons.
	util.graphics.set_standardized_dual_icon("recipe", "planetaris-glass-panel", "item", "glass", "item", "planetaris-pure-sand-barrel")
	util.graphics.set_standardized_dual_icon("recipe", "planetaris-raw-quartz", "item", "planetaris-raw-quartz", "item", "planetaris-sandstone-brick")
end
