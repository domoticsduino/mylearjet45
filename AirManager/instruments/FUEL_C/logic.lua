-- Global variables --
local gbl_target_fuel = 0
local gbl_cur_fuel    = 0
local gbl_factor      = 0.09
-- Set the maximum fuel quantity (full) in gallons here:
local gbl_max_fuel    = 100

-- Add images --
img_add_fullscreen("fuel_right_backdrop.png")
img_needle = img_add("neddle.png",0,90,256,256)
img_add_fullscreen("fuel_cover.png")


function new_fuel_fsx(perc, bus_volts)

    if bus_volts >= 10 then
        gbl_target_fuel = var_cap(perc * 100, 0, gbl_max_fuel)
    else
        gbl_target_fuel = 0
    end

end

-- Slowly move needle to current amount of fuel --
function timer_callback()    
    
    -- Rotate needle image
    rotate(img_needle, (90 / gbl_max_fuel * gbl_cur_fuel) -45)

    -- Calculate the current fuel position
    gbl_cur_fuel = gbl_cur_fuel + ((gbl_target_fuel - gbl_cur_fuel) * gbl_factor)

end


fsx_variable_subscribe("FUEL TANK CENTER LEVEL", "Percent Over 100", 
                       "ELECTRICAL MAIN BUS VOLTAGE", "Volts", new_fuel_fsx)
                       
-- Timers --
tmr_update = timer_start(0, 10, timer_callback)