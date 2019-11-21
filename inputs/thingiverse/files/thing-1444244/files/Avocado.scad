
// Avocado stand
// OpenSCAD version based on original design by t_colon
// http://www.thingiverse.com/thing:1146533

 
// preview[view:north east, tilt:bottom diagonal]

// Outer diameter of Ring
ring_dia = 40;   //[40:60]
// Width of Ring
ring_width = 15; //[14:20]
// Thickness of support
thickness = 2;   //[0.5:0.5:3]
// Height
support_height = 41; //[10:60]
// Overlap between rings
overlap = 5; //[3:7]
// 
single_or_quad = "quad"; // [single,quad]

/* [Visualize] */
show_tiled = "no"; //[yes, no]


/* [Hidden] */
tiling = ring_dia - overlap;
hole_dia = ring_dia - ring_width;
ridge_dia = ring_dia - (ring_dia - hole_dia) / 2;
//
//echo(hole_dia/2, (ring_width-hole_dia));
interlock_depth = 4;//+hole_dia-ring_width;
interlock_slop = 1;

//
cyl_res = 80;
Delta = 0.1;


//------------------------------
// ref, only for visual compare
module ref_model() {
	import("t_colon-avocado-x4.stl");
}
module ref() {
	translate([-1.5,0,3.5]) 
	color([0.7,0.7,0])
		ref_model();
	translate([-1.5, 70, 3.5]) 
	color([0,0.7,0.7])
		ref_model();
}


//------------------------------
module ring() {
	// flat disk
	difference() {
		cylinder(h=thickness, d=ring_dia, center=true, $fn=cyl_res);
		// from hole_dia
		cylinder(h=thickness+Delta*2, d=hole_dia, center=true, $fn=cyl_res);
	}
	// ridge
	translate([0,0,thickness])
	difference() {
		cylinder(h=thickness*2, d=ridge_dia, center=true, $fn=cyl_res);
		// from hole_dia
		cylinder(h=(thickness+Delta*2)*2, d=ridge_dia-thickness, center=true, $fn=cyl_res);
	}
}

module leg()  {
	translate([0,0,support_height/2])
	cylinder(h=support_height, d1=6, d2=2, center=true, $fn=cyl_res);
}

// plain Support
module support() {
	ring();
	foot_offset = 0.707*ridge_dia/2;
	for (i=[1:4])  {
		rotate([0,0,i*90])
		translate([foot_offset,foot_offset,0])
			leg();
	}
}

// the key
module interlock(slop=0)  {
	translate([0,-ridge_dia/2,0])  {
		cube(size=[thickness+slop,interlock_depth*1.5,thickness], center=true);
		translate([0,-interlock_depth/2,0])
			cylinder(h=thickness, d=thickness*1.5+slop, center=true, $fn=cyl_res);
	}
}

// Supports with cutouts for key
module interlocked_support()  {
	// trim off adjacent ring
	difference()  {
		support();
		translate([0,-tiling+interlock_slop/2,0])
			cylinder(h=thickness*8, d=ring_dia, center=true, $fn=cyl_res);
	}
	// interlock
	interlock();
}

// Supports with keys
module keyed_support() {
	difference() {
		support();
		// interlock
		translate([0,-tiling,0])
		mirror([0,1,0])
		scale([1,1,10]) // to cut through everything
			interlock(0.8);
	}
}


module quad_support() {
	translate([0,tiling,0])
	rotate([0,0,180])
		interlocked_support();
	translate([tiling,0,0])
		interlocked_support();
	translate([tiling,tiling,0])
	rotate([0,0,180])
		keyed_support();
	translate([])
		keyed_support();
}


//
translate([0,0,thickness/2])
if (single_or_quad == "single") {
	support();
} else {
		quad_support();
		if (show_tiled == "yes") {
			translate([0,tiling*2,0])
				quad_support();
		}
}
// ref();