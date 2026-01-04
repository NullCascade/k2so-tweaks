local util_data = {}

function util_data.clone(type, from, to)
	local from_prototype = data.raw[type][from]
	if (not from_prototype) then
		error(string.format("Could not clone '%s' of type '%s': Prototype does not exist.", from, type))
	end

	local to_prototype = data.raw[type][to]
	if (to_prototype) then
		error(string.format("Could not clone '%s' of type '%s': Existing prototype '%s' already exists..", from, type, to))
	end

	to_prototype = table.deepcopy(from_prototype)
	to_prototype.name = to
	data:extend({ to_prototype })
end

return util_data