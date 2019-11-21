/**
 * Rim (Lego or so!)
 * 
 * oval and support_rounded from https://www.thingiverse.com/thing:212041/
 *
 * @Author  Wilfried Loche
 * @Created June 2nd, 2017
 */

/* [Tire] */
// Width of the tire
tireWidth = 10;
// Inner diameter of the tire = Outer RIM diameter!
tireInnerDiameter = 40; //67;

/* [Rim] */
// Depth of the rim
rimDepth = 2;
axleHeigth = 7;
axleDiameter = 15;

axleInternalHoleThickness = 1.5;

// Spoke thickness: Should be a multiple of your nozzle diameter
spokeThickness = 1.2;
numberOfSpokes = 12;

module oval(l, w)
{
	// Someone wants to print the white house?
	// Use extrude_linear to create a 3D shape
	scale(v=[1, w/l, 1])
	{
		circle(r = 0.5*l, $fn = 180);
	}
}

module support_rounded(length = 10, width = 4, height = 5, d = 2)
{
	// Some kind of triangle to support walls and alike
	// Triangle is 'rounded'
    difference()
	{
		cube([length, width, height]);
		translate([length, width+1, height])
			rotate([90, 0, 0])
				linear_extrude(height = width + 2)
					oval(2*(length-d), 2*(height-d)); 
	}
}

module rim() {
    rotate_extrude(convexity = 10, $fn = 180)
    translate([tireInnerDiameter/2 - rimDepth, 0, 0])
    square(size = [rimDepth, tireWidth]);
}


module lego_axle(height) {
    // https://www.thingiverse.com/thing:5699
    spline_width=2.0; // May be 1.8, depends on you printer calibration!
    diameter=5;
	translate([0, 0, axleHeigth/2]) union() {
		cube([diameter, spline_width, axleHeigth + 2], center = true);
		cube([spline_width, axleDiameter/2 + 2, axleHeigth + 2], center = true);
	}
}

module axle_hole_half() {
    union() {
        rotate([0, 0, 30])
        rotate_extrude(angle = 120, convexity = 10, $fn = 180)
        translate([axleDiameter/4, 0, 0])
        square(size = [axleInternalHoleThickness, axleHeigth + 5]);
        
        rotate([0, 0, 30])
        translate([axleDiameter/4+axleInternalHoleThickness/2, 0, 0])
        cylinder(d = axleInternalHoleThickness, h = axleHeigth + 5, $fn = 30);

        rotate([0, 0, 150])
        translate([axleDiameter/4+axleInternalHoleThickness/2, 0, 0])
        cylinder(d = axleInternalHoleThickness, h = axleHeigth + 5, $fn = 30);
    }
}

module axle_hole() {
    translate([0, 0, -1])
    union() {
        axle_hole_half();
        mirror([0, 1, 0]) axle_hole_half();
    }
}

module axle() {
    difference() {
        translate([0, 0, axleHeigth/2])
            cylinder(d = axleDiameter, h = axleHeigth, center = true, $fn=90);
        lego_axle();
        axle_hole();
    }
}

module spokeOne() {
    spokeLength = tireInnerDiameter/2 - axleDiameter/2;
    translate([-axleDiameter/2 + rimDepth/2 - spokeLength, -spokeThickness/2, 0])
    support_rounded(spokeLength, spokeThickness, axleHeigth, axleHeigth/3);
}

module spokes() {
    for (i = [0:numberOfSpokes-1]) {
        rotate([0, 0, i*360/numberOfSpokes]) spokeOne();
    }
}

union() {
    rim();
    axle();
    spokes();
}