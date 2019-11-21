// width 
width = 16; // [1:1:100]

// thickness
th = 5;  // [1:1:10]

// move the bracket back and forward
forward = -4;  // [-100:1:100]

// angle
angle = 35;  // [-180:1:90]

// length
length = 65;  // [30:1:1000]

/* [Hidden] */
base_length = 20; // 
gap = 11.75;
depth = 4;
hook_th = 1.4;
hook_chamfer = 0.4;
snap_th = 2;
snap_length = 16;
margin = 0.4;
e = 0.01;
$fa=1;
$fs=0.5;

// preview[view:south, tilt:top]

rotate([-90, 0, 0]) main();

module base()
{
    difference()
    {
        translate([-th, -width/2, -base_length]) cube([th, width, base_length]);
        translate([0, 0, -base_length/2]) rotate([0, 90, 0]) cylinder(d=3.2, h=th*2+e, center=true);
    }
    translate([0, -width/2, 0])
    {
        cube([max(th, forward), width, th]);
        mirror([1, 0, 0]) cube([max(th, -forward), width, th]);
    } 
}

module head()
{
    difference()
    {
        cube([depth+margin, width, gap]);
        translate([-e, width/4-margin, gap-snap_th-hook_th-margin])
        cube([depth+margin+2*e, width/2+2*margin+e, hook_th+snap_th+margin+e]);
        translate([depth+margin, -e, gap-hook_th]) rotate([0, -45, 0]) cube([hook_th, width+2*e, hook_th*2]);
    }
    translate([depth+margin, 0, 0]) difference()
    {
        mirror([1, 0, 1]) cube([hook_th, width, hook_th]);
        translate([0, -e, -hook_chamfer]) rotate([0, 135, 0]) cube([hook_th*2, width+2*e, hook_th]);
    }

    difference()
    {
        snap();
        translate([-margin-th, 0, snap_th])
        {
            cube([th+depth+margin*2, width/4+margin, gap+hook_th]);
            translate([0, width*3/4-margin, 0]) cube([th+depth+margin*2, width/4+margin, gap+hook_th]);
        }
    }
}

module snap()
{
    length = snap_length;
    module profile()
    {
        
        difference()
        {
            union()
            {
                translate([-length, gap/2]) circle(d=gap);
                rotate(90) square([gap, length]);
                translate([margin, gap-snap_th])
                {
                    square([depth, snap_th]);
                    translate([depth-hook_th, 0]) difference()
                    {
                        square([hook_th, snap_th+hook_th]);
                        translate([hook_th, snap_th+hook_chamfer]) rotate(45) square([hook_th, hook_th*2]);
                    } 
                }
                translate([0, gap-snap_th]) square([depth, snap_th]);
            }
            translate([0, snap_th]) rotate(90) square([gap-snap_th*2, length]);
            translate([-length, gap/2]) circle(d=gap-snap_th*2);
        }
    }
    translate([0, width, 0]) rotate([90, 0, 0]) linear_extrude(height=width) profile();
}

module neck()
{
    difference()
    {
        cube([th, width, length]);
        translate([-e, width/4-margin, length-gap-margin])
        cube([th+2*e, width/2+margin*2, hook_th+snap_th+margin*2]);
    }
}

module main()
{
    base();

    translate([forward, 0, 0])
    rotate([0, angle, 0])
    translate([-th, -width/2, 0])
    {
        translate([th, 0, length]) mirror([0, 0, 1]) head();
        neck();
    }
}
