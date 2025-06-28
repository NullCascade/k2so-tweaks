--- Lighted Power Poles makes copies of existing entities, which can miss configurations done by other mods.

local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("standardize-stack-sizes")

local function set_stack_size(prototype, entity, size)
	local parent = data.raw[prototype]
	if (parent == nil) then
		return
	end

	local thing = parent[entity]
	if (thing == nil) then
		return
	end

	if (thing.stack_size == nil) then
		return
	end

	thing.stack_size = size
end

function patch.on_data_final_fixes()
	local default_stack_size = 200
	local machine_stack_size = 50

	-- Age of Production
	set_stack_size("item", "aop-biomass", default_stack_size)
	set_stack_size("item", "aop-deep-mineral", default_stack_size)
	set_stack_size("item", "aop-refined-mineral", default_stack_size)

	-- Cerys
	set_stack_size("item", "cerys-nitrogen-rich-minerals", default_stack_size)
	set_stack_size("item", "cerys-nuclear-scrap", default_stack_size)
	set_stack_size("item", "methane-ice", default_stack_size)
	set_stack_size("item", "plutonium-238", default_stack_size)

	-- Common Prototypes
	set_stack_size("item", "gold-ore", default_stack_size)
	set_stack_size("item", "gold-plate", default_stack_size)
	set_stack_size("item", "neodymium-ore", default_stack_size)
	set_stack_size("item", "neodymium-plate", default_stack_size)

	-- Corrundum
	set_stack_size("item", "asphalt-c", default_stack_size)
	set_stack_size("item", "calcium-sulfate", default_stack_size)
	set_stack_size("item", "catalytic-chemical-plant", machine_stack_size)
	set_stack_size("item", "chalcopyrite-ore", default_stack_size)
	set_stack_size("item", "platinum-ore", default_stack_size)
	set_stack_size("item", "platinum-plate", default_stack_size)
	set_stack_size("item", "pressure-lab", machine_stack_size)
	set_stack_size("item", "red-steam-engine", machine_stack_size)
	set_stack_size("item", "sulfur-ore", default_stack_size)

	-- Crushing Industry
	set_stack_size("item", "crushed-coal", default_stack_size)
	set_stack_size("item", "crushed-copper-ore", default_stack_size)
	set_stack_size("item", "crushed-iron-ore", default_stack_size)
	set_stack_size("item", "crushed-tungsten-ore", default_stack_size)
	set_stack_size("item", "glass", default_stack_size)
	set_stack_size("item", "holmium-powder", default_stack_size)

	-- Dea Dia System
	set_stack_size("item", "rhenium-alloy-plate", default_stack_size)
	set_stack_size("item", "navicomputer", default_stack_size)

	-- Metal and Stars
	set_stack_size("item", "algae-bacteria", default_stack_size)
	set_stack_size("item", "antimatter", default_stack_size)
	set_stack_size("item", "dark-matter-chunk", default_stack_size)
	set_stack_size("item", "dark-matter-compressed", default_stack_size)
	set_stack_size("item", "dark-matter-crystal", default_stack_size)
	set_stack_size("item", "diamond", default_stack_size)
	set_stack_size("item", "thorium", default_stack_size)
	set_stack_size("item", "uranium-233", default_stack_size)

	-- Muluna
	set_stack_size("item", "alumina-crushed", default_stack_size)
	set_stack_size("item", "alumina", default_stack_size)
	set_stack_size("item", "aluminum-plate", default_stack_size)
	set_stack_size("item", "cellulose", default_stack_size)
	set_stack_size("item", "silicon-cell", default_stack_size)
	set_stack_size("item", "silicon", default_stack_size)
	set_stack_size("item", "stone-crushed", default_stack_size)
	set_stack_size("item", "woodchips", default_stack_size)

	-- Paracelsin
	set_stack_size("item", "electric-coil", default_stack_size)
	set_stack_size("item", "sphalerite", default_stack_size)
	set_stack_size("item", "tetrahedrite", default_stack_size)
	set_stack_size("item", "vaterite", default_stack_size)
	set_stack_size("item", "zinc-plate", default_stack_size)
	set_stack_size("item", "zinc-rivets", default_stack_size)
	set_stack_size("item", "zinc-solder", default_stack_size)
	set_stack_size("item", "zinc", default_stack_size)

	-- Rubia
	set_stack_size("item", "craptonite-frame", default_stack_size)
	set_stack_size("item", "craptonite-wall", default_stack_size)
	set_stack_size("item", "rubia-cupric-scrap", default_stack_size)
	set_stack_size("item", "rubia-ferric-scrap", default_stack_size)

	-- Secretas & Frozeta
	set_stack_size("item", "spaceship-scrap", default_stack_size)

	-- Tenebris Prime
	set_stack_size("item", "bioluminescent-crystal", default_stack_size)
	set_stack_size("item", "chitin", default_stack_size)
	set_stack_size("item", "chitosan", default_stack_size)
	set_stack_size("item", "luciferin", default_stack_size)
	set_stack_size("item", "lucifunnel-seed", default_stack_size)
	set_stack_size("item", "lucifunnel", default_stack_size)
	set_stack_size("item", "quartz-crystal", default_stack_size)
	set_stack_size("item", "quartz-ore", default_stack_size)
	set_stack_size("item", "tenecap-spore", default_stack_size)
	set_stack_size("item", "tenecap", default_stack_size)
end

return patch