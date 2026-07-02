local util_accumulator = {}

--- @param name string
--- @param input_flow_limit string
--- @param output_flow_limit string
function util_accumulator.set_flow_limits(name, input_flow_limit, output_flow_limit)
	local accumulator = data.raw["accumulator"][name]
	if (not accumulator or not accumulator.energy_source) then
		return
	end

	accumulator.energy_source.input_flow_limit = input_flow_limit
	accumulator.energy_source.output_flow_limit = output_flow_limit
end

return util_accumulator
