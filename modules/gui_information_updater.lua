local current_block = {nil, nil, nil}
local inv_id = nil

function set_current_block(x, y, z, invid)
    current_block = {x, y, z}
    inv_id = invid
end

function clear_current_block()
    current_block = {nil, nil, nil}
    inv_id = nil
end

function get_current_block()
    return current_block[1], current_block[2], current_block[3], inv_id
end