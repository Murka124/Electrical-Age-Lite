local blocks_list = require("electrical_age_lite:blocks_list")
require "explode_lib:explode"
require "electrical_age_lite:block_extensions";

function machine_give_energy(x, y, z, vce)
    local data = get_block_data(x,y,z)
    if vce > data.max_voltage then explode(x, y, z, data.explode_strength) return 0 end
    local can_consume_value = data.energy_bank_max_value-data.energy_bank_value
    local consumed = math.max(math.min(vce, can_consume_value), 0)
    data.consumed_voltage = data.consumed_voltage + consumed
    data.energy_bank_value = data.energy_bank_value + consumed
    return vce-consumed
end

function machine_update(x, y, z)
    local data = get_block_data(x,y,z)
    if block.get_name(x,y,z):startsWith("electrical_age_lite:machine_light") then
        if data.energy_bank_value >= data.work_voltage then
            data.energy_bank_value = data.energy_bank_value - data.work_voltage
            if block.get_name(x,y,z) == "electrical_age_lite:machine_light" then
                block.set_with_name(x, y, z, "electrical_age_lite:machine_light_active")
            end
        else
            if block.get_name(x,y,z) == "electrical_age_lite:machine_light_active" then
                block.set_with_name(x, y, z, "electrical_age_lite:machine_light")
            end
        end
    end
    set_block_whole_data(x,y,z,data)
end