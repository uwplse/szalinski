// ***************** Remixed From *******************************
// ***************** Airtripper's Reel Roller  ******************


fn=90;
// ## Bearing Dimentions ##
bearing_id = 8;
bearing_od = 22;
bearing_w = 7;

number_of_bearings = 3;
bearing_spacing = 100;
side_wall_width = 4;
bushing_wall_depth = 8;
no_feet = true;

bushing_r = bearing_od/2+bushing_wall_depth;
spool_holder_width = bearing_w*number_of_bearings+side_wall_width*2;
channel_width = bearing_w*number_of_bearings-2;
spool_holder_length = bearing_spacing+bushing_r*2;

//print_half();
full_model();
//bushing();


// ######################     For Printing     ###########################

module print_half() {
	difference() {
		translate([0,0,0]) rotate([0,0,0]) roller();
		translate([0,25,spool_holder_width]) cube([bearing_spacing*2,100,spool_holder_width*2], center=true);
	}
}

// ######################     Full Model     ###########################

module full_model() {
	translate([0,0,0]) rotate([90,0,0]) roller();
	translate([bearing_spacing/2,0,bearing_od/2+bushing_wall_depth]) rotate([90,0,0]) bearing(bearing_id, bearing_od, bearing_w*number_of_bearings);
	translate([-bearing_spacing/2,0,bearing_od/2+bushing_wall_depth]) rotate([90,0,0]) bearing(bearing_id, bearing_od, bearing_w*number_of_bearings);
*%	translate([0,3,118]) rotate([90,0,0]) reel();
}

// ######################     Roller      ###########################

module roller() {
difference() {
union() {
	// ## Roller Body ##
	difference() {
		union() {
			translate([0,(bearing_od/2+bushing_wall_depth)/2,0]) cube([spool_holder_length,bearing_od/2+bushing_wall_depth,spool_holder_width], center=true);
		}
		union() {
			translate([0,25+side_wall_width,0]) cube([spool_holder_length*2,50,channel_width], center=true);
			translate([0,bearing_spacing+side_wall_width+2,0]) cylinder(100, r=bearing_spacing, center=true, $fn=fn*3);
			translate([bearing_spacing/2,bearing_od/2+bushing_wall_depth,0]) cylinder(spool_holder_width, r=13, center=true, $fn=fn);
			translate([-bearing_spacing/2,bearing_od/2+bushing_wall_depth,0]) cylinder(spool_holder_width, r=13, center=true, $fn=fn);

		}
	}
	// ## Screw Housings ##
	for (m = [-1, 1]) { 
		for (x = [bearing_spacing/2-bushing_r+4.5, bearing_spacing/2+bushing_r-4.5]) {
			hull () {
				translate([x*m,5,0]) cylinder(spool_holder_width, r=4.5, center=true, $fn=fn);
				translate([x*m,0,0]) cylinder(spool_holder_width, r=4.5, center=true, $fn=fn);
			}
		}
	}


// ## Bearing Axle and Housing##
// ## bushing arguments (id=8, od=22, bw=7, ed=12, b=2, tw=24)
	translate([bearing_spacing/2, bearing_od/2+bushing_wall_depth, 0])
	 bushing(bearing_id, bearing_od, bearing_w, bushing_wall_depth*2, number_of_bearings, spool_holder_width);
	translate([-bearing_spacing/2, bearing_od/2+bushing_wall_depth, 0])
	 bushing(bearing_id, bearing_od, bearing_w, bushing_wall_depth*2, number_of_bearings, spool_holder_width);
}
	// ##Screw Holes ##
	for (m = [-1, 1]) { 
		for (x = [bearing_spacing/2+bushing_r-4.5, bearing_spacing/2-bushing_r+4.5]) {
	translate([x*m,5,0]) cylinder(100, r=1.7, center=true, $fn=fn);
	translate([bearing_spacing/5*m,0,spool_holder_width/2-side_wall_width*2]) rotate([90,0,0]) cylinder(100, r=1.7, center=true, $fn=fn);
	translate([bearing_spacing/5*m,0,-spool_holder_width/2+side_wall_width*2]) rotate([90,0,0]) cylinder(100, r=1.7, center=true, $fn=fn);

		}
	}

// ## Cut off Feet
	if (no_feet == true) {
		translate([0,-25,0]) cube([200,50,50], center=true);
	}
}

}


// ######################     Reel      ###########################

module reel() {
	difference() {
		translate([0,0,0]) color("grey") cylinder(6, r=100, $fn=fn*3);
		translate([0,0,-1]) cylinder(8, r=16, $fn=fn*3);
	}

}

// ######################     Bearing      ###########################

//bearing(6, 19, 6);
module bearing(id, od, w) {
	difference() {
		union() {
			translate([0,0,0]) color("red") cylinder(w,r=od/2, center = true, $fs=.1);
		}
		union() {
			translate([0,0,0]) cylinder(w+2,r=od/2-1, center = true, $fs=.1);
		}
	}
	difference() {
		union() {
			translate([0,0,0]) color("red") cylinder(w,r=id/2+1, center = true, $fs=.1);
			translate([0,0,0]) color("black") cylinder(w-0.5,r=od/2-1, center = true, $fs=.1);
		}
		union() {
			translate([0,0,0]) cylinder(w+2,r=id/2, center = true, $fs=.1);
		}
	}
}

// ######################     Bushing      ###########################

module bushing(id=8, od=22, bw=7, ed=12, b=2, tw=22) {
gap = b*bw;
//translate([0,0,0]) bearing(8, 22, 7);
difference() {
	union() {
// ## Axle ##
	difference() {
		translate([0,0,0]) cylinder(tw, r=id/2-0.02, center=true, $fn=fn);
	}
// ## Bearing Support ##
		difference() {
			translate([0,0,0]) cylinder(tw, r=id/2*1.375, center=true, $fn=fn);
			translate([0,0,0]) cylinder(gap, r=od*2, center=true, $fn=fn);
		}
// ## End Caps ##
		difference() {
			translate([0,0,0]) cylinder(tw, r=od/2+ed/2, center=true, $fn=fn);
			translate([0,0,0]) cylinder(gap-2, r=od*2, center=true, $fn=fn);
			translate([0,0,0]) cylinder(gap+2, r=od/2+1, center=true, $fn=fn);
		}
	}

	translate([0,0,0]) cylinder(100, r=1.7, center=true, $fn=fn);
// ## Uncomment for half bushing
//#	translate([-60,-50,0]) cube([120,100,50]);
}
}
// ###################################################################

