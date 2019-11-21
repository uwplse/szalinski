filename1 = ""; // [image_surface:100x100]
filename2 = ""; // [image_surface:100x100]
filename3 = ""; // [image_surface:100x100]
thickness = 2;
fn = 24;

// Create a triangle which is 1/fn of a circle. 
// Parameters:
//     r  - the circle radius 
//     fn - the same meaning as the $fn of OpenSCAD
module one_over_fn_for_circle(r, fn) {
    a = 360 / fn;
	x = r * cos(a / 2);
	y = r * sin(a / 2);
	polygon(points=[[0, 0], [x, y],[x, -y]]);
}

// Transform a model inito a cylinder.
// Parameters:
//     length - the model's length 
//     width  - the model's width
//     square_thickness - the model's thickness
//     fn - the same meaning as the $fn of OpenSCAD
module square_to_cylinder(length, width, square_thickness, fn) {
    r = length / 6.28318;
    a = 360 / fn;
	y = r * sin(a / 2);
	for(i = [0 : fn - 1]) {
	    rotate(a * i) translate([0, -(2 * y * i + y), 0]) intersection() {
		    translate([0, 2 * y * i + y, 0]) 
		        linear_extrude(width) 
				    one_over_fn_for_circle(r, fn);
			translate([r - square_thickness, 0, width]) 
	            rotate([0, 90, 0]) 
	                children(0);
		}
	}
}

// read Heightmap information from a png file.
// Parameters:
//     filename - a png filename
//     width  - the png's width
//     length  - the png's length
//     thickness - the height of the model
module from_png(filename, length, width, thickness) {
	translate([width - 1, 0, 0]) rotate(90) 
		scale([1, 1, 0.01 * thickness]) surface(filename); 
}

module blank_pen_holder(length, width, thickness) {
	color("black") linear_extrude(width) difference() {
		circle(length / 6.28318 - thickness / 2);
		circle(length / 6.28318 - thickness);
	}
	color("white") linear_extrude(thickness / 2) circle(length / 6.28318);
}

module png_to_pen_holder(filename, length, width, thickness) {
	blank_pen_holder(length - 1, width - 1, thickness);
	color("white") 
	    square_to_cylinder(length - 1, width - 1, thickness, fn)    
		    from_png(filename, length, width, thickness);
}

// specific for thingiverse customizer
module from_100x100_pngs(filenames, thickness) {
	translate([99, 0, 0]) rotate(90) { 
	    surface(filenames[0]); 
		translate([99, 0, 0]) surface(filenames[1]); 
		translate([198, 0, 0]) surface(filenames[2]); 
	}
}

// specific for thingiverse customizer
module 100x100_pngs_to_pen_holder(filenames, thickness) {
	blank_pen_holder(300 - 4, 100 - 1, thickness);
	color("white") 
	    square_to_cylinder(300 - 3, 100 - 1, thickness, fn)    
		    from_100x100_pngs(filenames, thickness);
}

// specific for thingiverse customizer
100x100_pngs_to_pen_holder([filename1, filename2, filename3], thickness);

/*

 if you use openscad directly, you may use the following code.
filename = "circuit.png";
png_to_pen_holder(filename, 300, 125, thickness);

*/