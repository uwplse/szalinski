/* [Global] */

// Which part would you like to make?
part = "a"; // [a:Assembled (without mount),d:Decoration,f:Front,b:Back,p:Plate,m:Mount]

// How much gap (microns) should be left between fitting, unattached, parts?
microngap = 50; // [10:200]

// What diameter (mm) should the entry hole in the decoration or front have?
entrydia = 40; // [20:60]

// How tall (mm) should the mount be?
mounttall = 50; // [25:100]


/* [Hidden] */


module decor() {
	difference() {
		union () {
			translate([-20,-90,0]) {
				linear_extrude(height = 2.5) import("decor.dxf");
			}
			translate([90,50,0.5]) cylinder(h=26, r=3);
		}
		translate([120,80,-23]) cylinder(h=100, r=entrydia/2);
	}
}

module front() {
	difference() {
		union () {
			minkowski() {
				cube(size=[180,180,4]);
				cylinder(h=2, r=5);
			}
			translate([0,0,5]) decor();
		}
		translate([120,80,-23]) cylinder(h=100, r=entrydia/2);
	}
}

module plainback() {
	difference() {
		minkowski() {
			cube(size=[180,180,125-2]);
			cylinder(h=2, r=5);
		}
		difference() {
			translate([10,10,6]) minkowski() {
				cube(size=[160,160,390]);
				cylinder(h=2, r=10);
			}
			translate([-10,-10,-20]) rotate([0,0,45])
				cube(size=[160,160,350], center=true);

		}
		translate([-17,-17,-70]) rotate([0,0,45])
			cube(size=[160,160,500], center=true);

		// air vents
		translate([140,140,0]) rotate([0,-60,45]) cube(size=[25,75,3], center=true);
		translate([150,150,0]) rotate([0,-60,45]) cube(size=[25,50,3], center=true);
		translate([160,160,0]) rotate([0,-60,45]) cube(size=[25,25,3], center=true);

		// base drain
		translate([-10,95,95]) rotate([-30,90,45]) cube(size=[40,50,3], center=true);
		translate([95,-10,35]) rotate([30,90,45]) cube(size=[40,50,3], center=true);
		translate([-10,95,35]) rotate([-30,90,45]) cube(size=[40,50,3], center=true);
		translate([95,-10,95]) rotate([30,90,45]) cube(size=[40,50,3], center=true);
	}
}

module back() {
	union() {
		difference() {
			// the back design without removable floor
			plainback();

			// remove mounting/clean-out plate
			translate([43,43,54.9]) rotate([270,180,-45]) union() {
				cube(size=[100,150,12], center=true);	
				cube(size=[110,150,4], center=true);
			}
		}

		// Dietz 2013 inside
		translate([55,200,1]) rotate([0,0,-45])
		linear_extrude(height = 6) import("logo.dxf", center=true);
	}
}

module plate(tol=0.4) {
	// mounting/clean-out plate
	// could difference cylinders for mounting holes from this,
	// but it isn't clear what the mounting holes should be
	union() {
		// the plate itself...
		translate([43,43,125/2]) rotate([270,180,-45]) union() {
			cube(size=[100-(tol*2),125,12-(tol*2)], center=true);	
			cube(size=[110-(tol*2),125,4-(tol*2)], center=true);
		}

		// with 2x2mm tab for easier removal
		translate([43,43,1]) rotate([270,180,-45])
			translate([0,0,-4]) cube(size=[100-(tol*2),2,8], center=true);
	}
}

module assembled(tol=0.4) {
	// tolerance is gap for fitting plate
	union() {
		// each piece is defined in printing position,
		// but front() must be translated to make complete model
		translate([0,0,125]) front();
		back();
		plate(tol);
	}
}

module mount(tall=50) {
	// there were issues with the DXF file...
	// simply rescale the STL
	scale([1,1,tall/50])
	import(file="mount.stl");
}


print_part();

module print_part() {
	if (part == "d") {
		decor();
	} else if (part == "f") {
		front();
	} else if (part == "b") {
		back();
	} else if (part == "p") {
		plate(microngap / 100);
	} else if (part == "m") {
		mount(mounttall);
	} else {
		assembled(microngap / 100);
	}
}

