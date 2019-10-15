////////////////////////////////////////////////////////////////////////////
// Manhattan Pegboard Collection v1 : 4 Peg Bin
// designed in NYC by Matt Manhattan (mattmanhattan.com)
////////////////////////////////////////////////////////////////////////////

// These parameters create the INTERIOR size of your bin (in mm)

width = 60; // This is the width of the shelf -- MINIMUM is '32' for 2 rows of pegs
depth = 40; // This is the depth of the shelf
height = 32; // This is the height of the shelf -- MINIMUM is '32' for 2 rows of pegs
thickness = 2; // This is the thickness of the shelf
pegs = 2; // span between pegs [0 = centered (one peg // 1 = 2 pegs // 2 = 3 pegs // 3 = 4 pegs]

//////////////////////////////////////////////////////////////////
// Pegboard Bin
//////////////////////////////////////////////////////////////////

 // This code generates the rectangular shape of your bin
 
 difference()
    {
        // this is the exterior shape
        cube ([depth+(thickness*2),width+(thickness*2),height]); 
       
        // this is the interior shape which we are removing
        translate([thickness,thickness,0])
        {    
            cube ([depth,width,height]);
        }
    }
    
// This code generates the base of the bin
// if you comment it out you will remove the base of your bin which can be useful for tools
    
   cube([depth+(thickness*2),width+(thickness*2),thickness], centerequals);
     
//////////////////////////////////////////////////////////////////
// Pegboard Pegs
//////////////////////////////////////////////////////////////////

pegCenterToCenterDistance = 25.4; 	    // 1 inch spacing
pegDiameter = 6.35; 					// 1/4 inch peg holes
pegLength = 12;                         // length of the pegs
midpointY = width/2;
midpointZ = height/2;
    
// leave this alone - it alters the center point of the model
centerequals = false; 
///////////////////

// this rotates the pegs 90 degrees
rotate([0,-90,0])
    {    
    translate([(midpointZ+((pegCenterToCenterDistance/2))),(midpointY+((pegCenterToCenterDistance/2)*pegs)),0])    // moves PEG 1 to its position
        { 
        cylinder(h=pegLength, r=(pegDiameter/2), center=centerequals);  // PEG 1 (top left)
        }
        
    translate([(midpointZ+((pegCenterToCenterDistance/2))),(midpointY-((pegCenterToCenterDistance/2)*pegs)),0])    // moves PEG 2 to its position
        {    
        cylinder(h=pegLength, r=(pegDiameter/2), center=centerequals); // PEG 2 (top right)
        }
        
    translate([(midpointZ-((pegCenterToCenterDistance/2))),(midpointY+((pegCenterToCenterDistance/2)*pegs)),0])    // moves PEG 3 to its position
        { 
        cylinder(h=pegLength, r=(pegDiameter/2), center=centerequals);  // PEG 3 (bottom left)
        }
        
    translate([(midpointZ-((pegCenterToCenterDistance/2))),(midpointY-((pegCenterToCenterDistance/2)*pegs)),0])    // moves PEG 4 to its position
        {    
        cylinder(h=pegLength, r=(pegDiameter/2), center=centerequals); // PEG 4 (bottom right)
        }
    }
    
    
    

 