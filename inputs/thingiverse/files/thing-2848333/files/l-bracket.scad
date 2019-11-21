// thickness of back and base, and minimum thickness of side walls
wall_thickness = 5;
// width of cavity within
internal_width = 15;
// external width won't have any effect unless it's greater than internal_width + 2*wall_thickness
external_width = 30;
// height and base length
base_length = 30;


// metric size of flat head screws, I have a box of 4 x 20mm screws
screw = 4;
screw_length = 20;

// customizable variables end here

module screw(d, l) {
    // head
    union() {
        cylinder(h=2.3, r1=d, r2=d/2);
        cylinder(h=l, r=d/2);
    }
}

$fs=0.2;
$fa=1;

part_width = max(wall_thickness*2 + internal_width, external_width);
width_wall = max(wall_thickness, (part_width - internal_width)/2);

difference() {
    cube([part_width, base_length, base_length], center=false);
    // cut away half to make triangle with correct wall thickness
    translate([-part_width/part_width, -wall_thickness, 0]) rotate([45, 0, 0])
        cube([2*part_width, 2*base_length, 2*base_length], center=false);
    // create cavity within
    translate([width_wall, -wall_thickness, wall_thickness])
        cube([internal_width, base_length, base_length]);
    translate([width_wall + internal_width/2, base_length/2 - wall_thickness, wall_thickness + 0.1]) 
        rotate([180, 0, 0]) screw(screw, screw_length);
    translate([width_wall + internal_width/2, base_length - wall_thickness - 0.1, wall_thickness + base_length/2]) 
        rotate([270, 0, 0]) screw(screw, screw_length);
}