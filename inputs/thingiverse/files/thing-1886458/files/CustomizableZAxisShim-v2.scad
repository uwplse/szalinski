// Customizable Z-axis shim for FlashForge Creator Pro 2016 by DrLex
// Based on Thing 1475239 by ben8p and Thing 557994 by Atomist
// Released under Creative Commons - Attribution - Share Alike license
// v2, 2017/07/30

// The distance you want the Z homing to be lowered.
ShimHeight = 3; // [1:0.1:10]
// How thick the clamping part should be.
ClampHeight = 4; // [2:0.1:10]
// Print the thickness on the model?
Label = "yes"; // [yes, no]
// Useful for very thin thims where Shimheight is smaller than ClampHeight.
Reinforce = "no"; // [yes, no]

/* [Hidden] */
RodDistance = 100; // [80:0.1:120]
RodDiameter = 19; // [15:0.1:25]

RodRadius = RodDiameter/2;
RodCenter = RodDistance/2 + 0.1;
MaxX = RodCenter - 2.85;
ClampScale = [1, 1.062, 1];

difference() {
    union() {
        difference() {
            union() {
                translate([-MaxX, 3, 0]) cube([2*MaxX, 13.88, ShimHeight]);
                translate([0, -2.0, ClampHeight/2]) cube([RodDistance, 10, ClampHeight], center=true);
                translate([RodCenter, -7.15, ClampHeight/2]) scale(ClampScale) cylinder(r=RodRadius + 2, h=ClampHeight, center=true, $fn=32);
                translate([-RodCenter, -7.15, ClampHeight/2]) scale(ClampScale) cylinder(r=RodRadius + 2, h=ClampHeight, center=true, $fn=32);
            }
            
            // Rod holes
            translate([RodCenter, -7.15, 9]) scale(ClampScale) cylinder(r=RodRadius, h=20, center=true, $fn=32);
            translate([-RodCenter, -7.15, 9]) scale(ClampScale) cylinder(r=RodRadius, h=20, center=true, $fn=32);
            
            // Side screw holes
            translate([MaxX, 7.155, 9]) cylinder(r=3.1, h=20, center=true);
            translate([-MaxX, 7.155, 9]) cylinder(r=3.1, h=20, center=true);

            
            // Chop off the sides
            translate([MaxX, -2*RodDiameter, -5]) cube([RodDiameter, 4 * RodDiameter, 20]);
            translate([-MaxX - RodDiameter, -2*RodDiameter, -5]) cube([RodDiameter, 4 * RodDiameter, 20]);
            // Chop off the center
            translate([0, -10, 9]) cube([2*(RodCenter - RodRadius - 2), 20, 20], center=true);
            
            if(ClampHeight > ShimHeight) {
                // Remove pieces of the clamps sticking out
                translate([-MaxX - 1, 3, ShimHeight]) cube([2*MaxX + 2, 13.88, 20]);
            }
        }

        if(Reinforce == "yes") {
            translate([0, 1.85, ClampHeight/2]) isoTrapezoidX(22, 30, 3.7, ClampHeight);
        }
    }
    
    // Space for leadscrew bearing
    if(Reinforce == "yes") {
        translate([0, 0, ClampHeight/2]) isoTrapezoidX(18, 28, 5, ClampHeight+0.1);
    }
    else {
        translate([0, 0, 9]) cube([21.35, 7, 20], center=true);
    }
        
    if(Label == "yes") {
        translate([MaxX-9, 4, ShimHeight - 0.2]) linear_extrude(1)  text(str(ShimHeight, " mm"), 4.5, font="Roboto", halign="right", $fn=14);
    }
}

module isoTrapezoidX(sizeXTop, sizeXBtm, sizeY, sizeZ) {
    linear_extrude(height=sizeZ, center=true) polygon([[-sizeXTop/2, sizeY/2], [sizeXTop/2, sizeY/2], [sizeXBtm/2, -sizeY/2], [-sizeXBtm/2, -sizeY/2]]);

}