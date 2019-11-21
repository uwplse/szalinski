// NACA4 airfoil based prop generator for use with ducts.

use <naca4_airfoil.scad>;  // https://www.thingiverse.com/thing:2536887

/*
common prop size and pitch values in mm:

    2   in = 50.8  mm
    3   in = 76.2  mm
    3.8 in = 96.52 mm
    4   in = 101.6 mm
    4.5 in = 114.3 mm
    5   in = 127.0 mm
    5.5 in = 139.7 mm
    6   in = 152.4 mm
*/


// Parameters


// The diameter of the propeller in millimeters
propDiameter=127;
propHeight=8;

// changes the angle of the blades. Pitch is the distance the prop would move forward with one complete rotation.
propPitch=101.6;

// the target thickness for the thickest point of the airfoil. Not followed precisely.
propThickness=2;

// the amount of curve in the blades (passed into NACA4 algorithm)
propNacaCamber=0.04;

// the position of max curve in the blades (passed into NACA4 algorithm)
propNacaMaxCamberPosition=0.4;

// number of blades
propBladeCount=11;

// the diameter of the hole in the middle of the prop.
propShaftDiameter=5;

// the diameter of the hub, where a nut might attach this to a motor.
propHubDiameter=15;

// used to create the curve on the outside of the hub
propHubMinRadius=2;


// quality parameters


// number of segments to render the blades in, smaller is smoother but slower.
propSegmentSize=2;

// the number of samples in the airfoil profiles, bigger is smoother but slower.
propNacaSampleCount=41;


// recommended settings for quick preview:
    propSegmentSize=4;
    propNacaSampleCount=21;

// recommended settings for high resolution render:
    //propSegmentSize=0.5;
    //propNacaSampleCount=161;


Pi = 3.14159265359;
function pitchAngleAtRadius(radius) = atan(propPitch/(2*Pi*radius));
function chordLengthForAngleAndHeight(angle, height) = height/sin(angle);


module prop_blade() {
    propRadius=propDiameter/2 + propSegmentSize;
    segmentCount=round(propRadius/propSegmentSize);
    segments=[for(i=[0:1:segmentCount-1])
        let(
            position=i/(segmentCount-1),
            radius=affineTransform(0, 1, 0, propRadius, position),
            angle=pitchAngleAtRadius(radius),
            chord=chordLengthForAngleAndHeight(angle, propHeight),
            naca=[propNacaCamber, propNacaMaxCamberPosition, propThickness/chord]
        )
        airfoilLoftSegment(position=position, naca=naca, chord=chord, angle=-angle)
    ];
    rotate([0,90,0])
    rotate([0,0,90])
    airfoilLoft(
        segments=segments,
        span=propRadius,
        step=propSegmentSize,
        nacaSampleCount=propNacaSampleCount
    );
}

module prop_hub() {
    translate([0,0,-propHeight/2])
    rotate_extrude($fn=180)
    union() {
        translate([0,-propHeight/2])
        square([propHubDiameter/2-propHubMinRadius,propHeight]);
        translate([propHubDiameter/2-propHubMinRadius,0])
        scale([propHubMinRadius/propHeight,1])
        circle(d=propHeight, $fn=180);
    }
}

module prop() {
    intersection() {
        union() {
            prop_hub();
            bladeAngleOffset = 360/propBladeCount;
            for (i=[1:1:propBladeCount]) {
                rotate([0,0,i*bladeAngleOffset])
                prop_blade();
            }
        }
        difference() {
            cylinder(d=propDiameter,h=propHeight*4,center=true,$fn=360);
            cylinder(d=propShaftDiameter,h=propHeight*5,center=true,$fn=80);
            cylinder(d=propHubDiameter-propHubMinRadius*2,h=propHeight*2,$fn=80);
            translate([0,0,-propHeight*3])
            cylinder(d=propHubDiameter-propHubMinRadius*2,h=propHeight*2,$fn=80);
        }
    }
}

color("orange")
prop();
