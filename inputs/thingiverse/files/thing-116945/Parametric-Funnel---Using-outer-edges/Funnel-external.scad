// Parametric Funnel by Coasterman
// Modified by asp55

// VARIABLES
bottom_diameter = 60;
cone_height = 20;
top_diameter = 25;
top_height = 8;
width = 2.5;

// CODE
union()
{
difference()
{
cylinder(h=cone_height, r1=bottom_diameter/2, r2 = top_diameter/2);

cylinder(h=cone_height, r1=bottom_diameter/2 - width, r2 = top_diameter/2 - width);
}
translate([0, 0, cone_height])
{
difference()
{
cylinder(h=top_height, r=top_diameter/2);
cylinder(h=top_height, r=top_diameter/2 - width);
}
}
}