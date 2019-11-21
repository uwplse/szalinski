
wheel_diameter = 35;
wheel_width = 13.5;
wheel_rim_width = 9.75;
axle_cutout_diameter = 8;
inset_cutout_width = 20;
inset_cutout_depth = 5;

/* [Hidden] */
$fn = 100;

wheel();

module wheel() {
	// Axle cuttout
	difference(){
		// Inset cuttout
		difference(){
			// Wheel
			difference(){
				cylinder(d = wheel_diameter, h = wheel_width);
				translate([0, 0, wheel_width/2]) {
					rotate_extrude() {
						translate([wheel_diameter/2, 0, wheel_width/2]) {
							circle(d = wheel_rim_width, $fn = 100);
						}
					}
				}
			}
			translate([0, 0, wheel_width-inset_cutout_depth]) {
				cylinder(inset_cutout_depth, d = inset_cutout_width, $fn = 100);
			}
		}
		cylinder(wheel_width-inset_cutout_depth, d = axle_cutout_diameter, $fn = 100);
	}
}