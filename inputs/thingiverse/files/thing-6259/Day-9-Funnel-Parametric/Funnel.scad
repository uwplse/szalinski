// Parametric Funnel by Coasterman

// VARIABLES
bottom_diameter = 70;
cone_height = 45;
top_diameter = 5;
top_height = 20;
width = 2.5;

// CODE
union()
{
difference()
{
cylinder(h=cone_height, r1=bottom_diameter/2 + width, r2 = top_diameter/2 + width);
cylinder(h=cone_height, r1=bottom_diameter/2, r2 = top_diameter/2);
}
translate([0, 0, cone_height])
{
difference()
{
cylinder(h=top_height, r=top_diameter/2 + width);
cylinder(h=top_height, r=top_diameter/2);
}
}
}