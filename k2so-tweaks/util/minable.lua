local util_minable = {}

--- @param old string
--- @param new string
function util_minable.replace_all(old, new)
	for _, prototype in pairs(data.raw) do
		for _, entity in pairs(prototype) do
			if (entity.minable) then
				if (entity.minable.result == old) then
					entity.minable.result = new
				end
				for _, minable in ipairs(entity.minable.results or {}) do
					if (minable.name == old) then
						minable.name = new
					end
				end
			end
		end
	end
end

return util_minable