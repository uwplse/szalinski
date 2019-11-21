/**
 * CornerGurad.scad by Ron Tajima (ryosuke.tajima <at> gmail <dot> com)
 *
 * This corner guard is for orthogonal corner consists from three beam along x,y,z axis.
 * The inside corner is the coordinate origin.
 *
 * corner_gurad(length, width, thickness, inner_fillet, outer_fillet)
 *   length: Length from the inner face to the beam tip
 *   width: Beam width from the inner face to the wall edge
 *   thickness: thickness of each wall
 *   inner_fillet: Radius of inner fillet around axis (x,y,z).
 *   outer_fillet: Radius of outer fillet of each (x,y,z) beam.
 *   chamfer: make chamfer for outer corner if it is true.
 *
 */

// length for x direction (without the wall thickness)
length_x = 30;
// length for y direction (without the wall thickness)
length_y = 40;
// length for z direction (without the wall thickness)
length_z = 50;
// wall width of x side
width_x = 10;
// wall width of y side
width_y = 10;
// wall width of z side
width_z = 10;
// thickness of the wall with x-axis normal vector
thickness_x = 1.5;
// thickness of the wall with y-axis normal vector
thickness_y = 1.5;
// thickness of the wall with z-axis normal vector
thickness_z = 1.5;
// Radius of inner fillet with x-axis normal vector
inner_fillet_x = 3;
// Radius of inner fillet with y-axis normal vector
inner_fillet_y = 3;
// Radius of inner fillet with z-axis normal vector
inner_fillet_z = 3;
// Radius of outer fillet with x-axis normal vector
outer_fillet_x = 4;
// Radius of outer fillet with y-axis normal vector
outer_fillet_y = 4;
// Radius of outer fillet with z-axis normal vector
outer_fillet_z = 4;
// On/Off of corner chamfer
chamfer_flag = "On"; // [On, Off]

corner_guard(length=[length_x,length_y, length_z], width=[width_x,width_y,width_z], thickness=[thickness_x,thickness_y,thickness_z], inner_fillet=[inner_fillet_x,inner_fillet_y,inner_fillet_z], outer_fillet=[outer_fillet_x,outer_fillet_y,outer_fillet_z], chamfer=chamfer_flag);

// Corner guard
module corner_guard(length=[50,50,50], width=[10,10,10], thickness=[2,2,2], inner_fillet=[0,0,0], outer_fillet=[0, 0, 0], chamfer="On") {
    difference() {
	union() {
	    three_beams();
	    inner_fillet();
	}
	outer_fillet();
	if (chamfer=="On") {
	    corner_chamfer();
	}
    }
    // Main three beams
    module three_beams() {
	guard_length=length+thickness;
	guard_width=width+thickness;
	difference() {
	    union() {
		// Beam around X-axis
		difference() {
		    translate([-thickness[0], -thickness[1], -thickness[2]]) {
			cube(size=[length[0]+thickness[0], width[2]+thickness[1], width[1]+thickness[2]]);
		    }
		    translate([-2*thickness[0], width[0], width[0]]) {
			cube(size=[length[0], length[1], length[2]]);
		    }
		}
		// Beam around Y-axis
		difference() {
		    translate([-thickness[0], -thickness[1], -thickness[2]]) {
			cube(size=[width[2]+thickness[0], length[1]+thickness[1], width[0]+thickness[2]]);
		    }
		    translate([width[1], -2*thickness[1], width[1]]) {
			cube(size=[length[0], length[1], length[2]]);
		    }
		}
		// Beam around Z-axis
		difference() {
		    translate([-thickness[0], -thickness[1], -thickness[2]]) {
			cube(size=[width[1]+thickness[0], width[0]+thickness[1], length[2]+thickness[2]]);
		    }
		    translate([width[2], width[2], -2*thickness[2]]) {
			cube(size=[length[0], length[1], length[2]]);
		    }
		}
	    }
	    cube(size=guard_length);
	}
    }
    // Inner fillets
    module inner_fillet() {
	// Fillets around X-axis 
	translate([-thickness[0], width[0], width[0]] ) {
	    rotate([90, 0, 90]) {
		rounded_corner_3d(inner_fillet[0], thickness[0]);
	    }
	}
	// Fillets around Y-axis 
	translate([width[1], 0, width[1]] ) {
	    rotate([90, 0, 0]) {
		rounded_corner_3d(inner_fillet[1], thickness[1]);
	    }
	}
	// Fillets around Z-axis 
	translate([width[2], width[2], -thickness[2]] ) {
	    rotate([0, 0, 0]) {
		rounded_corner_3d(inner_fillet[2], thickness[2]);
	    }
	}
    }
    // Outer fillets
    module outer_fillet() {
	// Fillets around X-axis 
	translate([-thickness[0], length[1], width[0]]) {
	    rotate([-90, 0, -90]) {
		rounded_corner_3d(outer_fillet[1], thickness[0]);
	    }
	}
	translate([-thickness[0], width[0], length[2]]) {
	    rotate([-90, 0, -90]) {
		rounded_corner_3d(outer_fillet[2], thickness[0]);
	    }
	}
	// Fillets around Y-axis 
	translate([length[0], -thickness[1], width[1]]) {
	    rotate([0, 90, 90]) {
		rounded_corner_3d(outer_fillet[0], thickness[1]);
	    }
	}
	translate([width[1], -thickness[1], length[2]]) {
	    rotate([0, 90, 90]) {
		rounded_corner_3d(outer_fillet[2], thickness[1]);
	    }
	}
	// Fillets around Z-axis 
	translate([length[0], width[2], -thickness[2]]) {
	    rotate([0, 0, 180]) {
		rounded_corner_3d(outer_fillet[0], thickness[2]);
	    }
	}
	translate([width[2], length[1], -thickness[2]]) {
	    rotate([0, 0, 180]) {
		rounded_corner_3d(outer_fillet[1], thickness[2]);
	    }
	}
    }
    // Corner chamfer
    module corner_chamfer() {
	th = min(thickness[0],thickness[1],thickness[2]);
	rotate([-45,0,-45]) {
	    translate([0, 0, -10-th]) {
		cube([40,40,20], center=true);
	    }
	}
    }
}

// 2d fillet curve
module rounded_corner_2d(d, offset=0.001) {
    difference() {
	square([d+offset, d+offset]);
	translate([d, d]) {
	    circle(r=d,$fs=0.1);
	}
    }
}

// 3d fillet shape
module rounded_corner_3d(d,l,offset=0.001) {
    v = [-offset, -offset, -offset];
    translate(v) {
	linear_extrude(height=l+2*offset) {
	    rounded_corner_2d(d);
	}
    }
}
