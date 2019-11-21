module torus(bigradius, smallradius)
{
    x = 1;
    rotate_extrude (convexity = 10, $fn = 24)
    translate ([ x, 0, 0 ])
    circle (r = radius);
}

$fn = 500;
union()
{
    difference()
    {
        cylinder(h=20, d=90);
        translate([0, 0, -1]) cylinder(h=22, d=86);
    }
    difference()
    {
        cylinder(h=10, d=86);
        cylinder(h=10, d1=84, d2=76);
        translate([0, 0, 8]) cylinder(h=2, d1=76, d2=80);
    }
}
