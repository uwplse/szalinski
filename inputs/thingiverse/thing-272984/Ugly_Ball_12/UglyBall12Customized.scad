// Ugly Ball Christmas Ornament (Customized for Customizer on www.thingiverse.com)
// by Les Hall
// started 3-14-2014

// radius in millimeters
radius = 35; // [5:50]
// hollow
hollowPercentage = 90;  // [0:99]
hollow = hollowPercentage / 100; 
// smoothness of main sphere
detail = 64; // [3:256]
// smoothness of holes
holeDetail = 32; // [3:256]
// tweak this and num together
holeSizeScaled = 17; // [1:40]
holeSize = holeSizeScaled / 10;
// number of holes
num = 8; // [1:32]
// hole to pole scaling
shrinkage = 50; // [1:100]
shrinkification = shrinkage / 50;


// flip upside down for 3D printing
rotate(a = 180, v = [1, 0, 0])
union() {
	// bar on top for hanging ornament
	translate([0, 0, radius*(1+hollow)/2])
		cube((radius/5)*[3.5, 0.5, 0.5], center = true);
	difference() {
		union() {
			// main sphere
			sphere(r = radius, $fn = detail);
			// disc on top of ornament
			translate([0, 0, radius*(1+hollow)/2])
				cylinder(h = radius*(1-hollow), 
					r = radius*2/5, $fn = detail, center = true);
		}
		// make disc on top of ornament hollow
		translate([0, 0, radius*(1+hollow)/2])
			cylinder(h = 4*radius*(1-hollow), r = (radius/5) * 1.5, $fn = detail, center = true);
		// hollow out the sphere
		sphere(r = hollow*radius, $fn = detail);
		// cut all the little holes
		for (theta = [-180 : 240.0/num : 180], phi = [-60 : 120/num : 60]) {
			assign(w = (radius/5) * holeSize * (120-shrinkification * abs(phi) ) / 120) {
				rotate(a = theta+phi, v = [0, 0, 1])
				rotate(a = phi, v = [0, 1, 0])
				translate([radius*(1+hollow)/2, 0, 0])
				rotate(a = 90, v = [0, 1, 0])
					cylinder(h = 2*radius, r = w/2, $fn = holeDetail, center = true);
			}
		}
	}
}
