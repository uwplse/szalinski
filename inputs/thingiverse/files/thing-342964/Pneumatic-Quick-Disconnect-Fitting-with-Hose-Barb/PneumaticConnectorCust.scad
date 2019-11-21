

/* Pneumatic Quick Disconnect Fitting with Hose Barb
   Version 1.0
   by Kirk Saathoff
   2014-05-25
 */

use <MCAD/shapes.scad>

/* [Global] */
// Diameter of the barb
barbDiameter = 6.525; // [6.35:1/4", 7.9375:5/16", 9.525:3/8"]

// Single vs. All Three Sizes
print_all = 0; // [0:Single,1:Print All]

/* [Hidden] */
qLen = 32;
humpOffset = 7.3;
barrelLen = qLen-13.5;
insertion = 8;
flangeThickness = 3;
couplerBody = 11.71;
insertionDiam = couplerBody-2;
barbDiameter1_4 = 6.525;
barbDiameter5_16 = 7.9375;
barbDiameter3_8 = 9.525;

module coupler()
{
	difference() {
		union() {
			cylinder(r=7.92/2, h=qLen, $fn=64);
			cylinder(r=couplerBody/2, h=barrelLen, $fn=64);
			translate([0, 0, 6])
				hexagon(12, 7);

			translate([0, 0, qLen-humpOffset])
				rotate_extrude(convexity = 10, $fn=32)
					translate([3.5, 0, 0])
						circle(r = 1.8, $fn=8);

		}
		translate([0, 0, -.1]) {
			cylinder(r=4.9/2, h=qLen+.2, $fn=32);
			cylinder(r=insertionDiam/2, h=insertion, $fn=64);
		}
	}
}

module barb_nub(_barbDiameter)
{
		rotate_extrude(convexity = 10, $fn=32)
			translate([_barbDiameter/2, 0, 0]) {
				circle(r = 1.2, $fn=15);
				polygon([[0,0], [0,3], [1,.6]]);
		}
}

module barb(_barbDiameter)
{
		difference() {
			union() {
				translate([0, 0, insertion+flangeThickness]) {
					cylinder(r=_barbDiameter/2, h=qLen-(insertion+flangeThickness), $fn=64);
				}
				cylinder(r=(insertionDiam-0.3)/2, h=insertion+flangeThickness, $fn=64);
				cylinder(r=11.71/2, h=flangeThickness, $fn=32);
				translate([0, 0, qLen-humpOffset])
					barb_nub(_barbDiameter);
				translate([0, 0, qLen-humpOffset-humpOffset])
					barb_nub(_barbDiameter);
			}
			translate([0, 0, -.1])
//				cylinder(r=3.9/2, h=qLen+.2, $fn=64);
				cylinder(r=_barbDiameter/3.8, h=qLen+.2, $fn=64);
		}
}

module print_coupler(_barbDiameter)
{
	coupler();
	translate([20, 0, 0]) {
		barb(_barbDiameter);
	}
}

if (print_all) {

	print_coupler(barbDiameter1_4);
	translate([0, 20, 0])
		print_coupler(barbDiameter5_16);
	translate([0, 40, 0])
		print_coupler(barbDiameter3_8);



} else {
	print_coupler(barbDiameter);
}

