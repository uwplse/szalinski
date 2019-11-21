//By Dan Finlay, 2013
//dan@danfinlay.com

bearing_outer_diameter = 22;
bearing_width = 7;
bearing_hole_diameter = 8;

spool_diameter = 32;

wedge_difference = 1.5;

module bearing_hole(){
	translate([0,0,4])
	cylinder(r=bearing_outer_diameter/2, h=bearing_width);
}

module axle_hole(){
	cylinder(r=(bearing_hole_diameter/2)+2.2, h=bearing_width*2);
}

module main_area(){
	union(){
		difference(){
			cylinder(r1=(spool_diameter/2)-(wedge_difference/2), r2=(spool_diameter/2)+(wedge_difference/2), h=bearing_width+4);
			translate([0,0,4]) cylinder(r1=(spool_diameter/2)-5-(wedge_difference/2), r2=(spool_diameter/2)-5+(wedge_difference/2), h=bearing_width);
		}
		translate([0,0,4])
			cylinder(r=(bearing_outer_diameter/2)+3, h=bearing_width);
	}
}

difference(){
	main_area();
	bearing_hole();
	axle_hole();
}