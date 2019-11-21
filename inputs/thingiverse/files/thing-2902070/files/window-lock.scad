//  Window Lock
$fn=40;
$arm_length = 90;

base();
translate([-10, 0, 0]) locking_arm();

//  Locking arm
module locking_arm()
{
    cube([20,10,$arm_length]);
    translate([0,10,$arm_length - 10]) cube([20,15,10]);
}

module base()
{
    difference()
    {
        translate([-25, 0, 0]) cube([50,20,10]);
        translate([18, 10, 0]) countersunk_hole();
        translate([-18, 10, 0]) countersunk_hole();
    }
}

module countersunk_hole()
{
    translate([0, 0, 2]) cylinder(h=4, d1=3, d2=8.5);
    translate([0, 0, 6]) cylinder(h=4, d=8.5);
    translate([0, 0, 0]) cylinder(h=10, d=3);
}