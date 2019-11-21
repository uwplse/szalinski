// recursion level
iterations = 1;
// smallest pentagon side
element_size = 1;
// height of extrusion
extrusion = 1;
// up color
color_up = "crimson";
// down color
color_down = "black";
// fudge
fudge = 0.001;

/* [Holes] */
// holes presence
drilled = 1; // [0:1]
// holes relative radius
drill_radius = 0.262865556;
// holes resolution
drill_resolution = 20;

/* [Lentils] */
// round top
round_top = 1; // [0:1]
// round bottom
round_bottom = 0; // [0:1]
// round resolution
round_resolution = 30;

golden_cut = (sqrt(5) - 1) / 2;	 // 0.618033989
gc_pow_3 = pow(golden_cut, 3);
leg_span = element_size / 2;		 // 0.5
leg_drop = leg_span / tan(36);		 // 0.68819096
radius = leg_span / sin(36);		 // 0.850650808
wing_span = leg_span / golden_cut; // 0.809016994
wing_lift = radius * sin(18);		 // 0.262865556
shift_inner = - 2 * leg_drop;
shift_outer = radius + 2 * leg_drop;
fill_scale = pow(golden_cut, 3);	 // 0.236067978
fill_shift = 2 * (leg_drop + radius + wing_lift); // 3.603414648
extrude_ratio = (4 - round_top - round_bottom) / 4;
drill_radius_sized = drill_radius * element_size;

scale(pow(gc_pow_3, -(1 + iterations))) 
poly(iterations, true);

// 10 pentagons
module poly(i, c) {
	scale(gc_pow_3)
	for (r = [0 : 4]) rotate([0, 0, r * 72]) {
		translate([0, shift_inner]) mirror([0, 1, 0]) penta(i, !c);
		translate([0, shift_outer]) penta(i, c);
		if (i > 0) 	scale(fill_scale) translate([0, fill_shift]) penta(i - 1, c);
	}
}

// 1 pentagon
module penta(i, c) {
	if (i > 0) {
		poly(i - 1, c);
	} else {
		color(c ? color_down : color_up)
		rotate([0, 0, 72]) // triangulation alignment
		bevel(extrusion) scale(1 + fudge)
			polygon([
				[0, -radius],
				[-wing_span, -wing_lift],
				[-leg_span, leg_drop],
				[leg_span, leg_drop],
				[wing_span, -wing_lift],
			]);
	}
}

// extrusion, drilling, ...
module bevel(height) {
	h4 = height / 4;
	h8 = height / 8;
	difference() {
		union() {
			translate([0, 0, round_bottom ? h4 : 0])
				linear_extrude(height * extrude_ratio) children();
			if (round_top) intersection() {
				translate([0, 0, 3 * h4 - fudge])
					linear_extrude(h4 - fudge) children();
				translate([0, 0, 3 * h4 - fudge]) resize([0, 0, 2 * h4])
					sphere(r = radius + fudge, $fn = round_resolution);
			}
			if (round_bottom) intersection() {
				translate([0, 0, + fudge])
					linear_extrude(h4 - fudge) children();
				translate([0, 0, h4 + fudge]) resize([0, 0, 2 * h4])
					sphere(r = radius + fudge, $fn = round_resolution);
			}
		}
		if (drilled) {
			translate([0, 0, -2 * h4])
				cylinder(r = drill_radius_sized, h = 2 * height, $fn = drill_resolution);
			if (round_top) translate([0, 0, 9 * h8 - fudge]) resize([0, 0, 4 * h8])
				sphere(r = radius / 2 + fudge, $fn = round_resolution);
			if (round_bottom) translate([0, 0, -h8 + fudge]) resize([0, 0, 4 * h8])
				sphere(r = radius / 2 + fudge, $fn = round_resolution);
		}
	}
}
