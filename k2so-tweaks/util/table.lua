local util_table = {}

--- @param t table
--- @return table
function util_table.keys(t)
	local keys = {}
	for k, _ in pairs(t) do
		table.insert(keys, k)
	end
	return keys
end

--- @param t table
--- @return number
function util_table.size(t)
	local size = 0
	for k, _ in pairs(t) do
		size = size + 1
	end
	return size
end

--- Clears all data from a table.
--- @param t table
function util_table.clear(t)
	local keys = util_table.keys(t)
	for _, k in ipairs(keys) do
		t[k] = nil
	end
end

--- Determines if a table contains a given value.
--- @param t table The table to search.
--- @param value any The value to search for.
--- @return boolean contained Set if the value is contained in the given table.
function util_table.contains(t, value)
	return util_table.find(t, value) ~= nil
end

--- Returns the first (arbitrary) key for a given value.
--- @param t table The table to search.
--- @param value any The value to search for.
--- @return any key key associated with the given value.
function util_table.find(t, value)
	for i, v in pairs(t) do
		if (v == value) then
			return i
		end
	end
end

--- Inserts a value into a table, if it doesn't already exist as a value.
--- @param t table
--- @param value any
function util_table.insert_unique(t, value)
	if (util_table.contains(t, value)) then
		return false
	end
	table.insert(t, value)
	return true
end

--- Returns true if a table has all the keys/values matched.
--- @param t any
--- @param keyvalues any
--- @return boolean
function util_table.has_keyvalues(t, keyvalues)
	for k, v in pairs(keyvalues) do
		if (t[k] ~= v) then
			return false
		end
	end
	return true
end

--- Removes the first (arbitrary) instance of a value in a given table.
--- @param t table The table to modify.
--- @param value any The value to remove.
--- @return boolean success True if the value was successfully removed.
function util_table.remove_value(t, value)
	local i = util_table.find(t, value)
	if (i ~= nil) then
		table.remove(t, i)
		return true
	end
	return false
end

--- Gets the index of an array-style table where a value contains a specific sub-key matching a value.
--- @param t table[]
--- @param key any
--- @param value any
--- @return integer?
function util_table.get_index_with_keyvalue(t, key, value)
	for i, entry in ipairs(t) do
		if (entry[key] == value) then
			return i
		end
	end
end

--- Gets the index of an array-style table where a value contains multiple specific sub-key matching their given values.
--- @param t table[]
--- @param keyvalues table
--- @return integer?
function util_table.get_index_with_keyvalues(t, keyvalues)
	for i, entry in ipairs(t) do
		if (util_table.has_keyvalues(entry, keyvalues)) then
			return i
		end
	end
end

--- Removes an entry in an array whose sub-keys equals given values.
--- @param t table[]
--- @param keyvalues table
--- @return boolean
function util_table.remove_with_keyvalues(t, keyvalues)
	local entry = util_table.get_index_with_keyvalues(t, keyvalues)
	if (not entry) then
		return false
	end

	table.remove(t, entry)
	return true
end

--- Removes an entry in an array whose sub-key equals a value.
--- @param t table[]
--- @param key any
--- @param value any
--- @return boolean
function util_table.remove_with_keyvalue(t, key, value)
	local entry = util_table.get_index_with_keyvalue(t, key, value)
	if (not entry) then
		return false
	end

	table.remove(t, entry)
	return true
end

--- Returns true if all keys/values in a can be found in b.
--- @param a any
--- @param b any
function util_table.match_all(a, b)
	for k, v in pairs(a) do
		if (type(v) == "table") then
			return util_table.match_all(v, k[v])
		elseif (b[k] ~= v) then
			return false
		end
	end
end

return util_table

