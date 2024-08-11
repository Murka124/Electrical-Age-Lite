local eal_constants = require("electrical_age_lite:constants")
local string_extensions = require("electrical_age_lite:string_extensions")

function on_placed(x, y, z, playerid)
	wire_update(x, y, z)
end

function on_update(x, y, z)
	wire_update(x, y, z)
end

-- константы
local connectables = get_constants().wire_connectables --список подключаемых блоков
local materials = get_constants().wire_materials --список материалов для провода

function wire_update(x, y, z)
	-- функция для проверки 
	function is_block_connectable(x, y, z)
		local blockname = block.name(block.get(x,y,z)) --имя нужного блока
		--если нужный блок является подключаемым (префикс совпадает с одним из списка подключаемых блоков)
		for k, v in pairs(connectables) do --то блок считается подключаемым (true)
			if blockname:startsWith("electrical_age_lite:"..v) then return true end
		end
		return false
	end

	--конструируем новое имя провода. нужно узнать материал, из которого сделан текущий провод
	local blockname = block.name(block.get(x,y,z)) --имя текущего блока
	local new_block = "" --переменная-держатель нового названия
	--ищем материал текущего провода из его названия
	for k, v in pairs(materials) do
		if blockname:startsWith("electrical_age_lite:wire_"..v) then new_block = "electrical_age_lite:wire_"..v end
		--нашли материал, теперь new_block принимает вид "electrical_age_lite:wire_%материал%"
	end

	if is_block_connectable(x-1, y, z) then new_block = new_block.."_left" end
	if is_block_connectable(x+1, y, z) then new_block = new_block.."_right" end
	if is_block_connectable(x, y-1, z) then new_block = new_block.."_bottom" end
	if is_block_connectable(x, y+1, z) then new_block = new_block.."_top" end
	if is_block_connectable(x, y, z-1) then new_block = new_block.."_back" end
	if is_block_connectable(x, y, z+1) then new_block = new_block.."_front" end
	--добавляем в конец "_center"
	new_block = new_block.."_center"

	--если заново сконструированное имя блока не совпадает, обновляем текущий блок
	if new_block ~= blockname then
		block.set(x, y, z, block.index(new_block))
	end
end