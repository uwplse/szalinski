// Simple wire spool
//
// Oliver Hitz <oliver@net-track.ch>

// Spool core length
length = 40;

// Spool diameter
spool_d = 60;

// Diameter of the spool's core
core_d = 13;

// Diameter of the hole through the core
core_hole_d = 8;

// Walls thickness
thickness = 2.5;

// Wire diameter (for two holes for fixing the wire)
wire_d = 1;

// Spool cutout diameter
cutout_d = spool_d / 4;

$fn = 64;

module side() {
	difference() {
		cylinder(h=thickness, d=spool_d);
		
		for (i = [0:60:360]) {
			rotate([0, 0, i])
				translate([(spool_d - 3*cutout_d/2)/2, 0, 0])
					cylinder(h=thickness, d=cutout_d);
		}
	};
}

difference() {
	union() {
		cylinder(h=length, d=core_d);
		
		side();
	};
	cylinder(h=length, d=core_hole_d);

	translate([0, 0, thickness*2])
		rotate([90,0,0])
			cylinder(h=core_d/2, d=wire_d);
	
	translate([0, -spool_d/2+thickness, 0])
		cylinder(h=thickness, d=wire_d);

	translate([0, 0, length-thickness])
		difference() {
			cylinder(h=thickness, d=core_d);
			cylinder(h=thickness, d=(core_d + core_hole_d)/2, $fn=6);
		};
}

translate([1,0,0])
	union() {
		translate([spool_d,0,0])
			difference() {
				side();
				cylinder(h=thickness, d=(core_d + core_hole_d)/2, $fn=6);
			};
	};
