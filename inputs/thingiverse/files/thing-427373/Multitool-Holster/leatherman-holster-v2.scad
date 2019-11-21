//Multitool thickness in mm
thickness = 18.5;
//Multitool width in mm
width = 36;
//Multitool height in mm
height = 100;

/* [Hidden] */

$fn = 100;

case_thickness = 3;
case_height = height - 10;
lip = 5;
bottom_lip = 7.5;
bottom_lip_width = 15;
radius = 1;
mount_width = 25;
belt_thickness = 8;
belt_width = 50;

module rounded_rectangle(size, radius, center=false) {
	if(!center)
		translate([size[0] / 2, size[1] / 2])
			rounded_rectangle(size, radius, center=true);
	else
		hull() {
			translate([-(size[0] / 2 - radius), -(size[1] / 2 - radius)])
				circle(radius);
			translate([ (size[0] / 2 - radius), -(size[1] / 2 - radius)])
				circle(radius);
			translate([ (size[0] / 2 - radius),  (size[1] / 2 - radius)])
				circle(radius);
			translate([-(size[0] / 2 - radius),  (size[1] / 2 - radius)])
				circle(radius);
		}
}
module rounded_box(size, radius, center=false) {
	if(!center)
		translate([size[0] / 2, size[1] / 2, size[2] / 2])
			rounded_box(size, radius, center=true);
	else
		assign(hs = [size[0] / 2 - radius, size[1] / 2 - radius, size[2] / 2 - radius])
			hull() {
				translate([-hs[0],  hs[1],  hs[2]])
					sphere(radius);
				translate([ hs[0],  hs[1],  hs[2]])
					sphere(radius);
				translate([-hs[0], -hs[1],  hs[2]])
					sphere(radius);
				translate([ hs[0], -hs[1],  hs[2]])
					sphere(radius);
				translate([-hs[0],  hs[1], -hs[2]])
					sphere(radius);
				translate([ hs[0],  hs[1], -hs[2]])
					sphere(radius);
				translate([-hs[0], -hs[1], -hs[2]])
					sphere(radius);
				translate([ hs[0], -hs[1], -hs[2]])
					sphere(radius);
			}
}

module rsquare(size)
	rounded_box([size[0], size[1], case_height], radius, center=false);

rsquare([case_thickness * 2 + width, case_thickness], radius); // Back
// Left side arm
	rsquare([case_thickness, case_thickness * 2 + thickness]);
translate([0, case_thickness + thickness]) // Left lip
	rsquare([lip + case_thickness, case_thickness]);
translate([case_thickness + width, 0]) // Right side arm
	rsquare([case_thickness, case_thickness * 2 + thickness]);
translate([case_thickness + width - lip, case_thickness + thickness]) // Right lip
	rsquare([lip + case_thickness, case_thickness]);

difference() {
	hull() {
		translate([case_thickness + width / 2 - mount_width / 2, -(case_thickness + belt_thickness), case_height - (case_thickness * 2 + belt_width)])
			rounded_box([mount_width, belt_thickness + case_thickness * 2, case_thickness * 2 + belt_width], 3);
		translate([case_thickness + width / 2 - mount_width / 2, 0, case_height - (case_thickness * 2 + belt_width) - 6])
			sphere(r=.001);
		translate([case_thickness + width / 2 + mount_width / 2, 0, case_height - (case_thickness * 2 + belt_width) - 6])
			sphere(r=.001);
	}
	translate([mount_width * 2, -belt_thickness, case_height - case_thickness - belt_width])
		rotate(90, [0, -1, 0])
			linear_extrude(mount_width * 3)
				rounded_rectangle([belt_width, belt_thickness], belt_thickness / 2);
}

translate([case_thickness + width / 2 - bottom_lip_width / 2, 0, 0])
	rounded_box([bottom_lip_width, bottom_lip + case_thickness, case_thickness], radius);
