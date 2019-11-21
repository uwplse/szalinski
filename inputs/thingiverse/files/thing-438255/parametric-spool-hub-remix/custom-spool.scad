hub_diameter=32;
hub_height=4;
shaft_diameter=9;
wall_thickness=1;
brim_width=2;
hole_diameter=9;
$fn=24;
difference() {
	body();
	shaft();
	holes();
}
module body() { 
	cylinder(d=hub_diameter+brim_width*2,h=wall_thickness);
	difference() {
		cylinder(d=hub_diameter,h=hub_height+wall_thickness);
		cylinder(d=hub_diameter-wall_thickness*2,h=hub_height+wall_thickness);
	}
}
module shaft() {
	cylinder(d=shaft_diameter,h=hub_height);
}
module holes() {
	offset=hub_diameter/2-wall_thickness-hole_diameter/2;
	for(i=[0:360/6:360]) {
		rotate([0,0,i])
			translate([offset,0,0])
			cylinder(d=hole_diameter,h=wall_thickness);
	}
}