// configurable stuff

divider_thickness = 1; 			// [0.1:0.1:100]
support_wall_thickness = 2;		// [0.1:0.1:100]
support_height = 15;			// [0.1:0.1:100]
support_width = 30;				// [0.1:0.1:100]

/* [Hidden] */

support_length = support_width;
total_thickness = divider_thickness + (2 * support_wall_thickness);


module makebox ( xbox, ybox, zbox ) {

    translate([-(xbox/2), -(ybox/2), 0]) 
    cube([xbox, ybox, zbox]);

}

difference() {

union() {
    makebox(total_thickness, support_width, support_height);
    makebox(support_length, total_thickness, support_height);
    
}

translate([0,0,support_wall_thickness]) makebox(divider_thickness,support_width+1, support_height);    
translate([0,0,support_wall_thickness]) makebox(support_length+1, divider_thickness, support_height);

}