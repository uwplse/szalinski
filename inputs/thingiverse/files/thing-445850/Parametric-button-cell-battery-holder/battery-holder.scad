battery_diam = 12;
battery_width = 5.5;
battery_count = 3;
wire_hole_diam = 1;
wire_hook_width = 1.5;
wire_hook_height = 1.5;

///

$fn=50;
length = battery_width * battery_count;

union() {
	difference() {
		union() {
			translate([-length/2-2,-battery_diam/2-2,-battery_diam/2-2]) cube([length+4, battery_diam+4, battery_diam/2+2]);
		}

		union() {
			translate([0,0,0]) rotate(90, [0,1,0]) cylinder(r=battery_diam/2, h=length, center=true);
			translate([-length/2+wire_hole_diam/2,0,-battery_diam/2+wire_hole_diam/2]) rotate(90, [1,0,0]) cylinder(r=wire_hole_diam/2, h=battery_diam+6, center=true);
			translate([length/2-wire_hole_diam/2,0,-battery_diam/2+wire_hole_diam/2]) rotate(90, [1,0,0]) cylinder(r=wire_hole_diam/2, h=battery_diam+6, center=true);
		}
	}

	difference() {
		union() {
			translate([-length/2-2, 0, 0]) rotate(90, [0,1,0]) cylinder(r=battery_diam/2+2, h=2);
			translate([+length/2, 0, 0]) rotate(90, [0,1,0]) cylinder(r=battery_diam/2+2, h=2);
		}

		union() {
			translate([0,wire_hook_width,battery_diam/2+2-wire_hook_height/2]) cube([length+5,wire_hook_width,wire_hook_height], center=true);
			translate([0,-wire_hook_width,battery_diam/2+2-wire_hook_height/2]) cube([length+5,wire_hook_width,wire_hook_height], center=true);
		}
	}
}