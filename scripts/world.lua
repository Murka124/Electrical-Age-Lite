local gui_information_updater = require("electrical_age_lite:gui_information_updater")
local blocks_list = require("electrical_age_lite:blocks_list")
local constants_lib = require("electrical_age_lite:constants")
local constants = get_constants()
require "electrical_age_lite:machine_update"
require "electrical_age_lite:table_copy"

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
            doc["energy_text"].text = energy_level .. "/" .. data.energy_bank_max_value .. " vce"
            -- if energy_level > 0 then
            -- doc["energy_bar"].visible = true
            -- doc["energy_bar"].gravity = "center-left"
            doc["energy_bar"].size = { doc["energy_bar"].size[1], math.floor(data.energy_bar_max_value -
                data.energy_bar_max_value * (energy_level / data.energy_bank_max_value)) }
            --     -- print("height",math.floor(data.energy_bar_max_value-data.energy_bar_max_value*(energy_level/data.energy_bank_max_value)), doc["energy_bar"].size[2])
            -- end
            local process_level = data.current_process_time
            doc["process_text"].text = string.format(math.ceil(process_level / 2) / 10) .. " сек"
            if process_level > 0 then
                doc["process_bar"].visible = true
                -- print(data.process_bar_max_value*(process_level/data.max_process_time))
                doc["process_bar"].size = { math.floor(data.process_bar_max_value *
                    (process_level / data.max_process_time)),
                    doc["process_bar"].size[2] }
            else
                doc["process_bar"].visible = false
            end
            -- set_block_data(x, y, z, "current_process_time", math.random(data.max_process_time))
            -- set_block_data(x, y, z, "energy_bank_value", math.random(data.energy_bank_max_value))
        end
    end

    --проходимся по всем генераторам в списке и заставляем их вырабатывать энергию
    local generators = { "electrical_age_lite:generator_thermo", "electrical_age_lite:generator_solar" }
    for k, v in pairs(list) do
        for _, generator in pairs(generators) do
            if v.name:startsWith(generator) then
                update_generator(v.x, v.y, v.z)
            end
        end
    end



    --начинаем трансфер энергии. снова проходимся по всем генераторам и заставляем их отдавать энергию во все стороны
    for k, v in pairs(list) do
        for _, generator in pairs(generators) do
            -- print("\n\n\n\n")
            if v.name:startsWith(generator) then --проходимся по каждому генератору
                local directions = {
                    { 1,  0,  0 },
                    { -1, 0,  0 },
                    { 0,  1,  0 },
                    { 0,  -1, 0 },
                    { 0,  0,  1 },
                    { 0,  0,  -1 }
                }
                local wires = {}            -- {"xXyYzZ = true"}
                local paths_to_process = {} -- {{1,2,3}, {4,5,6}}
                local curx, cury, curz = v.x, v.y, v.z
                local cur_energy = generator_drain_energy(curx, cury, curz, v.data.max_energy_out, false)
                local initial_energy = cur_energy

                function wireFlow(loopx, loopy, loopz)
                    if loopx == nil then return nil end
                    for idx, dirtable in pairs(directions) do --перебираем все стороны вокруг текущего блока
                        local blockname = block.name(block.get(loopx + dirtable[1], loopy + dirtable[2],
                            loopz + dirtable[3]))
                        if blockname == nil then return nil end
                        if blockname:startsWith("electrical_age_lite:wire") and not wires["x" .. loopx + dirtable[1] .. "y" .. loopy + dirtable[2] .. "z" .. loopz + dirtable[3]] then
                            paths_to_process[#paths_to_process + 1] = { loopx + dirtable[1], loopy + dirtable[2], loopz +
                            dirtable[3] }
                            wires["x" .. loopx .. "y" .. loopy .. "z" .. loopz] = true
                            -- print("x"..loopx.."y"..loopy.."z"..loopz.." is a wire!")
                        elseif blockname:startsWith("electrical_age_lite:machine") then
                            -- print("found machine ",loopx+dirtable[1], loopy + dirtable[2], loopz + dirtable[3], cur_energy)
                            cur_energy = machine_give_energy(loopx + dirtable[1], loopy + dirtable[2],
                                loopz + dirtable[3], cur_energy)
                        end
                    end
                end

                paths_to_process[#paths_to_process + 1] = { curx, cury, curz }
                while true do
                    if #paths_to_process > 0 then
                        for key, value in pairs(paths_to_process) do
                            wireFlow(value[1], value[2], value[3])
                            paths_to_process[key] = nil
                        end
                    else
                        break
                    end
                end
                generator_drain_energy(curx, cury, curz, initial_energy - cur_energy)

                -- for _, dirtable in pairs(directions) do
                --     if block.name(block.get(curx + dirtable[1], cury + dirtable[2], curz + dirtable[3])):startsWith("electrical_age_lite:wire") then
                --         while true do -- :skull:
                --             local path_idx = #current_path + 1
                --             current_path[path_idx] = {}
                --             for dirid, dirtable in pairs(directions) do
                --                 if block.name(block.get(curx + dirtable[1], cury + dirtable[2], curz + dirtable[3])):startsWith("electrical_age_lite:wire") then
                --                     current_path[path_idx][#current_path[path_idx] + 1] = dirid
                --                 elseif block.name(block.get(curx + dirtable[1], cury + dirtable[2], curz + dirtable[3])):startsWith("electrical_age_lite:machine") then
                --                     local energy = generator_drain_energy(v.x, v.y, v.z, 4)
                --                     energy = machine_give_energy(v.x + dirtable[1], v.y + dirtable[2], v.z + dirtable[3], energy)
                --                     v.data.energy_bank_value = v.data.energy_bank_value + energy
                --                 end
                --             end
                --             break
                --         end
                --     end
                -- end



                -- for _, dirtable in pairs(directions) do
                --     if block.name(block.get(v.x + dirtable[1], v.y + dirtable[2], v.z + dirtable[3])):startsWith("electrical_age_lite:machine_light") then

                --     end
                -- end
            end
        end
    end

    for k, v in pairs(list) do
        if v.name:startsWith("electrical_age_lite:machine") then
            machine_update(v.x, v.y, v.z)
        end
    end
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
