function update_generator(x, y, z)
    local name = block.name(block.get(x, y, z))
    if name:startsWith("electrical_age_lite:generator_thermo") then
        local data = get_block_data(x, y, z)
        local invid = inventory.get_block(x, y, z)
        local inv_item, inv_val = inventory.get(invid, 0)
        local consumables = get_constants().generators.thermo.consumables
        local consume_time = get_constants().generators.thermo.consume_time
        -- print(data, invid, consumables)
        if data.current_process_time > 0 then
            if data.energy_bank_max_value - data.energy_bank_value >= data.energy_generation then
                data.current_process_time = data.current_process_time - 1
                data.energy_bank_value = data.energy_bank_value + data.energy_generation
            end
        end
        if data.current_process_time <= 0 then
            local consumed = false
            local consume_id = 0
            for k, v in pairs(consumables) do
                -- print(k, v, item.name(inv_item))
                if item.name(inv_item) == v then
                    consumed = true
                    consume_id = k
                end
            end
            if consumed then
                if inv_val <= 0 then
                    inventory.set(invid, 0, block.index("core:air"), 0)
                else
                    inv_val = inv_val - 1
                    inventory.set(invid, 0, inv_item, inv_val)
                    data.max_process_time = consume_time[consume_id]
                    data.current_process_time = consume_time[consume_id]
                end
            end
        end
        set_block_whole_data(x, y, z, data)
    elseif name:startsWith("electrical_age_lite:generator_solar") then
        local time = world.get_day_time()
        if time > 0.25 and time < 0.75 then
            local tmp_y = y + 1
            local can_generate = true
            while tmp_y < 256 do
                if block.name(block.get(x, tmp_y, z)) ~= "core:air" then
                    can_generate = false
                    break
                end
                tmp_y = tmp_y + 1
            end
            if can_generate then
                local data = get_block_data(x, y, z)
                data.energy_bank_value = 1
                set_block_whole_data(x, y, z, data)
            end
        end
    elseif name:startsWith("electrical_age_lite:generator_hydro") then
        local data = get_block_data(x, y, z);
        local invid = inventory.get_block(x, y, z);
        local inv_item, inv_val = inventory.get(invid, 0);

        local turbines = get_constants().generators.hydro.turbines
        local energy_produce = get_constants().generators.hydro.energy_produce

        for k, v in pairs(turbines) do
            if item.name(inv_item) == v then
                data.energy_generation = energy_produce[k]
                if data.energy_bank_max_value - data.energy_bank_value >= data.energy_generation then
                    data.energy_bank_value = data.energy_bank_value + energy_produce[k]
                end
            end
        end
        set_block_whole_data(x, y, z, data)
    end
end

function generator_drain_energy(x, y, z, vce, change)
    if change == nil then change = true end
    local name = block.name(block.get(x, y, z))
    if name:startsWith("electrical_age_lite:generator") then
        local data = get_block_data(x, y, z)
        if data.energy_bank_value > 0 then
            local can_give = math.min(data.energy_bank_value, vce)
            if change then
                data.energy_bank_value = data.energy_bank_value - can_give
                set_block_whole_data(x, y, z, data)
            end
            return can_give
        end
        return 0
    end
end
