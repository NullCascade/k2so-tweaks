local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("lignumis")
patch:add_required_mod("lignumis")

function patch.on_data_final_fixes()
	-- Lignumis seems perfectly legit for greenhouses.
    util.surface.relax_conditions_for_planet("assembling-machine", "kr-greenhouse", "lignumis")
end

return patch