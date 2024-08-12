local gui_information_updater = require("electrical_age_lite:gui_information_updater")

function on_open(invid, x, y, z)
    set_current_block(x, y, z, invid)
    -- print("opened",invid,x,y,z)
    -- print(document.energy_bar.max_value)
end

function on_close(invid)
    clear_current_block()
    -- print("closed",invid)
end