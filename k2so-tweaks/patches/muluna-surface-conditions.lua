--- Lighted Power Poles makes copies of existing entities, which can miss configurations done by other mods.

local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("muluna-surface-conditions")

local gravity_condition = { property = "gravity", min = 0.1 }

local function has_default_gravity_condition(entity)
	local gravity_condition = util.surface.get_surface_condition(entity, "gravity")
	if (gravity_condition == nil) then
		return true
	end

	return gravity_condition.min == 1.0
end

local function relax_gravity_conditions(type, id)
    if (id) then
        local entity = data.raw[type][id]
        if (entity and has_default_gravity_condition(entity)) then
            PlanetsLib.relax_surface_conditions(entity, gravity_condition)
        end
    else
        for _, entity in pairs(data.raw[type] or {}) do
            if (has_default_gravity_condition(entity)) then
	            PlanetsLib.relax_surface_conditions(entity, gravity_condition)
            end
        end
    end
end

function patch.on_data_final_fixes()
	relax_gravity_conditions("car", "kr-advanced-tank")
	relax_gravity_conditions("locomotive", "kr-nuclear-locomotive")
end

return patch