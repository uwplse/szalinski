//In mm, how wide should the tray be??
tray_width = 195; //[1:200]

//In mm, how long should the tray be??
tray_length = 95; //[1:200]

//In mm, how tall should the tray be??
tray_height = 18; //[1:50]

//How many areas should the tray be divided into?
number_of_divisions = 3; //[1:20]

/* [Advanced] */
// In mm, how thick should the tray walls be?
thickness_of_walls = 1.5; //[1:0.1:5]

//In mm, how tall should the rim at the top of the tray be?
size_of_rim = 0; //[0:0.25:5]

// What percentage of tray bottom should be flat?
size_of_bottom = 30; //[0:100]

// ########## Project Space #########
tray(tray_width, tray_length, tray_height, number_of_divisions, size_of_bottom, size_of_rim, thickness_of_walls);

// ############ Modules #############
module tray (width, length, height, divisions, bottom, tray_rim, wall_thickness) {
	division_width = (width - (wall_thickness * divisions + wall_thickness)) / divisions;
	division_length = length - (wall_thickness * 2);
	division_bottom = division_length * (bottom * 0.01);
	division_bottom_offset = (division_length - division_bottom) / 2;
		
	division_x_offset = division_width + wall_thickness;

	difference() {
		cube([width, length, height]);

		for (x = [wall_thickness : division_x_offset : width - wall_thickness]){	
			hull(){
				translate([x, wall_thickness, wall_thickness]) {
					translate([0, 0, height - wall_thickness - tray_rim]) cube([division_width, division_length, height]);
					translate([0, division_bottom_offset, 0]) cube([division_width, division_bottom, height]);
				}
			}
		}
	}
}
