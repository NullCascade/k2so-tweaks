local util = {}

util.accumulator = require("k2so-tweaks.util.accumulator")
util.ammo = require("k2so-tweaks.util.ammo")
util.assembler = require("k2so-tweaks.util.assembler")
util.autoplace = require("k2so-tweaks.util.autoplace")
util.data = require("k2so-tweaks.util.data")
util.fluid = require("k2so-tweaks.util.fluid")
util.graphics = require("k2so-tweaks.util.graphics")
util.ingredient = require("k2so-tweaks.util.ingredient")
util.inserter = require("k2so-tweaks.util.inserter")
util.item = require("k2so-tweaks.util.item")
util.lab = require("k2so-tweaks.util.lab")
util.loader = require("k2so-tweaks.util.loader")
util.log = require("k2so-tweaks.util.log")
util.matter = require("k2so-tweaks.util.matter")
util.minable = require("k2so-tweaks.util.minable")
util.patch = require("k2so-tweaks.util.patch")
util.projectile = require("k2so-tweaks.util.projectile")
util.recipe = require("k2so-tweaks.util.recipe")
util.recycling = require("k2so-tweaks.util.recycling")
util.string = require("k2so-tweaks.util.string")
util.surface = require("k2so-tweaks.util.surface")
util.table = require("k2so-tweaks.util.table")
util.technology = require("k2so-tweaks.util.technology")
util.tile = require("k2so-tweaks.util.tile")
util.trigger = require("k2so-tweaks.util.trigger")

util.factorio = require("__core__.lualib.util")

--- @param key string
--- @param value any
--- @param default any?
--- @return boolean
function util.setting_equal(key, value, default)
    local var = settings.startup[key]
    local val = var and var.value or default
    return val == value
end

return util