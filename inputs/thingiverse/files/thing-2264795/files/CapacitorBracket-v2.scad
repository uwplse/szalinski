
// make this the same as your capacitors diameter
innerDiameter = 67;

// configure the belt
beltHeight = 20;
beltThickness = 2;

// configure the latch
totalLatchThickness = 3 * beltThickness;

// configure feet
numOfFeet = 3;
feetAngleOffset = 0;

// diameter for screw holes in feet
screwHoleDiameter = 4;

// number of segments for cylinders
globalFn = 64;

difference() {
    union() {
        // outer body
        beltOuter();

        // latch to clamp capacitor
        beltLatch(totalLatchThickness, beltHeight);

        // add feet
        feet();
    }

    // remove inside space for capacitor
    beltInner();

    // subtract a larger version of the latch
    // to split the latch block and belt into two pieces
    translate([0, -3, -3]) beltLatch(beltThickness, beltHeight + 6);
}

module beltOuter() {
    // outer diameter
    cylinder(d=innerDiameter + 2*beltThickness, h=beltHeight, $fn=globalFn);
}

module beltInner() {
    // subtract inside diameter
    cylinder(d=innerDiameter, h=beltHeight, $fn=globalFn);
}

module beltLatch(thickness, size) {
    // latch to clamp capacitor
    translate([0, innerDiameter/2 + size/2, size/2]) {
        rotate([0, 90, 0]) {
            latch(thickness, size);
        }
    }
}

module feet() {
    for (i = [1:numOfFeet]) {
        angle = i * 360/numOfFeet + 60 + feetAngleOffset;
        foot(angle);
    }
}

module foot(angle) {
    rotate([0, 0, angle]) {
        translate([0, innerDiameter/2 + beltHeight/2 - 0.1, beltThickness/2]) {
            latch(beltThickness, beltHeight);
        }
    }
}

module latch(thickness, size) {
    translate([-size/2, -size/2, -thickness/2]) {
        difference() {
            // latch body
            union() {
                cube([size, size/2, thickness]);
                translate([size/2, size/2, 0]) {
                    cylinder(d=size, h=thickness);
                }
            }

            // screwhole in latch
            translate([size/2, size/2, -thickness/2]) {
                cylinder(d=screwHoleDiameter, h=thickness*2, $fn=globalFn);
            }
        }
    }
}
