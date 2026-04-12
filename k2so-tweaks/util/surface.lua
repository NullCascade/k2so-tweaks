local util_surface = {}

--- @param entity_type string
--- @param entity_id string
--- @param planet_id string
function util_surface.relax_conditions_for_planet(entity_type, entity_id, planet_id)
	local util = require("k2so-tweaks.util")

	local surface = data.raw["planet"][planet_id]
	if (surface == nil) then
		util.log("Planet '%s' does not exist.", planet_id)
		return
	end

	local prototype = data.raw[entity_type][entity_id]
	if (prototype == nil) then
		util.log("Entity '%s' of type '%s' does not exist.", entity_id, entity_type)
		return nil
	end

	local surface_properties = surface.surface_properties or {}
	for _, condition in ipairs(prototype.surface_conditions or {}) do
		local surface_condition = surface_properties[condition.property]
		if (surface_condition) then
			if (condition.min > surface_condition) then
				condition.min = surface_condition
			end
			if (condition.max < surface_condition) then
				condition.max = surface_condition
			end
		end
	end
end

return util_surface