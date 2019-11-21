/*[Test tube cap generator]*/
// By MagoNegro OCT-2017

// Tube outer diameter:
TubeOuterDiameter=15.6;
// Cap height:
CapHeight=12;
// Cap thickness:
CapThickness=3;
// Facets:
Facets=60; // [4:100]
// Tolerance (Typ. 0.2mm)
Tolerance = 0.2;
// Guard's lenght (Choose yours...):
GuardLength = 30.0;
// Guard's width (Choose yours...):
GuardWidth = 5.0;
// Guard's inner diameter (Typ. same of tube's):
GuardInnerDiameter = 25.0;
// Make guard or not (0..1)
UseGuard=1;

/* [Hidden] */
CapIntR=(TubeOuterDiameter/2)+Tolerance;
CapOutR=CapIntR+CapThickness-Tolerance;

GuardIntR=(GuardInnerDiameter/2)+Tolerance;
GuardOutR=GuardIntR+CapThickness-Tolerance;

module MakeCap()
{
    difference()
    {
        cylinder(h = CapHeight, 
            r = CapOutR, 
            center = false,
            $fn=Facets);
        // Hole
        translate([0,0,CapThickness])
            cylinder(h = CapHeight, 
                r = CapIntR, 
                center = false,
                $fn=Facets);
        translate([0,0,CapHeight-CapOutR+CapThickness/2])
            difference()
            {
            cylinder(h=CapOutR,
                r1=0,
                r2=CapOutR+Tolerance,
                $fn=Facets);
            translate([0,0,-CapThickness])
                cylinder(h=CapOutR,
                    r=CapOutR+Tolerance*2,
                    $fn=Facets);
            }
    }
}

module MakeGuard()
{
    GR=CapOutR+GuardLength;
    difference()
    {
        union()
        {
            translate([-GuardWidth/2,0,0])
                cube([GuardWidth,GR,CapThickness-Tolerance]);
            translate([0,GR+GuardOutR-CapThickness,0])
                    cylinder(h=CapThickness*2,
                        r=GuardOutR,
                        $fn=Facets);
        }
        translate([0,GR+GuardOutR-CapThickness,-CapThickness/2])
                cylinder(h=CapThickness*3,
                    r=GuardIntR,
                    $fn=Facets);
    }
}


// Main
union()
    {
    MakeCap();
    if (UseGuard!=0) MakeGuard();
    }
