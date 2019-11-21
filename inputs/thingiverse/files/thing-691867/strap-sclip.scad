// Customizable Strap S-Clip by Jim DeVona

// (mm) Determines width of center section of clip.
strap_width = 19;

// (mm) Determines size of openings in clip.
strap_thickness = 2;

// (mm) Determines thickness of clip walls.
wall_thickness = 2.5;

// (mm)
height = 15;

// If enabled, generate nubs on inner surface of clip to grip strap holes. Edit script to change tab dimensions.
tabs = "Enabled"; // [Enabled,Disabled]

/* [Hidden] */

strap_x = strap_width;
strap_y = strap_thickness;

box_y = 2 * wall_thickness + strap_y;

spring_ro = wall_thickness + strap_y;
spring_ri =  strap_y;
spring_y = wall_thickness + strap_y/2;

module Clip() {
	translate([-(strap_x + spring_ro)/2, -wall_thickness/2, 0])
	difference() {
		
		// positive space
		union() {
			
			// center section (extended into spring ring)
			cube([strap_x + spring_ro, box_y, height]);
			
			// opening handles
			translate([0, wall_thickness + strap_y, 0])
			rotate([0, 0, -45])
			translate([-spring_ro, 0, 0])
			cube([spring_ro, wall_thickness, height]);
			
			// spring ring
			translate([strap_x + spring_ro, spring_y, 0])
			cylinder(r = spring_ro, h = height, $fn = 30);
		}
		
		// negative space
		union() {
			
			// slot in center section for strap
			translate([0, wall_thickness, 0])
			cube([strap_x + spring_ro, strap_y, height]);
			
			// cavity in spring ring (affords flex)
			translate([strap_x + spring_ro, spring_y, 0])
			cylinder(r = spring_ri, h = height, $fn = 30);
			
			// chop off part that will be reflected
			cube([(strap_x + spring_ro) / 2, wall_thickness, height]);
		}
	}
}

module Tab() {
	cylinder(r1 = 2.5, r2 = 1, h = 1.5, $fn = 30);
}

union() {
	
	Clip();
	
	rotate([0, 0, 180])
	Clip();
	
	if (tabs == "Enabled") {
		translate([0, wall_thickness/2 + strap_y, height/2])
		rotate([90, 0, 0])
		Tab();

		translate([0, -(wall_thickness/2 + strap_y), height/2])
		rotate([-90, 0, 0])
		Tab();
	}
}