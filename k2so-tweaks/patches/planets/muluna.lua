--[[
	- Relaxes surface conditions to allow K2 trains (and other vehicles) to work there.

	TODO:
		- Add recipe for making processing units using Alumina
--]]

local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("planet-muluna")
patch:add_required_mod("planet-muluna")

local gravity_condition = { property = "gravity", min = 0.1 }

local function has_default_gravity_condition(entity)
	local gravity_condition = util.surface.get_surface_condition(entity, "gravity")
	if (gravity_condition == nil) then
		return true
	end

	return gravity_condition.min == 1.0
end

local function relax_gravity_conditions(prototype_id, entity_id)
	if (entity_id) then
		-- Convert a specific entity
		local entity = data.raw[prototype_id][entity_id]
		if (entity and has_default_gravity_condition(entity)) then
			PlanetsLib.relax_surface_conditions(entity, gravity_condition) --- @diagnostic disable-line
		end
	else
		-- Work on all entities of a given prototype
		for _, entity in pairs(data.raw[prototype_id] or {}) do
			if (has_default_gravity_condition(entity)) then
				PlanetsLib.relax_surface_conditions(entity, gravity_condition) --- @diagnostic disable-line
			end
		end
	end
end

function patch.on_data_final_fixes()
	-- Atmosphere is obtained using atmosphere condensation
	data.raw["recipe"]["muluna-carbon-dioxide"].category = "kr-atmosphere-condensation"

	-- K2's hydrogen and oxygen ratios are odd. We'll buff K2 and hide Maraxsis' recipe.
	data.raw["recipe"]["muluna-electrolysis"].hidden = true
	data.raw["recipe"]["kr-water-separation"]["results"] = {
		{ type = "fluid", name = "oxygen", amount = 100 },
		{ type = "fluid", name = "hydrogen", amount = 200 },
	}

	-- Let nuclear trains and other vehicles work on Muluna.
	relax_gravity_conditions("car", "kr-advanced-tank")
	relax_gravity_conditions("locomotive", "kr-nuclear-locomotive")
end

return patch