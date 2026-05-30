
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("planet-hyarion")
patch:add_required_mod("planetaris-hyarion")

function patch.on_data()
	-- Things like fusion power aren't allowed here.
	util.surface.enforce_condition("assembling-machine", "kr-fusion-reactor", "planetaris-crystalization-resistance", nil, 49)
	util.surface.enforce_condition("assembling-machine", "kr-antimatter-reactor", "planetaris-crystalization-resistance", nil, 49)

	-- Automation 4 is in a wierd place. It has more module slots than the advanced assembling machine, but a slower
	-- speed. For now, we just aren't going to touch it.
	-- util.recipe.replace_ingredient("kr-advanced-assembling-machine", "assembling-machine-3", "assembling-machine-4", 1, "item")

	-- Update the ruby laser turret to fit in with K2SO's values.
	local ruby_turret = data.raw["electric-turret"]["planetaris-ruby-laser-turret"]
	if (ruby_turret) then
		ruby_turret.max_health = 700						-- Vanilla: 1000;	K2: 500;	Ruby: 1400
		ruby_turret.call_for_help_radius = 35				-- Vanilla: 40;		K2: 35;		Ruby: 40
		ruby_turret.energy_source = {
			type = "electric",
			buffer_capacity = "3000kJ",						-- Vanilla: 801kJ;	K2: 2000kJ;	Ruby: 1201kJ
			input_flow_limit = "6000kW",					-- Vanilla: 9600kW;	K2: 4000kW;	Ruby: 14100kW
			drain = "150kW",								-- Vanilla: 24kW;	K2: 100kW;	Ruby: 32kW
			usage_priority = "primary-input",
		}
		ruby_turret.attack_parameters = {
			type = "beam",
			cooldown = 25,									-- Vanilla: 40;		K2: 30;		Ruby: 35
			range = 32,										-- Vanilla: 24;		K2: 30;		Ruby: 32
			min_range = 5,									-- Vanilla: nil;	K2: nil;	Ruby: 5
			source_direction_count = 64,
			source_offset = { 0, -3.423489 / 4 },
			damage_modifier = 3.75,							-- Vanilla: 2;		K2: 3;		Ruby: 2.5
			ammo_category = "laser",
			ammo_type = {
				energy_consumption = "1450kJ",				-- Vanilla: 800kJ;	K2: 975kJ;	Ruby: 1200kJ
				action = {
					type = "direct",
					action_delivery = {
						type = "beam",
						beam = "laser-beam",
						max_length = 40,					-- Vanilla: 24;		K2: 30;		Ruby: 32
						duration = 35,						-- Vanilla: 40;		K2: 30;		Ruby: 45
						source_offset = { 0, -1.31439 },
					},
				},
			},
		}

		-- Only increase range if the realistic weapons setting is enabled.
		if (util.setting_equal("kr-realistic-weapons", true)) then
			ruby_turret.attack_parameters.range = 40		-- Vanilla: 24;		K2: 30;		Ruby: 32
		end
	end

	-- TODO: Figure out how to best integrate ruby laser tech into the personal laser equipment.
	-- TODO: Ruby laser artillery turret?
end

function patch.on_data_final_fixes()
	
end
