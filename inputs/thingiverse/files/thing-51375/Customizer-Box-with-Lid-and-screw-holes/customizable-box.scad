//box length
box_length = 50;

//box_breadth
box_breadth = 50;

//box height
box_height = 50;

//outer radius for rounded box
radius_outer = 5;

//radius for screw holes
radius_hole = 2;

module faceplate(l,b,r_outer,r_hole) {
	difference() {
		minkowski() {
			circle(r_outer);
			square([l,b]);
		}
		circle(r_hole);
		translate([l,0,0])circle(r_hole);
		translate([0,b,0])circle(r_hole);
		translate([l,b,0])circle(r_hole);
	}
}

module inner_shape(l,b,r_outer) {
	difference() {
		square([l,b]);
		circle(r_outer);
		translate([l,0,0])circle(r_outer);
		translate([0,b,0])circle(r_outer);
		translate([l,b,0])circle(r_outer);
	}
}

module box(l,b,h,r_outer,r_hole) {
	union() {
		linear_extrude(height = h)
		{
			difference() {
				faceplate(l,b,r_outer,r_hole);
				inner_shape(l,b,r_outer,r_hole);
			}
		}
		linear_extrude(height = 2)faceplate(l,b,r_outer,r_hole);
	}
}

box(box_length,box_breadth,box_height,radius_outer,radius_hole);
translate([box_length+2*radius_outer+5,0,0])linear_extrude(height = 2)faceplate(box_length,box_breadth,radius_outer,radius_hole);


