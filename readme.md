Personally desired tweaks and patches for [Krastorio 2: Spaced Out](https://mods.factorio.com/mod/Krastorio2-spaced-out) and other mods. Significant changes beyond basic fixes can be configured/disabled.

I'm making this as I play through my current mod list, to fix incompatibilities or shortcomings I find.

Looking for more K2SO fixes/tweaks/enhancements? Check out [xyrc's K2SO Enhancements](https://mods.factorio.com/mod/xy-k2so-enhancements-nulls-fork).

---

- **Standardize Stack Sizes** (optional): Brings the stack sizes for any list optional dependency mod to be in line with K2's stack size defaults (200 for most items).
- **Recycling Patches**: Some mods add new ways to generate base resources, such as rare ore or ice. This mod ensures that these new recipes don't cause base resources (ores, asteroid chunk results) don't recycle into exotic modded planet resources. Improves compatibility with Metal and Stars, Vesta, probably others. This also tweaks some other recycling recipes from Automatic Train Painter and Moshine.
- **Consistent Crafting Categories**: Ensures that Krastorio 2 advanced crafting machines have access to their non-upgraded base machine crafting categories. Modded planets often add new categories that Krastorio doesn't get updated to understand. This fixes it so you can always craft something in an Advanced Chemical Plant that a normal Chemical Plant can craft, as an example. Affects the advanced assembling machine, advanced chemical reactor, and advanced furnace.

## Mod-Specific Changes

### [Age of Production](https://mods.factorio.com/mod/Age-of-Production)

- Fixes ammunition crafting recipes.

### [Apia-Carnova Planet System](https://mods.factorio.com/mod/apia)

- Allows crushing bones and fossils in the Krastorio crusher. This only applies to the basic recipe that the normal assembling machine could use.
- Brings stack sizes in line with Krastorio's defaults.

### [Cerys](https://mods.factorio.com/mod/Cerys-Moon-of-Fulgora)

- Fixes ammunition crafting categories.
- Brings stack sizes in line with Krastorio's defaults.
- Allows the placement of K2SO's interplanetary teleporter on the surface.

### [Corrundum](https://mods.factorio.com/mod/corrundum)

- Blue rocket damage is buffed proportionally to other changes Krastorio 2 does to rocket damage.
- Pipe productivity affects K2 steel pipes, Lignumis gold pipes, and Paracelsin zinc pipes.
- Steam turbine productivity affects K2 advanced turbines, Muluna condensing turbines, and Maraxsis oversized turbines.
- Brings stack sizes in line with Krastorio's defaults.

### [Crushing Industry](https://mods.factorio.com/mod/crushing-industry)

- Burner and electric crushers need their recipes selected, similar to how K2 furnaces need their recipe selected.
- Re-enables K2's glass smelting from sand recipe.
- Allows imersite to be crushed in Crushing Industry machines.
- The Big Crusher can accept fluid inputs, if [More Asteroids](https://mods.factorio.com/mod/More-Asteroids) is installed.
- Infinite productivity tech applies to K2SO's enriched iron/copper melting.
- Ratio Rebalance (optional): Crushing Industry smelting doesn't fit into K2's reduced ratios, and outshines K2's ore enrichment in all ways. This nerfs early game crushed smelting (2 crushed -> 1 plate), but also allows the enrichment of crushed ore. By chemical science, with enrichment, vanilla Crushing Industry ratios are available again. By Vulcanus (big crusher, molten metal) and Gleba (K2 advanced chemical plant), this combination is even stronger.

### [Krastorio 2: Spaced Out](https://mods.factorio.com/mod/Krastorio2-spaced-out)

- **Item Standardization**: Fixes incompatibilities between Crushing Industry, Moshine, Maraxis, and K2SO, which each try to switch which glass/sand is used, often in contradiction to one another. All mods will use a standard sand and glass. This is more comprehensive than some other attempts at this, and include minables such as Moshine's mixed ores and Maraxis' sand sources. Existing factories have their items automatically converted.
- **Fluid Standardization**: Fixes redundancies with K2SO, Maraxsis, Muluna, and Paracelsin. Oxygen, Hydrogen, and Nitrogen are common now. Existing factories have their K2 fluids automatically converted.
- (Optional) Additional Matter Recipes: Adds matter deconversion recipe for basic gases (oxygen, hydrogen, nitrogen). This is intended to make producing things like nitric acid on other planets more viable.
- Adds an additional vanilla-style recipe for lithium on Aquilo, using holmium plates. This allows for quality lithium, and provides a minimal bonus for the extra catalyst investment.
- Overwrites resistances for asteroids against K2's special damage types with vanilla resistances. This makes them less overpowered against big/huge asteroids, and improves compatibility with mods who alter resistances like Rubia. It also changes the name of K2's explosion damage resistance to be tagged and distinguishable from its vanilla version.

### [Krastorio 2 Imersite Asteroids](https://mods.factorio.com/mod/Imersite-Asteroids)

- **Crushing Industry**: Allow imersite asteroids to be crushed in burner/electric crushers.

### [Lighted Electric Poles +](https://mods.factorio.com/mod/Lighted-Poles-Plus)

- Fixes the wire reach and supply area of lighted poles to use K2's settings.

### [Lignumis](https://mods.factorio.com/mod/lignumis)

- Allows Krastorio 2's greenhouses to work on the planet.
- Adds a direct casting recipe for gold cable.
- (Optional) Additional Matter Recipes: Adds matter conversion to/from peat and gold ore.

### [Maraxsis](https://mods.factorio.com/mod/maraxsis)

- Allows atmosphere collecting in K2's atmosphere condenser machine.
- Allows salt electrolysis in K2's electrolysis plant and Space Age's electromagnetic plant.
- Allows the advanced chemical plant to be used anywhere that a normal chemical plant would be.
- Brings stack sizes in line with Krastorio's defaults.
- (Optional) Quantum Computer Revert: Reverts this planet's changes to K2SO's Quantum Computer. This re-enables the use of the machine on most planets, but also removes the 50% quality bonus. This is disabled by default.

### [More Asteroids](https://mods.factorio.com/mod/More-Asteroids)

- **Crushing Industry**: Allow most added asteroids to be crushed in burner/electric crushers.

### [Moshine](https://mods.factorio.com/mod/Moshine)

- Brings stack sizes in line with Krastorio's defaults.
- Allows the placement of K2SO's interplanetary teleporter on the surface.
- (Optional) Additional Matter Recipes: Adds matter conversion to/from neodymium.

### [Muluna, Moon of Nauvis](https://mods.factorio.com/mod/planet-muluna)

- Brings stack sizes in line with Krastorio's defaults.
- Adds compatibility between Muluna's thruster productivity technology and [K2SO Thruster Recipes Revert](https://mods.factorio.com/mod/k2so-thruster-fix) for those who use it.
- (Optional) Additional Matter Recipes: Adds matter conversion to/from alumina.

### [Paracelsin](https://mods.factorio.com/mod/Paracelsin)

- If xyrc's mod is installed, and its electrochemical plant changes are active, the electrochemical plant will also benefit from the crafting category consistency changes this mod makes.
- Brings stack sizes in line with Krastorio's defaults.

### [Pelagos](https://mods.factorio.com/mod/pelagos)

- Brings stack sizes in line with Krastorio's defaults.
- Adds a new technology and recipe to allow growing coconuts in greenhouses. Similar to Gleba's technology/recipe.
- Updates Corrosive Rifle Magazines to fit in line with Krastorio's ammo. New name, icon, buffed damage (8 -> 10), increased magazine size (10 -> 30). Requires K2 rifle ammo instead of pistol ammo.
- Updates the Heavy Gun Turret to fit in line with Krastorio's changes to turrets. Slightly buffed range (25 -> 28), more health (1200 -> 1500), somewhat slower firing rate (2 -> 3), better scaling with physical damage technologies (matches K2's gun turret scaling).
- Allows Pelagos' landfill productivity research to affect Krastorio (and other modded) landfill recipes.
- Adds a Krastorio-style equipment grid to cargo and tanker ships.
- Cultivation productivity now affects piranha roe from Carnova.

### [Planetaris: Arig](https://mods.factorio.com/mod/planetaris-arig)

- Replaced Planetaris glass and quartz with standard Krastorio resources. Recipes and progression on Arig remain unchanged.
- Quarts productivity research affects Krastorio quartz production.
- Allows converting sand from the surface (fluid) into sand (the item) via sifting.
- After cargo dropping has been researched, metallurgic machines can be dropped which allow direct smelting glass panes via pure sand.
- Brings stack sizes in line with Krastorio's defaults.
- Updates the Arig roboport to fit in line with Krastorio's roboport changes.

### [Planetaris: Hyarion](https://mods.factorio.com/mod/planetaris-hyarion)

- Restricted Krastorio's fusion reactor from functioning on the surface.
- Rebalanced the Ruby Laser Turret with K2's values in mind.
- **Crushing Industry**: Allow bismuth asteroids to be crushed in basic crushers.
- Brings stack sizes in line with Krastorio's defaults.

### [Rubia](https://mods.factorio.com/mod/rubia)

- Makes K2SO's railgun turrets deal Rubia's kinetic damage instead of physical damage.
