part = "collet";	// [all, shaft, collet, chuck]

// Diameter of bit
bitd = 3.175;

// Length of 1/4" hex drive
shaftlen = 30;

// Shaft diameter (1/4")
shaftd = 7.1;

// Fit fudge factor (nozzle width is usually good)
tolerance = 0.4;

// Collet diameter
colletd = 12;

// Collet screw length
colletlen = 10;

// Collet tip length
tiplen = 5;

// Collet stem length. This is also how deep the
// shaft goes in, so longer gives less runout.
stemlen = 10;

// Diameter of chuck nut
chuckd = 18;

// Number of jaws on the collet
njaws = 3;	// [3,4]

$fn=72;

module shaft() {
	difference() {
		cylinder(d=shaftd, h=shaftlen, $fn=6);
		
		// FIXME: approximate
		translate([0,0,9]) rotate_extrude()
			translate([6.7,0]) circle(d=9);
	}
}

module collet() {
	difference() {
		union() {
			translate([0,0,stemlen]) union() {
				intersection() {
					rotate([180,0,0]) mirror([0,0,1])
					thread(4, colletd/2, .5/36, 4, 3/2, 4);
					union() {
						translate([0,0,colletlen-4])
							cylinder(d1=colletd+4,d2=colletd,4);
						translate([0,0,4])
							cylinder(d=colletd+4,h=colletlen-8);
						cylinder(d2=colletd+4,d1=colletd,4);
					}
				}
				cylinder(d1=colletd,d2=colletd-2,
					h=colletlen);
			}

			translate([0,0,stemlen+colletlen])
				cylinder(d1=colletd-2,d2=bitd*2,h=tiplen);
			
			cylinder(d=colletd,h=stemlen,$fn=6);
			
			// supportless is nice
			hull() {
				translate([0,0,stemlen-3])
					cylinder(d=colletd-2,h=stemlen,$fn=6);
				translate([0,0,stemlen])
					cylinder(d1=colletd,h=1);
			}
		}
		cylinder(d=shaftd+tolerance,h=stemlen-.1,$fn=6);
		cylinder(d=bitd,h=colletlen*+stemlen+tiplen+1);
		cutd = bitd/2;
		for(a=[0:360/njaws:359]) {
			rotate([0,0,a])
			translate([-cutd/2,0,stemlen+0.1])
				cube([cutd,colletd,colletlen+tiplen]);
		}
	}
}

module chuck() {
	difference() {
		hull() {
			cylinder(d=chuckd,h=colletlen/2,$fn=6);
			cylinder(d=colletd+3,h=colletlen);
		}
		translate([0,0,-4])
		rotate([180,0,0]) mirror([0,0,1])
			thread(4, colletd/2+tolerance, .5/36, 4, 3/2, 4);
		cylinder(d=colletd,h=colletlen);
	}
}

if( part == "all" ) {
	color("gray") shaft();
	translate([0,0,shaftlen-5]) collet();
	color("green")
		translate([0,0,shaftlen+colletlen+stemlen]) chuck();
} else if( part == "collet" ) {
	collet();
} else if( part == "chuck" ) {
	rotate([180,0,0]) chuck();
} else if( part == "shaft" ) {
	rotate([90,0,0]) shaft();
}

////////////////////////////////////////
// FIXME: this really should use sweep or something
// more modern
fastthread = 0;
easythread = 0;

// spread - rise per turn
// radius - initial radius of first thread
// taper - inwards taper per 10 degrees(i.e. .225/36)
// turns - number of revolutions total
// threadr - radius of thread
// threadstep - length of each thread segment
module thread(spread,radius,taper,turns,threadr,threadstep) {
	if( fastthread ) {
		for(i=[0:18*turns]) {
			translate([sin(i*20)*(radius-i*2*taper),cos(i*20)*(radius-i*2*taper),i*spread/18])
			rotate ([90-5,-25,90-i*20-11])
				cylinder(r = threadr, h=threadstep,$fn=5);
		}
   } else if( easythread ) {
		for(i=[1:36*turns],j=i-1) {
         hull() {
            translate([sin(i*10)*(radius-i*2*taper),cos(i*10)*(radius-i*2*taper),i*spread/36])
            rotate ([90-5,-25,90-i*10-11])
               circle(r = threadr,$fn=5);
            translate([sin(j*10)*(radius-j*2*taper),cos(j*10)*(radius-j*2*taper),j*spread/36])
            rotate ([90-5,-25,90-j*10-11])
               circle(r = threadr,$fn=5);
         }
		}
	} else {
		for(i=[1:36*turns],j=i-1) {
			hull() {
		translate([sin(i*10)*(radius-i*taper),cos(i*10)*(radius-i*taper),i*spread/36])
				sphere(r=threadr, $fn=10);
		translate([sin(j*10)*(radius-j*taper),cos(j*10)*(radius-j*taper),j*spread/36])
				sphere(r=threadr, $fn=10);
			}
		}
	}
}
