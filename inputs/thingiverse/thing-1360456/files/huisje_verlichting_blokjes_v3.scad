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
// v2 Started working on inner walls for bigger boxes, easier to glue
// v3 Add one print mount, have to do the multiple ones yet ;)

// ===================================
// ** ToDo
// ===================================

// Add inner-wall options, with auto?

// ===================================
// ** START USER PARAMETERS
// ===================================

// Basic sizes (inner sizes)
depth = 20;
width = 45;
height = 20;
thick = 2;          // Thickness of box walls, varies for printers
                    // Does not affect bottom btw! That is steady 2mm.
thicklimit = 6;     // Limit for adding 45 degree supports                    

// Holes with automatic spacing
enableholes = 0;    // Simple holes in the back
diameter = 3.5;     // On my da Vinci this is the size for 3mm LED
numholes = 3;       // Number of holes you want, if set auto = 0
holestart = 5;      // Start/end position of hole

// Mount for print, no automatic spacing for maximum flexibility
enableprint = 1;    // Adds a slide-in mount for a print
printwidth = 6;
numprints = 2;
printspacing = 24;  // Space between print mounts
printstart = 6;     // Y-start position

// ===================================
// ** END USER PARAMETERS
// ===================================

// For good measure
outerdepth = depth + (thick*2);     // X
outerwidth = width + (thick*2);     // Y
outerheight = height;               // Z

// TESTING

// END TESTING

// Space between inner holes
holespacing = ( width - ( ( holestart * 2 ) + diameter ) ) / (numholes - 1);

union()
{
    difference()
    {
        // Base cube
        cube([outerdepth,outerwidth,outerheight]);

        translate([thick, thick, 2])
        {
            cube([depth,width,height]);
        }
        
        // Slider opening
        if(enableprint)
        {
            // Add center one for one print, ToDo
            for (n = [ 0 : (numprints-1) ])
            {
                translate([0,printstart+(n*printspacing),0])
                {
                    difference()
                    {
                        translate([-0.5,4,-0.1])
                        {
                            cube([0.6+thick,printwidth-1,height-8]);
                        }
                    }
                }
            }
        }
        
        // Holes in the back
        if(enableholes)
        {
            if(numholes == 1)
            {
                translate([(depth/2)+(thick),(outerwidth/2),-3])
                {
                    cylinder(10,d=diameter,diameter/2,$fn=50);
                }
            }
            else
            {
                for (n = [ 1 : numholes ] )
                {
                    
                    if( n == 1 )
                    {
                        translate([(depth/2)+(thick),holestart+thick+(diameter/2),-3])
                        {
                            cylinder(10,d=diameter,diameter/2,$fn=50);
                        }
                    }
                   
                    if ( (n == numholes) && ( n != 1) )
                    {
                        translate([(depth/2)+(thick),width - ( (holestart-thick) +(diameter/2) ),-3])
                        {
                            cylinder(10,d=diameter,diameter/2,$fn=50);
                        }
                    }
                    
                    if( ( n != 1) && ( n != numholes) )
                     {
                        translate([(depth/2)+(thick),( (holespacing* (n-1) )+thick+holestart+(diameter/2)),-3])
                        {
                            //echo( ( (holespacing* (n-1) )+thick+holestart+diameter));
                            cylinder(10,d=diameter,diameter/2,$fn=50);
                        }
                    }   
                }
            }
        }
    }
    
    // Print slider stuff
    if(enableprint)
    {
        for (n = [ 0 : (numprints-1) ])
            {
                translate([0,printstart+(n*printspacing),0])
                {
                    union()
                    {
                        // Sliding part
                        translate([-2.5,printwidth+5,0])
                        {
                            cube([2.5,2,height]);
                        }

                        translate([-2.5,0,0])
                        {
                            cube([2.5,2,height]);
                        }

                        translate([-4,0,0])
                        {
                            cube([1.5,4,height]);
                        }

                        translate([-4,printwidth+3,0])
                        {
                            cube([1.5,4,height]);
                        }
                        
                        translate([-4,1.5,height-2])
                        {
                            cube([4,printwidth+3.5,2]);
                        }
                    }
                }
            }
    }
    
    // Glue edges for smaller sizes
    if(thick<thicklimit)
    {
        translate([0,0,-2])
        {
            difference()
            {
                translate([0,-2,height])
                {    
                    cube([outerdepth,2,2]);
                }

                translate([-1,1,height-1])
                {
                    rotate([135,0,0])
                    {
                        cube([outerdepth+2,5,5]);
                    }
                }
            }
        }
        
        translate([0,outerwidth+2,-2])
        {
            difference()
            {
                translate([0,-2,height])
                {    
                    cube([outerdepth,2,2]);
                }

                translate([-1,4,height-1])
                {
                    rotate([135,0,0])
                    {
                        cube([outerdepth+2,5,5]);
                    }
                }
            }
        }
    }
}