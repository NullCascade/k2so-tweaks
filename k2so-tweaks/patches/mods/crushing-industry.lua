--[[
	- Allows imersite to be processed in the burner/electric crushers
TODO:
	- Add ore crushing for:
		- Krastorio 2: Rare Earth
		- Krastorio 2: Imersite? Already has crushing in K2...
		- <other planets>
--]]

local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("mod-crushing-industry")
patch:add_required_mod("crushing-industry")

function patch.on_data_final_fixes()
	-- Fix K2 glass recipe not being available.
	data.raw["recipe"]["kr-glass"].hidden = false

	-- Allow more things to be processed by crushing machines.
	util.recipe.add_additional_category("kr-imersite-powder", "basic-crushing")
end

return patch