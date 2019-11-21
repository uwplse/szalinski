$fn=10;

// Radius of a single link before it's turned into an oval.
link_radius = 100;

// Number of links in your chain.
number_of_links= 14;

// Amount to bevel the edges. 0 means no bevel.
bevel_size = .1;

chain(number_of_links, link_radius, bevel_size);

module base_link(radius) {
	difference() {
		cylinder(h=radius * .5, r=radius, center=true);
		cylinder(h=radius * 1.1, r=radius *.85, center=true);
	}
}

module bevel_link(ring_radius, size) {
	minkowski() {
		base_link(ring_radius);
		sphere(ring_radius * size);
	}
}

module oval_link(radius, bevel) {
	if (bevel == 0) {
		scale([1, 1.5, .5]) base_link(radius);
	}
	if (bevel != 0) {
		scale([1, 1.4, .5]) bevel_link(radius, bevel);
	}
}

module chain_link(radius, bevel) {
	rotate([0, -22.5, 0]) translate([0, -(radius*.5), 0]) {
		rotate([0, 0, 10]) oval_link(radius);
		rotate([0, 45, -10]) {
			translate([0, radius*1.5, -3]) oval_link(radius, bevel);
		}
	}
}

module chain(links, link_radius, bevel) {
	loop = links/2;
	for (i = [1:1:loop]) {
		rotate([0, 0, i*360/loop]) translate([-link_radius*(loop/2), 0, 0]) {
			chain_link(link_radius, bevel);
		}
	}
}