local util_surface = {}

function util_surface.get_surface_condition(entity, condition)
	for _, condition in ipairs(entity.surface_conditions or {}) do
		if (condition.property == condition) then
			return condition
		end
	end
end

return util_surface