--- Возвращает сущность по уникальному идентификатору
--- Возвращаемая таблица - та же, что доступна в компонентах сущности.
---@param uid number
---@return table
function entities.get(uid) return entities.get(uid) end

--- Создает указанную сущность.
--- args - таблица таблиц параметров компонентов (переменная ARGS)
--- args не является обязательным
--- структура args:
--- {префикс__имя={...}, ...}
--- префикс - id пака
--- имя - название компонента
--- префикс и имя компонента разделяются двумя подчеркиваниями
---@param name string
---@param pos table
---@param args table
function entities.spawn(name,pos,args) return entities.spawn(name,pos,args) end

--- Проверяет наличие сущности по уникальному идентификатору.
---@param uid number
---@return boolean
function entities.exists(uid) return entities.exists(uid) end

--- Возвращает индекс определения сущности по UID
---@param uid number
---@return number
function entities.get_def(uid) return entities.get_def(uid) end

--- Возвращает имя определения сущности по индексу (строковый ID).
---@param id number
---@return string
function entities.def_name(id) return entities.def_name(id) end

--- Возвращает индекс определения сущности по имени (числовой ID).
---@param name string
---@return number
function entities.def_index(name) return entities.def_index(name) end

--- Возвращает число доступных определений сущностей
---@return number
function entities.defs_count() return entities.defs_count() end

--- Возвращает таблицу всех загруженных сущностей
---@return table
function entities.get_all() return entities.get_all() end

--- Возвращает таблицу загруженных сущностей по переданному списку UID
---@param uids table
---@return table
function entities.get_all(uids) return entities.get_all(uids) end

--- Возвращает список UID сущностей, попадающих в прямоугольную область
--- pos - минимальный угол области
--- size - размер области
---@param pos table
---@param size table
---@return table
function entities.get_all_in_box(pos,size) return entities.get_all_in_box(pos,size) end

--- Возвращает список UID сущностей, попадающих в радиус
--- center - центр области
--- radius - радиус области
---@param center table
---@param radius number
---@return table
function entities.get_all_in_radius(center,radius) return entities.get_all_in_radius(center,radius) end

--- Возвращает таблицу с результатами если луч качается блока, либо сущности.
---@param start table
---@param dir table
---@param max_distance number
---@param ignore number
---@param destination table
---@return table
function entities.raycast(start,dir,max_distance,ignore,destination) return entities.raycast(start,dir,max_distance,ignore,destination) end