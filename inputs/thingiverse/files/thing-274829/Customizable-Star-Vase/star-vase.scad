// Customizable Star Vase

star_points = 5;

// Radius from center to tips of the star, as measured at base of vase.
tip_radius = 20;

// Radius from center to indentations between tips of the star, as measured at base of vase. Typically less than tip radius. The smaller the indent radius, the pointier the star.
indent_radius = 13;

vase_height = 60;

// Clockwise rotation applied to top relative to base (degrees).
vase_twist = 36;

// Scale factor applied to tip radius to determine top radius.
vase_scale = 1.42;

// Make more complex shapes by merging the vase with reflected versions of itself.
mirroring = 2; // [0:None, 1:X, 2:Y, 3:Both]


union() {

	StarVase();

	if (mirroring != 0) {
		mirror([mirroring == 1 || mirroring == 3 ? 1 : 0, mirroring == 2  || mirroring == 3 ? 1 : 0, 0]) StarVase();
	}
}

module StarVase() {
	linear_extrude(height=vase_height, twist=vase_twist, scale=vase_scale, slices=vase_height)
	Star(points=star_points, outer=tip_radius, inner=indent_radius);
}

// points = number of points
// outer  = radius to outer points
// inner  = radius to inner points
module Star(points, outer, inner) {
	
	// polar to cartesian: radius/angle to x/y
	function x(r, a) = r * cos(a);
	function y(r, a) = r * sin(a);
	
	// angular width of each pie slice of the star
	increment = 360/points;
	
	union() {
		for (p = [0 : points-1]) {
			
			// outer is outer point p
			// inner is inner point following p
			// next is next outer point following p

			assign(	x_outer = x(outer, increment * p),
					y_outer = y(outer, increment * p),
					x_inner = x(inner, (increment * p) + (increment/2)),
					y_inner = y(inner, (increment * p) + (increment/2)),
					x_next  = x(outer, increment * (p+1)),
					y_next  = y(outer, increment * (p+1))) {
				polygon(points = [[x_outer, y_outer], [x_inner, y_inner], [x_next, y_next], [0, 0]], paths  = [[0, 1, 2, 3]]);
			}
		}
	}
}