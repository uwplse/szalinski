// Set the initial viewport parameters
/*$vpr = [60, 0, 30];
$vpt = [10, 10, 30];
$vpd = 400;*/
$fn = 60;

outside = 71.5;
inside = 36;
width = 44;
thickness = 1.6;
brim = 7;

//draw the outer rim
difference() {
	translate([0, 0, 0])
		cylinder(h = width, r1 = outside/2, r2 = outside/2);
	translate([0, 0, 0])
		cylinder(h = width, r1 = (outside/2) - thickness, r2 = (outside/2) - thickness);
}

//draw the inner rim
difference() {
	translate([0, 0, 0])
		cylinder(h = width, r1 = (inside/2) + thickness, r2 = (inside/2) + thickness);
	translate([0, 0, 0])
		cylinder(h = width, r1 = inside/2, r2 = inside/2);
}

//draw the spokes
spokew = outside/2 - inside/2 - thickness;
spokex = inside/2 + (thickness/2);
for (i = [0:7]) {
	rotate([0, 0, 45*i]) translate([spokex, -thickness/4, 0])
		cube([spokew, thickness/2, width-thickness*3]);
}

//create the brim
difference() {
	difference() {
		translate([0, 0, 0])
			cylinder(h = 1.6, r1 = outside/2 + brim, r2 = outside/2 + brim - 0.3);
		translate([0, 0, 0])
			cylinder(h = 1.6, r1 = inside/2, r2 = inside/2);
	}
	filamentsaver = (outside/2-inside/2-4)/2;
	for (i = [0:7]) {
		rotate([0, 0, 45*i-45/2])
			translate([inside/2+filamentsaver+thickness*1.5, 0, 0])
				cylinder(h = 1.6, r1 = filamentsaver, r2 = filamentsaver);
	}
}