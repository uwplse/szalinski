/* [Settings] */
// diameter of the button
OD = 15;
// how many sewing holes you want, set to 0 for none
numHoles = 4;
// thickness of button
thickness = 3;
// how far the holes are spaced from the center
holerRimOD = 7;
// size of sewing holes
holeOD = 2;
// size of outer fillet
rimRadius = 2;
// type of button cut
flatStat = "bottom"; // [top,bottom,both,none]


// calculations
holeOr = holeOD/2;
Or = OD/2;
holeRimOr = holerRimOD/2;

module button() {
	$fn = 30;
	difference() {
		union() {
			// fillet rims
			rotate_extrude() {
				translate([Or,0])
				circle(rimRadius,true);
			}
			// center cylinder
			cylinder(h = thickness, r = Or, center = true);
		}

		union() {
			// cutout hotes
			for (i = [0:numHoles]) {
				rotate([0,0,i*360/numHoles]) {
					translate([holeRimOr,0,0]) {
						cylinder(h = thickness*1.1, r = holeOr, center = true);
					}
				}
			}

			if (flatStat == "top") {
				translate([0,0,(rimRadius + thickness)/2 - 0.01])
				cylinder(h = rimRadius, r = OD*1.5, center = true);
			} else if (flatStat == "bottom") {
				translate([0,0,-(rimRadius + thickness)/2 + 0.01])
				cylinder(h = rimRadius, r = OD*1.5, center = true);
			} else if (flatStat == "both") {
				translate([0,0,(rimRadius + thickness)/2 - 0.01])
				cylinder(h = rimRadius, r = OD*1.5, center = true);

				translate([0,0,-(rimRadius + thickness)/2 + 0.01])
				cylinder(h = rimRadius, r = OD*1.5, center = true);
			}
		}
	}
}

button();