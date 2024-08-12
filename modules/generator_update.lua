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
            if data.energy_bank_max_value-data.energy_bank_value >= data.energy_generation then
                data.current_process_time = data.current_process_time-1
                data.energy_bank_value = data.energy_bank_value + data.energy_generation
                -- if name == "electrical_age_lite:generator_thermo" then
                --     local states = block.get_states(x, y, z)
                --     inventory.unbind_block(x,y,z)
                --     block.set(x, y, z, block.index("electrical_age_lite:generator_thermo_active"), states)
                --     inventory.unbind_block(x,y,z)
                --     inventory.bind_block(invid, x,y,z)
                -- end
            end
        -- else
        --     if name == "electrical_age_lite:generator_thermo_active" then
        --         local states = block.get_states(x, y, z)
        --         inventory.unbind_block(x,y,z)
        --         block.set(x, y, z, block.index("electrical_age_lite:generator_thermo"), states)
        --         inventory.unbind_block(x,y,z)
        --         inventory.bind_block(invid, x,y,z)
        --     end
        end
        if data.current_process_time <= 0 then
            local consumed = false
            local consume_id = 0
            for k, v in pairs(consumables) do
                -- print(k, v, item.name(inv_item))
                if item.name(inv_item) == v then consumed = true consume_id = k end
            end
            if consumed then
                inv_val = inv_val -1
                if inv_val > 0 then
                    inventory.set(invid, 0, item.index("core:air"), 0)
                else
                    inventory.set(invid, 0, inv_item, inv_val)
                    data.max_process_time = consume_time[consume_id]
                    data.current_process_time = consume_time[consume_id]
                end
            end
        end
        set_block_whole_data(x, y, z, data)
    end
end