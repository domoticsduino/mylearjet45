-- ATR 72-500 TAT/TAS gauge
-- gauge shows temperature TAT in °C and true airspeed in Knots.
-- on button press temperature SAT (standard atmosphere) will be displayed.
-- remove the bezel by clicking in the top left corner of the instrument

-- config storage 
tat_config = persist_add("show_bezel","INT",1)

-- global variables
cfg_show_bezel = persist_get(tat_config)        -- load the bezel setting

-- Fonts
font = "size:34px; color: #D62100; halign: right;"

-- Images
img_no_bezel = img_add_fullscreen("black.png")
img_bezel = img_add_fullscreen("background.png")
if cfg_show_bezel == 0 then
    visible(img_bezel,false)
else
    visible(img_no_bezel,false)
end

txt_temperature = txt_add("", font, 43, 46, 100, 60)
txt_speed = txt_add("",font,158,46,100,60)
local show_sat = false        -- memory for the button press

function button_pressed()
    show_sat = true
end

function button_released()
    show_sat = false
end
button_add("knob.png", "knob_pressed.png", 48,98,23,23,button_pressed,button_released)

function bezel_config()                -- remove the bezel by clicking in the top left corner of the instrument
    if cfg_show_bezel == 1 then
        cfg_show_bezel = 0
        visible(img_bezel,false)
        visible(img_no_bezel, true)
    else
        cfg_show_bezel = 1
        visible(img_bezel, true)
        visible(img_no_bezel, false)
    end
    persist_put(tat_config, cfg_show_bezel)    -- save setting
end
switch_add(nil,nil,0,0,80,50,bezel_config)

function new_fsx_data(TAT, SAT, TAS, battery)
    if battery then
        TAS = math.floor(TAS)
        TAT = var_format(TAT,1)
        SAT = var_format(SAT,1)
        txt_set(txt_temperature,fif(show_sat,SAT,TAT))    -- Show either TAT or SAT depending on button state
        visible(txt_temperature, true)
        txt_set(txt_speed, TAS)
        visible(txt_speed, true)
    else
        visible(txt_temperature, false)
        visible(txt_speed, false)
    end
end

fsx_variable_subscribe("TOTAL AIR TEMPERATURE", "Celsius",
                        "STANDARD ATM TEMPERATURE", "Celsius",
                        "AIRSPEED TRUE", "Knots", 
                        "ELECTRICAL MASTER BATTERY", "BOOLEAN", 
                        new_fsx_data)
                        
fs2020_variable_subscribe("TOTAL AIR TEMPERATURE", "Celsius",
                           "STANDARD ATM TEMPERATURE", "Celsius",
                           "AIRSPEED TRUE", "Knots", 
                           "ELECTRICAL MASTER BATTERY", "BOOLEAN", 
                           new_fsx_data)                        