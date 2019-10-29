secondary_mirror_hole=43;
secondary_mirror_larger=44;
secondary_mirror_thickness=5;
$fn=50;

rotate([-45,0,0]){
difference() {
difference() {
intersection() {
	rotate([45,0,0]) {
		cylinder(r=secondary_mirror_larger*4, h=secondary_mirror_larger*4);
	}
	translate([0,0,-secondary_mirror_larger/2-secondary_mirror_thickness]){
	cylinder(r=secondary_mirror_larger/2, h=secondary_mirror_larger*4);
	}
}
translate([0,0,secondary_mirror_thickness]){
intersection() {
	rotate([45,0,0]) {
		cylinder(r=secondary_mirror_larger*4, h=secondary_mirror_larger*4);
	}
	translate([0,0,-secondary_mirror_larger/2]){
	cylinder(r=secondary_mirror_larger/2+0.01, h=secondary_mirror_larger*4);
	}
}
}
}
	translate([0,0,-secondary_mirror_larger/2-secondary_mirror_thickness]){
			cylinder(r=secondary_mirror_hole/2, h=secondary_mirror_larger*4);
	}
}
}