/*
    To create plastic linear bearings similar to the Igus® Drylin® RJ4JP-01-08 Sliding Bearing.

    You can choose to either create just the bearing or incorporate it in a block ready to mount.
    
    print in PLA for the properties of the harder plastic also concidder some kind of lubrication.
    
    inspired by:
    Toothed Linear Bearing by KR2
    www.thingiverse.com/thing:18219
    
    And 
    
    SC8UU Bushing by AxMod
    www.thingiverse.com/thing:1126245
    

*/

/* [Bearing Settings]*/

Inside_Diameter = 8;
Outside_Diameter = 15;
Length = 24;
Wall_Thickness = 1.5;
Number_of_teeth = 8;


Block = "yes"; // [yes, no]

/* [Block Settings]*/

How_Many_Mounting_Holes = 2; //[0, 2, 4, 6]
//The Diameter of the mounting holes so for an M3 bolt put 3 if you want to cut your own thread or 3.4 if you prefer to use with a nut
Mounting_Holes_Diameter = 3.2;
// Size of the nut across it's flats
Nut_size = 5.4;
// Set to 0 if you do not want retaining holes for nut
Nut_Depth = 3;


// need to create the 30 degrees champher properly.

difference()
{
    union()
    {
        if (Block == "yes")
        {
            cylinder (h=Length, d= Outside_Diameter, center = true, $fn = 50);
            translate ([-Outside_Diameter,0,-0.5*Length]) cube([Outside_Diameter *2,0.5*Outside_Diameter, Length]);
        }
        if (Block == "no")
        {
        cylinder (h=Length -3, d= Outside_Diameter, center = true, $fn = 50);
        translate ([0,0,(Length - 3) /2]) cylinder (h=1.5 , d1= Outside_Diameter, d2 = Outside_Diameter-1.74, center = false, $fn = 50);
        translate ([0,0,-Length/2 ]) cylinder (h=1.5 , d2= Outside_Diameter, d1 = Outside_Diameter-1.74, center = false, $fn = 50);
        }
    }    
    cylinder (h=Length+ 0.2, d= Inside_Diameter+0.5, center = true, $fn = 50); // remove core
    
// remove bands on outside
    if (Block == "no")
    {
    translate ([0,0,(Length /2) - 3.25 - 1.1])
    {
        difference()
        {
            cylinder(h = 1.1, d= Outside_Diameter, center = false, $fn = 50);
            cylinder(h = 1.1, d= Outside_Diameter-0.4, center = false, $fn = 50);
        }
    }
    
        translate ([0,0,-(Length /2) + 3.25 ])
    {
        difference()
        {
            cylinder(h = 1.1, d= Outside_Diameter, center = false, $fn = 50);
            cylinder(h = 1.1, d= Outside_Diameter-0.4, center = false, $fn = 50);
        }
    }
    }
// Remove Mounting Holes for Block
    if (Block == "yes")
        {
            if (How_Many_Mounting_Holes == 2)
            {
                translate ([0,0,0])Screw_Holes ();
            }
            if (How_Many_Mounting_Holes == 4)
            {
                translate ([0,0,0.25*Length])Screw_Holes ();
                translate ([0,0,-0.25*Length])Screw_Holes ();
            }
            if (How_Many_Mounting_Holes == 6)
            {
                translate ([0,0,0.25*Length])Screw_Holes ();
                translate ([0,0,0])Screw_Holes ();
                translate ([0,0,-0.25*Length])Screw_Holes ();
            }
        }
    
// Teeth    
    for ( i = [ 0: Number_of_teeth])
    {
        A = 360 / Number_of_teeth;
        rotate ([0,0, A * i]) 
        {
            translate([0,-0.5,-(Length/2)]) cube ([0.5*(Outside_Diameter -(Wall_Thickness*2)),1,Length]);
            /*
            // this gives the slots between the teeth a rounded end but takes ages to render.
            intersection() 
            {
                cylinder ( h=Length, d = Outside_Diameter -(Wall_Thickness*2), center = true, $fn = 50);
                translate ([0,-0.5,- Length/2])cube(size = [(0.5*Outside_Diameter),1,Length], center = false);
            }*/
           // Hollow out teeth
            
        }
    }
    
}

module Screw_Holes ()
{
    
    nut = 2*((Nut_size / 2) / cos(30))+0.5;
    translate ([-0.75 *Outside_Diameter,-0.1,0])rotate([270,30,0]) 
    {
        cylinder(h=0.55*Outside_Diameter ,d=Mounting_Holes_Diameter, $fn = 50);
        cylinder(h=Nut_Depth ,d=nut, $fn = 6);
    }
    translate ([0.75 *Outside_Diameter,-0.1,0])rotate([270,30,0]) 
    {
        cylinder(h=0.55*Outside_Diameter ,d=Mounting_Holes_Diameter, $fn = 50);
        cylinder(h=Nut_Depth ,d=nut, $fn = 6);
    }

    
}
