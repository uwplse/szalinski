/* [Basic] */
//basic parameters
//Inner radius of smallest ring
innerRingRadius = 20; // [0:0.5:150]
innerR = innerRingRadius;
//Height of rings
height = 4;
//# of rings
number = 3; // [2:1:10]
//Width of each ring
ringWidth = 4; // [3:0.25:8]
//Clearance between rings
ringClearance = 2; // [0.25:0.25:5]

/* [Advanced] */
//advanced parameters
//Clearance in joints, increase on bad machine
jointClearance = 0.2; // [0.1:0.025:0.5]
//Should rings be cylinders or sections of spheres (very slow)?
ringType = 0; // [0:Cylinders, 1:Spherical Sections]
sphericalRings = ringType == 1;
//Joint depth as % of ring width
jointOverlap = 75; // [50:5:90]
overlap = jointOverlap / 100;
//angle difference between each joint (90 is classic gimbal)
angleOffset = 90;
//# of segments (more is much slower)
$fn = 100;

//calculated parameters
spacing = ringWidth + ringClearance;
coneR = 0.9 * height / 2; //target cone radius
pinH = ringWidth*overlap + ringClearance - jointClearance;

for (i = [0:number-1]) {
	r = innerR + spacing*i;
	jointPoint = r + ringWidth*(1-overlap);
	render(convexity=2) difference() {
		ring(r);
		//make hole on all but last segment
		if (i != number-1)
			moveCone(jointPoint, angleOffset*i) cone(coneR/overlap,ringWidth);
	}
	//make pin on all but first segment
	if (i != 0)
		moveCone(jointPoint-spacing+jointClearance, angleOffset*(i-1)) cone(coneR, pinH);
}

module cone(r, h) {
	translate([h,0,0])
	rotate([0,-90,0])
	cylinder(h=h, r1=r, r2=0);
}

module ring(r) {
	if (sphericalRings) {
		intersection() {
			difference() {
				sphere(r + ringWidth);
				sphere(r);
			}
			cylinder(height, r=r+ringWidth+1, center=true);
		}
	} else {
		translate([0,0,-height/2]) linear_extrude(height) difference() {
			circle(r + ringWidth);
			circle(r);
		}
	}
}
module moveCone(r, theta) {
	for (i = [0,180]) {
		rotate([0,0,theta+i])
		translate([r,0,0])
		children();
	}
}