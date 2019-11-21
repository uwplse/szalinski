//9mm x 11mm top
//5mm hole in cabinet

length=12;
width=12;
thickness=2;
hole_size=6.35;
hole_depth=8;
peg_sides = 8;

// L-shaped bracket
cube(size = [length, width, thickness], center = false);
translate([0, 0, 0])
	cube(size = [thickness, width, length], center = false);

// 45-degree triangle brace
difference(){
	translate([0, (width - thickness) / 2, 0])
		cube(size = [length, thickness, length], center = false);
	
	rotate([0, 45, 0])
		translate([-length, (width - thickness) / 2 - 1, sqrt(2) * (length + thickness) / 2])
			cube(size = [length * 2, thickness * 2, length * 2], center = false);
}

// Peg
peg_z = (hole_size / 2) * cos(360 / (peg_sides * 2));	// Cylinder's flat side: sit on z==0
translate([-hole_depth, 1 + (width-thickness) / 2, peg_z])
	rotate([0, 90, 0])
		rotate([0, 0, 360 / (peg_sides * 2)])	// Rotate so cylinder's flat side is on the bottom
			cylinder(r = hole_size/2, h = hole_depth, center = false, $fn = peg_sides);
