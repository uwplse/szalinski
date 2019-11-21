// The height of the foot
height = 7;
// The diameter of the foot
diameter = 16;
// The radius of the rounding
roundRadius = 3;

// The diameter of the screw hole
holeDiameter = 6;
// The diameter of the screw
screwDiameter = 3.8;
// The thickness of the base, which the screw is screwed on
holeBaseThickness = 2;


// The number of faces used (detail)
numFaces = 32; // [16,32,64,128]

$fn = numFaces;

difference()
{
    cylinder(h=height, r=diameter/2);
    translate([0,0,holeBaseThickness])
    cylinder(h=height-holeBaseThickness+1, r = holeDiameter/2);
    translate([0,0,-1])
    cylinder(h=holeBaseThickness+2, r = screwDiameter/2);
    roundNegative();
}

module roundNegative()
{
    translate([0,0,height - roundRadius])
    rotate_extrude()
    {
        translate([diameter/2-roundRadius,0,0])
        difference()
        {
            square(roundRadius+1);
            circle(roundRadius);
        }
    }
}