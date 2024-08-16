--- создает единичную матрицу
function mat4.idt() return mat4.idt() end

--- записывает единичную матрицу в dst
---@param dst table
function mat4.idt(dst) return mat4.idt(dst) end

--- вычисляет определитель матрицы
---@param m table
function mat4.determinant(m) return mat4.determinant(m) end

--- создает матрицу вращения по кватерниону
---@param quaternion table
function mat4.from_quat(quaternion) return mat4.from_quat(quaternion) end

--- записывает матрицу вращения по кватерниону в dst
---@param quaternion table
---@param dst table
function mat4.from_quat(quaternion,dst) return mat4.from_quat(quaternion,dst) end

--- возвращает результат умножения матриц
---@param a table
---@param b table
function mat4.mul(a,b) return mat4.mul(a,b) end

--- записывает результат умножения матриц в dst
---@param a table
---@param b table
---@param dst table
function mat4.mul(a,b,dst) return mat4.mul(a,b,dst) end

--- возвращает результат умножения матрицы и вектора
---@param a table
---@param v table
function mat4.mul(a,v) return mat4.mul(a,v) end

--- записывает результат умножения матрицы и вектора в dst
---@param a table
---@param v table
---@param dst table
function mat4.mul(a,v,dst) return mat4.mul(a,v,dst) end

--- возвращает результат инверсии матрицы
---@param m table
function mat4.inverse(m) return mat4.inverse(m) end

--- записывает результат инверсии матрицы в dst
---@param m table
---@param dst table
function mat4.inverse(m,dst) return mat4.inverse(m,dst) end

--- возвращает результат транспонирования матрицы
---@param m table
function mat4.transpose(m) return mat4.transpose(m) end

--- записывает результат транспонирования матрицы в dst
---@param m table
---@param dst table
function mat4.transpose(m,dst) return mat4.transpose(m,dst) end

--- создает матрицу смещения
---@param translation table
function mat4.translate(translation) return mat4.translate(translation) end

--- возвращает результат применения смещения к матрице m
---@param m table
---@param translation table
function mat4.translate(m,translation) return mat4.translate(m,translation) end

--- записывает результат применения смещения к матрице m в dst
---@param m table
---@param translation table
---@param dst table
function mat4.translate(m,translation,dst) return mat4.translate(m,translation,dst) end

--- создает матрицу масштабирования
---@param scale table
function mat4.scale(scale) return mat4.scale(scale) end

--- возвращает результат применения масштабирования к матрице m
---@param m table
---@param scale table
function mat4.scale(m,scale) return mat4.scale(m,scale) end

--- записывает результат применения масштабирования к матрице m в dst
---@param m table
---@param scale table
---@param dst table
function mat4.scale(m,scale,dst) return mat4.scale(m,scale,dst) end

--- создает матрицу поворота (angle - угол поворота) по заданной оси (axis - единичный вектор)
---@param axis table
---@param angle number
function mat4.rotate(axis,angle) return mat4.rotate(axis,angle) end

--- возвращает результат применения вращения к матрице m
---@param m table
---@param axis table
---@param angle number
function mat4.rotate(m,axis,angle) return mat4.rotate(m,axis,angle) end

--- записывает результат применения вращения к матрице m в dst
---@param m table
---@param axis table
---@param angle number
---@param dst table
function mat4.rotate(m,axis,angle,dst) return mat4.rotate(m,axis,angle,dst) end

---Раскладывает матрицу трансформации на составляющие.
---@param m table
---@return table
function mat4.decompose(m) return mat4.decompose(m) end

--- cоздает матрицу вида с точки 'eye' на точку 'center', где вектор 'up' определяет верх.
---@param eye table
---@param center table
---@param up table
function mat4.look_at(eye,center,up) return mat4.look_at(eye,center,up) end

--- записывает матрицу вида в dst
---@param eye table
---@param center table
---@param up table
---@param dst table
function mat4.look_at(eye,center,up,dst) return mat4.look_at(eye,center,up,dst) end

--- возвращает строку представляющую содержимое матрицы
---@param m table
function mat4.tostring(m) return mat4.tostring(m) end

--- возвращает строку представляющую содержимое матрицы, многострочную, если multiline = true
---@param m table
---@param multiline boolean
function mat4.tostring(m,multiline) return mat4.tostring(m,multiline) end