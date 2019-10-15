// (C) 2016 B. Visee, info@lichtsignaal.nl
// This is for making lightboxes in, mostly, h0-scale, houses
// No guarentees, but I like it!

// ===================================
// ** CHANGELOG
// ===================================

// v1   Added better spacing for holes
//      Added holestart parameter so you can align hole(s) from the sides
// v2   Started working on inner walls for bigger boxes, easier to glue
// v3   Add one print mount, have to do the multiple ones yet ;)
// v3.1 Added print-thickness option
// v4   Removed simple holes, the effect is just not realistic enough
//      Added inner wall option with autospacing
//      Added autospacing for print holders

// ===================================
// ** ToDo
// ===================================

// Suggestions welcome :)

// ===================================
// ** START USER PARAMETERS
// ===================================

// Basic sizes (inner sizes)
depth           = 20;
width           = 60;
height          = 20;
thick           = 2;            // Thickness of box walls, varies for printers
                                // Does not affect bottom btw! That is steady 2mm.
thicklimit      = 6;            // Limit for adding 45 degree glue supports                    

// Inner walls with automatic spacing
enablewalls     = 1;            // Inner walls (0 disable, 1 enable)
wallthick       = 5;            // Thickness of inner wall
numwalls        = 4;            // Number of walls

// Mount for print with automatic spacing
enableprint     = 1;            // Adds a slide-in mount for a print (0 disable, 1 enable)
printwidth      = 5;            // Print width. Wider print can be used to add more then 1 LED
numprints       = 3;            // Supports maximum of 3 sliders
printstart      = 0;            // Y-start position
printthick      = 2.5;          // Thickness of your print

// ===================================
// ** END USER PARAMETERS
// ===================================

// For good measure
outerdepth      = depth + (thick*2);     // X
outerwidth      = width + (thick*2);     // Y
outerheight     = height;                // Z
offsetprint     = (printwidth - numprints) - 0.5;
wallspace       = (outerwidth / (numwalls+1)) ;
printspacing    = ((outerwidth - ((numprints * printwidth)+(printstart * 2))) / (numprints-1)) + offsetprint;

// TESTING

// END TESTING

union()
{
    // Inner walls
    if(enablewalls)
    {
        for (n = [ 1 : (numwalls) ])
        {
            translate([thick,(n*wallspace)-(wallthick/2),0])
            {
                cube([depth,wallthick,outerheight]);
            }
        }
    }
    
    /*
    if(enablewalls && (numprints > 2))
    {
        for (n = [ 0 : (numprints-2) ])
        {
            translate([thick,(printstart+wallspace)+(n*wallspace),0])
            //translate([thick,(((width+(wallthick/2)-thick)/numprints))+(n*printspacing),0])
            {
                cube([depth,wallthick,outerheight]);
            }
        }
    }
    */
    
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
            // Add center one for one print
            if(numprints == 1)
            {
                translate([0,(width/2)-((thick-0.5)+(printwidth/2)),0])
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
   
            if(numprints == 2)
            {
                for (n = [ 0 : (numprints-1) ])
                {
                    translate([0,(printstart/2)+(n*((outerwidth-(printstart+thick))-(printwidth*2))),0])
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
            
            if(numprints > 2)
            {   
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
        }        
    }
    
    // Print slider stuff
    if(enableprint)
    {
        // Add center one for one print
        if(numprints == 1)
        {
            translate([0,(width/2)-((thick-0.5)+(printwidth/2)),0])
            {
                union()
                {
                    // Sliding part
                    translate([-printthick,printwidth+5,0])
                    {
                        cube([printthick,2,height]);
                    }

                    translate([-printthick,0,0])
                    {
                        cube([printthick,2,height]);
                    }

                    translate([-(printthick+1.5),0,0])
                    {
                        cube([1.5,4,height]);
                    }

                    translate([-(printthick+1.5),printwidth+3,0])
                    {
                        cube([1.5,4,height]);
                    }
                    
                    translate([-(printthick+1.5),1.5,height-2])
                    {
                        cube([(printthick+1.5),printwidth+3.5,2]);
                    }
                }
            }
        }
        
        if(numprints == 2)
        {
            for (n = [ 0 : (numprints-1) ])
            {
                translate([0,(printstart/2)+(n*((outerwidth-(printstart+thick))-(printwidth*2))),0])
                {
                    union()
                    {
                        // Sliding part
                        translate([-printthick,printwidth+5,0])
                        {
                            cube([printthick,2,height]);
                        }

                        translate([-printthick,0,0])
                        {
                            cube([printthick,2,height]);
                        }

                        translate([-(printthick+1.5),0,0])
                        {
                            cube([1.5,4,height]);
                        }

                        translate([-(printthick+1.5),printwidth+3,0])
                        {
                            cube([1.5,4,height]);
                        }
                        
                        translate([-(printthick+1.5),1.5,height-2])
                        {
                            cube([(printthick+1.5),printwidth+3.5,2]);
                        }
                    }
                }
            }
        }
        
        if(numprints > 2)
        {
            for (n = [ 0 : (numprints-1) ])
            {
                translate([0,printstart+(n*printspacing),0])
                {
                    union()
                    {
                        // Sliding part
                        translate([-printthick,printwidth+5,0])
                        {
                            cube([printthick,2,height]);
                        }

                        translate([-printthick,0,0])
                        {
                            cube([printthick,2,height]);
                        }

                        translate([-(printthick+1.5),0,0])
                        {
                            cube([1.5,4,height]);
                        }

                        translate([-(printthick+1.5),printwidth+3,0])
                        {
                            cube([1.5,4,height]);
                        }
                        
                        translate([-(printthick+1.5),1.5,height-2])
                        {
                            cube([(printthick+1.5),printwidth+3.5,2]);
                        }
                    }
                }
            }
        }
    }
    
    // Glue edges for thin outerwalls (you probably want that at walls < 2mm thick)
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