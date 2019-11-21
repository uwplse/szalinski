// Customizable Clip

// For clipping together wires, etc.

// Gap between ends
gap=0.5;
// Thickness of clip
thickness=2;
// Inner diameter of clip
diameter=7;
// Number of sides
sides=3; //[3:32]

$fn=sides;

difference() {
	rotate([0,0,360/sides/2]) cylinder(r=diameter/2+thickness, h=thickness);
	translate([0,0,-1]) {
		rotate([0,0,360/sides/2]) cylinder(r=diameter/2, h=thickness+2);
		translate([0,-gap/2,0]) cube([diameter,gap,thickness+2]);
		}
	}