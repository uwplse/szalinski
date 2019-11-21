// resolution of curves
$fs = 0.01;

// USER VARIABLES, please change

// centre to centre
standoffSeparation = 31; 
// width of the camera body at the mounting screw point
cameraWidth = 19; 
// outer diameter of the lens / inner diameter of the support
lensInnerDia = 12;
// distance from the mounting screw to the back of the lens ring 
lensOffset = 7;
// how far the camera sits inside the frame, use negative values to sit forwards
cameraInset = 0;
// thickness of material around the lens
lensRingThickness = 2.4; 

// outer diameter minus 0.2mm for a tight fit
standoffOuterDia = 4.8; 
// how far up the standoffs the grips extend vertically
standoffGripHeight = 9;
// amount of material either side of the standoff
standoffGripThickness = 1.6; 
// desired amount of uptilt
cameraAngle = 45; 
// distance from the back of the lens ring to the front
lensHeight = 3.2; 
// how wide the arms are where it meets the lens ring
armHeight = 6; 
// external fillet on the lens ring arms
armRadius = 4;
// size of the screw hole 
screwDia = 2; 
// size of the hole to access the screw
screwDriverDia = 5; 

// CALCULATED VARIABLES, do not change
standoffOuterRad = standoffOuterDia / 2;
standoffGripOuterRad = standoffOuterRad + standoffGripThickness;
standoffGripOuterDia = standoffGripOuterRad * 2;
standoffHeight = standoffGripHeight + 10; // can be any large number, only used for cutting holes
lensInnerRad = lensInnerDia /2;
lensOuterDia = lensInnerDia + (lensRingThickness * 2);
lensOuterRad = lensOuterDia / 2;
LensRingSupportLength = lensOffset + lensHeight; // TODO should be based on the lens offset
LensRingSupportWidth = cameraWidth / 2; // takes us towards the ring, overlap to be cutoff
screwRad = screwDia / 2;
screwDriverRad = screwDriverDia / 2;
screwDriverLength = standoffGripOuterDia * 2; // big enough to stick clear out of the side
standoffGripWidth = (standoffSeparation - cameraWidth) / 2; // width of the standoff blocks to reach the camera
standoffGripInset = cameraInset < 0 ? cameraInset : 0; // how far the standoff grips extend forward

module bevelOuter(outerRadius, length){
    outerDia = outerRadius*2;
    intersection() {
        translate([-outerDia,-outerDia,0]){
            cube([outerDia, outerDia, length]);
        }
        cylinder(length, outerRadius, outerRadius);
    }
}
module bevelInner(innerRadius, length){
    innerDia = innerRadius*2;
    difference() {
        translate([-innerRadius,-innerRadius,0]){
            cube([innerRadius, innerRadius, length]);
        }
        cylinder(length, innerRadius, innerRadius);
    }
}
module bevelBoth(overallSize, joinSize, extrude){
    differenceSize = overallSize-joinSize;
    difference(){
        cube([overallSize, overallSize, extrude]);
        translate([overallSize,overallSize,0]){
            bevelInner(overallSize, extrude);
        }
        translate([overallSize,overallSize,0]){
            bevelOuter(differenceSize, extrude);
        }
    }
}
module lensHolder(){
    difference(){
        union(){
           
            // LHS suport arm
            // moves it so the rotation point is around the screw hole
            translate([lensHeight * 2 + cameraWidth, -LensRingSupportLength, armHeight/2]){
                rotate([0,180,0]){
                    LensRingSupport(LensRingSupportLength, LensRingSupportWidth, armRadius, armHeight, lensHeight);
                }           
            }

            // RHS suport arm
            // moves it so the rotation point is around the screw hole
            translate([0, -LensRingSupportLength, -armHeight/2]){
                LensRingSupport(LensRingSupportLength, LensRingSupportWidth, armRadius, armHeight, lensHeight);           
            }

            // lens ring
            translate([(cameraWidth/2) + lensHeight,-(LensRingSupportLength - lensHeight),0]){
                rotate([90,0,0]){
                    // pipe(lensInnerDia, lensOuterDia, lensHeight);
                    cylinder(lensHeight, lensOuterRad, lensOuterRad);
                }                  
            }
        }

        translate([(cameraWidth/2) + lensHeight,-(LensRingSupportLength - lensHeight),0]){
            // lens hole cutter
            translate([0, 2, 0]){
                rotate([90,0,0]){
                    cylinder(lensHeight + 4, lensInnerRad, lensInnerRad);
                }
            }
        }
    }
}
module LensRingSupport(supportLength, supportWidth, bevelRadius, extrudeHeight, supportThickness){
    extendLength = supportLength - bevelRadius;
    extendWidth = supportWidth - bevelRadius;
    union(){
        // small support to lens ring
        translate([bevelRadius, 0, 0]){
            cube([extendWidth, supportThickness, extrudeHeight]);
        }
        // large support to arm grips
        translate([0, bevelRadius, 0]){
            cube([supportThickness, extendLength, extrudeHeight]);
        }
        translate([0, 0, 0]){
            bevelBoth(bevelRadius, supportThickness, extrudeHeight);
        }
    }
}

difference(){
    // keepers
    union(){
        // standoff grips
        translate([0,0,-standoffGripHeight/2]){
            cylinder(standoffGripHeight, standoffGripOuterRad, standoffGripOuterRad);
            translate([standoffSeparation,0,0]){
                cylinder(standoffGripHeight, standoffGripOuterRad, standoffGripOuterRad);
            }
        }
        // standoff grip blocks
        translate([0,0,-standoffGripHeight/2]){
            translate([0,-standoffGripOuterRad + standoffGripInset,0]){
                cube([standoffGripWidth, standoffGripOuterDia + abs(cameraInset), standoffGripHeight]);
            }
            translate([standoffSeparation - standoffGripWidth, -standoffGripOuterRad + standoffGripInset,0]){
                cube([standoffGripWidth, standoffGripOuterDia + abs(cameraInset), standoffGripHeight]);
            }
        }
        // lens ring holder
        translate([standoffGripWidth-lensHeight, cameraInset, 0]){
            rotate([-cameraAngle,0,0]){
                lensHolder();
            }
        }
    }
    // cutters    
    union(){
        // standoffs
        translate([0,0,-standoffHeight/2]){
            cylinder(standoffHeight, standoffOuterRad, standoffOuterRad);
            translate([standoffSeparation,0,0]){
                cylinder(standoffHeight, standoffOuterRad, standoffOuterRad);
            }
        }
        // screw hole
        translate([-standoffSeparation/2, cameraInset, 0]){
            rotate([0,90,0]){
                cylinder(standoffSeparation*2, screwRad, screwRad);
            }
        }
        // screwdriver hole RH
        translate([standoffGripWidth - 1.2, cameraInset, 0]){
            rotate([0,-90,0]){
                cylinder(screwDriverLength, screwDriverRad, screwDriverRad);
            }
        }
        // screwdriver hole LH
        translate([standoffSeparation - (standoffGripWidth - 1.2), cameraInset, 0]){
            rotate([0,90,0]){
                cylinder(screwDriverLength, screwDriverRad, screwDriverRad);
            }
        }
    }



}
