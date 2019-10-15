$fs = 0.5/1;
$fa = 0.5/1;

padWidth = 94;
padDepth = 75;

topThickness = 4;

height = 40;

legHeight = height - topThickness;
legRadius = 10;

feetHeight = 0.5;
feetRadius = 5;

union () {
	for (i = [-1 : 2 : 1]) {
		for (j = [-1 : 2 : 1]) {
			translate([i*(padWidth/2-legRadius), j*(padDepth/2-legRadius), 0]) {
				difference() {
					cylinder(legHeight, legRadius, legRadius);
					translate([0, 0, -1]) {
						cylinder(feetHeight+1, feetRadius, feetRadius);
					}
				}
			}
		}
	}

	hull() {
		translate([0, 0, legHeight]) {
			for (i = [-1 : 2 : 1]) {
				for (j = [-1 : 2 : 1]) {
					translate([i*(padWidth/2-legRadius), j*(padDepth/2-legRadius), 0]) {
						cylinder(topThickness, legRadius, legRadius);
					}
				}
			}
		}
	}
}
