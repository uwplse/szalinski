/*
Trying out the customizer with a minimal script that
generates a stack of polygons with a circle in the middle.
The top and bottom polygons are the circumscribed and
inscribed respectively. Uses a single parameter (number
of sides) as shown here: 

http://customizer.makerbot.com/docs

// variable description
variable name = default value; // possible values

*/

// Number of Sides
N=5; // [3,4,5,6,7,8,9,10,11,12,13]

color("RoyalBlue") cylinder(r=10/cos(180/N), h=5, $fn=N);
color("DeepSkyBlue") translate([0,0,5]) cylinder(r=10, h=5, $fn=12*N);
color("Aqua") translate([0,0,10]) cylinder(r=10, h=5, $fn=N);
