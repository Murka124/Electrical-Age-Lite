--- создает кватернион на основе матрицы вращения
---@param m table
function quat.from_mat4(m) return quat.from_mat4(m) end

--- записывает кватернион по матрице вращения в dst
---@param m table
---@param dst table
function quat.from_mat4(m,dst) return quat.from_mat4(m,dst) end

--- создает кватернион как интерполяцию между a и b, 
--- где t - фактор интерполяции
---@param a table
---@param b table
---@param t number
function quat.slerp(a,b,t) return quat.slerp(a,b,t) end

--- записывает кватернион как интерполяцию между a и b в dst, 
--- где t - фактор интерполяции
---@param a table
---@param b table
---@param t number
---@param dst table
function quat.slerp(a,b,t,dst) return quat.slerp(a,b,t,dst) end

--- возвращает строку представляющую содержимое кватерниона
---@param q table
function quat.tostring(q) return quat.tostring(q) end