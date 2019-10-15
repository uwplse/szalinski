// (C) 2016 B. Visee, info@lichtsignaal.nl
// This is for making lightboxes in, mostly, h0-scale, houses
// No guarentees, but I like it!

// You can make it all sorts of sizes with an adjustable
// number of holes for your LED's (also adjustable!)
// Printed at 0.25mm or 0.3mm height. 0.4 is too big
// The parameters are INSIDE sizes!

// ===================================
// ** CHANGELOG
// ===================================
// v1 Added better spacing for holes
//    Added holestart parameter so you can align hole(s) from the sides

// ===================================
// ** START USER PARAMETERS
// ===================================

width = 70;
depth = 20;
height = 20;
diameter = 3.5;     // On my da Vinci this is the size for 3mm LED
numholes = 3;       // Number of holes you want, if set auto = 0
holestart = 10;      // Start/end position of hole

// To-Do ...
//autohole = 0;       // Auto-magic number of holes (WIP)
//autospacing = 10;   // Auto-magic spacing of holes (WIP)
// Add wall options 

// ===================================
// ** END USER PARAMETERS
// ===================================

holewidth =  ( ( width - ( holestart * 2 ) ) / (numholes - 1) );

union()
{
    difference()
    {
        cube([height+2,width+2,depth+2]);

        translate([1, 1, 2])
        {
        cube([height,width,depth+2]);
        }
        
        if(numholes == 1)
        {
            translate([(height/2)+1,(width/2)+1,-3])
            {
                cylinder(10,d=diameter,diameter/2,$fn=64);
            }
        }
        else
        {
            for (n = [ 1 : numholes ] )
            {
                
                if( n == 1 )
                {
                    translate([(height/2)+1,holestart+1,-3])
                    {
                        cylinder(10,d=diameter,diameter/2,$fn=64);
                    }
                }
               
                if ( n == numholes )
                {
                    translate([(height/2)+1,width - (holestart),-3])
                    {
                        cylinder(10,d=diameter,diameter/2,$fn=64);
                    }
                }
                
                if( ( n != 1) && ( n != numholes) )
                 {
                    translate([(height/2)+1,((n-1)*holewidth) + holestart,-3])
                    {
                        cylinder(10,d=diameter,diameter/2,$fn=64);
                    }
                }   
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