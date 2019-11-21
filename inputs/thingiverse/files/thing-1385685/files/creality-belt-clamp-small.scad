/* 

Y belt clamps for the Creality CR-7 MINI, e.g. available from
http://www.eastmachinery.com/product/8213.html

This little 3D printer doesn't have a decent way for fixing the belts.
I.e. they suggest just using plastic "cuffs".

Original code made by Triffid Hunter
http://www.thingiverse.com/thing:13479

Additional code from John Ridely' robust belt clamp/tightner for i3
Prusa (can't remember where I found this), i.d. I replaced the top
clamp code with the one from John Ridley

Daniel K. Schneider, TECFA, University of Geneva, Feb 2016

*/

// Define BELT properties in mm

// belt width (7mm default)
belt_width = 7; // 15 for a double, 7 for a single

// belt height (thinkness)
belt_height = 2;

// distance between teeth
tooth_offset = 2.1; // distance between teeth

// height of the teeth
tooth_height = 1.2;

// width of the teeth
tooth_width = 1.05; // roughtly == tooth_offset/2,  can be made a bit bigger or smaller (depends on your slicing)

// Distance between holes and perimeter
wall = 3;

/* tweeking extrusion ? */
extrusion_width = 0.4;

// Height of clamps
clamp_height = 3.5;

// Width of clamps (wall * 4)
clamp_width = 12;

/* Parameters for the ram (optional) */

ram_height = 7;
ram_length = 1.5; 

/* Definition of the nuts and bolts */

m3_diameter = 3 / cos(180 / 8) + 0.4;
m3_radius = m3_diameter / 2;

m3_nut_diameter = 5.5 / cos(180 / 6) + 0.4;
m3_nut_radius = m3_nut_diameter / 2;

m3_nut_depth = 2.5;

// ***************  models - comment if you like, e.g. for the CR-7 you only may need the clamps

translate([wall * 2 + m3_diameter + 2, 0, 0]) clamp_top(); // Clamp with grid
translate([-wall * 2 - m3_diameter - 2, 0, 0]) clamp_trap(); // Clamp with nut holes

// clamp_base(); // the ram base
// translate([wall * 4 + m3_diameter * 2 + 3, -belt_width, 0]) ram(); // ram 1
// translate([wall * 4 + m3_diameter * 2 + 3, belt_width, 0]) ram(); // ram 2


// ----------- code 

module clamp(h=10) {
	translate([-wall - m3_radius, 0, 0])
	difference() {
		intersection() {
			translate([0, belt_width / -2 - m3_diameter - wall - extrusion_width * 2, 0]) cube([wall * 2 + m3_diameter, belt_width + m3_diameter * 2 + wall * 2 + extrusion_width * 4, h]);
			union() {
				translate([wall + m3_radius, belt_width / 2 + m3_radius + extrusion_width, 0]) cylinder(r=wall + m3_radius, h=h + 1, $fn=32);
				translate([wall + m3_radius, -belt_width / 2 - m3_radius - extrusion_width, 0]) cylinder(r=wall + m3_radius, h=h + 1, $fn=32);
				translate([0, -belt_width / 2 - m3_radius - extrusion_width, 0]) cube([wall * 2 + m3_diameter, belt_width + m3_diameter  + extrusion_width * 2, h + 1]);
			}
		}
		translate([wall + m3_radius, belt_width / 2 + m3_radius + extrusion_width, -1]) cylinder(r=m3_radius, h=h + 2, $fn=16);
		translate([wall + m3_radius, belt_width / -2 - m3_radius - extrusion_width, -1]) cylinder(r=m3_radius, h=h + 2, $fn=16);
	}
}

module clamp_base() {
	difference() {
		clamp(belt_height + m3_nut_diameter);

		translate([-1 - wall - m3_radius, -belt_width / 2, m3_nut_diameter]) cube([wall * 4, belt_width, belt_height + 1]);
		translate([-1 - wall - m3_radius, 0, m3_nut_radius]) rotate([0, 90, 0]) rotate([0, 0, 180 / 8]) cylinder(r=m3_radius, h=wall * 4, $fn=8);
		translate([-1 - wall - m3_radius, 0, m3_nut_radius]) rotate([0, 90, 0]) rotate([0, 0, 180 / 6]) cylinder(r=m3_nut_radius, h=1 + m3_nut_depth, $fn=6);
	}
}

// clamp top with insets for holding the belt
// The code in the for loop was taken from John Ridely
module clamp_top() {
	difference() {
		clamp(clamp_height);
		for(i=[0:clamp_width/tooth_offset])
			{
			translate([(-clamp_width / 2) + (tooth_offset * i), 0, (clamp_height - tooth_height/2)])
				cube([tooth_width, belt_width, tooth_height], center=true);
			}
		}
	}


// clamp holding the 2 nuts
module clamp_trap() {
	difference() {
		clamp(clamp_height);
		translate([0, belt_width / 2 + m3_radius + extrusion_width, max(clamp_height - m3_nut_depth, 1)]) cylinder(r=m3_nut_radius, h=m3_nut_depth + 1, $fn=6);
		translate([0, belt_width / -2 - m3_radius - extrusion_width, max(clamp_height - m3_nut_depth, 1)]) cylinder(r=m3_nut_radius, h=m3_nut_depth + 1, $fn=6);
	}
}

// 2 blocks
module ram() {
	difference() {
		union() {
			cylinder(r=m3_nut_radius, h=ram_height, $fn=32);
			translate([0, -m3_nut_radius, 0]) cube([ram_length + 0.1, m3_nut_diameter, ram_height]);
		}
		translate([ram_length, -m3_nut_radius - 1, -1]) cube([m3_nut_diameter + 2, m3_nut_diameter + 2, ram_height + 2]);
		translate([-0.5, 0, ram_height / 2]) rotate([0, 90, 0]) rotate([0, 0, 180 / 8]) cylinder(r=m3_radius, h=2 + ram_length, $fn=8);
	}
}

