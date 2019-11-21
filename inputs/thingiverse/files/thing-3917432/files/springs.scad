// Customizable spring
// By Magonegro JUL-2016
// This constructs a spring based on a series of washers
// Print it horizontaly with buildplate support only.
// Remember that under compression this spring will increase its diameter.

// Outer radius of the spring
ROUT=10;
// Inner radius
RIN=7;
// Height
HEIGHT=40;
// Washer's radius. Keep this around 2XROUT. You can change this to get different elastic properties (values from 1.5X to 3X make sense, defaults to 2X)
RWASHER=20;
// Washer's thickness
HEIGHTWASHER=1.2;
// Height of the spring base. 0 for nothing
BASECYLINDER=3;
// Resolution (min 60)
FACETS=60;

// [hidden]
// Height of the washer
A=RWASHER-sin(acos(ROUT/(RWASHER-HEIGHTWASHER)))*((RWASHER-HEIGHTWASHER));

NUMWASHERS=(HEIGHT/(A-HEIGHTWASHER));

module washer()
{
    intersection()
    {
    translate([0,0,-RWASHER+(A/2)])
    rotate([90,0,0])
        difference()
        {
        cylinder(r=RWASHER,h=ROUT*2.1,center=true,$fn=FACETS);
        cylinder(r=RWASHER-HEIGHTWASHER,h=ROUT*2.1,center=true,$fn=FACETS);
        }
    difference()
        {
        cylinder(r=ROUT,h=2*A,center=true,$fn=FACETS);
        cylinder(r=RIN,h=2*A,center=true,$fn=FACETS);
        }
    }
}

module makebase()
{
    translate([0,0,BASECYLINDER/2])
        difference()
            {
            cylinder(r=ROUT,h=BASECYLINDER,center=true,$fn=FACETS);
            cylinder(r=RIN,h=BASECYLINDER,center=true,$fn=FACETS);
            }
            
    translate([0,0,HEIGHT-BASECYLINDER/2])
        difference()
            {
            cylinder(r=ROUT,h=BASECYLINDER,center=true,$fn=FACETS);
            cylinder(r=RIN,h=BASECYLINDER,center=true,$fn=FACETS);
            }
}

render() difference()
{
    union()
    {
    for(n=[0:1:NUMWASHERS])
        translate([0,0,(A/2)+(A-HEIGHTWASHER)*n])
            rotate([180*n,0,0])
                render() washer();
        if(BASECYLINDER!=0)
            {
            render() makebase();
            };
    }
    // Remove top excess due to rounding
    translate([0,0,HEIGHT]) cylinder(h=2*A,r=ROUT*1.2);
}
