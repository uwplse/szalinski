/*
Creates a rounded half-sphere with mounting holes
that can be screwed to a board to create a balance board.
*/

// Whether the dome should be hollow or not
hollow = true;
// If hollow, how thick to make the walls:
outer_wall_thickness = 7;
// Width of rounded shape in millimeters.
sphere_diameter = 150;
// Factor to reduce rounded shape height by.  Lower is easier.
scrunch_factor = 0.75;
// The diameter of the screws you intend to use.
screw_diameter = 4;
// The area left for of the heads of the screws you intend to use.
screw_top_diameter = 7.5;
// Whether this is a wood screw with a tapered head.
wood_screw = true;
// Height of the tapered portion of the screw head.
screw_head_taper_height = 3;
// Amount of space in the hole around the screw's head.
screw_wiggle_room = 1.5;
// The number of screws you'd like to mount with.
screw_count = 5;
// The thickness of the shape that the screws have to grip to.
mount_height = 5;
// Number of facets on each rounded surface
resolution = 100;
// If hollow, the size of the fill hole at the bottom
fill_hole_radius = 15;

// Computed Properties
sphere_radius = sphere_diameter / 2;
screw_offset = sphere_radius - (screw_top_diameter);
screw_increment = 360 / screw_count;
screw_top_radius = screw_top_diameter / 2;
screw_radius = screw_diameter / 2;

// cutBlock is a block big enough to slice chunks off the sphere.
// It is oversized in x + y, so it is only suitable for Z-axis slicing.
module cutBlock() {
	cube([
		sphere_diameter,
		sphere_diameter,
		sphere_diameter * scrunch_factor,
	], center=true);
}

module ball(radius) {
	scale([1, 1, scrunch_factor])
	sphere(r=radius, $fn=resolution);
}

module halfSphere() {
	difference(){
		ball(sphere_diameter / 2);

		translate([0, 0, sphere_diameter * scrunch_factor * -0.5])
		cutBlock();
	}
}

module hollowHalfSphere() {
	difference () {
		halfSphere();

		ball((sphere_diameter - (outer_wall_thickness * 2)) / 2);
	}
}

module mountHoles() {
	for(i=[0:screw_count]) {
		rotate([0, 0, screw_increment * i])
		mountHole(screw_offset);
	}
}

module mountHoleSpaces() {
	for(i=[0:screw_count]) {
		rotate([0, 0, screw_increment * i])
		mountHoleSpace(screw_offset);
	}
}

module mountHoleSpace(offset) {
		// Wide cylinder down to screw hole
	translate([offset, 0, 0])
	cylinder(r=screw_top_radius + screw_wiggle_room + (outer_wall_thickness/2), h=sphere_radius, $fn=resolution);
}

module mountHole(offset) {

	if (wood_screw) {

		// Wide cylinder down to screw hole
		translate([offset, 0, mount_height + screw_head_taper_height])
		cylinder(r=screw_top_radius + screw_wiggle_room, h=sphere_radius, $fn=resolution);

		// Tapered wood screw cone
		color("green")
		translate([offset, 0, mount_height])
		cylinder(r1=screw_radius, r2=screw_top_radius, h=screw_head_taper_height, $fn=resolution);

	} else {

		// Wide cylinder down to screw hole
		translate([offset, 0, mount_height])
		cylinder(r=screw_top_radius + screw_wiggle_room, h=sphere_radius, $fn=resolution);
	}

	// Screw hole itself
	translate([offset, 0, 0])
	cylinder(r = (screw_diameter / 2), h=sphere_radius, $fn=resolution);
}

module bottomPlate() {
	difference() {
		intersection() {
			color([1,0,0], 0.5) {
				cylinder(r=sphere_radius, center=true, $fn=resolution);
			}
			halfSphere();
		}
		cylinder(r=fill_hole_radius, center=true);
	}
}

if (hollow) {
	difference() {
		union() { // The positive space

			color([0,1,0], 0.5) {
				hollowHalfSphere();
				intersection() {
					halfSphere();
					mountHoleSpaces();
				}
			}

			bottomPlate();
		}

		// The negative space
		mountHoles();
	}

} else {  // Non-hollow version of the design:
	difference(){
		halfSphere();
		color("blue")
		mountHoles();
	}
}
