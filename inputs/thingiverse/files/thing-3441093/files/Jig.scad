$fa=6*1;
$fs=0.5*1;


// Jig lenght
length=160;

// Jig width
width=65;

// Lenghtwise (1) or widthwise (0) jig?
type = 0;

// Hole spacing from limit stop
space=45;

// Jig thickness
thick=4;

// Hole Diameter (in mm)
dia=5;

// Center hole distance
chd=128;

// Limit stop high
limit=15;

difference()
{
    union() {
    // build main plate
    linear_extrude(thick) 
    square([(thick+width),length]);

    if (type)
    {
    translate([0,0,0]) 
    linear_extrude(limit) square([width, thick]);
    }
    else
    {
    translate([0,0,0]) 
    linear_extrude(limit) square([thick, length]);
    }  
    }

    // Drill bottom hole
    translate ([(thick+space+(dia/2)),((length-chd)/2), 0])
    cylinder(h=thick*4, d=dia, center=true);


    // Drill top hole
    translate ([(thick+space+(dia/2)),(chd+(length-chd)/2), 0])
    cylinder(h=thick*4, d=dia, center=true);
}
