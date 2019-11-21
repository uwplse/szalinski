// Title: SmallMagnetClip
// Author: http://www.thingiverse.com/Jinja
// Date: 2018-05-12

/////////// START OF PARAMETERS /////////////////

MagnetDiam = 4.8;           
MagnetThickness = 2.2;      
MinThickness = 0.7;         //[0.5:0.05:1.0]
Tolerance = 5;              //[0:10]
ClipLength = 20;            
FulcrumPosition = 0.5;      //[0.0:0.1:1.0]
Angle = 30;                 //[10:5:40]
Model = "clip"; // [clip:The magnet clip,test:The tolerance hole test]

/////////// END OF PARAMETERS /////////////////

$fs=0.3*1;
$fa=6*1; //smooth
//$fa=20; //rough

tolScale = 1.0/20.0;
tolOffset = -0.1 * 1;
gap = ((Tolerance*tolScale)+tolOffset);
rad = (MagnetDiam/2);
clipRad = rad+2;
clipInnerLength = ClipLength-2*clipRad;
holeRad = rad + gap;
magHoleThickness = MagnetThickness + 2*gap;
hingeRad = 1*1;
hingeHoleRad = hingeRad+gap;
ClipThickness = magHoleThickness + MinThickness * 2;
lidFrameHeight = 8*1;

if(Model=="test")
{
    translate([0,ClipThickness*3+3,0]) TestHoles();
}
else
{
    ClipPart1();
    translate([0,ClipThickness+3,0]) ClipPart2();
}

module ClipPart1()
{
    offset1 = clipInnerLength*FulcrumPosition;
    difference()
    {
        SimpleClipPart2b();
        translate([offset1,0,-clipRad-1])
        cylinder(clipRad*2+2,hingeRad,hingeRad);
    }
}

module ClipPart2()
{
    angle = Angle;
    offset1 = clipInnerLength*FulcrumPosition;
    offset2 = 0.0;
    difference()
    {
        SimpleClipPart2();
        translate([ClipLength*0.5+offset1+offset2,0,0])
        cube([ClipLength,ClipLength,ClipLength],true);
    }
    translate([offset1,-ClipThickness,0])
    rotate([0,0,angle])
    translate([-offset1,ClipThickness,0])
    difference()
    {
        SimpleClipPart2();
        translate([-ClipLength*0.5+offset1-offset2,0,0])
        cube([ClipLength,ClipLength,ClipLength],true);
    }
    translate([offset1,-ClipThickness,-clipRad])
    cylinder(clipRad*2,hingeRad,hingeRad);
}

module SimpleClipPart2()
{
    
    difference()
    {
        rotate([90,0,0])
        hull()
        {
            cylinder(ClipThickness, clipRad,clipRad);
            translate([clipInnerLength,0,0])
            cylinder(ClipThickness, clipRad,clipRad);
        }
        translate([0,-magHoleThickness*0.5 - MinThickness,-1])
        cube([holeRad*2,magHoleThickness,clipRad*2+3], true);
    }
}

module SimpleClipPart2b()
{
    
    difference()
    {
        rotate([90,0,0])
        hull()
        {
            cylinder(ClipThickness, clipRad,clipRad);
            translate([clipInnerLength,0,0])
            cylinder(ClipThickness, clipRad,clipRad);
        }
        translate([0,-magHoleThickness*0.5 - MinThickness,-1])
        cube([holeRad*2,magHoleThickness,clipRad*2+3], true);
    }
}

module TestHoles()
{
    biggap = ((10*tolScale)+tolOffset);
    outLength = MagnetDiam + 3 + biggap;
    difference()
    {
        union()
        {
            for(tol=[0:1:10])
            {
                gap = ((tol*tolScale)+tolOffset);
                holeThick = MagnetThickness + 2*gap;
                outThick = holeThick + MinThickness * 2;
                holeLength = MagnetDiam + 2*gap;
                hingeHoleRad = hingeRad+gap;

                translate([tol*outLength,0,0])
                cube([outLength,outThick,clipRad*2]);
            }
        }
        
        for(tol=[0:1:10])
        {
            gap = ((tol*tolScale)+tolOffset);
            holeThick = MagnetThickness + 2*gap;
            outThick = holeThick + MinThickness * 2;
            holeLength = MagnetDiam + 2*gap;
            hingeHoleRad = hingeRad+gap;

            translate([1.5,0,0])
            translate([tol*outLength,MinThickness,-1])
            cube([holeLength, holeThick, clipRad*2+2]);
        }
    }
}

module HHole(depth, rad)
{
    b = 0.5;
    bezel = min(b, depth);
    translate([0,0,-0.01])
    cylinder(0.015, rad+bezel, rad+bezel);
    cylinder(bezel, rad+bezel, rad);
    if(depth>b)
    {
        translate([0,0,bezel-0.01])
        cylinder(depth-bezel, rad, rad);
    }
}

module VHole(depth, rad)
{
    rotate([90,0,0])
    cylinder(depth, rad, rad);
    rotate([0,-45,0])
    translate([0,-depth,0])
    cube([rad, depth, rad]);
}


