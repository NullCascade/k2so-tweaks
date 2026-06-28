--- Lighted Power Poles makes copies of existing entities, which can miss configurations done by other mods.

local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("standardize-stack-sizes")
patch:add_required_startup_setting_equal("nulls-k2so-standardize-stack-sizes", true)

function patch.on_data_final_fixes()
	local default_stack_size = 200
	local machine_stack_size = 50
	local big_machine_stack_size = 20
	local advanced_pipe_stack_size = 50

	-- Base items. Some mods revert them to vanilla stack sizes.
	util.item.set_stack_size("item", "explosives", default_stack_size)
	util.item.set_stack_size("item", "rocket-fuel", default_stack_size)
	util.item.set_stack_size("item", "solid-fuel", default_stack_size)

	-- Generic items
	util.item.set_stack_size("item", "glass", default_stack_size)
	util.item.set_stack_size("item", "sand", default_stack_size)

	-- Age of Production
	util.item.set_stack_size("item", "aop-biomass", default_stack_size)
	util.item.set_stack_size("item", "aop-deep-mineral", default_stack_size)
	util.item.set_stack_size("item", "aop-refined-mineral", default_stack_size)

	-- Apia-Cornova
	util.item.set_stack_size("item", "artificial-hive", machine_stack_size)
	util.item.set_stack_size("item", "bio-solar-panel", machine_stack_size)
	util.item.set_stack_size("item", "bioreactor", machine_stack_size)
	util.item.set_stack_size("item", "biosynthesizer", machine_stack_size)
	util.item.set_stack_size("item", "apicultural-science-pack", default_stack_size)
	util.item.set_stack_size("item", "bone-meal", default_stack_size)
	util.item.set_stack_size("item", "bones", default_stack_size)
	util.item.set_stack_size("item", "flamethrower-capsule", default_stack_size)
	util.item.set_stack_size("item", "flesh", default_stack_size)
	util.item.set_stack_size("item", "fossil-larvae", default_stack_size)
	util.item.set_stack_size("item", "honey", default_stack_size)
	util.item.set_stack_size("item", "honeycombs", default_stack_size)
	util.item.set_stack_size("item", "lipids", default_stack_size)
	util.item.set_stack_size("item", "phosphorus", default_stack_size)
	util.item.set_stack_size("item", "polysaccharides", default_stack_size)
	util.item.set_stack_size("item", "proteins", default_stack_size)
	util.item.set_stack_size("item", "raw-larvae", default_stack_size)
	util.item.set_stack_size("item", "wax-platform", default_stack_size)
	util.item.set_stack_size("item", "wax", default_stack_size)

	-- Arig
	util.item.set_stack_size("capsule", "planetaris-cactus", default_stack_size)
	util.item.set_stack_size("item", "planetaris-cactus-seeds", default_stack_size)
	util.item.set_stack_size("item", "planetaris-glass-panel", default_stack_size)
	util.item.set_stack_size("item", "planetaris-heavy-glass", default_stack_size)
	util.item.set_stack_size("item", "planetaris-polished-diamond", default_stack_size)
	util.item.set_stack_size("item", "planetaris-raw-diamond", default_stack_size)
	util.item.set_stack_size("item", "planetaris-raw-quartz", default_stack_size)
	util.item.set_stack_size("item", "planetaris-sandstone-brick", default_stack_size)
	util.item.set_stack_size("item", "planetaris-sandstone-foundation", default_stack_size)
	util.item.set_stack_size("item", "planetaris-silica", default_stack_size)
	util.item.set_stack_size("item", "planetaris-simulating-unit", default_stack_size)
	util.item.set_stack_size("tool", "planetaris-compression-science-pack", default_stack_size)

	-- Cerys
	util.item.set_stack_size("item", "cerys-nitrogen-rich-minerals", default_stack_size)
	util.item.set_stack_size("item", "cerys-nuclear-scrap", default_stack_size)
	util.item.set_stack_size("item", "methane-ice", default_stack_size)
	util.item.set_stack_size("item", "plutonium-238", default_stack_size)
	util.item.set_stack_size("item", "plutonium-239", default_stack_size)

	-- Common Prototypes
	util.item.set_stack_size("item", "gold-ore", default_stack_size)
	util.item.set_stack_size("item", "gold-plate", default_stack_size)
	util.item.set_stack_size("item", "neodymium-ore", default_stack_size)
	util.item.set_stack_size("item", "neodymium-plate", default_stack_size)

	-- Corrundum
	util.item.set_stack_size("item", "asphalt-c", default_stack_size)
	util.item.set_stack_size("item", "calcium-sulfate", default_stack_size)
	util.item.set_stack_size("item", "catalytic-chemical-plant", machine_stack_size)
	util.item.set_stack_size("item", "chalcopyrite-ore", default_stack_size)
	util.item.set_stack_size("item", "platinum-ore", default_stack_size)
	util.item.set_stack_size("item", "platinum-plate", default_stack_size)
	util.item.set_stack_size("item", "pressure-lab", machine_stack_size)
	util.item.set_stack_size("item", "red-steam-engine", machine_stack_size)
	util.item.set_stack_size("item", "sulfur-ore", default_stack_size)
	util.item.set_stack_size("item", "sulfuric-oxidizer", default_stack_size)

	-- Crushing Industry
	util.item.set_stack_size("item", "crushed-coal", default_stack_size)
	util.item.set_stack_size("item", "crushed-copper-ore", default_stack_size)
	util.item.set_stack_size("item", "crushed-iron-ore", default_stack_size)
	util.item.set_stack_size("item", "crushed-tungsten-ore", default_stack_size)
	util.item.set_stack_size("item", "glass", default_stack_size)
	util.item.set_stack_size("item", "holmium-powder", default_stack_size)

	-- Dea Dia System
	util.item.set_stack_size("item", "navicomputer", default_stack_size)
	util.item.set_stack_size("item", "rhenium-alloy-plate", default_stack_size)
	util.item.set_stack_size("item", "rhenium-dust", default_stack_size)
	util.item.set_stack_size("item", "rhenium-plate", default_stack_size)

	-- Hyarion
	util.item.set_stack_size("item", "kr-polishing-research-data", default_stack_size)
	util.item.set_stack_size("item", "kr-polishing-tech-card", default_stack_size)
	util.item.set_stack_size("item", "kr-refraction-research-data", default_stack_size)
	util.item.set_stack_size("item", "kr-refraction-tech-card", default_stack_size)
	util.item.set_stack_size("item", "msppr-hyarion", default_stack_size)
	util.item.set_stack_size("item", "planetaris_raw_bismuth", default_stack_size)
	util.item.set_stack_size("item", "planetaris-beryl", default_stack_size)
	util.item.set_stack_size("item", "planetaris-beryllium-coating", default_stack_size)
	util.item.set_stack_size("item", "planetaris-beryllium-nitride", default_stack_size)
	util.item.set_stack_size("item", "planetaris-beryllium-plate", default_stack_size)
	util.item.set_stack_size("item", "planetaris-bismuth-transistor", default_stack_size)
	util.item.set_stack_size("item", "planetaris-carbon-nanotube", default_stack_size)
	util.item.set_stack_size("item", "planetaris-charged-fluorite", default_stack_size)
	util.item.set_stack_size("item", "planetaris-fiber-optics-cable", default_stack_size)
	util.item.set_stack_size("item", "planetaris-fluorite", default_stack_size)
	util.item.set_stack_size("item", "planetaris-metallic-ore", default_stack_size)
	util.item.set_stack_size("item", "planetaris-nanoscale-lens", default_stack_size)
	util.item.set_stack_size("item", "planetaris-polished-bismuth", default_stack_size)
	util.item.set_stack_size("item", "planetaris-polished-diamond", default_stack_size)
	util.item.set_stack_size("item", "planetaris-polished-emerald", default_stack_size)
	util.item.set_stack_size("item", "planetaris-polished-quartz", default_stack_size)
	util.item.set_stack_size("item", "planetaris-polished-ruby", default_stack_size)
	util.item.set_stack_size("item", "planetaris-polished-sapphire", default_stack_size)
	util.item.set_stack_size("item", "planetaris-polishing-science-pack", default_stack_size)
	util.item.set_stack_size("item", "planetaris-raw-diamond", default_stack_size)
	util.item.set_stack_size("item", "planetaris-raw-emerald", default_stack_size)
	util.item.set_stack_size("item", "planetaris-raw-quartz", default_stack_size)
	util.item.set_stack_size("item", "planetaris-raw-ruby", default_stack_size)
	util.item.set_stack_size("item", "planetaris-raw-sapphire", default_stack_size)
	util.item.set_stack_size("item", "planetaris-refraction-science-pack", default_stack_size)
	util.item.set_stack_size("item", "planetaris-refractory-ceramics", default_stack_size)
	util.item.set_stack_size("item", "planetaris-ruby-laser", default_stack_size)
	util.item.set_stack_size("item", "planetaris-simulating-unit", default_stack_size)
	util.item.set_stack_size("item", "planetaris-unstable-gem", default_stack_size)
	util.item.set_stack_size("item", "planetaris-unstable-shard", default_stack_size)

	-- Lignumis
	util.item.set_stack_size("item", "gold-storage-tank", machine_stack_size)
	util.item.set_stack_size("item", "basic-circuit-board", default_stack_size)
	util.item.set_stack_size("item", "basic-repair-pack", default_stack_size)
	util.item.set_stack_size("item", "crushed-gold-ore", default_stack_size)
	util.item.set_stack_size("item", "cupriavidus-necator", default_stack_size)
	util.item.set_stack_size("item", "dead-cupriavidus-necator", default_stack_size)
	util.item.set_stack_size("item", "gold-bacteria", default_stack_size)
	util.item.set_stack_size("item", "gold-cable", default_stack_size)
	util.item.set_stack_size("item", "gold-ore", default_stack_size)
	util.item.set_stack_size("item", "gold-plate", default_stack_size)
	util.item.set_stack_size("item", "gold-quality-catalyst", default_stack_size)
	util.item.set_stack_size("item", "gold-stromatolite-seed", default_stack_size)
	util.item.set_stack_size("item", "lumber", default_stack_size)
	util.item.set_stack_size("item", "moist-stromatolite-remnant", default_stack_size)
	util.item.set_stack_size("item", "peat", default_stack_size)
	util.item.set_stack_size("item", "steam-science-pack-spoiled", default_stack_size)
	util.item.set_stack_size("item", "steam-science-pack", default_stack_size)
	util.item.set_stack_size("item", "wood-darts-magazine", default_stack_size)
	util.item.set_stack_size("item", "wood-science-pack", default_stack_size)
	util.item.set_stack_size("item", "wooden-gear-wheel", default_stack_size)

	-- Maraxsis
	util.item.set_stack_size("item", "maraxsis-big-cliff-explosives", default_stack_size)
	util.item.set_stack_size("item", "maraxsis-empty-research-vessel", default_stack_size)
	util.item.set_stack_size("item", "maraxsis-fish-food", default_stack_size)
	util.item.set_stack_size("item", "maraxsis-microplastics", default_stack_size)
	util.item.set_stack_size("item", "maraxsis-salt-filter", default_stack_size)
	util.item.set_stack_size("item", "maraxsis-saturated-salt-filter", default_stack_size)
	util.item.set_stack_size("item", "maraxsis-super-sealant-substance", default_stack_size)
	util.item.set_stack_size("item", "maraxsis-tropical-fish", default_stack_size)
	util.item.set_stack_size("item", "maraxsis-wyrm-confinement-cell", default_stack_size)
	util.item.set_stack_size("item", "maraxsis-wyrm-specimen", default_stack_size)

	-- Metal and Stars
	util.item.set_stack_size("item", "algae-bacteria", default_stack_size)
	util.item.set_stack_size("item", "antimatter", default_stack_size)
	util.item.set_stack_size("item", "dark-matter-chunk", default_stack_size)
	util.item.set_stack_size("item", "dark-matter-compressed", default_stack_size)
	util.item.set_stack_size("item", "dark-matter-crystal", default_stack_size)
	util.item.set_stack_size("item", "diamond", default_stack_size)
	util.item.set_stack_size("item", "thorium", default_stack_size)
	util.item.set_stack_size("item", "uranium-233", default_stack_size)

	-- Moshine
	util.item.set_stack_size("item", "neodymium", default_stack_size)
	util.item.set_stack_size("item", "magnet", default_stack_size)
	util.item.set_stack_size("item", "silicon-carbide", default_stack_size)
	util.item.set_stack_size("item", "hard-drive", default_stack_size)

	-- Muluna
	util.item.set_stack_size("item", "alumina-crushed", default_stack_size)
	util.item.set_stack_size("item", "alumina", default_stack_size)
	util.item.set_stack_size("item", "aluminum-crushed", default_stack_size)
	util.item.set_stack_size("item", "aluminum-plate", default_stack_size)
	util.item.set_stack_size("item", "cellulose", default_stack_size)
	util.item.set_stack_size("item", "microcellular-plastic", default_stack_size)
	util.item.set_stack_size("item", "muluna-diffused-plastic", default_stack_size)
	util.item.set_stack_size("item", "muluna-lunar-regolith", default_stack_size)
	util.item.set_stack_size("item", "muluna-microcellular-plastic", default_stack_size)
	util.item.set_stack_size("item", "silicon-cell", default_stack_size)
	util.item.set_stack_size("item", "silicon", default_stack_size)
	util.item.set_stack_size("item", "stone-crushed", default_stack_size)
	util.item.set_stack_size("item", "woodchips", default_stack_size)

	-- Paracelsin
	util.item.set_stack_size("item", "electric-coil", default_stack_size)
	util.item.set_stack_size("item", "electromagnetic-plant", big_machine_stack_size)
	util.item.set_stack_size("item", "galvanized-iron-gear-wheel", default_stack_size)
	util.item.set_stack_size("item", "galvanized-iron-plate", default_stack_size)
	util.item.set_stack_size("item", "galvanized-steel-plate", default_stack_size)
	util.item.set_stack_size("item", "macerator", big_machine_stack_size)
	util.item.set_stack_size("item", "mechanical-plant", big_machine_stack_size)
	util.item.set_stack_size("item", "sphalerite", default_stack_size)
	util.item.set_stack_size("item", "tetrahedrite", default_stack_size)
	util.item.set_stack_size("item", "vaterite", default_stack_size)
	util.item.set_stack_size("item", "zinc-pipe-to-ground", advanced_pipe_stack_size)
	util.item.set_stack_size("item", "zinc-pipe", advanced_pipe_stack_size)
	util.item.set_stack_size("item", "zinc-plate", default_stack_size)
	util.item.set_stack_size("item", "zinc-rivets", default_stack_size)
	util.item.set_stack_size("item", "zinc-solder", default_stack_size)
	util.item.set_stack_size("item", "zinc", default_stack_size)

	-- Pelagos
	util.item.set_stack_size("ammo", "corrosive-firearm-magazine", default_stack_size)
	util.item.set_stack_size("capsule", "coconut-meat", default_stack_size)
	util.item.set_stack_size("item", "activated-carbon", default_stack_size)
	util.item.set_stack_size("item", "coconut-husk", default_stack_size)
	util.item.set_stack_size("item", "coconut-meat", default_stack_size)
	util.item.set_stack_size("item", "coconut-sealant", default_stack_size)
	util.item.set_stack_size("item", "coconut-seed", default_stack_size)
	util.item.set_stack_size("item", "coconut", default_stack_size)
	util.item.set_stack_size("item", "copper-biter-egg", default_stack_size)
	util.item.set_stack_size("item", "fermentation-bacteria", default_stack_size)
	util.item.set_stack_size("item", "fermented-fish", default_stack_size)
	util.item.set_stack_size("item", "sand", default_stack_size)
	util.item.set_stack_size("item", "titanium-dust", default_stack_size)
	util.item.set_stack_size("item", "titanium-plate", default_stack_size)
	util.item.set_stack_size("item", "wooden-platform", default_stack_size)

	-- Rubia
	util.item.set_stack_size("item", "craptonite-frame", default_stack_size)
	util.item.set_stack_size("item", "craptonite-wall", default_stack_size)
	util.item.set_stack_size("item", "rubia-cupric-scrap", default_stack_size)
	util.item.set_stack_size("item", "rubia-ferric-scrap", default_stack_size)

	-- Secretas & Frozeta
	util.item.set_stack_size("item", "spaceship-scrap", default_stack_size)

	-- SLP - Dyson Sphere Reworked
	util.item.set_stack_size("item", "ds-energy-loader-mk1", machine_stack_size)
	util.item.set_stack_size("item", "ds-energy-loader-mk2", machine_stack_size)
	util.item.set_stack_size("item", "ds-energy-loader-mk3", machine_stack_size)
	util.item.set_stack_size("item", "ds-energy-loader", machine_stack_size)
	util.item.set_stack_size("item", "ds-energy-small-loader", machine_stack_size)
	util.item.set_stack_size("item", "ds-entangled-core", default_stack_size)
	util.item.set_stack_size("item", "slp-sun-fuel-mk2", default_stack_size)
	util.item.set_stack_size("item", "slp-sun-fuel", default_stack_size)

	-- Tenebris Prime
	util.item.set_stack_size("item", "bioluminescent-crystal", default_stack_size)
	util.item.set_stack_size("item", "chitin", default_stack_size)
	util.item.set_stack_size("item", "chitosan", default_stack_size)
	util.item.set_stack_size("item", "luciferin", default_stack_size)
	util.item.set_stack_size("item", "lucifunnel-seed", default_stack_size)
	util.item.set_stack_size("item", "lucifunnel", default_stack_size)
	util.item.set_stack_size("item", "quartz-crystal", default_stack_size)
	util.item.set_stack_size("item", "quartz-ore", default_stack_size)
	util.item.set_stack_size("item", "tenecap-spore", default_stack_size)
	util.item.set_stack_size("item", "tenecap", default_stack_size)

	-- Vesta
	util.item.set_stack_size("item", "iridium-plate", default_stack_size)
end

return patch