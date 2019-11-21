// Author: GrAndAG

/* [Settings] */

// Thickness of holder (mm)
thickness = 6; // [3:0.5:25]

//Economical version (requires less plastic)
economical = 1; // [0:No, 1:Yes]

// Diameters of mount holes (mm)
mount_hole_diameter = 3.5; // [2.7:0.1:4.0]

/* [Hidden] */
// to avoid renderring glitches
eps = 0.05;

module end_stop_holder() {
	$fn=50;

	difference() {
        // main body with tip
		union() {
			cube([30, 16, thickness], center = true);
			translate([-7, -4, thickness/2])
				cube([6, 8, 3.5], center = true);
		}

        // hole for contacts on back side of PCB
		translate([3, -2, -thickness/2 + 1.25 - eps/4])
			cube([15, 6, 2.5+eps/2], center = true);

        //cut some unneeded plastic
        if(economical)
            translate([8+eps/4, 0, 3.5])
                cube([14+eps/2, 16+eps, thickness], center = true);

        // two mount holes
		translate([-7, 5, 0])
			cylinder(h=thickness+eps, d=mount_hole_diameter, center = true);
		translate([12, 5, 0])
			cylinder(h=thickness+eps, d=mount_hole_diameter, center = true);
	}
}

end_stop_holder();

