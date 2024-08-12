local blocks_list = require("electrical_age_lite:blocks_list")
require "explode_lib:explode"

function machine_give_energy(x, y, z, vce)
    local data = get_block_data(x,y,z)
    local can_consume_value = data.energy_bank_max_value-data.energy_bank_value
    local consumed = math.max(math.min(vce, can_consume_value), 0)
    data.consumed_voltage = data.consumed_voltage + consumed
    data.energy_bank_value = data.energy_bank_value + consumed
    return vce-consumed
end

function machine_update(x, y, z)
    local data = get_block_data(x,y,z)
    if block.name(block.get(x,y,z)):startsWith("electrical_age_lite:machine_light") then
        if data.energy_bank_value >= data.work_voltage then
            data.energy_bank_value = data.energy_bank_value - data.work_voltage
            if block.name(block.get(x,y,z)) == "electrical_age_lite:machine_light" then
                block.set(x,y,z,block.index("electrical_age_lite:machine_light_active"))
            end
        else
            if block.name(block.get(x,y,z)) == "electrical_age_lite:machine_light_active" then
                block.set(x,y,z,block.index("electrical_age_lite:machine_light"))
            end
        end
    end
    set_block_whole_data(x,y,z,data)
end