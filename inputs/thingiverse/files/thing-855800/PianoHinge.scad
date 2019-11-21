// (mm) Making this bigger will increase the hinge stength.
rodDiameter    = 1.7;  
//  (mm) This needs to be big enough that the rod won't fuse with the hinge tube.
HorizontalGap  = 0.8; 
// (mm) Gap between segments, should be 2 or 3 times the layer height
VerticalGap    = 0.6;  
// (mm) Total height of the hinge
hingeHeight    = 60;  
// Number of segments, should be at least 3
numberOfSegments    = 4;   
// (mm)
tubeThickness  = 0.5; 
// (mm) 
hingeWidth     = 10;
// (mm) Gap between tube and rectangular flap
flangeWidth    = 4;
// (mm) 
hingeThickness = 1.5;

numberOfFacetsInCylinders = 20;

$fn = numberOfFacetsInCylinders;

segmentHeight = hingeHeight/numberOfSegments;
holeRad = rodDiameter/2+HorizontalGap;
tubeRad = holeRad+tubeThickness;

// Hinge body
translate([tubeRad+holeRad,0,0])
cube([hingeWidth,hingeThickness,hingeHeight]);
translate([0,tubeRad+holeRad,0])
cube([hingeThickness,hingeWidth,hingeHeight]);

difference()
{
    // Tube sections and the parts connecting them to the main hinge body
    union()
    {
        for(i = [0:numberOfSegments-1])
        {
            translate([0,0,segmentHeight*i])
            cylinder(r=tubeRad,h=segmentHeight-VerticalGap);
            if(i%2==1)
            {
                translate([holeRad,0,segmentHeight*i])
                cube([flangeWidth,hingeThickness,segmentHeight-VerticalGap]);
            }
            else
            {
                translate([0,holeRad,segmentHeight*i])
                cube([hingeThickness,flangeWidth,segmentHeight-VerticalGap]);
            }               
        }
    }
    translate([0,0,2*VerticalGap])
    cylinder(r=holeRad,h=hingeHeight-4*VerticalGap);
}

// Rod
cylinder(r=rodDiameter/2,h=hingeHeight-2*VerticalGap);

// Close off top 
translate([0,0,hingeHeight-VerticalGap])
cylinder(r=tubeRad,h=VerticalGap);
