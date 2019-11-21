$fn=100*1;              // Smooth cylinders
// Outer radius of fipple
OuterRadius = 8.5;      
// Inner radius of fipple
InnerRadius = 7;        
// Overall height of mouthpiece
TotalHeight = 42;       
// Height to bottom of blowhole
BodyHeight = 25;        
// Radius of cutout for lower lip relief
LipRadius = 12;         
// Depth of air hole
AirDepth = 1.9;         
// Width of air hole
AirWidth = 7.9;         
// Height of sound hole
SoundHoleHeight = 15;   
// Height of blade in sound hole
BladeHeight = 12;       
// Depth of blade as a fraction of AirDepth
BladeDepth = .5;        


// The outer edge of the pipe
module OuterCylinder() {
    translate(0, 0, TotalHeight / 2)
        cylinder(r = OuterRadius, h = TotalHeight);
}

// Overall Shell of Mouthpiece
module MouthpieceShell()
{
    difference() {
        // Outer cylinder
        OuterCylinder();
        // Inner cylinder: only goes partway up
		cylinder(r = InnerRadius, h = BodyHeight);
		// cutout for lower lip
		rotate(90, [1,0,0])
            translate([-1 * TotalHeight / 4, TotalHeight, -1 * OuterRadius])
            cylinder(r = LipRadius, OuterRadius * 2);
    }
}

module AirwayCube(width = AirWidth, height = TotalHeight, extra=true)
{
    offset = 0;
    if (extra == true) { offset = 0.5; }

    translate([InnerRadius - AirDepth, -1*width/2, TotalHeight - height - offset])
        cube([OuterRadius,width,height + 2*offset]);
}

// The part you blow through
module BlowHole()
{
    intersection() {
        cylinder(r = InnerRadius, h = TotalHeight);
        AirwayCube(width = AirWidth, height = TotalHeight - BodyHeight + SoundHoleHeight - BladeHeight);
    }
}

module BladeInsert()
{
    intersection() {
        OuterCylinder();
        AirwayCube(width=OuterRadius*2, height=TotalHeight-BodyHeight + SoundHoleHeight, extra = false);
    }
}

// Kind of an ugly hack for making ramps.
module Ramp(inside = false, CheckSlope = true)
{
    X = InnerRadius - AirDepth*BladeDepth;
    Y = AirWidth/2;
    Z = BodyHeight - (SoundHoleHeight - BladeHeight);
    slope = -BladeHeight / (AirDepth * BladeDepth);
    
    if (inside == true)
    {
        translate([X,0,Z])
            rotate(180, [0,0,1])
            translate([-X,0,-Z])
            RampCube(X=X,Y=Y,Z=Z,slope=slope);
    }
    else
    {
        // Double-check the slope
        slope = max( slope, -Z/((AirDepth * BladeDepth) + (OuterRadius-InnerRadius)));
        RampCube(X=X,Y=Y,Z=Z,slope=slope);
    }
}

module RampCube(X,Y,Z,slope)
{
    polyhedron(
        points = [[X,Y,Z],[X,-Y,Z],[X-Z/slope,Y,0],[X-Z/slope,-Y,0],[X+OuterRadius,Y,Z],[X+OuterRadius,-Y,Z],[X-Z/slope+OuterRadius,Y,0],[X-Z/slope+OuterRadius,-Y,0]],
        faces = [[0,1,3,2],[0,2,6,4],[1,5,7,3],[5,4,6,7],[1,0,4,5],[2,3,7,6]]);
}

module BladeHoleTop()
{
    
    union() {
        translate([0,0, - (TotalHeight-BodyHeight)])
            AirwayCube(height = SoundHoleHeight - BladeHeight, extra = false);
        Ramp();
        Ramp(inside = true);
    }
}

difference() {
    union() {
        MouthpieceShell();
        BladeInsert();
    }
    BlowHole();
    BladeHoleTop();
}
