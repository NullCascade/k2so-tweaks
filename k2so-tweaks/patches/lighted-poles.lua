--- Lighted Power Poles makes copies of existing entities, which can miss configurations done by other mods.

local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("lighted-poles-reach")

function patch.on_data_final_fixes()
	local poles = data.raw["electric-pole"]
	for id, pole in pairs(poles) do
		if (util.string.starts_with(id, "lighted-")) then
			local originalId = string.sub(id, string.len("lighted-") + 1)
			local original = poles[originalId]
			pole.maximum_wire_distance = original.maximum_wire_distance
			pole.supply_area_distance = original.supply_area_distance
			pole.surface_conditions = original.surface_conditions
		end
	end
end

return patch