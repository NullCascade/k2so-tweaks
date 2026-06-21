
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("planet-apia-carnova")
patch:add_required_mod("apia")

function patch.on_data_final_fixes()
    -- Allow the simple crushing-like recipes to be used in the crusher.
    util.recipe.add_additional_category("fossil-larvae-processing", "kr-crushing")
    util.recipe.add_additional_category("simple-bone-processing", "kr-crushing")
end
