---Get name of block by coordinates.
---@param x number
---@param y number
---@param z number
---@return string
function block.get_name(x,y,z)
  return block.name(block.get(x,y,z));
end

---Set block by name, not id.
---@param x number
---@param y number
---@param z number
---@param name string Name of block.
function block.set_with_name(x,y,z,name)
  return block.set(x,y,z,block.index(name))
end