// Allen key/hex key extender
// version 0.0.1
// by pixelhaufen
// is licensed under CC BY-SA 3.0 -> https://creativecommons.org/licenses/by-sa/3.0/

//------------------------------------------------------------------
// User Inputs


/*[propertys]*/
// inner diameter of the key
inner_diameter = 4.3; // [1:0.1:10]

// height of the extender
height = 50; // [10:1:80]

// depth of the hole for the bit
depth = 12; // [8:1:20]

// use a multiple of your nozzle
shell = 0.8; // [0.1:0.05:5]

// diameter of the base
base_diameter = 8; // [8:1:20]


/*[Hidden]*/
$fn = 150; // stell can't be modified on thingiverse
incircle = inner_diameter/2;
base_radius = base_diameter/2;


//------------------------------------------------------------------
// Main

difference()
{
    union()
    {
        hexagon(incircle+shell,height);
        cylinder(r1=base_radius, r2=incircle+shell, h=depth, center=false);
        cylinder(r1=base_radius, r2=base_radius, h=1, center=false);
    }
    
    translate([0,0,height-depth])
    {
        hexagon(incircle,depth);
    }
}


//------------------------------------------------------------------
// Module

module hexagon(incircle, height)
{
    r=incircle/(sqrt(3)/2);
    linear_extrude(height = height, center = false, convexity = 10, twist = 0)
    {
        angles=[ for (i = [0:6-1]) i*(360/6) ];
        coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
        polygon(coords);
    }
 }
 