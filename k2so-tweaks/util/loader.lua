local util_loader = {}

--- @param name string
--- @param hidden boolean
function util_loader.set_hidden(name, hidden)
	local loader = data.raw["loader-1x1"] and data.raw["loader-1x1"][name]
	if (not loader) then
		return
	end

	loader.hidden = hidden
	loader.hidden_in_factoriopedia = hidden
end

--- @param name string
--- @param next_upgrade string?
function util_loader.set_next_upgrade(name, next_upgrade)
	local loader = data.raw["loader-1x1"] and data.raw["loader-1x1"][name]
	if (not loader) then
		return
	end

	loader.next_upgrade = next_upgrade
end

return util_loader
