local util_autoplace = {}

--- @param name string
--- @param order string
function util_autoplace.set_order(name, order)
	local control = data.raw["autoplace-control"] and data.raw["autoplace-control"][name]
	if (not control) then
		return
	end

	control.order = order
end

return util_autoplace
