////////////////////////////////////////////////////////////////////////////
// Manhattan Pegboard Collection v1 : 4 Peg Bin Rounded
// designed in NYC by Matt Manhattan (mattmanhattan.com)
////////////////////////////////////////////////////////////////////////////

// These parameters create the INTERIOR size of your bin (in mm)

width = 32;  // This is the DIAMETER of the cylinder cutout -- MINIMUM is '28' for 2 rows of pegs
depth = width; // This is the depth of the shelf
height = 32; // This is the height of the shelf -- MINIMUM is '32' for 2 rows of pegs
thickness = 2; // This is the thickness of the shelf
pegs = 1; // span between pegs [0 = centered (one peg // 1 = 2 pegs // 2 = 3 pegs // 3 = 4 pegs]

// leave this alone - it alters the center point of the model
centerequals = false; 
///////////////////

//////////////////////////////////////////////////////////////////
// Rounded Pegboard Bin
//////////////////////////////////////////////////////////////////

 difference()
    {
        // this generates the rear cube which attaches to the pegs
        cube ([((depth/2)),width+(thickness*2),height]); 
       
        translate([midpointY,midpointY,0])
        {
            
            cylinder (height,d=(width),centerequals);  
        }
    }
        
difference()
    {
      translate([midpointY,midpointY,0])
        {
            
            cylinder ($fa=1,height,d=(width+(thickness*2)),centerequals);  // exterior circle shape
        }  
        
      translate([midpointY,midpointY,thickness]) // if you change 'thickness' to '0' you will remove the base of your bin which can be useful for tools
        {
            
            cylinder (height,d=width,centerequals);  // interior circle shape
        }
    }    

//////////////////////////////////////////////////////////////////
// Pegboard Pegs
//////////////////////////////////////////////////////////////////   

pegCenterToCenterDistance = 25.4; 	    // 1 inch spacing
pegDiameter = 6.35; 					// 1/4 inch peg holes
pegLength = 12;                         // length of the pegs
midpointY = (width+(thickness*2))/2;
midpointZ = height/2;

// PEG 1
// this rotates the peg 90 degrees
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