// Copyright 2016 Luciano Montanaro <mikelima@cirulla.net>

// [Global]

// Generate pot, saucer or both
print="both"; // [pot:Pot only,saucer:Saucer only,both:Both Pot and Saucer]

// Preview mode avoids lengthy rendering
preview = 1; // [0, 1]

// Width of the base
base_width = 160; // [50:200]

// Width at the top
top_width = 185;  // [50:200]

// Depth of the pot
depth = 120;      // [50:200]

// Wall thickness
thickness = 1.5;  // [1.0:5.0]

// Shape of the base
shape = "elliptical";  // [elliptical,hexagonal,round,octagonal,cloud,square]

// [Pot]
// Height of the pot
pot_height = 60;      // [5:200]

// Profile of the base: Linear, C shaped, S shaped
pot_profile = "c"; // [l:Linear,c:C shaped,s:S shaped]

// [Saucer]
// Saucer height
saucer_height = 8; // [5:20]

saucer_profile = "l"; // Strings: [l,c,s]


function profile(profile) =
profile == "c" ? [[0.0, 1.0], [0.05, 1.03], [0.1, 1.04], [0.9, 1.04], [0.95, 1.03], [1.0 ,1.0]] :
profile == "s" ? [[0.0, 1.0], [0.05, 1.03], [0.1, 1.04], [0.9, 0.96], [0.95, 0.97], [1.0, 1.0]] :
[[0, 1], [1, 1]];

module shaped_extrude(length, s, path) 
{
    echo(length, s, len(path));
    for (i = [0: len(path) - 2]) {
	x0 = path[i][0];
	y0 = path[i][1];
	x1 = path[i + 1][0];
	y1 = path[i + 1][1];
	delta = length * (x1 - x0);
	h0 = length * x0;
	scale1 = y0 * (1 + (s - 1) * x0);
	scale2 = y1 * (1 + (s - 1) * x1) / scale1;
	translate([0, 0, h0]) linear_extrude(delta, scale=scale2) scale(scale1) children(0);
	echo (x0, y0, x1, y1, ":", delta, h0, scale1, scale2);
    }
}

module hex_grid(width, height, spacing, hex_size)
{
    spacing_y = spacing * sqrt(3) / 2;
    x_count = floor(width / spacing);
    y_count = floor(height / spacing_y);
    /* Center the grid */
    x_offset = (x_count * spacing) / 2;
    y_offset = (y_count * spacing_y) / 2;

    grid_x = [for (i = [0 : spacing : width + spacing]) i];
    grid_y = [for (i = [0 : spacing : width + spacing]) i];

    for (i = [-1 : 1 : x_count]) {
	for (j = [-1 : 1 : y_count]) {
	    translate([(-(j % 2)) * spacing / 2 + i * spacing - x_offset, 
		    j * spacing * sqrt(3) / 2 - y_offset, 1 / 2]) {
		rotate([0, 0, 30]) cylinder(1, d = hex_size, center = true, $fn = 6);
	    }
	}
    }
}

module drain_hole(diameter)
{
    intersection() {
	cylinder(1, d = diameter);
	hex_grid(diameter, diameter, diameter / 5, diameter / 6);
    }
}

module base_shape(shape, w, h) 
{
    if (shape == "elliptical") {
	resize([w, h]) circle(d=h, $fn=42);
    } else if (shape == "hexagonal") {
	hull() {
	    translate([-(w - h) / 2, 0, 0]) circle(d=h, $fn=6);
	    translate([(w - h) / 2, 0, 0]) circle(d=h, $fn=6);
	}  
    } else if (shape == "round") {
	hull() {
	    translate([-(w - h) / 2, 0, 0]) circle(d=h, $fn=42);
	    translate([(w - h) / 2, 0, 0]) circle(d=h, $fn=42);
	}
    } else if (shape == "octagonal") {
	hull() {
	    a = h / 10;
	    translate([-w / 2 + 2 * a, h / 2 - a, 0]) circle(r=a, $fn=42);
	    translate([-w / 2 + a, h / 2 - 2 * a, 0]) circle(r=a, $fn=42);
	    translate([-w / 2 + 2 * a, -h / 2 + a, 0]) circle(r=a, $fn=42);
	    translate([-w / 2 + a, -h / 2 + 2 * a, 0]) circle(r=a, $fn=42);

	    translate([w / 2 - 2 * a, h / 2 - a, 0]) circle(r=a, $fn=42);
	    translate([w / 2 - a, h / 2 - 2 * a, 0]) circle(r=a, $fn=42);
	    translate([w / 2 - 2 * a, -h / 2 + a, 0]) circle(r=a, $fn=42);
	    translate([w / 2 - a, -h / 2 + 2 * a, 0]) circle(r=a, $fn=42);
	}
    } else if (shape == "cloud") {
	union() {
	    a = h / 12;
	    hull() {                
		translate([-w / 2 + 2 * a, h / 2 - a, 0]) circle(r=a, $fn=42);
		translate([-w / 2 + 2 * a, -h / 2 + a, 0]) circle(r=a, $fn=42);

		translate([w / 2 - 2 * a, h / 2 - a, 0]) circle(r=a, $fn=42);
		translate([w / 2 - 2 * a, -h / 2 + a, 0]) circle(r=a, $fn=42);
	    }
	    hull() {
		translate([-w / 2 + a, h / 2 - 2 * a, 0]) circle(r=a, $fn=42);
		translate([-w / 2 + a, -h / 2 + 2 * a, 0]) circle(r=a, $fn=42);

		translate([w / 2 - a, h / 2 - 2 * a, 0]) circle(r=a, $fn=42);
		translate([w / 2 - a, -h / 2 + 2 * a, 0]) circle(r=a, $fn=42);
	    }
	}
    } else if (shape == "square") {
	hull() {
	    translate([-(w -h) / 2, 0, 0]) square(base_width, center=true);
	    translate([(w -h) / 2, 0, 0]) square(base_width, center=true);
	}
    }
}

module shell_generator(shape, p, base_width, top_width, height, depth) 
{
    v = profile(p);

    s = top_width / base_width;
    echo ("length:", len(v), s);
    difference() {
	shaped_extrude(depth, s, v) {
	    base_shape(shape, base_width, height);
	}
	translate([0, 0, 0.1]) {
	    shaped_extrude(depth - 0.05, s, v) {
		base_shape(shape, base_width - 0.1, height - 0.1);
	    }
	}
    }
}

module pot_shell(shape, profile, base_width, top_width, height, depth, thickness) 
{
    if (preview) {
	shell_generator(shape, profile, base_width, top_width, height, depth);
    } else {
	minkowski() {
	    shell_generator(shape, profile, base_width, top_width, height, depth);
	    sphere(d=thickness);
	}
    }
}

module ridge(height, thickness) 
{
    cube([thickness, 9 / 10 * height,  thickness], center = true);
}

module ridges(width, height, thickness) 
{
# translate([-width / 5, 0, thickness]) ridge(height, thickness);
# translate([width / 5, 0, thickness]) ridge(height, thickness);
}

module saucer(shape, profile, base_width, top_width, height, depth, thickness) 
{
    union () {
	pot_shell(shape, profile, base_width, top_width, height, depth, thickness);
	ridges(base_width, height, thickness);
    }
}

module pot(shape, profile, base_width, top_width, height, depth, thickness)
{
    difference () {
	pot_shell(shape, profile, base_width, top_width, height, depth, thickness);
	translate ([-base_width / 5, 0, -thickness / 2]) scale([1, 1, thickness * 1.1]) drain_hole(3 * height / 7);
	translate ([base_width / 5, 0, -thickness / 2]) scale([1, 1, thickness * 1.1]) drain_hole(3 * height / 7);
    }
}

/* Note: with a 0.3 nozzle, 0.15 layer height, 1mm is too thin to have a watertight pot. 1.2 could be just enough */

// saucer("cloud", 116, 130, 72, 8, 1.5);
// translate([0, 0, 5]) pot("cloud", 110, 130, 68, 60, 1.8);

// saucer("elliptical", 116, 130, 72, 8, 1.5);
// translate([0, 0, 5]) pot("elliptical", 110, 130, 68, 40, 1.8);

// saucer("elliptical", 161, 183, 100, 8, 1.8);
// translate([0, 0, 5]) pot("elliptical", 155, 183, 96, 40, 1.8);

// saucer("elliptical", "c", 164, 180, 114, 8, 2);
// translate([0, 0, 5]) pot("elliptical", "c", 160, 185, 110, 50, 2);

if (print == "both" || print =="saucer") {
    saucer(shape, saucer_profile, base_width + 3 * thickness, top_width, depth + 3 * thickness, saucer_height, thickness);
}
if (print == "both" || print =="pot") {
    translate([0, 0, 5]) pot(shape, pot_profile, base_width, top_width, depth, pot_height, thickness);
}
