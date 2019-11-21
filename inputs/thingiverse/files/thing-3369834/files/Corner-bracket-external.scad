// thickness of wall
wall_thickness = 3;
// length of sides
side_length = 50;

// metric size of flat head screws, I have a box of 4 x 20mm screws
screw = 4;
// metric length of screws
screw_length = 20;

// Distance from sides to screw hole. 3 means 1/3 of side_length
hole_adjustment_factor = 2.7;

// customizable variables end here

module screw(d, l) {
    // head
    union() {
        cylinder(h=2.3, r1=d, r2=d/2);
        cylinder(h=l, r=d/2);
    }
}

difference() {
    cube([side_length, side_length, side_length], center=false);
    // cut away edges to make triangle shape with correct wall thickness
    translate([-side_length/2, -wall_thickness, 0]) rotate([45, 0, 0])
        cube([2*side_length, 2*side_length, 2*side_length], center=false);
    translate([-wall_thickness, -side_length/2, 0]) rotate([0, -45, 0])
        cube([2*side_length, 2*side_length, 2*side_length], center=false);
    translate([0, side_length-wall_thickness, -0.1])
        rotate([0, 0, -135])
        cube([2*side_length, 2*side_length, 2*side_length], center=false);
    // create cavity within
    translate([-wall_thickness, -wall_thickness, wall_thickness])
        cube([side_length, side_length, side_length]);
    // screw holes
    translate([side_length - (side_length/hole_adjustment_factor), side_length - (side_length/hole_adjustment_factor), -0.1])
            rotate([0, 0, 0]) screw(screw, screw_length);
    translate([side_length + 0.1, side_length - (side_length/hole_adjustment_factor), (side_length/hole_adjustment_factor)])
            rotate([0, -90, 0]) screw(screw, screw_length);
    translate([side_length - (side_length/hole_adjustment_factor),side_length + 0.1 ,(side_length/hole_adjustment_factor)])
            rotate([90, 0, 0]) screw(screw, screw_length);

}

$fs=0.2;
$fa=1;
