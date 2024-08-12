local blocks_list = require("electrical_age_lite:blocks_list")
require "explode_lib:explode"

function machine_give_energy(x, y, z, vce)
    local data = get_block_data(x,y,z)
    local can_consume_value = data.energy_bank_max_value-data.energy_bank_value
    can_consume_value = min(can_consume_value, data.max_voltage-data.consumed_voltage)
    local consumed = min(vce, can_consume_value)
    data.consumed_voltage = data.consumed_voltage + consumed
    return consumed
end

function machine_update(x, y, z)
    local data = get_block_data(x,y,z)
    if data.consumed_voltage > data.max_voltage then explode(x, y, z, data.explode_strength) return nil end

    if data.name:startsWith("electrical_age_lite:machine_light") then
        if data.energy_bank_value >= data.work_voltage then
            data.energy_bank_value = data.energy_bank_value - data.work_voltage
            if block.name(block.get(x,y,z)) == "electrical_age_lite:machine_light" then
                block.set(x,y,z,block.index("electrical_age_lite:machine_light_active"))
            end
        else
            if block.name(block.get(x,y,z)) == "electrical_age_lite:machine_light_active" then
                block.set(x,y,z,block.index("electrical_age_lite:machine_light"))
            end --дописать
        end
    end
    set_block_whole_data(x,y,z,data)
end