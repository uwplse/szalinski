/*
For inner circle of radius R, the inside radius of the blades is 1.5R and the outer radius of the blades is 5R. The blades are separated by 60°.
*/

// Coaster Diameter (mm)
coaster_diameter = 100; // [1:200]
// Height of the base (mm)
base_height = 2; // [0:10]
// Height of the rim (mm)
rim_height = 5; // [0:10]
// Thickness of the rim (mm)
rim_thickness = 2.8; // [0:10]
// Height of the radiation symbol (mm)
symbol_height = 3.5; // [0:10]
// Gap between symbol and rim (mm)
gap_thickness = 3; // [0:10]

/* [Hidden] */
$fn = 100;

diam = coaster_diameter;
baseH = base_height;
rimH = rim_height;
rimT = rim_thickness;
symH = symbol_height;
gap = gap_thickness;

symDout = diam-2*rimT-2*gap;
centerD = symDout/5.0;
symDin = centerD*1.5;

//color("yellow")
cylinder(baseH,d1=diam,d2=diam);

//color("black")
{
    cylinder(symH,d1=centerD,d2=centerD,$fn=50);
    rotate_extrude(angle=60) translate([symDin/2,0,0]) square([(symDout-symDin)/2,symH]);
    rotate([0,0,120]) rotate_extrude(angle=60) translate([symDin/2,0,0]) square([(symDout-symDin)/2,symH]);
    rotate([0,0,-120]) rotate_extrude(angle=60) translate([symDin/2,0,0]) square([(symDout-symDin)/2,symH]);
    translate([0,0,baseH]) rotate_extrude(angle=360) translate([diam/2-rimT,0,0]) square([rimT,rimH-baseH]);
}