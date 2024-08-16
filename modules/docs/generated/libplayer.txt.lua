--- Возвращает x, y, z координаты игрока
---@param playerid number
---@return {[1]:number,[2]:number,[3]:number}
function player.get_pos(playerid) return player.get_pos(playerid) end

--- Устанавливает x, y, z координаты игрока
---@param playerid number
---@param x number
---@param y number
---@param z number
function player.set_pos(playerid,x,y,z) return player.set_pos(playerid,x,y,z) end

---Возвращает x, y, z линейной скорости игрока
---@param playerid number
---@return {[1]:number,[2]:number,[3]:number}
function player.get_vel(playerid) return player.get_vel(playerid) end

---Устанавливает x, y, z линейной скорости игрока
---@param playerid number
---@param x number
---@param y number
---@param z number
function player.set_vel(playerid,x,y,z) return player.set_vel(playerid,x,y,z) end

---Возвращает x, y, z вращения камеры (в радианах)
---@param playerid number
---@return {[1]:number,[2]:number,[3]:number}
function player.get_rot(playerid) return player.get_rot(playerid) end

---Устанавливает x, y вращения камеры (в радианах)
---@param playerid number
---@param x number
---@param y number
---@param z number
function player.set_rot(playerid,x,y,z) return player.set_rot(playerid,x,y,z) end

---Возвращает id инвентаря игрока и индекс выбранного слота (от 0 до 9)
---@param playerid number
---@return {[1]:number,[2]:number}
function player.get_inventory(playerid) return player.get_inventory(playerid) end

---Геттер режима полета
---@return boolean
function player.is_flight() return player.is_flight() end

---Сеттер режима полета
---@param bool boolean
function player.set_flight(bool) return player.set_flight(bool) end

---Геттер noclip режима (выключенная коллизия игрока)
---@return boolean
function player.is_noclip() return player.is_noclip() end

---Сеттер noclip режима (выключенная коллизия игрока)
---@param bool boolean
function player.set_noclip(bool) return player.set_noclip(bool) end

---Сеттер точки спавна игрока
---@param playerid number
---@param x number
---@param y number
---@param z number
function player.set_spawnpoint(playerid,x,y,z) return player.set_spawnpoint(playerid,x,y,z) end

---Геттер точки спавна игрока
---@param playerid number
---@return {[1]:number,[2]:number,[3]:number}
function player.get_spawnpoint(playerid) return player.get_spawnpoint(playerid) end

---Возвращает координаты выделенного блока, либо nil
---@param playerid number
---@return {[1]:number,[2]:number,[3]:number}
function player.get_selected_block(playerid) return player.get_selected_block(playerid) end

---Возвращает уникальный идентификатор сущности, на которую нацелен игрок
---@param playerid number
---@return number
function player.get_selected_entity(playerid) return player.get_selected_entity(playerid) end

---Возвращает уникальный идентификатор сущности игрока
---@param playerid number
---@return number
function player.get_entity(playerid) return player.get_entity(playerid) end