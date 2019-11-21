// Thickness of the overall piece, must be smaller than height of treking pole tip
thickness = 10.5;
// Radius of the base of the tip of a treking pole
trekking_pole_base_radius = 6.425;
// Radius of the top of the tip of a treking pole
trekking_pole_tip_radius = 4.85;
// Height of the tip of a treking pole
trekking_pole_tip_height = 35;
// Angle at which the treking poles will sit
trekking_pole_angle = 30;
// Length of the arm of the piece
arm_length = 40;
// Radius of the center of the piece
center_radius = 20;
// Radius of the hole for the screw for the ball mount
ball_mount_hole_radius = 3.25;
// Percentage for adjustment of hole sizes in case of printer undersizing holes
hole_undersize_adjustment = 1.00;
// Smoothness of round parts
round_smoothness = 360;



difference() {
	union() {
		// Arms
		for(i=[0:120:360]) {
			rotate([0,0,i]) {
				difference() {
					// Arm
					union() {
						translate([0,arm_length,0]) {
							cylinder(h=thickness, r=(trekking_pole_base_radius+5)*hole_undersize_adjustment, center=true, $fn=round_smoothness);
						}
						translate([0,arm_length/2,0]) {
							cube([((trekking_pole_base_radius+5)*2)*hole_undersize_adjustment,arm_length,thickness], center=true);
						}
					}
					// Arm hole
					translate([0,arm_length-3,0]) {
						rotate([trekking_pole_angle,0,0]) {
							cylinder(h=trekking_pole_tip_height, r1=trekking_pole_base_radius*hole_undersize_adjustment, r2=trekking_pole_tip_radius*hole_undersize_adjustment, center=true, $fn=round_smoothness);
						}
					}
				}
			}
		}

		// Center
		cylinder(h=thickness, r=center_radius*hole_undersize_adjustment, center=true, $fn=round_smoothness);
	}
	// Ball mount hole
	cylinder(h=thickness+10, r=ball_mount_hole_radius*hole_undersize_adjustment, center=true, $fn=round_smoothness);
}