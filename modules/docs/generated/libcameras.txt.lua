--- Возвращает камеру по имени.
---@param name string
---@return number
function cameras.get(name) return cameras.get(name) end

--- возвращает индекс камеры
---@return number
function cam:get_index() return cam:get_index() end

--- возвращает имя камеры
---@return string
function cam:get_name() return cam:get_name() end

--- возвращает позицию камеры
---@return table
function cam:get_pos() return cam:get_pos() end

--- устанавливает позицию камеры
---@param pos table
function cam:set_pos(pos) return cam:set_pos(pos) end

--- возращает вращение камеры
---@return table
function cam:get_rot() return cam:get_rot() end

--- устанавливает вращение камеры
---@param rot table
function cam:set_rot(rot) return cam:set_rot(rot) end

--- возвращает значение приближения камеры
---@return number
function cam:get_zoom() return cam:get_zoom() end

--- устанавливает значение приближения камеры
---@param zoom number
function cam:set_zoom(zoom) return cam:set_zoom(zoom) end

--- возвращает угол поля зрения камеры по Y (в градусах)
---@return number
function cam:get_fov() return cam:get_fov() end

--- устанавливает угол поля зрения камеры по Y (в градусах)
---@param fov number
function cam:set_fov(fov) return cam:set_fov(fov) end

--- возвращает true если ось Y отражена
---@return boolean
function cam:is_flipped() return cam:is_flipped() end

--- отражает ось Y при значении true
---@param flipped boolean
function cam:set_flipped(flipped) return cam:set_flipped(flipped) end

--- проверяет, включен ли режим перспективы
---@return boolean
function cam:is_perspective() return cam:is_perspective() end

--- включает/выключает режим перспективы
---@param perspective boolean
function cam:set_perspective(perspective) return cam:set_perspective(perspective) end

--- возвращает вектор направления камеры
---@return table
function cam:get_front() return cam:get_front() end

--- возвращает вектор направления направо
---@return table
function cam:get_right() return cam:get_right() end

--- возвращает вектор направления вверх
---@return table
function cam:get_up() return cam:get_up() end

--- направляет камеру на заданную точку
---@param point table
function cam:look_at(point) return cam:look_at(point) end

--- направляет камеру на заданную точку с фактором интерполяции
---@param point table
---@param t number
function cam:look_at(point,t) return cam:look_at(point,t) end