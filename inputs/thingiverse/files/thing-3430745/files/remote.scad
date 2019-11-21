$fn = 100;

difference()
{
    // hollow outer box
    difference()
    {
        cube([95,75,50], center=true);
        translate([0,0,-2]) cube([91,71,50], center=true);

    }

    // antenna hole
    translate([3,20,25]) cylinder(d=11, h=5, center=true);

    // switch hole
    translate([0,-35,-10]) cube([14,10,10], center=true);

    // usb hole
    translate([47,-21,-10]) cube([5,18,10], center=true);

    // joystick holes
    translate([24,-10,23]) joystickHoles();
    translate([-24,-10,23]) joystickHoles();
}

// lid
translate([100,0,16]) cube([95,75,3], center=true);
difference()
{
    translate([100,0,12]) cube([90,71,4], center=true);
    translate([100,0,12]) cube([87,67,6], center=true);
}

// joystick breakouts
translate([-80,30,16.5]) joystickBreakout();
translate([-80,-30,16.5]) joystickBreakout();


module joystickHoles()
{
    cylinder(h=6,d=28,center=true);
    translate([18,18,0]) cylinder(h=6,d=3.5,center=true);
    translate([-18,18,0]) cylinder(h=6,d=3.5,center=true);
    translate([-18,-18,0]) cylinder(h=6,d=3.5,center=true);
    translate([18,-18,0]) cylinder(h=6,d=3.5,center=true);
}

module joystickBreakout()
{
    difference()
    {
        cube([43,43,2], center=true);

        // pcb holes
        translate([13,11,0]) cylinder(h=6,d=3.5,center=true);
        translate([-13,11,0]) cylinder(h=6,d=3.5,center=true);
        translate([-13,-9,0]) cylinder(h=6,d=3.5,center=true);
        translate([13,-9,0]) cylinder(h=6,d=3.5,center=true);

        // spacer holes
        translate([18,18,0]) cylinder(h=6,d=3.5,center=true);
        translate([-18,18,0]) cylinder(h=6,d=3.5,center=true);
        translate([-18,-18,0]) cylinder(h=6,d=3.5,center=true);
        translate([18,-18,0]) cylinder(h=6,d=3.5,center=true);
    }
}
