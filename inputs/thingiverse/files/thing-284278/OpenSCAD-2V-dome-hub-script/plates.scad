// Script to create hubs for a 2V dome using a certain rod size.
// Dome requires 20 six hole hubs and 6 five hole hubs.
// Will require 35 A (long) and 30 B (short) rods.
// A/B rod ratio is about 1.131:1.
// Six hole hubs are used instead of four hole hubs for base.
// See here for more info http://www.desertdomes.com/dome2calc.html

// preview
part = 56; // [56:both,5:penta,6:hexa]
function opt(x) = search(str(x), str(part)); // part helper.
// diameter in mm. e.g. 3.5 = bamboo skewer.
rod = 3.5;

main(rod);

module main(rod) {
	$fn = 48; // Cylinder faces.
	space = 5; // Space between parts.
	if (opt(5)) 
		plate(5, rod); // 5 hole plate.
	if (opt(6)) 
		translate([(rod*4) + space, 0, 0]) plate(6, rod); // 6 hole plate off to the right.
}

module plate(num, rod) {
	// Create a cylinder and put holes in it.
	difference() {
		hub(rod);
		holes(num, rod);
	}
}

module hub(rod) {
	// Make cylinder big enough to fit rods.
	cylinder(h = (rod * 2) - 1, r = rod * 2);
}

module holes(num, rod) {
	// Put holes in cylinder and tilt them.
	angle = 16; // approximate.
	for (i= [1:num]) {
		rotate([angle,0,360 / num * i]) hole(rod);
	}
}
module hole(rod) {
	// Single cylinder.
	rotate([90, 0, 0])
	translate([0, rod + rod / 4, rod / 2])
	cylinder(r = rod / 2, h = rod * 2);
}

