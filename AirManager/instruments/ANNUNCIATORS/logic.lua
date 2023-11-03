img_anun_off = img_add_fullscreen("annunciator_background.png")
img_l_eng_fire = img_add_fullscreen("annunciator_l_eng_fire.png")
img_r_eng_fire = img_add_fullscreen("annunciator_r_eng_fire.png")
img_apu = img_add_fullscreen("annunciator_apu.png")
img_brakes = img_add_fullscreen("annunciator_brakes.png")
img_emer_batt = img_add_fullscreen("annunciator_emer_batt.png")
img_entry_door = img_add_fullscreen("annunciator_entry_door.png")
img_gear = img_add_fullscreen("annunciator_gear.png")
img_gen_fail = img_add_fullscreen("annunciator_gen_fail.png")
img_l_fuel_press_low = img_add_fullscreen("annunciator_l_fuel_press_low.png")
img_r_fuel_press_low = img_add_fullscreen("annunciator_r_fuel_press_low.png")
img_l_oil_press_low = img_add_fullscreen("annunciator_l_oil_press_low.png")
img_r_oil_press_low = img_add_fullscreen("annunciator_r_oil_press_low.png")
black = img_add_fullscreen("black.png")

visible(img_l_eng_fire, false)
visible(img_r_eng_fire, false)
visible(img_apu, false)
visible(img_brakes, false)
visible(img_emer_batt, false)
visible(img_entry_door, false)
visible(img_gear, false)
visible(img_gen_fail, false)
visible(img_l_fuel_press_low, false)
visible(img_r_fuel_press_low, false)
visible(img_l_oil_press_low, false)
visible(img_r_oil_press_low, false)

function annunciator(l_eng_fire, r_eng_fire, apu, gear, brakes, entry_door, gen1, gen2, l_fuel_press_low, r_fuel_press_low, l_oil_press_low, r_oil_press_low, master)

	visible(black, not master)

	visible(img_l_eng_fire, l_eng_fire and master)    
	visible(img_r_eng_fire, r_eng_fire and master)
	visible(img_apu, apu and master)
	visible(img_brakes, brakes and master)
	visible(img_emer_batt, (not (gen1 or gen2)) and master)
	visible(img_entry_door, entry_door and master)
	visible(img_gear, gear and master)
	visible(img_gen_fail, (not (gen1 and gen2)) and master)
	visible(img_l_fuel_press_low, l_fuel_press_low and master)
	visible(img_r_fuel_press_low, r_fuel_press_low and master)
	visible(img_l_oil_press_low, l_oil_press_low and master)
	visible(img_r_oil_press_low, r_oil_press_low and master)
    
end

fsx_variable_subscribe("L:Fire_Eng1_Warning", "Bool",
						"L:Fire_Eng2_Warning", "Bool",
						"L:Fire_Apu_Warning", "Bool",
						"L:Gear_Warning", "Bool",
						"BRAKE PARKING INDICATOR", "Bool",
						"CANOPY OPEN", "Bool",
						"GENERAL ENG GENERATOR ACTIVE:1", "Bool",
						"GENERAL ENG GENERATOR ACTIVE:2", "Bool",
						"L:FuelPressure_Eng1_Warning", "Bool",
						"L:FuelPressure_Eng2_Warning", "Bool",
						"L:OilPressure_Eng1_Warning", "Bool",
						"L:OilPressure_Eng2_Warning", "Bool",
						"ELECTRICAL MASTER BATTERY", "Bool",
                       annunciator)