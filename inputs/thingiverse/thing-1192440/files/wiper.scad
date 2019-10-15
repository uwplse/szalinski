// Custom Wiper Box by Matt Johnson
// intentional3D
// Use this to customize your own nozzle wiper for multi extruding printers.


//


width = 110;
depth = 110;
height = 10;
wallThickness = 1;
gap=1;
base=10;






gapThickness = gap+1;


base();


module base() 
    {
        union() 
        {
                 //base
                difference()
                { 
                    translate([-(width)/2, -(depth)/2, -height-base]) 
                    {
                
                        cube([width,depth,height+base]);
                    }
                
        
                translate([(width-2*gapThickness-2*wallThickness)/-2,(depth-2*gapThickness-2*wallThickness)/-2,-50]) 
                    {
                        cube([(width-2*gapThickness-2*wallThickness),(depth-2*gapThickness-2*wallThickness),100]);
                    }
     
                }
            // Outer Wall
            difference()
            {
                translate([-width/2, -depth/2, 0]) 
                {
                    cube([width,depth,height]);
                }
	
                translate([(-width/2) + wallThickness, -depth/2 + wallThickness, -50]) 
                {
                    cube([width - (wallThickness * 2), depth - (wallThickness * 2), 100]);
                }
                                
            }
            // inner wall
                difference()
                { 
                    translate([-(width-2*gapThickness)/2, -(depth-2*gapThickness)/2, 0]) 
                    {
                
                        cube([width-2*gapThickness,depth-2*gapThickness,height]);
                    }
                
        
                translate([(width-2*gapThickness-2*wallThickness)/-2,(depth-2*gapThickness-2*wallThickness)/-2,-height]) 
                    {
                        cube([(width-2*gapThickness-2*wallThickness),(depth-2*gapThickness-2*wallThickness),100]);
                    }
     
                }
           
                
            }
        }