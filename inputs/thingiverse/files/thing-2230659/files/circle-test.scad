// 9-Area Bed Level Calibration Test
// V1.0 - 2017/04/06
//
// timfou - Mitch Fournier
// http://www.thingiverse.com/thing:2230659

// How many circles in a row? (Default: 3)
num_circles_x = 3;
// How many circles in a column? (Default: 3)
num_circles_y = 3;
// Diameter of the test circles (Default: 40mm)
circle_diameter = 40;
// Height of the circles (Default: 0.3mm, good for 0.2mm layer test)
circle_height = 0.3;
// X-spacing between circle centers (Default: 95mm)
x_spacing = 95;
// Y-spacing between circle centers (Default: 75mm)
y_spacing = 75;

$fn=128*1;


// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
//	Draw ***ALL THE CIRCLES***
// = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
linear_extrude(circle_height) drawCircles();


module drawCircles() {
	for (i=[0:num_circles_y-1]) {
		for (j=[0:num_circles_x-1]) {
			translate([j*x_spacing,i*y_spacing,0]) circle(circle_diameter/2);
		}
	}
}