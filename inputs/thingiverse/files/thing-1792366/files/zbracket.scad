height = 5;
frame = 5.5;
slack = 0.2;
screws = 3;
bearing_diameter = 22.4;
bearing_radius = bearing_diameter/2;
bearing_height = 7; 
bearing_wall = 3;
bearing_brim = 1;
bearing_brim_thickness = 2;
rod_diameter = 8;
rod_radius = rod_diameter/2;
block_x = frame*3;
block_y = 12;
boden = 4;
horizontal_rod_diameter = 8;
horizontal_rod_radius = horizontal_rod_diameter/2;
dach = (block_y-horizontal_rod_diameter)/2;		
block_z = height+boden+horizontal_rod_diameter+dach;
bracket_depth = 85;
x_outer_notch = 10;
x_inner_notch = 28;
corners = 10;
x_rail = 3;


little=0.01;							// improve OpenSCAD preview
$fn=90;


module zbracket()  {

	linear_extrude(height)
		difference()  {
		hull()  {
			for (x=[corners, 67-corners],
			     y=[corners, bracket_depth-corners])  {
			translate([x, y])
			circle(corners);
			}
		}

		translate([29, 11])				// opening for spindle	
		circle(bearing_radius+slack);

		translate([51, 11])				// smooth rod
		circle(rod_radius+slack);

		translate([frame, 79])				// Aussparung Y außen
		square([frame+slack, frame+2]);

		translate([frame, 56])				// Aussparung Y innen
		square([frame+slack, frame+slack]);

		translate([-little/2, 45.5])			// Aussparung X innen
		square([x_inner_notch+little, frame+slack]);

		translate([57-little/2, 45.5])			// Aussparung X außen
		square([x_outer_notch+little, frame+slack]);

		translate([8+slack/2, 70])			// Bohrung Befestungsschraube Y
		circle(screws/2+slack);

		translate([43, 48.25+slack/2])			// Bohrung Befestungsschraube X
		circle(screws/2+slack);

		translate([frame*3+slack, bracket_depth])	// Schräge hinten
		rotate(-30)
	        square([60, 25]);
	}

	linear_extrude(bearing_height+bearing_brim_thickness)
	translate([29, 11])
	difference()  {
		circle(bearing_radius+bearing_wall);		// ring for bearing
		circle(bearing_radius+slack);
	}

	linear_extrude(bearing_brim_thickness)
	translate([29, 11])
	difference()  {
		circle(bearing_radius+bearing_wall);
		circle(bearing_radius-bearing_brim);		// brim for bearing
	}

	module Wellenbock()  {
		difference()  {
			cube([block_x, block_y, block_z]);						// block

			translate([frame, -little/2, -little/2])
			cube([frame+slack, block_y+little, height+slack+little/2]);			// fork

			translate([-little/2, block_y/2, height+boden+horizontal_rod_radius])
			rotate([0, 90, 0])
			cylinder(block_x+little, horizontal_rod_radius, horizontal_rod_radius);		// rod bore
		}
	}			

	translate([15, 45.5-x_rail, height])
	cube([52, x_rail, x_rail]);
	translate([15, 45.5+frame+slack, height])
	cube([52, x_rail, x_rail]);

	enough_space_for_nut = bearing_diameter+bearing_wall-block_y/2+horizontal_rod_radius+3;
	for (y=[bracket_depth-block_y, enough_space_for_nut])
	translate([0, y, 0])
	Wellenbock();

	difference()  {
		translate([0, enough_space_for_nut+block_y, height])
		cube([block_x, bracket_depth-2*block_y-enough_space_for_nut, block_z-height]);

		translate([8+slack/2, 70, 0])					// Bohrung Befestungsschraube X
		cylinder(block_z, screws/2+slack,  screws/2+slack);

		translate([8+slack/2, 70, height])				// Bohrung Befestungsschraube X
		cylinder(block_z-height+little/2, screws/2+1.5,  screws/2+1.5);
	}
}

module left_zbracket()  {
	mirror([1, 0, 0]) 
	zbracket();
}

module right_zbracket()  {
	zbracket();
}



translate([5, 0, 0]) right_zbracket();			// right bracket
translate([-5, 0, 0]) left_zbracket();			// left bracket

