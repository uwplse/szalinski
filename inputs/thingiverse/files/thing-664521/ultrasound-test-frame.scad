//
// Ultrasound test bench
//
// Design by Egil Kvaleberg, 1 February 2015
//
// Now with some extra strengthening of the tower
//
// Note that X and Z are switched. Sorry about that

variant = "tower"; // [demo, tower, pivot, bar]

// wall thickness
wall = 2.0;
// diameter of transducer
sdia = 16.2; 
// height above table
theight = 200.0; 
// width of bar
bwidth = 10.0;
// length of supporting feet
fwidth = 70.0;
// distance horisontally
dlen = 200.0; 
// tolerance for fit 
tol = 0.25; 
// radius of protractor
protractor = 40.0; 

platform = 1*200.0;
d = 1*0.03;

//color("Green") cube([platform, platform, 0.1], center=true);


module tower() {
	// main pillar
	translate([theight/2, 0, bwidth/2]) cube([theight-sdia-wall, wall, bwidth], center=true);
	translate([theight/2, 0, wall/2]) cube([theight-sdia-wall, bwidth, wall], center=true);

	translate([0, 0, bwidth/2]) difference(){
		union () {
			// feet across
			translate([wall/2, 0, 0]) cube([wall, fwidth, bwidth], center=true);
			translate([bwidth/2/2, 0, -bwidth/2+wall/2]) cube([bwidth/2, fwidth, wall], center=true);
			translate([wall+sdia/4, 0, 0]) cube([sdia/2, bwidth, bwidth], center=true);
		}
		union () {
			translate([wall+(sdia/2-wall)/2, 0, 0]) cube([sdia/2-wall, bwidth-2*wall, 2*d+bwidth], center=true);
		}
	}
	// foot "upwards"
	translate([wall/2, 0, fwidth/4+bwidth/2]) cube([wall, bwidth, fwidth/2], center=true);
	translate([bwidth/2/2, wall/2-bwidth/2, fwidth/4+bwidth/2]) cube([bwidth/2, wall, fwidth/2], center=true);
	translate([bwidth/2/2, bwidth/2-wall/2, fwidth/4+bwidth/2]) cube([bwidth/2, wall, fwidth/2], center=true);
	// ring on top
	translate([theight, 0, 0]) difference () {
		cylinder(r=sdia/2+wall, h=bwidth, $fn=60);
		translate([0, 0, -d]) cylinder(r=sdia/2, h=bwidth+2*d, $fn=60);
	}
}

module connector (len) {
	translate([0, 0, bwidth/2])
			translate([wall+(sdia/2-wall)/2, 0, 0]) cube([sdia/2-wall-2*tol, bwidth-2*wall-2*tol, bwidth+2*tol], center=true);
	translate([bwidth/2, 0, -tol-(bwidth/2)/2]) cube([bwidth, bwidth, bwidth/2], center=true);
	translate([wall/2, 0, -tol-(len-tol)/2]) cube([wall, bwidth, len-tol], center=true);
}


module pivot() {
	connector(1.1*bwidth);
	translate([0, 0, -1.1*bwidth]) rotate([0,90,0]) {
		difference () { 
			intersection () {
				cylinder(r = protractor, h=wall, $fn=60);
				translate([protractor/2, 0, wall/2]) cube([protractor, 2*protractor, wall], center=true);
			}
			for (r = [-90:5:90]) 
			rotate([0, 0, r]) translate([protractor-2.0, 0, -d]) cylinder(r = 1.2, h=wall+2*d, $fn=10);
			for (r = [-90:15:90]) 
			rotate([0, 0, r]) translate([protractor-5.0, 0, -d]) cylinder(r = 1.2, h=wall+2*d, $fn=10);
		}
	}
	translate([0, 0, -1.1*bwidth]) rotate([0,90,0]) cylinder(r = bwidth/4-tol/2, h=3*wall, $fn=20);
}

module bar() {
	difference () {
		union () {
			connector(dlen-protractor-bwidth*1.1-tol);
			translate([wall+tol/2, 0, protractor-dlen+1.6*bwidth+tol]) cube([wall+tol+wall, bwidth, 1.0*bwidth], center=true);
			translate([wall/2+wall+tol, 0, protractor-dlen-0.4*bwidth]) cube([wall, bwidth, protractor+1*bwidth], center=true);
			translate([wall+tol, 0, 1.1*bwidth-dlen]) rotate([0,90,0]) cylinder(r=bwidth/2, h=wall);
		}
		union () {
			// axle
			translate([0, 0, 1.1*bwidth-dlen]) rotate([0,90,0]) cylinder(r = bwidth/4+tol/2, h=2*wall+tol+d, $fn=20);
			// observation hole 
			translate([0, 0, protractor+0.8*bwidth-dlen]) rotate([0,90,0]) cylinder(r = bwidth/4, h=2*wall+tol+d, $fn=20);
			translate([0, 0, protractor+0.4*bwidth-dlen]) rotate([0,90,0]) cylinder(r = 1.2, h=2*wall+tol+d, $fn=20);
		}
	}
}

if (variant == "tower") rotate([0, 0, 180+45]) tower();
if (variant == "bar") rotate([0, -90, 45]) bar();
if (variant == "pivot") rotate([0, -90, 0]) pivot();
if (variant == "demo") rotate([0, -90, 0]) {
	tower();
	color("Green") bar();	 
	rotate([180, 0, 0]) translate([0, 0, dlen]) {
		color("Blue") pivot();
		tower();
	}
}