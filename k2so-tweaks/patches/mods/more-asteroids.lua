local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("mod-more-asteroids")
patch:add_required_mod("More-Asteroids")

--- @param assembling_machine string
--- @param fluid_boxes data.FluidBox[]?
local function add_fluid_boxes(assembling_machine, fluid_boxes)
	local prototype = data.raw["assembling-machine"][assembling_machine]
	if (not prototype) then
		return
	end

	local has_fluid_boxes = #(prototype.fluid_boxes or {}) > 0
	if not has_fluid_boxes then
		prototype.fluid_boxes = fluid_boxes
		prototype.fluid_boxes_off_when_no_fluid_recipe = true
		prototype.forced_symmetry = "horizontal"
		util.log("Added fluid boxes to assembling machine: %s", assembling_machine)
	end
end

function patch.on_data_updates()
	-- Add fluid boxes to Crushing Industries crushers.
	add_fluid_boxes("big-crusher", {
		{
			production_type = "input",
			volume = 200,
			pipe_connections = {
				{ flow_direction = "input-output", direction = 12, position = { -1.5, 0.5 } },
			},
		},
		{
			production_type = "input",
			volume = 200,
			pipe_connections = {
				{ flow_direction = "input-output", direction = 4, position = { 1.5, -0.5 } },
			},
		},
	})
end

return patch