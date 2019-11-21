// Ice Wheel for 1/10 Traxxas Rustler (maybe others) - Rear

// CUSTOMIZER VARIABLES

// Diameter of the wheel without the claws:
coreWheelDia=110; // [80:150]

// Width of the wheel (needs to be larger than hubClearanceDepth + hexInsertDepth + spindleShaftHoleThickness):
coreWheelWidth=50; // [30:100]

// How much the edge of the wheel is "rounded off"
tireEdgeRoundOffRadius=5; // [1:10]

// The size of the opening on the inside / back-side of the wheel (needs to be smaller than coreWheelDia):
hubClearanceInnerDia=80; // [60:140]

// The depth of the opening on the inside/back-side of the wheel:
hubClearanceDepth=25; // [15:35]

// Measurement from point to point of the hex insertion recess:
hexInsertDia=14.5; // [10:20]

// Depth of the hex insertion recess:
hexInsertDepth=4; // [3:6]

// Diameter of the axle-shaft hole:
spindleShaftDia=5; // [3:8]

// Thickness of the wheel around the axle-shaft hole:
spindleShaftHoleThickness=4; // [3:6]

// Diameter of the flat area (where the axle-nut tightens down):
nutFlatDia=12; // [10:20]

// How many paddles:
numberOfPaddles=8; // [8:20]

// How far in the paddles are from the edge of the wheel:
paddleInset=6; // [0:15]

// How tall the paddle is up from the wheel surface:
paddleLength=15; // [1:25]

// How thick the "blade" of the paddle is:
paddleThickness=3; // [2:6]

// How far over each paddle tilts (degrees):
paddleAngle=-20; // [-60:60]

// How many spokes (or spoke slots... same thing):
numberOfSpokes=5; // [4,5,6]

// How much the corners of the spoke-slots are "rounded off":
spokeCornerRoundnessDia=5; // [1:10]

// How much solid space to reserve in the center of the wheel:
spokeHubDia=30; // [20:80]

// How much solid space to reserve outside the spoke-slots:
spokeSlotInset=3; // [0:20]

// How far into the wheel the base of the paddle sticks (compensates, if necessary, for higher paddle tilt or thickness, or smaller-wheel curve, to make a solid, connected object):
paddleOverlap=3; // [2:6]

// TODO: Calculate paddle overlap instead of requiring it to be manually set.


//CUSTOMIZER VARIABLES END

overlap=0.01*1;

$fn=50*1;

outerConeDepth=coreWheelWidth
        -hubClearanceDepth
        -hexInsertDepth
        -spindleShaftHoleThickness;

union() {
    difference() {
        translate([0,0,tireEdgeRoundOffRadius]) {
            minkowski() {
                cylinder(d=coreWheelDia-tireEdgeRoundOffRadius*2,
                    h=coreWheelWidth-tireEdgeRoundOffRadius*2);
                sphere(r=tireEdgeRoundOffRadius);
            }
        }
        translate([0,0,coreWheelWidth-hubClearanceDepth])
            cylinder(d=hubClearanceInnerDia, 
                h=hubClearanceDepth+overlap);
        translate([0,0,
                coreWheelWidth-hubClearanceDepth-hexInsertDepth])
            cylinder(d=hexInsertDia, 
                h=hexInsertDepth+overlap, $fn=6);
        translate([0,0,-overlap])
            cylinder(d=spindleShaftDia, h=coreWheelWidth+overlap*2);
        translate([0,0,-overlap])
            cylinder(d1=hubClearanceInnerDia, d2=nutFlatDia, 
            h=outerConeDepth+overlap);
        spokeCutouts();
    }
    // Paddles
    paddleSeparationAngle=360/numberOfPaddles;
    for (s=[1:numberOfPaddles]) {
        rotate([0,0,paddleSeparationAngle*s])
        translate([coreWheelDia/2-overlap-paddleOverlap, 0, paddleInset])
            rotate([0,0,paddleAngle])
                cube([paddleLength+paddleOverlap,
                    paddleThickness,coreWheelWidth-paddleInset*2]);
    }
    
}

module spokeCutouts() {
    // Spokes
    // Note: Spoke material is same size as spoke opening
    spokeHalfAngle=360/numberOfSpokes/4;
    for (s=[0:numberOfSpokes-1]) {
        rotate([0,0,s*(spokeHalfAngle*4)])
        hull() {
            // inner
            rotate([0,0,-spokeHalfAngle])
                translate([(spokeHubDia+spokeCornerRoundnessDia)/2
                        ,0,0])
                    cylinder(d=spokeCornerRoundnessDia, 
                        h=coreWheelWidth);
            rotate([0,0,spokeHalfAngle])
                translate([(spokeHubDia+spokeCornerRoundnessDia)/2
                        ,0,0])
                    cylinder(d=spokeCornerRoundnessDia, 
                        h=coreWheelWidth);
            // outer
            rotate([0,0,-spokeHalfAngle])
                translate([(hubClearanceInnerDia-
                        spokeCornerRoundnessDia)/2-spokeSlotInset,
                                0,0])
                    cylinder(d=spokeCornerRoundnessDia, 
                        h=coreWheelWidth);
            rotate([0,0,spokeHalfAngle])
                translate([(hubClearanceInnerDia
                        -spokeCornerRoundnessDia)/2-spokeSlotInset,
                            0,0])
                    cylinder(d=spokeCornerRoundnessDia, 
                        h=coreWheelWidth);
        }
    }
}