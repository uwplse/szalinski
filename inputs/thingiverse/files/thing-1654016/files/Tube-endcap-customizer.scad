/*[EndCap generator]*/

// Max inner diameter for the rings:
InnerMAXDiameter = 20;
// Min inner diameter for the rings:
InnerMINDiameter = 18;
// Number of rings:
Rings=6;
// Ring height:
RingHeight=3;
// Rings Ratio (1..0.93):
RingsRatio=1;
// CAP outer diameter:
CAPOuterDiameter=24;
// CAP height:
CAPHeight=10;
// Facets:
Facets=100; // [4:100]
// Fillet radius:
Fillet=6;
// Inner hole diameter:
InnerHoleDiameter=14;
// Inner hole height:
InnerHoleHeight=18;


module MakeCap()
{
    difference()
    {
        union()
        {
            // Rings
            for(i=[0:Rings-1])
            {
                Ratio=1-((1-RingsRatio)*(Rings-i));
                translate([0,0,i*RingHeight])
                    cylinder(h = RingHeight, 
                        r1 = Ratio*InnerMINDiameter/2, 
                        r2 = Ratio*InnerMAXDiameter/2, 
                        center = false,$fn=Facets);
            }
            // Cap
            translate([0,0,RingHeight*Rings])
                cylinder(h = CAPHeight-Fillet, 
                    r = CAPOuterDiameter/2, 
                    center = false,$fn=Facets);
            translate([0,0,RingHeight*Rings+CAPHeight-Fillet])
                cylinder(h = Fillet, 
                    r = CAPOuterDiameter/2-Fillet, 
                    center = false,$fn=Facets);
            rotate([0,0,360/2*Facets])
            translate([0, 0, RingHeight*Rings+CAPHeight-Fillet])
                rotate_extrude(convexity = 10,$fn = Facets)
                    translate([CAPOuterDiameter/2-Fillet, 0, 0])
                        intersection()
                            {
                            circle(r = Fillet, $fn = Facets);    
                            square(Fillet);
                            }
        }
    // Hole
    cylinder(h = InnerHoleHeight, 
                r = InnerHoleDiameter/2, 
                center = false,$fn=Facets);
    
    }
}

// Main
MakeCap();
