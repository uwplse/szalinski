// Filter adapter 52mm to 1.25" telescope filter.

small_filter=1.25*25.4;
large_filter=51.5;

filter_lip_width=1.75;
filter_lip_height=1;
filter_depth=3;

$fn=360;

difference() {
	cylinder(r=large_filter/2, h=filter_depth);
	translate([0,0,-0.1]) {
		cylinder(r=small_filter/2-filter_lip_width, h=filter_depth);
		translate([0,0,filter_lip_height+0.1]){
			cylinder(r=small_filter/2, h=filter_depth);
		}
	}
}