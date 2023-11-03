img_add_fullscreen("apu.png")
apu_fail = img_add("apu_fail.png",88, 115, nil, nil)
apu_run = img_add("apu_run.png", 215, 134, nil, nil)
apu_start = img_add("apu_start.png", 209, 109, nil, nil)
master_on = img_add("master_on.png",332, 121, nil, nil)
fire = img_add("fire.png",327, 43, nil, nil)

visible(apu_fail, false)
visible(apu_run, false)
visible(apu_start, false)
visible(master_on, false)
visible(fire, false)

txt_amps = txt_add(" ", "size:35px; font:digital-7-mono.ttf; color: red; halign:center; valign:center", 70, 37, 66, 32)
txt_perc = txt_add(" ", "size:35px; font:digital-7-mono.ttf; color: red; halign:center; valign:center", 196, 36, 66, 32)
txt_debug = txt_add(" ", "size:20px; font:digital-7-mono.ttf; color: red; halign:center; valign:center", 0, 0, 200, 32)

function new_apu_fsx(volts, generator_switch, generator_active, onfire, pct_starter, pct_rpm)
    txt_set(txt_amps, string.format("%d", var_round(volts, 0)))
    txt_set(txt_perc, string.format("%d", var_round(pct_rpm * 100, 0)))
    visible(apu_start, pct_starter > 0.001)
    visible(apu_run, generator_active)
    visible(apu_fail, pct_rpm < 0.01 and pct_starter > 0.001)
    visible(fire, onfire)
end


fsx_variable_subscribe("APU VOLTS", "Volts", 
						"APU GENERATOR SWITCH", "Bool",
						"APU GENERATOR ACTIVE", "Bool",
						"APU ON FIRE DETECTED", "Bool",
						"APU PCT STARTER", "Percent over 100",
						"APU PCT RPM", "Percent over 100",
						new_apu_fsx)

-- COLD AND DARK

--black = img_add_fullscreen("black.png")
function new_battery_FSX(battery)
	visible(master_on, battery)
	if not battery then
	    txt_set(txt_amps, "")
		txt_set(txt_perc, "")
		visible(apu_fail, false)
	end
end
fsx_variable_subscribe("ELECTRICAL MASTER BATTERY", "Bool",
						new_battery_FSX)
new_battery_FSX(false)