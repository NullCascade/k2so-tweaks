
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("planet-corrundum")
patch:add_required_mod("corrundum")

function patch.on_data_final_fixes()
    -- Allow pipe productivity to affect other pipes.
    util.technology.extend_recipe_productivity("pipe-productivity-infinite", "pipe", "gold-pipe")
    util.technology.extend_recipe_productivity("pipe-productivity-infinite", "pipe", "kr-steel-pipe")
    util.technology.extend_recipe_productivity("pipe-productivity-infinite", "pipe", "kr-casting-steel-pipe")
    util.technology.extend_recipe_productivity("pipe-productivity-infinite", "pipe", "zinc-pipe")
end
