// (C) 2016 B. Visee, info@lichtsignaal.nl
// This is for making lightboxes in, mostly, h0-scale, houses
// No guarentees, but I like it!
// You can make it all sorts of sizes with an adjustable
// number of holes for your LED's (also adjustable!)

// 0.25mm height
// 

// Set parameters as you wish
width = 30;
depth = 20;
height = 20;
diameter = 3.5; // On my da Vinci this is the size for 3mm LED
numholes = 2;

// Leave alone from here, unless you know what you are doing
holedistance = (width / (numholes+1)) + 1;

translate([1,15,2])
{
    cube([20,2,20]);
}

union()
{
    difference()
    {
        cube([height+2,width+2,depth+2]);

        translate([1, 1, 2])
        {
        cube([height,width,depth+2]);
        }

        for (n = [ 1 : numholes ] )
        {
            translate([(height/2)+1,n*holedistance,-3])
            {
                cylinder(10,d=diameter,diameter/2,$fn=64);
            }
        }
    }

    difference()
    {
        translate([0,-2,depth])
        {    
            cube([height+2,2,2]);
        }

        translate([-1,1,depth-1])
        {
            rotate([135,0,0])
            {
                cube([height+4,5,5]);
            }
        }
    }

    difference()
    {
        translate([0,width+2,depth])
        {    
            cube([height+2,2,2]);
        }

        translate([-1,width+8,depth-1])
        {
            rotate([135,0,0])
            {
                cube([height+4,5,5]);
            }
        }
    }
}