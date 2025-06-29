--- Lighted Power Poles makes copies of existing entities, which can miss configurations done by other mods.

local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("mod-lighted-poles-plus")
patch:add_required_mod("Lighted-Poles-Plus")

local function is_lighted_pole(id)
	return util.string.starts_with(id, "lighted-")
end

local function get_unlighted_pole(lit_id)
	local unlit_id = string.sub(lit_id, string.len("lighted-") + 1)
	return data.raw["electric-pole"][unlit_id]
end

function patch.on_data_final_fixes()
	for lit_id, lit_pole in pairs(data.raw["electric-pole"]) do
		if (is_lighted_pole(lit_id)) then
			local unlit_pole = get_unlighted_pole(lit_id)
			if (unlit_pole) then
				lit_pole.maximum_wire_distance = unlit_pole.maximum_wire_distance
				lit_pole.supply_area_distance = unlit_pole.supply_area_distance
				lit_pole.surface_conditions = unlit_pole.surface_conditions
			end
		end
	end
end

return patch