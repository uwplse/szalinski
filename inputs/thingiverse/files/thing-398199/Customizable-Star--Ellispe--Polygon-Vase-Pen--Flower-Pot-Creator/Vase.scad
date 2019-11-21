//Vase Shape
shape = "ellipse"; // [polygon, ellipse, star]

//Polygon Sides or Star Points
sides = 5; // [3:20]

//Angle to Rotate (in degrees)
twist = 360; // [0:720]

//Vase Height (in mm)
height = 100;

//Base Radius (in mm)
base = 50; // [10:150]

//Base2 (Inner Star/small Ellipse in mm)
base2 = 35; // [10:150]

//Top Radius (in mm)
top = 70; // [10:200]

//Double Twist (opposite rotation) 
anti = "no"; // [yes, no]

//Layer Height (in mm)
layerheight = .24; // [0.2, 0.24, 0.5, 1, 2, 5, 10]

/* [Hidden] */

$fs=0.8; // def 1, 0.2 is high res
$fa=4;//def 12, 3 is very nice

slices = height/layerheight;
scale = top/base;

module ngon(sides, radius, center=false){
    rotate([0, 0, 360/sides/2]) circle(r=radius, $fn=sides, center=center);
}

module ellipse(width, height) {
  scale([1, height/width, 1]) circle(r=width/2);
}

//from https://gist.github.com/anoved/9622826 star.scad
module star(points, outer, inner) {
	function x(r, a) = r * cos(a);
	function y(r, a) = r * sin(a);
	increment = 360/points;
	union() {
		for (p = [0 : points-1]) {
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

module vase(base, base2, top, height, twist, scale, slices, shape, sides){
	linear_extrude(
		height = height, 
		center = true, 
		convexity = 10, 
		twist = twist, 
		scale=scale, 
		slices=slices){
		if (shape == "polygon") {
			ngon(sides, base, true);
		}else if (shape == "ellipse"){
			ellipse(base, base2);
		}else if (shape == "star"){
			star(sides, base, base2);
		}
	}
}

vase(base, base2, top, height, twist, scale, slices, shape, sides);

if (anti == "yes") {
rotate((360/sides)/2)
	vase(base, base2, top, height, -twist, scale, slices, shape, sides);
}