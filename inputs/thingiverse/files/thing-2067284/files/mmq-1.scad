// mmq 1

size    = 100;
motor   = 8.5;

armSize     = 4;
motorPad    = 4;
motorHeight = 5;
motorGap    = 0.8;

bedWidth    = 21;
bedLength   = 40;
bedDepth    = 4;
bedPad      = 2;

cameraBedLength = 10;
cameraBedAngle  = 15;

$fs = 0.01;

module addition() {
    translate([0, 0, armSize / 4]) {
        // arm 1
        cube([size, armSize, armSize / 2], center = true);

        // arm 2
        rotate([0, 0, 90]) {
            cube([size, armSize, armSize / 2], center = true);
        }
    }
    
     translate([0, 0, armSize / 2]) {
        // arm 1
        translate([-size / 2, 0, 0])
            rotate([0, 90, 0])
                cylinder(d = armSize, h = size);

        // arm 2
        translate([0, size / 2, 0])
            rotate([90, 0, 0])
                cylinder(d = armSize, h = size);
    }

    module motorMount(translation) {
        translate(translation) {
            cylinder(d = motor + motorPad, h = motorHeight);
            
            translate([0,0,motorHeight]) {
                sphere(d = motor + motorPad);
            }
        }
    }

    // motor mount 1
    motorMount([size / 2, 0, 0]);

    // motor mount 2
    motorMount([0, size / 2, 0]);

    // motor mount 3
    motorMount([-size / 2, 0, 0]);

    // motor mount 4
    motorMount([0, -size / 2, 0]);
    
    // bed
    rotate([0, 0, 45]) {
        translate([0, 0, bedDepth / 2]) {
            cube([bedWidth + (bedPad * 2), bedLength + (bedPad * 2), bedDepth], center = true);
        }
    }
}

module subtraction() {
    module motorMount(translation, rotation) {
        translate(translation) {
            rotate(rotation) {
                cylinder(d = motor, h = motorHeight * 3);
                
                translate([0, -(motorGap / 2), 0]) {
                    cube([motorPad + motor, motorGap, motorHeight * 3]);
                }
            }
        }
    }
    
    // motor mount 1
    motorMount([size / 2, 0, -(motorHeight / 2)], [0, 0, 0]);

    // motor mount 2
    motorMount([0, size / 2, -(motorHeight / 2)], [0, 0, 90]);

    // motor mount 3
    motorMount([-size / 2, 0, -(motorHeight / 2)], [0, 0, 180]);

    // motor mount 4
    motorMount([0, -size / 2, -(motorHeight / 2)], [0, 0, 270]);
    
    module wireHole(translation, rotation) {
        translate(translation) {
            rotate(rotation) {
                cylinder(d = wireHole, h = motorHeight + 2);
            }
        }
    }    
    
    rotate([0, 0, 45]) {
        // bed
        translate([0, 0, (bedDepth / 2) + bedPad]) {
            cube([bedWidth, bedLength * 2, bedDepth], center = true);
            
            // batt / usb access
            translate([0, bedPad + 1, 0]) {
                cube([bedWidth, bedLength, bedDepth], center = true);
            }
        }
    }
}

module main() {
    difference() {
        addition();
        subtraction();
    }

    // camera bed
    cameraBedOpposite = sin(cameraBedAngle) * cameraBedLength;
    cameraBedAdjacent = cos(cameraBedAngle) * cameraBedLength;

    halfBedLength = (bedLength * 0.5) + bedPad - cameraBedAdjacent;

    cameraBedTranslate = sqrt((halfBedLength * halfBedLength ) / 2);

    translate([cameraBedTranslate, -cameraBedTranslate, bedPad]) {
        rotate([90, 0, -45]) {
            linear_extrude(height = bedWidth, center = true) {
                polygon([
                    [0, 0],
                    [cameraBedAdjacent, cameraBedOpposite],
                    [cameraBedAdjacent, 0]
                ]);
            }
        }
    }
}

rotate([0, 0, 45]) {
    main();
}