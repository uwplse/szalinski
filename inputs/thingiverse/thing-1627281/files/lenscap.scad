// number of segments
$fn = 50;
// inner diameter
inner_diameter = 30;
// cap height. So far, bottom is always 2mm, border is 1mm
cap_height = 10;
// width of the clamps
clamp_width = 10;


module gripper(inner=30,height=10,clampwidth=10) {
	intersection() {
		translate([0,0,5]) cube([inner*2+4,clampwidth,height],center=true);
		difference() {
			cylinder(r=inner+2,h=height);
			cylinder(r=inner+.5,h=height-2);
			cylinder(r=inner-.1,h=height+1);
		}
	}
}
module cap(inner=30,height=10,clampwidth=10) {
difference() {
cylinder(r=inner+2,h=height);
	translate([0,0,2]) {
		cylinder(r=inner + 0.5,h=height);
		translate([0,0,5]) cube([inner*2+4,clampwidth+2,height],center=true);
	}
}
gripper(inner=inner,height=height,clampwidth=clampwidth);
}


cap(inner=inner_diameter, height=cap_height, clampwidth=clamp_width);
