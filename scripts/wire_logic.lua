function on_placed(x, y, z, playerid)
	wire_update(x, y, z)
end

function on_use(tps)
	print("meow!")
end

function on_update(x, y, z)
	wire_update(x, y, z)
end

function wire_update(x, y, z)
	print("got update on",x,y,z)
	print("listing all blocks...")
	function is_block_connectable(x, y, z)
		local blockname = block.name(block.get(x,y,z))
		--local connectable = false
		if blockname:sub(1, 31) == "electrical_age_lite:copper_wire" then return true end
		if blockname:sub(1, 28) == "electrical_age_lite:tin_wire" then return true end
		if blockname:sub(1, 28) == "electrical_age_lite:machine_" then return true end
		if blockname:sub(1, 30) == "electrical_age_lite:generator_" then return true end
		return false
	end
	local blockname = block.name(block.get(x,y,z))
	local new_block = ""
	if blockname:sub(1, 31) == "electrical_age_lite:copper_wire" then new_block = "electrical_age_lite:copper_wire" end
	if blockname:sub(1, 28) == "electrical_age_lite:tin_wire" then new_block = "electrical_age_lite:tin_wire" end
	local connected = false
	if is_block_connectable(x-1, y, z) then new_block = new_block.."_left" connected = true end
	if is_block_connectable(x+1, y, z) then new_block = new_block.."_right" connected = true end
	if is_block_connectable(x, y-1, z) then new_block = new_block.."_bottom" connected = true end
	if is_block_connectable(x, y+1, z) then new_block = new_block.."_top" connected = true end
	if is_block_connectable(x, y, z-1) then new_block = new_block.."_back" connected = true end
	if is_block_connectable(x, y, z+1) then new_block = new_block.."_front" connected = true end
	if connected == false then new_block = new_block.."_center" end
	print("setting new block...")
	if new_block ~= blockname then
		block.set(x, y, z, block.index(new_block))
	end
	print("ready "..new_block)
end