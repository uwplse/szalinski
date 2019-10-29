
//parametric motor mount spacer

hole1Spacing=16;
hole2Spacing=19;
holeDiameter=3;

//width of cross 
mountWidth=8;

//strength around mounting holes in mm
minimumStrength=3;

//Shaft Hole
shaftDiameter=7;

//lenght of hole required for motor shaft at base of motor.
shaftDepth=5;

mountHeight=24;

difference()
{
union()
{
//cylinder right
translate([hole1Spacing/2,0,mountHeight/2])
cylinder(h=mountHeight,d=holeDiameter+minimumStrength*2,center=true);

//cylinder left
translate([-hole1Spacing/2,0,mountHeight/2])
cylinder(h=mountHeight,d=holeDiameter+minimumStrength*2,center=true);

//cylinder top
translate([0,hole2Spacing/2,mountHeight/2])
cylinder(h=mountHeight,d=holeDiameter+minimumStrength*2,center=true);

//cylinder bottom
translate([0,-hole2Spacing/2,mountHeight/2])
cylinder(h=mountHeight,d=holeDiameter+minimumStrength*2,center=true);


translate([0,0,mountHeight/2])
cube([hole1Spacing,mountWidth,mountHeight],center=true);

translate([0,0,mountHeight/2])
cube([mountWidth,hole2Spacing,mountHeight],center=true);
}

{
//hole1 right
translate([hole1Spacing/2,0,mountHeight/2])
cylinder(h=mountHeight+tolerance,d=holeDiameter,center=true);

//hole1 left
translate([-hole1Spacing/2,0,mountHeight/2])
cylinder(h=mountHeight+tolerance,d=holeDiameter,center=true);

//hole2 top
translate([0,hole2Spacing/2,mountHeight/2])
cylinder(h=mountHeight+tolerance,d=holeDiameter,center=true);

//hole2 bottom
translate([0,-hole2Spacing/2,mountHeight/2])
cylinder(h=mountHeight+tolerance,d=holeDiameter,center=true);

//shaft hole
translate([0,0,shaftDepth/2])
cylinder(h=shaftDepth+tolerance,d=shaftDiameter,center=true);

}
}

/* [Hidden] */
$fn=50;
tolerance=.01;