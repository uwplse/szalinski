/* [Configuration] */
numberOfBrushes=4; // [1:20]
// the thickness of the wall mounting plate
baseThickness=3; // [3:20]
// the height of the plate, also width per holder
baseHeight=30; // [10:100]
// the length of an arm
armLength=30; // [10:100]
// the radius of the arm base
armBottomRadius=5;
// the raduis of the arm end (within the ball)
armTopRadius=2.5;

/* [Hidden] */
// render quality
$fn=80; 
// fixed values
armAngle=15;
frontHolderPinOffset = -2;
frontHolderPinLength = 10;
frontHolderPinDiameter = 5;
backHolderPinOffset = 1;
backHolderPinLength = 10;
backHolderPinDiameter = 3;

// calculated values
totalBaseWidth = baseHeight * numberOfBrushes;

go();

module go() {
    union(){
        wallBase();
        brushHolders();
    }
}


module brushHolders() {
    for(i=[0:numberOfBrushes - 1]){
        brushHolder(i);
    }
}

module brushHolder(holderIndex) {
    translate([baseHeight / 2 + holderIndex * baseHeight,0,0]) {
        cylinder(h = armLength, r1 = armBottomRadius, r2 = armTopRadius);
        translate([0,0,armLength]) {
            sphere(r = 5);
            // bottom nose
            rotate([90,0,0]) {
                cylinder(h = 8, r1 = 5, r2 = 0);
            }
            rotate([-90,0,0]) {
                // front pin
                translate([0,frontHolderPinOffset,0]) {
                    cylinder(h = frontHolderPinLength, d = frontHolderPinDiameter);
                }
                // back pin
                translate([0,backHolderPinOffset,0]) {
                    cylinder(h = backHolderPinLength, d = backHolderPinDiameter);
                }
                translate([-backHolderPinDiameter / 2,-backHolderPinOffset * 2,0]) {
                    cube([backHolderPinDiameter, backHolderPinDiameter, backHolderPinLength]);
                }
            }
        }
    }
}

module wallBase() {
    translate([0,-baseHeight/2,0]) {
        cube([totalBaseWidth, baseHeight, baseThickness]);
    }
}
