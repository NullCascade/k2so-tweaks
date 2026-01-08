local util_tile = {}

--- @param old string
--- @param new string
function util_tile.replace_all(old, new)
	for _, prototype in pairs(data.raw["tile"]) do
		if (prototype.fluid == old) then
			prototype.fluid = new
		end
	end
end

return util_tile