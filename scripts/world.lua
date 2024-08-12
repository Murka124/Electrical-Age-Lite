local gui_information_updater = require("electrical_age_lite:gui_information_updater")
local blocks_list = require("electrical_age_lite:blocks_list")
local constants_lib = require("electrical_age_lite:constants")
local constants = get_constants()

local list = {}
local packid = "electrical_age_lite"

function on_world_open()
    --создаём папку с модом если не создана
    file.mkdirs("world:data/" .. packid .. "/")
    --создаём список блоков если не создан
    if not file.exists("world:data/" .. packid .. "/list.json") then
        file.write("world:data/" .. packid .. "/list.json", "{}")
    end
    list = json.parse(file.read("world:data/" .. packid .. "/list.json"))
    set_list(list)
end

local gen_upd = require("electrical_age_lite:generator_update")
function on_blocks_tick(tps)
    -- print("world tick", get_current_block())

    --обновляем информацию на экране
    --ой щас говнокод будеет...
    local x, y, z, _ = get_current_block()
    if x ~= nil then
        if block.name(block.get(x, y, z)):startsWith("electrical_age_lite:generator_thermo") then
            local doc = Document.new("electrical_age_lite:generator_thermo")
            local data = get_block_data(x, y, z)
            local energy_level = data.energy_bank_value
            doc["energy_text"].text = energy_level.."/"..data.energy_bank_max_value.." vce"
            -- if energy_level > 0 then
                -- doc["energy_bar"].visible = true
                -- doc["energy_bar"].gravity = "center-left"
                doc["energy_bar"].size = {doc["energy_bar"].size[1], math.floor(data.energy_bar_max_value-data.energy_bar_max_value*(energy_level/data.energy_bank_max_value))}
            --     -- print("height",math.floor(data.energy_bar_max_value-data.energy_bar_max_value*(energy_level/data.energy_bank_max_value)), doc["energy_bar"].size[2])
            -- end
            local process_level = data.current_process_time
            doc["process_text"].text = string.format(math.ceil(process_level/2)/10).." сек"
            if process_level > 0 then
                doc["process_bar"].visible = true
                -- print(data.process_bar_max_value*(process_level/data.max_process_time))
                doc["process_bar"].size = {math.floor(data.process_bar_max_value*(process_level/data.max_process_time)), doc["process_bar"].size[2]}
            else
                doc["process_bar"].visible = false
            end
            -- set_block_data(x, y, z, "current_process_time", math.random(data.max_process_time))
            -- set_block_data(x, y, z, "energy_bank_value", math.random(data.energy_bank_max_value))
        end
    end

    --проходимся по всем генераторам в списке и заставляем их вырабатывать энергию
    local generators = {"electrical_age_lite:generator_thermo"}
    for k, v in pairs(list) do
        if v.name:startsWith(generators[1]) then
            update_generator(v.x, v.y, v.z)
        end
    end

    --начинаем трансфер энергии. снова проходимся по всем генераторам и заставляем их отдавать энергию.
end

function on_world_save()
    write_list()
end

function on_world_quit()
    write_list()
end

function write_list()
    file.write("world:data/" .. packid .. "/list.json", json.tostring(get_list()))
end