include <configuration.scad>;

separation = 40;  // Distance between ball joint mounting faces.
offset = 20;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
push_fit_height = 3.8;  // Length of brass threaded into printed plastic.
push_fit_radius = 4.7; //M10 x 1.0 thread for manual tap
push_fit_manual_tap = true;
height = 10;
cone_r1 = 3;
cone_r2 = 12;
cone_supports = false;
hotend_rotation = 25;

module effector() {
  difference() {
    union() {
		
      cylinder(r=offset-2, h=height, center=true, $fn=180);
      for (a = [60:120:359]) rotate([0, 0, a]) {
		rotate([0, 0, 30]) 
			translate([offset-2, 0, 0])
	  			cube([10, 13, height], center=true);
		for (s = [-1, 1]) scale([s, 1, 1]) {
	  		translate([0, offset, 0]) {
				if(cone_supports) {
					
					translate([separation / 2 - 2.5,0,-height / 2 + 1.7])
						rotate([0,0,90])
		   					cube([1,5,height / 2 - 1.6], center=true);
					translate([separation / 2 - 5.4,3.425,-height / 2 + 2.5])
						rotate([0,0,160])
				   			cube([1,5,height / 2], center=true);
				}	// translate
		
				difference() {
				    intersection() {
						cube([separation, 40, height], center=true);
						translate([0, -4, 0]) rotate([0, 90, 0])
							cylinder(r=10, h=separation, center=true, $fn=96);			

						translate([separation/2-7, 0, 0]) rotate([0, 90, 0])
							cylinder(r1=cone_r2, r2=cone_r1, h=14, center=true, $fn=96);
		    		} // intersection

			    	rotate([0, 90, 0])
						cylinder(r=m3_radius, h=separation+1, center=true, $fn=96);
					rotate([90, 90, 90])
			   	   		cylinder(r=m3_nut_radius, h=separation-23, center=true, $fn=6);
				} // difference
			} // translate
		} // for
      } // for
    } // union
	rotate([0,0,hotend_rotation])
        translate([0, 0, -push_fit_height+(height/2)]) {
            translate([0,0,0]) {
                push_fit_thread();
            } // translate
        } // translate
	
    for (a = [60 + hotend_rotation:30:149 + hotend_rotation]) rotate([0, 0, a]) {
      translate([0, mount_radius, 0])
		cylinder(r=m3_wide_radius, h=2*height, center=true, $fn=24);
    } // for

	for (a = [240 + hotend_rotation:30:329 + hotend_rotation]) rotate([0, 0, a]) {
      translate([0, mount_radius, 0])
		cylinder(r=m3_wide_radius, h=2*height, center=true, $fn=24);
    } // for
  } // difference
} // module

module push_fit_thread() {
	cylinder(r=hotend_radius, h=height, $fn=144);
	union() {
		if(push_fit_manual_tap)
			cylinder(r=push_fit_radius, h=30, $fn=144, center=true);
		else
			translate([0, 0, -6]) # import("m5_internal.stl");
	}
}

translate([0, 0, height/2]) effector();

