local eal_constants = require("electrical_age_lite:constants")
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
			if blockname:sub(1,#("electrical_age_lite:"..v)) == "electrical_age_lite:"..v then return true end
		end
		return false
	end

	--конструируем новое имя провода. нужно узнать материал, из которого сделан текущий провод
	local blockname = block.name(block.get(x,y,z)) --имя текущего блока
	local new_block = "" --переменная-держатель нового названия
	--ищем материал текущего провода из его названия
	for k, v in pairs(materials) do
		if blockname:sub(1,#("electrical_age_lite:wire_"..v)) == "electrical_age_lite:wire_"..v then new_block = "electrical_age_lite:wire_"..v end
		--нашли материал, теперь new_block принимает вид "electrical_age_lite:wire_%материал%"
	end

	local connected = false --переменная-держатель состояния подключенности, нужна для правильного конструирования одиночного провода
	--пошла лесенка из проверок. здесь провод проверяет, можно ли подключиться к соседним блокам
	if is_block_connectable(x-1, y, z) then new_block = new_block.."_left" connected = true end
	if is_block_connectable(x+1, y, z) then new_block = new_block.."_right" connected = true end
	if is_block_connectable(x, y-1, z) then new_block = new_block.."_bottom" connected = true end
	if is_block_connectable(x, y+1, z) then new_block = new_block.."_top" connected = true end
	if is_block_connectable(x, y, z-1) then new_block = new_block.."_back" connected = true end
	if is_block_connectable(x, y, z+1) then new_block = new_block.."_front" connected = true end
	--вот и пригодилась наша переменная-держатель. если подключаемых блоков вокруг не обнаружено, добавляем префикс "_center"
	--(потому что "wire_%материал%" занят предметом)
	if connected == false then new_block = new_block.."_center" end

	--если заново сконструированное имя блока не совпадает, обновляем текущий блок
	if new_block ~= blockname then
		block.set(x, y, z, block.index(new_block))
	end
end