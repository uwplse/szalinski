// units in millimeters
//


clearance = 30; // [8:50]
//original spacer has 19 mm of clearance
// flask is 25.3mm high

/* [Hidden] */

resolution = 50;
width = 12.5;
depth = 17.5;

cut_height = 15;
cut_depth = 11;
cut_width = width;

microscope_lens = 4;

height = cut_height + clearance + microscope_lens; // original 38 mm

screw_distance = 8.15; // 11.65 and 4.65
screw_diameter = 5.5;
screw_inner_diameter = 3.65;
screw_depth = 5;

peg_diameter = 6.5;
peg_height = 11.6;
peg_distance_front = 6.6+peg_diameter/2;
//6.77 diameter 2.65

module body() {
    difference() {
        cube([width, depth, height], center = false);
        translate([0, depth-cut_depth, height-cut_height])
            cube([cut_width, cut_depth, cut_height], center = false);
        screws();
        translate([0, 0, -screw_distance]) screws();
        peg();
    }
}
module screws() {
    translate([width/2, 0, -screw_diameter/2+height-1]){
        rotate([-90, 0, 0]){
            cylinder(h = screw_depth, d = screw_diameter, $fn = resolution);
            cylinder(h = depth-cut_depth, d = screw_inner_diameter, $fn = resolution);
        }
    }
}

module peg() {
    translate([width/2, peg_distance_front, 0])
    cylinder(h = peg_height,d = peg_diameter , center=false, $fn = resolution);
}
body();