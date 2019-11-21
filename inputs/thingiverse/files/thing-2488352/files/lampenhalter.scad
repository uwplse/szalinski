/* [Socket] */

// Diameter of lamp attachment tube [mm]
lamp_dia = 16; // [5:50]

// Thickness of socket wall [mm]
wall_str = 5; // [1:20]

// Depth of the hollow socket [mm]
socket_len = 40; // [10:200]

/* [Rectangular Base] */

// Length of rectangular base [mm]
base_length = 50; // [10:200]

// Width of rectangular base [mm]
base_width = 50; // [10:200]

// Height of rectangular base [mm]
base_height = 10; // [1:50]

/* [Screw Holes] */

// Screw holes: Diameter of inset for screw head [mm]
screw_hole_large_diam = 8; // [2:30]

// Screw holes: Diameter of actual screw hole [mm]
screw_hole_small_diam = 6; // [2:30]

// Screw holes: x/y distance of screw holes from edge [mm]
screw_hole_dist_from_edge = 3; // [0:100]

// Screw holes: Distance from back side at which screw holes begin [mm]
screw_hole_base_height = 10; // [2:30]



module outline(lamp_dia, wall_str, base_dim, mink_cyl_h,socket_len,mink_cyl_d) {
	hull() {
		minkowski()
		{
		  cube(base_dim);
		  cylinder(r=mink_cyl_d,h=mink_cyl_h);
		}
		
		difference() { // allow socket wall to cut into base (if socket wall thicker than base height)
			// render socket
			translate([-mink_cyl_d,base_dim[1]/2,lamp_dia/2+mink_cyl_h+base_dim[2]])
			rotate([0,90,0])
				cylinder(h=socket_len, d=lamp_dia+2*wall_str);
				// helper cube to allow socket wall to cut into base
				translate([0,0,-100+base_dim[2]]) cube([base_dim[0], base_dim[1], 100]);
		}
	}
}

module screw_hole_punch(base_height, large_diam, small_diam) {
	translate([0,0,base_height]) cylinder(h=100, d=large_diam, center=false);
	translate([0,0,-1]) cylinder(h=100, d=small_diam, center=false);
}

function screw_hole_coords (large_r, mink_d, edge_dist, base_w, base_l) = [
	[edge_dist+large_r-mink_d, base_l-(edge_dist+large_r-mink_d), 0],
	[base_w-(edge_dist+large_r-mink_d), base_l-(edge_dist+large_r-mink_d), 0],
	[base_w-(edge_dist+large_r-mink_d), edge_dist+large_r-mink_d, 0],
	[-mink_d+large_r+edge_dist,-mink_d+large_r+edge_dist,0]
];	

mink_cyl_h = 1;
mink_cyl_d = 2;
base_dim = [base_length, base_width, base_height];
screw_hole_coords_list = screw_hole_coords(screw_hole_large_diam/2, mink_cyl_d, screw_hole_dist_from_edge, base_dim[0], base_dim[1]);


$fn=100;
//color("gray")
difference() {
	// outline slab - no holes yet!
	outline(lamp_dia, wall_str, base_dim, mink_cyl_h,socket_len,mink_cyl_d);
	
	union() {
		// socket hole
		translate([-5,base_dim[1]/2,lamp_dia/2+mink_cyl_h+base_dim[2]])
			rotate([0,90,0]) cylinder(h=socket_len+5, d=lamp_dia);
		// screw holes
		for(coords = screw_hole_coords_list)
			translate(coords) screw_hole_punch(screw_hole_base_height, screw_hole_large_diam, screw_hole_small_diam);
	}
	
}

