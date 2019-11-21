/*[EndCap generator]*/

// Length of the inner insertion:
InnerLength = 15;
// Max X inner diameter for the rings:
InnerX = 20;
// Max Y inner diameter for the rings:
InnerY = 10;
// Ratio for the smaller ring dimensions (1 or less, 0.94 typical.):
RatioRingsInner=0.95;
// Number of rings:
Rings=4;
// Rings Ratio (1 or less, 0.98 typical.):
RingsRatio=1;
// CAP outer X:
CAPOuterX=24;
// CAP outer Y:
CAPOuterY=14;
// CAP height:
CAPHeight=3;
// Inner hole X dimension:
InnerHoleX=10;
// Inner hole Y dimension:
InnerHoleY=5;
// Inner hole height:
InnerHoleHeight=15;

module MakeRCap()
{
    translate([0,0,InnerLength+CAPHeight])
    rotate([180,0,0])
    difference()
    {
        union()
        {
            // Rings
            for(i=[0:Rings-1])
            {
                Ratio=1-((1-RingsRatio)*(Rings-i));
                RingHeight=InnerLength/Rings;
                translate([0,0,(i+1)*RingHeight])
                rotate([180,0,0])
                linear_extrude(height = RingHeight, scale=RatioRingsInner)
                    square([Ratio*InnerX,Ratio*InnerY],center=true);
            }
            // Cap
            translate([0,0,InnerLength+CAPHeight/2]) cube([CAPOuterX,CAPOuterY,CAPHeight],center=true);
        }
    // Hole
    translate([-InnerHoleX/2,-InnerHoleY/2,0]) cube([InnerHoleX,InnerHoleY, InnerHoleHeight]);
    }
}

// Main
MakeRCap();
