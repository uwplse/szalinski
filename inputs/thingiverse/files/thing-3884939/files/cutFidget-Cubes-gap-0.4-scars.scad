// Settings for ultra small cube
//$fn = 32;
//gap = 0.4;
//size = 8;
//hinge_radius_ratio = 0.42;
//edge_bevel_size = 0.0;
//face_bevel_size = 0.0;
//hinge_wall_thickness = 0.8;
//hinge_pin_scale = 1.8;
//hinge_edge_thickness = 0.4;

// Settings for small cube
//$fn = 48;
//gap = 0.4;
//size = 15;
//hinge_radius_ratio = 0.3333;
//edge_bevel_size = 1.2;
//face_bevel_size = 1.2;
//hinge_wall_thickness = 2.0;
//hinge_pin_scale = 1.0;
//hinge_edge_thickness = 0.4;

// Settings for regular cube
//$fn = 48;
//gap = 0.4;
//size = 20;
//hinge_radius_ratio = 0.30;
//edge_bevel_size = 1.6;
//face_bevel_size = 1.6;
//hinge_wall_thickness = 2.4;
//hinge_pin_scale = 1.0;
//hinge_edge_thickness = 0.4;

// Select what kind object to generate. See thing documentation for details
subject = "cube"; // ["cube", "hinge_test_vertical", "hinge_test_bottom", "hinge_test_top", "solid_cube", "hinge", "hinge_hole", "gap_inspection", "gap_inspection2", "hinge_profile", "hinge_hole_profile", "hinge_gap_profile", "cube_profile"]

// [n] Level of detail. This value can be reduced to obtain faster previews. Don't go below 32 or you won't be able to print a working cube due to artifacts and facetted roundings.
$fn = 48;

// [mm] The minimal distance you can print without glueing neighboring objects together. This value will be used as distance between the cubes and within the mechanics. This is typically your nozzle size.
gap = 0.4;

// [mm] Size of a single cube (the gap will be subtracted)
size = 20;

// [ratio] Size of the hinge. Bigger values give thicker and longer hinges and hinge pins. Don't make this bigger than 0.45.
hinge_radius_ratio = 0.30;

// [mm] Amount of beveling on the cube's edges
edge_bevel_size = 1.6;

// [mm] Depth of the 'scars' across the cube's faces.
face_bevel_size = 0.4;

// [mm] Thickness of the walls that hold the hinge pins. Should be a multiple of the nozzle size. Affects the width of the hinges
hinge_wall_thickness = 2.4;

// [ratio] Changes the length of the pin. Higher values result in less play, but the hinges will be harder to break free.
hinge_pin_scale = 1;

// [mm] This flattens the pin-hole-edge of the hinge. Bigger values make the pin less visible but smaller and shorter. Don't make this smaller than your nozzle size or the edge will get eaten up by the slicer.
hinge_edge_thickness = 0.4;

e = 1 / 1024;
ee = 2 * e;
__ = gap;
_ = 0.5 * __;

hsize = 0.5 * size;
size__ = size - __;
hsize_ = hsize - _;
radius = hinge_radius_ratio * hsize_;
hole_radius = radius + __;
hinge_axis_position = hsize_ - radius;
hinge_linear_length = 2 * radius + __;
hinge_hwidth = hsize_ - hinge_wall_thickness - __;
hinge_width = 2 * hinge_hwidth; //size__ - 2 * hinge_wall_thickness - 2 * __;
hinge_hole_hwidth = hinge_hwidth + __;
hinge_hole_width = 2 * hinge_hole_hwidth;
delta = (size__/4);
//delta = 4.5;

module edge_deco_profile(size = edge_bevel_size, e = e) {
	polygon([[-e, -e], [-e, size + e], [size + e, -e]]);
}

module face_deco_profile(size = face_bevel_size, e = e) {
	polygon([[size, 0], [-e, -size - e], [-e, size + e]]);
}

module hinged_face_profile() {
	difference() {
		// the main square
		translate([-hsize_ - e, -hsize_ - e]) square([size__ + e, size__ + e]);
		
		// bevel the corners (later edges in 3D)
		if (edge_bevel_size > 0) {
			translate([-hsize_, -hsize_]) rotate(0 * 90) edge_deco_profile(edge_bevel_size, 2 * e);
			translate([+hsize_, -hsize_]) rotate(1 * 90) edge_deco_profile(edge_bevel_size, 2 * e);
			translate([+hsize_, +hsize_]) rotate(2 * 90) edge_deco_profile(edge_bevel_size, 2 * e);
			translate([-hsize_, +hsize_]) rotate(3 * 90) edge_deco_profile(edge_bevel_size, 2 * e);
		}

		// bevel the sides (later faces in 3D)
		if (face_bevel_size > 0) {
			translate([-hsize_, 0]) rotate(0 * 90) face_deco_profile(face_bevel_size, 2 * e);
			translate([0, -hsize_]) rotate(1 * 90) face_deco_profile(face_bevel_size, 2 * e);
			translate([+hsize_, 0]) rotate(2 * 90) face_deco_profile(face_bevel_size, 2 * e);
			translate([0, +hsize_]) rotate(3 * 90) face_deco_profile(face_bevel_size, 2 * e);
		}
		
		// rounded corner
		translate([hinge_axis_position, hinge_axis_position])
		difference() {
			square([hsize_ + e, hsize + e]);
			circle(r = radius);
		}
	}
}

module my_hinged_face_profile() {
	difference() {
		// the main square
//		translate([-hsize_ - e, -hsize_ - e]) square([size__ + e, size__ + e]);
        translate([-hsize_ - e, -hsize_ - e]) polygon(points=[[0,0],[size__ + e,0],[size__ + e, delta],[delta ,size__ + e],[0,size__ + e]],paths=[[0,1,2,3,4]]);
//		translate([-hsize_ - e, -hsize_ - e]) polygon(points=[[0,0],[size__ + e,0],[0,size__ + e]], paths=[[0,1,2]]);
		
		// bevel the corners (later edges in 3D)
		if (edge_bevel_size > 0) {
			translate([-hsize_, -hsize_]) rotate(0 * 90) edge_deco_profile(edge_bevel_size, 2 * e);
			translate([+hsize_, -hsize_]) rotate(1 * 90) edge_deco_profile(edge_bevel_size, 2 * e);
			translate([+hsize_, +hsize_]) rotate(2 * 90) edge_deco_profile(edge_bevel_size, 2 * e);
			translate([-hsize_, +hsize_]) rotate(3 * 90) edge_deco_profile(edge_bevel_size, 2 * e);
		}

		// bevel the sides (later faces in 3D)
		if (face_bevel_size > 0) {
			translate([-hsize_, 0]) rotate(0 * 90) face_deco_profile(face_bevel_size, 2 * e);
			translate([0, -hsize_]) rotate(1 * 90) face_deco_profile(face_bevel_size, 2 * e);
			translate([+hsize_, 0]) rotate(2 * 90) face_deco_profile(face_bevel_size, 2 * e);
			translate([0, +hsize_]) rotate(3 * 90) face_deco_profile(face_bevel_size, 2 * e);
		}
		
		// rounded corner
		translate([hinge_axis_position, hinge_axis_position])
		difference() {
			square([hsize_ + e, hsize + e]);
			circle(r = radius);
		}
	}
}

module solid_cube() {
	intersection() {
		rotate([ 0, 90,   0]) linear_extrude(height = size, center = true) hinged_face_profile();
		rotate([90, 0,  180]) linear_extrude(height = size, center = true) hinged_face_profile();
		rotate([ 0, 0,  -90]) linear_extrude(height = size, center = true) my_hinged_face_profile();
	}
}

module hinge_pin_hole_profile() {
	polygon(points = [	
		[radius - hinge_edge_thickness + e,  hinge_hwidth + e],
		[0                            ,  hinge_hwidth - (radius - hinge_edge_thickness) * hinge_pin_scale],
		[0                            ,  hinge_hwidth + e],
	]);
}

module hinge_profile() {
	difference() {
		translate([0, -hinge_hwidth]) square([radius, hinge_width]);
		translate([radius, 0, 0]) mirror() face_deco_profile(face_bevel_size);
	}
}

module hinge_full_profile() {
	hinge_profile();
	mirror()
	hinge_profile();
}

module hinge_hole_profile() {
	difference() {
		translate([0, -hinge_hole_hwidth]) square([hole_radius, hinge_hole_width]);
		translate([radius + __, 0, 0]) mirror() face_deco_profile(face_bevel_size);
	}
}

module hinge_pin_profile() {
	polygon(points = [
		[radius - hinge_edge_thickness + e,  hinge_hwidth + __ + e],
		[0,  hinge_hwidth - (radius - hinge_edge_thickness) * hinge_pin_scale + __],
		[0,  hinge_hwidth + __ + e],
	]);
}

module hinge_hole_full_profile() {
	hinge_hole_profile();
	mirror()
	hinge_hole_profile();
}

module hinge() {
	difference() {
		union() {
			translate([0, -0.5 * hinge_linear_length, 0])
			rotate(180)
			rotate_extrude(angle = 180, convexity = 4)
			hinge_profile();

			translate([0, 0.5 * hinge_linear_length, 0])
			rotate_extrude(angle = 180, convexity = 4)
			hinge_profile();

			rotate([90, 0, 0])
			linear_extrude(height = hinge_linear_length, center = true)
			hinge_full_profile();
		}
		
		translate([0, -0.5 * hinge_linear_length]) rotate_extrude() hinge_pin_hole_profile();
		translate([0, 0.5 * hinge_linear_length]) rotate_extrude() hinge_pin_hole_profile();
		translate([0, -0.5 * hinge_linear_length]) mirror([0, 0, 1]) rotate_extrude() hinge_pin_hole_profile();
		translate([0, 0.5 * hinge_linear_length]) mirror([0, 0, 1]) rotate_extrude() hinge_pin_hole_profile();
	}
}

module hinge_hole() {
	difference() {
		union() {
			translate([0, -0.5 * hinge_linear_length, 0])
			rotate(180)
			rotate_extrude(angle = 180, convexity = 4)
			hinge_hole_profile();

			translate([0, 0.5 * hinge_linear_length, 0])
			rotate_extrude(angle = 180, convexity = 4)
			hinge_hole_profile();

			rotate([90, 0, 0])
			linear_extrude(height = hinge_linear_length, center = true)
			hinge_hole_full_profile();
			
			translate([0, 0.5 * hinge_linear_length, 0])
			rotate([90, 0, 90])
			linear_extrude(height = hole_radius)
			hinge_hole_profile();
			
			translate([0, -0.5 * hinge_linear_length, 0])
			rotate([-90, 0, -90])
			linear_extrude(height = hole_radius)
			hinge_hole_profile();

			translate([0.5 * hole_radius, 0, 0])
			cube([hole_radius, hinge_linear_length, hinge_hole_width], center = true);
		}
		
		translate([0, -0.5 * hinge_linear_length]) rotate_extrude() hinge_pin_profile();
		translate([0, 0.5 * hinge_linear_length]) rotate_extrude() hinge_pin_profile();
		translate([0, -0.5 * hinge_linear_length]) mirror([0, 0, 1]) rotate_extrude() hinge_pin_profile();
		translate([0, 0.5 * hinge_linear_length]) mirror([0, 0, 1]) rotate_extrude() hinge_pin_profile();
	}
}

module two_cubes() {
	translate([-1.5 * size, -0.5 * size, 0]) rotate([0, 0, -90]) solid_cube();
	translate([-0.5 * size, -0.5 * size, 0]) rotate([0, 90, 180]) mirror() solid_cube();
}

module four_cubes() {
	two_cubes();
	mirror([0, 1, 0])
	two_cubes();
}

module eight_cubes() {
	four_cubes();
	mirror([1, 0, 0])
	four_cubes();
}

module fidget_cubes() {
	difference() {
		eight_cubes();

		translate([0, -0.5 * size - hinge_axis_position, 0]) rotate([0, 0, -90]) hinge_hole();
		translate([0, +0.5 * size + hinge_axis_position, 0]) rotate([0, 0, 90]) hinge_hole();

		translate([-1.5 * size, 0, hinge_axis_position]) rotate([0, -90, 0]) hinge_hole();
		translate([+1.5 * size, 0, hinge_axis_position]) rotate([0, -90, 0]) hinge_hole();

		translate([-1 * size, -0.5 * size, -hinge_axis_position]) rotate([90, 90, 0]) hinge_hole();
		translate([-1 * size, +0.5 * size, -hinge_axis_position]) rotate([90, 90, 0]) hinge_hole();
		translate([+1 * size, -0.5 * size, -hinge_axis_position]) rotate([90, 90, 0]) hinge_hole();
		translate([+1 * size, +0.5 * size, -hinge_axis_position]) rotate([90, 90, 0]) hinge_hole();
	}

	translate([0, -0.5 * size - hinge_axis_position, 0]) rotate([0, 0, -90]) hinge();
	translate([0, +0.5 * size + hinge_axis_position, 0]) rotate([0, 0, 90]) hinge();

	translate([-1.5 * size, 0, hinge_axis_position]) rotate([0, -90, 0]) hinge();
	translate([+1.5 * size, 0, hinge_axis_position]) rotate([0, -90, 0]) hinge();

	translate([-1 * size, -0.5 * size, -hinge_axis_position]) rotate([90, 90, 0]) hinge();
	translate([-1 * size, +0.5 * size, -hinge_axis_position]) rotate([90, 90, 0]) hinge();
	translate([+1 * size, -0.5 * size, -hinge_axis_position]) rotate([90, 90, 0]) hinge();
	translate([+1 * size, +0.5 * size, -hinge_axis_position]) rotate([90, 90, 0]) hinge();
}

module test_cubes(angle = 0) {
	rotate([angle, 0, 0]) {
		difference() {
			union() {
				translate([-0.5 * size, 0, 0]) rotate([0, 0, -90]) solid_cube(false, true);
				translate([0.5 * size, 0, 0]) rotate([0, 90, 180]) mirror() solid_cube(true, false);
			}
			translate([0, 0, -hinge_axis_position]) rotate([90, 90, 0]) hinge_hole();
		}
		translate([0, 0, -hinge_axis_position]) rotate([90, 90, 0]) hinge();
	}
}

if (subject == "hinge_test_vertical") {
	translate([0, 0, hsize_])
	test_cubes(90);
} else if (subject == "hinge_test_bottom") {
	translate([0, 0, hsize_])
	test_cubes(0);
} else if (subject == "hinge_test_top") {
	translate([0, 0, hsize_])
	test_cubes(180);
} else if (subject == "solid_cube") {
	translate([0, 0, hsize_])
	solid_cube();
} else if (subject == "hinge") {
	translate([0, 0, radius])
	rotate([0, 90, 0])
	hinge();
} else if (subject == "hinge_hole") {
	translate([0, 0, radius])
	rotate([0, 90, 0])
	hinge_hole();
} else if (subject == "gap_inspection") {
	translate([-size, -0.5 * size, 0])
	intersection() {
		mirror([0, 1, 0])
		mirror([1, 0, 0]) {
			difference() {
				two_cubes();
				translate([0, -0.5 * size - hinge_axis_position, 0]) rotate([0, 0, -90]) hinge_hole();
				translate([-1.5 * size, 0, hinge_axis_position]) rotate([0, -90, 0]) hinge_hole();
			}
			translate([0, -0.5 * size - hinge_axis_position, 0]) rotate([0, 0, -90]) hinge();
			translate([-1.5 * size, 0, hinge_axis_position]) rotate([0, -90, 0]) hinge();
		}
		cube(size * 2);
	}
} else if (subject == "gap_inspection2") {
	difference() {
		hinge_hole();
		hinge();
		cube([size, size, size]);
	}
} else if (subject == "hinge_profile") {
	hinge_profile();
} else if (subject == "hinge_hole_profile") {
	hinge_hole_profile();
} else if (subject == "hinge_gap_profile") {
	difference() {
		hinge_hole_profile();
		hinge_profile();
	}
} else if (subject == "cube_profile") {
	hinged_face_profile();
} else {
	translate([0, 0, hsize_])
	fidget_cubes();
}
