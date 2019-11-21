innerradius = 5; // [0:100]
wallthickness = 2; // [0:10]
radius = innerradius+wallthickness;

height = 7; // [0:15]

cable_binder_width_plus_margin = 5; // [0:10]
cable_binder_height_plus_margin = 2; // [0:10]
cable_binder_position_in_percent = 50; // [0:100]

open_top = "yes"; // [yes,no]
opening_angle = 90; // // [0:360]



// from http://rocklinux.net/pipermail/openscad/2012-August/003170.html
// whosawhatsis
module slice(r = 10, deg = 30) { 
	degn = (deg % 360 > 0) ? deg % 360 : deg % 360 + 360;
	difference() {
		circle(r);
		if (degn > 180) 
			intersection_for(a = [0, 180 - degn]) 
				rotate(a) 
					translate([-r, 0, 0]) 
						square(r * 2); 
		else 
			union() 
				for(a = [0, 180 - degn]) 
					rotate(a) 
						translate([-r, 0, 0]) 
							square(r * 2); 
	}
}



difference(){
	cylinder(h = height, r = radius, center = true);
	cylinder(h = height+2, r = innerradius, center = true);

	translate([0,-radius,0])
		translate([0,(radius*2)*cable_binder_position_in_percent/100, 0])
			cube(size = [radius*2, cable_binder_height_plus_margin, cable_binder_width_plus_margin], center = true);

if (open_top == "yes"){
	rotate(90 + opening_angle/2) 
	linear_extrude(height = height+2, center = true)
		slice(radius*2, opening_angle);
}

}




