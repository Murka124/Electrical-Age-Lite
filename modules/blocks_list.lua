local constants_lib = require("electrical_age_lite:constants")
local constants = get_constants()
local list = {}

function set_list(parsed_json)
    list = parsed_json
end

function get_list()
    return list
end

function set_block(x, y, z, name_id)
    list["x"..x.."y"..y.."z"..z] = {}
    list["x"..x.."y"..y.."z"..z].name = name_id
    list["x"..x.."y"..y.."z"..z].data = {}
    list["x"..x.."y"..y.."z"..z].x = x
    list["x"..x.."y"..y.."z"..z].y = y
    list["x"..x.."y"..y.."z"..z].z = z
end

function set_block_data(x, y, z, key, value)
    list["x"..x.."y"..y.."z"..z].data[key] = value
end

function set_block_whole_data(x, y, z, data)
    list["x"..x.."y"..y.."z"..z].data = data
end

function set_block_data_pattern(x, y, z, pattern_name)
    list["x"..x.."y"..y.."z"..z].data = constants.data_patterns[pattern_name]
end

function get_block_data(x, y, z)
    if list["x"..x.."y"..y.."z"..z] then return list["x"..x.."y"..y.."z"..z].data end
end

function clear_block(x, y, z)
    list["x"..x.."y"..y.."z"..z] = nil
end