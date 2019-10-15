// Designed by Brian McEvoy, 24HourEngineer
// 24hourengineer.com
// 24hourengineer@gmail.com

// Please note that the dimensions shown here are radii, not diameters
holeRadius00 = 6;
holeRadius01 = 8;
holeRadius02 = 10;
holeRadius03 = 10;
holeRadius04 = 8;
holeRadius05 = 6;

guideTrackRadius = 2;
spacingDistance = 2;
blockLength = 150;

// This thickness should be at least as large as the biggest hole radius plus a few millimeters
halfBlockThickness = 15;

// This is basically the resolution of the circles. High number = smooth circles
$fn = 30;

///// Play around with the red numbers above this line and 
///// press F6 to see the results. Zero is an acceptable variable.

//2//4//H//o//u//r////E//n//g//i//n//e//e//r//
//2//4//H//o//u//r////E//n//g//i//n//e//e//r//

blockWidth = holeRadius00*2 + holeRadius01*2 + holeRadius02*2 + holeRadius03*2 + holeRadius04*2 + holeRadius05*2 + guideTrackRadius*4 + spacingDistance*10;
hole00Distance = (spacingDistance*2 + guideTrackRadius*2 + holeRadius00);
hole01Distance = (spacingDistance*3 + guideTrackRadius*2 + holeRadius00*2 + holeRadius01);
hole02Distance = (spacingDistance*5 + guideTrackRadius*2 + holeRadius00*2 + holeRadius01*2 + holeRadius02);
hole03Distance = (spacingDistance*6 + guideTrackRadius*2 + holeRadius00*2 + holeRadius01*2 + holeRadius02*2 + holeRadius03);
hole04Distance = (spacingDistance*7 + guideTrackRadius*2 + holeRadius00*2 + holeRadius01*2 + holeRadius02*2 + holeRadius03*2 + holeRadius04);
hole05Distance = (spacingDistance*8 + guideTrackRadius*2 + holeRadius00*2 + holeRadius01*2 + holeRadius02*2 + holeRadius03*2 + holeRadius04*2 + holeRadius05);


// Body
difference(){
    translate([blockWidth/2, -halfBlockThickness/2, 0]){
        cube([blockWidth, halfBlockThickness, blockLength], center = true);
    }
    // First bead rolling track
    translate([hole00Distance, 0, 0]){
        trackTemplate(holeRadius00);
    }
    // Second bead rolling track
    translate([hole01Distance, 0, 0]){
        trackTemplate(holeRadius01);
    }
    // Third bead rolling track
    translate([hole02Distance, 0, 0]){
        trackTemplate(holeRadius02);
    }
    // Fourth bead rolling track
    translate([hole03Distance, 0, 0]){
        trackTemplate(holeRadius02);
    }
    // Fifth bead rolling track
    translate([hole04Distance, 0, 0]){
        trackTemplate(holeRadius04);
    }
    // Sixth bead rolling track
    translate([hole05Distance, 0, 0]){
        trackTemplate(holeRadius05);
    }
    // Far guide track
    translate([blockWidth-guideTrackRadius - spacingDistance, 0, +0.00]){
        trackTemplate(guideTrackRadius);
    }
}
// Close track
translate([guideTrackRadius+spacingDistance, +0.00, +0.00]){
    trackTemplate(guideTrackRadius);
}


// Body
translate([-blockWidth-1, +0.00, +0.00]){
    rotate([+0.00, +0.00, +0.00]){
        difference(){
            translate([blockWidth/2, -halfBlockThickness/2, 0]){
                cube([blockWidth, halfBlockThickness, blockLength], center = true);
            }
            // First bead rolling track
            translate([blockWidth - hole05Distance, 0, 0]){
                trackTemplate(holeRadius05);
            }
            // Second bead rolling track
            translate([blockWidth - hole04Distance, 0, 0]){
                trackTemplate(holeRadius04);
            }
            // Third bead rolling track
            translate([blockWidth - hole03Distance, 0, 0]){
                trackTemplate(holeRadius03);
            }
            // Fourth bead rolling track
            translate([blockWidth - hole02Distance, 0, 0]){
                trackTemplate(holeRadius02);
            }
            // Fifth bead rolling track
            translate([blockWidth - hole01Distance, 0, 0]){
                trackTemplate(holeRadius01);
            }
            // Sixth bead rolling track
            translate([blockWidth - hole00Distance, 0, 0]){
                trackTemplate(holeRadius00);
            }
            // Far guide track
            translate([blockWidth-guideTrackRadius - spacingDistance, 0, +0.00]){
                trackTemplate(guideTrackRadius);
            }
        }
        // Close track
        translate([guideTrackRadius+spacingDistance, +0.00, +0.00]){
            trackTemplate(guideTrackRadius);
        }
    }
}




// This provides a simple method for making centered cylinder all the same length
module trackTemplate(radius){
    cylinder(blockLength, radius, radius, center = true);
}