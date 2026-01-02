
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("mod-aai-industry")
patch:add_required_mod("aai-industry")

function patch.on_data_final_fixes()
	util.technology.replace("sand-processing", "kr-sand", "sand")
	util.recipe.set_hidden("sand", false)
	util.technology.replace("glass-processing", "kr-glass", "glass")
	util.recipe.set_hidden("glass", false)
end

return patch