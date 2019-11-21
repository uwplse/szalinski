/* [Guide Dimensions] */
// width of the belt guide, not including overlap
width = 20.9;
// depth of the belt guide, not including overlap
depth = 12.4;
// heigth of the belt guide, not including overhang thickness
height = 9.5;
/* [Overlap adjustments] */
// thickness of the plates that keep the guide from sliding up and down
plate_thickness = 1.5;
// amount by which the top and bottom plates overlap the edges of the guide body
overlap = 1.05;
/* [Belt slit] */
// the angle at which the slit is set into the wall of the guide
slit_angle = -45;
// the width of the slit (can easily be smaller than the thickness of the belt, as the guide will flex)
slit_width = 0.6;
/* [Guide opening] */
// the width of the opening for guiding the belt
opening_width = 18;
// the depth of the opening for guiding the belt
opening_depth = 10.9;

module slit() {
    rotate([0,0,slit_angle]) {
        cube([10,slit_width,height+3*plate_thickness]);
    }
}

module opening(thing_height, thing_depth, thing_width, opening_depth, opening_width) {
    z_offset = 2.5;
    opening_height=thing_height+2*z_offset;
    y_midpoint = thing_depth/2;
    x_midpoint = thing_width/2;
    opening_radius = opening_depth/2;
    left_cylinder_x_center = thing_width/2 - opening_width/2 + opening_radius;
    right_cylinder_x_center = thing_width/2 + opening_width/2 - opening_radius;
    
    translate([left_cylinder_x_center,y_midpoint,-z_offset]) {
        cylinder(h=opening_height,r=opening_radius);
    }
    translate([right_cylinder_x_center,y_midpoint,-z_offset]) {
        cylinder(h=opening_height,r=opening_radius);
    }
    translate([left_cylinder_x_center,y_midpoint-opening_radius,-z_offset]) {
        cube([opening_width-opening_depth,opening_depth,opening_height]);
    }
}


difference() {
    union() {
        cube([width,depth,height]);
        translate([-overlap,-overlap,height]) {
            cube([width+2*overlap,depth+2*overlap,plate_thickness]);
        };

        translate([-overlap,-overlap,-plate_thickness]) {
            cube([width+2*overlap,depth+2*overlap,plate_thickness]);
        };
    }
    opening(thing_height=height, thing_depth=depth, thing_width=width, opening_width = opening_width, opening_depth=opening_depth);
    translate([width*.9,depth/2,-1.5*plate_thickness]) {
        slit();
    }
}
