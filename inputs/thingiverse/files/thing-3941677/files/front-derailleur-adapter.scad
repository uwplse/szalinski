$fn = 1024;

d_inner = 28.6;
d_outer = 34.9;
height = 23;
height2 = height + 2;
tollerance = 0.25;

difference()
{
    hull()
    {
        cylinder(d = d_outer, h = height, center = true);

        translate([0, 0, height2 - height])
        cylinder(d = (d_inner + d_outer) / 2, h = height2, center = true);
    }

    cylinder(d = d_inner, h = 100, center = true);

    translate([50 - tollerance, 0, 0])
    cube([100, 100, 100], center = true);
}
