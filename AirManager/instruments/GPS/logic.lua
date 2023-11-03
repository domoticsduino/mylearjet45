-- General vars --
local gps_zoom = 12
-------------------------------------
-- Load and display map and images --
-------------------------------------
img_add_fullscreen("background.png")
----------------------------------------------** MAP OPTIONS START **----------------------------------------------
-- Change zoom level '...OSM_MAPQUEST",zoom level)' to set your preferred zoom level, lower is out, higher is in --
-- Change map type '...,"map type",12)' to set your preferred map type. See the wiki for the options.            --                                                                                   --
-------------------------------------------------------------------------------------------------------------------

-- Zoom Button functions --
function new_zoomplus()
    
    gps_zoom = gps_zoom + 1
    
    if (gps_zoom > 14) then
        gps_zoom = 14
    end
    
    map_zoom(navmap, gps_zoom)

end

function new_zoommin()
    
    gps_zoom = gps_zoom - 1
        
    if (gps_zoom < 7) then
        gps_zoom = 7
    end
    
    map_zoom(navmap, gps_zoom)

end



navmap = map_add(1,92,798,942,"OSM_TRANSPORT", gps_zoom)
black = img_add("black.png",1,92,798,942)

---------------------------------------------**** MAP OPTIONS END ****---------------------------------------------
-------------------------------------------------------------------------------------------------------------------

map_add_nav_img_layer(navmap, "AIRPORT", "airport.png", -13, -13, 26, 26)
map_add_nav_txt_layer(navmap, "AIRPORT", "ICAO", "size:16px; color: #fb2c00; font:arimo_bold.ttf; halign:center;", -40, -30, 80, 40)
img_add("northarrow.png", 55, 30, 40, 40)
airplane_icon = img_add("airplane.png", 375, 738, 50, 50)
visible(airplane_icon, false)

---------------------------
-- Load and display text --
---------------------------

-- MAP --
txt_add("N","size:18px; color: black; font:arimo_bold.ttf;", 71,43,20,20)
txt_add("HDG","size:22px; color: #b6cfe5; font:arimo_bold.ttf; halign:center;", 645,15,100,50)
txt_heading = txt_add(" ","size:22px; color: white; font:arimo_bold.ttf; halign:center;", 710,15,100,50)
txt_add("GS","size:22px; color: #b6cfe5; font:arimo_bold.ttf; halign:center;", 645,55,100,50)
txt_ground_speed = txt_add(" ","size:22px; color: white; font:arimo_bold.ttf; halign:center;", 700,55,100,50)
txt_gs_kt = txt_add("KT", "size:16px; font:arimo_bold.ttf; color: white; halign: center;", 730,60,100,50)
txt_add("GPS","size:34px; font:arimo_bold.ttf; color: #5fce4b; halign:center;", 350,1040,100,50)

-- MAP COORDINATES --
txt_add("Lat:  ","size:22px; font:arimo_bold.ttf; color: #b6cfe5; halign:center;", 190,58,100,50)
txt_lat = txt_add(" ","size:22px; font:arimo_bold.ttf; color: white; halign:left;", 270, 58,150,50)
txt_add("Lon:  ","size:22px; font:arimo_bold.ttf; color: #b6cfe5; halign:center;", 420,58,100,100)
txt_lon = txt_add(" ","size:22px; font:arimo_bold.ttf; color: white; halign:left;", 500,58,150,50)

-- MAP ZOOM --
button_zoomplus = button_add("zoomplus.png","zoompluspr.png",220,1037,30,30, new_zoomplus)
button_zoommin = button_add("zoommin.png","zoomminpres.png",560,1037,30,30, new_zoommin)


---------------
-- Functions --
---------------

function new_position(latitude, longitude, heading, groundspeed, timer)

-- Set position on world map --
map_goto(navmap, latitude, longitude)

-- Rotate airplane icon to current heading --
rotate(airplane_icon, heading)

-- Set heading text --
txt_set(txt_heading, string.format("%.0f°", heading) )

-- Set groundspeed text --
txt_set(txt_ground_speed, string.format("%.0f", groundspeed) )

-- Set coordinates text --
txt_set(txt_lat, string.format("%06.03f", latitude) )
txt_set(txt_lon, string.format("%06.03f", longitude) )

end

-------------------
-- Bus subscribe --
-------------------
fsx_variable_subscribe("GPS POSITION LAT", "Degrees",
                       "GPS POSITION LON", "Degrees",
                       "PLANE HEADING DEGREES MAGNETIC", "Degrees",
                       "GPS GROUND SPEED", "Knots", new_position)

-- COLD AND DARK

-- black = img_add_fullscreen("black.png")
function new_battery_FSX(battery)
	visible(black, not battery)
	visible(airplane_icon, battery)
	txt_set(txt_heading, "" )
	txt_set(txt_ground_speed, "" )
	txt_set(txt_lat, "" )
	txt_set(txt_lon, "" )
end
fsx_variable_subscribe("ELECTRICAL MASTER BATTERY", "Bool",
						new_battery_FSX)
new_battery_FSX(false)