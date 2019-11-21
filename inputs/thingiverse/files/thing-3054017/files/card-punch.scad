// This is an over shot card cutter punch.
//
// Warning -- some sanding and fitting may be required.
//
// This is licensed under the creative commons+attribution license
//
// To fulfill the attribution requirement, please link to:
// http://www.thingiverse.com/thing:3054017

/* [Main] */

// Define number of facets (large numbers provide better smoothing)
$fn=100;

// Define outer shell holder diameter in mm
d1=14.0;

// Define inner shell holder diameter in mm
d2=11.0;

// Define cutter diameter in mm
d3=18.5;

// Define sphere diameter in mm
d4=25.0;

// Define shell holder height in mm
h1=3.175;

// Define punch height (above base) in mm
h2=60.0;

module base()
{
    union()
    {
        hull()
        {
            rotate_extrude(convexity=10)
            translate([d1/2-h1/2,0,0])
            circle(r=h1/2);
        }
        translate([0,0,h1]) cylinder(r=d2/2,h=h1,center=true);
    }
}

union()
{
    difference()
    {
        // Render cutting punch
        translate([0,0,0]) cylinder(r=d3/2,h=h2,center=true);
        // Subtract sphere from top to improve cutting surface
        translate([0,0,h2/2+d4/3]) sphere(r=d4/2,center=true);
    }
    // Render base
    translate([0,0,-(h2/2+1.5*h1)]) base();
}
