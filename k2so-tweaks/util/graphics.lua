local util_graphics = {}

--- @param type string
--- @param id string
--- @return string?
function util_graphics.get_icon(type, id)
	local prototype = data.raw[type][id]
	if (prototype == nil) then
		return nil
	end

	if (prototype.icon) then
		return prototype.icon
	end

	if (prototype.icons and #prototype.icons > 0) then
		return prototype.icons[1].icon
	end

	return nil
end

---@param primary_type string
---@param primary_id string
---@param secondary_type string
---@param secondary_id string
---@return data.IconData[]
function util_graphics.create_dual_icon(primary_type, primary_id, secondary_type, secondary_id)
	local primary_icon = assert(util_graphics.get_icon(primary_type, primary_id), "Primary icon does not exist")
	local secondary_icon = assert(util_graphics.get_icon(secondary_type, secondary_id), "Secondary icon does not exist")
	return {
		{ icon = primary_icon },
		{ icon = secondary_icon, scale = 0.22, shift = { -8, -8 }, },
	}
end

--- @param type string
--- @param id string
--- @param primary_icon_type string
--- @param primary_icon_name string
--- @param secondary_icon_type string
--- @param secondary_icon_name string
function util_graphics.set_standardized_dual_icon(type, id, primary_icon_type, primary_icon_name, secondary_icon_type, secondary_icon_name)
	local prototype = data.raw[type][id]
	if (prototype == nil) then
		return
	end

	prototype.icon = nil
	prototype.icons = util_graphics.create_dual_icon(primary_icon_type, primary_icon_name, secondary_icon_type, secondary_icon_name)
end

return util_graphics