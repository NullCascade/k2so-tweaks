local util_inserter = {}

---@param name string
---@param value number
function util_inserter.set_max_belt_stack_size(name, value)
    local prototype = data.raw["inserter"][name]
    if (not prototype) then
        return
    end

    prototype.max_belt_stack_size = value
end

return util_inserter