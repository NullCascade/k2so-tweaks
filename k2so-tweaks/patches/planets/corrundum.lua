
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("planet-corrundum")
patch:add_required_mod("corrundum")

local function extend_technologies()
    -- Allow pipe productivity to affect other pipes.
    util.technology.extend_recipe_productivity("pipe-productivity-infinite", "pipe", "gold-pipe")
    util.technology.extend_recipe_productivity("pipe-productivity-infinite", "pipe", "kr-steel-pipe")
    util.technology.extend_recipe_productivity("pipe-productivity-infinite", "pipe", "kr-casting-steel-pipe")
    util.technology.extend_recipe_productivity("pipe-productivity-infinite", "pipe", "zinc-pipe")

    -- Allow steam turbine productivity to affect some other modded turbines.
    util.technology.extend_recipe_productivity("steam-turbine-productivity-infinite", "steam-turbine", "kr-advanced-steam-turbine")
    util.technology.extend_recipe_productivity("steam-turbine-productivity-infinite", "steam-turbine", "maraxsis-oversized-steam-turbine")
    util.technology.extend_recipe_productivity("steam-turbine-productivity-infinite", "steam-turbine", "muluna-cycling-steam-turbine")
end

local function combat_adjustments()
    -- +50% base rocket damage, +100% rocket AoE damage, in line with K2 changes.
    util.projectile.update_damage("blue-rocket", 200, 300, "explosion")
    util.projectile.update_damage("blue-rocket", 150, 300, "explosion")
end

function patch.on_data_final_fixes()
    extend_technologies()
    combat_adjustments()
end
