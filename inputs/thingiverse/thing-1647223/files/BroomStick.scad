// Broom Handle Screw End Cap
// Modification of Broom Handle Screw End Plug by Ed Nisley KE4ZNU March 2013

// Extrusion parameters must match reality!
// Print with +1 shells and 3 solid layers

ThreadThick = 0.25;
ThreadWidth = 2.0 * ThreadThick;

HoleWindage = 0.2;

function IntegerMultiple(Size,Unit) = Unit * ceil(Size / Unit);

Protrusion = 0.1;                       // make holes end cleanly

//----------------------
// Dimensions

PI = 3.14159265358979;

WallThickness=2.5;            // Desired Wall Thickness

PostOD = 24;              // post inside metal handle
PostLength = 25.0;

PitchDia = 15.5;            // thread center diameter
ScrewLength = 20.0;

ThreadFormOD = 2.5;         // diameter of thread form
ThreadPitch = 5.0;

OALength = PostLength + ScrewLength; // excludes bolt head extension

$fn=8*4;

echo("Pitch dia: ",PitchDia);
echo("Root dia: ",PitchDia - ThreadFormOD);
echo("Crest dia: ",PitchDia + ThreadFormOD);

//----------------------
// Useful routines

module Cyl_Thread(pitch,length,pitchdia,cyl_radius,resolution=32) {

Cyl_Adjust = 1.25;                      // force overlap

    Turns = length/pitch;
    Slices = Turns*resolution;
    RotIncr = 1/resolution;
    PitchRad = pitchdia/2;
    ZIncr = length/Slices;
    helixangle = atan(pitch/(PI*pitchdia));
    cyl_len = Cyl_Adjust*(PI*pitchdia)/resolution;

    union() {
        for (i = [0:Slices-1]) {
            translate([PitchRad*cos(360*i/resolution),PitchRad*sin(360*i/resolution),i*ZIncr])
                rotate([90+helixangle,0,360*i/resolution])
                    cylinder(r=cyl_radius,h=cyl_len,center=true,$fn=12);
        }
    }
}

module PolyCyl(Dia,Height,ForceSides=0) {                       // based on nophead's polyholes

  Sides = (ForceSides != 0) ? ForceSides : (ceil(Dia) + 2);

  FixDia = Dia / cos(180/Sides);

  cylinder(r=(FixDia + HoleWindage)/2,
           h=Height,
           $fn=Sides);
}


//-------------------
// Build it...

    union() {
        cylinder(r=PitchDia/2,h=ScrewLength);
        translate([0,0,0])
            Cyl_Thread(ThreadPitch,(ScrewLength - ThreadFormOD/2),PitchDia,ThreadFormOD/2);
    }

difference(){
    translate([0,0,-PostLength-WallThickness])cylinder(d=PostOD+WallThickness,h=PostLength+WallThickness);
    translate([0,0,-PostLength-WallThickness*2])cylinder(d=PostOD,h=PostLength+WallThickness);
}