baseThick = 2;
baseWidth = 4;
baseOuterDiameter = 104;
baseInnerDiameter = baseOuterDiameter - (baseWidth * 2);

wallHeight = 15;
wallThick = 4;
chamberDiameter = 100;

partHeight = wallHeight;
partWidth = baseOuterDiameter;

use <MCAD/gears.scad>

union() {

    difference() {

        difference() {
            cylinder(h = wallHeight, d = baseOuterDiameter);

            translate([0,0,-1]) {
                difference() {
                    cylinder(h = baseThick + 2, d = baseOuterDiameter - wallThick);

                    difference() {

                        translate([0,0,-1]) {
                            cylinder(h = baseThick + 2, d = baseOuterDiameter - wallThick);
            			}

                        // Remove Gear-Shape from cylinder to form the base teeth
                        translate([0,0,-2]) {
						   rotate(-7, [0,0,1])
                            linear_extrude(height = baseThick + 4) {
                                gear(number_of_teeth=6, circular_pitch=100, clearance = 60, pressure_angle=60);
                            }
						   rotate(7, [0,0,1])
                            linear_extrude(height = baseThick + 4) {
                                gear(number_of_teeth=6, circular_pitch=100, clearance = 60, pressure_angle=60);
                            }
                        }
                    }
                }
            }
        }

        translate([0,0,baseThick]) {
            cylinder(h = wallHeight + 2, d = chamberDiameter);
        }

        translate([0,0,-1]) {
	        cylinder(h = baseThick + 2, d = baseInnerDiameter);
        }

        num = 3;

        for ( i = [0 : num] )
        {
            rotate( i * (360 / num), [0, 0, 1])
            translate([0, 1 + baseOuterDiameter / 2, wallHeight / 2]) {
                rotate( 90, [1, 0, 0])
        	    cylinder(h = baseWidth + 2, d = 5);
        	}
        }
   }
}

