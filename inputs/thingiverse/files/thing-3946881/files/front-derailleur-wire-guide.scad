$fn = 128;

d_seattube = 28.6;
// d_seattube = 34.9; // for wider tube
r_seattube = d_seattube / 2;
dist_tube = 20;
d_wire_hole = 1.5;
d_bowden_hole = 6;
h = 25;
strenght = 3;

clamp_h = 13.5; // TODO: buy and measure
clamp_w = 11.5; // TODO: buy and measure

tollerance = 0.2;

difference()
{
    // main body
    hull()
    {
        cylinder(r = r_seattube + strenght, h = h);

        translate([r_seattube + dist_tube, 0, 0])
        cylinder(d = d_bowden_hole + strenght, h = h);
    }

    // hole for tube
    cylinder(d = d_seattube, h = 100, center = true);

    // cutout for bowden
    translate([r_seattube + dist_tube, 0, h / 2])
    union()
    {
        translate([0, 0, -50])
        cylinder(d = d_wire_hole, h = 100);

        translate([0, 0, -100])
        cylinder(d = d_bowden_hole, h = 100);
    }

    // "tunnel" for clamp
    translate([0, 0, strenght])
    difference()
    {
        hull()
        {
            cylinder(r = r_seattube + strenght + clamp_w, h = clamp_h);
            
            translate([r_seattube + strenght, -50, 0])
            cube([clamp_w, 100, clamp_h]);

        }
        
        cylinder(d = d_seattube + 2 * strenght, h = 100, center = true);
    }

    // divider
    translate([-tollerance, -50, -50])
    cube([tollerance, 100, 100]);
}
