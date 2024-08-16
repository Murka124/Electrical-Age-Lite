--- Возвращает строковый id блока по его числовому id.
---@param blockid number
---@return string
function block.name(blockid) return block.name(blockid) end

--- Возвращает числовой id блока, принимая в качестве агрумента строковый
---@param name string
---@return number
function block.index(name) return block.index(name) end

--- Возвращает id материала блока.
---@param blockid number
---@return string
function block.material(blockid) return block.material(blockid) end

--- Возвращает название блока, отображаемое в интерфейсе.
---@param blockid number
---@return string
function block.caption(blockid) return block.caption(blockid) end

--- Возвращает числовой id блока на указанных координатах.
--- Если чанк на указанных координатах не загружен, возвращает -1.
---@param x number
---@param y number
---@param z number
---@return number
function block.get(x,y,z) return block.get(x,y,z) end

--- Возвращает полное состояние (поворот + сегмент + доп. информация) в виде целого числа
---@param x number
---@param y number
---@param z number
---@return number
function block.get_states(x,y,z) return block.get_states(x,y,z) end

--- Устанавливает блок с заданным числовым id и состоянием (0 - по-умолчанию) на заданных координатах.
---@param x number
---@param y number
---@param z number
---@param id number
---@param states number
function block.set(x,y,z,id,states) return block.set(x,y,z,id,states) end

--- Устанавливает блок с заданным числовым id и состоянием (0 - по-умолчанию) на заданных координатах
--- от лица игрока, вызывая событие on_placed.
--- playerid не является обязательным
---@param x number
---@param y number
---@param z number
---@param id number
---@param states number
---@param playerid number
function block.place(x,y,z,id,states,playerid) return block.place(x,y,z,id,states,playerid) end

--- Ломает блок на заданных координатах от лица игрока, вызывая событие on_broken.
--- playerid не является обязательным
---@param x number
---@param y number
---@param z number
---@param playerid number
function block.destruct(x,y,z,playerid) return block.destruct(x,y,z,playerid) end

--- Собирает полное состояние в виде целого числа
---@param state table
---@return number
function block.compose_state(state) return block.compose_state(state) end

--- Разбирает полное состояние на: вращение, сегмент, пользовательские биты
---@param state number
---@return table
function block.decompose_state(state) return block.decompose_state(state) end

--- Проверяет, является ли блок на указанных координатах полным
---@param x number
---@param y number
---@param z number
---@return boolean
function block.is_solid_at(x,y,z) return block.is_solid_at(x,y,z) end

--- Проверяет, можно ли на заданных координатах поставить блок 
--- (примеры: воздух, трава, цветы, вода)
---@param x number
---@param y number
---@param z number
---@return boolean
function block.is_replaceable_at(x,y,z) return block.is_replaceable_at(x,y,z) end

--- Возвращает количество id доступных в загруженном контенте блоков
---@return number
function block.defs_count() return block.defs_count() end

--- Возвращает числовой id предмета, указанного в свойстве *picking-item*.
---@param id number
---@return number
function block.get_picking_item(id) return block.get_picking_item(id) end

--- Возвращает таблицу с информацией о луче.
--- Возвращает целочисленный единичный вектор X блока на указанных координатах с учётом его вращения (три целых числа).
--- Если поворот отсутствует, возвращает 1, 0, 0
---@param start table
---@param dir table
---@param max_distance number
---@param dest table
---@return table
function block.raycast(start,dir,max_distance,dest) return block.raycast(start,dir,max_distance,dest) end

--- То же, но для оси Y (по-умолчанию 0, 1, 0)
---@param x number
---@param y number
---@param z number
---@return {[1]:number,[2]:number,[3]:number}
function block.get_Y(x,y,z) return block.get_Y(x,y,z) end

--- То же, но для оси Z (по-умолчанию 0, 0, 1)
---@param x number
---@param y number
---@param z number
---@return {[1]:number,[2]:number,[3]:number}
function block.get_Z(x,y,z) return block.get_Z(x,y,z) end

--- Возвращает индекс поворота блока в его профиле вращения (не превышает 7).
---@param x number
---@param y number
---@param z number
---@return number
function block.get_rotation(x,y,z) return block.get_rotation(x,y,z) end

--- Устанавливает вращение блока по индексу в его профиле вращения.
---@param x number
---@param y number
---@param z number
---@param rotation number
function block.set_rotation(x,y,z,rotation) return block.set_rotation(x,y,z,rotation) end

--- Возвращает имя профиля вращения (none/pane/pipe)
---@param id number
---@return string
function block.get_rotation_profile(id) return block.get_rotation_profile(id) end

--- Проверяет, является ли блок расширенным.
---@param id number
---@return boolean
function block.is_extended(id) return block.is_extended(id) end

--- Возвращает размер блока.
---@param id number
---@return {[1]:number,[2]:number,[3]:number}
function block.get_size(id) return block.get_size(id) end

--- Проверяет является ли блок сегментом расширенного блока, не являющимся главным.
---@param x number
---@param y number
---@param z number
---@return boolean
function block.is_segment(x,y,z) return block.is_segment(x,y,z) end

--- Возвращает позицию главного сегмента расширенного блока или исходную позицию,
--- если блок не является расширенным.
---@param x number
---@param y number
---@param z number
---@return {[1]:number,[2]:number,[3]:number}
function block.seek_origin(x,y,z) return block.seek_origin(x,y,z) end

--- Возвращает выбранное число бит с указанного смещения в виде целого беззнакового числа
---@param x number
---@param y number
---@param z number
---@param offset number
---@param bits number
---@return number
function block.get_user_bits(x,y,z,offset,bits) return block.get_user_bits(x,y,z,offset,bits) end

--- Записывает указанное число бит значения value в user bits по выбранному смещению
---@param x number
---@param y number
---@param z number
---@param offset number
---@param bits number
---@param value number
---@return number
function block.set_user_bits(x,y,z,offset,bits,value) return block.set_user_bits(x,y,z,offset,bits,value) end

--- Возвращает массив из двух векторов (массивов из 3 чисел):
--- 1. Минимальная точка хитбокса
--- 2. Размер хитбокса
--- rotation_index - индекс поворота блока
---@param id number
---@param rotation_index number
---@return table
function block.get_hitbox(id,rotation_index) return block.get_hitbox(id,rotation_index) end

--- возвращает тип модели блока (block/aabb/custom/...)
---@param id number
---@return string
function block.get_model(id) return block.get_model(id) end

--- возвращает массив из 6 текстур, назначенных на стороны блока
---@param id number
---@return table
function block.get_textures(id) return block.get_textures(id) end