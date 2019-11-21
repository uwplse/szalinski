// Outer diameter of roller bearings. (mm)
bearing_outer_diameter = 22;

// Inner diameter of roller bearings. Determines diameter of bearing mounting pegs. (mm)
bearing_inner_diameter = 7.75;

// Diameter of pilot holes for bearing mounting screws. (mm)
bearing_screw_diameter = 2.5;

// Minimum size of bearing flange formed by bracket body. Keeps spool on bracket. (mm)
bearing_lip = 2;

// Minimum thickness of bracket frame. (mm)
bracket_width = 6;

// Width of socket into which the bracket is press fit. (mm)
socket_x = 76;

// Depth of socket into which the bracket is press fit. (mm)
socket_y = 25;

// Width of inner spool (should be less than socket width). (mm)
inner_spool = 59;

// Width of outer spool (should be greater than socket width). (mm)
outer_spool = 90;


bearing_zone = bearing_outer_diameter + (2 * bearing_lip);
lower_stack = max(socket_y, bearing_zone);

// Curved corner reinforcements
module Brace() {
	scale([bearing_outer_diameter/2, bearing_outer_diameter/2, bearing_outer_diameter/2])
	rotate([0, 0, 180])
	translate([-1, -1, -1])
	difference() {
		polyhedron(
			points=[
				[1, 1, 0],
				[1, 1, 1],
				[1, 0, 1],
				[0, 1, 1]
			],
			triangles=[
				[0, 1, 2],
				[3, 0, 2],
				[3, 1, 0],
				[1, 3, 2]
			]
		);
		sphere(r = sqrt(2), $fn = 60, center=true);
	}
}

module Braces() {
	// inner spool braces
	translate([-inner_spool/2, bracket_width, bearing_zone/2]) Brace();
	translate([-inner_spool/2, bracket_width, -bearing_zone/2]) mirror([0, 0, 1]) Brace();
	translate([inner_spool/2, bracket_width, bearing_zone/2]) mirror([0, 0, 1]) rotate([0, 180, 0]) Brace();
	translate([inner_spool/2, bracket_width, -bearing_zone/2]) rotate([0, 180, 0]) Brace();

	// outer spool braces
	translate([-outer_spool/2, lower_stack + bracket_width, bearing_zone/2]) Brace();
	translate([-outer_spool/2, lower_stack + bracket_width, -bearing_zone/2]) mirror([0, 0, 1]) Brace();
	translate([outer_spool/2, lower_stack + bracket_width, bearing_zone/2]) mirror([0, 0, 1]) rotate([0, 180, 0]) Brace();
	translate([outer_spool/2, lower_stack + bracket_width, -bearing_zone/2]) rotate([0, 180, 0]) Brace();
}

module Axle() {
	rotate([0, 90, 0]) cylinder(d=bearing_screw_diameter, h= outer_spool + (2 * bracket_width) + 1, center=true, $fn=30);
}

module BevelButton(diameter = 8, flat = 2, height = 3) {
	assign(inset = (diameter - flat)/2, radius = diameter/2)
	// this intersection operation seems to leave a micro gap 
	intersection() {
		rotate([90, 0, 0])
		linear_extrude(height=diameter, center=true)
		polygon(points=[
			[-radius, 0	],
			[inset - radius, height],
			[radius - inset, height],
			[radius, 0]
		]);
		cylinder(h=height, r=radius, $fn=30);
	}
}

module BracketStock() {
	difference() {
		union() {
			linear_extrude(height=bearing_zone, center=true) BracketPattern();
			
			// bearing holders
			translate([-inner_spool/2, lower_stack + bracket_width - bearing_zone/2, 0]) rotate([90, 90, 90]) BevelButton(bearing_inner_diameter, bearing_screw_diameter);
			translate([inner_spool/2, lower_stack + bracket_width - bearing_zone/2, 0]) rotate([-90, 90, 90]) BevelButton(bearing_inner_diameter, bearing_screw_diameter);
			translate([-outer_spool/2, lower_stack + bracket_width + bearing_zone/2, 0]) rotate([90, 90, 90]) BevelButton(bearing_inner_diameter, bearing_screw_diameter);
			translate([outer_spool/2, lower_stack + bracket_width + bearing_zone/2, 0]) rotate([-90, 90, 90]) BevelButton(bearing_inner_diameter, bearing_screw_diameter);
		}

		// inner spool axle hole
		translate([0, lower_stack + bracket_width - bearing_zone/2, 0]) Axle();
		
		// outer spool axle hole
		translate([0, lower_stack + bracket_width + bearing_zone/2, 0]) Axle();
	}
}

module BracketPattern() {
	pts = [
		[0, socket_x/2],
		[socket_y, socket_x/2],
		[socket_y, outer_spool/2 + bracket_width],
		[lower_stack + bracket_width + bearing_zone, outer_spool/2 + bracket_width],
		[lower_stack + bracket_width + bearing_zone, outer_spool/2],
		[lower_stack + bracket_width, outer_spool/2],
		[lower_stack + bracket_width, inner_spool/2],
		[bracket_width, inner_spool/2],
		[bracket_width, 0],
		[0, 0]
	];
	rotate([0, 0, 90]) union() {
		polygon(points=pts);
		mirror([0, 1, 0]) polygon(points=pts);
	}
}

rotate([0, 0, 180])
translate([0, 0, bearing_zone/2])
union() {
	BracketStock();
	Braces();
}