// Ice Wheel for 1/10 Traxxas Rustler (maybe others) - Rear

//CUSTOMIZER VARIABLES

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
hexInsertDia=15; // [10:20]

// Depth of the hex insertion recess:
hexInsertDepth=4; // [3:6]

// Diameter of the axle-shaft hole:
spindleShaftDia=5; // [3:8]

// Thickness of the wheel around the axle-shaft hole:
spindleShaftHoleThickness=4; // [3:6]

// Diameter of the flat area (where the axle-nut tightens down):
nutFlatDia=12; // [10:20]

// How tall the claws are from the wheel surface:
clawBaseDia=10; // [4:14]

// How long the claws slope into the wheel surface:
clawLength=15; // [8:18]

// How many claws go in each row:
clawsPerRow=15; // [6:40]

// How many rows of claws:
clawRows=4; // [2:6]

// How many spokes (or spoke slots... same thing):
numberOfSpokes=5; // [4,5,6]

// How much the corners of the spoke-slots are "rounded off":
spokeCornerRoundnessDia=5; // [1:10]

// How much solid space to reserve in the center of the wheel:
spokeHubDia=30; // [20:80]

// How much solid space to reserve outside the spoke-slots:
spokeSlotInset=3; // [0:20]

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
    // Claws
    clawSeparationAngle=360/clawsPerRow;
    clawRowOffset=coreWheelWidth/(clawRows+1);
    for(r=[1:clawRows]) {
        for (s=[1:clawsPerRow]) {
            rotate([0,0,
                clawSeparationAngle*s
                + ((r%2 != 0) ? 0 : clawSeparationAngle/2)])
            translate([coreWheelDia/2-overlap, 0,
                    clawRowOffset*r])
                rotate([0,90,((r%2 !=0) ? -1 : 1)*100])
                    cylinder(d1=clawBaseDia,d2=0,
                        h=clawLength,
                        $fn=4);
        }
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