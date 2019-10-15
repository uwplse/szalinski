// Replacement part for IKEA Faktum Drawer Frontplate Mount
//
// As I don't think my printer can even remotely handle the screws for
// adjusting, I simply made this model adjustable. It mimicks the
// original without being adjustable once printed.
// Enter values (in ° and in mm, repsectively) and see how the model changes.
// Careful - it is possible to enter nonsensical numbers!
//
rotate_knob_angle = 0;
adjust = 0;
//
// no changes below here should be necessary
//
module screw_hole(){
    difference(){
        cylinder(6.5,6.25,6.25,center=false);
        translate([0,0,-.5]) cylinder(7.5,3.3,3.3,center=false);
        translate([0,0,3.5]) cylinder(d=10.5,h=4);
    }
}

module rotate_knob(){
    rotate([rotate_knob_angle,0,0])
    rotate([0,90,0])
    union(){
        cylinder(8.1,6,6);
        translate([2.5,0,0]) cylinder(14,3.25,3.25);
    }
}

module adjust_screw(){
    rotate([0,90,0])
    translate([0,0,adjust])
    difference(){
        cylinder(10,6.5,6.5);
        cylinder(10,4,4);
    }
}

$fs=.3;
$fa=1;
rotate([0,-90,180]){
//rotate([0,0,0]){
    difference(){
    union(){
        translate([5.5,16,0]) screw_hole();
        translate([5.5,-16,0]) screw_hole();
        translate([4,0,1.5]) cube([8,25.4,3],center=true);
        translate([1,0,1.5]) cube([2,32,3],center=true);
    }
    translate([-3,0,0]) cube([6,40,20],center=true);
}

translate([1.125,10.5,2]) cylinder(23,1.125,1.125);
translate([1.125,-10.5,2]) cylinder(23,1.125,1.125);

translate([1.5625,10.5,25]) cylinder(30,0.5625,0.5625);
translate([1.5625,-10.5,25]) cylinder(30,0.5625,0.5625);

translate([4,0,13])cube([8,21,24],center=true);
difference(){
    translate([4.5,0,40]) cube([7,21,30],center=true);
    translate([0,0,47]) cube([20,14,10],center=true);
}

translate([4.5,10.5,54.9]){
    rotate([90,0,0])
    difference(){
        scale([1,1.5,1]) cylinder(21,3.5,3.5);
        translate([0,-6,10.5]) cube([7,12,21], center=true);
    }
}
translate([0,0,16]) rotate_knob();
translate([0,0,33]) adjust_screw();
}
