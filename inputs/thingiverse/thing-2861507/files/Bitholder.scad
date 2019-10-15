// Drill bit holder for attaching to whatever
// CC
// Authr: Neon22 April 2018

// Holder length
holder_length = 60;   // [10:200]
// Holder Depth
holder_depth  = 8;     // [6:20]
// Holder Height
holder_height = 20;    // [10:60]
// Corner Rounding
rounding = 4;          // [1:6]
// Base support thickness
support_thickness = 3; // [1:8]

//Width of Bits
bit_size = 8;     // [3:0.25:10]
// How many bits to hold
howmany_bits  = 6;  // [2:12]
// Magnet diameter
magnet_dia   = 6;   // [3:10]
// Magnet thickness
magnet_depth = 2;   // [1:0.5:6]

/* [Hidden] */
Delta = 0.1;
cyl_res = 22;

// Hex shaped drill bit cutouts
module bit () {
	cylinder(d=bit_size, h=holder_height, $fn=6, center=true);
}

// Hole for the round magnets
module magnet() {
	cylinder(d=magnet_dia,$fn=cyl_res,h=holder_depth,center=true);
}

// corner posts with rounded tops to be hulled together
module corner () {
	y= holder_depth-rounding/2;
	translate([0,0,-rounding/4]) {
		cylinder(d=rounding, h=y, $fn=cyl_res, center=true);
		translate([0,0,y/2])
			sphere(d=rounding, center=true, $fn=cyl_res);
	}
}

// hull 4 corner posts together
module base() {
	w = (holder_length-rounding)/2;
	h = (holder_height-rounding)/2;
	hull() {
		translate([-w,-h,0]) corner();
		translate([-w,+h,0]) corner();
		translate([w,-h,0]) corner();
		translate([w,+h,0]) corner();
	}
	
}

// bring it all together
module holder() {
	active_length = holder_length+rounding;
	stepsize = active_length/(howmany_bits+1);
	start_offset = stepsize*(howmany_bits+1)/2;
	difference() {
		base();
		for (i = [1: howmany_bits]) {
			// bits
			translate([-start_offset+stepsize*i, support_thickness, holder_depth/2])
			rotate([90,0,0])
				bit();
			// magnets
			translate([-start_offset+stepsize*i, 0, holder_depth-bit_size/2-magnet_depth])
				magnet();
		}
	}
}

holder();

