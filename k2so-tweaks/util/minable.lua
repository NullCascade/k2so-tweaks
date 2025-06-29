local util_minable = {}

function util_minable.replace_all(old, new)
	for _, prototype in pairs(data.raw) do
		for _, entity in pairs(prototype) do
			if (entity.minable) then
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