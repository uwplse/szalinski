////////////////////////////////////////////////////////////////////////////
// Manhattan Pegboard Collection v1 : 2 Peg Bin
// designed in NYC by Matt Manhattan (mattmanhattan.com)
////////////////////////////////////////////////////////////////////////////

// These parameters create the INTERIOR size of your bin (in mm)

width = 40;
depth = 40;
height = 32;
thickness = 2; // this is the thickness of the walls (in mm)
pegs = 1; // span between pegs [0 = centered (one peg // 1 = 2 pegs // 2 = 3 pegs // 3 = 4 pegs]

//////////////////////////////////////////////////////////////////
// Pegboard Bin
//////////////////////////////////////////////////////////////////

// This code generates the rectangular shape of your bin

    difference()
    {
        
        // this is the exterior shape
        cube([width+(thickness*2),depth+(thickness*2),height], centerequals);
        
        // this is the interior shape which we are removing
        translate([thickness,thickness,0])
        {
            cube([width,depth,height], centerequals);
        }
    }

// This code generates the base of the bin
// if you comment it out you will remove the base of your bin which can be useful for tools
    
   cube([width+(thickness*2),depth+(thickness*2),thickness], centerequals);
    
//////////////////////////////////////////////////////////////////
// Pegboard Pegs
//////////////////////////////////////////////////////////////////
    
pegCenterToCenterDistance = 25.4; 	    // 1 inch spacing
pegDiameter = 6.35; 					// 1/4 inch peg holes
pegLength = 12;
midpoint = ((2*thickness) + width)/2;
    
// leave this alone - it alters the center point of the model
centerequals = false; 
///////////////////

difference(){
    
// PEG 1
// this rotates the peg 90 degrees
rotate([90,0,0])
    { 
    // this moves the peg    
    translate([(midpoint - ((pegCenterToCenterDistance/2)*pegs)),(height/2),0])
        {    
        cylinder(h=pegLength, r=(pegDiameter/2), center=centerequals);
        }
    }

}

difference(){
    
// PEG 2
// this rotates the peg 90 degrees
rotate([90,0,0])
    { 
    // this moves the peg    
    translate([(midpoint + ((pegCenterToCenterDistance/2)*pegs)),(height/2),0])
        {    
        cylinder(h=pegLength, r=(pegDiameter/2), center=centerequals);
        }
    }
//
}