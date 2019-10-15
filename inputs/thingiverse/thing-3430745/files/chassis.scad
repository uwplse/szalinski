$fn = 100;

//%translate([52.7,-0.6,88]) rotate([90,180,0]) import("solar.stl");

// base
cube([90,80,2], center=true);

difference()
{
    union()
    {
        // screwboard 1
        translate([7,20,(22.23/2)+1]) rotate([90,180,0]) difference()
        {
            cube([32,22.23,3], center=true);
        }

        // bevel 1
        translate([14,-13.5,6]) rotate([180,90,0]) difference()
        {
            cube([5,5,23]);
            translate([0,0,-1]) cylinder(h=27,d=10);
        }

        // screwboard 2
        translate([7,-20,(22.23/2)+1]) rotate([90,180,0]) difference()
        {
            cube([32,22.23,3], center=true);
        }

        // bevel 2
        translate([-9,13.5,6]) rotate([0,90,0]) difference()
        {
            cube([5,5,23]);
            translate([0,0,-1]) cylinder(h=27,d=10);
        }
    }

    // holes
    rotate([90,0,0])
    {
        translate([-2.2,12,0]) cylinder(d=7.6,h=90, center=true); // 4.6
        translate([17.75,20.7,0]) cylinder(d=3.5,h=90, center=true); // m3
        translate([17.75,3.25,0]) cylinder(d=3.5,h=90, center=true);
    }
}
