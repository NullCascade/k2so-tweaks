--[[
Features:
    - Allow the greenhouse to be used on the planet (wood only).
    - Add direct cast recipe for gold cable.
To-Do:
    - Be able to make tech cards on-surface.
]]

local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("lignumis")
patch:add_required_mod("lignumis")

function patch.on_data()
    -- Add a direct casting recipe for gold cable.
    if (not data.raw["recipe"]["casting-gold-cable"]) then
        data:extend({
            {
                type = "recipe",
                name = "casting-gold-cable",
                icons = util.graphics.create_casting_icon("item", "gold-cable", "fluid", "molten-gold"),
                category = "metallurgy",
                energy_required = 1,
                ingredients = {
                    { type = "fluid", name = "molten-gold", amount = 5, fluidbox_multiplier = 5 },
                },
                results = {
                    { type = "item", name = "gold-cable", amount = 2 },
                },
                subgroup = "vulcanus-processes",
                order = "b[casting]-hb[casting-gold-cable]",
                enabled = false,
                allow_productivity = true,
                allow_decomposition = false,
                auto_recycle = false,
            },
        })
        util.technology.add_recipe_unlock("foundry", "casting-gold-cable")
    end
end

function patch.on_data_final_fixes()
	-- Lignumis seems perfectly legit for greenhouses.
    util.surface.relax_conditions_for_planet("assembling-machine", "kr-greenhouse", "lignumis")
end

return patch
