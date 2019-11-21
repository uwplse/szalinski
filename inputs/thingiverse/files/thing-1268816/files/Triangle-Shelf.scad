////////////////////////////////////////////////////////////////////////////
// Manhattan Pegboard Collection v1 : Triangle Shelf
// designed in NYC by Matt Manhattan (mattmanhattan.com)
////////////////////////////////////////////////////////////////////////////

width = 150; // This is the width of the shelf
depth = 150; // This is the depth of the shelf
height = 40; // This is the width of the shelf
pegs = 5; // span between pegs [0 = centered (one peg // 1 = 2 pegs // 2 = 3 pegs // 3 = 4 pegs]

//////////////////////////////////////////////////////////////////
// Triangle Shelf
//////////////////////////////////////////////////////////////////

polyhedron
    (points = [
	       [0, 0, height],          // point 0
           [0, width, height],      // point 1
           [0, width, 0],           // point 2
           [0, 0, 0],               // point 3
           [depth, 0, height],      // point 4
           [depth, width, height],  // point 5
	       ], 
     faces = [
           [0,1,5],[0,5,4],          // top of triangle
           [0,4,3],                  // triangle on x-axis
           [5,1,2],                  // opposite triangle
           [1,0,2],[0,3,2],          // rear of triangle on y-axis
           [3,4,2],[5,2,4],          // angle of triangle
		  ]
     );
     
//////////////////////////////////////////////////////////////////
// Pegboard Pegs
//////////////////////////////////////////////////////////////////   

pegCenterToCenterDistance = 25.4; 	    // 1 inch spacing
pegDiameter = 6.35; 					// 1/4 inch peg holes
pegLength = 12;                         // length of the pegs
midpointX = width/2;
midpointY = height/2;

// leave this alone - it alters the center point of the model
centerequals = false; 
///////////////////

// PEG 1
// this rotates the peg 90 degrees
rotate([0,-90,0])
    {    
    translate([(midpointY+((pegCenterToCenterDistance/2))),(midpointX+((pegCenterToCenterDistance/2)*pegs)),0])    // moves PEG 1 to its position
        { 
        cylinder(h=pegLength, r=(pegDiameter/2), center=centerequals);  // PEG 1 (top left)
        }
        
    translate([(midpointY+((pegCenterToCenterDistance/2))),(midpointX-((pegCenterToCenterDistance/2)*pegs)),0])    // moves PEG 2 to its position
        {    
        cylinder(h=pegLength, r=(pegDiameter/2), center=centerequals); // PEG 2 (top right)
        }
        
    translate([(midpointY-((pegCenterToCenterDistance/2))),(midpointX+((pegCenterToCenterDistance/2)*pegs)),0])    // moves PEG 3 to its position
        { 
        cylinder(h=pegLength, r=(pegDiameter/2), center=centerequals);  // PEG 3 (bottom left)
        }
        
    translate([(midpointY-((pegCenterToCenterDistance/2))),(midpointX-((pegCenterToCenterDistance/2)*pegs)),0])    // moves PEG 4 to its position
        {    
        cylinder(h=pegLength, r=(pegDiameter/2), center=centerequals); // PEG 4 (bottom right)
        }
    }
 