// The diameter of the hole at the centre of the spool into which this widget must fit
spool_hole_diameter = 53.5; // [23:60]
// Whether or not the centre of this widget should be open to slide over a bar
closed = false; // [true,false]

/* [Hidden] */

$fa = 6; // minimum angle per fragment
$fs = 1; // minimum length per fragment

M8_r = 8 / 2 + .2;
bearing_r = 22/2 + .2;
spool_overlap = 2;

bearing_h = 3;
interface_h = 1;
spool_h = 3;

weird_angle = asin(M8_r / bearing_r);

function cis(a) = [cos(a), sin(a)];

module thing(closed, diameter)
{
	spool_r = diameter/2;
    translate([0,0,bearing_h	+ interface_h]) difference()
    {
        union()
        {
            translate([0, 0, -interface_h])
                cylinder(r = spool_r, h = spool_h + interface_h);
            translate([0, 0, -interface_h - bearing_h])
                cylinder(r = spool_r + spool_overlap, h = bearing_h + interface_h);
        }

        translate([0, 0, -bearing_h - interface_h - 1])
            cylinder(r = bearing_r, h = bearing_h + 1);
        translate([0, 0, -interface_h - bearing_h - 1])
            linear_extrude(height = spool_h + interface_h + bearing_h + 2)
        if(!closed) {
            // This bit needs to be fixed to cope with holes bigger than 39mm
            polygon(bearing_r * [
                cis(weird_angle) + [100, 0],
                cis(weird_angle),
                cis(90 + weird_angle/2),
                cis(180),
                cis(270 - weird_angle/2),
                cis(-weird_angle),
                cis(-weird_angle) + [100, 0],
            ]);
        } else {
            polygon(bearing_r * [
                cis(0),
                cis(60),
                cis(120),
                cis(180),
                cis(240),
                cis(300),
            ]);
        }
    }
}

thing(closed, spool_hole_diameter);
