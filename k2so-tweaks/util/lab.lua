local util_lab = {}

--- @param name string
--- @param inputs string[]
function util_lab.set_inputs(name, inputs)
	local lab = data.raw["lab"][name]
	if (not lab) then
		return
	end

	lab.inputs = inputs
end

return util_lab
