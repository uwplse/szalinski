/* filament guide, mountable on display of Prusa i3 Pro B
   presets fit the wood/pertinax 5.5mm frame
*/


// determines depth of beam resting on frame, and consequently, depth of filament eyelets
frame=5.5;                         // [0.5:0.1:15]

mount_screws_separation=145;       // [80:180]

mount_screws_diameter=3;           // [2:0.5:6]

mount_screws_radius=mount_screws_diameter/2;

// distance of screws from upper frame edge
mount_hole_to_beam=9.5;            // [3:0.1:18]

// outer diameter
eyelet_diameter=20;                // [5:0.5:50]

eyelet_radius=eyelet_diameter/2;

// seperate to keep sandwiched display unobstructed by filament
eyelet_seperation=100;             // [10:1:150]

filament_slot_angle=60;            // [-135:135]

filament_slot=2;                   // [1:0.2:5]

// material thickness of beams and tabs
guide_strength=1;                  // [0.5:0.1:4]

guide_vertical_beam=6;             // [0:0.5:16]

guide_vertical_beam_total=guide_vertical_beam+guide_strength;

tabsize=(mount_hole_to_beam+guide_strength-guide_vertical_beam_total)*2;

guide_length = mount_screws_separation+tabsize;

$fn=12;                            // [12:90]

little = 0+0.01;


// r1: inner radius
// r2: outer radius
module torus(r1, r2)  {
        x = (r2+r1)/2;
	y = (r2-r1)/2;
	rotate_extrude(convexity = 10)
	translate([x, y])
	circle(r = y);
}


module tab(size, thickness, bore)  {
	linear_extrude(thickness) {
		difference()  {
			square(size, center=true);
			circle(bore);
		}
	}
}

module eyelet()  {
	difference()  {
		union()  {
			translate([0, 0, guide_strength])
			torus(eyelet_radius-frame, eyelet_radius);
			difference()  {
				cylinder(frame/2+guide_strength, eyelet_radius, eyelet_radius);
				translate([0, 0, -little/2])
				cylinder(frame+guide_strength+little, eyelet_radius-frame, eyelet_radius-frame);
			}
		}

		translate([0, eyelet_radius-frame/2, (frame+guide_strength)/2-little/2])
		cube([eyelet_diameter, frame+little/2, frame+guide_strength+little], center=true);

		rotate([0, 0, 270-filament_slot_angle])
		translate([0, 0, -little/2])
		cube([eyelet_radius, filament_slot, frame+guide_strength+little]);	// filament slot
	}
}




cube([guide_length, guide_vertical_beam_total, guide_strength]);		// vertical beam
cube([guide_length, guide_strength, frame+guide_strength]);			// horizontal beam

for (x=[0:1])  {
	translate([((2*x-1)*mount_screws_separation+guide_length)/2, guide_vertical_beam_total+tabsize/2, 0])
	tab(tabsize, guide_strength, mount_screws_radius*1.1);			// tabs

	translate([((2*x-1)*eyelet_seperation+guide_length)/2, frame-eyelet_radius, 0])
	eyelet();								// eyelets
}
