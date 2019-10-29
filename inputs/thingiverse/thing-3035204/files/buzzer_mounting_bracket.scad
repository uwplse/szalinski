/* [General] */
// Spacing between the standoffs (center to center)
feetSpacing = 27.5;
// Diameter of the feet
feetDiameter = 5.5;
// Thickness of the walls around the feet
feetWall = 1.2;
// Height of the feet
feetHeight = 15;

// Diameter of the Buzzer
buzzerDiameter = 9;

// Height of the holder
holderHeight = 15;
// Width of the holder
holderWidth = 3;

/* [Offsets] */
// Buzzer offset from the bottom
buzzerOffsetZ = 7.5;
// Buzzer offset from the center
buzzerOffsetY = 0;

// Holder Offset from the bottom
holderOffsetZ = 0;
// Holder Offset from the front
holderOffsetX = 4.9;

/* [HIDDEN] */
feetRadius = feetDiameter / 2;
buzzerRadius = buzzerDiameter / 2;
feetRadiusOuter = feetRadius + feetWall;
feetHoleHeight = feetHeight + (feetHeight - holderHeight + holderOffsetZ) + 2;

$fn = 50;

difference() {
    group() {
        cylinder(r = feetRadiusOuter, h = feetHeight);
        translate([feetSpacing, 0, 0])
            cylinder(r = feetRadiusOuter, h = feetHeight);
        
        translate([0, -feetRadiusOuter + holderOffsetX, holderOffsetZ])
            cube([feetSpacing, holderWidth, holderHeight]);
    }
    
    translate([0, 0, -1]) {
        cylinder(r = feetRadius, h = feetHoleHeight);
            translate([feetSpacing, 0, 0])
                cylinder(r = feetRadius, h = feetHoleHeight);
    }
    
    rotate([90, 0, 0])
        translate([feetSpacing / 2 + buzzerOffsetY, buzzerOffsetZ, -(holderOffsetX - feetRadiusOuter + holderWidth + 1)])
            cylinder(r = buzzerRadius, h = holderWidth + 2);
}