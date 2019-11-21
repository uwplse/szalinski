// outer dimensions of the box
size_x = 150;
size_y = 150;
size_z = 100;

// distance between pickets
space = 40;
// thickness of pickets (x-dimension)
thickness = 4;
// thickness of pickets (y-dimension)
side_width = 2;

module box_side(width=100,height=100) {
    sqrt2 = sqrt(2);
    translate([-height,0,0]) union() {
        difference() {
            union() {
                for(pos_x=[0:(width+height)/space]) {
                    translate([pos_x*space,0,0]) rotate([0,45,0]) cube([thickness,side_width,sqrt2*height]);
                    translate([pos_x*space+height,0,0]) rotate([0,-45,0]) cube([thickness,side_width,sqrt2*height]);
                }
            }
            translate([-1,-1,-2*thickness]) cube([height+thickness,side_width+2,height+4*thickness]);
            translate([height+width,-1,-2*thickness]) cube([height+thickness,side_width+2,height+4*thickness]);
            translate([height,-1,-thickness-1]) cube([width,side_width+2,thickness+1]);
            translate([height,-1,height]) cube([width,side_width+2,thickness+1]);
        }
        translate([height,0,0]) cube([width,side_width,thickness]);
        translate([height,0,height-thickness]) cube([width,side_width,thickness]);
        translate([height,0,0]) cube([thickness,side_width,height]);
        translate([width+height-thickness,0,0]) cube([thickness,side_width,height]);
    }
}

module box(width=100,depth=100,height=100) {
    union() {
        box_side(width,height);
        translate([0,depth-side_width,0]) box_side(width,height);
        translate([side_width,0,0]) rotate([0,0,90]) box_side(depth, height);
        translate([width,0,0]) rotate([0,0,90]) box_side(depth, height);
        translate([0,0,side_width]) rotate([-90,0,0]) box_side(width,depth);
    }
}

box(size_x, size_y, size_z);
