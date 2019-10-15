/* [Spiral] */

// Spiral vase height (mm).
height = 50;

// Total rotation of spiral from base to top (degrees).
twist = 310;

// Offset from axis at the base of the spiral (mm).
initial_spoke_radius = 16;

// Offset from axis at the top of the spiral (mm).
final_spoke_radius = 6;

// Radius of nodes at the base of the spiral (mm).
initial_node_radius = 18;

// Radius of nodes at the top of the spiral (mm).
final_node_radius = 14;

/* [Resolution] */

// Number of nodes comprising spiral. Smaller values produce a more segmented appearance.
spiral_steps = 24;

// Number of facets in 360 degrees. Larger values produce smoother surfaces but are slower to calculate.
sphere_resolution = 30;

// Represent spiral as individual spherical nodes or continuous tubular convex hull. Tubular mode is much slower to calculate.
node_mode = 0; // [0:Spherical, 1:Tubular]

/* [Pair Mode] */

// Enable pair mode to combine two instances of the spiral to generate more complex forms.
pair_mode = 1; // [0:Off, 1:On]

// X separation between central axes (mm).
x_gap = 0;

// Y separation between central axes (mm).
y_gap = 18;

// Rotation of each instance around its central axis (degrees). Applied before mirroring.
rotation = 45;

// Mirror instances across the X axis.
x_mirror = 1; // [0:Off, 1:On]

// Mirror instances across the Y axis.
y_mirror = 0; // [0:Off, 1:On]

/* [Hidden] */

$fn = sphere_resolution;

spoke_radius_step = (final_spoke_radius - initial_spoke_radius) / (spiral_steps - 1);
node_radius_step = (final_node_radius - initial_node_radius) / (spiral_steps - 1);
spoke_angle_step = twist / (spiral_steps - 1);
height_step = height / (spiral_steps - 1);

function x(r, a) = r * cos(a);
function y(r, a) = r * sin(a);

if (pair_mode == 1) {
	union() {
		translate([x_gap/2, y_gap/2, 0])
		rotate([0, 0, rotation])
		SpiralBlob();

		translate([-x_gap/2, -y_gap/2, 0])
		mirror([y_mirror, x_mirror, 0])
		rotate([0, 0, rotation])
		SpiralBlob();
	}
} else {
	SpiralBlob();
}

// Just a helper to illustrate spiral structure
module SpiralFrame() {
	
	// axis
	cylinder(r=1, h=height);
	
	// spokes
	for (i = [0 : spiral_steps - 1]) {
		translate([0, 0, i * height_step])
		rotate([0, 90, i * spoke_angle_step])
		cylinder(r=1, h=i * spoke_radius_step + initial_spoke_radius);
	}
}

// Chop the top and bottom off a raw spiral blob to make flat surfaces
module SpiralBlob() {
	//SpiralFrame();
	difference() {
		RawSpiralBlob();
	
		assign(
				bottom_chop = abs(initial_spoke_radius) + initial_node_radius,
				top_chop = abs(final_spoke_radius) + final_node_radius) {
	
	 		translate([0, 0, -initial_node_radius/2])
			cube([3 * bottom_chop, 3 * bottom_chop, initial_node_radius], center=true);
	
			translate([0, 0, height + (final_node_radius/2)])
			cube([3 * top_chop, 3 * top_chop, final_node_radius], center=true);
		}
	}
}

// A form comprised of blobs arranged in a spiral around the z axis
module RawSpiralBlob() {
	union() {
		if (node_mode == 1) {
			// Comprised either of convex hull segments representing each node pair...
			for (i = [0 : spiral_steps - 2]) {
				BlobHull(
						i,
						spoke_radius_step, initial_spoke_radius,
						spoke_angle_step,
						height_step,
						node_radius_step, initial_node_radius);
			}
		}
		else {
			// ...or simply a sphere representing each spiral node.
			for (i = [0 : spiral_steps - 1]) {
				BlobNode(
						i * spoke_radius_step + initial_spoke_radius,
						i * spoke_angle_step,
						i * height_step,
						i * node_radius_step + initial_node_radius);				
			}
		}
	}
}

// The tubular convex hull connecting two successive blob nodes
module BlobHull(i, spoke_radius_step, initial_spoke_radius, spoke_angle_step, height_step, node_radius_step, initial_node_radius) {
	hull() {
		BlobNode(
				i * spoke_radius_step + initial_spoke_radius,
				i * spoke_angle_step,
				i * height_step,
				i * node_radius_step + initial_node_radius);
		BlobNode(
				(i + 1) * spoke_radius_step + initial_spoke_radius,
				(i + 1) * spoke_angle_step,
				(i + 1) * height_step,
				(i + 1) * node_radius_step + initial_node_radius);
	}
}

// A single blob node (a sphere)
module BlobNode(spoke_radius, spoke_angle, spoke_height, node_radius) {
	translate([
			x(spoke_radius, spoke_angle),
			y(spoke_radius, spoke_angle),
			spoke_height])
	sphere(r=node_radius);
}