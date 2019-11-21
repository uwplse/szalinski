// configured
// part
which = "pot"; // [pot:pot,brim:brim,both:both]
// top
diameter = 195;
// height
height = 170;
// taper
ratio = .95;
// thickness
wall = 2.4;
// mesh hole
size = 5;
// hole
shape = "cylinder"; // [cube:Square,cylinder:Circle]
// smoothing
$fn = 24;
// brim
girth=3;
// brim
thickness=2.4;
// derived
radius = diameter / 2;
circumference = PI * diameter;
// function
function space() = shape=="cube" ? size / 1.4142 : size;
// procedures
main();
module main() {
	both = which == "both";
	if (both || which == "pot") {
		difference() {
			pot();
			mesh();
		}
	}
	if (both || which == "brim") {
		brim();
	}
}
module brim() {
	position = diameter + radius;
	translate([0,0,thickness])
	difference() {
		translate([position, 0, -thickness])
			cylinder(r = radius + wall + girth, h = thickness);
		translate([position, 0, -height + wall])
			cup(radius);
	}
}
module mesh() {
	// perforate vessel
	// fit as many as can be around in a row, the smallest row
	count = circumference * ratio / (space() + space() / 2);
	step = 360 / count;
	for (i = [0 : step : 360 - step]) {
		rotate([0, 0, i]) {
			holes();
		}
	}
}
module holes() {
	// single column of holes
	// fit as many as can be top to bottom in a column
	steps = (height - wall) / (space() + space() / 2);
	stepsize = space() + space() / 2;
	// do not overlap these and create many unions or gcal will choke (#350)
	// stagger inward based on taper
	offset = (diameter - (diameter * ratio)) / steps / 2;
	function stagger(_i) = (steps - _i) * offset;
	for(i = [1 : 1 : steps]) {
		translate([0, stagger(i), stepsize * i - space() / 2])
			shaft();
	}
}
module shaft() { 
	// single hole
	rotate([90, 45, 0]) {
		if (shape == "cube") {
			translate([0, 0, radius])
			cube([space(), space(), radius / 2], center = true);
		}
		else {
			translate([0, 0, radius])
			cylinder(r = space()/2, h = radius / 2, center = true );
		}
	}
}
module pot() {
	// create vessel and hollow it
	difference() {
		cup(radius);
		translate([0, 0, wall])
			cup(radius - wall);
		translate([0,0,height])
			cylinder(r = radius + wall, h=wall);
	}
}
module cup(_radius) {
	// create tapered shape
	hull() {
		cylinder(r = _radius * ratio);
		translate([0, 0, height]) cylinder(r = _radius);
	}
}

